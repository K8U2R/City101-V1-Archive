local HasAlreadyEnteredMarker, LastZone = false, nil
local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local CurrentAction_wesam_2, CurrentActionMsg_wesam_2, CurrentActionData_wesam_2 = nil, '', {}
local CurrentlyTowedVehicle, Blips, NPCOnJob, NPCTargetTowable, NPCTargetTowableZone = nil, {}, false, nil, nil
local NPCHasSpawnedTowable, NPCLastCancel, NPCHasBeenNextToTowable, NPCTargetDeleterZone = false, GetGameTimer() - 5 * 60000, false, false
local isDead, isBusy = false, false
local isOnDuty = false
local list_car_owner = {}
local blips = {}
local zones = {
	{x = 410.545, y = -1637.881, z = 29.27991, dist = 25.0}, -- حجز لوس
	{x = 274.6334, y = -2500.2515, z = 6.4403, dist = 15.0}, -- الحجز الي عند ميناء مدينة 101 الغربي
	{x = -363.3746, y = 6071.1279, z = 31.4989, dist = 15.0}, -- حجز لوليتو
	{x = 1632.2532, y = 3790.0105, z = 34.6951, dist = 15.0}, -- حجز ساندي
}
local bedController = {vector3(-2.5, -3.8, -1.0), vector3(0.0, 0.0, 0.0)}
local notifIn = false
local notifOut = false
local closestZone = 1
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

	TriggerServerEvent("esx_wesam:getListCarsOwnedwesam")
	
	refreshblipHjzCar()

end)

local Cooldown_count = 0
	
local function Cooldown(sec)
	CreateThread(function()
		Cooldown_count = sec
		while Cooldown_count ~= 0 do
			Cooldown_count = Cooldown_count - 1
			Wait(1000)
		end	
		Cooldown_count = 0
	end)	
end

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		local playerPed = GetPlayerPed(-1)
		local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
		local minDistance = 100000
		for i = 1, #zones, 1 do
			dist = Vdist(zones[i].x, zones[i].y, zones[i].z, x, y, z)
			if dist < minDistance then
				minDistance = dist
				closestZone = i
			end
		end
		Citizen.Wait(4000)
	end
end)

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		Citizen.Wait(0)
		local player = GetPlayerPed(-1)
		local x,y,z = table.unpack(GetEntityCoords(player, true))
		local dist = Vdist(zones[closestZone].x, zones[closestZone].y, zones[closestZone].z, x, y, z)
	
		if dist <= zones[closestZone].dist then
			if not notifIn then
				TriggerEvent('esx_misc:updatePromotionStatus', 'HjzCar', true)
				notifIn = true
				notifOut = false
			end
		else
			if not notifOut then
				TriggerEvent('esx_misc:updatePromotionStatus', 'HjzCar', false)
				notifOut = true
				notifIn = false
			end
		end
	end
end)

local is_in = nil
local HasAlreadyEnteredMarker_wesam_2 = false
local LastZone_wesam_2 = nil
function isTargetVehicleATrailer(modelHash)
	if GetVehicleClassFromName(modelHash) == 11 then
		return true
	else
		return false
	end
end

local xoff = 0.0
local yoff = 0.0
local zoff = 0.0

function isVehicleATowTruck(vehicle)
	local isValid = false
	for model,posOffset in pairs(Config.allowedTowModels) do
		if IsVehicleModel(vehicle, model) then
			xoff = posOffset.x
			yoff = posOffset.y
			zoff = posOffset.z
			isValid = true
			break
		end
	end
	return isValid
end


AddEventHandler('esx_wesam:hasEnteredMarker2', function(zone)
	if zone == "car_wesam" then
		CurrentAction_wesam_2     = 'car_wesam'
		CurrentActionMsg_wesam_2  = _U('car_wesam')
		CurrentActionData_wesam_2 = {}
	end
end)

AddEventHandler('esx_wesam:hasExitedMarker2', function(zone)
	CurrentAction_wesam_2 = nil
	ESX.UI.Menu.CloseAll()
end)

function all_trim(s)
	return s:match( "^%s*(.-)%s*$" )
 end

Citizen.CreateThread(function();

	while true do

		if ESX.PlayerData.job then

			local coords_2 = GetEntityCoords(PlayerPedId())
			local isInMarker_wesam_2  = false
			local currentZone_wesam_2 = nil
			for k,v in pairs(Config.vehcar) do
				local playerPed = PlayerPedId()
				local PlayerLocation = GetEntityCoords(playerPed)
				local veh, distance  = ESX.Game.GetClosestVehicle(PlayerLocation)
				local is_true = false
				if DoesEntityExist(veh) then
					local plate = GetVehicleNumberPlateText(veh)
					if list_car_owner[ESX.PlayerData.identifier] then
						for k1,v1 in pairs(list_car_owner) do
							for l,r in pairs(list_car_owner[k1]) do
								local json_d = json.decode(l)
								if ESX.PlayerData.identifier == k1 then
									if all_trim(plate) == all_trim(json_d["plate"]) then
										local blip_veh_car = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 7.0, v, 70)
										local coords_2 = GetOffsetFromEntityInWorldCoords(blip_veh_car, 1.2, -0.95, -1.0)
										local rightDir, fwdDir, upDir, pos = GetEntityMatrix(blip_veh_car)
										local data = bedController
										local x = pos.x + (fwdDir.x * data[1].x) + (rightDir.x * data[1].y) + (upDir.x * data[1].z)
										local y = pos.y + (fwdDir.y * data[1].x) + (rightDir.y * data[1].y) + (upDir.y * data[1].z)
										local z = pos.z + (fwdDir.z * data[1].x) + (rightDir.z * data[1].y) + (upDir.z * data[1].z)
										local controllerPos = vector3(x, y, z + 0.50)
										coords_2 = vector3(coords_2.x-3, coords_2.y+2, coords_2.z + 0.30)
										local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), controllerPos, true)
										if distance <= 7.0 then
											DrawMarker(23, controllerPos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.2, 255, 0, 0, 200, false, true, 2, false, false, false, false)
										end
										if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), controllerPos, true) <= 1.5 then
											isInMarker_wesam_2 = true
											currentZone_wesam_2 = "car_wesam"
										end
							
										if (isInMarker_wesam_2 and not HasAlreadyEnteredMarker_wesam_2) or (isInMarker_wesam_2 and LastZone_wesam_2 ~= currentZone_wesam_2) then
											HasAlreadyEnteredMarker_wesam_2 = true
											LastZone_wesam_2 = currentZone_wesam_2
											TriggerEvent('esx_wesam:hasEnteredMarker2', currentZone_wesam_2)
										end

										if not isInMarker_wesam_2 and HasAlreadyEnteredMarker_wesam_2 then
											HasAlreadyEnteredMarker_wesam_2 = false
											TriggerEvent('esx_wesam:hasExitedMarker2', LastZone_wesam_2)
										end
									end
								end
							end
						end
					end
				end

			end
	  
	  	end

	  	Citizen.Wait(0)

	end
end)

ObjectInFront = function(ped, pos)
	local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.5, 0.0)
	local car = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 30, ped, 0)
	local _, _, _, _, result = GetRaycastResult(car)
	return result
end

RegisterNetEvent('esx_mechanicjob:Start_repair')
AddEventHandler('esx_mechanicjob:Start_repair', function(ped, coords, veh)
	local dict
	local model = 'prop_carjack'
	local offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, -2.0, 0.0)
	local headin = GetEntityHeading(ped)
	local vehicle   = ESX.Game.GetVehicleInDirection()
	local msg = '<font size=5 color=white>جاري إصلاح المركبة'
	FreezeEntityPosition(veh, true)
	TriggerEvent('esx_misc:hidehud', true)
	local vehpos = GetEntityCoords(veh)
	dict = 'mp_car_bomb'
	RequestAnimDict(dict)
	RequestModel(model)
	while not HasAnimDictLoaded(dict) or not HasModelLoaded(model) do
		Citizen.Wait(1)
	end
	local vehjack = CreateObject(GetHashKey(model), vehpos.x, vehpos.y, vehpos.z - 0.5, true, true, true)
	disableAllControlActions = true	
	Citizen.CreateThread(function()
	while disableAllControlActions do
	Citizen.Wait(0)
	DisableAllControlActions(0)
	EnableControlAction(0, 249, true)
	EnableControlAction(0, 311, true)
	EnableControlAction(0, 1, true)
	EnableControlAction(0, 2, true)
	 end
	end)
	TriggerEvent('pogressBar:drawBar', 9250, msg)
	AttachEntityToEntity(vehjack, veh, 0, 0.0, 0.0, -1.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1250, 1, 0.0, 1, 1)
	Citizen.Wait(1250)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.01, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.025, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.05, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.1, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.15, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.2, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.3, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	dict = 'move_crawl'
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.4, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.5, true, true, true)
	SetEntityCollision(veh, false, false)
	TaskPedSlideToCoord(ped, offset, headin, 1000)
	Citizen.Wait(1000)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
	TriggerEvent('pogressBar:drawBar', 11000, msg)
	TaskPlayAnimAdvanced(ped, dict, 'onback_bwd', coords, 0.0, 0.0, headin - 180, 1.0, 0.5, 3000, 1, 0.0, 1, 1)
	dict = 'amb@world_human_vehicle_mechanic@male@base'
	Citizen.Wait(3000)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
	TaskPlayAnim(ped, dict, 'base', 8.0, -8.0, 5000, 1, 0, false, false, false)
	dict = 'move_crawl'
	Citizen.Wait(5000)
	local coords2 = GetEntityCoords(ped)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
	TaskPlayAnimAdvanced(ped, dict, 'onback_fwd', coords2, 0.0, 0.0, headin - 180, 1.0, 0.5, 2000, 1, 0.0, 1, 1)
	Citizen.Wait(3000)
	dict = 'mp_car_bomb'
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
	SetVehicleFixed(vehicle)
	SetVehicleDeformationFixed(vehicle)
	SetVehicleUndriveable(vehicle, false)
	SetVehicleEngineOn(vehicle, true, true)
	ClearPedTasksImmediately(playerPed)
	TriggerEvent('pogressBar:drawBar', 8250, msg)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1250, 1, 0.0, 1, 1)
	Citizen.Wait(1250)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.4, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.3, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.2, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.15, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.1, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.05, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.025, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	dict = 'move_crawl'
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.01, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z, true, true, true)
	FreezeEntityPosition(veh, false)
	DeleteObject(vehjack)
	SetEntityCollision(veh, true, true)
	disableAllControlActions = false
	ESX.ShowNotification('تم إصلاح المركبة')
	TriggerEvent('esx_misc:hidehud', false)
end)

RegisterNetEvent('esx_mechanicjob:repairveh')
AddEventHandler('esx_mechanicjob:repairveh', function()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local veh = ObjectInFront(ped, coords)
	if DoesEntityExist(veh) then
		if IsEntityAVehicle(veh) then
			if Cooldown_count == 0 then 
				ESX.UI.Menu.CloseAll()
				Cooldown(75)
				SetEntityAsMissionEntity(veh, true, true)
				TriggerServerEvent('esx_mechanicjob:RemoveItem_repair', ped, coords, veh)
			else
				ESX.ShowNotification('<font color=red>يجب الأنتظار</font>. <font color=orange>'..Cooldown_count..' ثانية</font> لإصلاح المركبة')
			end
		else
			ESX.ShowNotification('لاتوجد مركبة بالقرب منك')
		end
	end
end)

function SelectRandomTowable()
	local index = GetRandomIntInRange(1,  #Config.Towables)

	for k,v in pairs(Config.Zones) do
		if v.Pos.x == Config.Towables[index].x and v.Pos.y == Config.Towables[index].y and v.Pos.z == Config.Towables[index].z then
			return k
		end
	end
end

function StartNPCJob()
	NPCOnJob = true

	NPCTargetTowableZone = SelectRandomTowable()
	local zone = Config.Zones[NPCTargetTowableZone]

	Blips['NPCTargetTowableZone'] = AddBlipForCoord(zone.Pos.x,  zone.Pos.y,  zone.Pos.z)
	SetBlipRoute(Blips['NPCTargetTowableZone'], true)

	ESX.ShowNotification(_U('drive_to_indicated'))
end

function StopNPCJob(cancel)
	if Blips['NPCTargetTowableZone'] then
		RemoveBlip(Blips['NPCTargetTowableZone'])
		Blips['NPCTargetTowableZone'] = nil
	end

	if Blips['NPCDelivery'] then
		RemoveBlip(Blips['NPCDelivery'])
		Blips['NPCDelivery'] = nil
	end

	Config.Zones.VehicleDelivery.Type = -1

	NPCOnJob = false
	NPCTargetTowable  = nil
	NPCTargetTowableZone = nil
	NPCHasSpawnedTowable = false
	NPCHasBeenNextToTowable = false

	if cancel then
		ESX.ShowNotification(_U('mission_canceled'))
	else
		--TriggerServerEvent('esx_mechanicjob:onNPCJobCompleted')
	end
end

function OpenMechanicActionsMenu()
	local elements = {
		{label = _U('work_wear'),      value = 'cloakroom'},
		{label = _U('civ_wear'),       value = 'cloakroom2'}
		--{label = _U('deposit_stock'),  value = 'put_stock'}
	}

	if Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'bosstwo' then
		--table.insert(elements, {label = _U('withdraw_stock'), value = 'get_stock'})
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})		
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_actions', {
		title    = _U('mechanic'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'vehicle_list' then
			if Config.EnableSocietyOwnedVehicles then

				local elements = {}

				ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)
					for i=1, #vehicles, 1 do
						table.insert(elements, {
							label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']',
							value = vehicles[i]
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner', {
						title    = _U('service_vehicle'),
						align    = 'top-left',
						elements = elements
					}, function(data, menu)
						menu.close()
						local vehicleProps = data.current.value

						ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint.Pos, 270.0, function(vehicle)
							ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
							local playerPed = PlayerPedId()
							TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
						end)

						TriggerServerEvent('esx_society:removeVehicleFromGarage', 'mechanic', vehicleProps)
					end, function(data, menu)
						menu.close()
					end)
				end, 'mechanic')

			else

				local elements = {
					{label = _U('flat_bed'),  value = 'flatbed'},
					{label = _U('tow_truck'), value = 'towtruck2'}
				}

				if Config.EnablePlayerManagement and ESX.PlayerData.job and (ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'chief' or ESX.PlayerData.job.grade_name == 'experimente') then
					table.insert(elements, {label = 'SlamVan', value = 'slamvan3'})
				end

				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle', {
					title    = _U('service_vehicle'),
					align    = 'top-left',
					elements = elements
				}, function(data, menu)
					if Config.MaxInService == -1 then
						ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 90.0, function(vehicle)
							local playerPed = PlayerPedId()
							TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
						local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
						TriggerServerEvent('esx_vehicleshop:setVehicleOwnedJob', vehicleProps, "mechanic")							
						end)
					else
						ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
							ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 90.0, function(vehicle)
								local playerPed = PlayerPedId()
								TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
							end)
						end, 'mechanic')
					end

					menu.close()
				end, function(data, menu)
					menu.close()
					OpenMechanicActionsMenu()
				end)

			end
		elseif data.current.value == 'cloakroom' then
			menu.close()
			isOnDuty = true -- addon service
			ESX.ShowNotification(_U('service_in'))
			TriggerServerEvent('esx_mechanic:sendToAllPlayersNotficiton', ESX.PlayerData.job.grade_label)
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
				else
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
				end
			end)
		elseif data.current.value == 'cloakroom2' then
			menu.close()
			isOnDuty = false -- addon service
			ESX.ShowNotification(_U('service_out'))
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		elseif data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'mechanic', function(data, menu)
				menu.close()
			end)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'mechanic_actions_menu'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
	end)
end



function OpenMechanicHarvestMenu()
	if Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.grade_name ~= 'recrue' then
		local elements = {
			{label = _U('gas_can'), value = 'gaz_bottle'},
			{label = _U('repair_tools'), value = 'fix_tool'},
			--{label = _U('body_work_tools'), value = 'caro_tool'}
		}

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_harvest', {
			title    = 'التصنيع',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			menu.close()

			if data.current.value == 'gaz_bottle' then
				TriggerServerEvent('esx_mecanojob:startHarvest')
			elseif data.current.value == 'fix_tool' then
				TriggerServerEvent('esx_mecanojob:startHarvest2')
			elseif data.current.value == 'caro_tool' then
				TriggerServerEvent('esx_mecanojob:startHarvest3')
			end
		end, function(data, menu)
			menu.close()
			CurrentAction     = 'mechanic_harvest_menu'
			CurrentActionMsg  = _U('harvest_menu')
			CurrentActionData = {}
		end)
	else
		ESX.ShowNotification(_U('not_experienced_enough'))
	end
end

function OpenMechanicCraftMenu()
	if Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.grade_name ~= 'recrue' then
		local elements = {
			{label = _U('repair_kit'), value = 'fix_kit'},
			{label = _U('body_kit'),   value = 'caro_kit'}
		}

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_craft', {
			title    = _U('craft'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			menu.close()

			if data.current.value == 'blow_pipe' then
				TriggerServerEvent('esx_mechanicjob:startCraft')
			elseif data.current.value == 'fix_kit' then
				TriggerServerEvent('esx_mechanicjob:startCraft2')
			elseif data.current.value == 'caro_kit' then
				TriggerServerEvent('esx_mechanicjob:startCraft3')
			end
		end, function(data, menu)
			menu.close()

			CurrentAction     = 'mechanic_craft_menu'
			CurrentActionMsg  = _U('craft_menu')
			CurrentActionData = {}
		end)
	else
		ESX.ShowNotification(_U('not_experienced_enough'))
	end
end

function OpenVehicleInfosMenu(vehicleData)

	ESX.TriggerServerCallback('esx_mechanicjob:getVehicleInfos', function(retrivedInfo)

		local elements = {}

		table.insert(elements, {label = _U('plate', retrivedInfo.plate), value = nil})

		if retrivedInfo.owner == nil then
			table.insert(elements, {label = _U('owner_unknown'), value = nil})
		else
			table.insert(elements, {label = _U('owner', retrivedInfo.owner), value = nil})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos',
		{
			title    = 'معلومات المركبة',
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)

	end, vehicleData.plate)

end

function OpenMobileMechanicActionsMenu()
	ESX.UI.Menu.CloseAll()
	local elements = {
		{label = "اظهار كم شخص من الوظائف المعتمده متصل ✔️", value = 'get_players'},
		{label = _U('billing'),       value = 'billing'},
		{label = _U('vehicle_interaction'),	value = 'vehicle_interaction'},
		{label = _U('hijack'),        value = 'hijack_vehicle'},
		{label = _U('repair'),        value = 'fix_vehicle'},
		{label = 'سمكرة',        		value = 'caro_vehicle'},
		{label = _U('clean'),         value = 'clean_vehicle'},
		{label = _U('imp_veh'),       value = 'del_vehicle'},
		{label = _U('place_objects'), value = 'object_spawner'},
		{label = _U('extra'), 			value = 'OpenVehicleExtrasMenu'},
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_mechanic_actions', {
		title    = _U('mechanic'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if isBusy then
			return
		end
		if data.current.value == "get_players" then
			local players_in_none = false
			local em = {}
			ESX.TriggerServerCallback("esx_adminjob:getPlayerverify", function(players)
				for i=1, #players.data, 1 do
					players_in_none = true
				end
				if not players_in_none then
					table.insert(em, {label = "لايوجد احد متصل من اي وظيفة معتمده"})
				else
					table.insert(em, {label = "<font color=#0080FF>الشرطة</font> <font color=white>:</font> [<font color=#0080FF>" .. players.counter_police .. "</font><font color=white>]</font>"})
					table.insert(em, {label = "<font color=#00FF00>حرس الحدود</font> <font color=white>:</font> [<font color=#00FF00>" .. players.counter_agent .. "</font><font color=white>]</font>"})
					table.insert(em, {label = "<font color=#EB3C3C>الهلال الأحمر</font> <font color=white>:</font> [<font color=#EB3C3C>" .. players.counter_ambulance .. "</font><font color=white>]</font>"})
					table.insert(em, {label = "<font color=#606060>كراج الميكانيك</font> <font color=white>:</font> [<font color=#606060>" .. players.counter_mechanic .. "</font><font color=white>]</font>"})
				end
				ESX.UI.Menu.Open("default", GetCurrentResourceName(), 'wesam_get_player', {
					title = "قائمة موظفين المعتمد",
					align = "top-left",
					elements = em
				}, function(data_get_player, menu_get_player)
					--print()
				end, function(data_get_player, menu_get_player)
					menu_get_player.close()
				end)
			end)
		end
		if data.current.value == "get_info_closest_player" then
			local eeee = {}
			local ped222 = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 3.0)
			for k_s,playerNearby_s in ipairs(ped222) do
				ESX.TriggerServerCallback('esx_adminjob:getNameplayer', function(name_player_s)
					table.insert(eeee, {label = name_player_s.name, playerId = name_player_s.id, coords_player = name_player_s.coords_player})
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stretcher_menu3', {
						title		= 'حدد من الشخص',
						align		= 'top-left',
						elements	= eeee
					}, function(data3, menu3)
						menu3.close()
						TriggerEvent("esx_wesam:getInfoPlayerMechanicJob", data3.current.playerId)
					end, function(data3, menu3)
						menu2.close()
				end)
				end, GetPlayerServerId(playerNearby_s))
			end
		end
		if data.current.value == "get_my_info_mechanic_job" then
			TriggerEvent("esx_wesam:getInfoPlayerMechanicJob", GetPlayerServerId(PlayerId()))
		end
		if data.current.value == 'vehicle_interaction' then
			local elements  = {}
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local class = GetVehicleClass(vehicle)
			
			if DoesEntityExist(vehicle) then
				if class ~= 18 then
					local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
					OpenVehicleInfosMenu(vehicleData)
					--ESX.ShowNotification('ﺔﺑﺎﻗﺮﻟﺍ ﻯﺪﻟ ﻡﻼﻌﺘﺳﻻﺍ ﻖﻴﺛﻮﺗ ﻢﺘﻳ')
				else
					ESX.ShowNotification('لايمكن الإستعمال')
				end
			else
				ESX.ShowNotification('لاتوجد مركبة قريبه منك')
			end
		elseif data.current.value == 'billing' then
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
				title = _U('invoice_amount')
			}, function(data, menu)
				local amount = tonumber(data.value)

				if amount == nil or amount < 0 then
					ESX.ShowNotification(_U('amount_invalid'))
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification(_U('no_players_nearby'))
					else
						menu.close()
						billPass = 'a82mKba0bma2'
						TriggerServerEvent('esx_billing:sendKBill_28vn2', billPass, GetPlayerServerId(closestPlayer), 'society_mechanic', _U('mechanic'), amount)
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		elseif data.current.value == 'hijack_vehicle' then
			local playerPed = PlayerPedId()
			local vehicle = ESX.Game.GetVehicleInDirection()
			local coords = GetEntityCoords(playerPed)

			if IsPedSittingInAnyVehicle(playerPed) then
				ESX.ShowNotification(_U('inside_vehicle'))
				return
			end

			if DoesEntityExist(vehicle) then
				isBusy = true
				TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
				Citizen.CreateThread(function()
					Citizen.Wait(10000)

					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)

					ESX.ShowNotification(_U('vehicle_unlocked'))
					isBusy = false
				end)
			else
				ESX.ShowNotification(_U('no_vehicle_nearby'))
			end
	elseif data.current.value == 'fix_vehicle' then
		DoAction('fixkit',15000)
		ESX.UI.Menu.CloseAll()
	elseif data.current.value == 'caro_vehicle' then
		DoAction('carokit',25000)
		ESX.UI.Menu.CloseAll()
		elseif data.current.value == 'clean_vehicle' then
			local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local coords    = GetEntityCoords(playerPed)

			if IsPedSittingInAnyVehicle(playerPed) then
				ESX.ShowNotification(_U('inside_vehicle'))
				return
			end

			if DoesEntityExist(vehicle) then
				isBusy = true
				TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
				Citizen.CreateThread(function()
					Citizen.Wait(10000)

					SetVehicleDirtLevel(vehicle, 0)
					ClearPedTasksImmediately(playerPed)
					TriggerServerEvent('esx_mechanicjob:checkIsSetXpLevelJobsWhiteList2')
					isBusy = false
				end)
			else
				ESX.ShowNotification(_U('no_vehicle_nearby'))
			end
		elseif data.current.value == 'del_vehicle' then
		DoActionImpound(10000)
		
		--[[local playerPed = PlayerPedId()

		if IsPedSittingInAnyVehicle(playerPed) then
			local vehicle = GetVehiclePedIsIn(playerPed, false)

			if GetPedInVehicleSeat(vehicle, -1) == playerPed then
				--ESX.ShowNotification(_U('vehicle_impounded'))
				TriggerEvent('esx_mechanicjob:jobNotifyGeneral', _U('vehicle_impounded'), 'success', 7000, true)
				ESX.Game.DeleteVehicle(vehicle)
				if Config.EnableJobLogs == true then
					TriggerServerEvent('esx_joblogs:AddInLog', "mecano", "del_vehicle", GetPlayerName(PlayerId()))
				end
			else
				--ESX.ShowNotification(_U('must_seat_driver'))
				TriggerEvent('esx_mechanicjob:jobNotifyGeneral', _U('must_seat_driver'), 'error', 7000, true)
			end
		else
			local vehicle = ESX.Game.GetVehicleInDirection()

			if DoesEntityExist(vehicle) then
				--ESX.ShowNotification(_U('vehicle_impounded'))
				TriggerEvent('esx_mechanicjob:jobNotifyGeneral', _U('vehicle_impounded'), 'success', 7000, true)
				ESX.Game.DeleteVehicle(vehicle)
				if Config.EnableJobLogs == true then
					TriggerServerEvent('esx_joblogs:AddInLog', "mecano", "del_vehicle", GetPlayerName(PlayerId()))
				end
			else
				--ESX.ShowNotification(_U('must_near'))
				TriggerEvent('esx_mechanicjob:jobNotifyGeneral', _U('must_near'), 'error', 7000, true)
			end
		end]]
		elseif data.current.value == 'dep_vehicle' then
		elseif data.current.value == 'OpenVehicleExtrasMenu' then
		OpenVehicleExtrasMenu()			
		ESX.ShowNotification('<font color=red>يمنع</font> <font color=orange>إستخدام الاكسترا خارج كراج الميكانيك</font>')
		elseif data.current.value == 'object_spawner' then
			local playerPed = PlayerPedId()

			if IsPedSittingInAnyVehicle(playerPed) then
				ESX.ShowNotification(_U('inside_vehicle'))
				return
			end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_mechanic_actions_spawn', {
			title    = _U('objects'),
			align    = 'top-left',
			elements = {
				{label = _U('roadcone'), 		value = 'prop_roadcone02a'},
				--{label = _U('toolbox'),  		value = 'prop_toolchest_01'},
				--{label = _U('light_high'),		value = 'prop_worklight_01a'},
				--{label = _U('barrier_arrow'),	value = 'prop_mp_arrow_barrier_01'},
			}
		}, function(data2, menu2)
			local model   = data2.current.value
			local coords  = GetEntityCoords(playerPed)
			local forward = GetEntityForwardVector(playerPed)
			local x, y, z = table.unpack(coords + forward * 1.0)

			if model == 'prop_roadcone02a' then
				z = z --  - 2.0
			elseif model == 'prop_toolchest_01' then
				z = z --  - 2.0
			end

			ESX.Game.SpawnObject(model, {
				x = x,
				y = y,
				z = z
			}, function(obj)
				SetEntityHeading(obj, GetEntityHeading(playerPed))
				PlaceObjectOnGroundProperly(obj)
			end)

			end, function(data2, menu2)
				menu2.close()
			end)
		end
	end, function(data, menu)
		menu.close()
	end)
end

RegisterNetEvent('esx_swap:tofunction')
AddEventHandler('esx_swap:tofunction', function()
	DoActionImpound(10000)
end)

function DoActionImpound(waitime)
	if notifIn then
		_disableAllControlActions = true
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
		local found = false
		local NN = nil
		for locationNumber,data in pairs(Config.impound.location) do
			found = true
			NN = locationNumber
		end
		Citizen.CreateThread(function()
			while _disableAllControlActions do
				Citizen.Wait(0)
				DisableAllControlActions(0) --disable all control (comment it if you want to detect how many time key pressed)
			end
		end)
		
		if IsPedSittingInAnyVehicle(playerPed) then
			ESX.ShowNotification(_U('inside_vehicle'))
			return
		end
		
		if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
			local vehicle = nil
		
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 10.0, 0, 71)
			--vehicle = ESX.Game.GetVehicleInDirection()
			
			if DoesEntityExist(vehicle) then
				--------------------------
				ESX.TriggerServerCallback('esx_mechanicjob:canMechanicImpound', function(canImpound)
					if canImpound then					
						TriggerEvent('pogressBar:drawBar', waitime, '<font size=5>حجز المركبة')
						Citizen.Wait(1500)
						TriggerServerEvent('esx_misc3:try2', ESX.Game.GetVehicleProperties(vehicle).plate)
						TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
						Citizen.CreateThread(function()
							Citizen.Wait(waitime-3000)
							--ESX.Game.DeleteVehicle(vehicle)
							AdvancedOnesyncDeleteVehicle(vehicle)
							ClearPedTasksImmediately(playerPed)
							Citizen.Wait(1500)
							_disableAllControlActions = false
							--if Config.EnableJobLogs == true then
								--TriggerServerEvent('esx_joblogs:AddInLog', "mecano", "del_vehicle", GetPlayerName(PlayerId()))
							--end
						end)
					else
						_disableAllControlActions = false
					end
				end, locationNumber, ESX.Game.GetVehicleProperties(vehicle).plate)							
			else
				ESX.ShowNotification(_U('no_vehicle_nearby'))
				_disableAllControlActions = false
			end	
		else
			ESX.ShowNotification(_U('no_vehicle_nearby'))
			_disableAllControlActions = false
		end
	else
		ESX.ShowNotification("يجب ان تكون داخل منطقة حجز مركبات لحجز المركبة")
	end
end

function AdvancedOnesyncDeleteVehicle(vehicle)
	ESX.Game.DeleteVehicle(vehicle)
	
	local entity = vehicle
    carModel = GetEntityModel(entity)
    carName = GetDisplayNameFromVehicleModel(carModel)
    NetworkRequestControlOfEntity(entity)
    
    local timeout = 2000
    while timeout > 0 and not NetworkHasControlOfEntity(entity) do
        Wait(100)
        timeout = timeout - 100
    end

    SetEntityAsMissionEntity(entity, true, true)
    
    local timeout = 2000
    while timeout > 0 and not IsEntityAMissionEntity(entity) do
        Wait(100)
        timeout = timeout - 100
    end

    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
    
    if (DoesEntityExist(entity)) then 
        DeleteEntity(entity)
    end 
end

function DoAction(item,waitime)
	_disableAllControlActions = true
				
	Citizen.CreateThread(function()
		while _disableAllControlActions do
			Citizen.Wait(0)
			DisableAllControlActions(0) --disable all control (comment it if you want to detect how many time key pressed)
		end
	end)
	
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	
	if IsPedSittingInAnyVehicle(playerPed) then
		ESX.ShowNotification(_U('inside_vehicle'))
		return
	end
	
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = nil
	
		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 10.0, 0, 71)
		--vehicle = ESX.Game.GetVehicleInDirection()
		
		if DoesEntityExist(vehicle) then
			--------------------------
			--ESX.TriggerServerCallback('esx_mechanicjob:canMechanicDoAction', function(canRepaire)
				--if canRepaire then
				if Cooldown_count == 0 then
					Cooldown(60)
					exports['progressBars']:startUI(waitime, 'تصليح المركبة')
					SetVehicleDoorOpen(vehicle, 4, false)
					Citizen.Wait(1500)
					if item == 'fixkit' then
						TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
					elseif item == 'carokit' then	
						TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_HAMMERING', 0, true)
					end	
					Citizen.CreateThread(function()
						Citizen.Wait(waitime-3000)
						SetVehicleFixed(vehicle)
						SetVehicleDeformationFixed(vehicle)
						SetVehicleUndriveable(vehicle, false)
						ClearPedTasksImmediately(playerPed)
						Citizen.Wait(1500)
						SetVehicleDoorShut(vehicle, 4, false)
						if item == 'carokit' then
							TriggerServerEvent('esx_mechanicjob:checkIsSetXpLevelJobsWhiteList3')
						elseif item == 'fixkit' then
							TriggerServerEvent('esx_mechanicjob:checkIsSetXpLevelJobsWhiteList')
						end
						_disableAllControlActions = false
					end)
				else
					_disableAllControlActions = false
					ESX.ShowNotification('<font color=red>يجب الأنتظار</font>. <font color=orange>'..Cooldown_count..' ثانية')
				end
			--end,item)
		else
			ESX.ShowNotification(_U('no_vehicle_nearby'))
			_disableAllControlActions = false
		end	
	else
		ESX.ShowNotification(_U('no_vehicle_nearby'))
		_disableAllControlActions = false
	end		
end

function OpenGetStocksMenu()
	ESX.TriggerServerCallback('esx_mechanicjob:getStockItems', function(items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('mechanic_stock'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('invalid_quantity'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_mechanicjob:getStockItem', itemName, count)

					Citizen.Wait(1000)
					OpenGetStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutStocksMenu()
	ESX.TriggerServerCallback('esx_mechanicjob:getPlayerInventory', function(inventory)
		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type  = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('inventory'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('invalid_quantity'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_mechanicjob:putStockItems', itemName, count)

					Citizen.Wait(1000)
					OpenPutStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

RegisterNetEvent('esx_mechanicjob:onHijack')
AddEventHandler('esx_mechanicjob:onHijack', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		local chance = math.random(100)
		local alarm  = math.random(100)

		if DoesEntityExist(vehicle) then
			if alarm <= 33 then
				SetVehicleAlarm(vehicle, true)
				StartVehicleAlarm(vehicle)
			end

			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)

			Citizen.CreateThread(function()
				Citizen.Wait(10000)
				if chance <= 66 then
					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)
					ESX.ShowNotification(_U('veh_unlocked'))
				else
					ESX.ShowNotification(_U('hijack_failed'))
					ClearPedTasksImmediately(playerPed)
				end
			end)
		end
	end
end)

RegisterNetEvent('esx_mechanicjob:onCarokit')
AddEventHandler('esx_mechanicjob:onCarokit', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_HAMMERING', 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(10000)
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				ClearPedTasksImmediately(playerPed)
				ESX.ShowNotification(_U('body_repaired'))
			end)
		end
	end
end)

RegisterNetEvent("esx_mechanicjob:wesam:addvehtolist")
AddEventHandler("esx_mechanicjob:wesam:addvehtolist", function(iden, plate)
	if list_car_owner[iden] then
		if list_car_owner[iden][plate] then
			--list_car_owner[iden][plate] = true
		else
			list_car_owner[iden][plate] = true
		end
	else
		list_car_owner[iden] = {}
		if list_car_owner[iden][plate] then
			--list_car_owner[iden][plate] = true
		else
			list_car_owner[iden][plate] = true
		end
	end
end)

RegisterNetEvent("esx_wesam:setListCarsS")
AddEventHandler("esx_wesam:setListCarsS", function(list)
	list_car_owner = list
end)

RegisterNetEvent('esx_mechanicjob:onFixkit')
AddEventHandler('esx_mechanicjob:onFixkit', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(20000)
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				SetVehicleUndriveable(vehicle, false)
				ClearPedTasksImmediately(playerPed)
				ESX.ShowNotification(_U('veh_repaired'))
			end)
		end
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	isOnDuty = false
	refreshblipHjzCar()
end)

AddEventHandler('esx_mechanicjob:hasEnteredMarker', function(zone)
	if zone == 'NPCJobTargetTowable' then
	elseif zone =='VehicleDelivery' then
		NPCTargetDeleterZone = true
	elseif zone == 'MechanicActions' or zone == 'MechanicSandyShores' or zone == 'MechanicLosSantos' then
		CurrentAction     = 'mechanic_actions_menu'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
	elseif zone == 'MechanicCraftActions' or zone == 'MechanicCraftSandyShores' or zone == 'MechanicCraftLosSantos' then
		CurrentAction     = 'mechanic_harvest_menu'
		CurrentActionMsg  = _U('harvest_menu')
		CurrentActionData = {}
	elseif zone == 'MechanicCraftActions2' or zone == 'MechanicCraftSandyShores2' or zone == 'MechanicCraftLosSantos2' then
		CurrentAction     = 'mechanic_harvest_menu'
		CurrentActionMsg  = _U('harvest_menu')
		CurrentActionData = {}
	elseif zone == 'Craft' or zone == 'CraftTwo' or zone == 'CraftThree' or zone == 'CraftFour' or zone == 'CraftFive' then
		CurrentAction     = 'mechanic_craft_menu'
		CurrentActionMsg  = _U('craft_menu')
		CurrentActionData = {}
	elseif zone == 'VehicleDeleter' then
		local playerPed = PlayerPedId()
		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed,  false)
			CurrentAction     = 'delete_vehicle'
			CurrentActionMsg  = _U('veh_stored')
			CurrentActionData = {vehicle = vehicle}
		end
	end
end)

AddEventHandler('esx_mechanicjob:hasExitedMarker', function(zone)
	if zone =='VehicleDelivery' then
		NPCTargetDeleterZone = false
	elseif zone == 'Craft' then
		TriggerServerEvent('esx_mechanicjob:stopCraft')
		TriggerServerEvent('esx_mechanicjob:stopCraft2')
		TriggerServerEvent('esx_mechanicjob:stopCraft3')
	elseif zone == 'Garage' then
		TriggerServerEvent('esx_mechanicjob:stopHarvest')
		TriggerServerEvent('esx_mechanicjob:stopHarvest2')
		TriggerServerEvent('esx_mechanicjob:stopHarvest3')
	end

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

AddEventHandler('esx_mechanicjob:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' and not IsPedInAnyVehicle(playerPed, false) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('press_remove_obj')
		CurrentActionData = {entity = entity}
	end
end)

AddEventHandler('esx_mechanicjob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = _U('mechanic'),
		number     = 'mechanic',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEwAACxMBAJqcGAAAA4BJREFUWIXtll9oU3cUx7/nJA02aSSlFouWMnXVB0ejU3wcRteHjv1puoc9rA978cUi2IqgRYWIZkMwrahUGfgkFMEZUdg6C+u21z1o3fbgqigVi7NzUtNcmsac40Npltz7S3rvUHzxQODec87vfD+/e0/O/QFv7Q0beV3QeXqmgV74/7H7fZJvuLwv8q/Xeux1gUrNBpN/nmtavdaqDqBK8VT2RDyV2VHmF1lvLERSBtCVynzYmcp+A9WqT9kcVKX4gHUehF0CEVY+1jYTTIwvt7YSIQnCTvsSUYz6gX5uDt7MP7KOKuQAgxmqQ+neUA+I1B1AiXi5X6ZAvKrabirmVYFwAMRT2RMg7F9SyKspvk73hfrtbkMPyIhA5FVqi0iBiEZMMQdAui/8E4GPv0oAJkpc6Q3+6goAAGpWBxNQmTLFmgL3jSJNgQdGv4pMts2EKm7ICJB/aG0xNdz74VEk13UYCx1/twPR8JjDT8wttyLZtkoAxSb8ZDCz0gdfKxWkFURf2v9qTYH7SK7rQIDn0P3nA0ehixvfwZwE0X9vBE/mW8piohhl1WH18UQBhYnre8N/L8b8xQvlx4ACbB4NnzaeRYDnKm0EALCMLXy84hwuTCXL/ExoB1E7qcK/8NCLIq5HcTT0i6u8TYbXUM1cAyyveVq8Xls7XhYrvY/4n3gC8C+dsmAzL1YUiyfWxvHzsy/w/dNd+KjhW2yvv/RfXr7x9QDcmo1he2RBiCCI1Q8jVj9szPNixVfgz+UiIGyDSrcoRu2J16d3I6e1VYvNSQjXpnucAcEPUOkGYZs/l4uUhowt/3kqu1UIv9n90fAY9jT3YBlbRvFTD4fw++wHjhiTRL/bG75t0jI2ITcHb5om4Xgmhv57xpGOg3d/NIqryOR7z+r+MC6qBJB/ZB2t9Om1D5lFm843G/3E3HI7Yh1xDRAfzLQr5EClBf/HBHK462TG2J0OABXeyWDPZ8VqxmBWYscpyghwtTd4EKpDTjCZdCNmzFM9k+4LHXIFACJN94Z6FiFEpKDQw9HndWsEuhnADVMhAUaYJBp9XrcGQKJ4qFE9k+6r2+MG3k5N8VQ22TVglbX2ZwOzX2VvNKr91zmY6S7N6zqZicVT2WNLyVSehESaBhxnOALfMeYX+K/S2yv7wmMAlvwyuR7FxQUyf0fgc/jztfkJr7XeGgC8BJJgWNV8ImT+AAAAAElFTkSuQmCC'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

-- Pop NPC mission vehicle when inside area
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if NPCTargetTowableZone and not NPCHasSpawnedTowable then
			local coords = GetEntityCoords(PlayerPedId())
			local zone   = Config.Zones[NPCTargetTowableZone]

			if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < Config.NPCSpawnDistance then
				local model = Config.Vehicles[GetRandomIntInRange(1,  #Config.Vehicles)]

				ESX.Game.SpawnVehicle(model, zone.Pos, 0, function(vehicle)
					NPCTargetTowable = vehicle
				end)

				NPCHasSpawnedTowable = true
			end
		end

		if NPCTargetTowableZone and NPCHasSpawnedTowable and not NPCHasBeenNextToTowable then
			local coords = GetEntityCoords(PlayerPedId())
			local zone   = Config.Zones[NPCTargetTowableZone]

			if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < Config.NPCNextToDistance then
				ESX.ShowNotification(_U('please_tow'))
				NPCHasBeenNextToTowable = true
			end
		end
	end
end)

local hjzmarker = {
	Markers = {
		Delete = {Type = 36, r = 255, g = 0, b = 0, x = 1.5, y = 1.5, z = 1.5}, -- Red Color / Big Size Circle.
	}
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if ESX.PlayerData and ESX.PlayerData.job and ESX.PlayerData.job.name == "mechanic" then
			DrawMarker(hjzmarker.Markers.Delete.Type, vector3(274.6334, -2500.2515, 6.4403), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, hjzmarker.Markers.Delete.x, hjzmarker.Markers.Delete.y, hjzmarker.Markers.Delete.z, hjzmarker.Markers.Delete.r, hjzmarker.Markers.Delete.g, hjzmarker.Markers.Delete.b, 100, false, true, 2, true, nil, nil, false)
		end
	end
end)

-- Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.MechanicActions.Pos.x, Config.Zones.MechanicActions.Pos.y, Config.Zones.MechanicActions.Pos.z)

	SetBlipSprite (blip, 446)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, 5)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('blip_mechanic'))
	EndTextCommandSetBlipName(blip)
end)
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.MechanicSandyShores.Pos.x, Config.Zones.MechanicSandyShores.Pos.y, Config.Zones.MechanicSandyShores.Pos.z)

	SetBlipSprite (blip, 446)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, 5)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('blip_mechanic'))
	EndTextCommandSetBlipName(blip)
end)
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.MechanicLosSantos.Pos.x, Config.Zones.MechanicLosSantos.Pos.y, Config.Zones.MechanicLosSantos.Pos.z)

	SetBlipSprite (blip, 446)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, 5)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('blip_mechanic'))
	EndTextCommandSetBlipName(blip)
end)



function refreshblipHjzCar()
	for k,v in pairs(blips) do
		RemoveBlip(blips[k])
	end
	Citizen.CreateThread(function()
		if ESX.PlayerData and ESX.PlayerData.job then
			if ESX.PlayerData.job.name == "mechanic" then
				local blip = AddBlipForCoord(274.6334, -2500.2515, 6.4403)
				table.insert(blips, blip)
				SetBlipSprite (blip, 50)
				SetBlipDisplay(blip, 4)
				SetBlipScale  (blip, 1.0)
				SetBlipColour (blip, 64)
				SetBlipAsShortRange(blip, true)
				BeginTextCommandSetBlipName('STRING')
				AddTextComponentSubstringPlayerName('<FONT FACE="A9eelsh">ﻚﻴﻧﺎﻜﻴﻤﻠﻟ | ﺰﺠﺣ')
				EndTextCommandSetBlipName(blip)
			end
		end
	end)
end

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
			local coords, letSleep = GetEntityCoords(PlayerPedId()), true

			for k,v in pairs(Config.Zones) do
				if v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end
			end

			if letSleep then
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then

			local coords = GetEntityCoords(PlayerPedId())
			local isInMarker = false
			local currentZone = nil
			for k,v in pairs(Config.Zones) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('esx_mechanicjob:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_mechanicjob:hasExitedMarker', LastZone)
			end

		end
	end
end)

Citizen.CreateThread(function()
	local trackedEntities = {
		'prop_roadcone02a',
		--'prop_toolchest_01',
		--'prop_worklight_01a',
		--'prop_mp_arrow_barrier_01',
	}

	while true do
		Citizen.Wait(500)
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
	
			local closestDistance = -1
			local closestEntity   = nil
	
			for i=1, #trackedEntities, 1 do
				local object = GetClosestObjectOfType(coords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)
	
				if DoesEntityExist(object) then
					local objCoords = GetEntityCoords(object)
					local distance  = GetDistanceBetweenCoords(coords, objCoords, true)
	
					if closestDistance == -1 or closestDistance > distance then
						closestDistance = distance
						closestEntity   = object
					end
				end
			end
	
			if closestDistance ~= -1 and closestDistance <= 3.0 then
				if LastEntity ~= closestEntity then
					TriggerEvent('esx_mechanicjob:hasEnteredEntityZone', closestEntity)
					LastEntity = closestEntity
				end
			else
				if LastEntity then
					TriggerEvent('esx_mechanicjob:hasExitedEntityZone', LastEntity)
					LastEntity = nil
				end
			end
		else
			Citizen.Wait(3000)
		end		
	end
end)

function OpenMenuwesamCar()
	local playerPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerPed, true)

	local towmodel = GetHashKey('bensonc')
	local model_2 = GetHashKey('bensonc2')
	local isVehicleTow = IsVehicleModel(vehicle, towmodel)
	local isVehicle_2 = IsVehicleModel(vehicle, model_2)
	if isVehicleTow or isVehicle_2 then
		local targetVehicle = ESX.Game.GetVehicleInDirection()

		if CurrentlyTowedVehicle == nil then
			if targetVehicle ~= 0 then
				if not IsPedInAnyVehicle(playerPed, true) then
					if vehicle ~= targetVehicle then
						if isVehicleTow then
							AttachEntityToEntity(targetVehicle, vehicle, 19, -0.12, -4.0, -0.10, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
						elseif isVehicle_2 then
							AttachEntityToEntity(targetVehicle, vehicle, 19, -0.12, -5.0, -0.10, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
						end
						CurrentlyTowedVehicle = targetVehicle
						ESX.ShowNotification(_U('vehicle_success_attached'))

						if NPCOnJob then
							if NPCTargetTowable == targetVehicle then
								ESX.ShowNotification(_U('please_drop_off'))
								Config.Zones.VehicleDelivery.Type = 1

								if Blips['NPCTargetTowableZone'] then
									RemoveBlip(Blips['NPCTargetTowableZone'])
									Blips['NPCTargetTowableZone'] = nil
								end

								Blips['NPCDelivery'] = AddBlipForCoord(Config.Zones.VehicleDelivery.Pos.x, Config.Zones.VehicleDelivery.Pos.y, Config.Zones.VehicleDelivery.Pos.z)
								SetBlipRoute(Blips['NPCDelivery'], true)
							end
						end
					else
						ESX.ShowNotification(_U('cant_attach_own_tt'))
					end
				end
			else
				ESX.ShowNotification(_U('no_veh_att'))
			end
		else
			if isVehicleTow then
				AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 19, -0.8, -10.5, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
			elseif isVehicle_2 then
				AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -1.0, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
			end
			DetachEntity(CurrentlyTowedVehicle, true, true)

			if NPCOnJob then
				if NPCTargetDeleterZone then

					if CurrentlyTowedVehicle == NPCTargetTowable then
						ESX.Game.DeleteVehicle(NPCTargetTowable)
						TriggerServerEvent('esx_mechanicjob:onNPCJobMissionCompleted')
						StopNPCJob()
						NPCTargetDeleterZone = false
					else
						ESX.ShowNotification(_U('not_right_veh'))
					end

				else
					ESX.ShowNotification(_U('not_right_place'))
				end
			end

			CurrentlyTowedVehicle = nil
			ESX.ShowNotification(_U('veh_det_succ'))
		end
	else
		ESX.ShowNotification("اركب المركبة حقتك عشان تدخل السيارة")
	end

end


-- Key Controls


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if CurrentAction_wesam_2 then
			ESX.ShowHelpNotification(CurrentActionMsg_wesam_2)
			if IsControlJustReleased(0, 38) then
				if CurrentAction_wesam_2 == "car_wesam" then
					OpenMenuwesamCar()
				end
				CurrentAction_wesam_2 = nil
			end
		end

	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
				if CurrentAction == 'mechanic_actions_menu' then
					OpenMechanicActionsMenu()
				elseif CurrentAction == 'mechanic_harvest_menu' then
				    if isOnDuty then
						OpenMechanicHarvestMenu()
					else
				    	ESX.ShowNotification(_U('service_not'))
			        end
				elseif CurrentAction == 'mechanic_craft_menu' then
				    if isOnDuty then
						OpenMechanicCraftMenu()
					else
				    	ESX.ShowNotification(_U('service_not'))
			        end
				elseif CurrentAction == 'delete_vehicle' then
					if Config.EnableSocietyOwnedVehicles then

						local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
						TriggerServerEvent('esx_society:putVehicleInGarage', 'mechanic', vehicleProps)
                    
					else

						if
							GetEntityModel(vehicle) == GetHashKey('flatbed')   or
							GetEntityModel(vehicle) == GetHashKey('towtruck2') or
							GetEntityModel(vehicle) == GetHashKey('slamvan3')
						then
							TriggerServerEvent('esx_service:disableService', 'mechanic')
						end

					end

					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
					TriggerServerEvent('esx_vehicleshop:DeleteVehicleFromMechanic', "mechanic")	

				elseif CurrentAction == 'remove_entity' then
					DeleteEntity(CurrentActionData.entity)
				end

				CurrentAction = nil
			end
		end

		if IsControlJustReleased(0, 167) and not isDead and ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
		    if isOnDuty then -- addon service
				OpenMobileMechanicActionsMenu()
			else -- addon service
				ESX.ShowNotification(_U('service_not')) -- addon service
			end	 -- addon service
		end

	end
end)

--------------
--extas menu--
--------------
function OpenVehicleExtrasMenu()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    local availableExtras = {}

    if not DoesEntityExist(vehicle) then
	    ESX.ShowNotification(_U('novehiclenearby'))
        return
    end

    for i=0, 12 do
        if DoesExtraExist(vehicle, i) then
            local state = IsVehicleExtraTurnedOn(vehicle, i) == 1
            table.insert(availableExtras, {
                label = ('اكسسوار <span style="color:darkgoldenrod;">%s</span>: %s'):format(i, GetExtraLabel(state)),
                state = state,
                extraId = i
            })
        end
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_extras', {
        title    = 'اكسسوارات السيارة',
        align    = 'top-left',
        elements = availableExtras
    }, function(data, menu)
        ToggleVehicleExtra(vehicle, data.current.extraId, data.current.state)

        menu.close()
        OpenVehicleExtrasMenu()
    end, function(data, menu)
        menu.close()
    end)
end
Citizen.CreateThread(function()
	while true do
		Wait(0)
		local playerped = PlayerPedId()
		local pedCoords = GetEntityCoords(playerped)
		local closesvehicle = GetClosestVehicle(pedCoords, 10.0, GetHashKey('flatbed'), 70)
		local vehicle = GetVehiclePedIsIn(playerped, true)
	
		local isVehicleTow = isVehicleATowTruck(vehicle)

		if isVehicleTow then
			if DoesEntityExist(closesvehicle) and IsVehicleSeatFree(closesvehicle,-1) and isVehicleATowTruck(closesvehicle) then
				local d1,d2 = GetModelDimensions(GetEntityModel(closesvehicle))
				local enginePos = GetOffsetFromEntityInWorldCoords(closesvehicle, -2.0,d1.y+2.8,-1.0)
				local enginePos2 = GetOffsetFromEntityInWorldCoords(closesvehicle, 0.0,d1.y-3.8,-1.0)
				local vehDistance = (GetDistanceBetweenCoords(pedCoords, vector3(enginePos.x, enginePos.y, enginePos.z), true))
				local vehCoords = vector3(enginePos.x, enginePos.y, enginePos.z+0.6)
				local vehCoords2 = vector3(enginePos2.x, enginePos2.y, enginePos2.z+0.6)

				if vehDistance <= 9.0 then
					DrawMarker(1, enginePos.x, enginePos.y, enginePos.z-0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.3, 1.3, 1.0, 255, 255, 255, 200, false, true, 2, false, false, false, false)
					DrawMarker(1, enginePos2.x, enginePos2.y, enginePos2.z-0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.3, 2.3, 1.0, 255, 0, 0, 200, false, true, 2, false, false, false, false)
					if vehDistance <= 2.0 then
						ESX.ShowHelpNotification('ﺔﺒﻛﺮﻤﻟﺍ ﻊﻓﺮﻟ ~y~E ~w~ﻂﻐﻀﺎ  ')
						if IsControlJustPressed(0, 38) then
							local coordA = GetEntityCoords(playerped, 1)
							local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
							local targetVehicle, targetVehicledistance = ESX.Game.GetClosestVehicle(vehCoords2)
						
							Citizen.CreateThread(function()
								while true do
									Citizen.Wait(0)
									isVehicleTow = isVehicleATowTruck(vehicle)
									local roll = GetEntityRoll(GetVehiclePedIsIn(PlayerPedId(), true))
									if IsEntityUpsidedown(GetVehiclePedIsIn(PlayerPedId(), true)) and isVehicleTow or roll > 70.0 or roll < -70.0 then
										DetachEntity(currentlyTowedVehicle, false, false)
										currentlyTowedVehicle = nil
										ESX.ShowNotification("يبدو أن الكابلات المثبتة على السيارة قد تحطمت")
										break
									end
								end
							end)

							if currentlyTowedVehicle == nil then
								if DoesEntityExist(targetVehicle) and targetVehicledistance <= 3.0 then
									local targetVehicleLocation = GetEntityCoords(targetVehicle, true)
									local towTruckVehicleLocation = GetEntityCoords(vehicle, true)
									local targetModelHash = GetEntityModel(targetVehicle)
									
									if not ((not allowTowingBoats and IsThisModelABoat(targetModelHash)) or (not allowTowingHelicopters and IsThisModelAHeli(targetModelHash)) or (not allowTowingPlanes and IsThisModelAPlane(targetModelHash)) or (not allowTowingTrains and IsThisModelATrain(targetModelHash)) or (not allowTowingTrailers and isTargetVehicleATrailer(targetModelHash))) then 
										if not IsPedInAnyVehicle(playerped, true) then
											if vehicle ~= targetVehicle and IsVehicleStopped(vehicle) then
												AttachEntityToEntity(targetVehicle, vehicle, GetEntityBoneIndexByName(vehicle, 'bodyshell'), 0.0 + xoff, -1.5 + yoff, 0.0 + zoff, 0, 0, 0, false, false, true, false, 0, true)
												currentlyTowedVehicle = targetVehicle
											else
												ESX.ShowNotification("لا توجد أي مركبة على السطحة")
											end
										else
											ESX.ShowNotification("يجب أن تكون خارج مركبتك")
										end
									else
										ESX.ShowNotification("شاحنة السحب الخاصة بك غير مجهزة لسحب هذه المركبة")
									end
								else
									ESX.ShowNotification("لم يتم العثور على مركبة قابلة للرفع")
								end
							elseif IsVehicleStopped(vehicle) then
								DetachEntity(currentlyTowedVehicle, false, false)
								local vehiclesCoords = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -12.0, 0.0)
								SetEntityCoords(currentlyTowedVehicle, vehiclesCoords["x"], vehiclesCoords["y"], vehiclesCoords["z"], 1, 0, 0, 1)
								SetVehicleOnGroundProperly(currentlyTowedVehicle)
								currentlyTowedVehicle = nil
							end
						end
					end
				end
			end
		end
	end
end)

function ToggleVehicleExtra(vehicle, extraId, extraState)
    SetVehicleExtra(vehicle, extraId, extraState)
end

function GetExtraLabel(state)
    if state then
        return '<span style="color:green;">مفعل</span>'
    elseif not state then
        return '<span style="color:darkred;">غير مفعل</span>'
    end
end
--------------------
--END--extras menu--
--------------------

AddEventHandler('esx:onPlayerDeath', function(data) isDead = true end)
AddEventHandler('esx:onPlayerSpawn', function(spawn) isDead = false end)
