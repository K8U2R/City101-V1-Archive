local PTFX_ASSET = 'ent_dst_elec_fire_sp'
local PTFX_DICT = 'core'
local LOOP_AMOUNT = 25
local PTFX_DURATION = 1000
-- draw scaleform multi use
--local function DisplayScaleform(title, description, time)
function DisplayScaleform2(title, description, time)
    if time == nil then time = 4000 end
    Citizen.CreateThread(function()
      local scaleform = RequestScaleformMovie("mp_big_message_freemode")
      while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
      end
    
      BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
      PushScaleformMovieMethodParameterString(title)
      PushScaleformMovieMethodParameterString(description)
      PushScaleformMovieMethodParameterInt(5)
      EndScaleformMovieMethod()
      
      local show = true
      Citizen.SetTimeout(6000, function()
        show = false
      end)
    
      while show do
        Citizen.Wait(0)
        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255) -- Draw the scaleform fullscreen
      end
    end)
end

RegisterNetEvent('esx_misc:controlSystemScaleform_givemoney')
AddEventHandler('esx_misc:controlSystemScaleform_givemoney', function(money)
	DisplayScaleform2("<FONT FACE='A9eelsh'>~w~ﻝﺎﻣ ﺀﺎﻄﻋﺇ", "<FONT FACE='A9eelsh'>~y~ﻡﺎﻌﻟﺍ ﻡﺎﻈﻨﻟﺍ ﻭ ﻦﻴﻧﺍﻮﻘﻟﺎﺑ ﻚﻣﺍﺰﺘﻟﺃ ﻰﻠﻋ ﺍﺮﻜﺷ ﻎﻠﺒﻣ ~g~$"..money.."~y~ ﺀﺎﻄﻋﺇ ﻢﺗ</font>", 6000)
	PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	--PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
end)



-------------------------------------
RegisterNetEvent('esx_misc:controlSystemScaleform_givemoney')
AddEventHandler('esx_misc:controlSystemScaleform_givemoney', function(money)
	DisplayScaleform2("<FONT FACE='A9eelsh'>~w~ﻝﺎﻣ ﺀﺎﻄﻋﺇ", "<FONT FACE='A9eelsh'>~y~ﻡﺎﻌﻟﺍ ﻡﺎﻈﻨﻟﺍ ﻭ ﻦﻴﻧﺍﻮﻘﻟﺎﺑ ﻚﻣﺍﺰﺘﻟﺃ ﻰﻠﻋ ﺍﺮﻜﺷ ﻎﻠﺒﻣ ~g~$"..money.."~y~ ﺀﺎﻄﻋﺇ ﻢﺗ</font>", 6000)
	PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	--PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
end)
RegisterNetEvent('esx_misc:controlSystemScaleform_rash')
AddEventHandler('esx_misc:controlSystemScaleform_rash', function()
	DisplayScaleform2("<FONT FACE='A9eelsh'>~w~ﺔﺼﺧﺭ ﺀﺎﻄﻋﺇ", "<FONT FACE='A9eelsh'>~y~ﻡﺎﻌﻟﺍ ﻡﺎﻈﻨﻟﺍ ﻭ ﻦﻴﻧﺍﻮﻘﻟﺎﺑ ﻚﻣﺍﺰﺘﻟﺃ ﻰﻠﻋ ﺍﺮﻜﺷ  ~g~~y~ </font>", 6000)
	PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	--PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
end)
RegisterNetEvent('esx_misc:controlSystemScaleform_giveshop')
AddEventHandler('esx_misc:controlSystemScaleform_giveshop', function(money)
	DisplayScaleform2("<FONT FACE='A9eelsh'>~w~ﺮﺠﺘﻣ ﺀﺎﻄﻋﺇ", "<FONT FACE='A9eelsh'>~y~  "..money.." ﻢﻗﺭ ﺮﺠﺘﻣ ﻚﻤﻴﻠﺴﺗ ﻢﺗ~g~~y~ </font>", 6000)
	PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	--PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
end)


RegisterNetEvent('esx_misc:controlSystemScaleform_removeshop')
AddEventHandler('esx_misc:controlSystemScaleform_removeshop', function()
	DisplayScaleform2("<FONT FACE='A9eelsh'>~w~ﺮﺠﺘﻣ ﺐﺤﺳ", "<FONT FACE='A9eelsh'>~r~مﺎﻌﻟﺍ مﺎﻈﻨﻟﺍ و ﻦﻴﻧﺍﻮﻘﻟﺎﺑ مﺍﺰﺘﻟﻷﺍ ءﺎﺟﺮﻟﺍ  ~b~</font>")
	--PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
end)


RegisterNetEvent('esx_misc:controlSystemScaleform_removeshopauto')
AddEventHandler('esx_misc:controlSystemScaleform_removeshopauto', function()
	DisplayScaleform2("<FONT FACE='A9eelsh'>~w~ﺮﺠﺘﻣ ﺐﺤﺳ", "<FONT FACE='A9eelsh'>~r~ تﺍﺭﺍﺬﻧﻻﺍ دﺪﻋ زﻭﺎﺠﺘﻟ ﻲﺋﺎﻘﻠﺗ كﺮﺠﺘﻣ ﺐﺤﺳ ﻢﺗ  ~b~</font>")
	--PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
end)

RegisterNetEvent('esx_misc:controlSystemScaleform_removelicsen')
AddEventHandler('esx_misc:controlSystemScaleform_removelicsen', function()
	DisplayScaleform2("<FONT FACE='A9eelsh'>~w~ﺔﺼﺧﺭ ﺐﺤﺳ", "<FONT FACE='A9eelsh'>~r~ مﺎﻌﻟﺍ مﺎﻈﻨﻟﺍ و ﻦﻴﻧﺍﻮﻘﻟﺎﺑ مﺍﺰﺘﻟﻷﺍ ءﺎﺟﺮﻟﺍ  ~b~</font>")
	--PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
end)
RegisterNetEvent('esx_misc:controlSystemScaleform_givecar')
AddEventHandler('esx_misc:controlSystemScaleform_givecar', function(money)
	DisplayScaleform2("<FONT FACE='A9eelsh'>~w~ﺔﺒﻛﺮﻣ ﺀﺎﻄﻋﺇ", "<FONT FACE='A9eelsh'>~y~ ~g~"..money.."~y~ ﺎﻬﺑ ﺔﺻﺎﺨﻟﺍ ﺔﺣﻮﻠﻟﺍ ﺔﺒﻛﺮﻣ ﻚﺋﺎﻄﻋﺍ ﻢﺗ</font>", 6000)
	PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	--PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
end)
RegisterNetEvent('esx_misc:controlSystemScaleform_take_car')
AddEventHandler('esx_misc:controlSystemScaleform_take_car', function(plate, reason)
	DisplayScaleform2("<FONT FACE='A9eelsh'>~r~ﺔﺒﻛﺮﻣ ةﺭﺩﺎﺼﻣ", "<FONT FACE='A9eelsh'>~y~ﻦﻴﻧﺍﻮﻘﻟﺎﺑ مﺍﺰﺘﻟﻷﺍ ءﺎﺟﺮﻟﺍ ~g~"..plate.."~y~ ﺔﺣﻮﻟ ب ﺔﺒﻛﺮﻣ ةﺭﺩﺎﺼﻣ ﺖﻤﺗ</font>", 6000)
	PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	--PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
end)

RegisterNetEvent('esx_misc:controlSystemScaleform_givemoney_toAll')
AddEventHandler('esx_misc:controlSystemScaleform_givemoney_toAll', function(money)
	DisplayScaleform2("<FONT FACE='A9eelsh'>~w~ﻝﺎﻣ ﺀﺎﻄﻋﺇ", "<FONT FACE='A9eelsh'>~y~ﺎﻴﻟﺎﺣ ﻦﻴﻠﺼﺘﻤﻟﺍ ﻦﻴﺒﻋﻼﻟﺍ ﻊﻴﻤﺠﻟ ~g~$"..money.."~y~ ﻎﻠﺒﻣ ﺀﺎﻄﻋﺇ ﻢﺗ</font>", 6000)
	PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	--PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
end)

RegisterNetEvent('esx_misc:controlSystemScaleform_giveXP_toAll')
AddEventHandler('esx_misc:controlSystemScaleform_giveXP_toAll', function(XP)
	DisplayScaleform2("<FONT FACE='A9eelsh'>~w~ﺓﺮﺒﺧ ﺀﺎﻄﻋﺇ", "<FONT FACE='A9eelsh'>~y~ﺎﻴﻟﺎﺣ ﻦﻴﻠﺼﺘﻤﻟﺍ ﻦﻴﺒﻋﻼﻟﺍ ﻊﻴﻤﺠﻟ ﺓﺮﺒﺧ ~b~"..XP.."~y~ ﺀﺎﻄﻋﺇ ﻢﺗ</font>", 6000)
	PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	--PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
end)

RegisterNetEvent('esx_misc:controlSystemScaleform_threb_start')
AddEventHandler('esx_misc:controlSystemScaleform_threb_start', function()
	DisplayScaleform2("<FONT FACE='A9eelsh'>~w~تﺎﻋﻮﻨﻤﻣ ﺐﻳﺮﻬﺗ", "<FONT FACE='A9eelsh'>~g~ﺐﻳﺮﻬﺘﻟﺍ ﺖﻗﻭ أﺪﺑ</font>", 6000)
	PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	--PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
end)

RegisterNetEvent('esx_misc:controlSystemScaleform_threb_end')
AddEventHandler('esx_misc:controlSystemScaleform_threb_end', function()
	DisplayScaleform2("<FONT FACE='A9eelsh'>~w~تﺎﻋﻮﻨﻤﻣ ﺐﻳﺮﻬﺗ", "<FONT FACE='A9eelsh'>~r~ﺐﻳﺮﻬﺘﻟﺍ ﺖﻗﻭ ﻰﻬﺘﻧﺍ</font>", 6000)
	PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	--PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
end)


RegisterNetEvent('esx_misc:controlSystemScaleform_giveXP')
AddEventHandler('esx_misc:controlSystemScaleform_giveXP', function(XP)
	DisplayScaleform2("<FONT FACE='A9eelsh'>~w~ﺓﺮﺒﺧ ﺀﺎﻄﻋﺇ", "<FONT FACE='A9eelsh'>~y~ﻡﺎﻌﻟﺍ ﻡﺎﻈﻨﻟﺍ ﻭ ﻦﻴﻧﺍﻮﻘﻟﺎﺑ ﻚﻣﺍﺰﺘﻟﺃ ﻰﻠﻋ ﺍﺮﻜﺷ ﺓﺮﺒﺧ ~b~"..XP.."~y~ ﻚﺋﺎﻄﻋﺇ ﻢﺗ</font>")
	PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	--PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
end)

RegisterNetEvent('esx_misc:controlSystemScaleform_ghramh')
AddEventHandler('esx_misc:controlSystemScaleform_ghramh', function(XP)
	DisplayScaleform2("<FONT FACE='A9eelsh'>~w~ﺔﻣﺍﺮﻏ ﺀﺎﻄﻋﺇ", "<FONT FACE='A9eelsh'>~y~ﻦﻴﻧﺍﻮﻘﻟﺎﺑ مﺍﺰﺘﻟﻷﺍ ءﺎﺟﺮﻟﺍ ~b~"..XP.."~y~ ﺔﻤﻴﻘﺑ ﺔﻴﻟﺎﻣ ﺔﻣﺍﺮﻏ ﻚﺋﺎﻄﻋﺍ ﻢﺗ</font>")
	PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	--PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
end)

RegisterNetEvent('esx_misc:controlSystemScaleform_start')
AddEventHandler('esx_misc:controlSystemScaleform_start', function(money, xp)
	DisplayScaleform2("<FONT FACE='A9eelsh'>~w~ﺔﻳﺍﺪﺒﻟﺍ ﺔﻗﺎﺑ", "<FONT FACE='A9eelsh'>~w~ ﻎﻠﺒﻣ ~g~$" .. money .. "~w~ و~b~" .. " ةﺮﺒﺧ ~g~" .. xp .. " ~y~ﻚﻤﻴﻠﺴﺗ ﻢﺗ</font>")
	PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	--PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
end)

RegisterNetEvent('esx_misc:controlSystemScaleform_t3wed')
AddEventHandler('esx_misc:controlSystemScaleform_t3wed', function(XP)
	DisplayScaleform2("<FONT FACE='A9eelsh'>~w~ﺾﻳﻮﻌﺗ", "<FONT FACE='A9eelsh'>~y~ﺮﻓﺮﻴﺴﻟﺍ ﻞﻴﻔﻘﺗ ﺾﻳﻮﻌﺗ ﻎﻠﺒﻣ ~b~$"..XP.."~y~ ءﺎﻄﻋﺍ ﻢﺗ</font>")
	PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	--PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
end)

RegisterNetEvent('esx_misc:controlSystemScaleform_t3wedXP')
AddEventHandler('esx_misc:controlSystemScaleform_t3wedXP', function(XP)
	DisplayScaleform2("<FONT FACE='A9eelsh'>~w~ﺾﻳﻮﻌﺗ", "<FONT FACE='A9eelsh'>~y~ﺮﻓﺮﻴﺴﻟﺍ ﻞﻴﻔﻘﺗ ﺾﻳﻮﻌﺗ ةﺮﺒﺧ ~b~"..XP.."~y~ ءﺎﻄﻋﺍ ﻢﺗ</font>")
	PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	--PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
end)

RegisterNetEvent('esx_misc:controlSystemScaleform_astd3a')
AddEventHandler('esx_misc:controlSystemScaleform_astd3a', function()
	DisplayScaleform2("<FONT FACE='A9eelsh'>~w~ءﺎﻋﺪﺘﺳﺍ", "<FONT FACE='A9eelsh'>~y~ةﺪﻋﺎﺴﻤﻟﺍ و ﻢﻋﺪﻟﺍ دﺭﻮﻜﺳﺪﻟﺍ ﻰﻟﺍ ﻪﺟﻮﺗ ﻚﻴﻠﻋ</font>")
	PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	--PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
end)

RegisterNetEvent('esx_misc:controlSystemScaleform_systembankmoneyget')
AddEventHandler('esx_misc:controlSystemScaleform_systembankmoneyget', function(money)
	DisplayScaleform2("<FONT FACE='A9eelsh'>~w~ضﺮﻗ ﺬﺧﺍ", "<FONT FACE='A9eelsh'>~y~ﺔﻤﻴﻘﺑ ~b~$"..money.."~y~ ضﺮﻗ تﺬﺧﺍ ﺪﻘﻟ</font>")
	PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	--PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
end)

RegisterNetEvent('esx_misc:controlSystemScaleform_systembankmoneyend')
AddEventHandler('esx_misc:controlSystemScaleform_systembankmoneyend', function()
	DisplayScaleform2("<FONT FACE='A9eelsh'>~w~ضﺮﻘﻟﺍ ةﺪﻣ ءﺎﻬﺘﻧﺍ", "<FONT FACE='A9eelsh'>~y~ضﺮﻘﻟﺍ ةﺪﻣ ﺖﻬﺘﻧﺍ ﺪﻘﻟ كﻭﺮﺒﻣ</font>")
	PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	--PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
end)

RegisterNetEvent("esx_misc:Teleport")
AddEventHandler("esx_misc:Teleport", function(coords, heading)
    local isTeleporting = false
	local playerPed = PlayerPedId()
	TriggerEvent("esx_misc:hidehud", true)
	FreezeEntityPosition(GetPlayerPed(-1), true)
    SwitchOutPlayer(PlayerPedId(), 0, 1)
	
		SetEntityAlpha(PlayerPedId(), 1000, false)
		FreezeEntityPosition(GetPlayerPed(-1), false)
		TeleportMenuIsOpen = false
		isTeleporting = true
		Citizen.CreateThread(function()	
		while isTeleporting do
			Citizen.Wait(0)
			if PlayerData.job.name ~= 'admin' then
			DisableAllControlActions(0)
		end
		end
	end)
	Citizen.Wait(1000)
	SetEntityVisible(playerPed, false, true)
	--sky()
	--DoScreenFadeOut(800)
    
	--[[
	while not IsScreenFadedOut() do
		Citizen.Wait(500)
	end]]
    
	Citizen.Wait(1000)
	FreezeEntityPosition(GetPlayerPed(-1), false)
	ESX.Game.Teleport(playerPed, coords, function()
		--DoScreenFadeIn(800)

		if heading then
			SetEntityHeading(playerPed, heading)
		end
	end)
	FreezeEntityPosition(GetPlayerPed(-1), true)
	--Citizen.Wait(5000)
	--SwitchInPlayer(PlayerPedId())
	
	local player = PlayerId()
    local timer = GetGameTimer()
	
	--local delaytime = 15 * 1000
	local delaytime = 1 * 1000
	ShowLoadingPromt('Teleporting', delaytime, 3) -- loading icon
	while true do
        Citizen.Wait(0)
        		
        -- wait 20 seconds before starting the switch to the player
        if GetGameTimer() - timer > delaytime then
			
			Citizen.Wait(1000)
			
			
            -- Switch to the player.
            SwitchInPlayer(PlayerPedId())
            
            -- Wait for the player switch to be completed (state 12).
            while GetPlayerSwitchState() ~= 12 do
                Citizen.Wait(0)
            end
			FreezeEntityPosition(GetPlayerPed(-1), false)
			SetEntityVisible(playerPed, true, false)
            -- Stop the infinite loop.
            break
        end
    end
	--PedId = PlayerPedId()
	isTeleporting = false
	TriggerEvent("esx_misc:hidehud", false)
	Citizen.Wait(150)
	--TriggerServerEvent('esx_misc:syncPtfxEffecte', PlayerPedId())
	--createPlayerModePtfxLoop(PedId)
end)

RegisterNetEvent('esx_misc:controlSystemScaleform_anthar')
AddEventHandler('esx_misc:controlSystemScaleform_anthar', function()
	DisplayScaleform2("<FONT FACE='A9eelsh'>~w~رﺍﺬﻧﺍ ءﺎﻄﻋﺍ", "<FONT FACE='A9eelsh'>~y~ﻦﻴﻧﺍﻮﻘﻟﺎﺑ مﺍﺰﺘﻟﻷﺍ ءﺎﺟﺮﻟﺍ ~y~ رﺍﺬﻧﺍ ﻚﺋﺎﻄﻋﺍ ﻢﺗ</font>")
	PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	--PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
end)

RegisterNetEvent('esx_misc:controlSystemScaleform_removeXP')
AddEventHandler('esx_misc:controlSystemScaleform_removeXP', function(XP)
	DisplayScaleform2("<FONT FACE='A9eelsh'>~w~ﺓﺮﺒﺧ ﻢﺼﺧ", "<FONT FACE='A9eelsh'>~r~مﺎﻌﻟﺍ مﺎﻈﻨﻟﺍ و ﻦﻴﻧﺍﻮﻘﻟﺎﺑ مﺍﺰﺘﻟﻷﺍ ءﺎﺟﺮﻟﺍ ﺓﺮﺒﺧ ~b~"..XP.."~r~ ﻢﺼﺧ ﻢﺗ</font>")
	--PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
end)

RegisterNetEvent('esx_misc:controlSystemScaleform_mzadMabrok')
AddEventHandler('esx_misc:controlSystemScaleform_mzadMabrok', function(name_shop)
	DisplayScaleform2("<FONT FACE='A9eelsh'>~w~دﺍﺰﻤﻟﺎﺑ ﺰﺋﺎﻓ", "<FONT FACE='A9eelsh'>~w~ﻚﺗﺎﻜﻠﺘﻤﻣ ﻰﻟﺍ ~g~"..name_shop.."~w~ لﺍ ﺔﻴﻜﻠﻣ ﻞﻳﻮﺤﺗ ﻢﺗ</font>")
	--PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
end)

RegisterNetEvent('esx_misc:controlSystemScaleform_mzadMabrokCar')
AddEventHandler('esx_misc:controlSystemScaleform_mzadMabrokCar', function(car_plate)
	DisplayScaleform2("<FONT FACE='A9eelsh'>~w~دﺍﺰﻤﻟﺎﺑ ﺰﺋﺎﻓ", "<FONT FACE='A9eelsh'>~w~ﻚﺟﺍﺮﻛ ﻲﻓ ~g~"..car_plate.."~w~ ﺔﺒﻛﺮﻤﻟﺍ ﻞﻳﻮﺤﺗ ﻢﺗ</font>")
	--PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
end)

RegisterNetEvent('esx_misc:controlSystemScaleform_removeMoney')
AddEventHandler('esx_misc:controlSystemScaleform_removeMoney', function(XP)
	DisplayScaleform2("<FONT FACE='A9eelsh'>~w~ﻎﻠﺒﻣ ﻢﺼﺧ", "<FONT FACE='A9eelsh'>~r~مﺎﻌﻟﺍ مﺎﻈﻨﻟﺍ و ﻦﻴﻧﺍﻮﻘﻟﺎﺑ مﺍﺰﺘﻟﻷﺍ ءﺎﺟﺮﻟﺍ ﻎﻠﺒﻣ ~g~$"..XP.."~r~ ﻢﺼﺧ ﻢﺗ</font>")
	--PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
end)