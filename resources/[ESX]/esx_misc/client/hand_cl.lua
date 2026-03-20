
local arrested					= false		-- Zostaw na False innaczej bedzie aresztowac na start Skryptu
local Aresztowany				= false		-- Zostaw na False innaczej bedziesz Arresztowany na start Skryptu
 
local SekcjaAnimacji			= 'mp_arrest_paired'	-- Sekcja Katalogu Animcji
local Animarrested 				= 'cop_p2_back_left'	-- Animacja Aresztujacego
local AnimAresztowany			= 'crook_p2_back_left'	-- Animacja Aresztowanego
local OstatnioAresztowany		= 0						-- Mozna sie domyslec ;)

local IsHandcuffed = false
HandcuffTimer = {}
local DragStatus = {}
DragStatus.IsDragged = false

RegisterNetEvent('esx_misc:aresztowany') --arrested للمتهم
AddEventHandler('esx_misc:aresztowany', function(target)
	
	if not IsHandcuffed then
		Aresztowany = true
	
		local playerPed = GetPlayerPed(-1)
		local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

		RequestAnimDict(SekcjaAnimacji)
		
		while not HasAnimDictLoaded(SekcjaAnimacji) do
			Citizen.Wait(10)
		end
		AttachEntityToEntity(GetPlayerPed(-1), targetPed, 11816, -0.1, 0.45, 0.0, 0.0, 0.0, 20.0, false, false, false, false, 20, false)
		TaskPlayAnim(playerPed, SekcjaAnimacji, AnimAresztowany, 8.0, -8.0, 5500, 33, 0, false, false, false)
	
		Citizen.Wait(950)
		DetachEntity(GetPlayerPed(-1), true, false)
		
		Aresztowany = false
		Citizen.Wait(1500)
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'cuffseffect', 0.5)		
		Citizen.Wait(2000)
		
		TriggerEvent('esx_misc:handcuff')
	else
		TriggerEvent('esx_misc:handcuff')
	end
end)

RegisterNetEvent('esx_misc:unhand') --arrestedفك للمتهم
AddEventHandler('esx_misc:unhand', function(target)
	
	if not IsHandcuffed then
		Aresztowany = true
	
		local playerPed = GetPlayerPed(-1)
		local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
		
		while not HasAnimDictLoaded(SekcjaAnimacji) do
			Citizen.Wait(10)
		end
	
		Citizen.Wait(950)
		DetachEntity(GetPlayerPed(-1), true, false)
		
		Aresztowany = false
		Citizen.Wait(1500)
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'cuffseffect', 0.5)		
		Citizen.Wait(2000)
		
		TriggerEvent('esx_misc:handcuff')
	else
		TriggerEvent('esx_misc:handcuff')
	end
end)


RegisterNetEvent('esx_misc:unhands') --arrest  فك للشرطي
AddEventHandler('esx_misc:unhands', function()
	if not IsHandcuffed then
		local playerPed = GetPlayerPed(-1)
	
		
		--SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_PISTOL'), true) -- unarm player
		
		while not HasAnimDictLoaded(SekcjaAnimacji) do
			Citizen.Wait(10)
		end
	
	
		Citizen.Wait(3000)
	end
	arrested = false
end)

RegisterNetEvent('esx_misc:aresztuj') --arrest للشرطي
AddEventHandler('esx_misc:aresztuj', function(job)
	if not IsHandcuffed then
		local playerPed = GetPlayerPed(-1)
	
		RequestAnimDict(SekcjaAnimacji)
		
		--SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_PISTOL'), true) -- unarm player
		
		while not HasAnimDictLoaded(SekcjaAnimacji) do
			Citizen.Wait(10)
		end
		if job == "admin" then
			--print()
		else
			TaskPlayAnim(playerPed, SekcjaAnimacji, Animarrested, 8.0, -8.0, 5500, 33, 0, false, false, false)
		end
	
		Citizen.Wait(3000)
	end
	arrested = false
end)

--handcuff shortcut
Citizen.CreateThread(function()
	while PlayerData == nil do
		Citizen.Wait(500)
	end
	
	local timeHeld
	
	while true do
		Wait(0)
		local ped = GetPlayerPed(-1)
		
		local parachuteState = GetPedParachuteState(ped)
		--[[ parachuteState:
			-1: Normal  
			0: Wearing parachute on back  
			1: Parachute opening  
			2: Parachute open  
			3: Falling to doom (e.g. after exiting parachute)  
			Normal means no parachute?  
		]]

		if IsControlPressed(0, Keys['E']) and not arrested and GetGameTimer() - OstatnioAresztowany > 10 * 1000 and MycurrentJobLeo and timeHeld > 60 and not IsPedInAnyVehicle(ped, false) and parachuteState <= 0 then	-- Mozesz tutaj zmienic przyciski
			TriggerEvent('esx_misc:togglehandcuff')
			timeHeld = 0
		end
		
		if IsControlPressed(0, Keys['E']) then
			timeHeld = timeHeld + 1
		else
			timeHeld = 0
		end
	end
end)

RegisterNetEvent('esx_misc:togglehandcuff') -- اول شي يتم طلب هذا الكود
AddEventHandler('esx_misc:togglehandcuff', function()
	local closestPlayer, distance = ESX.Game.GetClosestPlayer()
	
	if closestPlayer ~= -1 and distance <= Config.ArrestDistance then
		if IsPedDeadOrDying(GetPlayerPed(-1)) then
		
		elseif IsPedInAnyVehicle(GetPlayerPed(-1)) then
			ESX.ShowNotification("<font color=red>لايمكنك تقيد شخص وانت داخل المركبة")
		elseif IsPedInAnyVehicle(GetPlayerPed(closestPlayer)) then
			ESX.ShowNotification("<font color=red>لايمكن تقيد شخص داخل مركبه")
		elseif IsPedDeadOrDying(GetPlayerPed(closestPlayer)) then
			ESX.ShowNotification("<font color=red>لايمكن تقيد لاعب مغمى عليه او ميت")
		else
			if not arrested and not Aresztowany then
			
				if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'mp_arresting', 'idle', 3) ~= 1 then
					arrested = true
					OstatnioAresztowany = GetGameTimer()
					
					ESX.ShowNotification("جاري تقيد " ..GetPlayerName(closestPlayer))
					TriggerServerEvent('esx_misc:startAreszt', GetPlayerServerId(closestPlayer)) --في حال توافر الشروط كامله يتم طلب كود من السيرفر
				else
					ESX.ShowNotification("تم فك قيد " ..GetPlayerName(closestPlayer))
					TriggerServerEvent('esx_misc:startAreszt', GetPlayerServerId(closestPlayer)) --في حال توافر الشروط كامله يتم طلب كود من السيرفر
					Citizen.Wait(1000)
				end
			end
		end	
	else
		--ESX.ShowNotification("<font color=red>لايوجد لاعب قريب")
		ESX.ShowNotification("لايوجد لاعب قريب")
	end	
end)



RegisterNetEvent('esx_misc:handcuff')
AddEventHandler('esx_misc:handcuff', function(job)
	IsHandcuffed    = not IsHandcuffed
	local playerPed = PlayerPedId()
	Citizen.CreateThread(function()
		if IsHandcuffed then

			RequestAnimDict('mp_arresting')
			while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(100)
			end

			TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)

			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			SetPedCanPlayGestureAnims(playerPed, false)
			FreezeEntityPosition(playerPed, true)
			DisplayRadar(false)

			if Config.EnableHandcuffTimer then

				if HandcuffTimer.Active then
					ESX.ClearTimeout(HandcuffTimer.Task)
				end

				StartHandcuffTimer()
			end

		else

			if Config.EnableHandcuffTimer and HandcuffTimer.Active then
				ESX.ClearTimeout(HandcuffTimer.Task)
			end

			ClearPedSecondaryTask(playerPed)
			SetEnableHandcuffs(playerPed, false)
			DisablePlayerFiring(playerPed, false)
			SetPedCanPlayGestureAnims(playerPed, true)
			FreezeEntityPosition(playerPed, false)
			DisplayRadar(true)
		
			if DragStatus.IsDragged then	
				DetachEntity(PlayerPedId(), true, false)
			end
		end
	end)
end)

RegisterNetEvent('esx_misc:unrestrain')
AddEventHandler('esx_misc:unrestrain', function()
	if IsHandcuffed then
		local playerPed = PlayerPedId()
		IsHandcuffed = false

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)

		-- end timer
		if Config.EnableHandcuffTimer and HandcuffTimer.Active then
			ESX.ClearTimeout(HandcuffTimer.Task)
		end
	end
end)

function StartHandcuffTimer()
	if Config.EnableHandcuffTimer and HandcuffTimer.Active then
		ESX.ClearTimeout(HandcuffTimer.Task)
	end

	HandcuffTimer.Active = true

	HandcuffTimer.Task = ESX.SetTimeout(Config.HandcuffTimer, function()
		ESX.ShowNotification(_U('unrestrained_timer')) --#changeme
		TriggerEvent('esx_misc:unrestrain') --#changeme
		HandcuffTimer.Active = false
	end)
end

-- Handcuff
Citizen.CreateThread(function()
	while PlayerData == nil do
		Citizen.Wait(500)
	end
	
	while true do
		Citizen.Wait(1)
		local playerPed = PlayerPedId()

		if IsHandcuffed then
			
			if IsPedInAnyVehicle(playerPed) then
				DisableControlAction(0, 1, true) -- Disable pan
				DisableControlAction(0, 2, true) -- Disable tilt
			end
			
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

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('esx_misc:drag')
AddEventHandler('esx_misc:drag', function(copID)
	if not IsHandcuffed then
		return
	end
	
	DragStatus.IsDragged = not DragStatus.IsDragged
	DragStatus.CopId     = tonumber(copID)
end)

Citizen.CreateThread(function()
	local playerPed
	local targetPed

	while true do
		Citizen.Wait(1)

		if IsHandcuffed then
			playerPed = PlayerPedId()

			if DragStatus.IsDragged then
				targetPed = GetPlayerPed(GetPlayerFromServerId(DragStatus.CopId))

				-- undrag if target is in an vehicle
				if not IsPedSittingInAnyVehicle(targetPed) then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end

				if IsPedDeadOrDying(targetPed, true) then
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end

			else
				DetachEntity(playerPed, true, false)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('esx_misc:putInVehicle')
AddEventHandler('esx_misc:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if not IsHandcuffed then
		return
	end

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)
			print('put in vehicle max seats = ',maxSeats)
			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				DragStatus.IsDragged = false
			end
		end
	end
end)

RegisterNetEvent('esx_misc:OutVehicle')
AddEventHandler('esx_misc:OutVehicle', function()
	local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)

exports("ishandcuffedmisc", function()
	return IsHandcuffed
end)