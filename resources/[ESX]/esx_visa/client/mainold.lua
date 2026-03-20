local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }
  
  --	StartTheoryTest()
  
  ESX                     = nil
  local Licenses          = {}
  local CurrentTest       = nil
  local syncyingVisa		= true
  
  function IsPlayerVisaTesting()
	  if CurrentTest ~= nil and CurrentTest == 'theory' then
		  return true
	  else
		  return false
	  end
  end
  
  
  Citizen.CreateThread(function()
	  while ESX == nil do
		  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		  Citizen.Wait(100)
	  end
	  end)

  function StartTheoryTest()
	  CurrentTest = 'theory'
  
	  SendNUIMessage({
		  openQuestion = true
	  })
  
	  ESX.SetTimeout(200, function()
		  SetNuiFocus(true, true)
	  end)
  
	  --TriggerServerEvent('esx_visa:pay', Config.Prices['dmv'])
  end
  
  function StopTheoryTest(success)
	  CurrentTest = nil
  
	  SendNUIMessage({
		  openQuestion = false
	  })
  
	  SetNuiFocus(false)
  
	  if success then
		  TriggerServerEvent('esx_visa:addLicense', 'visa')
		  ESX.ShowNotification('<font color=gold>لقد حصلت على تأشيرة دخول لمدينة النهاية')
	  else
		  ESX.ShowNotification('<font color=red>رسبت في الاختبار. حاول مرة اخرى')
		  Citizen.Wait(3000)
		  TriggerServerEvent('esx_visa:kickplayer', '39vma66J83c')
		  Citizen.Wait(6000)
	  end
	  
	  syncyingVisa = false
  end
  
  RegisterNUICallback('question', function(data, cb)
	SendNUIMessage({
		openSection = 'question'
	})

	cb('OK')
end)
  
  RegisterNUICallback('close', function(data, cb)
	  StopTheoryTest(true)
	  cb('OK')
  end)
  
  RegisterNUICallback('kick', function(data, cb)
	  StopTheoryTest(false)
	  cb('OK')
  end)
  
  RegisterNetEvent('esx_visa:loadLicenses')
  AddEventHandler('esx_visa:loadLicenses', function(licenses)
	  Licenses = licenses
  end)
  
  TriggerServerEvent("interview:get:question")
  RegisterNetEvent("interview:get:question")
  AddEventHandler("interview:get:question", function(data)
	  SendNUIMessage({ questions = data })
  end)

  function isPlayerHaveVisa()
	  for i=1,#Licenses,1 do
		  --print(' Licenses['..i..'].type = '..Licenses[i].type)
		  if Licenses[i].type == 'visa' then
			  return true
		  end
	  end
	  
	  return false
  end
  
  -- Block UI
  Citizen.CreateThread(function()
	  while true do
		  Citizen.Wait(1)
  
		  if CurrentTest == 'theory' then
			  local playerPed = PlayerPedId()
  
			  DisableControlAction(0, 1, true) -- LookLeftRight
			  DisableControlAction(0, 2, true) -- LookUpDown
			  DisablePlayerFiring(playerPed, true) -- Disable weapon firing
			  DisableControlAction(0, 142, true) -- MeleeAtesxkAlternate
			  DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
		  else
			  Citizen.Wait(2000)
		  end
	  end
  end)
  
  local loadingScreenOff = false
AddEventHandler('esx:loadingScreenOff', function()
--AddEventHandler("playerSpawned", function ()
	-- If not already ran
	if not loadingScreenOff then
		loadingScreenOff = true
		Citizen.CreateThread(function()
			ClearScreen()
			ToggleSound(true)
			Citizen.Wait(500)
			
			-- Switch out the player if it isn't already in a switch state.
			if not IsPlayerSwitchInProgress() then
				SwitchOutPlayer(PlayerPedId(), 0, 1)
			end
			
			-- Wait for the switch cam to be in the sky in the 'waiting' state (5).
			while GetPlayerSwitchState() ~= 5 do
				Citizen.Wait(0)
			end
			
			local count = 1
			-- Shut down the NUI loading screen.
			ShutdownLoadingScreen()
			ShutdownLoadingScreenNui()
			
			Citizen.Wait(3000)
			
			while GetIsLoadingScreenActive() do
				ShutdownLoadingScreen()
				ShutdownLoadingScreenNui()
				count = count + 1
				Citizen.Wait(3000)
			end
			
			--when player land from the sky set visible and unfreeze
			unfreezeplayer()
			startskytransition()
		end)
	end	
end)

function unfreezeplayer()
	Citizen.CreateThread(function()
		while GetPlayerSwitchState() ~= 12 do
			Citizen.Wait(0)
		end
			
		SetEntityVisible(GetPlayerPed(-1), true)
		FreezeEntityPosition(GetPlayerPed(-1), false)
	end)
end
  

  ---- JOIN TRANSITION ----
  ---- JOIN TRANSITION ----
  ---- JOIN TRANSITION ----
  
  -- Copyright © Vespura 2018
  -- Edit it if you want, but don't re-release this without my permission, and never claim it to be yours!
  
  ------- Configurable options  -------
  
  -- set the opacity of the clouds
  local cloudOpacity = 0.01 -- (default: 0.01)
  
  -- setting this to false will NOT mute the sound as soon as the game loads 
  -- (you will hear background noises while on the loading screen, so not recommended)
  local muteSound = true -- (default: true)
  
  
  ------- Code -------
  
  -- Mutes or un-mutes the game's sound using a short fade in/out transition.
  function ToggleSound(state)
	  if state then
		  StartAudioScene("MP_LEADERBOARD_SCENE");
	  else
		  StopAudioScene("MP_LEADERBOARD_SCENE");
	  end
  end
  
  -- Runs the initial setup whenever the script is loaded.
  function InitialSetup()
	  -- Stopping the loading screen from automatically being dismissed.
	  --SetManualShutdownLoadingScreenNui(true) --not supported after 5/9/2019 update
	  -- Disable sound (if configured)
	  ToggleSound(muteSound)
	  -- Switch out the player if it isn't already in a switch state.
	  if not IsPlayerSwitchInProgress() then
		  SwitchOutPlayer(PlayerPedId(), 0, 1)
	  end
  end
  
  -- Hide radar & HUD, set cloud opacity, and use a hacky way of removing third party resource HUD elements.
  function ClearScreen()
    Citizen.CreateThread(function()
		while GetPlayerSwitchState() ~= 12 do
			Citizen.Wait(0)
	
			SetCloudHatOpacity(cloudOpacity)
			HideHudAndRadarThisFrame()
    
			-- nice hack to 'hide' HUD elements from other resources/scripts. kinda buggy though.
			SetDrawOrigin(0.0, 0.0, 0.0, 0)
		end	
	end)		
end
  
  -- Sometimes this gets called too early, but sometimes it's perfectly timed,
  -- we need this to be as early as possible, without it being TOO early, it's a gamble!
  InitialSetup()
  
  
  Citizen.CreateThread(function()	
	  FreezeEntityPosition(PlayerPedId(), true)
	  -- In case it was called too early before, call it again just in case.
	  InitialSetup()
	  
	  while ESX == nil do
		  Citizen.Wait(1)
	  end
	  
	  -- Wait for the switch cam to be in the sky in the 'waiting' state (5).
	  while GetPlayerSwitchState() ~= 5 do
		  Citizen.Wait(0)
		  ClearScreen()
	  end
	  
	  -- Shut down the game's loading screen (this is NOT the NUI loading screen).
	  --ShutdownLoadingScreen()
	  
	  ClearScreen()
	  Citizen.Wait(0)
	  DoScreenFadeOut(0)
	  
	  -- Shut down the NUI loading screen.
	  ShutdownLoadingScreenNui()
	  
	  ClearScreen()
	  Citizen.Wait(0)
	  ClearScreen()
	  DoScreenFadeIn(500)
	  
	  while not IsScreenFadedIn() do
		  Citizen.Wait(0)
		  ClearScreen()
	  end
	  
	  local player = PlayerId()
	  local timer = GetGameTimer()
	  
	  local delaytime = 15 * 1000
	  
	  -- Re-enable the sound in case it was muted.
	  ToggleSound(false)
	  ShowLoadingPromt('Loading', delaytime, 3) -- loading icon
	  
	  while true do
		  ClearScreen()
		  Citizen.Wait(0)
				  
		  -- wait 20 seconds before starting the switch to the player
		  if GetGameTimer() - timer > delaytime then
			  
			  --[[wait server to get player licenses
			  if Licenses[1] == nil then
				  Citizen.Wait(3000)
			  end]]
			  
			  --check if player have visa
			  if Config.checkVisa then
				  if isPlayerHaveVisa() then
					  syncyingVisa = false
					  CurrentTest = nil
				  else
					  --start theory test
					  StartTheoryTest()
					  DisplayRadar(false)
					  Citizen.Wait(1000)
				  end
			  else
				  syncyingVisa = false
				  CurrentTest = nil
			  end
			  
			  --wait if player testing theory
			  while CurrentTest ~= nil or syncyingVisa do
				  Citizen.Wait(1000)
			  end
			  
			  -- Switch to the player.
			  SwitchInPlayer(PlayerPedId())
			  
			  ClearScreen()
			  
			  -- Wait for the player switch to be completed (state 12).
			  while GetPlayerSwitchState() ~= 12 do
				  Citizen.Wait(0)
				  ClearScreen()
			  end
			  -- Stop the infinite loop.
			  break
		  end
	  end
	  
	  -- Reset the draw origin, just in case (allowing HUD elements to re-appear correctly)
	  ClearDrawOrigin()
	  TriggerEvent('esx_visa:updateTestState', false) --false = finish testing
  end)
  
  function startskytransition()
    DoScreenFadeIn(500)
    
	while not IsScreenFadedIn() do
        Citizen.Wait(0)
        --ClearScreen()
    end
    
    local player = PlayerId()
    local timer = GetGameTimer()
	
	local delaytime = 15 * 1000
    
	-- Re-enable the sound in case it was muted.
    ToggleSound(false)
    ShowLoadingPromt('Loading', delaytime, 3) -- loading icon
    
	while true do
        --ClearScreen()
        Citizen.Wait(0)
        		
        -- wait 20 seconds before starting the switch to the player
        if GetGameTimer() - timer > delaytime then
			
			--[[wait server to get player licenses
			if Licenses[1] == nil then
				Citizen.Wait(3000)
			end]]
			
			--check if player have visa
			if Config.checkVisa then
				if isPlayerHaveVisa() then
					syncyingVisa = false
					CurrentTest = nil
				else
					--start theory test
					StartTheoryTest()
					DisplayRadar(false)
					Citizen.Wait(1000)
				end
			else
				syncyingVisa = false
				CurrentTest = nil
			end
			
			--wait if player testing theory
			while CurrentTest ~= nil or syncyingVisa do
				Citizen.Wait(1000)
			end
			
            -- Switch to the player.
            SwitchInPlayer(PlayerPedId())
            
            --ClearScreen()
            
            -- Wait for the player switch to be completed (state 12).
            while GetPlayerSwitchState() ~= 12 do
                Citizen.Wait(0)
                --ClearScreen()
            end

            -- Stop the infinite loop.
            break
        end
    end
    
    -- Reset the draw origin, just in case (allowing HUD elements to re-appear correctly)
    ClearDrawOrigin()
	TriggerEvent('esx_visa:updateTestState', false) --false = finish testing
end

  function ShowLoadingPromt(msg, time, type)
	Citizen.CreateThread(function()
	  Citizen.Wait(0)
	  
	  BeginTextCommandBusyString("STRING")
	  AddTextComponentString(msg)
	  EndTextCommandBusyString(type)
	  
	  Citizen.Wait(time)
	  
	  RemoveLoadingPrompt()
	end)
  end  

  RegisterNetEvent("interview:get:question")
AddEventHandler("interview:get:question", function(data)
	SendNUIMessage({ questions = data })
end)