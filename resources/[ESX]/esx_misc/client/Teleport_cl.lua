local TeleportMenuIsOpen = false


-- Applies the particle effect to a ped
local PTFX_ASSET = 'ent_dst_elec_fire_sp'
local PTFX_DICT = 'core'
local LOOP_AMOUNT = 25
local PTFX_DURATION = 1000
--[[function createPlayerModePtfxLoop(tgtPedId) -- need to duo a syncPtfxEffect
    CreateThread(function()
        RequestNamedPtfxAsset(PTFX_DICT)
		
        local playerPed = tgtPedId

        -- Wait until it's done loading.
        while not HasNamedPtfxAssetLoaded(PTFX_DICT) do
            Wait(0)
        end

        local particleTbl = {}

        for i=0, LOOP_AMOUNT do
            UseParticleFxAssetNextCall(PTFX_DICT)
            --local partiResult = StartParticleFxLoopedOnEntity(PTFX_ASSET, playerPed, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, false, false, false)
            local partiResult = StartParticleFxLoopedOnEntity(PTFX_ASSET, playerPed, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.5, false, false, false)
            particleTbl[#particleTbl + 1] = partiResult
            Wait(0)
        end

        Wait(PTFX_DURATION)
        for _, parti in ipairs(particleTbl) do
            StopParticleFxLooped(parti, true)
        end
    end)
end]]

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

function Teleport(coords, heading)
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
end

--[[RegisterNetEvent("esx_misc:syncPtfxEffect_cl")
AddEventHandler("esx_misc:syncPtfxEffect_cl", function(tgtSrc)
    local tgtPlayer = GetPlayerFromServerId(tgtSrc)
    local tgtPlayerPed = GetPlayerPed(tgtPlayer)
    --if tgtSrc == 0 then return end
    createPlayerModePtfxLoop(tgtPlayerPed)
end)]]

local canOpenMenu = false
RegisterNetEvent("esx_misc:StartTeleport")
AddEventHandler("esx_misc:StartTeleport", function(value)
    if value == 'all' then
		TriggerEvent('chatMessage', " ⭐ الرقابة و التفتيش  " ,  {198, 40, 40} ,  "إعادة توزيع اللاعبين قائمة الأنتقال - اختياري")
	elseif value == "all_with_check_jail" then
		TriggerEvent('chatMessage', " ⭐ الرقابة و التفتيش  " ,  {198, 40, 40} ,  "إعادة توزيع اللاعبين قائمة الأنتقال - اختياري")
	else
		TriggerEvent('chatMessage', " ⭐ الرقابة و التفتيش  " ,  {198, 40, 40} ,  "قائمة الأنتقال - اختياري")
	end
    DisplayScaleform2("<FONT FACE='A9eelsh'>~w~ﻱﺭﺎﻴﺘﺧﺍ ﻝﺎﻘﺘﻧﺍ ﺔﻤﺋﺎﻗ", "<FONT FACE='A9eelsh'>ﻝﺎﻘﺘﻧﻻﺍ ﺔﻤﺋﺎﻗ ﺢﺘﻓ ﻲﻓ ﺐﻏﺮﺗ ﺖﻨﻛ ﺍﺫﺇ ~r~G~w~ ﺔﻠﻀﻋ ﻂﻐﻀﻟ ﺪﻌﺘﺳﺃ</font>", 6000)
	PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	
	Citizen.Wait(5000)
	canOpenMenu = true
	ESX.ShowHelpNotification('~r~G~w~ ﻝﺎﻘﺘﻧﻷﺍ ﺔﻤﺋﺎﻗ')
	
	Citizen.CreateThread(function()
	local sleep = 0
    while true do
		Citizen.Wait(0)
        
		if IsControlJustReleased(0, 58) then
		if canOpenMenu then
		OpenTeleportMenu()
		else
		sleep = 3000
		end
		end
	end
	
	Citizen.Wait(sleep)
end)
	
	Citizen.Wait(7000)
	canOpenMenu = false
end)

local canOpenMenu = false
RegisterNetEvent("esx_misc:StartTeleportPlayer")
AddEventHandler("esx_misc:StartTeleportPlayer", function(PlayerId, xPlayer, xTarget)	
	local xPlayer = xPlayer
	local xTarget = xTarget
	local PlayerId = PlayerId
	TriggerServerEvent("esx_misc:SwapPlayer", PlayerId, true, xTarget)
end)
RegisterNetEvent("esx_misc:OpenMenu")
AddEventHandler("esx_misc:OpenMenu", function(PlayerId)
    local PlayerId = PlayerId
	TeleportMenuIsOpen = true

	
	local elements = {}
	local elements2 = {}
	
	table.insert(elements, {label = 'قائمة المعارض', value = 'VehShopsMenu'})
	table.insert(elements, {label = '<font color=MediumPurple>مركز التوظيف</font>', coords = vector3(-612.636, -349.5931, 34.83934), heading = 232.92944335938})
	--table.insert(elements, {label = '<font color=white>موقع المزاد</font>', coords = vector3(699.1099853515625, 619.6099853515625, 128.91000366210938), heading = 290.51049804688})
	--# كراجات
	table.insert(elements, {label = '<font color=Blue>كراج لوس 1</font>', coords = vector3(192.9898, -1449.284, 29.14163), heading = 232.92944335938})
	table.insert(elements, {label = '<font color=Blue>كراج لوس 2</font>', coords = vector3(862.1312, -1336.547, 26.053), heading = 128.34576416016})
	table.insert(elements, {label = '<font color=Blue>كراج ساندي</font>', coords = vector3(1740.82, 3714.374, 34.11332), heading = 53.582233428955})
	table.insert(elements, {label = '<font color=Blue>كراج بليتو</font>', coords = vector3(-219.3883, 6263.184, 31.68427), heading = 170.86059570313})
	--# حجز
	table.insert(elements, {label = '<font color=orange>حجز لوس</font>', coords = vector3(408.5297, -1612.622, 29.29156), heading = 314.80520629883})
	table.insert(elements, {label = '<font color=orange>حجز ساندي</font>', coords = vector3(1739.656, 3610.097, 34.91333), heading = 313.28057861328})
	table.insert(elements, {label = '<font color=orange>حجز بليتو</font>', coords = vector3(-360.1978, 6062.771, 31.50014), heading = 346.0390625})
	--# شاحنات
	table.insert(elements, {label = '<font color=brown>شاحنات لوس</font>', coords = vector3(861.0832, -1579.692, 31.0382), heading = 62.513187408447})
	table.insert(elements, {label = '<font color=brown>شاحنات ساندي</font>', coords = vector3(177.3994, 2809.435, 45.31482), heading = 271.14010620117})
	table.insert(elements, {label = '<font color=brown>شاحنات بليتو</font>', coords = vector3(-275.8618, 6020.795, 31.997), heading = 357.32211303711})
	--# قائمة المعارض
	table.insert(elements2, {label = '<font color=gold>سيارات جديد</font>', coords = vector3(2196.173, 2912.302, 46.5373), heading = 91.909492492676})
	table.insert(elements2, {label = '<font color=gold>شاحنات جديد</font>', coords = vector3(1232.078, 2726.086, 38.00418), heading = 136.00520324707})
	--# اَخر
	table.insert(elements, {label = '<font color=gold>مركز إدارة الرقابة و التفتيش</font>', coords = vector3(230.2241, -1148.274, 29.31121), heading = 85.065399169922})
	
	
	if PlayerData.job.name == 'police' or PlayerData.job.name == 'admin' then
		table.insert(elements, {label = '<font color=Blue>مركز شرطة لوس</font>', coords = vector3(411.1493, -966.9874, 29.46332), heading = 87.328079223633})
		table.insert(elements, {label = '<font color=Blue>مركز شرطة ساندي</font>', coords = vector3(1877.479, 3665.073, 33.64734), heading = 28.225255966187})
		table.insert(elements, {label = '<font color=Blue>مركز شرطة بليتو</font>', coords = vector3(-427.7365, 6032.241, 31.49011), heading = 291.93078613281})
	end
	
	if PlayerData.job.name == 'agent' or PlayerData.job.name == 'police' or PlayerData.job.name == 'admin' then
		table.insert(elements, {label = '<font color=green>ميناء مدينة 101 البحري</font>', coords = vector3(787.3835, -2958.627, 6.038402), heading = 92.161666870117})
		table.insert(elements, {label = '<font color=green>ميناء مدينة 101 الغربي</font>', coords = vector3(-52.10347, -2529.776, 6.152335), heading = 145.83110046387})
	end
	
	if PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'admin' then
		table.insert(elements, {label = '<font color=red>مستشفى لوس السلام</font>', coords = vector3(374.3611, -574.7087, 28.84346), heading = 269.00588989258})
		table.insert(elements, {label = '<font color=red>مستشفى بجانب كراج لوس 1</font>', coords = vector3(309.4666, -1452.621, 29.96651), heading = 51.175903320313})
		table.insert(elements, {label = '<font color=red>مستشفى بجانب كراج لوس 2</font>', coords = vector3(787.3835, -2958.627, 6.038402), heading = 92.161666870117})
		table.insert(elements, {label = '<font color=red>مستشفى ساندي</font>', coords = vector3(1806.807, 3670.695, 34.27539), heading = 300.43865966797})
		table.insert(elements, {label = '<font color=red>مستشفى بليتو</font>', coords = vector3(-239.7325, 6313.521, 31.48951), heading = 222.32019042969})
	end
	
	table.insert(elements, {label = 'إلغاء الإنتقال', value = 'closeMenu'})
	
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'TeleportMenu', {
		title    = 'قائمة أنتقال - إختياري',
		align    = 'bottom-right',
		elements = elements
	}, function(data2, TeleportMenu)
		local action = data2.current.value
		local coords = data2.current.coords
		local heading = data2.current.heading

		if action == 'VehShopsMenu' then
            ---------------------------
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'VehShopsMenu', {
				title    = 'قائمة أنتقال - المعارض',
				align    = 'bottom-right',
				elements = elements2
			}, function(data12, menu12)
				menu12.close()
				local action2 = data12.current.value
				local coords2 = data12.current.coords
		        local heading2 = data12.current.heading
				TriggerServerEvent('esx_misc:SwapPlayer2', PlayerId, coords2, heading2)
			end, function(data12, menu12)
				menu12.close()
			end)
			--------------------------
				elseif action == 'closeMenu' then
					TeleportMenu.close()
					SetEntityAlpha(PlayerPedId(), 1000, false)
					FreezeEntityPosition(GetPlayerPed(-1), false)
					TeleportMenuIsOpen = false
				else
				    TeleportMenu.close()
					TriggerServerEvent('esx_misc:SwapPlayer2', PlayerId, coords, heading)
				end

	end, function(data2, TeleportMenu)
		TeleportMenu.close()
		SetEntityAlpha(PlayerPedId(), 1000, false)
		FreezeEntityPosition(GetPlayerPed(-1), false)
		TeleportMenuIsOpen = false
	end)
end)

function OpenTeleportMenu()
    
	TeleportMenuIsOpen = true
	
	
	SetEntityAlpha(PlayerPedId(), 100, false)
	FreezeEntityPosition(GetPlayerPed(-1), true)
	
	local elements = {}
	local elements2 = {}
	
	table.insert(elements, {label = 'قائمة المعارض', value = 'VehShopsMenu'})
	table.insert(elements, {label = '<font color=MediumPurple>مركز التوظيف</font>', coords = vector3(-612.636, -349.5931, 34.83934), heading = 232.92944335938})
	table.insert(elements, {label = '<font color=white>موقع المزاد</font>', coords = vector3(699.1099853515625, 619.6099853515625, 128.91000366210938), heading = 290.51049804688})
	--# كراجات
	table.insert(elements, {label = '<font color=Blue>كراج لوس 1</font>', coords = vector3(192.9898, -1449.284, 29.14163), heading = 232.92944335938})
	table.insert(elements, {label = '<font color=Blue>كراج لوس 2</font>', coords = vector3(862.1312, -1336.547, 26.053), heading = 128.34576416016})
	table.insert(elements, {label = '<font color=Blue>كراج ساندي</font>', coords = vector3(1740.82, 3714.374, 34.11332), heading = 53.582233428955})
	table.insert(elements, {label = '<font color=Blue>كراج بليتو</font>', coords = vector3(-219.3883, 6263.184, 31.68427), heading = 170.86059570313})
	--# حجز
	table.insert(elements, {label = '<font color=orange>حجز لوس</font>', coords = vector3(408.5297, -1612.622, 29.29156), heading = 314.80520629883})
	table.insert(elements, {label = '<font color=orange>حجز ساندي</font>', coords = vector3(1739.656, 3610.097, 34.91333), heading = 313.28057861328})
	table.insert(elements, {label = '<font color=orange>حجز بليتو</font>', coords = vector3(-360.1978, 6062.771, 31.50014), heading = 346.0390625})
	--# شاحنات
	table.insert(elements, {label = '<font color=brown>شاحنات لوس</font>', coords = vector3(861.0832, -1579.692, 31.0382), heading = 62.513187408447})
	table.insert(elements, {label = '<font color=brown>شاحنات ساندي</font>', coords = vector3(177.3994, 2809.435, 45.31482), heading = 271.14010620117})
	table.insert(elements, {label = '<font color=brown>شاحنات بليتو</font>', coords = vector3(-275.8618, 6020.795, 31.997), heading = 357.32211303711})
	--# قائمة المعارض
	table.insert(elements2, {label = '<font color=gold>سيارات جديد</font>', coords = vector3(2196.173, 2912.302, 46.5373), heading = 91.909492492676})
	table.insert(elements2, {label = '<font color=gold>شاحنات جديد</font>', coords = vector3(1232.078, 2726.086, 38.00418), heading = 136.00520324707})
	--# اَخر
	table.insert(elements, {label = '<font color=gold>مركز إدارة الرقابة و التفتيش</font>', coords = vector3(230.2241, -1148.274, 29.31121), heading = 85.065399169922})
	
	
	if PlayerData.job.name == 'police' or PlayerData.job.name == 'admin' then
		table.insert(elements, {label = '<font color=Blue>مركز شرطة لوس</font>', coords = vector3(411.1493, -966.9874, 29.46332), heading = 87.328079223633})
		table.insert(elements, {label = '<font color=Blue>مركز شرطة ساندي</font>', coords = vector3(1877.479, 3665.073, 33.64734), heading = 28.225255966187})
		table.insert(elements, {label = '<font color=Blue>مركز شرطة بليتو</font>', coords = vector3(-427.7365, 6032.241, 31.49011), heading = 291.93078613281})
	end
	
	if PlayerData.job.name == 'agent' or PlayerData.job.name == 'police' or PlayerData.job.name == 'admin' then
		table.insert(elements, {label = '<font color=green>ميناء مدينة 101 البحري</font>', coords = vector3(787.3835, -2958.627, 6.038402), heading = 92.161666870117})
		table.insert(elements, {label = '<font color=green>ميناء مدينة 101 الغربي</font>', coords = vector3(-52.10347, -2529.776, 6.152335), heading = 145.83110046387})
	end
	
	if PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'admin' then
		table.insert(elements, {label = '<font color=red>مستشفى لوس السلام</font>', coords = vector3(374.3611, -574.7087, 28.84346), heading = 269.00588989258})
		table.insert(elements, {label = '<font color=red>مستشفى بجانب كراج لوس 1</font>', coords = vector3(309.4666, -1452.621, 29.96651), heading = 51.175903320313})
		table.insert(elements, {label = '<font color=red>مستشفى بجانب كراج لوس 2</font>', coords = vector3(787.3835, -2958.627, 6.038402), heading = 92.161666870117})
		table.insert(elements, {label = '<font color=red>مستشفى ساندي</font>', coords = vector3(1806.807, 3670.695, 34.27539), heading = 300.43865966797})
		table.insert(elements, {label = '<font color=red>مستشفى بليتو</font>', coords = vector3(-239.7325, 6313.521, 31.48951), heading = 222.32019042969})
	end
	
	table.insert(elements, {label = 'إلغاء الإنتقال', value = 'closeMenu'})
	
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'TeleportMenu', {
		title    = 'قائمة أنتقال - إختياري',
		align    = 'bottom-right',
		elements = elements
	}, function(data2, TeleportMenu)
		local action = data2.current.value
		local coords = data2.current.coords
		local heading = data2.current.heading

		if action == 'VehShopsMenu' then
            ---------------------------
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'VehShopsMenu', {
				title    = 'قائمة أنتقال - المعارض',
				align    = 'bottom-right',
				elements = elements2
			}, function(data12, menu12)
				menu12.close()
				local action2 = data12.current.value
				local coords2 = data12.current.coords
		        local heading2 = data12.current.heading
				Teleport(coords2, heading2)
			end, function(data12, menu12)
				menu12.close()
			end)
			--------------------------
				elseif action == 'closeMenu' then
					TeleportMenu.close()
					SetEntityAlpha(PlayerPedId(), 1000, false)
					FreezeEntityPosition(GetPlayerPed(-1), false)
					TeleportMenuIsOpen = false
				else
				    TeleportMenu.close()
					Teleport(coords, heading)
				end

	end, function(data2, TeleportMenu)
		TeleportMenu.close()
		SetEntityAlpha(PlayerPedId(), 1000, false)
		FreezeEntityPosition(GetPlayerPed(-1), false)
		TeleportMenuIsOpen = false
	end)
end