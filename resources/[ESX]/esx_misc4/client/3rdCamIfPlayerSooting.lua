local shot = false
local check = false
local check2 = false
local count = 0

Citizen.CreateThread(function()
	while true do
		--SetBlackout(false)
		Citizen.Wait( 1 )
		-- check if player is already in first person
		if IsPlayerFreeAiming(PlayerId()) then
		    if GetFollowPedCamViewMode() == 4 and check == false then
			    check = false
			else
			    SetFollowPedCamViewMode(4)
			    check = true
			end
		else
		    if check == true then
		        SetFollowPedCamViewMode(1)
				check = false
			end
		end
	end
end )



Citizen.CreateThread(function()
	while true do
		
		-- Wait 5 seconds after player has loaded in and trigger the event.
		--SetBlackout(false)
		Citizen.Wait( 1 )

		HideHudComponentThisFrame( 14 ) -- Remove aim point
		
		if IsPedShooting(PlayerPedId()) and shot == false and GetFollowPedCamViewMode() ~= 4 then
			check2 = true
			shot = true
			SetFollowPedCamViewMode(4)
		end
		
		if IsPedShooting(PlayerPedId()) and shot == true and GetFollowPedCamViewMode() == 4 then
			count = 0
		end
		
		if not IsPedShooting(PlayerPedId()) and shot == true then
		    count = count + 1
		end

        if not IsPedShooting(PlayerPedId()) and shot == true then
			if not IsPedShooting(PlayerPedId()) and shot == true and count > 20 then
		        if check2 == true then
				    check2 = false
					shot = false
					SetFollowPedCamViewMode(1)
				end
			end
		end	    
	end
end )


--keep my door open
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local ped = PlayerPedId()

		if DoesEntityExist(ped) and IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) and not IsPauseMenuActive() then
			Citizen.Wait(150)
			if DoesEntityExist(ped) and IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) and not IsPauseMenuActive() then
				local veh = GetVehiclePedIsIn(ped, false)
				TaskLeaveVehicle(ped, veh, 256)
			end
		end
	end
end)