ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(Config_car_job.CheckTime)
		if ESX.PlayerData and ESX.PlayerData.job then
			if not (ESX.PlayerData.job.name == "police" or ESX.PlayerData.job.name == "ambulance" or ESX.PlayerData.job.name == "agent" or ESX.PlayerData.job.name == "admin" or ESX.PlayerData.job.name == "mechanic") then -- add here more job's if needed	
				if IsPedInAnyVehicle(PlayerPedId()) then
					Ped = PlayerPedId()
					vehicle = GetVehiclePedIsIn(Ped, false)

					if Ped and vehicle then
						if GetPedInVehicleSeat(vehicle, -1) == Ped then
							if(getVehicle(Ped, vehicle)) then
								Citizen.Wait(Config_car_job.CheckTime)
							end
						end
					end
				end
			end
		end
	end
end)

function getVehicleBlacklist(model)
	for _, blacklistedVehicle in pairs(Config_car_job.carsblacklisted) do
		if model == GetHashKey(blacklistedVehicle) then
			return true
		end
	end

	return false
end

function getVehicle(Ped, vehicle)
	if vehicle then
		vehicleModel = GetEntityModel(vehicle)
		vehicleName = GetDisplayNameFromVehicleModel(vehicleModel)

		if getVehicleBlacklist(vehicleModel) then
			TaskLeaveVehicle(Ped, vehicle, 1)
			
			if Config_car_job.pNotify then
				TriggerEvent("pNotify:SendNotification", {
					text = Config_car_job.NotifyMessage,
					type = "error",
					timeout = 5000,
					layout = "bottomCenter"
				})
			elseif Config_car_job.EsxNotify then
				ESX.ShowNotification(Config_car_job.NotifyMessage)
			end

			return true
		end
	end
	return false
end
