local firstSpawn, PlayerLoaded = true, false
local id, name = GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId())
isDead, isSearched, medic = false, false, 0
ESX = nil
local streetName, playerGender
local is_godemod = false
local is_set_time_out_player = false
local is_want_set_in_srer = false

TriggerEvent('skinchanger:getSkin', function(skin)
	playerGender = skin.sex
end)
AddEventHandler("onClientMapStart", function()
	exports.spawnmanager:spawnPlayer()
	Citizen.Wait(5000)
	exports.spawnmanager:setAutoSpawn(false)
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end
	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

AddEventHandler('esx:onPlayerSpawn', function()
	isDead = false
	if firstSpawn then
		firstSpawn = false

		if Config.AntiCombatLog then
			while not PlayerLoaded do
				Citizen.Wait(5000)
			end

			ESX.TriggerServerCallback('esx_ambulancejob:getDeathStatus', function(shouldDie)
				if shouldDie then
					Citizen.Wait(1000)
					ESX.ShowNotification(_U('combatlog_message'))
				    RemoveItemsAfterRPDeath(2)
				end
			end)
		end
	end
end)

Citizen.CreateThread(function()
	for k,v in pairs(Config.HospitalsBlips) do
		local blip = AddBlipForCoord(v.coords)

		SetBlipSprite(blip, v.sprite)
		SetBlipScale(blip, v.scale)
		SetBlipColour(blip, v.color)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')

		AddTextComponentSubstringPlayerName(v.info)

		EndTextCommandSetBlipName(blip)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if isDead then
			DisableAllControlActions(0)
			EnableControlAction(0, 47, true)
			EnableControlAction(0, 245, true)
			EnableControlAction(0, 38, true)
		else
			Citizen.Wait(500)
		end
	end
end)

local watertimer = 0

function MoveToRoad()
	local playerPed = PlayerPedId()
	local playercoords = GetEntityCoords(playerPed)
	watertimer = 500
	while true do
		Citizen.Wait(0)
		if watertimer > 0 and isDead then
			watertimer = watertimer -1
			SetTextFont(font)
			SetTextProportional(1)
			SetTextScale(0.0, 0.5)
			SetTextColour(255, 0, 0, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("<FONT FACE='A9eelsh'>ﺀﺎﻤﻟﺍ ﺝﺭﺎﺧ ﻚﻠﻘﻧ ﻢﺘﻳ ﻑﻮﺳ</font> ")
			DrawText(0.420, 0.370)
		else
			break
		end
	end
	if isDead then
		local _, closstRd, anotPos = GetClosestRoad(playercoords.x, playercoords.y, playercoords.z, 10, 1, true)
		SetEntityCoords(playerPed, closstRd)
		Citizen.Wait(1000)
		TriggerServerEvent("esx_ambulancejob:m3gon:removeBlipAfterDead:server")
		Citizen.Wait(1000)
		TriggerServerEvent('esx_ambulancejob:playerdeadblip', GetEntityCoords(PlayerPedId()))
	end
end

-- Disable most inputs when dead
Citizen.CreateThread(function()
	while true do
		local Sleep = 1500

		if isDead then
			Sleep = 0
			DisableAllControlActions(0)
			EnableControlAction(0, 47, true)
			EnableControlAction(0, 245, true)
			EnableControlAction(0, 38, true)
			local playerPed = PlayerPedId()
			if IsEntityInWater(playerPed) and watertimer == 0 then
				MoveToRoad()
			end
		else
			Citizen.Wait(500)
		end
		Citizen.Wait(Sleep)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isDead and isSearched then
			local playerPed = PlayerPedId()
			local ped = GetPlayerPed(GetPlayerFromServerId(medic))
			isSearched = false

			AttachEntityToEntity(playerPed, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
			Citizen.Wait(1000)
			DetachEntity(playerPed, true, false)
			ClearPedTasksImmediately(playerPed)
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:clsearch')
AddEventHandler('esx_ambulancejob:clsearch', function(medicId)
	local playerPed = PlayerPedId()

	if isDead then
		local coords = GetEntityCoords(playerPed)
		local playersInArea = ESX.Game.GetPlayersInArea(coords, 50.0)

		for i=1, #playersInArea, 1 do
			local player = playersInArea[i]
			if player == GetPlayerFromServerId(medicId) then
				medic = tonumber(medicId)
				isSearched = true
				break
			end
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:setGodMode')
AddEventHandler('esx_ambulancejob:setGodMode', function(do_what)
	if do_what == "set_false" then
		is_godemod = false
	elseif do_what == "set_true" then
		is_godemod = true
	end
end)

function OnPlayerDeath()
	ESX.UI.Menu.CloseAll()
	if ESX.PlayerData.job.name == "ambulance" then
		TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(PlayerId()), true)
		ESX.ShowNotification("انت <span style='color:red;'>مسعف</span> <span style='color:white;'>تم انعاشك تلقائياّ</span>")
	else
		if not isDead then
			TriggerServerEvent("esx_adminjob:m3gonsetcoords")
			StartScreenEffect('DeathFailOut', 0, false)
			TriggerServerEvent('esx_ambulancejob:setDeathStatus', true)
			TriggerServerEvent('esx_ambulancejob:playerdeadblip', GetEntityCoords(PlayerPedId()))
			TriggerEvent('esx_misc:hidehud', true)
			TriggerEvent("esx_admin_defcon:setstatusdead", true)
			StartDeathTimer()
			ESX.TriggerServerCallback('getPlayerCheckOnlineBym3gon:check', function(add_msafen)
				if add_msafen then
					StartDistressSignal()
				elseif not add_msafen then
					StartDistressSignal2()
				end
			end, 'ambulance')
			isDead = true
			ScreenEffectStart()
		end
		--do_player_animations_dead()
	end
end

RegisterNetEvent('is_want_revive')
AddEventHandler('is_want_revive', function(data)
	is_want_revive = data
end)

RegisterNetEvent('is_want_set_in_srer')
AddEventHandler('is_want_set_in_srer', function(data)
	is_want_set_in_srer = data
end)

--[[function do_player_animations_dead()
	while true do
		if isDead and not is_want_revive and not is_want_set_in_srer then
			local ped = PlayerPedId()

			RequestAnimDict("random@dealgonewrong")

			while not HasAnimDictLoaded("random@dealgonewrong") do
				Citizen.Wait(0)
			end

			Citizen.Wait(1000)

			SetEntityHealth(ped, 200)

			SetEntityInvincible(ped, true)

			ClearPedTasksImmediately(ped)

			TaskPlayAnim(ped, "random@dealgonewrong", "idle_a", 1.0, 1.0, -1, 1, 0, 0, 0, 0)
		elseif not isDead then
			break
		end
		Wait(5000)
	end
end--]]

Citizen.CreateThread(function()
	while isDead do
		Citizen.Wait(500)
	end
	local alpha = 255
	fontId = RegisterFontId('A9eelsh')
	local white = {r=255,g=255,b=255}
	local scale = 0.55

	while true do
		Citizen.Wait(1)

		if isDead then
			--id
			SetTextColour(white.r, white.g, white.b, alpha)
			SetTextFont(fontId)
			SetTextScale(scale, scale)
			SetTextWrap(0.0, 1.0)
			SetTextCentre(false)
			SetTextDropshadow(2, 2, 0, 0, 0)
			SetTextEdge(1, 0, 0, 0, 205)
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString('<FONT FACE = "A9eelsh">~w~~r~'..id..' ~w~~w~ ﺮﻓﺮﻴﺴﻟﺎﺑ ﻚﻤﻗﺭ')
			DrawText(0.435, 0.460)
	end
	end
end)

RegisterNetEvent('esx_ambulancejob:useItem')
AddEventHandler('esx_ambulancejob:useItem', function(itemName)
	ESX.UI.Menu.CloseAll()

	if itemName == 'medikit' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01'
		local playerPed = PlayerPedId()

		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end

			TriggerEvent('esx_ambulancejob:heal', 'big', true)
			ESX.ShowNotification(_U('used_medikit'))
		end)

	elseif itemName == 'bandage' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01'
		local playerPed = PlayerPedId()

		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end

			TriggerEvent('esx_ambulancejob:heal', 'small', true)
			ESX.ShowNotification(_U('used_bandage'))
		end)
	end
end)

local message_in_sh = nil
function StartDistressSignal()
	Citizen.CreateThread(function()
		local timer = Config.BleedoutTimer

		while timer > 0 and isDead do
			Citizen.Wait(0)
			timer = timer - 30

			fontId = RegisterFontId('A9eelsh')
			SetTextFont(fontId)
			SetTextScale(0.45, 0.45)
			SetTextColour(185, 185, 185, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			BeginTextCommandDisplayText('STRING')
			AddTextComponentSubstringPlayerName(_U('distress_send'))
			EndTextCommandDisplayText(0.407, 0.430)

			if IsControlJustReleased(0, 47) then
				SendDistressSignal()
				break
			end
		end
	end)
end

function StartDistressSignal2()
	Citizen.CreateThread(function()
		local timer = Config.BleedoutTimer

		while timer > 0 and isDead do
			Citizen.Wait(0)
			timer = timer - 30

			fontId = RegisterFontId('A9eelsh')
			SetTextFont(fontId)
			SetTextScale(0.45, 0.45)
			SetTextColour(185, 185, 185, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			BeginTextCommandDisplayText('STRING')
			AddTextComponentSubstringPlayerName(_U('police_send_shash'))
			EndTextCommandDisplayText(0.407, 0.430)

			if IsControlJustReleased(0, 47) then
				SendDistressSignal2()
				break
			end
		end
	end)
end

local blips_dead_player = {}

RegisterNetEvent("esx_ambulancejob:playerdeadblip:client")
AddEventHandler("esx_ambulancejob:playerdeadblip:client", function(coords, id_p)
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
		local blip = AddBlipForCoord(coords)
		blips_dead_player[id_p] = blip
		SetBlipSprite(blip, 280)
		SetBlipColour(blip, 1)
		SetBlipFlashes(blip, true)
		SetBlipCategory(blip, 7)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('blip_dead'))
		EndTextCommandSetBlipName(blip)
	else
		RemoveBlip(blip)
	end
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent("esx_admin_or_defcon:selectLactionWith:::G:::")
AddEventHandler("esx_admin_or_defcon:selectLactionWith:::G:::", function(coords)
	DisplayHelpText('<FONT FACE="A9eelsh">' .. "غﻼﺒﻟﺍ ﻊﻗﻮﻣ ﺪﻳﺪﺤﺘﻟ ~r~G ~w~ﻂﻐﺿﺍ")
	local counter_select_location = 500
	while counter_select_location > 0 do
		if IsControlJustReleased(0, 47) then
			SetNewWaypoint(tonumber(coords.x), tonumber(coords.y))
			ESX.ShowNotification('تم تحديد <font color=orange>البلاغ</font> البلاغ في الخريطة')
			counter_select_location = 0
		end
		counter_select_location = counter_select_location - 1
		Citizen.Wait(0)
	end
end)

function SendDistressSignal()
	local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local myPos = GetEntityCoords(PlayerPedId())
    local GPS = 'GPS: ' .. myPos.x .. ', ' .. myPos.y
	TriggerServerEvent('gksphone:jbmessage', "يوجد شخص مسقط بحاجة الى انعاش", 0, "يوجد شخص مسقط بحاجة الى انعاش | الموقع " .. GPS, 0, GPS .. ", " .. myPos.y, "ambulance", myPos)

	TriggerEvent("pNotify:SendNotification",{
		text = "<b style='color:#FFAE00'><font size=5><center>".._U('distress_sent').."</center></b>",
		type = "alert",
		timeout = (10000),
		layout = "centerLeft",
		killer = true,
		queue = "distress_sent",
		sounds = {
		sources = {"Radio.wav"},
		volume = 0.1,
		conditions = {"docVisible"}
					            }
	})

	TriggerEvent("pNotify:SendNotification",{
		text = "<b style='color:#F6F6F6'><font size=5><center>سوف يظهر لك اختيار الانتقال للمستشفى مقابل رسوم بعد انقضاء الوقت المحدد</center></b>",
		type = "info",
		timeout = (15000),
		layout = "centerLeft",
		killer = false,
		queue = "distress_sent"
	})

	TriggerEvent("pNotify:SendNotification",{
		text = "<b style='color:#F6F6F6'><font size=5><center>اختيارك الانتقال للمستشفى اثناء حضور الشرطة والاسعاف او  قبل انتهاء الرول بلاي الذي اشتركت به او بدأته بنفسك يعتبر <font color=#FFAE00>مخالف للرول بلاي</br><font color=#FF0E0E>العقوبة طرد او بان</center></b>",
		type = "info",
		timeout = (30000),
		layout = "centerLeft",
		killer = false,
		queue = "distress_sent"
	})

	TriggerServerEvent('esx_ambulancejob:onPlayerDistress')
end

function SendDistressSignal2()
	TriggerServerEvent('esx_ambulancejob:playerdeadblip', GetEntityCoords(PlayerPedId()))
	local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local myPos = GetEntityCoords(PlayerPedId())
    local GPS = 'GPS: ' .. myPos.x .. ', ' .. myPos.y
    TriggerServerEvent('gksphone:jbmessage', "يوجد شخص مسقط بحاجة الى انعاش", 0, "يوجد شخص مسقط بحاجة الى انعاش | الموقع " .. GPS, 0, GPS, "police", myPos)
	TriggerServerEvent('gksphone:jbmessage', "يوجد شخص مسقط بحاجة الى انعاش", 0, "يوجد شخص مسقط بحاجة الى انعاش | الموقع " .. GPS, 0, GPS, "agent", myPos)

	--[[TriggerServerEvent('esx_addons_gcphone:startCall', 'ambulance', _U('distress_message'), {
		x = coords.x,
		y = coords.y,
		z = coords.z
	})]]
	--TriggerServerEvent("esx:emitMessagetoems",GetPlayerServerId(playerPed))
	--TriggerEvent("pNotify:SetQueueMax", "distress_sent", 1)

	TriggerEvent("pNotify:SendNotification",{
 				                text = "<b style='color:#FFAE00'><font size=5><center>".._U('distress_sent').."</center></b>",
					            type = "alert",
					            timeout = (10000),
					            layout = "centerLeft",
					            killer = true,
					            queue = "distress_sent",
								sounds = {
							    sources = {"Radio.wav"}, -- For sounds to work, you place your sound in the html folder and then add it to the files array in the __resource.lua file.
							    volume = 0.1,
							    conditions = {"docVisible"}
					            }
				            })

	TriggerEvent("pNotify:SendNotification",{
 				                text = "<b style='color:#F6F6F6'><font size=5><center>سوف يظهر لك اختيار الانتقال للمستشفى مقابل رسوم بعد انقضاء الوقت المحدد</center></b>",
					            type = "info",
					            timeout = (15000),
					            layout = "centerLeft",
					            killer = false,
					            queue = "distress_sent"
				            })

	TriggerEvent("pNotify:SendNotification",{
 				                text = "<b style='color:#F6F6F6'><font size=5><center>اختيارك الانتقال للمستشفى اثناء حضور الشرطة والاسعاف او  قبل انتهاء الرول بلاي الذي اشتركت به او بدأته بنفسك يعتبر <font color=#FFAE00>مخالف للرول بلاي</br><font color=#FF0E0E>العقوبة طرد او بان</center></b>",
					            type = "info",
					            timeout = (30000),
					            layout = "centerLeft",
					            killer = false,
					            queue = "distress_sent"
				            })

	TriggerServerEvent('esx_ambulancejob:onPlayerDistress')
end


function DrawGenericTextThisFrame()
fontId = RegisterFontId('A9eelsh')
	SetTextFont(fontId)
	SetTextScale(0.0, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
end

function secondsToClock(seconds)
	local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

	if seconds <= 0 then
		return 0, 0
	else
		local hours = string.format('%02.f', math.floor(seconds / 3600))
		local mins = string.format('%02.f', math.floor(seconds / 60 - (hours * 60)))
		local secs = string.format('%02.f', math.floor(seconds - hours * 3600 - mins * 60))

		return mins, secs
	end
end

function ScreenEffectStart()
	while isDead do
		StartScreenEffect('DeathFailOut', 0, false)
		Citizen.Wait(5000)
	end
	StopScreenEffect('DeathFailOut')
	Citizen.Wait(1000)
	StopScreenEffect('DeathFailOut')
end

function StartDeathTimer()
	local canPayFine = false

	if Config.EarlyRespawnFine then
		ESX.TriggerServerCallback('esx_ambulancejob:checkBalance', function(canPay)
			canPayFine = canPay
		end)
	end

	local earlySpawnTimer = ESX.Math.Round(Config.EarlyRespawnTimer / 1000)
	local bleedoutTimer = ESX.Math.Round(Config.BleedoutTimer / 1000)

	Citizen.CreateThread(function()
		-- early respawn timer
		while earlySpawnTimer > 0 and isDead do
			Citizen.Wait(1000)

			if earlySpawnTimer > 0 then
				earlySpawnTimer = earlySpawnTimer - 1
			end
		end

		-- bleedout timer
		while bleedoutTimer > 0 and isDead do
			Citizen.Wait(1000)

			if bleedoutTimer > 0 then
				bleedoutTimer = bleedoutTimer - 1
			end
		end
	end)

	Citizen.CreateThread(function()
		local text, timeHeld

		-- early respawn timer
		while earlySpawnTimer > 0 and isDead do
			Citizen.Wait(0)
			text = _U('respawn_available_in', secondsToClock(earlySpawnTimer))

			DrawGenericTextThisFrame()

			SetTextEntry('STRING')
			AddTextComponentString(text)
			EndTextCommandDisplayText(0.505, 0.500)
		end

		-- bleedout timer
		while bleedoutTimer > 0 and isDead do
			Citizen.Wait(0)
			text = _U('respawn_bleedout_in', secondsToClock(bleedoutTimer))

			if not Config.EarlyRespawnFine then
				text = text .. _U('respawn_bleedout_prompt')

				if IsControlPressed(0, 38) and timeHeld > 60 then
					RemoveItemsAfterRPDeath(1)
					break
				end
			elseif Config.EarlyRespawnFine and canPayFine then
				text2 = _U('respawn_bleedout_fine', ESX.Math.GroupDigits(Config.EarlyRespawnFineAmount))

				if IsControlPressed(0, 38) and timeHeld > 60 then
					TriggerServerEvent('esx_ambulancejob:payFine')
					RemoveItemsAfterRPDeath(1)
					break
				end
			end

			if IsControlPressed(0, 38) then
				timeHeld = timeHeld + 1
			else
				timeHeld = 0
			end

			DrawGenericTextThisFrame()

			SetTextEntry("STRING")
			AddTextComponentString(text2)
			DrawText(0.5, 0.54)

			DrawGenericTextThisFrame()

			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.5, 0.5)
		end

		if bleedoutTimer < 1 and isDead then
			RemoveItemsAfterRPDeath(0)
		end
	end)
end

function RemoveItemsAfterRPDeath(deathType) -- 0 = player bleedout | 1 = player select go to hospital
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end

		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)
		local nearHospitalDistance = 100000000
		local nearHospitalcoords = {}
		local nearHospitalheading = 0
		local hospitalLabel = ''

		for k,v in pairs(Config.RespawnPoint) do
			if exports.esx_jail.isPlayerJailed() then
				nearHospitalcoords = Config.jailedRespawnPoint.coords
				nearHospitalheading = Config.jailedRespawnPoint.heading
				hospitalLabel = Config.jailedRespawnPoint.label
				break
			else
				checkDistance = GetDistanceBetweenCoords(pedCoords, v.coords, true)

				if checkDistance < nearHospitalDistance then
					nearHospitalDistance = checkDistance
					nearHospitalcoords = v.coords
					nearHospitalheading = v.heading
					hospitalLabel = v.label
				end
			end
		end

		TriggerServerEvent('esx_ambulancejob:chat', deathType, hospitalLabel)
		TriggerEvent('esx_misc:hidehud', false)
		isDead = false
		if deathType == 2 then
			deathType = 1
		end
		ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()

			ESX.SetPlayerData('lastPosition', nearHospitalcoords)
			ESX.SetPlayerData('loadout', {})

			TriggerServerEvent('esx:updateLastPosition', nearHospitalcoords)
			RespawnPed(PlayerPedId(), nearHospitalcoords, nearHospitalheading)

			StopScreenEffect('DeathFailOut')
			DoScreenFadeIn(800)
		end, deathType)
	end)
end

function RespawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)
	ESX.UI.Menu.CloseAll()


	TriggerServerEvent('esx:onPlayerSpawn')
	TriggerEvent('esx:onPlayerSpawn')
	TriggerEvent('playerSpawned') -- compatibility with old scripts, will be removed soon
end

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = 'Ambulance',
		number     = 'ambulance',
		base64Icon = 'data:image/png;base64,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'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	OnPlayerDeath()
end)

RegisterNetEvent('esx_ambulancejob:reviveALL')
AddEventHandler('esx_ambulancejob:reviveALL', function(coords)
	if isDead then
		local playerPed = GetPlayerPed()
		local coords = coords

		TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

		Citizen.CreateThread(function()
			DoScreenFadeOut(800)

			while not IsScreenFadedOut() do
				Citizen.Wait(50)
			end

			local formattedCoords = {
				x = ESX.Math.Round(coords.x, 1),
				y = ESX.Math.Round(coords.y, 1),
				z = ESX.Math.Round(coords.z, 1),
				heading = 0.0,
			}

			ESX.SetPlayerData('lastPosition', formattedCoords)

			TriggerServerEvent('esx:updateCoords', formattedCoords)

			RespawnPed(playerPed, formattedCoords, 0.0)

			--remove armor and save skin
			SetPedComponentVariation(playerPed, 9, 0, 0, 0)

			StopScreenEffect('DeathFailOut')
			DoScreenFadeIn(800)
		end)
	end
end)

local dead_key_limit = {
	DisabledKeys = { -- here you can choose what Keys you want to Disable -- هنا يمكنك اختيار المفاتيح التي تريد اطفائها
        {Index = 288, types = 0}, --(F1)
        {Index = 289, types = 0}, --(F2)
        {Index = 170, types = 0}, --(F3)
		{Index = 166, types = 0}, --(F5)
		{Index = 167, types = 0}, --(F6)
		{Index = 168, types = 0}, --(F7)
		{Index = 56, types = 0}, --(F9)
		{Index = 57, types = 0}, --(F10)
		{Index = 44, types = 0}, --(Q)
		{Index = 45, types = 0}, --(R)
		{Index = 245, types = 0}, --(T)
		{Index = 47, types = 0}, --(G)
		{Index = 74, types = 0}, --(H)
		{Index = 20, types = 0}, --(Z)
		{Index = 23, types = 0}, --(F)
		{Index = 49, types = 0}, --(F)
		{Index = 75, types = 0}, --(F)
		{Index = 145, types = 0}, --(F)
		{Index = 185, types = 0}, --(F)
		{Index = 251, types = 0}, --(F)
		{Index = 29, types = 0}, --(B)
		{Index = 244, types = 0}, --(M)
		{Index = 37, types = 0}, --(TAB)
		{Index = 37, types = 2}, --(TAB)
		{Index = 137, types = 0}, --(CAPS)
		{Index = 21, types = 0}, --(LEFTSHIFT)
		{Index = 36, types = 0}, --(LEFTCTRL)
		{Index = 24, types = 0}, --(LEFTMOUSEBUTTON)
		{Index = 22, types = 0}, --(SPACE)
		{Index = 243, types = 0} --(~)
    }
}

Citizen.CreateThread(function()
	while true do
		if is_set_time_out_player then
			for i, r in pairs(dead_key_limit.DisabledKeys) do
				local player = GetPlayerPed(PlayerPedId())
				DisableControlAction(r['types'], r['Index'], true)
				if IsDisabledControlJustPressed(2, 37) then --if Tab is pressed, send error message
					SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) -- if tab is pressed it will set them to unarmed (this is to cover the vehicle glitch until I sort that all out)
				end
				if IsDisabledControlJustPressed(0, 106) then --if LeftClick is pressed, send error message
					SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) -- If they click it will set them to unarmed
				end
				if IsDisabledControlJustPressed(0, 140) then --if R is pressed, send error message
					SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) -- If they click it will set them to unarmed
				end
			end
			Citizen.Wait(0)
		else
			Citizen.Wait(1000)
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:m3gon:removeBlipAfterDead')
AddEventHandler('esx_ambulancejob:m3gon:removeBlipAfterDead', function(player_id_the_revive)
	if blips_dead_player[player_id_the_revive] then
		RemoveBlip(blips_dead_player[player_id_the_revive])
	end
end)

RegisterNetEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
	DoScreenFadeOut(800)

	while not IsScreenFadedOut() do
		Citizen.Wait(50)
	end

	local formattedCoords = {
		x = ESX.Math.Round(coords.x, 1),
		y = ESX.Math.Round(coords.y, 1),
		z = ESX.Math.Round(coords.z, 1)
	}

	RespawnPed(playerPed, formattedCoords, 0.0)
	StopScreenEffect('DeathFailOut')
	DoScreenFadeIn(800)
	ClearPedTasks(PlayerPedId())
	isDead = false
	TriggerEvent('esx_misc:hidehud', false) -- show hud agen after revive
	if ESX.PlayerData.job.name == "admin" or ESX.PlayerData.job.name == "ambulance" or ESX.PlayerData.job.name == "police" or ESX.PlayerData.job.name == "agent" or ESX.PlayerData.job.name == "mechanic" then
		is_want_revive = false
		TriggerServerEvent('esx_ambulancejob:m3gon:removeBlipAfterDead:server')
		TriggerEvent("esx_admin_defcon:setstatusdead", false)
	else
		is_want_revive = false
		TriggerServerEvent('esx_ambulancejob:m3gon:removeBlipAfterDead:server')
		TriggerEvent("esx_admin_defcon:setstatusdead", false)
		TriggerEvent('pogressBar:drawBar', 15000, 'قدراتك محدودة .. انتظر 15 ثانية حتى انتهاء الوقت')
		is_set_time_out_player = true
		Citizen.Wait(15000)
		is_set_time_out_player = false
	end
end)

-- Load unloaded IPLs
if Config.LoadIpl then
	RequestIpl('Coroner_Int_on') -- Morgue
end
