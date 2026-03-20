isAirshot = false

Citizen.CreateThread(function()
	-- animdict = "move_weapon@pistol@cope"
	-- anim = "idle"
	animdict = "weapons@pistol@"
	animdict_fp = "weapons@first_person@aim_rng@generic@pistol@pistol_50@"
	anim = "wall_block"
	-- anim_fp = 
	
	RequestAnimDict(animdict)
	repeat Wait(500) until HasAnimDictLoaded(animdict)
	RequestAnimDict(animdict_fp)
	repeat Wait(500) until HasAnimDictLoaded(animdict_fp)

	while true do 
		
		if not IsPedInAnyVehicle(PlayerPedId(), 0) then
			Citizen.Wait(100)
			
			local _, wep = GetCurrentPedWeapon(PlayerPedId(), 1)
			
			if IsControlPressed(0, 26) and IsPlayerFreeAiming(PlayerId()) and GetWeapontypeGroup(wep) ~= `GROUP_THROWN` then
				if isAirshot == false then
					if GetFollowPedCamViewMode() == 4 then 
						TaskPlayAnim(PlayerPedId(), animdict_fp, anim, 4.0, 4.0, -1, 49, -1.0, false, false, false)
					else
						TaskPlayAnim(PlayerPedId(), animdict, anim, 4.0, 4.0, -1, 49, -1.0, false, false, false)
					end
					isAirshot = true
				else
					TaskPlayAnim(PlayerPedId(), "", "", 4.0, 4.0, -1, 49, -1.0, false, false, false)
					isAirshot = false
				end
			end
			
			
			if isAirshot then
				if not IsPlayerFreeAiming(PlayerId()) then
					TaskPlayAnim(PlayerPedId(), "", "", 4.0, 4.0, -1, 49, -1.0, false, false, false)
					isAirshot = false
				end
			
				DisablePlayerFiring(PlayerId(), true)
				if IsDisabledControlJustPressed(0, 24) then
					SetPedShootsAtCoord(PlayerPedId(), 0.0, 0.0, 0.0, 0)
					-- repeat Wait(500) until IsPedWeaponReadyToShoot(PlayerPedId())
				end
				DisableAimCamThisUpdate()
			end
			
			-- if isAirshot == true and not IsPedWeaponReadyToShoot(PlayerPedId()) then
				-- TaskPlayAnim(PlayerPedId(), "", "", 4.0, 4.0, -1, 49, -1.0, false, false, false)
				-- isAirshot = false
			-- end
		else
			Citizen.Wait(3000)
		end	
	end
end)