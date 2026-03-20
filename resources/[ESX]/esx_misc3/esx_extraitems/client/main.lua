


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)

	while not ConfigReady do; Citizen.Wait(1000); end
	if Config.GPS.VehicleGPS then
		DisplayRadar(false)
	end
end)


-- Start of Bandage
RegisterNetEvent('esx_extraitems:bandage')
AddEventHandler('esx_extraitems:bandage', function(source)
	local playerPed = PlayerPedId()
	local health = GetEntityHealth(playerPed)
	local maxHealth = GetEntityMaxHealth(playerPed)
	local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 20)) -- 8

	if IsPedSittingInAnyVehicle(playerPed) then
		ESX.ShowNotification(_U('error_veh'))
	else
		if IsPedOnFoot(playerPed) then
			local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01'
			ESX.Streaming.RequestAnimDict(lib, function()
				TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

				Citizen.Wait(500)
				while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
					Citizen.Wait(0)
					DisableAllControlActions(0)
				end

				SetEntityHealth(playerPed, newHealth)
			end)
		else
			ESX.ShowNotification(_U('error_no_foot'))
		end
	end
end)
-- End of Bandage

-- Start of Binoculars
local fov_max = 70.0
local fov_min = 5.0
local zoomspeed = 10.0
local speed_lr = 8.0
local speed_ud = 8.0
local binoculars = false
local fov = (fov_max+fov_min)*0.5

Citizen.CreateThread(function(); while not ConfigReady do; Citizen.Wait(1000); end
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(playerPed)

		if binoculars then
			binoculars = true
			if not (IsPedSittingInAnyVehicle(playerPed)) then
				Citizen.CreateThread(function()
					TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_BINOCULARS", 0, 1)
					PlayAmbientSpeech1(PlayerPedId(), "GENERIC_CURSE_MED", "SPEECH_PARAMS_FORCE")
				end)
			end

			Wait(2000)

			SetTimecycleModifier("default")
			SetTimecycleModifierStrength(0.3)

			local scaleform = RequestScaleformMovie("BINOCULARS")

			while not HasScaleformMovieLoaded(scaleform) do
				Citizen.Wait(10)
			end

			local playerPed = PlayerPedId()
			local vehicle = GetVehiclePedIsIn(playerPed)
			local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)

			AttachCamToEntity(cam, playerPed, 0.0,0.0,1.0, true)
			SetCamRot(cam, 0.0,0.0,GetEntityHeading(playerPed))
			SetCamFov(cam, fov)
			RenderScriptCams(true, false, 0, 1, 0)
			PushScaleformMovieFunction(scaleform, "SET_CAM_LOGO")
			PushScaleformMovieFunctionParameterInt(0) -- 0 for nothing, 1 for LSPD logo
			PopScaleformMovieFunctionVoid()

			while binoculars and not IsEntityDead(playerPed) and (GetVehiclePedIsIn(playerPed) == vehicle) and true do
				if IsControlJustPressed(0, Config.BinocularsPutAway) then -- Toggle binoculars
					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
					ClearPedTasks(PlayerPedId())
					binoculars = false
				end

				local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
				CheckInputRotation(cam, zoomvalue)

				HandleZoom(cam)
				HideHUDThisFrame()

				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
				Citizen.Wait(5)
			end

			binoculars = false
			ClearTimecycleModifier()
			fov = (fov_max+fov_min)*0.5
			RenderScriptCams(false, false, 0, 1, 0)
			SetScaleformMovieAsNoLongerNeeded(scaleform)
			DestroyCam(cam, false)
			SetNightvision(false)
			SetSeethrough(false)
		end
	end
end)

RegisterNetEvent('esx_extraitems:binoculars')
AddEventHandler('esx_extraitems:binoculars', function()
	binoculars = not binoculars
end)

function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(1) -- Wanted Stars
	HideHudComponentThisFrame(2) -- Weapon icon
	HideHudComponentThisFrame(3) -- Cash
	HideHudComponentThisFrame(4) -- MP CASH
	HideHudComponentThisFrame(6)
	HideHudComponentThisFrame(7)
	HideHudComponentThisFrame(8)
	HideHudComponentThisFrame(9)
	HideHudComponentThisFrame(13) -- Cash Change
	HideHudComponentThisFrame(11) -- Floating Help Text
	HideHudComponentThisFrame(12) -- more floating help text
	HideHudComponentThisFrame(15) -- Subtitle Text
	HideHudComponentThisFrame(18) -- Game Stream
	HideHudComponentThisFrame(19) -- weapon wheel
end

function CheckInputRotation(cam, zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(cam, 2)

	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
		new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)), -89.5)
		SetCamRot(cam, new_x, 0.0, new_z, 2)
	end
end

function HandleZoom(cam)
	local playerPed = PlayerPedId()

	if not (IsPedSittingInAnyVehicle(playerPed)) then
		if IsControlJustPressed(0,241) then -- Scrollup
			fov = math.max(fov - zoomspeed, fov_min)
		end

		if IsControlJustPressed(0,242) then
			fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown
		end

		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then
			fov = current_fov
		end

		SetCamFov(cam, current_fov + (fov - current_fov)*0.05)
	else
		if IsControlJustPressed(0,17) then -- Scrollup
			fov = math.max(fov - zoomspeed, fov_min)
		end

		if IsControlJustPressed(0,16) then
			fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown
		end

		local current_fov = GetCamFov(cam)

		if math.abs(fov-current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
			fov = current_fov
		end

		SetCamFov(cam, current_fov + (fov - current_fov)*0.05) -- Smoothing of camera zoom
	end
end
-- End of Binoculars

local BLOCKINPUTCONTROL = false

Citizen.CreateThread( function()
	while true do
		Citizen.Wait(1)
		if BLOCKINPUTCONTROL then
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, Keys['W'], true) -- W
			DisableControlAction(0, Keys['A'], true) -- A
			DisableControlAction(0, Keys['E'], true) -- A
			DisableControlAction(0, 31, true) -- S (fault in Keys table!)
			DisableControlAction(0, 30, true) -- D (fault in Keys table!)

			DisableControlAction(0, Keys['R'], true) -- Reload
			DisableControlAction(0, Keys['SPACE'], true) -- Jump
			DisableControlAction(0, Keys['Q'], true) -- Cover
			DisableControlAction(0, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(0, Keys['F'], true) -- Also 'enter'?

			DisableControlAction(0, Keys['F1'], true) -- Disable phone
			DisableControlAction(0, Keys['F2'], true) -- Inventory
			DisableControlAction(0, Keys['F3'], true) -- Animations
			DisableControlAction(0, Keys['F6'], true) -- Job

			DisableControlAction(0, Keys['V'], true) -- Disable changing view
			DisableControlAction(0, Keys['C'], true) -- Disable looking behind
			DisableControlAction(0, Keys['X'], true) -- Disable clearing animation
			DisableControlAction(2, Keys['P'], true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		end
	end
end)

local use_b = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if use_b then
			TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
			Citizen.Wait(10000)
		end
	end
end)

-- Start of Bullet Proof Vest
RegisterNetEvent('esx_extraitems:bulletproof')
AddEventHandler('esx_extraitems:bulletproof', function()
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		ESX.ShowNotification(_U('error_veh'))
	else
		TriggerServerEvent('esx_wesam_wesam:send')
		if IsPedOnFoot(playerPed) then
			Citizen.CreateThread(function()
				BLOCKINPUTCONTROL = true
				exports['pogressBar']:drawBar(30000, 'جاري لبس سترة ضد الرصاص')
				use_b = true
				Wait(30000)
				SetPedComponentVariation(playerPed, 9, 26, 9, 2)
				AddArmourToPed(playerPed, 100)
				SetPedArmour(playerPed, 100)
				Wait(500)
				ClearPedTasks(playerPed)
				BLOCKINPUTCONTROL = false
				use_b = false
				TriggerServerEvent('esx_wesam_wesam:send')
			end)
		else
			ESX.ShowNotification(_U('error_no_foot'))
			TriggerServerEvent('esx_wesam_wesam:send')
		end
	end
end)


-- End of Bullet Proof Vest

-- Start of Defib
RegisterNetEvent('esx_extraitems:defib')
AddEventHandler('esx_extraitems:defib', function(source)
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		ESX.ShowNotification(_U('error_veh'))
	else
		if IsPedOnFoot(playerPed) then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer == -1 or closestDistance > 3.0 then
				ESX.ShowNotification(_U('error_no_ped'))
			else
				local closestPlayerPed = GetPlayerPed(closestPlayer)
				local chance = math.random(100)

				if IsPedDeadOrDying(closestPlayerPed, 1) then
					local playerPed = PlayerPedId()
					local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'
					ESX.ShowNotification(_U('revive_inprogress'))

					for i=1, 15 do
						Citizen.Wait(900)

						ESX.Streaming.RequestAnimDict(lib, function()
							TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
						end)
					end

					if chance <= 66 then
						TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))
						ESX.ShowNotification(_U('defib_worked'))
					else
						ESX.ShowNotification(_U('defib_failed'))
					end
				else
					ESX.ShowNotification(_U('player_not_unconscious'))
				end
			end
		else
			ESX.ShowNotification(_U('error_no_foot'))
		end
	end
end)
-- End of Defib

-- Start of Drill
RegisterNetEvent('esx_extraitems:drill')
AddEventHandler('esx_extraitems:drill', function(source)
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		ESX.ShowNotification(_U('error_veh'))
	else
		if IsPedOnFoot(playerPed) then
			TriggerServerEvent('esx_extraitems:removedrill')
			TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_CONST_DRILL", 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(Config.Wait.Drill)
				ClearPedTasksImmediately(playerPed)
			end)
		else
			ESX.ShowNotification(_U('error_no_foot'))
		end
	end
end)
-- End of Drill

-- Start of Firework
local box = nil
local animlib = 'anim@mp_fireworks'

RegisterNetEvent('esx_extraitems:firework')
AddEventHandler('esx_extraitems:firework', function()
	RequestAnimDict(animlib)

	while not HasAnimDictLoaded(animlib) do
		Citizen.Wait(10)
	end

	if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
		RequestNamedPtfxAsset("scr_indep_fireworks")

		while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
			Wait(10)
		end
	end

	local pedcoords = GetEntityCoords(PlayerPedId())
	local ped = PlayerPedId()
	local times = 20

	TaskPlayAnim(ped, animlib, 'place_firework_3_box', -1, -8.0, 3000, 0, 0, false, false, false)
	Citizen.Wait(4000)
	ClearPedTasks(ped)

	box = CreateObject(GetHashKey('ind_prop_firework_03'), pedcoords, true, false, false)
	PlaceObjectOnGroundProperly(box)
	FreezeEntityPosition(box, true)
	local firecoords = GetEntityCoords(box)

	Citizen.Wait(10000)
	repeat
	UseParticleFxAssetNextCall("scr_indep_fireworks")
	local part1 = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", firecoords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
	times = times - 1
	Citizen.Wait(2000)
	until(times == 0)
	DeleteEntity(box)
	box = nil
end)
-- End of Firework

-- Start of First Aid Kit
RegisterNetEvent('esx_extraitems:firstaidkit')
AddEventHandler('esx_extraitems:firstaidkit', function()
	local playerPed = PlayerPedId()
	local health = GetEntityHealth(playerPed)
	local maxHealth = GetEntityMaxHealth(playerPed)

	if Config.Heal then
		if IsPedSittingInAnyVehicle(playerPed) then
			ESX.ShowNotification(_U('error_veh'))
		else
			if IsPedOnFoot(playerPed) then
				if health > 0 and health < maxHealth then
					local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01'
					ESX.Streaming.RequestAnimDict(lib, function()
						TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

						Citizen.Wait(500)
						while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
							Citizen.Wait(0)
							DisableAllControlActions(0)
						end

						TriggerServerEvent('esx_extraitems:removefirstaidkit')
						SetEntityHealth(playerPed, maxHealth)
					end)
				end
			else
				ESX.ShowNotification(_U('error_no_foot'))
			end
		end
	else
		TriggerServerEvent('esx_extraitems:givebandages')
	end
end)
-- End of First Aid Kit

-- Start of Lock Pick
RegisterNetEvent('esx_extraitems:lockpick')
AddEventHandler('esx_extraitems:lockpick', function()
	--local playerPed = PlayerPedId()
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
				Citizen.Wait(Config.Wait.LockPick)

				if chance <= 66 then
					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)
					ESX.ShowNotification(_U('veh_unlocked'))
					--SetVehicleNeedsToBeHotwired(vehicle, true)
					--IsVehicleNeedsToBeHotwired(vehicle)
					--TaskEnterVehicle(playerPed, vehicle, 10.0, -1, 1.0, 1, 0)
				else
					TriggerServerEvent('esx_extraitems:removelockpick')
					ESX.ShowNotification(_U('hijack_failed'))
					ClearPedTasksImmediately(playerPed)
				end

				Citizen.Wait(500)

				if GetVehicleDoorLockStatus(vehicle) == 1 then
					print('SetVehicleNeedsToBeHotwired')
					SetVehicleNeedsToBeHotwired(vehicle, true)
				else
					print('IsVehicleNeedsToBeHotwired')
					IsVehicleNeedsToBeHotwired(vehicle)
				end

				TaskEnterVehicle(playerPed, vehicle, 10.0, -1, 1.0, 1, 0)
			end)
		end
	end
end)
-- End of Lock Pick

-- Start of Oxygen Mask
RegisterNetEvent('esx_extraitems:oxygenmask')
AddEventHandler('esx_extraitems:oxygenmask', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local boneIndex = GetPedBoneIndex(playerPed, 12844)
	local boneIndex2 = GetPedBoneIndex(playerPed, 24818)

	ESX.Game.SpawnObject('p_s_scuba_mask_s', {
		x = coords.x,
		y = coords.y,
		z = coords.z - 3
	}, function(object)
		ESX.Game.SpawnObject('p_s_scuba_tank_s', {
			x = coords.x,
			y = coords.y,
			z = coords.z - 3
		}, function(object2)
			AttachEntityToEntity(object2, playerPed, boneIndex2, -0.30, -0.22, 0.0, 0.0, 90.0, 180.0, true, true, false, true, 1, true)
			AttachEntityToEntity(object, playerPed, boneIndex, 0.0, 0.0, 0.0, 0.0, 90.0, 180.0, true, true, false, true, 1, true)
			SetPedDiesInWater(playerPed, false)

			ESX.ShowNotification(_U('dive_suit_on') .. '%.')

			Citizen.Wait(50000)
			ESX.ShowNotification(_U('oxygen_notify', '~y~', '50') .. '%.')

			Citizen.Wait(25000)
			ESX.ShowNotification(_U('oxygen_notify', '~o~', '25') .. '%.')

			Citizen.Wait(25000)
			ESX.ShowNotification(_U('oxygen_notify', '~r~', '0') .. '%.')

			SetPedDiesInWater(playerPed, true)
			DeleteObject(object)
			DeleteObject(object2)
			ClearPedSecondaryTask(playerPed)
		end)
	end)
end)
-- End of Oxygen Mask

-- Start of Repair Kit
-- RegisterNetEvent('esx_extraitems:repairkit')
-- AddEventHandler('esx_extraitems:repairkit', function()
-- 	local playerPed = PlayerPedId()
-- 	local coords = GetEntityCoords(playerPed)
-- 	local vehicle = ESX.Game.GetVehicleInDirection()
	
-- 	if IsPedSittingInAnyVehicle(playerPed) then
-- 		ESX.ShowNotification(_U('error_veh'))
-- 	else
-- 		if DoesEntityExist(vehicle) and IsPedOnFoot(playerPed) then
-- 			TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
-- 			Citizen.CreateThread(function()
-- 				Citizen.Wait(Config.Wait.RepairKit)
-- 				SetVehicleFixed(vehicle)
-- 				SetVehicleDeformationFixed(vehicle)
-- 				SetVehicleUndriveable(vehicle, false)
-- 				ClearPedTasksImmediately(playerPed)
-- 				TriggerServerEvent('esx_extraitems:removerepairkit')
-- 				ESX.ShowNotification(_U('repair_done'))
-- 			end)
-- 		else
-- 			ESX.ShowNotification(_U('error_no_veh'))
-- 		end
-- 	end
-- end)
-- End of Repair Kit

-- Start of Tire Kit
RegisterNetEvent('esx_extraitems:tirekit')
AddEventHandler('esx_extraitems:tirekit', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
	local closestTire = GetClosestVehicleTire(vehicle)

	if IsPedSittingInAnyVehicle(playerPed) then
		ESX.ShowNotification(_U('error_veh'))
	else
		if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
			if DoesEntityExist(vehicle) and IsPedOnFoot(playerPed) and closestTire ~= nil then
				TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
				Citizen.CreateThread(function()
					Citizen.Wait(Config.Wait.TireKit)
					SetVehicleTyreFixed(vehicle, closestTire.tireIndex)
					SetVehicleWheelHealth(vehicle, closestTire.tireIndex, 100)
					ClearPedTasksImmediately(playerPed)
					TriggerServerEvent('esx_extraitems:removetirekit')
					ESX.ShowNotification(_U('tire_done'))
				end)
			else
				ESX.ShowNotification(_U('error_no_tire'))
			end
		else
			ESX.ShowNotification(_U('error_no_veh'))
		end
	end
end)

function GetClosestVehicleTire(vehicle)
	local tireBones = {"wheel_lf", "wheel_rf", "wheel_lm1", "wheel_rm1", "wheel_lm2", "wheel_rm2", "wheel_lm3", "wheel_rm3", "wheel_lr", "wheel_rr"}
	local tireIndex = {["wheel_lf"] = 0, ["wheel_rf"] = 1, ["wheel_lm1"] = 2, ["wheel_rm1"] = 3, ["wheel_lm2"] = 45,["wheel_rm2"] = 47, ["wheel_lm3"] = 46, ["wheel_rm3"] = 48, ["wheel_lr"] = 4, ["wheel_rr"] = 5,}
	local playerPed = PlayerPedId()
	local playerPos = GetEntityCoords(playerPed, false)
	local minDistance = 1.0
	local closestTire = nil

	for a=1, #tireBones do
		local bonePos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, tireBones[a]))
		local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, bonePos.x, bonePos.y, bonePos.z)

		if closestTire == nil then
			if distance <= minDistance then
				closestTire = {bone = tireBones[a], boneDist = distance, bonePos = bonePos, tireIndex = tireIndex[tireBones[a]]}
			end
		else
			if distance < closestTire.boneDist then
				closestTire = {bone = tireBones[a], boneDist = distance, bonePos = bonePos, tireIndex = tireIndex[tireBones[a]]}
			end
		end
	end

	return closestTire
end
-- End of Tire Kit

-- Start of Vehicle GPS
local ShowRadar = false

RegisterNetEvent('esx_extraitems:installGPS')
AddEventHandler('esx_extraitems:installGPS', function()
	if Config.GPS.VehicleGPS then
		local playerPed = PlayerPedId()
		local playerVeh = GetVehiclePedIsIn(playerPed, false)

		if ShowRadar == false then
			if DoesEntityExist(playerVeh) then
				if Config.GPS.LimitedVehicles then
					local model = GetEntityModel(playerVeh)

					if IsThisModelABoat(model) or IsThisModelACar(model) or IsThisModelAHeli(model) or IsThisModelAPlane(model) or IsThisModelAnAmphibiousCar(model) or GPSList() == true then
						ShowRadar = true
						ESX.ShowNotification(_U('gps_installed'))
					else
						ESX.ShowNotification(_U('gps_not_correct'))
					end
				else
					ShowRadar = true
					ESX.ShowNotification(_U('gps_installed'))
				end
			else
				ESX.ShowNotification(_U('gps_no_vehicle'))
			end
		else
			DisplayRadar(false)
			ShowRadar = false
			ESX.ShowNotification(_U('gps_removed'))
		end
	end
end)


function GPSList()
    local playerPed = PlayerPedId()
    local currentVehicle = GetVehiclePedIsIn(playerPed)

    for i,model in pairs(Config.GPS.BikeGPS) do
		if IsVehicleModel(currentVehicle, GetHashKey(model)) then
			return true
		end
	end
	return false
end
-- End of Vehicle GPS

-- Start of Weapon Kit
RegisterNetEvent('esx_extraitems:weakit')
AddEventHandler('esx_extraitems:weakit', function()
	local playerPed = PlayerPedId()
	
	if IsPedSittingInAnyVehicle(playerPed) then
		ESX.ShowNotification(_U('error_veh'))
	else
		if IsPedOnFoot(playerPed) then
			TriggerEvent('esx_extraitems:OpenCompMenu')
		else
			ESX.ShowNotification(_U('error_veh'))
		end
	end
end)
-- End of Weapon Kit

-- Start of Ammo Boxes
RegisterNetEvent('esx_extraitems:checkammo')
AddEventHandler('esx_extraitems:checkammo', function(type)
	local playerPed = PlayerPedId()

	if IsPedArmed(playerPed, 4) then
		if type == 'boxpistol' then
			hash = GetSelectedPedWeapon(playerPed)
			ammo = Config.AmmoBoxes.Pistol
			if isWeaponPistol(hash) then
				TriggerServerEvent('esx_extraitems:removebox', hash, ammo, 'boxpistol')
			else
				ESX.ShowNotification(_U('not_suitable'))
			end
		elseif type == 'boxsmg' then
			hash = GetSelectedPedWeapon(playerPed)
			ammo = Config.AmmoBoxes.SMG
			if isWeaponSMG(hash) then
				TriggerServerEvent('esx_extraitems:removebox', hash, ammo, 'boxsmg')
			else
				ESX.ShowNotification(_U('not_suitable'))
			end
		elseif type == 'boxshot' then
			hash = GetSelectedPedWeapon(playerPed)
			ammo = Config.AmmoBoxes.Shotgun
			if isWeaponShotgun(hash) then
				TriggerServerEvent('esx_extraitems:removebox', hash, ammo, 'boxshot')
			else
				ESX.ShowNotification(_U('not_suitable'))
			end
		elseif type == 'boxrifle' then
			hash = GetSelectedPedWeapon(playerPed)
			ammo = Config.AmmoBoxes.Rifle
			if isWeaponRifle(hash) then
				TriggerServerEvent('esx_extraitems:removebox', hash, ammo, 'boxrifle')
			else
				ESX.ShowNotification(_U('not_suitable'))
			end
		elseif type == 'boxmg' then
			hash = GetSelectedPedWeapon(playerPed)
			ammo = Config.AmmoBoxes.MG
			if isWeaponMG(hash) then
				TriggerServerEvent('esx_extraitems:removebox', hash, ammo, 'boxmg')
			else
				ESX.ShowNotification(_U('not_suitable'))
			end
		elseif type == 'boxsniper' then
			hash = GetSelectedPedWeapon(playerPed)
			ammo = Config.AmmoBoxes.Sniper
			if isWeaponSniper(hash) then
				TriggerServerEvent('esx_extraitems:removebox', hash, ammo, 'boxsniper')
			else
				ESX.ShowNotification(_U('not_suitable'))
			end
		elseif type == 'boxflare' then
			hash = GetSelectedPedWeapon(playerPed)
			ammo = Config.AmmoBoxes.Flare
			if isWeaponFlare(hash) then
				TriggerServerEvent('esx_extraitems:removebox', hash, ammo, 'boxflare')
			else
				ESX.ShowNotification(_U('not_suitable'))
			end
		elseif type == 'boxbig' then
			hash = GetSelectedPedWeapon(playerPed)
			ammo = Config.AmmoBoxes.BoxBig
			if hash ~= nil then
				TriggerServerEvent('esx_extraitems:removebox', hash, ammo, 'boxbig')
			end
		elseif type == 'boxsmall' then
			hash = GetSelectedPedWeapon(playerPed)
			ammo = Config.AmmoBoxes.BoxSmall
			if hash ~= nil then
				TriggerServerEvent('esx_extraitems:removebox', hash, ammo, 'boxsmall')
			end
		end
	else
		ESX.ShowNotification(_U('no_weapon'))
	end
end)

function isWeaponPistol(model)
	for _, weaponPistol in pairs(Config.WeaponList.Pistols) do
		if model == GetHashKey(weaponPistol) then
			return true
		end
	end
	return false
end

function isWeaponSMG(model)
	for _, weaponSMG in pairs(Config.WeaponList.SMGs) do
		if model == GetHashKey(weaponSMG) then
			return true
		end
	end
	return false
end

function isWeaponShotgun(model)
	for _, weaponShotgun in pairs(Config.WeaponList.Shotguns) do
		if model == GetHashKey(weaponShotgun) then
			return true
		end
	end
	return false
end

function isWeaponRifle(model)
	for _, weaponRifle in pairs(Config.WeaponList.Rifles) do
		if model == GetHashKey(weaponRifle) then
			return true
		end
	end
	return false
end

function isWeaponMG(model)
	for _, weaponMG in pairs(Config.WeaponList.MGs) do
		if model == GetHashKey(weaponMG) then
			return true
		end
	end
	return false
end

function isWeaponSniper(model)
	for _, weaponSniper in pairs(Config.WeaponList.Snipers) do
		if model == GetHashKey(weaponSniper) then
			return true
		end
	end
	return false
end

function isWeaponFlare(model)
	for _, weaponFlare in pairs(Config.WeaponList.Flares) do
		if model == GetHashKey(weaponFlare) then
			return true
		end
	end
	return false
end
-- End of Ammo Boxes
