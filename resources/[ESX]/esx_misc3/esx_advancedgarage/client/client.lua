local CurrentActionData, PlayerData, userProperties, this_Garage, vehInstance, BlipList, PrivateBlips, JobBlips = {}, {}, {}, {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker, WasInPound, WasinJPound = false, false, false
local LastZone, CurrentAction, CurrentActionMsg
ESX = nil
local cooldown = 0
local PrivateGarage = false
-- Create Blips
function CreateBlips(); while not ConfigReady do; Citizen.Wait(1000); end
	if Config.Aircrafts.Garages and Config.Aircrafts.Blips then
		for k,v in pairs(Config.AircraftGarages) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, Config.Blips.Garages4.Sprite)
			SetBlipColour (blip, Config.Blips.Garages4.Color)
			SetBlipDisplay(blip, Config.Blips.Garages4.Display)
			SetBlipScale  (blip, Config.Blips.Garages4.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_garage2'))
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end

		for k,v in pairs(Config.AircraftPounds) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, Config.Blips.Pounds4.Sprite)
			SetBlipColour (blip, Config.Blips.Pounds4.Color)
			SetBlipDisplay(blip, Config.Blips.Pounds4.Display)
			SetBlipScale  (blip, Config.Blips.Pounds4.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_pound2'))
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end
	end


	if Config.Helicopters.Garages and Config.Helicopters.Blips then
		for i = 1, #Config.HelicopterGarages.Blips, 1 do
			local blip = AddBlipForCoord(Config.HelicopterGarages.Blips[i])

			SetBlipSprite (blip, Config.Blips.Garages6.Sprite)
			SetBlipColour (blip, Config.Blips.Garages6.Color)
			SetBlipDisplay(blip, Config.Blips.Garages6.Display)
			SetBlipScale  (blip, Config.Blips.Garages6.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_garage4'))
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end

		for k,v in pairs(Config.HelicopterPounds) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, Config.Blips.Pounds6.Sprite)
			SetBlipColour (blip, Config.Blips.Pounds6.Color)
			SetBlipDisplay(blip, Config.Blips.Pounds6.Display)
			SetBlipScale  (blip, Config.Blips.Pounds6.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_pound4'))
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end
	end

	if Config.Boats.Garages and Config.Boats.Blips then
		for k,v in pairs(Config.BoatGarages) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, Config.Blips.Garages5.Sprite)
			SetBlipColour (blip, Config.Blips.Garages5.Color)
			SetBlipDisplay(blip, Config.Blips.Garages5.Display)
			SetBlipScale  (blip, Config.Blips.Garages5.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_garage3'))
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end

		for k,v in pairs(Config.BoatPounds) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, Config.Blips.Pounds5.Sprite)
			SetBlipColour (blip, Config.Blips.Pounds5.Color)
			SetBlipDisplay(blip, Config.Blips.Pounds5.Display)
			SetBlipScale  (blip, Config.Blips.Pounds5.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_pound3'))
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end
	end


	if Config.Trucks.Garages and Config.Trucks.Blips then
		for k,v in pairs(Config.TruckGarages) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, Config.Blips.Garages7.Sprite)
			SetBlipColour (blip, Config.Blips.Garages7.Color)
			SetBlipDisplay(blip, Config.Blips.Garages7.Display)
			SetBlipScale  (blip, Config.Blips.Garages7.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_garage5'))
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end

		for k,v in pairs(Config.TruckPounds) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, Config.Blips.Pounds7.Sprite)
			SetBlipColour (blip, Config.Blips.Pounds7.Color)
			SetBlipDisplay(blip, Config.Blips.Pounds7.Display)
			SetBlipScale  (blip, Config.Blips.Pounds7.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_pound5'))
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end
	end

	if Config.Cars.Garages and Config.Cars.Blips then
		for i = 1, #Config.CarGarages.Blips, 1 do
			local blip = AddBlipForCoord(Config.CarGarages.Blips[i])

			SetBlipSprite (blip, Config.Blips.Garages.Sprite)
			SetBlipColour (blip, Config.Blips.Garages.Color)
			SetBlipDisplay(blip, Config.Blips.Garages.Display)
			SetBlipScale  (blip, Config.Blips.Garages.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_garage'))
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end

		for k,v in pairs(Config.CarPounds) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, Config.Blips.Pounds.Sprite)
			SetBlipColour (blip, Config.Blips.Pounds.Color)
			SetBlipDisplay(blip, Config.Blips.Pounds.Display)
			SetBlipScale  (blip, Config.Blips.Pounds.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_pound'))
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end
	end
end

-- Handles Private Blips
function DeletePrivateBlips()
	if PrivateBlips[1] ~= nil then
		for i=1, #PrivateBlips, 1 do
			RemoveBlip(PrivateBlips[i])
			PrivateBlips[i] = nil
		end
	end
end

function RefreshPrivateBlips()
	for zoneKey,zoneValues in pairs(Config.PrivateCarGarages) do
		if zoneValues.Private and has_value(userProperties, zoneValues.Private) then
			local blip = AddBlipForCoord(zoneValues.Marker)

			SetBlipSprite (blip, Config.Blips.PGarages.Sprite)
			SetBlipColour (blip, Config.Blips.PGarages.Color)
			SetBlipDisplay(blip, Config.Blips.PGarages.Display)
			SetBlipScale  (blip, Config.Blips.PGarages.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_garage_private'))
			EndTextCommandSetBlipName(blip)
			table.insert(PrivateBlips, blip)
		end
	end
end

-- Handles Job Blips
function DeleteJobBlips()
	if JobBlips[1] ~= nil then
		for i=1, #JobBlips, 1 do
			RemoveBlip(JobBlips[i])
			JobBlips[i] = nil
		end
	end
end

function RefreshJobBlips()
	if Config.Ambulance.Garages and Config.Ambulance.Blips then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
			for k,v in pairs(Config.AmbulanceGarages) do
				local blip = AddBlipForCoord(v.Marker)

				SetBlipSprite (blip, Config.Blips.JGarages.Sprite)
				SetBlipColour (blip, Config.Blips.JGarages.Color)
				SetBlipDisplay(blip, Config.Blips.JGarages.Display)
				SetBlipScale  (blip, Config.Blips.JGarages.Scale)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('blip_ambulance_garage'))
				EndTextCommandSetBlipName(blip)
				table.insert(JobBlips, blip)
			end
		end
	end

	if Config.Ambulance.Pounds and Config.Ambulance.Blips then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
			for k,v in pairs(Config.AmbulancePounds) do
				local blip = AddBlipForCoord(v.Marker)

				SetBlipSprite (blip, Config.Blips.JPounds.Sprite)
				SetBlipColour (blip, Config.Blips.JPounds.Color)
				SetBlipDisplay(blip, Config.Blips.JPounds.Display)
				SetBlipScale  (blip, Config.Blips.JPounds.Scale)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('blip_ambulance_pound'))
				EndTextCommandSetBlipName(blip)
				table.insert(JobBlips, blip)
			end
		end
	end

	if Config.Police.Garages and Config.Police.Blips then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
			for k,v in pairs(Config.PoliceGarages) do
				local blip = AddBlipForCoord(v.Marker)

				SetBlipSprite (blip, Config.Blips.JGarages.Sprite)
				SetBlipColour (blip, Config.Blips.JGarages.Color)
				SetBlipDisplay(blip, Config.Blips.JGarages.Display)
				SetBlipScale  (blip, Config.Blips.JGarages.Scale)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('blip_police_garage'))
				EndTextCommandSetBlipName(blip)
				table.insert(JobBlips, blip)
			end
		end
	end

	if Config.Police.Pounds and Config.Police.Blips then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
			for k,v in pairs(Config.PolicePounds) do
				local blip = AddBlipForCoord(v.Marker)

				SetBlipSprite (blip, Config.Blips.JPounds.Sprite)
				SetBlipColour (blip, Config.Blips.JPounds.Color)
				SetBlipDisplay(blip, Config.Blips.JPounds.Display)
				SetBlipScale  (blip, Config.Blips.JPounds.Scale)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('blip_police_pound'))
				EndTextCommandSetBlipName(blip)
				table.insert(JobBlips, blip)
			end
		end
	end

	------------------
	if Config.agent.Garages and Config.agent.Blips then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'agent' then
			for k,v in pairs(Config.agentGarages) do
				local blip = AddBlipForCoord(v.Marker)

				SetBlipSprite (blip, Config.Blips.JGarages.Sprite)
				SetBlipColour (blip, Config.Blips.JGarages.Color)
				SetBlipDisplay(blip, Config.Blips.JGarages.Display)
				SetBlipScale  (blip, Config.Blips.JGarages.Scale)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('blip_agent_garage'))
				EndTextCommandSetBlipName(blip)
				table.insert(JobBlips, blip)
			end
		end
	end

	if Config.agent.Pounds and Config.agent.Blips then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'agent' then
			for k,v in pairs(Config.agentPounds) do
				local blip = AddBlipForCoord(v.Marker)

				SetBlipSprite (blip, Config.Blips.JPounds.Sprite)
				SetBlipColour (blip, Config.Blips.JPounds.Color)
				SetBlipDisplay(blip, Config.Blips.JPounds.Display)
				SetBlipScale  (blip, Config.Blips.JPounds.Scale)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('blip_agent_pound'))
				EndTextCommandSetBlipName(blip)
				table.insert(JobBlips, blip)
			end
		end
	end

		------------------
	if Config.Admin.Garages and Config.Admin.Blips then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'admin' then
			for k,v in pairs(Config.AdminGarages) do
				local blip = AddBlipForCoord(v.Marker)

				SetBlipSprite (blip, Config.Blips.JGarages.Sprite)
				SetBlipColour (blip, Config.Blips.JGarages.Color)
				SetBlipDisplay(blip, Config.Blips.JGarages.Display)
				SetBlipScale  (blip, Config.Blips.JGarages.Scale)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('blip_admin_garage'))
				EndTextCommandSetBlipName(blip)
				table.insert(JobBlips, blip)
			end
		end
	end

	if Config.Admin.Pounds and Config.Admin.Blips then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'admin' then
			for k,v in pairs(Config.AdminPounds) do
				local blip = AddBlipForCoord(v.Marker)

				SetBlipSprite (blip, Config.Blips.JPounds.Sprite)
				SetBlipColour (blip, Config.Blips.JPounds.Color)
				SetBlipDisplay(blip, Config.Blips.JPounds.Display)
				SetBlipScale  (blip, Config.Blips.JPounds.Scale)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('blip_admin_pound'))
				EndTextCommandSetBlipName(blip)
				table.insert(JobBlips, blip)
			end
		end
	end

	if Config.Mechanic.Garages and Config.Mechanic.Blips then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
			for k,v in pairs(Config.MechanicGarages) do
				local blip = AddBlipForCoord(v.Marker)

				SetBlipSprite (blip, Config.Blips.JGarages.Sprite)
				SetBlipColour (blip, Config.Blips.JGarages.Color)
				SetBlipDisplay(blip, Config.Blips.JGarages.Display)
				SetBlipScale  (blip, Config.Blips.JGarages.Scale)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('blip_mechanic_garage'))
				EndTextCommandSetBlipName(blip)
				table.insert(JobBlips, blip)
			end
		end
	end

	if Config.Mechanic.Pounds and Config.Mechanic.Blips then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
			for k,v in pairs(Config.MechanicPounds) do
				local blip = AddBlipForCoord(v.Marker)

				SetBlipSprite (blip, Config.Blips.JPounds.Sprite)
				SetBlipColour (blip, Config.Blips.JPounds.Color)
				SetBlipDisplay(blip, Config.Blips.JPounds.Display)
				SetBlipScale  (blip, Config.Blips.JPounds.Scale)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('blip_mechanic_pound'))
				EndTextCommandSetBlipName(blip)
				table.insert(JobBlips, blip)
			end
		end
	end
end

Citizen.CreateThread( function()
	while true do
	  Citizen.Wait(0)
	  if cooldown > 0 then
		Citizen.Wait(1000)
		cooldown = cooldown - 1
	  else
		  Citizen.Wait(500)
	  end
	end
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

	CreateBlips()
	RefreshJobBlips()
end)

RegisterFontFile('A9eelsh')
fontId = RegisterFontId('A9eelsh')

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer); while not ConfigReady do; Citizen.Wait(1000); end
	if Config.Pvt.Garages then
		ESX.TriggerServerCallback('esx_advancedgarage:getOwnedProperties', function(properties)
			userProperties = properties
			DeletePrivateBlips()
			RefreshPrivateBlips()
		end)
	end

	ESX.PlayerData = xPlayer

	RefreshJobBlips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job

	DeleteJobBlips()
	RefreshJobBlips()
end)

RegisterNetEvent('esx_advancedgarage:getPropertiesC')
AddEventHandler('esx_advancedgarage:getPropertiesC', function(xPlayer)
	if Config.Pvt.Garages then
		ESX.TriggerServerCallback('esx_advancedgarage:getOwnedProperties', function(properties)
			userProperties = properties
			DeletePrivateBlips()
			RefreshPrivateBlips()
		end)

		ESX.ShowNotification(_U('get_properties'))
		TriggerServerEvent('esx_advancedgarage:printGetProperties', securityToken)
	end
end)

function has_value (tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end
	return false
end

-- Start of Ambulance Code
function ListOwnedAmbulanceMenu()
	local elements = {}

	if Config.Main.ShowVehLoc and Config.Main.Spacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - <span style="color:red;">%s</span> |'):format(_U('plate'), _U('vehicle'), _U('location'))
		table.insert(elements, {label = spacer, value = nil})
	elseif Config.Main.ShowVehLoc == false and Config.Main.Spacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
		table.insert(elements, {label = ('<span style="color:red;">%s</span>'):format(_U('spacer1')), value = nil})
		table.insert(elements, {label = spacer, value = nil})
	end

	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedAmbulanceCars', function(ownedAmbulanceCars)
		if #ownedAmbulanceCars == 0 then
			ESX.ShowNotification(_U('garage_no_ambulance'))
		else
			for _,v in pairs(ownedAmbulanceCars) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = v.name
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)
				local labelvehicle3 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> | '):format(plate, vehicleName)

				if Config.Main.ShowVehLoc then
					if v.stored then
						labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=00EE4F>'.._U('loc_garage')..'<font color=white> |</font>'
					else
						labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=FF0E0E>'.._U('loc_pound')..'<font color=white> |</font>'
					end
				else
					if v.stored then
						labelvehicle = labelvehicle3
					else
						labelvehicle = labelvehicle3
					end
				end

				table.insert(elements, {label = labelvehicle, value = v})
			end
		end

		table.insert(elements, {label = _U('spacer2'), value = nil})

		ESX.TriggerServerCallback('esx_advancedgarage:getOwnedAmbulanceAircrafts', function(ownedAmbulanceAircrafts)
			if #ownedAmbulanceAircrafts == 0 then
				ESX.ShowNotification(_U('garage_no_ambulance_aircraft'))
			else
				for _,v in pairs(ownedAmbulanceAircrafts) do
					local hashVehicule = v.vehicle.model
					local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
					local vehicleName = v.name
					local plate = v.plate
					local labelvehicle
					local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)
					local labelvehicle3 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> | '):format(plate, vehicleName)

					if Config.Main.ShowVehLoc then
						if v.stored then
							labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=00EE4F>'.._U('loc_garage')..'<font color=white> |</font>'
						else
							labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=FF0E0E>'.._U('loc_pound')..'<font color=white> |</font>'
						end
					else
						if v.stored then
							labelvehicle = labelvehicle3
						else
							labelvehicle = labelvehicle3
						end
					end

					table.insert(elements, {label = labelvehicle, value = v})
				end
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_ambulance', {
				title = _U('garage_ambulance'),
				align = Config.Main.MenuAlign,
				elements = elements
			}, function(data, menu)
				if data.current.value == nil then
				elseif data.current.value.vtype == 'aircraft' or data.current.value.vtype == 'helicopter' then
					if data.current.value.stored then
						menu.close()
						if CanSpawnVehicleInPos(this_Garage.Spawner) then
							SpawnVehicle2(data.current.value.vehicle, data.current.value.plate)
						end
					else
						ESX.ShowNotification(_U('ambulance_is_impounded'))
					end
				else
					if data.current.value.stored then
						menu.close()
						if CanSpawnVehicleInPos(this_Garage.Spawner) then
							SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
						end
					else
						ESX.ShowNotification(_U('ambulance_is_impounded'))
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end)
end

function StoreOwnedAmbulanceMenu()
	local playerPed  = PlayerPedId()

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(PlayerPedId(), true)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
			if valid then
				if engineHealth < 990 then
					if Config.Main.DamageMult then
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.Ambulance.PoundP*Config.Main.MultAmount)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					else
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.Ambulance.PoundP)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					end
				else
					StoreVehicle(vehicle, vehicleProps)
				end	
			else
				ESX.ShowNotification(_U('cannot_store_vehicle'))
			end
		end, vehicleProps)
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end

function ReturnOwnedAmbulanceMenu()
	if WasinJPound then
		ESX.ShowNotification(_U('must_wait', Config.Main.JPoundWait))
	else
		ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedAmbulanceCars', function(ownedAmbulanceCars)
			local elements = {}

			if Config.Main.ShowVehLoc == false and Config.Main.Spacers then
				local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
				table.insert(elements, {label = spacer, value = nil})
			end

			for _,v in pairs(ownedAmbulanceCars) do
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = v.name
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)

				labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span> |'):format(_U('return'))

				table.insert(elements, {label = labelvehicle, value = v})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_ambulance', {
				title = _U('pound_ambulance', ESX.Math.GroupDigits(Config.Ambulance.PoundP)),
				align = Config.Main.MenuAlign,
				elements = elements
			}, function(data, menu)
				local doesVehicleExist = false

				for k,v in pairs (vehInstance) do
					if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.value.plate) then
						if DoesEntityExist(v.vehicleentity) then
							doesVehicleExist = true
						else
							table.remove(vehInstance, k)
							doesVehicleExist = false
						end
					end
				end

				if not doesVehicleExist and not DoesAPlayerDrivesVehicle(data.current.value.plate) then
					ESX.TriggerServerCallback('esx_advancedgarage:checkMoneyAmbulance', function(hasEnoughMoney)
						if hasEnoughMoney then
							if data.current.value == nil then
							else
								if CanSpawnVehicleInPos(this_Garage.Spawner) then
									SpawnVehicle(data.current.value, data.current.value.plate)
									TriggerServerEvent('esx_advancedgarage:payAmbulance', securityToken)
									if Config.Main.JPoundTimer then
										WasinJPound = true
									end
								end
							end
						else
							ESX.ShowNotification(_U('not_enough_money'))
						end
					end)
				else
					ESX.ShowNotification(_U('cant_take_out'))
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end
end
-- End of Ambulance Code

-- Start of Police Code
function ListOwnedPoliceMenu()
	local elements = {}

	if Config.Main.ShowVehLoc and Config.Main.Spacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - <span style="color:red;">%s</span> |'):format(_U('plate'), _U('vehicle'), _U('location'))
		table.insert(elements, {label = spacer, value = nil})
	elseif Config.Main.ShowVehLoc == false and Config.Main.Spacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
		table.insert(elements, {label = ('<span style="color:red;">%s</span>'):format(_U('spacer1')), value = nil})
		table.insert(elements, {label = spacer, value = nil})
	end

	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedPoliceCars', function(ownedPoliceCars)
		if #ownedPoliceCars == 0 then
			ESX.ShowNotification(_U('garage_no_police'))
		else
			for _,v in pairs(ownedPoliceCars) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = v.name
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)
				local labelvehicle3 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> | '):format(plate, vehicleName)

				if Config.Main.ShowVehLoc then
					if v.stored then
						labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=00EE4F>'.._U('loc_garage')..'<font color=white> |</font>'
					else
						labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=FF0E0E>'.._U('loc_pound')..'<font color=white> |</font>'
					end
				else
					if v.stored then
						labelvehicle = labelvehicle3
					else
						labelvehicle = labelvehicle3
					end
				end

				table.insert(elements, {label = labelvehicle, value = v})
			end
		end

		table.insert(elements, {label = _U('spacer2'), value = nil})

		ESX.TriggerServerCallback('esx_advancedgarage:getOwnedPoliceAircrafts', function(ownedPoliceAircrafts)
			if #ownedPoliceAircrafts == 0 then
				ESX.ShowNotification(_U('garage_no_police_aircraft'))
			else
				for _,v in pairs(ownedPoliceAircrafts) do
					local hashVehicule = v.vehicle.model
					local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
					local vehicleName = v.name
					local plate = v.plate
					local labelvehicle
					local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)
					local labelvehicle3 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> | '):format(plate, vehicleName)

					if Config.Main.ShowVehLoc then
						if v.stored then
							labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=00EE4F>'.._U('loc_garage')..'<font color=white> |</font>'
						else
							labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=FF0E0E>'.._U('loc_pound')..'<font color=white> |</font>'
						end
					else
						if v.stored then
							labelvehicle = labelvehicle3
						else
							labelvehicle = labelvehicle3
						end
					end

					table.insert(elements, {label = labelvehicle, value = v})
				end
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_police', {
				title = _U('garage_police'),
				align = Config.Main.MenuAlign,
				elements = elements
			}, function(data, menu)
				if data.current.value == nil then
				elseif data.current.value.vtype == 'aircraft' or data.current.value.vtype == 'helicopter' then
					if data.current.value.stored then
						menu.close()
						if CanSpawnVehicleInPos(this_Garage.Spawner) then
							SpawnVehicle2(data.current.value.vehicle, data.current.value.plate)
						end
					else
						ESX.ShowNotification(_U('police_is_impounded'))
					end
				else
					if data.current.value.stored then
						menu.close()
						if CanSpawnVehicleInPos(this_Garage.Spawner) then
							SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
						end
					else
						ESX.ShowNotification(_U('police_is_impounded'))
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end)
end

function StoreOwnedPoliceMenu()
	local playerPed  = PlayerPedId()

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(PlayerPedId(), true)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
			if valid then
				if engineHealth < 990 then
					if Config.Main.DamageMult then
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.Police.PoundP*Config.Main.MultAmount)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					else
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.Police.PoundP)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					end
				else
					StoreVehicle(vehicle, vehicleProps)
				end	
			else
				ESX.ShowNotification(_U('cannot_store_vehicle'))
			end
		end, vehicleProps)
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end

function ReturnOwnedPoliceMenu()
	if WasinJPound then
		ESX.ShowNotification(_U('must_wait', Config.Main.JPoundWait))
	else
		ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedPoliceCars', function(ownedPoliceCars)
			local elements = {}

			if Config.Main.ShowVehLoc == false and Config.Main.Spacers then
				local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
				table.insert(elements, {label = spacer, value = nil})
			end

			for _,v in pairs(ownedPoliceCars) do
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = v.name
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)

				labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span> |'):format(_U('return'))

				table.insert(elements, {label = labelvehicle, value = v})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_police', {
				title = _U('pound_police', ESX.Math.GroupDigits(Config.Police.PoundP)),
				align = Config.Main.MenuAlign,
				elements = elements
			}, function(data, menu)
				local doesVehicleExist = false

				for k,v in pairs (vehInstance) do
					if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.value.plate) then
						if DoesEntityExist(v.vehicleentity) then
							doesVehicleExist = true
						else
							table.remove(vehInstance, k)
							doesVehicleExist = false
						end
					end
				end

				if not doesVehicleExist and not DoesAPlayerDrivesVehicle(data.current.value.plate) then
					ESX.TriggerServerCallback('esx_advancedgarage:checkMoneyPolice', function(hasEnoughMoney)
						if hasEnoughMoney then
							if data.current.value == nil then
							else
								if CanSpawnVehicleInPos(this_Garage.Spawner) then
									SpawnVehicle(data.current.value, data.current.value.plate)
									TriggerServerEvent('esx_advancedgarage:payPolice', securityToken)
									if Config.Main.JPoundTimer then
										WasinJPound = true
									end
								end
							end
						else
							ESX.ShowNotification(_U('not_enough_money'))
						end
					end)
				else
					ESX.ShowNotification(_U('cant_take_out'))
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end
end
-- End of Police Code

--------------------------------------------------------------
-- Start of agent Code
function ListOwnedagentMenu()
	local elements = {}

	if Config.Main.ShowVehLoc and Config.Main.Spacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - <span style="color:red;">%s</span> |'):format(_U('plate'), _U('vehicle'), _U('location'))
		table.insert(elements, {label = spacer, value = nil})
	elseif Config.Main.ShowVehLoc == false and Config.Main.Spacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
		table.insert(elements, {label = ('<span style="color:red;">%s</span>'):format(_U('spacer1')), value = nil})
		table.insert(elements, {label = spacer, value = nil})
	end

	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedagentCars', function(ownedagentCars)
		if #ownedagentCars == 0 then
			ESX.ShowNotification(_U('garage_no_agent'))
		else
			for _,v in pairs(ownedagentCars) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = v.name
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)
				local labelvehicle3 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> | '):format(plate, vehicleName)

				if Config.Main.ShowVehLoc then
					if v.stored then
						labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=00EE4F>'.._U('loc_garage')..'<font color=white> |</font>'
					else
						labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=FF0E0E>'.._U('loc_pound')..'<font color=white> |</font>'
					end
				else
					if v.stored then
						labelvehicle = labelvehicle3
					else
						labelvehicle = labelvehicle3
					end
				end

				table.insert(elements, {label = labelvehicle, value = v})
			end
		end

		table.insert(elements, {label = _U('spacer2'), value = nil})

		ESX.TriggerServerCallback('esx_advancedgarage:getOwnedagentAircrafts', function(ownedagentAircrafts)
			if #ownedagentAircrafts == 0 then
				ESX.ShowNotification(_U('garage_no_agent_aircraft'))
			else
				for _,v in pairs(ownedagentAircrafts) do
					local hashVehicule = v.vehicle.model
					local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
					local vehicleName = v.name
					local plate = v.plate
					local labelvehicle
					local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)
					local labelvehicle3 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> | '):format(plate, vehicleName)

					if Config.Main.ShowVehLoc then
						if v.stored then
							labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=00EE4F>'.._U('loc_garage')..'<font color=white> |</font>'
						else
							labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=FF0E0E>'.._U('loc_pound')..'<font color=white> |</font>'
						end
					else
						if v.stored then
							labelvehicle = labelvehicle3
						else
							labelvehicle = labelvehicle3
						end
					end

					table.insert(elements, {label = labelvehicle, value = v})
				end
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_agent', {
				title = _U('garage_agent'),
				align = Config.Main.MenuAlign,
				elements = elements
			}, function(data, menu)
				if data.current.value == nil then
				elseif data.current.value.vtype == 'aircraft' or data.current.value.vtype == 'helicopter' then
					if data.current.value.stored then
						menu.close()
						if CanSpawnVehicleInPos(this_Garage.Spawner) then
							SpawnVehicle2(data.current.value.vehicle, data.current.value.plate)
						end
					else
						ESX.ShowNotification(_U('agent_is_impounded'))
					end
				else
					if data.current.value.stored then
						menu.close()
						if CanSpawnVehicleInPos(this_Garage.Spawner) then
							SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
						end
					else
						ESX.ShowNotification(_U('agent_is_impounded'))
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end)
end

function StoreOwnedagentMenu()
	local playerPed  = PlayerPedId()

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(PlayerPedId(), true)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
			if valid then
				if engineHealth < 990 then
					if Config.Main.DamageMult then
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.agent.PoundP*Config.Main.MultAmount)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					else
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.agent.PoundP)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					end
				else
					StoreVehicle(vehicle, vehicleProps)
				end	
			else
				ESX.ShowNotification(_U('cannot_store_vehicle'))
			end
		end, vehicleProps)
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end

function ReturnOwnedagentMenu()
	if WasinJPound then
		ESX.ShowNotification(_U('must_wait', Config.Main.JPoundWait))
	else
		ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedagentCars', function(ownedagentCars)
			local elements = {}

			if Config.Main.ShowVehLoc == false and Config.Main.Spacers then
				local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
				table.insert(elements, {label = spacer, value = nil})
			end

			for _,v in pairs(ownedagentCars) do
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = v.name
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)

				labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span> |'):format(_U('return'))

				table.insert(elements, {label = labelvehicle, value = v})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_agent', {
				title = _U('pound_agent', ESX.Math.GroupDigits(Config.agent.PoundP)),
				align = Config.Main.MenuAlign,
				elements = elements
			}, function(data, menu)
				local doesVehicleExist = false

				for k,v in pairs (vehInstance) do
					if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.value.plate) then
						if DoesEntityExist(v.vehicleentity) then
							doesVehicleExist = true
						else
							table.remove(vehInstance, k)
							doesVehicleExist = false
						end
					end
				end

				if not doesVehicleExist and not DoesAPlayerDrivesVehicle(data.current.value.plate) then
					ESX.TriggerServerCallback('esx_advancedgarage:checkMoneyagent', function(hasEnoughMoney)
						if hasEnoughMoney then
							if data.current.value == nil then
							else
								if CanSpawnVehicleInPos(this_Garage.Spawner) then
									SpawnVehicle(data.current.value, data.current.value.plate)
									TriggerServerEvent('esx_advancedgarage:payagent', securityToken)
									if Config.Main.JPoundTimer then
										WasinJPound = true
									end
								end
							end
						else
							ESX.ShowNotification(_U('not_enough_money'))
						end
					end)
				else
					ESX.ShowNotification(_U('cant_take_out'))
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end
end
-- End of Police Code

----------------------------------------------------

-- Start of Admin Code
function ListOwnedAdminMenu()
	local elements = {}

	if Config.Main.ShowVehLoc and Config.Main.Spacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - <span style="color:red;">%s</span> |'):format(_U('plate'), _U('vehicle'), _U('location'))
		table.insert(elements, {label = spacer, value = nil})
	elseif Config.Main.ShowVehLoc == false and Config.Main.Spacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
		table.insert(elements, {label = ('<span style="color:red;">%s</span>'):format(_U('spacer1')), value = nil})
		table.insert(elements, {label = spacer, value = nil})
	end

	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedAdminCars', function(ownedAdminCars)
		if #ownedAdminCars == 0 then
			ESX.ShowNotification(_U('garage_no_admin'))
		else
			for _,v in pairs(ownedAdminCars) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = v.name
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)
				local labelvehicle3 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> | '):format(plate, vehicleName)

				if Config.Main.ShowVehLoc then
					if v.stored then
						labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=00EE4F>'.._U('loc_garage')..'<font color=white> |</font>'
					else
						labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=FF0E0E>'.._U('loc_pound')..'<font color=white> |</font>'
					end
				else
					if v.stored then
						labelvehicle = labelvehicle3
					else
						labelvehicle = labelvehicle3
					end
				end

				table.insert(elements, {label = labelvehicle, value = v})
			end
		end

		table.insert(elements, {label = _U('spacer2'), value = nil})

		ESX.TriggerServerCallback('esx_advancedgarage:getOwnedAdminAircrafts', function(ownedAdminAircrafts)
			if #ownedAdminAircrafts == 0 then
				ESX.ShowNotification(_U('garage_no_admin_aircraft'))
			else
				for _,v in pairs(ownedAdminAircrafts) do
					local hashVehicule = v.vehicle.model
					local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
					local vehicleName = v.name
					local plate = v.plate
					local labelvehicle
					local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)
					local labelvehicle3 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> | '):format(plate, vehicleName)

					if Config.Main.ShowVehLoc then
						if v.stored then
							labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=00EE4F>'.._U('loc_garage')..'<font color=white> |</font>'
						else
							labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=FF0E0E>'.._U('loc_pound')..'<font color=white> |</font>'
						end
					else
						if v.stored then
							labelvehicle = labelvehicle3
						else
							labelvehicle = labelvehicle3
						end
					end

					table.insert(elements, {label = labelvehicle, value = v})
				end
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_admin', {
				title = _U('garage_admin'),
				align = Config.Main.MenuAlign,
				elements = elements
			}, function(data, menu)
				if data.current.value == nil then
				elseif data.current.value.vtype == 'aircraft' or data.current.value.vtype == 'helicopter' then
					if data.current.value.stored then
						menu.close()
						if CanSpawnVehicleInPos(this_Garage.Spawner) then
							SpawnVehicle2(data.current.value.vehicle, data.current.value.plate)
						end
					else
						ESX.ShowNotification(_U('admin_is_impounded'))
					end
				else
					if data.current.value.stored then
						menu.close()
						if CanSpawnVehicleInPos(this_Garage.Spawner) then
							SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
						end
					else
						ESX.ShowNotification(_U('admin_is_impounded'))
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end)
end

function StoreOwnedAdminMenu()
	local playerPed  = PlayerPedId()

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(PlayerPedId(), true)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
			if valid then
				if engineHealth < 990 then
					if Config.Main.DamageMult then
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.Admin.PoundP*Config.Main.MultAmount)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					else
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.Admin.PoundP)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					end
				else
					StoreVehicle(vehicle, vehicleProps)
				end	
			else
				ESX.ShowNotification(_U('cannot_store_vehicle'))
			end
		end, vehicleProps)
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end

function ReturnOwnedAdminMenu()
	if WasinJPound then
		ESX.ShowNotification(_U('must_wait', Config.Main.JPoundWait))
	else
		ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedAdminCars', function(ownedAdminCars)
			local elements = {}

			if Config.Main.ShowVehLoc == false and Config.Main.Spacers then
				local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
				table.insert(elements, {label = spacer, value = nil})
			end

			for _,v in pairs(ownedAdminCars) do
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = v.name
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)

				labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span> |'):format(_U('return'))

				table.insert(elements, {label = labelvehicle, value = v})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_admin', {
				title = _U('pound_admin', ESX.Math.GroupDigits(Config.Admin.PoundP)),
				align = Config.Main.MenuAlign,
				elements = elements
			}, function(data, menu)
				local doesVehicleExist = false

				for k,v in pairs (vehInstance) do
					if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.value.plate) then
						if DoesEntityExist(v.vehicleentity) then
							doesVehicleExist = true
						else
							table.remove(vehInstance, k)
							doesVehicleExist = false
						end
					end
				end

				if not doesVehicleExist and not DoesAPlayerDrivesVehicle(data.current.value.plate) then
					ESX.TriggerServerCallback('esx_advancedgarage:checkMoneyAdmin', function(hasEnoughMoney)
						if hasEnoughMoney then
							if data.current.value == nil then
							else
								if CanSpawnVehicleInPos(this_Garage.Spawner) then
									SpawnVehicle(data.current.value, data.current.value.plate)
									TriggerServerEvent('esx_advancedgarage:payAdmin', securityToken)
									if Config.Main.JPoundTimer then
										WasinJPound = true
									end
								end
							end
						else
							ESX.ShowNotification(_U('not_enough_money'))
						end
					end)
				else
					ESX.ShowNotification(_U('cant_take_out'))
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end
end

---------------------------------------

-- Start of Mechanic Code
function ListOwnedMechanicMenu()
	local elements = {}

	if Config.Main.ShowVehLoc and Config.Main.Spacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - <span style="color:red;">%s</span> |'):format(_U('plate'), _U('vehicle'), _U('location'))
		table.insert(elements, {label = spacer, value = nil})
	elseif Config.Main.ShowVehLoc == false and Config.Main.Spacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
		table.insert(elements, {label = ('<span style="color:red;">%s</span>'):format(_U('spacer1')), value = nil})
		table.insert(elements, {label = spacer, value = nil})
	end

	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedMechanicCars', function(ownedMechanicCars)
		if #ownedMechanicCars == 0 then
			ESX.ShowNotification(_U('garage_no_mechanic'))
		else
			for _,v in pairs(ownedMechanicCars) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = v.name
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)
				local labelvehicle3 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> | '):format(plate, vehicleName)

				if Config.Main.ShowVehLoc then
					if v.stored then
						labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=00EE4F>'.._U('loc_garage')..'<font color=white> |</font>'
					else
						labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=FF0E0E>'.._U('loc_pound')..'<font color=white> |</font>'
					end
				else
					if v.stored then
						labelvehicle = labelvehicle3
					else
						labelvehicle = labelvehicle3
					end
				end

				table.insert(elements, {label = labelvehicle, value = v})
			end
		end
		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_mechanic', {
			title = _U('garage_mechanic'),
			align = Config.Main.MenuAlign,
			elements = elements
		}, function(data, menu)
			if data.current.value == nil then
			else
				if data.current.value.stored then
					menu.close()
					if CanSpawnVehicleInPos(this_Garage.Spawner) then
						SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
					end
				else
					ESX.ShowNotification(_U('mechanic_is_impounded'))
				end
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function StoreOwnedMechanicMenu()
	local playerPed  = PlayerPedId()

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(PlayerPedId(), true)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
			if valid then
				if engineHealth < 990 then
					if Config.Main.DamageMult then
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.Mechanic.PoundP*Config.Main.MultAmount)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					else
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.Mechanic.PoundP)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					end
				else
					StoreVehicle(vehicle, vehicleProps)
				end	
			else
				ESX.ShowNotification(_U('cannot_store_vehicle'))
			end
		end, vehicleProps)
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end

function ReturnOwnedMechanicMenu()
	if WasinJPound then
		ESX.ShowNotification(_U('must_wait', Config.Main.JPoundWait))
	else
		ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedMechanicCars', function(ownedMechanicCars)
			local elements = {}

			if Config.Main.ShowVehLoc == false and Config.Main.Spacers then
				local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
				table.insert(elements, {label = spacer, value = nil})
			end

			for _,v in pairs(ownedMechanicCars) do
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = v.name
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)

				labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span> |'):format(_U('return'))

				table.insert(elements, {label = labelvehicle, value = v})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_mechanic', {
				title = _U('pound_mechanic', ESX.Math.GroupDigits(Config.Mechanic.PoundP)),
				align = Config.Main.MenuAlign,
				elements = elements
			}, function(data, menu)
				local doesVehicleExist = false

				for k,v in pairs (vehInstance) do
					if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.value.plate) then
						if DoesEntityExist(v.vehicleentity) then
							doesVehicleExist = true
						else
							table.remove(vehInstance, k)
							doesVehicleExist = false
						end
					end
				end

				if not doesVehicleExist and not DoesAPlayerDrivesVehicle(data.current.value.plate) then
					ESX.TriggerServerCallback('esx_advancedgarage:checkMoneyMechanic', function(hasEnoughMoney)
						if hasEnoughMoney then
							if data.current.value == nil then
							else
								if CanSpawnVehicleInPos(this_Garage.Spawner) then
									SpawnVehicle(data.current.value, data.current.value.plate)
									TriggerServerEvent('esx_advancedgarage:payMechanic', securityToken)
									if Config.Main.JPoundTimer then
										WasinJPound = true
									end
								end
							end
						else
							ESX.ShowNotification(_U('not_enough_money'))
						end
					end)
				else
					ESX.ShowNotification(_U('cant_take_out'))
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end
end
-- End of Mechanic Code

-- Start of Aircraft Code
function ListOwnedAircraftsMenu2()
	local elements = {}

	if Config.Main.ShowVehLoc and Config.Main.Spacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - <span style="color:red;">%s</span> |'):format(_U('plate'), _U('vehicle'), _U('location'))
		table.insert(elements, {label = spacer, value = nil})
	elseif Config.Main.ShowVehLoc == false and Config.Main.Spacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
		table.insert(elements, {label = ('<span style="color:red;">%s</span>'):format(_U('spacer1')), value = nil})
		table.insert(elements, {label = spacer, value = nil})
	end

	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedAircrafts', function(ownedAircrafts)
		if #ownedAircrafts == 0 then
			ESX.ShowNotification(_U('garage_no_aircrafts'))
		else
			for _,v in pairs(ownedAircrafts) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = v.name
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)
				local labelvehicle3 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> | '):format(plate, vehicleName)

				if Config.Main.ShowVehLoc then
					if v.stored then
						labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=00EE4F>'.._U('loc_garage')..'<font color=white> |</font>'
					else
						labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=FF0E0E>'.._U('loc_pound')..'<font color=white> |</font>'
					end
				else
					if v.stored then
						labelvehicle = labelvehicle3
					else
						labelvehicle = labelvehicle3
					end
				end

				table.insert(elements, {label = labelvehicle, value = v})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_aircraft', {
			title = _U('garage_aircrafts'),
			align = Config.Main.MenuAlign,
			elements = elements
		}, function(data, menu)
			if data.current.value == nil then
			else
				if data.current.value.stored then
					menu.close()
					if CanSpawnVehicleInPos(this_Garage.Spawner) then
						SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
					end
				else
					ESX.ShowNotification(_U('aircraft_is_impounded'))
				end
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function ListOwnedAircraftsMenu()
	local playerPed  = PlayerPedId()

	if IsPedInAnyVehicle(playerPed,  false) then
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_car___222qasqs', {
			title = _U('garage_aircrafts'),
			align = Config.Main.MenuAlign,
			elements = {
				{label = '<font color=red>تخزين</font>', value = 'yes'},
			}
		}, function(data, menu)
			if data.current.value == 'yes' then
				ESX.UI.Menu.CloseAll()
				StoreOwnedAircraftsMenu()
			end
		end, function(data, menu)
			menu.close()
		end)
	else
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_car___222ssss', {
			title = _U('garage_aircrafts'),
			align = Config.Main.MenuAlign,
			elements = {
				{label = '<font color=green>عرض</font>', value = 'yes'},
			}
		}, function(data, menu)
			if data.current.value == 'yes' then
				ESX.UI.Menu.CloseAll()
				ListOwnedAircraftsMenu2()
			end
		end, function(data, menu)
			menu.close()
		end)
	end
end

function StoreOwnedAircraftsMenu()
	local playerPed  = PlayerPedId()

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(PlayerPedId(), true)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
			if valid then
				if engineHealth < 990 then
					if Config.Main.DamageMult then
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.Aircrafts.PoundP*Config.Main.MultAmount)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					else
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.Aircrafts.PoundP)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					end
				else
					StoreVehicle(vehicle, vehicleProps)
				end	
			else
				ESX.ShowNotification(_U('cannot_store_vehicle'))
			end
		end, vehicleProps)
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end

function ReturnOwnedAircraftsMenu()
	if WasInPound then
		ESX.ShowNotification(_U('must_wait', Config.Main.PoundWait))
	else
		ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedAircrafts', function(ownedAircrafts)
			local elements = {}

			if Config.Main.ShowVehLoc == false and Config.Main.Spacers then
				local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
				table.insert(elements, {label = spacer, value = nil})
			end

			for _,v in pairs(ownedAircrafts) do
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = v.name
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)

				labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span> |'):format(_U('return'))

				table.insert(elements, {label = labelvehicle, value = v})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_aircraft', {
				title = _U('pound_aircrafts', ESX.Math.GroupDigits(Config.Aircrafts.PoundP)),
				align = Config.Main.MenuAlign,
				elements = elements
			}, function(data, menu)
				local doesVehicleExist = false

				for k,v in pairs (vehInstance) do
					if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.value.plate) then
						if DoesEntityExist(v.vehicleentity) then
							doesVehicleExist = true
						else
							table.remove(vehInstance, k)
							doesVehicleExist = false
						end
					end
				end

				if not doesVehicleExist and not DoesAPlayerDrivesVehicle(data.current.value.plate) then
					ESX.TriggerServerCallback('esx_advancedgarage:checkMoneyAircrafts', function(hasEnoughMoney)
						if hasEnoughMoney then
							if data.current.value == nil then
							else
								if CanSpawnVehicleInPos(this_Garage.Spawner) then
									SpawnVehicle(data.current.value, data.current.value.plate)
									TriggerServerEvent('esx_advancedgarage:payAircraft', securityToken)
									if Config.Main.PoundTimer then
										WasInPound = true
									end
								end
							end
						else
							ESX.ShowNotification(_U('not_enough_money'))
						end
					end)
				else
					ESX.ShowNotification(_U('cant_take_out'))
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end
end
-- End of Aircraft Code

-- Start of Helicopter Code
function ListOwnedHelicoptersMenu2()
	local elements = {}

	if Config.Main.ShowVehLoc and Config.Main.Spacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - <span style="color:red;">%s</span> |'):format(_U('plate'), _U('vehicle'), _U('location'))
		table.insert(elements, {label = spacer, value = nil})
	elseif Config.Main.ShowVehLoc == false and Config.Main.Spacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
		table.insert(elements, {label = ('<span style="color:red;">%s</span>'):format(_U('spacer1')), value = nil})
		table.insert(elements, {label = spacer, value = nil})
	end

	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedHelicopters', function(ownedHelicopters)
		if #ownedHelicopters == 0 then
			ESX.ShowNotification(_U('garage_no_helicopters'))
		else
			for _,v in pairs(ownedHelicopters) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = v.name
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)
				local labelvehicle3 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> | '):format(plate, vehicleName)

				if Config.Main.ShowVehLoc then
					if v.stored then
						labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=00EE4F>'.._U('loc_garage')..'<font color=white> |</font>'
					else
						labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=FF0E0E>'.._U('loc_pound')..'<font color=white> |</font>'
					end
				else
					if v.stored then
						labelvehicle = labelvehicle3
					else
						labelvehicle = labelvehicle3
					end
				end

				table.insert(elements, {label = labelvehicle, value = v})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_helicopter', {
			title = _U('garage_helicopters'),
			align = Config.Main.MenuAlign,
			elements = elements
		}, function(data, menu)
			if data.current.value == nil then
			else
				if data.current.value.stored then
					menu.close()
					if CanSpawnVehicleInPos(this_Garage.Spawner) then
						SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
					end
				else
					ESX.ShowNotification(_U('helicopter_is_impounded'))
				end
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function ListOwnedHelicoptersMenu()
	local playerPed  = PlayerPedId()

	if IsPedInAnyVehicle(playerPed,  false) then
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_car___222s', {
			title = _U('garage_helicopters'),
			align = Config.Main.MenuAlign,
			elements = {
				{label = '<font color=red>تخزين</font>', value = 'yes'},
			}
		}, function(data, menu)
			if data.current.value == 'yes' then
				ESX.UI.Menu.CloseAll()
				StoreOwnedHelicoptersMenu()
			end
		end, function(data, menu)
			menu.close()
		end)
	else
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_car___222s', {
			title = _U('garage_helicopters'),
			align = Config.Main.MenuAlign,
			elements = {
				{label = '<font color=green>عرض</font>', value = 'yes'},
			}
		}, function(data, menu)
			if data.current.value == 'yes' then
				ESX.UI.Menu.CloseAll()
				ListOwnedHelicoptersMenu2()
			end
		end, function(data, menu)
			menu.close()
		end)
	end
end

function StoreOwnedHelicoptersMenu()
	local playerPed  = PlayerPedId()

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(PlayerPedId(), true)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
			if valid then
				if engineHealth < 990 then
					if Config.Main.DamageMult then
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.Helicopters.PoundP*Config.Main.MultAmount)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					else
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.Helicopters.PoundP)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					end
				else
					StoreVehicle(vehicle, vehicleProps)
				end	
			else
				ESX.ShowNotification(_U('cannot_store_vehicle'))
			end
		end, vehicleProps)
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end

function ReturnOwnedHelicoptersMenu()
	if WasInPound then
		ESX.ShowNotification(_U('must_wait', Config.Main.PoundWait))
	else
		ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedHelicopters', function(ownedHelicopters)
			local elements = {}

			if Config.Main.ShowVehLoc == false and Config.Main.Spacers then
				local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
				table.insert(elements, {label = spacer, value = nil})
			end

			for _,v in pairs(ownedHelicopters) do
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = v.name
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)

				labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span> |'):format(_U('return'))

				table.insert(elements, {label = labelvehicle, value = v})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_helicopter', {
				title = _U('pound_helicopters', ESX.Math.GroupDigits(Config.Helicopters.PoundP)),
				align = Config.Main.MenuAlign,
				elements = elements
			}, function(data, menu)
				local doesVehicleExist = false

				for k,v in pairs (vehInstance) do
					if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.value.plate) then
						if DoesEntityExist(v.vehicleentity) then
							doesVehicleExist = true
						else
							table.remove(vehInstance, k)
							doesVehicleExist = false
						end
					end
				end

				if not doesVehicleExist and not DoesAPlayerDrivesVehicle(data.current.value.plate) then
					ESX.TriggerServerCallback('esx_advancedgarage:checkMoneyHelicopters', function(hasEnoughMoney)
						if hasEnoughMoney then
							if data.current.value == nil then
							else
								if CanSpawnVehicleInPos(this_Garage.Spawner) then
									SpawnVehicle(data.current.value, data.current.value.plate)
									TriggerServerEvent('esx_advancedgarage:payHelicopter', securityToken)
									if Config.Main.PoundTimer then
										WasInPound = true
									end
								end
							end
						else
							ESX.ShowNotification(_U('not_enough_money'))
						end
					end)
				else
					ESX.ShowNotification(_U('cant_take_out'))
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end
end
-- End of Helicopter Code

-- Start of Boat Code
function ListOwnedBoatsMenu()
	local elements = {}

	if Config.Main.ShowVehLoc and Config.Main.Spacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - <span style="color:red;">%s</span> |'):format(_U('plate'), _U('vehicle'), _U('location'))
		table.insert(elements, {label = spacer, value = nil})
	elseif Config.Main.ShowVehLoc == false and Config.Main.Spacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
		table.insert(elements, {label = ('<span style="color:red;">%s</span>'):format(_U('spacer1')), value = nil})
		table.insert(elements, {label = spacer, value = nil})
	end

	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedBoats', function(ownedBoats)
		if #ownedBoats == 0 then
			ESX.ShowNotification(_U('garage_no_boats'))
		else
			for _,v in pairs(ownedBoats) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = v.name
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)
				local labelvehicle3 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> | '):format(plate, vehicleName)

				if Config.Main.ShowVehLoc then
					if v.stored then
						labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=00EE4F>'.._U('loc_garage')..'<font color=white> |</font>'
					else
						labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=FF0E0E>'.._U('loc_pound')..'<font color=white> |</font>'
					end
				else
					if v.stored then
						labelvehicle = labelvehicle3
					else
						labelvehicle = labelvehicle3
					end
				end

				table.insert(elements, {label = labelvehicle, value = v})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_boat', {
			title = _U('garage_boats'),
			align = Config.Main.MenuAlign,
			elements = elements
		}, function(data, menu)
			if data.current.value == nil then
			else
				if data.current.value.stored then
					menu.close()
					if CanSpawnVehicleInPos(this_Garage.Spawner) then
						SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
					end
				else
					ESX.ShowNotification(_U('boat_is_impounded'))
				end
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function StoreOwnedBoatsMenu()
	local playerPed  = PlayerPedId()

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(PlayerPedId(), true)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
			if valid then
				if engineHealth < 990 then
					if Config.Main.DamageMult then
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.Boats.PoundP*Config.Main.MultAmount)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					else
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.Boats.PoundP)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					end
				else
					StoreVehicle(vehicle, vehicleProps)
				end	
			else
				ESX.ShowNotification(_U('cannot_store_vehicle'))
			end
		end, vehicleProps)
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end

function ReturnOwnedBoatsMenu()
	if WasInPound then
		ESX.ShowNotification(_U('must_wait', Config.Main.PoundWait))
	else
		ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedBoats', function(ownedBoats)
			local elements = {}

			if Config.Main.ShowVehLoc == false and Config.Main.Spacers then
				local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
				table.insert(elements, {label = spacer, value = nil})
			end

			for _,v in pairs(ownedBoats) do
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = v.name
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)

				labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span> |'):format(_U('return'))

				table.insert(elements, {label = labelvehicle, value = v})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_boat', {
				title = _U('pound_boats', ESX.Math.GroupDigits(Config.Boats.PoundP)),
				align = Config.Main.MenuAlign,
				elements = elements
			}, function(data, menu)
				local doesVehicleExist = false

				for k,v in pairs (vehInstance) do
					if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.value.plate) then
						if DoesEntityExist(v.vehicleentity) then
							doesVehicleExist = true
						else
							table.remove(vehInstance, k)
							doesVehicleExist = false
						end
					end
				end

				if not doesVehicleExist and not DoesAPlayerDrivesVehicle(data.current.value.plate) then
					ESX.TriggerServerCallback('esx_advancedgarage:checkMoneyBoats', function(hasEnoughMoney)
						if hasEnoughMoney then
							if data.current.value == nil then
							else
								if CanSpawnVehicleInPos(this_Garage.Spawner) then
									SpawnVehicle(data.current.value, data.current.value.plate)
									TriggerServerEvent('esx_advancedgarage:payBoat', securityToken)
									if Config.Main.PoundTimer then
										WasInPound = true
									end
								end
							end
						else
							ESX.ShowNotification(_U('not_enough_money'))
						end
					end)
				else
					ESX.ShowNotification(_U('cant_take_out'))
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end
end
-- End of Boat Code

-- Start of Truck Code
function ListOwnedTrucksMenu()
	local elements = {}

	if Config.Main.ShowVehLoc and Config.Main.Spacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - <span style="color:red;">%s</span> |'):format(_U('plate'), _U('vehicle'), _U('location'))
		table.insert(elements, {label = spacer, value = nil})
	elseif Config.Main.ShowVehLoc == false and Config.Main.Spacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
		table.insert(elements, {label = ('<span style="color:red;">%s</span>'):format(_U('spacer1')), value = nil})
		table.insert(elements, {label = spacer, value = nil})
	end

	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedTrucks', function(ownedTrucks)
		if #ownedTrucks == 0 then
			ESX.ShowNotification(_U('garage_no_trucks'))
		else
			for _,v in pairs(ownedTrucks) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = v.name
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)
				local labelvehicle3 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> | '):format(plate, vehicleName)

				if Config.Main.ShowVehLoc then
					if v.stored then
						labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=00EE4F>'.._U('loc_garage')..'<font color=white> |</font>'
					else
						labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=FF0E0E>'.._U('loc_pound')..'<font color=white> |</font>'
					end
				else
					if v.stored then
						labelvehicle = labelvehicle3
					else
						labelvehicle = labelvehicle3
					end
				end

				table.insert(elements, {label = labelvehicle, value = v})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_truck', {
			title = _U('garage_trucks'),
			align = Config.Main.MenuAlign,
			elements = elements
		}, function(data, menu)
			if data.current.value == nil then
			else
				if data.current.value.stored then
					menu.close()
					if CanSpawnVehicleInPos(this_Garage.Spawner) then
						SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
					end
				else
					ESX.ShowNotification(_U('truck_is_impounded'))
				end
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function StoreOwnedTrucksMenu()
	local playerPed  = PlayerPedId()

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(PlayerPedId(), true)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
			if valid then
				if engineHealth < 990 then
					if Config.Main.DamageMult then
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.Trucks.PoundP*Config.Main.MultAmount)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					else
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.Trucks.PoundP)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					end
				else
					StoreVehicle(vehicle, vehicleProps)
				end	
			else
				ESX.ShowNotification(_U('cannot_store_vehicle'))
			end
		end, vehicleProps)
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end

function ReturnOwnedTrucksMenu()
	if WasInPound then
		ESX.ShowNotification(_U('must_wait', Config.Main.PoundWait))
	else
		ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedTrucks', function(ownedTrucks)
			local elements = {}

			if Config.Main.ShowVehLoc == false and Config.Main.Spacers then
				local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
				table.insert(elements, {label = spacer, value = nil})
			end

			for _,v in pairs(ownedTrucks) do
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = v.name
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)

				labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span> |'):format(_U('return'))

				table.insert(elements, {label = labelvehicle, value = v})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_truck', {
				title = _U('pound_trucks', ESX.Math.GroupDigits(Config.Trucks.PoundP)),
				align = Config.Main.MenuAlign,
				elements = elements
			}, function(data, menu)
				local doesVehicleExist = false

				for k,v in pairs (vehInstance) do
					if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.value.plate) then
						if DoesEntityExist(v.vehicleentity) then
							doesVehicleExist = true
						else
							table.remove(vehInstance, k)
							doesVehicleExist = false
						end
					end
				end

				if not doesVehicleExist and not DoesAPlayerDrivesVehicle(data.current.value.plate) then
					ESX.TriggerServerCallback('esx_advancedgarage:checkMoneyTrucks', function(hasEnoughMoney)
						if hasEnoughMoney then
							if data.current.value == nil then
							else
								if CanSpawnVehicleInPos(this_Garage.Spawner) then
									SpawnVehicle(data.current.value, data.current.value.plate)
									TriggerServerEvent('esx_advancedgarage:payTruck', securityToken)
									if Config.Main.PoundTimer then
										WasInPound = true
									end
								end
							end
						else
							ESX.ShowNotification(_U('not_enough_money'))
						end
					end)
				else
					ESX.ShowNotification(_U('cant_take_out'))
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end
end
-- End of Truck Code

-- Start of Car Code
function ListOwnedCarsMenu2()
	local elements = {}

	if Config.Main.ShowVehLoc and Config.Main.Spacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - <span style="color:red;">%s</span> |'):format(_U('plate'), _U('vehicle'), _U('location'))
		table.insert(elements, {label = spacer, value = nil})
	elseif Config.Main.ShowVehLoc == false and Config.Main.Spacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
		table.insert(elements, {label = ('<span style="color:red;">%s</span>'):format(_U('spacer1')), value = nil})
		table.insert(elements, {label = spacer, value = nil})
	end

	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedCars', function(ownedCars)
		if #ownedCars == 0 then
			ESX.ShowNotification(_U('garage_no_cars'))
		else
			for _,v in pairs(ownedCars) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = v.name
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)
				local labelvehicle3 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> | '):format(plate, vehicleName)

				if Config.Main.ShowVehLoc then
					if v.stored then
						labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=00EE4F>'.._U('loc_garage')..'<font color=white> |</font>'
					else
						labelvehicle = '| <font color=FFAE00>'..plate..'<font color=white> | <font color=AF90B5>'..vehicleName..'<font color=white> | <font color=FF0E0E>'.._U('loc_pound')..'<font color=white> |</font>'
					end
				else
					if v.stored then
						labelvehicle = labelvehicle3
					else
						labelvehicle = labelvehicle3
					end
				end

				table.insert(elements, {label = labelvehicle, value = v})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_car', {
			title = _U('garage_cars'),
			align = Config.Main.MenuAlign,
			elements = elements
		}, function(data, menu)
			if data.current.value == nil then
			else
				if data.current.value.stored then
					menu.close()
					if CanSpawnVehicleInPos(this_Garage.Spawner) then
						SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
					end
				else
					ESX.ShowNotification(_U('car_is_impounded'))
				end
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function ListOwnedCarsMenu()

	local playerPed  = PlayerPedId()

	if IsPedInAnyVehicle(playerPed,  false) then
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_car___222', {
			title = 'كراج المركبات',
			align = Config.Main.MenuAlign,
			elements = {
				{label = '<font color=red>تخزين</font>', value = 'yes'},
			}
		}, function(data, menu)
			if data.current.value == 'yes' then
				ESX.UI.Menu.CloseAll()
				StoreOwnedCarsMenu()
			end
		end, function(data, menu)
			menu.close()
		end)
	else
		local elements1111 = {}
		table.insert(elements1111, {label = '<font color=64dd17>عرض جميع المركبات</font>', value = 'car'})
		if not PrivateGarage then
--			table.insert(elements1111, {label = '<font color=D37135>كراج الشاحنات</font>', value = 'truck'})
		end
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_car___222', {
			title = 'كراج المركبات',
			align = Config.Main.MenuAlign,
			elements = elements1111
		}, function(data, menu)
			if data.current.value == 'car' then
				ListOwnedCarsMenu2()
			elseif data.current.value == 'truck' then
				ListOwnedTrucksMenu()
			end
		end, function(data, menu)
			menu.close()
		end)
	end
end

function StoreOwnedCarsMenu()
	local playerPed  = PlayerPedId()

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(PlayerPedId(), true)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
			if valid then
				if engineHealth < 990 then
					if Config.Main.DamageMult then
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.Cars.PoundP*Config.Main.MultAmount)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					else
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.Cars.PoundP)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					end
				else
					StoreVehicle(vehicle, vehicleProps)
				end	
			else
				ESX.ShowNotification(_U('cannot_store_vehicle'))
			end
		end, vehicleProps)
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end

function ReturnOwnedCarsMenu2()
	ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedCars', function(ownedCars)
		local elements = {}

		if Config.Main.ShowVehLoc == false and Config.Main.Spacers then
			local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
			table.insert(elements, {label = spacer, value = nil})
		end

		for _,v in pairs(ownedCars) do
			local hashVehicule = v.model
			local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
			local vehicleName = v.name
			local plate = v.plate
			local labelvehicle
			local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)

			labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span> |'):format(_U('return'))

			table.insert(elements, {label = labelvehicle, value = v.vehicle})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_car', {
			title = _U('pound_cars', ESX.Math.GroupDigits(Config.Cars.PoundP)),
			align = Config.Main.MenuAlign,
			elements = elements
		}, function(data, menu)
			local doesVehicleExist = false

			for k,v in pairs (vehInstance) do
				if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.value.plate) then
					if DoesEntityExist(v.vehicleentity) then
						doesVehicleExist = true
					else
						table.remove(vehInstance, k)
						doesVehicleExist = false
					end
				end
			end

			if not doesVehicleExist and not DoesAPlayerDrivesVehicle(data.current.value.plate) then
				ESX.TriggerServerCallback('esx_advancedgarage:checkMoneyCars', function(hasEnoughMoney)
					if hasEnoughMoney then
						if data.current.value == nil then
						else
							if CanSpawnVehicleInPos(this_Garage.Spawner) then
								SpawnVehicle(data.current.value, data.current.value.plate)
								TriggerServerEvent('esx_advancedgarage:payCar')
								TriggerServerEvent('esx_misc3:try', data.current.value.plate)
								--ESX.TriggerServerCallback('esx_mechanic:sendLogExtractCar', ESX.PlayerData.identifier, data.current.value.plate)
								if Config.Main.PoundTimer then
									WasInPound = true
								end
							end
						end
					else
						ESX.ShowNotification(_U('not_enough_money'))
					end
				end)
			else
				ESX.ShowNotification(_U('cant_take_out'))
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function ReturnOwnedCarsMenu()
	if WasInPound then
		ESX.ShowNotification(_U('must_wait', Config.Main.PoundWait))
	else

		while ESX.PlayerData.job == nil do
			Citizen.Wait(500)
		end
		local elements515 = {}
		table.insert(elements515, { label = '<font color=#f57c00>عرض المركبات المحجوزة</font>', value = 'citizen' })
--		table.insert(elements515, { label = '<font color=D37135>حجز الشاحنات</font>', value = 'truck' })
		if ESX.PlayerData.job.name == 'police' then
			table.insert(elements515, { label = 'حجز <font color=#0070CD> إدارة الشرطة </font>', value = 'police' })
		elseif ESX.PlayerData.job.name == 'agent' then
			table.insert(elements515, { label = 'حجز <font color=#656f8b> حرس الحدود  </font>', value = 'agent' })
		elseif ESX.PlayerData.job.name == 'admin' then
			table.insert(elements515, { label = 'حجز <font color=#3D3D3D> ادارة الرقابة و التفتيش </font>', value = 'admin' })
		elseif ESX.PlayerData.job.name == 'ambulance' then
			table.insert(elements515, { label = 'حجز <font color=#E73030> الدفاع المدني </font>', value = 'ambulance' })
		elseif ESX.PlayerData.job.name == 'mechanic' then
			table.insert(elements515, { label = 'حجز <font color=#D26612> الميــكانيـكي </font>', value = 'mechanic' })
		end
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_car___ss', {
			title = 'حجز المركبات',
			align = Config.Main.MenuAlign,
			elements = elements515
		}, function(data515, menu515)
			if data515.current.value == 'citizen' then
				ReturnOwnedCarsMenu2()
			elseif data515.current.value == 'truck' then
				ReturnOwnedTrucksMenu()
			elseif data515.current.value == 'police' then
				ReturnOwnedPoliceMenu()
			elseif data515.current.value == 'agent' then
				ReturnOwnedagentMenu()
			elseif data515.current.value == 'admin' then
				ReturnOwnedAdminMenu()
			elseif data515.current.value == 'ambulance' then
				ReturnOwnedAmbulanceMenu()
			elseif data515.current.value == 'mechanic' then
				ReturnOwnedMechanicMenu()
			end
		end, function(data515, menu515)
			menu515.close()
		end)
		----------------------------------------------
	end
end
-- End of Car Code

-- WasInPound & WasinJPound Code
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(0)

-- 		if Config.Main.PoundTimer then
-- 			if WasInPound then
-- 				Citizen.Wait(Config.Main.PoundWait * 60000)
-- 				WasInPound = false
-- 			end
-- 		end

-- 		if Config.Main.JPoundTimer then
-- 			if WasinJPound then
-- 				Citizen.Wait(Config.Main.JPoundWait * 60000)
-- 				WasinJPound = false
-- 			end
-- 		end
-- 	end
-- end)

-- Repair Vehicles
function RepairVehicle(apprasial, vehicle, vehicleProps)
	ESX.UI.Menu.CloseAll()
	TriggerServerEvent('esx_advancedgarage:payhealth', apprasial, securityToken)
	vehicleProps.bodyHealth = 1000.0 -- must be a decimal value!!!
	vehicleProps.engineHealth = 1000
	StoreVehicle(vehicle, vehicleProps)
end

-- Store Vehicles
function StoreVehicle(vehicle, vehicleProps)
	for k,v in pairs (vehInstance) do
		if ESX.Math.Trim(v.plate) == ESX.Math.Trim(vehicleProps.plate) then
			table.remove(vehInstance, k)
		end
	end

	local health = {
		body = GetVehicleBodyHealth(vehicle),
		Engine = GetVehicleEngineHealth(vehicle),
	}

	DeleteEntity(vehicle)
	TriggerServerEvent('esx_advancedgarage:setVehicleState', vehicleProps.plate, true, health, securityToken)
	ESX.ShowNotification('<font color=green>تم تخزين مركبتك بنجاح</font>')
end

-- Spawn Vehicles
function SpawnVehicle(vehicle, plate)
	ESX.Game.SpawnVehicle(vehicle.model, this_Garage.Spawner, this_Garage.Heading, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		--SetVehicleFixed(callback_vehicle)
		--SetVehicleDeformationFixed(callback_vehicle)
		SetVehicleUndriveable(callback_vehicle, false)
		SetVehicleEngineOn(callback_vehicle, false, true)
		--SetVehicleEngineHealth(callback_vehicle, 1000) -- Might not be needed
		--SetVehicleBodyHealth(callback_vehicle, 1000) -- Might not be needed
		local carplate = GetVehicleNumberPlateText(callback_vehicle)
		table.insert(vehInstance, {vehicleentity = callback_vehicle, plate = carplate})
		if Config.Main.LegacyFuel then
			exports['esx_misc4']:SetFuel(callback_vehicle, fuel)
		end
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
	end)

	TriggerServerEvent('esx_advancedgarage:setVehicleState', plate, false)
end

function SpawnVehicle2(vehicle, plate)
	ESX.Game.SpawnVehicle(vehicle.model, this_Garage.Spawner2, this_Garage.Heading2, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		--SetVehicleFixed(callback_vehicle)
		--SetVehicleDeformationFixed(callback_vehicle)
		SetVehicleUndriveable(callback_vehicle, false)
		SetVehicleEngineOn(callback_vehicle, false, true)
		--SetVehicleEngineHealth(callback_vehicle, 1000) -- Might not be needed
		--SetVehicleBodyHealth(callback_vehicle, 1000) -- Might not be needed
		local carplate = GetVehicleNumberPlateText(callback_vehicle)
		table.insert(vehInstance, {vehicleentity = callback_vehicle, plate = carplate})
		if Config.Main.LegacyFuel then
			exports['esx_misc4']:SetFuel(callback_vehicle, fuel)
		end
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
	end)

	TriggerServerEvent('esx_advancedgarage:setVehicleState', plate, false)
end

function CanSpawnVehicleInPos(Pos)
	if ESX.Game.IsSpawnPointClear(Pos, 5.0) then
		return true
	end
	ESX.ShowNotification('<font color=red>لا توجد مساحة كافية لإخراج المركبة</font>')
end

-- Check Vehicles
function DoesAPlayerDrivesVehicle(plate)
	local isVehicleTaken = false
	local players = ESX.Game.GetPlayers()
	for i=1, #players, 1 do
		local target = GetPlayerPed(players[i])
		if target ~= PlayerPedId() then
			local plate1 = GetVehicleNumberPlateText(GetVehiclePedIsIn(target, true))
			local plate2 = GetVehicleNumberPlateText(GetVehiclePedIsIn(target, false))
			if plate == plate1 or plate == plate2 then
				isVehicleTaken = true
				break
			end
		end
	end
	return isVehicleTaken
end

-- Entered Marker
AddEventHandler('esx_advancedgarage:hasEnteredMarker', function(zone)
	if zone == 'ambulance_garage_point' then
		CurrentAction = 'ambulance_garage_point'
		CurrentActionMsg = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'ambulance_store_point' then
		CurrentAction = 'ambulance_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'ambulance_pound_point' then
		CurrentAction = 'ambulance_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
	elseif zone == 'police_garage_point' then
		CurrentAction = 'police_garage_point'
		CurrentActionMsg = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'police_store_point' then
		CurrentAction = 'police_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'police_pound_point' then
		CurrentAction = 'police_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}

		---------------------------
	elseif zone == 'agent_garage_point' then
		CurrentAction = 'agent_garage_point'
		CurrentActionMsg = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'agent_store_point' then
		CurrentAction = 'agent_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'agent_pound_point' then
		CurrentAction = 'agent_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
		----------------
				---------------------------
	elseif zone == 'admin_garage_point' then
		CurrentAction = 'admin_garage_point'
		CurrentActionMsg = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'admin_store_point' then
		CurrentAction = 'admin_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'admin_pound_point' then
		CurrentAction = 'admin_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
		----------------
	elseif zone == 'mechanic_garage_point' then
		CurrentAction = 'mechanic_garage_point'
		CurrentActionMsg = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'mechanic_store_point' then
		CurrentAction = 'mechanic_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'mechanic_pound_point' then
		CurrentAction = 'mechanic_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
	elseif zone == 'aircraft_garage_point' then
		CurrentAction = 'aircraft_garage_point'
		CurrentActionMsg = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'aircraft_store_point' then
		CurrentAction = 'aircraft_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'aircraft_pound_point' then
		CurrentAction = 'aircraft_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
	elseif zone == 'helicopter_garage_point' then
		CurrentAction = 'helicopter_garage_point'
		CurrentActionMsg = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'helicopter_store_point' then
		CurrentAction = 'helicopter_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'helicopter_pound_point' then
		CurrentAction = 'helicopter_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}	
	elseif zone == 'boat_garage_point' then
		CurrentAction = 'boat_garage_point'
		CurrentActionMsg = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'boat_store_point' then
		CurrentAction = 'boat_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'boat_pound_point' then
		CurrentAction = 'boat_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
	elseif zone == 'truck_garage_point' then
		CurrentAction = 'truck_garage_point'
		CurrentActionMsg = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'truck_store_point' then
		CurrentAction = 'truck_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'truck_pound_point' then
		CurrentAction = 'truck_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
	elseif zone == 'car_garage_point' then
		CurrentAction = 'car_garage_point'
		CurrentActionMsg = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'car_store_point' then
		CurrentAction = 'car_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'car_pound_point' then
		CurrentAction = 'car_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
	end
end)

-- Exited Marker
AddEventHandler('esx_advancedgarage:hasExitedMarker', function()
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Resource Stop
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		ESX.UI.Menu.CloseAll()
	end
end)

-- Enter / Exit marker events & Draw Markers
Citizen.CreateThread(function(); while not ConfigReady do; Citizen.Wait(1000); end
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local isInMarker, letSleep, currentZone = false, true

		if Config.Ambulance.Garages then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
				for k,v in pairs(Config.AmbulanceGarages) do
					local distance = #(playerCoords - v.Marker)
					local distance2 = #(playerCoords - v.Deleter)
					local distance3 = #(playerCoords - v.Deleter2)

					if distance < Config.Main.DrawDistance then
						letSleep = false

						if Config.Ambulance.Markers.Points.Type ~= -1 then
							DrawMarker(Config.Ambulance.Markers.Points.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Ambulance.Markers.Points.x, Config.Ambulance.Markers.Points.y, Config.Ambulance.Markers.Points.z, Config.Ambulance.Markers.Points.r, Config.Ambulance.Markers.Points.g, Config.Ambulance.Markers.Points.b, 100, false, true, 2, true, nil, nil, false)
						end

						if distance < Config.Ambulance.Markers.Points.x then
							isInMarker, this_Garage, currentZone = true, v, 'ambulance_garage_point'
						end
					end

					if distance2 < Config.Main.DrawDistance then
						letSleep = false

						if Config.Ambulance.Markers.Delete.Type ~= -1 then
							DrawMarker(Config.Ambulance.Markers.Delete.Type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Ambulance.Markers.Delete.x, Config.Ambulance.Markers.Delete.y, Config.Ambulance.Markers.Delete.z, Config.Ambulance.Markers.Delete.r, Config.Ambulance.Markers.Delete.g, Config.Ambulance.Markers.Delete.b, 100, false, true, 2, true, nil, nil, false)
						end

						if distance2 < Config.Ambulance.Markers.Delete.x then
							isInMarker, this_Garage, currentZone = true, v, 'ambulance_store_point'
						end
					end

					if distance3 < Config.Main.DrawDistance then
						letSleep = false

						if Config.Ambulance.Markers.Delete.Type ~= -1 then
							DrawMarker(Config.Ambulance.Markers.Delete.Type, v.Deleter2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Ambulance.Markers.Delete.x, Config.Ambulance.Markers.Delete.y, Config.Ambulance.Markers.Delete.z, Config.Ambulance.Markers.Delete.r, Config.Ambulance.Markers.Delete.g, Config.Ambulance.Markers.Delete.b, 100, false, true, 2, true, nil, nil, false)
						end

						if distance3 < Config.Ambulance.Markers.Delete.x then
							isInMarker, this_Garage, currentZone = true, v, 'ambulance_store_point'
						end
					end
				end
			end
		end

		if Config.Ambulance.Pounds then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
				for k,v in pairs(Config.AmbulancePounds) do
					local distance = #(playerCoords - v.Marker)

					if distance < Config.Main.DrawDistance then
						letSleep = false

						if Config.Ambulance.Markers.Pounds.Type ~= -1 then
							DrawMarker(Config.Ambulance.Markers.Pounds.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Ambulance.Markers.Pounds.x, Config.Ambulance.Markers.Pounds.y, Config.Ambulance.Markers.Pounds.z, Config.Ambulance.Markers.Pounds.r, Config.Ambulance.Markers.Pounds.g, Config.Ambulance.Markers.Pounds.b, 100, false, true, 2, true, nil, nil, false)
						end

						if distance < Config.Ambulance.Markers.Pounds.x then
							isInMarker, this_Garage, currentZone = true, v, 'ambulance_pound_point'
						end
					end
				end
			end
		end

		if Config.Police.Garages then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
				for k,v in pairs(Config.PoliceGarages) do
					local distance = #(playerCoords - v.Marker)
					local distance2 = #(playerCoords - v.Deleter)
					local distance3 = #(playerCoords - v.Deleter2)

					if distance < Config.Main.DrawDistance then
						letSleep = false

						if Config.Police.Markers.Points.Type ~= -1 then
							DrawMarker(Config.Police.Markers.Points.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Police.Markers.Points.x, Config.Police.Markers.Points.y, Config.Police.Markers.Points.z, Config.Police.Markers.Points.r, Config.Police.Markers.Points.g, Config.Police.Markers.Points.b, 100, false, true, 2, true, nil, nil, false)
						end

						if distance < Config.Police.Markers.Points.x then
							isInMarker, this_Garage, currentZone = true, v, 'police_garage_point'
						end
					end

					if distance2 < Config.Main.DrawDistance then
						letSleep = false

						if Config.Police.Markers.Delete.Type ~= -1 then
							DrawMarker(Config.Police.Markers.Delete.Type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Police.Markers.Delete.x, Config.Police.Markers.Delete.y, Config.Police.Markers.Delete.z, Config.Police.Markers.Delete.r, Config.Police.Markers.Delete.g, Config.Police.Markers.Delete.b, 100, false, true, 2, true, nil, nil, false)
						end

						if distance2 < Config.Police.Markers.Delete.x then
							isInMarker, this_Garage, currentZone = true, v, 'police_store_point'
						end
					end

					if distance3 < Config.Main.DrawDistance then
						letSleep = false

						if Config.Police.Markers.Delete.Type ~= -1 then
							DrawMarker(Config.Police.Markers.Delete.Type, v.Deleter2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Police.Markers.Delete.x, Config.Police.Markers.Delete.y, Config.Police.Markers.Delete.z, Config.Police.Markers.Delete.r, Config.Police.Markers.Delete.g, Config.Police.Markers.Delete.b, 100, false, true, 2, true, nil, nil, false)
						end

						if distance3 < Config.Police.Markers.Delete.x then
							isInMarker, this_Garage, currentZone = true, v, 'police_store_point'
						end
					end
				end
			end
		end

		if Config.Police.Pounds then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
				for k,v in pairs(Config.PolicePounds) do
					local distance = #(playerCoords - v.Marker)

					if distance < Config.Main.DrawDistance then
						letSleep = false

						if Config.Police.Markers.Pounds.Type ~= -1 then
							DrawMarker(Config.Police.Markers.Pounds.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Police.Markers.Pounds.x, Config.Police.Markers.Pounds.y, Config.Police.Markers.Pounds.z, Config.Police.Markers.Pounds.r, Config.Police.Markers.Pounds.g, Config.Police.Markers.Pounds.b, 100, false, true, 2, true, nil, nil, false)
						end

						if distance < Config.Police.Markers.Pounds.x then
							isInMarker, this_Garage, currentZone = true, v, 'police_pound_point'
						end
					end
				end
			end
		end

		------------------------------
		
		if Config.agent.Garages then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'agent' then
				for k,v in pairs(Config.agentGarages) do
					local distance = #(playerCoords - v.Marker)
					local distance2 = #(playerCoords - v.Deleter)
					local distance3 = #(playerCoords - v.Deleter2)

					if distance < Config.Main.DrawDistance then
						letSleep = false

						if Config.agent.Markers.Points.Type ~= -1 then
							DrawMarker(Config.agent.Markers.Points.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.agent.Markers.Points.x, Config.agent.Markers.Points.y, Config.agent.Markers.Points.z, Config.agent.Markers.Points.r, Config.agent.Markers.Points.g, Config.agent.Markers.Points.b, 100, false, true, 2, true, nil, nil, false)
						end

						if distance < Config.agent.Markers.Points.x then
							isInMarker, this_Garage, currentZone = true, v, 'agent_garage_point'
						end
					end

					if distance2 < Config.Main.DrawDistance then
						letSleep = false

						if Config.agent.Markers.Delete.Type ~= -1 then
							DrawMarker(Config.agent.Markers.Delete.Type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.agent.Markers.Delete.x, Config.agent.Markers.Delete.y, Config.agent.Markers.Delete.z, Config.agent.Markers.Delete.r, Config.agent.Markers.Delete.g, Config.agent.Markers.Delete.b, 100, false, true, 2, true, nil, nil, false)
						end

						if distance2 < Config.agent.Markers.Delete.x then
							isInMarker, this_Garage, currentZone = true, v, 'agent_store_point'
						end
					end

					if distance3 < Config.Main.DrawDistance then
						letSleep = false

						if Config.agent.Markers.Delete.Type ~= -1 then
							DrawMarker(Config.agent.Markers.Delete.Type, v.Deleter2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.agent.Markers.Delete.x, Config.agent.Markers.Delete.y, Config.agent.Markers.Delete.z, Config.agent.Markers.Delete.r, Config.agent.Markers.Delete.g, Config.agent.Markers.Delete.b, 100, false, true, 2, true, nil, nil, false)
						end

						if distance3 < Config.agent.Markers.Delete.x then
							isInMarker, this_Garage, currentZone = true, v, 'agent_store_point'
						end
					end
				end
			end
		end

		if Config.agent.Pounds then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'agent' then
				for k,v in pairs(Config.agentPounds) do
					local distance = #(playerCoords - v.Marker)

					if distance < Config.Main.DrawDistance then
						letSleep = false

						if Config.agent.Markers.Pounds.Type ~= -1 then
							DrawMarker(Config.agent.Markers.Pounds.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.agent.Markers.Pounds.x, Config.agent.Markers.Pounds.y, Config.agent.Markers.Pounds.z, Config.agent.Markers.Pounds.r, Config.agent.Markers.Pounds.g, Config.agent.Markers.Pounds.b, 100, false, true, 2, true, nil, nil, false)
						end

						if distance < Config.agent.Markers.Pounds.x then
							isInMarker, this_Garage, currentZone = true, v, 'agent_pound_point'
						end
					end
				end
			end
		end

				------------------------------
		
				if Config.Admin.Garages then
					if ESX.PlayerData.job and ESX.PlayerData.job.name == 'admin' then
						for k,v in pairs(Config.AdminGarages) do
							local distance = #(playerCoords - v.Marker)
							local distance2 = #(playerCoords - v.Deleter)
							local distance3 = #(playerCoords - v.Deleter2)
		
							if distance < Config.Main.DrawDistance then
								letSleep = false
		
								if Config.Admin.Markers.Points.Type ~= -1 then
									DrawMarker(Config.Admin.Markers.Points.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Admin.Markers.Points.x, Config.Admin.Markers.Points.y, Config.Admin.Markers.Points.z, Config.Admin.Markers.Points.r, Config.Admin.Markers.Points.g, Config.Admin.Markers.Points.b, 100, false, true, 2, true, nil, nil, false)
								end
		
								if distance < Config.Admin.Markers.Points.x then
									isInMarker, this_Garage, currentZone = true, v, 'admin_garage_point'
								end
							end
		
							if distance2 < Config.Main.DrawDistance then
								letSleep = false
		
								if Config.Admin.Markers.Delete.Type ~= -1 then
									DrawMarker(Config.Admin.Markers.Delete.Type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Admin.Markers.Delete.x, Config.Admin.Markers.Delete.y, Config.Admin.Markers.Delete.z, Config.Admin.Markers.Delete.r, Config.Admin.Markers.Delete.g, Config.Admin.Markers.Delete.b, 100, false, true, 2, true, nil, nil, false)
								end
		
								if distance2 < Config.Admin.Markers.Delete.x then
									isInMarker, this_Garage, currentZone = true, v, 'admin_store_point'
								end
							end
		
							if distance3 < Config.Main.DrawDistance then
								letSleep = false
		
								if Config.Admin.Markers.Delete.Type ~= -1 then
									DrawMarker(Config.Admin.Markers.Delete.Type, v.Deleter2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Admin.Markers.Delete.x, Config.Admin.Markers.Delete.y, Config.Admin.Markers.Delete.z, Config.Admin.Markers.Delete.r, Config.Admin.Markers.Delete.g, Config.Admin.Markers.Delete.b, 100, false, true, 2, true, nil, nil, false)
								end
		
								if distance3 < Config.Admin.Markers.Delete.x then
									isInMarker, this_Garage, currentZone = true, v, 'admin_store_point'
								end
							end
						end
					end
				end
		
				if Config.Admin.Pounds then
					if ESX.PlayerData.job and ESX.PlayerData.job.name == 'admin' then
						for k,v in pairs(Config.AdminPounds) do
							local distance = #(playerCoords - v.Marker)
		
							if distance < Config.Main.DrawDistance then
								letSleep = false
		
								if Config.Admin.Markers.Pounds.Type ~= -1 then
									DrawMarker(Config.Admin.Markers.Pounds.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Admin.Markers.Pounds.x, Config.Admin.Markers.Pounds.y, Config.Admin.Markers.Pounds.z, Config.Admin.Markers.Pounds.r, Config.Admin.Markers.Pounds.g, Config.Admin.Markers.Pounds.b, 100, false, true, 2, true, nil, nil, false)
								end
		
								if distance < Config.Admin.Markers.Pounds.x then
									isInMarker, this_Garage, currentZone = true, v, 'admin_pound_point'
								end
							end
						end
					end
				end

		if Config.Mechanic.Garages then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
				for k,v in pairs(Config.MechanicGarages) do
					local distance = #(playerCoords - v.Marker)
					local distance2 = #(playerCoords - v.Deleter)

					if distance < Config.Main.DrawDistance then
						letSleep = false

						if Config.Mechanic.Markers.Points.Type ~= -1 then
							DrawMarker(Config.Mechanic.Markers.Points.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Mechanic.Markers.Points.x, Config.Mechanic.Markers.Points.y, Config.Mechanic.Markers.Points.z, Config.Mechanic.Markers.Points.r, Config.Mechanic.Markers.Points.g, Config.Mechanic.Markers.Points.b, 100, false, true, 2, true, nil, nil, false)
						end

						if distance < Config.Mechanic.Markers.Points.x then
							isInMarker, this_Garage, currentZone = true, v, 'mechanic_garage_point'
						end
					end

					if distance2 < Config.Main.DrawDistance then
						letSleep = false

						if Config.Mechanic.Markers.Delete.Type ~= -1 then
							DrawMarker(Config.Mechanic.Markers.Delete.Type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Mechanic.Markers.Delete.x, Config.Mechanic.Markers.Delete.y, Config.Mechanic.Markers.Delete.z, Config.Mechanic.Markers.Delete.r, Config.Mechanic.Markers.Delete.g, Config.Mechanic.Markers.Delete.b, 100, false, true, 2, true, nil, nil, false)
						end

						if distance2 < Config.Mechanic.Markers.Delete.x then
							isInMarker, this_Garage, currentZone = true, v, 'mechanic_store_point'
						end
					end
				end
			end
		end

		if Config.Mechanic.Pounds then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
				for k,v in pairs(Config.MechanicPounds) do
					local distance = #(playerCoords - v.Marker)

					if distance < Config.Main.DrawDistance then
						letSleep = false

						if Config.Mechanic.Markers.Pounds.Type ~= -1 then
							DrawMarker(Config.Mechanic.Markers.Pounds.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Mechanic.Markers.Pounds.x, Config.Mechanic.Markers.Pounds.y, Config.Mechanic.Markers.Pounds.z, Config.Mechanic.Markers.Pounds.r, Config.Mechanic.Markers.Pounds.g, Config.Mechanic.Markers.Pounds.b, 100, false, true, 2, true, nil, nil, false)
						end

						if distance < Config.Mechanic.Markers.Pounds.x then
							isInMarker, this_Garage, currentZone = true, v, 'mechanic_pound_point'
						end
					end
				end
			end
		end

		if Config.Aircrafts.Garages then
			for k,v in pairs(Config.AircraftGarages) do
				if v.Marker then
					local distance = #(playerCoords - v.Marker)
					if distance < Config.Main.DrawDistance then
						letSleep = false

						if Config.Aircrafts.Markers.Points.Type ~= -1 then
							DrawMarker(Config.Aircrafts.Markers.Points.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Aircrafts.Markers.Points.x, Config.Aircrafts.Markers.Points.y, Config.Aircrafts.Markers.Points.z, Config.Aircrafts.Markers.Points.r, Config.Aircrafts.Markers.Points.g, Config.Aircrafts.Markers.Points.b, 100, false, true, 2, true, nil, nil, false)
						end

						if distance < Config.Aircrafts.Markers.Points.x then
							isInMarker, this_Garage, currentZone = true, v, 'aircraft_garage_point'
						end
					end
				end

				if v.Deleter then
					local distance2 = #(playerCoords - v.Deleter)
					if distance2 < Config.Main.DrawDistance then
						letSleep = false

						if Config.Aircrafts.Markers.Delete.Type ~= -1 then
							DrawMarker(Config.Aircrafts.Markers.Delete.Type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Aircrafts.Markers.Delete.x, Config.Aircrafts.Markers.Delete.y, Config.Aircrafts.Markers.Delete.z, Config.Aircrafts.Markers.Delete.r, Config.Aircrafts.Markers.Delete.g, Config.Aircrafts.Markers.Delete.b, 100, false, true, 2, true, nil, nil, false)
						end

						if distance2 < Config.Aircrafts.Markers.Delete.x then
							isInMarker, this_Garage, currentZone = true, v, 'aircraft_store_point'
						end
					end
				end
			end

			for k,v in pairs(Config.AircraftPounds) do
				local distance = #(playerCoords - v.Marker)

				if distance < Config.Main.DrawDistance then
					letSleep = false

					if Config.Aircrafts.Markers.Pounds.Type ~= -1 then
						DrawMarker(Config.Aircrafts.Markers.Pounds.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Aircrafts.Markers.Pounds.x, Config.Aircrafts.Markers.Pounds.y, Config.Aircrafts.Markers.Pounds.z, Config.Aircrafts.Markers.Pounds.r, Config.Aircrafts.Markers.Pounds.g, Config.Aircrafts.Markers.Pounds.b, 100, false, true, 2, true, nil, nil, false)
					end

					if distance < Config.Aircrafts.Markers.Pounds.x then
						isInMarker, this_Garage, currentZone = true, v, 'aircraft_pound_point'
					end
				end
			end
		end




		if Config.Helicopters.Garages then
			for k,v in pairs(Config.HelicopterGarages) do

				if v.Marker then
					local distance = #(playerCoords - v.Marker)
					if distance < Config.Main.DrawDistance then
						letSleep = false

						if Config.Helicopters.Markers.Points.Type ~= -1 then
							DrawMarker(Config.Helicopters.Markers.Points.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Helicopters.Markers.Points.x, Config.Helicopters.Markers.Points.y, Config.Helicopters.Markers.Points.z, Config.Helicopters.Markers.Points.r, Config.Helicopters.Markers.Points.g, Config.Helicopters.Markers.Points.b, 100, false, true, 2, true, nil, nil, false)
						end

						if distance < Config.Helicopters.Markers.Points.x then
							isInMarker, this_Garage, currentZone = true, v, 'helicopter_garage_point'
						end
					end
				end

				if v.Deleter then
					local distance2 = #(playerCoords - v.Deleter)
					if distance2 < Config.Main.DrawDistance then
						letSleep = false

						if Config.Helicopters.Markers.Delete.Type ~= -1 then
							DrawMarker(Config.Helicopters.Markers.Delete.Type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Helicopters.Markers.Delete.x, Config.Helicopters.Markers.Delete.y, Config.Helicopters.Markers.Delete.z, Config.Helicopters.Markers.Delete.r, Config.Helicopters.Markers.Delete.g, Config.Helicopters.Markers.Delete.b, 100, false, true, 2, true, nil, nil, false)
						end

						if distance2 < Config.Helicopters.Markers.Delete.x then
							isInMarker, this_Garage, currentZone = true, v, 'helicopter_store_point'
						end
					end
				end
			end

			for k,v in pairs(Config.HelicopterPounds) do
				local distance = #(playerCoords - v.Marker)

				if distance < Config.Main.DrawDistance then
					letSleep = false

					if Config.Helicopters.Markers.Pounds.Type ~= -1 then
						DrawMarker(Config.Helicopters.Markers.Pounds.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Helicopters.Markers.Pounds.x, Config.Helicopters.Markers.Pounds.y, Config.Helicopters.Markers.Pounds.z, Config.Helicopters.Markers.Pounds.r, Config.Helicopters.Markers.Pounds.g, Config.Helicopters.Markers.Pounds.b, 100, false, true, 2, true, nil, nil, false)
					end

					if distance < Config.Helicopters.Markers.Pounds.x then
						isInMarker, this_Garage, currentZone = true, v, 'helicopter_pound_point'
					end
				end
			end
		end

		if Config.Boats.Garages then
			for k,v in pairs(Config.BoatGarages) do
				local distance = #(playerCoords - v.Marker)
				local distance2 = #(playerCoords - v.Deleter)

				if distance < Config.Main.DrawDistance then
					letSleep = false

					if Config.Boats.Markers.Points.Type ~= -1 then
						DrawMarker(Config.Boats.Markers.Points.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Boats.Markers.Points.x, Config.Boats.Markers.Points.y, Config.Boats.Markers.Points.z, Config.Boats.Markers.Points.r, Config.Boats.Markers.Points.g, Config.Boats.Markers.Points.b, 100, false, true, 2, true, nil, nil, false)
					end

					if distance < Config.Boats.Markers.Points.x then
						isInMarker, this_Garage, currentZone = true, v, 'boat_garage_point'
					end
				end

				if distance2 < Config.Main.DrawDistance then
					letSleep = false

					if Config.Boats.Markers.Delete.Type ~= -1 then
						DrawMarker(Config.Boats.Markers.Delete.Type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Boats.Markers.Delete.x, Config.Boats.Markers.Delete.y, Config.Boats.Markers.Delete.z, Config.Boats.Markers.Delete.r, Config.Boats.Markers.Delete.g, Config.Boats.Markers.Delete.b, 100, false, true, 2, true, nil, nil, false)
					end

					if distance2 < Config.Boats.Markers.Delete.x then
						isInMarker, this_Garage, currentZone = true, v, 'boat_store_point'
					end
				end
			end

			for k,v in pairs(Config.BoatPounds) do
				local distance = #(playerCoords - v.Marker)

				if distance < Config.Main.DrawDistance then
					letSleep = false

					if Config.Boats.Markers.Pounds.Type ~= -1 then
						DrawMarker(Config.Boats.Markers.Pounds.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Boats.Markers.Pounds.x, Config.Boats.Markers.Pounds.y, Config.Boats.Markers.Pounds.z, Config.Boats.Markers.Pounds.r, Config.Boats.Markers.Pounds.g, Config.Boats.Markers.Pounds.b, 100, false, true, 2, true, nil, nil, false)
					end

					if distance < Config.Boats.Markers.Pounds.x then
						isInMarker, this_Garage, currentZone = true, v, 'boat_pound_point'
					end
				end
			end
		end

		if Config.Trucks.Garages then
			for k,v in pairs(Config.TruckGarages) do
				local distance = #(playerCoords - v.Marker)
				local distance2 = #(playerCoords - v.Deleter)

				if distance < Config.Main.DrawDistance then
					letSleep = false

					if Config.Trucks.Markers.Points.Type ~= -1 then
						DrawMarker(Config.Trucks.Markers.Points.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Trucks.Markers.Points.x, Config.Trucks.Markers.Points.y, Config.Trucks.Markers.Points.z, Config.Trucks.Markers.Points.r, Config.Trucks.Markers.Points.g, Config.Trucks.Markers.Points.b, 100, false, true, 2, true, nil, nil, false)
					end

					if distance < Config.Trucks.Markers.Points.x then
						isInMarker, this_Garage, currentZone = true, v, 'truck_garage_point'
					end
				end

				if distance2 < Config.Main.DrawDistance then
					letSleep = false

					if Config.Trucks.Markers.Delete.Type ~= -1 then
						DrawMarker(Config.Trucks.Markers.Delete.Type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Trucks.Markers.Delete.x, Config.Trucks.Markers.Delete.y, Config.Trucks.Markers.Delete.z, Config.Trucks.Markers.Delete.r, Config.Trucks.Markers.Delete.g, Config.Trucks.Markers.Delete.b, 100, false, true, 2, true, nil, nil, false)
					end

					if distance2 < Config.Trucks.Markers.Delete.x then
						isInMarker, this_Garage, currentZone = true, v, 'truck_store_point'
					end
				end
			end

			for k,v in pairs(Config.TruckPounds) do
				local distance = #(playerCoords - v.Marker)

				if distance < Config.Main.DrawDistance then
					letSleep = false

					if Config.Trucks.Markers.Pounds.Type ~= -1 then
						DrawMarker(Config.Trucks.Markers.Pounds.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Trucks.Markers.Pounds.x, Config.Trucks.Markers.Pounds.y, Config.Trucks.Markers.Pounds.z, Config.Trucks.Markers.Pounds.r, Config.Trucks.Markers.Pounds.g, Config.Trucks.Markers.Pounds.b, 100, false, true, 2, true, nil, nil, false)
					end

					if distance < Config.Trucks.Markers.Pounds.x then
						isInMarker, this_Garage, currentZone = true, v, 'truck_pound_point'
					end
				end
			end
		end

		if Config.Cars.Garages then
			for k,v in pairs(Config.CarGarages) do
				if v.Marker then
					local distance = #(playerCoords - v.Marker)
					if distance < Config.Main.DrawDistance then
						letSleep = false

						if Config.Cars.Markers.Points.Type ~= -1 then
							DrawMarker(Config.Cars.Markers.Points.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Cars.Markers.Points.x, Config.Cars.Markers.Points.y, Config.Cars.Markers.Points.z, Config.Cars.Markers.Points.r, Config.Cars.Markers.Points.g, Config.Cars.Markers.Points.b, 100, false, true, 2, true, nil, nil, false)
						end

						if distance < Config.Cars.Markers.Points.x then
							PrivateGarage = false
							isInMarker, this_Garage, currentZone = true, v, 'car_garage_point'
						end
					end
				end

				if v.Deleter then
					local distance2 = #(playerCoords - v.Deleter)
					if distance2 < Config.Main.DrawDistance then
						letSleep = false

						if Config.Cars.Markers.Delete.Type ~= -1 then
							DrawMarker(Config.Cars.Markers.Delete.Type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Cars.Markers.Delete.x, Config.Cars.Markers.Delete.y, Config.Cars.Markers.Delete.z, Config.Cars.Markers.Delete.r, Config.Cars.Markers.Delete.g, Config.Cars.Markers.Delete.b, 100, false, true, 2, true, nil, nil, false)
						end

						if distance2 < Config.Cars.Markers.Delete.x then
							PrivateGarage = false
							isInMarker, this_Garage, currentZone = true, v, 'car_store_point'
						end
					end
				end
			end

			for k,v in pairs(Config.CarPounds) do
				local distance = #(playerCoords - v.Marker)

				if distance < Config.Main.DrawDistance then
					letSleep = false

					if Config.Cars.Markers.Pounds.Type ~= -1 then
						DrawMarker(Config.Cars.Markers.Pounds.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Cars.Markers.Pounds.x, Config.Cars.Markers.Pounds.y, Config.Cars.Markers.Pounds.z, Config.Cars.Markers.Pounds.r, Config.Cars.Markers.Pounds.g, Config.Cars.Markers.Pounds.b, 100, false, true, 2, true, nil, nil, false)
					end

					if distance < Config.Cars.Markers.Pounds.x then
						PrivateGarage = false
						isInMarker, this_Garage, currentZone = true, v, 'car_pound_point'
					end
				end
			end
		end

		if Config.Pvt.Garages then
			for k,v in pairs(Config.PrivateCarGarages) do
				if not v.Private or has_value(userProperties, v.Private) then
					local distance = #(playerCoords - v.Marker)
					local distance2 = #(playerCoords - v.Deleter)

					if distance < Config.Main.DrawDistance then
						letSleep = false

						if Config.Pvt.Markers.Points.Type ~= -1 then
							DrawMarker(Config.Pvt.Markers.Points.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Pvt.Markers.Points.x, Config.Pvt.Markers.Points.y, Config.Pvt.Markers.Points.z, Config.Pvt.Markers.Points.r, Config.Pvt.Markers.Points.g, Config.Pvt.Markers.Points.b, 100, false, true, 2, true, nil, nil, false)
						end

						if distance < Config.Pvt.Markers.Points.x then
							PrivateGarage = true
							isInMarker, this_Garage, currentZone = true, v, 'car_garage_point'
						end
					end

					if distance2 < Config.Main.DrawDistance then
						letSleep = false

						if Config.Pvt.Markers.Delete.Type ~= -1 then
							DrawMarker(Config.Pvt.Markers.Delete.Type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Pvt.Markers.Delete.x, Config.Pvt.Markers.Delete.y, Config.Pvt.Markers.Delete.z, Config.Pvt.Markers.Delete.r, Config.Pvt.Markers.Delete.g, Config.Pvt.Markers.Delete.b, 100, false, true, 2, true, nil, nil, false)
						end

						if distance2 < Config.Pvt.Markers.Delete.x then
							PrivateGarage = true
							isInMarker, this_Garage, currentZone = true, v, 'car_store_point'
						end
					end
				end
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker, LastZone = true, currentZone
			LastZone = currentZone
			TriggerEvent('esx_advancedgarage:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_advancedgarage:hasExitedMarker', LastZone)
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function(); while not ConfigReady do; Citizen.Wait(1000); end
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local playerVeh = GetVehiclePedIsIn(playerPed, false)
		local model = GetEntityModel(playerVeh)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if cooldown <= 0 then 
					if CurrentAction == 'ambulance_garage_point' then
						if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
							ListOwnedAmbulanceMenu()
						else
							ESX.ShowNotification(_U('must_ambulance'))
						end
					elseif CurrentAction == 'ambulance_store_point' then
						if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
							if IsThisModelACar(model) or IsThisModelABicycle(model) or IsThisModelABike(model) or IsThisModelAHeli(model) then
								if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
									StoreOwnedAmbulanceMenu()
								else
									ESX.ShowNotification(_U('driver_seat'))
								end
							else
								ESX.ShowNotification(_U('not_correct_veh'))
							end
						else
							ESX.ShowNotification(_U('must_ambulance'))
						end
					elseif CurrentAction == 'ambulance_pound_point' then
						if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
							ReturnOwnedAmbulanceMenu()
						else
							ESX.ShowNotification(_U('must_ambulance'))
						end
					elseif CurrentAction == 'police_garage_point' then
						if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
							ListOwnedPoliceMenu()
						else
							ESX.ShowNotification(_U('must_police'))
						end
					elseif CurrentAction == 'police_store_point' then
						if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
							if IsThisModelACar(model) or IsThisModelABicycle(model) or IsThisModelABike(model) or IsThisModelAHeli(model) then
								if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
									StoreOwnedPoliceMenu()
								else
									ESX.ShowNotification(_U('driver_seat'))
								end
							else
								ESX.ShowNotification(_U('not_correct_veh'))
							end
						else
							ESX.ShowNotification(_U('must_police'))
						end
					elseif CurrentAction == 'police_pound_point' then
						if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
							ReturnOwnedPoliceMenu()
						else
							ESX.ShowNotification(_U('must_police'))
						end

					---------------------------
					elseif CurrentAction == 'agent_garage_point' then
						if ESX.PlayerData.job and ESX.PlayerData.job.name == 'agent' then
							ListOwnedagentMenu()
						else
							ESX.ShowNotification(_U('must_agent'))
						end
					elseif CurrentAction == 'agent_store_point' then
						if ESX.PlayerData.job and ESX.PlayerData.job.name == 'agent' then
							if IsThisModelACar(model) or IsThisModelABicycle(model) or IsThisModelABike(model) or IsThisModelAHeli(model) then
								if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
									StoreOwnedagentMenu()
								else
									ESX.ShowNotification(_U('driver_seat'))
								end
							else
								ESX.ShowNotification(_U('not_correct_veh'))
							end
						else
							ESX.ShowNotification(_U('must_agent'))
						end
					elseif CurrentAction == 'agent_pound_point' then
						if ESX.PlayerData.job and ESX.PlayerData.job.name == 'agent' then
							ReturnOwnedagentMenu()
						else
							ESX.ShowNotification(_U('must_agent'))
						end
											---------------------------
					elseif CurrentAction == 'admin_garage_point' then
						if ESX.PlayerData.job and ESX.PlayerData.job.name == 'admin' then
							ListOwnedAdminMenu()
						else
							ESX.ShowNotification(_U('must_admin'))
						end
					elseif CurrentAction == 'admin_store_point' then
						if ESX.PlayerData.job and ESX.PlayerData.job.name == 'admin' then
							if IsThisModelACar(model) or IsThisModelABicycle(model) or IsThisModelABike(model) or IsThisModelAHeli(model) then
								if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
									StoreOwnedAdminMenu()
								else
									ESX.ShowNotification(_U('driver_seat'))
								end
							else
								ESX.ShowNotification(_U('not_correct_veh'))
							end
						else
							ESX.ShowNotification(_U('must_admin'))
						end
					elseif CurrentAction == 'admin_pound_point' then
						if ESX.PlayerData.job and ESX.PlayerData.job.name == 'admin' then
							ReturnOwnedAdminMenu()
						else
							ESX.ShowNotification(_U('must_admin'))
						end
						-------------------------------------------
						
					elseif CurrentAction == 'mechanic_garage_point' then
						if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
							ListOwnedMechanicMenu()
						else
							ESX.ShowNotification(_U('must_mechanic'))
						end
					elseif CurrentAction == 'mechanic_store_point' then
						if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
							if IsThisModelACar(model) or IsThisModelABicycle(model) or IsThisModelABike(model) or IsThisModelAHeli(model) then
								if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
									StoreOwnedMechanicMenu()
								else
									ESX.ShowNotification(_U('driver_seat'))
								end
							else
								ESX.ShowNotification(_U('not_correct_veh'))
							end
						else
							ESX.ShowNotification(_U('must_mechanic'))
						end
					elseif CurrentAction == 'mechanic_pound_point' then
						if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
							ReturnOwnedMechanicMenu()
						else
							ESX.ShowNotification(_U('must_mechanic'))
						end
					elseif CurrentAction == 'aircraft_garage_point' then
						--ListOwnedAircraftsMenu()
						ESX.TriggerServerCallback('esx_license:checkLicense', function(hasdriverLicense)
							if hasdriverLicense then
								ListOwnedAircraftsMenu()
							else
								ESX.ShowNotification('<font color=red>أنت لاتحمل رخصة طيران</font>')
							end
						end, GetPlayerServerId(PlayerId()), 'drive_aircraft')
					elseif CurrentAction == 'aircraft_store_point' then
						if IsThisModelAPlane(model) then
							if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
								--StoreOwnedAircraftsMenu()
								ESX.TriggerServerCallback('esx_license:checkLicense', function(hasdriverLicense)
									if hasdriverLicense then
										StoreOwnedAircraftsMenu()
									else
										ESX.ShowNotification('<font color=red>أنت لاتحمل رخصة طيران</font>')
									end
								end, GetPlayerServerId(PlayerId()), 'drive_aircraft')
							else
								ESX.ShowNotification(_U('driver_seat'))
							end
						else
							ESX.ShowNotification(_U('not_correct_veh'))
						end
					elseif CurrentAction == 'aircraft_pound_point' then
						--ReturnOwnedAircraftsMenu()
						ESX.TriggerServerCallback('esx_license:checkLicense', function(hasdriverLicense)
							if hasdriverLicense then
								ReturnOwnedAircraftsMenu()
							else
								ESX.ShowNotification('<font color=red>أنت لاتحمل رخصة طيران</font>')
							end
						end, GetPlayerServerId(PlayerId()), 'drive_aircraft')

					elseif CurrentAction == 'helicopter_garage_point' then
						--ListOwnedHelicoptersMenu()
						ESX.TriggerServerCallback('esx_license:checkLicense', function(hasdriverLicense)
							if hasdriverLicense then
								ListOwnedHelicoptersMenu()
							else
								ESX.ShowNotification('<font color=red>أنت لاتحمل رخصة طيران</font>')
							end
						end, GetPlayerServerId(PlayerId()), 'drive_aircraft')
					elseif CurrentAction == 'helicopter_store_point' then
						if IsThisModelAHeli(model) then
							if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
								--StoreOwnedHelicoptersMenu()
								ESX.TriggerServerCallback('esx_license:checkLicense', function(hasdriverLicense)
									if hasdriverLicense then
										StoreOwnedHelicoptersMenu()
									else
										ESX.ShowNotification('<font color=red>أنت لاتحمل رخصة طيران</font>')
									end
								end, GetPlayerServerId(PlayerId()), 'drive_aircraft')
							else
								ESX.ShowNotification(_U('driver_seat'))
							end
						else
							ESX.ShowNotification(_U('not_correct_veh'))
						end
					elseif CurrentAction == 'helicopter_pound_point' then
						--ReturnOwnedHelicoptersMenu()
						ESX.TriggerServerCallback('esx_license:checkLicense', function(hasdriverLicense)
							if hasdriverLicense then
								ReturnOwnedHelicoptersMenu()
							else
								ESX.ShowNotification('<font color=red>أنت لاتحمل رخصة طيران</font>')
							end
						end, GetPlayerServerId(PlayerId()), 'drive_aircraft')


					elseif CurrentAction == 'boat_garage_point' then
						--ListOwnedBoatsMenu()
						ESX.TriggerServerCallback('esx_license:checkLicense', function(hasdriverLicense)
							if hasdriverLicense then
								ListOwnedBoatsMenu()
							else
								ESX.ShowNotification('<font color=red>أنت لاتحمل رخصة قارب</font>')
							end
						end, GetPlayerServerId(PlayerId()), 'drive_boat')
					elseif CurrentAction == 'boat_store_point' then
						if IsThisModelABoat(model) then
							if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
								--StoreOwnedBoatsMenu()
								ESX.TriggerServerCallback('esx_license:checkLicense', function(hasdriverLicense)
									if hasdriverLicense then
										StoreOwnedBoatsMenu()
									else
										ESX.ShowNotification('<font color=red>أنت لاتحمل رخصة قارب</font>')
									end
								end, GetPlayerServerId(PlayerId()), 'drive_boat')
							else
								ESX.ShowNotification(_U('driver_seat'))
							end
						else
							ESX.ShowNotification(_U('not_correct_veh'))
						end
					elseif CurrentAction == 'boat_pound_point' then
						--ReturnOwnedBoatsMenu()
						ESX.TriggerServerCallback('esx_license:checkLicense', function(hasdriverLicense)
							if hasdriverLicense then
								ReturnOwnedBoatsMenu()
							else
								ESX.ShowNotification('<font color=red>أنت لاتحمل رخصة قارب</font>')
							end
						end, GetPlayerServerId(PlayerId()), 'drive_boat')
					elseif CurrentAction == 'truck_garage_point' then
						--ListOwnedTrucksMenu()
						ESX.TriggerServerCallback('esx_license:checkLicense', function(hasdriverLicense)
							if hasdriverLicense then
								ListOwnedTrucksMenu()
							else
								ESX.ShowNotification('<font color=red>أنت لاتحمل رخصة شاحنات</font>')
							end
						end, GetPlayerServerId(PlayerId()), 'drive_truck')
					elseif CurrentAction == 'truck_store_point' then
						if IsThisModelACar(model) then
							if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
								--StoreOwnedTrucksMenu()
								ESX.TriggerServerCallback('esx_license:checkLicense', function(hasdriverLicense)
									if hasdriverLicense then
										StoreOwnedTrucksMenu()
									else
										ESX.ShowNotification('<font color=red>أنت لاتحمل رخصة شاحنات</font>')
									end
								end, GetPlayerServerId(PlayerId()), 'drive_truck')
							else
								ESX.ShowNotification(_U('driver_seat'))
							end
						else
							ESX.ShowNotification(_U('not_correct_veh'))
						end
					elseif CurrentAction == 'truck_pound_point' then
						--ReturnOwnedTrucksMenu()
						ESX.TriggerServerCallback('esx_license:checkLicense', function(hasdriverLicense)
							if hasdriverLicense then
								ReturnOwnedTrucksMenu()
							else
								ESX.ShowNotification('<font color=red>أنت لاتحمل رخصة شاحنات</font>')
							end
						end, GetPlayerServerId(PlayerId()), 'drive_truck')	
					elseif CurrentAction == 'car_garage_point' then
						--ListOwnedCarsMenu()
						ESX.TriggerServerCallback('esx_license:checkLicense', function(hasdriverLicense)
							if hasdriverLicense then
								ListOwnedCarsMenu()
							else
								ESX.ShowNotification('<font color=red>أنت لاتحمل رخصة قيادة</font>')
							end
						end, GetPlayerServerId(PlayerId()), 'drive')
					elseif CurrentAction == 'car_store_point' then
						if IsThisModelACar(model) or IsThisModelABicycle(model) or IsThisModelABike(model) or IsThisModelAQuadbike(model) then
							if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
								--StoreOwnedCarsMenu()
								ESX.TriggerServerCallback('esx_license:checkLicense', function(hasdriverLicense)
									if hasdriverLicense then
										StoreOwnedCarsMenu()
									else
										ESX.ShowNotification('<font color=red>أنت لاتحمل رخصة قيادة</font>')
									end
								end, GetPlayerServerId(PlayerId()), 'drive')
							else
								ESX.ShowNotification(_U('driver_seat'))
							end
						else
							ESX.ShowNotification(_U('not_correct_veh'))
						end
					elseif CurrentAction == 'car_pound_point' then
						--ReturnOwnedCarsMenu()
						ESX.TriggerServerCallback('esx_license:checkLicense', function(hasdriverLicense)
							if hasdriverLicense then
								ReturnOwnedCarsMenu()
							else
								ESX.ShowNotification('<font color=red>أنت لاتحمل رخصة قيادة</font>')
							end
						end, GetPlayerServerId(PlayerId()), 'drive')
					end
					cooldown = 15
				else
					ESX.ShowNotification('<font color=red> عليك الانتظار </font><font color=orange>'..cooldown..'</font> ثانية ')
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)
