----------------------------------------------------------------
-- Copyright © 2019 by Guy Shefer
-- Made By: Guy293
-- GitHub: https://github.com/Guy293
-- Fivem Forum: https://forum.fivem.net/u/guy293/
----------------------------------------------------------------

--- DO NOT EDIT THIS --
local holstered  = true
local blocked	 = false

Citizen.CreateThread(function()
	while PlayerData.job == nil do
		Citizen.Wait(500)
	end
	
	--set local functions
	local function CheckWeapon(ped)
		for i = 1, #Config.Weapons do
			if GetHashKey(Config.Weapons[i]) == GetSelectedPedWeapon(ped) then
				return true
			end
		end
		return false
	end
	
	local function loadAnimDict(dict)
		while ( not HasAnimDictLoaded(dict)) do
			RequestAnimDict(dict)
			Citizen.Wait(100)
		end
	end
	--end local functions

	if MycurrentJobLeo then
		Config.cooldownCurrent = Config.cooldownPolice
	else
		Config.cooldownCurrent 	= Config.cooldownCitizen
	end
	
	while true do
		Citizen.Wait(200)
		loadAnimDict("rcmjosh4")
		loadAnimDict("weapons@pistol@")
		loadAnimDict("reaction@intimidation@cop@unarmed")
		local ped = PlayerPedId()
		local parachuteState = GetPedParachuteState(ped)
		--[[ parachuteState:
			-1: Normal  
			0: Wearing parachute on back  
			1: Parachute opening  
			2: Parachute open  
			3: Falling to doom (e.g. after exiting parachute)  
			Normal means no parachute?  
		]]
		
		if not IsPedInAnyVehicle(ped, false) and parachuteState <= 0 then
			if DoesEntityExist( ped ) and not IsEntityDead( ped ) and GetVehiclePedIsTryingToEnter(ped) == 0 and not IsPedInParachuteFreeFall (ped) then
				if CheckWeapon(ped) and not holdingHostageInProgress then
				--if IsPedArmed(ped, 4) then
					if holstered then
						blocked   = true
						TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
						Citizen.Wait(Config.cooldownCurrent)
						TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
						Citizen.Wait(600)
						ClearPedTasks(ped)
						holstered = false
					else
						blocked = false
					end
				else
				--elseif not IsPedArmed(ped, 4) then
					if not holstered then
							TaskPlayAnim(ped, "weapons@pistol@", "aim_2_holster", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
							Citizen.Wait(500)
							ClearPedTasks(ped)
							holstered = true
					end
				end
			else
				SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
			end
		else
			holstered = false
		end
	end
end)

Citizen.CreateThread(function()
	local sleep
	while true do
		sleep = 500
		
		if blocked then
			sleep = 0
			DisableControlAction(1, 25, true )
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(1, 23, true)
			DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
			DisablePlayerFiring(ped, true) -- Disable weapon firing
		end
		
		Citizen.Wait(sleep)
	end
end)

RegisterNetEvent('SalvzTurki:esx_animations2:holsterweapon:fix_blocked')  -- يصلح مشكلة ركوب السيارة و إخراج السلاح
AddEventHandler('SalvzTurki:esx_animations2:holsterweapon:fix_blocked', function() -- يستعمل في كوماند -- /LAG : esx_misc
    blocked = false
end)