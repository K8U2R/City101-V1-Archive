local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum
local isBusy, deadPlayers, deadPlayerBlips, isOnDuty = false, {}, {}, false
local isBusyRevive = false
--local list_dead_player_blips = {}
isInShopMenu = false
ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

--[[
function OpenAmbulanceActionsMenu()
	local elements = {{label = _U('cloakroom'), value = 'cloakroom'}}

	if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions', {
		title    = _U('ambulance'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'cloakroom' then
			OpenCloakroomMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
				menu.close()
			end, {wash = false})
		end
	end, function(data, menu)
		menu.close()
	end)
end
--]]

-------------------------------------
---START - addon cloakroom system ---
-------------------------------------
local blipsEMS = {}
playerInService = false

function OpenAmbulanceActionsMenu()
	local playerPed = PlayerPedId()
	--local grade = PlayerData.job.grade_name
	local gradeNo = ESX.PlayerData.job.grade

	local grade = ESX.PlayerData.job.grade_name
	local gradel = ESX.PlayerData.job.grade_label

	local elements = {}

	table.insert(elements, {label = _U('citizen_wear'), value = 'citizen_wear'})
	table.insert(elements, {label = _U('EMSCloakroomMenu'), value = 'EMSCloakroomMenu'})

	if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions',
	{
		title		= "<font color=#FF0000>" .. _U('ambulance') .. "</font>",
		align		= 'top-left',
		elements	= elements
	}, function(data, menu)
		if data.current.value == 'EMSCloakroomMenu' then
			OpenEMSCloakroomMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
				menu.close()
			end, {wash = false})
		elseif data.current.value == 'citizen_wear' then
			isOnDuty = false
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)

			if Config.MaxInService ~= -1 then

				ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
				--if not canTakeService then
							--ESX.ShowNotification(_U('service_max', inServiceCount, maxInService))
							--ESX.ShowNotification('test '..inServiceCount..'/'..maxInService)
							--ESX.ShowNotification('test ')
						--else
					if isInService then

						playerInService = false

						local notification = {
							title    = _U('service_anonunce'),
							subject  = '',
							msg      = _U('service_out_announce', GetPlayerName(PlayerId())),
							iconType = 1
						}

						TriggerServerEvent('esx_service:notifyAllInService', notification, 'ambulance')

						TriggerServerEvent('esx_service:disableService', 'ambulance')
						if not Config.OnesyncInfinty then
							TriggerEvent('esx_ambulancejob:updateBlip')
						end
						ESX.ShowNotification(_U('service_out'))
					end
					--end
				end, 'ambulance')
			end

		end
	end, function(data, menu)
		menu.close()
	end)
end

--[[
function OpenFireActionsMenu()
	local playerPed = PlayerPedId()
	local grade = PlayerData.job.grade_name
	local gradeNo = PlayerData.job.grade

	local elements = {}

	table.insert(elements, {label = _U('citizen_wear'), value = 'citizen_wear'})

	if gradeNo >= 1 then
		--table.insert(elements, {label = _U('FireCloakroomMenu'), value = 'FireCloakroomMenu'})
		table.insert(elements, {label = _U('FireCloakroomMenu')..' <font color=gray>قريبا</font>'})
	else
		table.insert(elements, {label = 'الإطفاء غير متاح للمتدرب'})
	end

	if Config.EnablePlayerManagement and PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions',
	{
		title		= _U('ambulance'),
		align		= 'top-left',
		elements	= elements
	}, function(data, menu)
		if data.current.value == 'EMSCloakroomMenu' then
			OpenEMSCloakroomMenu()
		elseif data.current.value == 'FireCloakroomMenu' then
			OpenFireCloakroomMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBosP4sSwoRdsMenu', 'ambulance', function(data, menu)
				menu.close()
			end, {wash = false})
		elseif data.current.value == 'citizen_wear' then

			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)

			if Config.MaxInService ~= -1 then

				ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
					if isInService then

						playerInService = false

						local notification = {
							title    = _U('service_anonunce'),
							subject  = '',
							msg      = _U('service_out_announce', GetPlayerName(PlayerId())),
							iconType = 1
						}

						TriggerServerEvent('esx_service:notifyAllInService', notification, 'ambulance')

						TriggerServerEvent('esx_service:disableService', 'ambulance')
						if not Config.OnesyncInfinty then
							TriggerEvent('esx_ambulancejob:updateBlip')
						end
						ESX.ShowNotification(_U('service_out'))
					end
				end, 'ambulance')
			end

		end
	end, function(data, menu)
		menu.close()
	end)
end
--]]

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function OpenEMSCloakroomMenu()

	local playerPed = PlayerPedId()
	--local grade = PlayerData.job.grade_name
	local gradeNo = ESX.PlayerData.job.grade

	local grade = ESX.PlayerData.job.grade_name
	local gradel = ESX.PlayerData.job.grade_label

	local elementsAccessories = {}
	local elements = {}

	if  gradeNo == 0 then
		table.insert(elements, {label = _U('ems_0'), value = 'ems_0'})
	elseif  gradeNo == 1 then
		table.insert(elements, {label = _U('ems_1'), value = 'ems_1'})
		table.insert(elementsAccessories, {label = _U('badge'), value = 'badge'})
		table.insert(elementsAccessories, {label = _U('radio_belt'), value = 'radio_belt'})
		table.insert(elementsAccessories, {label = _U('mask2'), value = 'mask2'})
		table.insert(elementsAccessories, {label = _U('chain_remove'), value = 'chain_remove'})
		table.insert(elementsAccessories, {label = _U('mask_remove'), value = 'mask_remove'})
	elseif  gradeNo == 2 then
		table.insert(elements, {label = _U('ems_2'), value = 'ems_2'})
		table.insert(elements, {label = _U('ems_5'), value = 'ems_5'})
		table.insert(elementsAccessories, {label = _U('badge'), value = 'badge'})
		table.insert(elementsAccessories, {label = _U('sma3a'), value = 'sma3a'})
		table.insert(elementsAccessories, {label = _U('mask2'), value = 'mask2'})
		table.insert(elementsAccessories, {label = _U('radio_belt'), value = 'radio_belt'})
		table.insert(elementsAccessories, {label = _U('chain_remove'), value = 'chain_remove'})
		table.insert(elementsAccessories, {label = _U('mask_remove'), value = 'mask_remove'})
	elseif  gradeNo == 3 then
		table.insert(elements, {label = _U('ems_1'), value = 'ems_1'})
		table.insert(elements, {label = _U('ems_2'), value = 'ems_2'})
		table.insert(elements, {label = _U('ems_5'), value = 'ems_5'})
		table.insert(elementsAccessories, {label = _U('badge'), value = 'badge'})
		table.insert(elementsAccessories, {label = _U('sma3a'), value = 'sma3a'})
		table.insert(elementsAccessories, {label = _U('radio_belt'), value = 'radio_belt'})
		table.insert(elementsAccessories, {label = _U('radio_belt2'), value = 'radio_belt2'})
		table.insert(elementsAccessories, {label = _U('bag_cbr'), value = 'bag_cbr'})
		table.insert(elementsAccessories, {label = _U('mask2'), value = 'mask2'})
		table.insert(elementsAccessories, {label = _U('chain_remove'), value = 'chain_remove'})
		table.insert(elementsAccessories, {label = _U('mask_remove'), value = 'mask_remove'})
		table.insert(elementsAccessories, {label = _U('bag_remove'), value = 'bag_remove'})
		table.insert(elementsAccessories, {label = _U('belt_remove'), value = 'belt_remove'})
	elseif  gradeNo == 4 then
		table.insert(elements, {label = _U('ems_1'), value = 'ems_1'})
		table.insert(elements, {label = _U('ems_2'), value = 'ems_2'})
		table.insert(elements, {label = _U('ems_5'), value = 'ems_5'})
		table.insert(elementsAccessories, {label = _U('badge'), value = 'badge'})
		table.insert(elementsAccessories, {label = _U('sma3a'), value = 'sma3a'})
		table.insert(elementsAccessories, {label = _U('radio_belt'), value = 'radio_belt'})
		table.insert(elementsAccessories, {label = _U('radio_belt2'), value = 'radio_belt2'})
		table.insert(elementsAccessories, {label = _U('bag_cbr'), value = 'bag_cbr'})
		table.insert(elementsAccessories, {label = _U('mask2'), value = 'mask2'})
		table.insert(elementsAccessories, {label = _U('chain_remove'), value = 'chain_remove'})
		table.insert(elementsAccessories, {label = _U('mask_remove'), value = 'mask_remove'})
		table.insert(elementsAccessories, {label = _U('bag_remove'), value = 'bag_remove'})
		table.insert(elementsAccessories, {label = _U('belt_remove'), value = 'belt_remove'})
	elseif  gradeNo == 5 then
		table.insert(elements, {label = _U('ems_1'), value = 'ems_1'})
		table.insert(elements, {label = _U('ems_2'), value = 'ems_2'})
		table.insert(elements, {label = _U('ems_3'), value = 'ems_3'})
		table.insert(elements, {label = _U('ems_4'), value = 'ems_4'})
		table.insert(elements, {label = _U('ems_5'), value = 'ems_5'})
		table.insert(elementsAccessories, {label = _U('badge'), value = 'badge'})
		table.insert(elementsAccessories, {label = _U('sma3a'), value = 'sma3a'})
		table.insert(elementsAccessories, {label = _U('radio_belt'), value = 'radio_belt'})
		table.insert(elementsAccessories, {label = _U('radio_belt2'), value = 'radio_belt2'})
		table.insert(elementsAccessories, {label = _U('bag_cbr'), value = 'bag_cbr'})
		table.insert(elementsAccessories, {label = _U('mask2'), value = 'mask2'})
		table.insert(elementsAccessories, {label = _U('chain_remove'), value = 'chain_remove'})
		table.insert(elementsAccessories, {label = _U('mask_remove'), value = 'mask_remove'})
		table.insert(elementsAccessories, {label = _U('bag_remove'), value = 'bag_remove'})
		table.insert(elementsAccessories, {label = _U('belt_remove'), value = 'belt_remove'})
	elseif  gradeNo == 6 then
		table.insert(elements, {label = _U('ems_1'), value = 'ems_1'})
		table.insert(elements, {label = _U('ems_2'), value = 'ems_2'})
		table.insert(elements, {label = _U('ems_3'), value = 'ems_3'})
		table.insert(elements, {label = _U('ems_4'), value = 'ems_4'})
		table.insert(elements, {label = _U('ems_5'), value = 'ems_5'})
		table.insert(elementsAccessories, {label = _U('badge'), value = 'badge'})
		table.insert(elementsAccessories, {label = _U('sma3a'), value = 'sma3a'})
		table.insert(elementsAccessories, {label = _U('radio_belt'), value = 'radio_belt'})
		table.insert(elementsAccessories, {label = _U('radio_belt2'), value = 'radio_belt2'})
		table.insert(elementsAccessories, {label = _U('bag_cbr'), value = 'bag_cbr'})
		table.insert(elementsAccessories, {label = _U('mask2'), value = 'mask2'})
		table.insert(elementsAccessories, {label = _U('chain_remove'), value = 'chain_remove'})
		table.insert(elementsAccessories, {label = _U('mask_remove'), value = 'mask_remove'})
		table.insert(elementsAccessories, {label = _U('bag_remove'), value = 'bag_remove'})
		table.insert(elementsAccessories, {label = _U('belt_remove'), value = 'belt_remove'})
	elseif  gradeNo == 7 then
		table.insert(elements, {label = _U('ems_1'), value = 'ems_1'})
		table.insert(elements, {label = _U('ems_2'), value = 'ems_2'})
		table.insert(elements, {label = _U('ems_3'), value = 'ems_3'})
		table.insert(elements, {label = _U('ems_4'), value = 'ems_4'})
		table.insert(elements, {label = _U('ems_5'), value = 'ems_5'})
		table.insert(elementsAccessories, {label = _U('badge'), value = 'badge'})
		table.insert(elementsAccessories, {label = _U('sma3a'), value = 'sma3a'})
		table.insert(elementsAccessories, {label = _U('radio_belt'), value = 'radio_belt'})
		table.insert(elementsAccessories, {label = _U('radio_belt2'), value = 'radio_belt2'})
		table.insert(elementsAccessories, {label = _U('bag_cbr'), value = 'bag_cbr'})
		table.insert(elementsAccessories, {label = _U('mask2'), value = 'mask2'})
		table.insert(elementsAccessories, {label = _U('chain_remove'), value = 'chain_remove'})
		table.insert(elementsAccessories, {label = _U('mask_remove'), value = 'mask_remove'})
		table.insert(elementsAccessories, {label = _U('bag_remove'), value = 'bag_remove'})
		table.insert(elementsAccessories, {label = _U('belt_remove'), value = 'belt_remove'})
	elseif  gradeNo == 8 then
		table.insert(elements, {label = _U('ems_1'), value = 'ems_1'})
		table.insert(elements, {label = _U('ems_2'), value = 'ems_2'})
		table.insert(elements, {label = _U('ems_3'), value = 'ems_3'})
		table.insert(elements, {label = _U('ems_4'), value = 'ems_4'})
		table.insert(elements, {label = _U('ems_5'), value = 'ems_5'})
		table.insert(elementsAccessories, {label = _U('badge'), value = 'badge'})
		table.insert(elementsAccessories, {label = _U('sma3a'), value = 'sma3a'})
		table.insert(elementsAccessories, {label = _U('radio_belt'), value = 'radio_belt'})
		table.insert(elementsAccessories, {label = _U('radio_belt2'), value = 'radio_belt2'})
		table.insert(elementsAccessories, {label = _U('bag_cbr'), value = 'bag_cbr'})
		table.insert(elementsAccessories, {label = _U('mask2'), value = 'mask2'})
		table.insert(elementsAccessories, {label = _U('chain_remove'), value = 'chain_remove'})
		table.insert(elementsAccessories, {label = _U('mask_remove'), value = 'mask_remove'})
		table.insert(elementsAccessories, {label = _U('bag_remove'), value = 'bag_remove'})
		table.insert(elementsAccessories, {label = _U('belt_remove'), value = 'belt_remove'})
	elseif  gradeNo == 9 then
		table.insert(elements, {label = _U('ems_1'), value = 'ems_1'})
		table.insert(elements, {label = _U('ems_2'), value = 'ems_2'})
		table.insert(elements, {label = _U('ems_3'), value = 'ems_3'})
		table.insert(elements, {label = _U('ems_4'), value = 'ems_4'})
		table.insert(elements, {label = _U('ems_5'), value = 'ems_5'})
		table.insert(elementsAccessories, {label = _U('badge'), value = 'badge'})
		table.insert(elementsAccessories, {label = _U('sma3a'), value = 'sma3a'})
		table.insert(elementsAccessories, {label = _U('radio_belt'), value = 'radio_belt'})
		table.insert(elementsAccessories, {label = _U('radio_belt2'), value = 'radio_belt2'})
		table.insert(elementsAccessories, {label = _U('bag_cbr'), value = 'bag_cbr'})
		table.insert(elementsAccessories, {label = _U('mask2'), value = 'mask2'})
		table.insert(elementsAccessories, {label = _U('chain_remove'), value = 'chain_remove'})
		table.insert(elementsAccessories, {label = _U('mask_remove'), value = 'mask_remove'})
		table.insert(elementsAccessories, {label = _U('bag_remove'), value = 'bag_remove'})
		table.insert(elementsAccessories, {label = _U('belt_remove'), value = 'belt_remove'})
	elseif  gradeNo == 10 then
		table.insert(elements, {label = _U('ems_1'), value = 'ems_1'})
		table.insert(elements, {label = _U('ems_2'), value = 'ems_2'})
		table.insert(elements, {label = _U('ems_3'), value = 'ems_3'})
		table.insert(elements, {label = _U('ems_4'), value = 'ems_4'})
		table.insert(elements, {label = _U('ems_5'), value = 'ems_5'})
		table.insert(elementsAccessories, {label = _U('badge'), value = 'badge'})
		table.insert(elementsAccessories, {label = _U('sma3a'), value = 'sma3a'})
		table.insert(elementsAccessories, {label = _U('radio_belt'), value = 'radio_belt'})
		table.insert(elementsAccessories, {label = _U('radio_belt2'), value = 'radio_belt2'})
		table.insert(elementsAccessories, {label = _U('bag_cbr'), value = 'bag_cbr'})
		table.insert(elementsAccessories, {label = _U('mask2'), value = 'mask2'})
		table.insert(elementsAccessories, {label = _U('chain_remove'), value = 'chain_remove'})
		table.insert(elementsAccessories, {label = _U('mask_remove'), value = 'mask_remove'})
		table.insert(elementsAccessories, {label = _U('bag_remove'), value = 'bag_remove'})
		table.insert(elementsAccessories, {label = _U('belt_remove'), value = 'belt_remove'})
	elseif  gradeNo == 11 then
		table.insert(elements, {label = _U('ems_1'), value = 'ems_1'})
		table.insert(elements, {label = _U('ems_2'), value = 'ems_2'})
		table.insert(elements, {label = _U('ems_3'), value = 'ems_3'})
		table.insert(elements, {label = _U('ems_4'), value = 'ems_4'})
		table.insert(elements, {label = _U('ems_5'), value = 'ems_5'})
		table.insert(elementsAccessories, {label = _U('badge'), value = 'badge'})
		table.insert(elementsAccessories, {label = _U('sma3a'), value = 'sma3a'})
		table.insert(elementsAccessories, {label = _U('radio_belt'), value = 'radio_belt'})
		table.insert(elementsAccessories, {label = _U('radio_belt2'), value = 'radio_belt2'})
		table.insert(elementsAccessories, {label = _U('bag_cbr'), value = 'bag_cbr'})
		table.insert(elementsAccessories, {label = _U('mask2'), value = 'mask2'})
		table.insert(elementsAccessories, {label = _U('chain_remove'), value = 'chain_remove'})
		table.insert(elementsAccessories, {label = _U('mask_remove'), value = 'mask_remove'})
		table.insert(elementsAccessories, {label = _U('bag_remove'), value = 'bag_remove'})
		table.insert(elementsAccessories, {label = _U('belt_remove'), value = 'belt_remove'})
	elseif  gradeNo == 12 then
		table.insert(elements, {label = _U('ems_1'), value = 'ems_1'})
		table.insert(elements, {label = _U('ems_2'), value = 'ems_2'})
		table.insert(elements, {label = _U('ems_3'), value = 'ems_3'})
		table.insert(elements, {label = _U('ems_4'), value = 'ems_4'})
		table.insert(elements, {label = _U('ems_5'), value = 'ems_5'})
		table.insert(elementsAccessories, {label = _U('badge'), value = 'badge'})
		table.insert(elementsAccessories, {label = _U('sma3a'), value = 'sma3a'})
		table.insert(elementsAccessories, {label = _U('radio_belt'), value = 'radio_belt'})
		table.insert(elementsAccessories, {label = _U('radio_belt2'), value = 'radio_belt2'})
		table.insert(elementsAccessories, {label = _U('bag_cbr'), value = 'bag_cbr'})
		table.insert(elementsAccessories, {label = _U('mask2'), value = 'mask2'})
		table.insert(elementsAccessories, {label = _U('chain_remove'), value = 'chain_remove'})
		table.insert(elementsAccessories, {label = _U('mask_remove'), value = 'mask_remove'})
		table.insert(elementsAccessories, {label = _U('bag_remove'), value = 'bag_remove'})
		table.insert(elementsAccessories, {label = _U('belt_remove'), value = 'belt_remove'})
	end

	if  gradeNo >= 1 then
		table.insert(elements, {label = _U('Accessories'), value = 'Accessories'})
	else
		table.insert(elements, {label = _U('Accessories_unavailable')})
	end

	--ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'EMSCloakroomMenu',
	{
		title    = _U('EMSCloakroomMenu'),
		align    = 'top-left',
		elements = elements
	}, function(data2, menu2)

		cleanPlayer(playerPed)

		if data2.current.value == 'citizen_wear' then

			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)

			if Config.MaxInService ~= -1 then

				ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
					if isInService then

						playerInService = false

						local notification = {
							title    = _U('service_anonunce'),
							subject  = '',
							msg      = _U('service_out_announce', GetPlayerName(PlayerId())),
							iconType = 1
						}

						TriggerServerEvent('esx_service:notifyAllInService', notification, 'ambulance')

						TriggerServerEvent('esx_service:disableService', 'ambulance')
						if not Config.OnesyncInfinty then
							TriggerEvent('esx_ambulancejob:updateBlip')
						end
						ESX.ShowNotification(_U('service_out'))
					end
				end, 'ambulance')
			end

		end

		if Config.MaxInService ~= -1 and data2.current.value ~= 'citizen_wear' and data2.current.value ~= 'Accessories' then
			local serviceOk = 'waiting'

			ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
				if not isInService then

					ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
						serviceOk = true
						playerInService = true

						local notification = {
							title    = _U('service_anonunce'),
							subject  = '',
							msg      = _U('service_in_announce', GetPlayerName(PlayerId())),
							iconType = 1
						}

						TriggerServerEvent('esx_service:notifyAllInService', notification, 'ambulance')
						if not Config.OnesyncInfinty then
							TriggerEvent('esx_ambulancejob:updateBlip')
						end
						ESX.ShowNotification(_U('service_in'))
					end, 'ambulance')

				else
					serviceOk = true
				end
			end, 'ambulance')

			while type(serviceOk) == 'string' do
				Citizen.Wait(5)
			end

			-- if we couldn't enter service don't let the player get changed
			if not serviceOk then
				return
			end
		end

		if
			data2.current.value == 'ems_0' or
			data2.current.value == 'ems_1' or
			data2.current.value == 'ems_2' or
			data2.current.value == 'ems_3' or
			data2.current.value == 'ems_4' or
			data2.current.value == 'ems_5'
		then
		    isOnDuty = true
			TriggerServerEvent('esx_mecanojob:n89andzaed', 'zaed_ms3f')
			setUniform(data2.current.value, playerPed)
		elseif data2.current.value == 'Accessories' then
			OpenEMSAccessoriesMenu(elementsAccessories)
		end

	end, function(data2, menu2)
		menu2.close()

	end)
end


function OpenFireCloakroomMenu()

	local playerPed = PlayerPedId()
	local grade = PlayerData.job.grade_name
	local gradeNo = PlayerData.job.grade

	local elements = {}

	local elementsAccessories = {}

	table.insert(elements, {label = _U('fire_0'), value = 'fire_0'})
	--table.insert(elements, {label = _U('Accessories'), value = 'Accessories'})

	--ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'FireCloakroomMenu',
	{
		title    = _U('FireCloakroomMenu'),
		align    = 'top-left',
		elements = elements
	}, function(data2, menu2)

		cleanPlayer(playerPed)

		if data2.current.value == 'citizen_wear' then

			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)

			if Config.MaxInService ~= -1 then

				ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
					if isInService then

						playerInService = false

						local notification = {
							title    = _U('service_anonunce'),
							subject  = '',
							msg      = _U('service_out_announce', GetPlayerName(PlayerId())),
							iconType = 1
						}

						TriggerServerEvent('esx_service:notifyAllInService', notification, 'ambulance')

						TriggerServerEvent('esx_service:disableService', 'ambulance')
						if not Config.OnesyncInfinty then
							TriggerEvent('esx_ambulancejob:updateBlip')
						end
						ESX.ShowNotification(_U('service_out'))
					end
				end, 'ambulance')
			end

		end

		if Config.MaxInService ~= -1 and data2.current.value ~= 'citizen_wear' and data2.current.value ~= 'Accessories' then
			local serviceOk = 'waiting'

			ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
				if not isInService then

					ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
						serviceOk = true
						playerInService = true

						local notification = {
							title    = _U('service_anonunce'),
							subject  = '',
							msg      = _U('service_in_announce', GetPlayerName(PlayerId())),
							iconType = 1
						}

						TriggerServerEvent('esx_service:notifyAllInService', notification, 'ambulance')
						if not Config.OnesyncInfinty then
							TriggerEvent('esx_ambulancejob:updateBlip')
						end
						ESX.ShowNotification(_U('service_in'))
					end, 'ambulance')

				else
					serviceOk = true
				end
			end, 'ambulance')

			while type(serviceOk) == 'string' do
				Citizen.Wait(5)
			end

			-- if we couldn't enter service don't let the player get changed
			if not serviceOk then
				return
			end
		end

		if
			data2.current.value == 'fire_0'
		then
			setUniform(data2.current.value, playerPed)
		elseif data2.current.value == 'Accessories' then
			OpenFireAccessoriesMenu(elementsAccessories)
		end

	end, function(data2, menu2)
		menu2.close()

	end)
end

function OpenEMSAccessoriesMenu(elementsAccessories)

	local playerPed = PlayerPedId()
	local grade = ESX.PlayerData.job.grade_name

	local elements = elementsAccessories

	--ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Accessories',
	{
		title    = _U('Accessories')..' '.._U('EMSCloakroomMenu'),
		align    = 'top-left',
		elements = elements
	}, function(data2, menu2)

		cleanPlayer(playerPed)

		if data2.current.value == 'citizen_wear' then

			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)

			if Config.MaxInService ~= -1 then

				ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
					if isInService then

						playerInService = false

						local notification = {
							title    = _U('service_anonunce'),
							subject  = '',
							msg      = _U('service_out_announce', GetPlayerName(PlayerId())),
							iconType = 1
						}

						TriggerServerEvent('esx_service:notifyAllInService', notification, 'ambulance')

						TriggerServerEvent('esx_service:disableService', 'ambulance')
						if not Config.OnesyncInfinty then
							TriggerEvent('esx_ambulancejob:updateBlip')
						end
						ESX.ShowNotification(_U('service_out'))
					end
				end, 'ambulance')
			end

		end

		if Config.MaxInService ~= -1 and data2.current.value ~= 'citizen_wear' then
			local serviceOk = 'waiting'

			ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
				if not isInService then

					ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
						--if not canTakeService then
							--ESX.ShowNotification(_U('service_max', inServiceCount, maxInService))
						--else

						serviceOk = true
						playerInService = true

						local notification = {
							title    = _U('service_anonunce'),
							subject  = '',
							msg      = _U('service_in_announce', GetPlayerName(PlayerId())),
							iconType = 1
						}

						TriggerServerEvent('esx_service:notifyAllInService', notification, 'ambulance')
						if not Config.OnesyncInfinty then
							TriggerEvent('esx_ambulancejob:updateBlip')
						end
						ESX.ShowNotification(_U('service_in'))
					end, 'ambulance')

				else
					serviceOk = true
				end
			end, 'ambulance')

			while type(serviceOk) == 'string' do
				Citizen.Wait(5)
			end

			-- if we couldn't enter service don't let the player get changed
			if not serviceOk then
				return
			end
		end

		if
			data2.current.value == 'badge' or
			data2.current.value == 'sma3a' or
			data2.current.value == 'radio_belt' or
			data2.current.value == 'radio_belt2' or
			data2.current.value == 'mask2' or
			data2.current.value == 'bag_cbr' or
			data2.current.value == 'chain_remove' or
			data2.current.value == 'mask_remove' or
			data2.current.value == 'bag_remove' or
			data2.current.value == 'belt_remove'
		then
			setUniform(data2.current.value, playerPed)
		end

	end, function(data2, menu2)
		menu2.close()

	end)
end

function OpenFireAccessoriesMenu(elementsAccessories)

	local playerPed = PlayerPedId()
	local grade = PlayerData.job.grade_name

	local elements = elementsAccessories

	--ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Accessories',
	{
		title    = _U('Accessories')..' '.._U('FireCloakroomMenu'),
		align    = 'top-left',
		elements = elements
	}, function(data2, menu2)

		cleanPlayer(playerPed)

		if data2.current.value == 'citizen_wear' then

			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)

			if Config.MaxInService ~= -1 then

				ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
					if isInService then

						playerInService = false

						local notification = {
							title    = _U('service_anonunce'),
							subject  = '',
							msg      = _U('service_out_announce', GetPlayerName(PlayerId())),
							iconType = 1
						}

						TriggerServerEvent('esx_service:notifyAllInService', notification, 'ambulance')

						TriggerServerEvent('esx_service:disableService', 'ambulance')
						if not Config.OnesyncInfinty then
							TriggerEvent('esx_ambulancejob:updateBlip')
						end
						ESX.ShowNotification(_U('service_out'))
					end
				end, 'ambulance')
			end

		end

		if Config.MaxInService ~= -1 and data2.current.value ~= 'citizen_wear' then
			local serviceOk = 'waiting'

			ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
				if not isInService then

					ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
						serviceOk = true
						playerInService = true

						local notification = {
							title    = _U('service_anonunce'),
							subject  = '',
							msg      = _U('service_in_announce', GetPlayerName(PlayerId())),
							iconType = 1
						}

						TriggerServerEvent('esx_service:notifyAllInService', notification, 'ambulance')
						if not Config.OnesyncInfinty then
							TriggerEvent('esx_ambulancejob:updateBlip')
						end
						ESX.ShowNotification(_U('service_in'))
					end, 'ambulance')

				else
					serviceOk = true
				end
			end, 'ambulance')

			while type(serviceOk) == 'string' do
				Citizen.Wait(5)
			end

			-- if we couldn't enter service don't let the player get changed
			if not serviceOk then
				return
			end
		end

		if
			data2.current.value == 'chain_remove' or
			data2.current.value == 'mask_remove'
		then
			setUniform(data2.current.value, playerPed)
		end

	end, function(data2, menu2)
		menu2.close()

	end)
end

function setUniform(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.Uniforms[job].male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		else
			if Config.Uniforms[job].female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		end
	end)
end

RegisterNetEvent('esx_ambulancejob:updateBlip')
AddEventHandler('esx_ambulancejob:updateBlip', function()

	-- Refresh all blips
	for k, existingBlip in pairs(blipsEMS) do
		RemoveBlip(existingBlip)
	end

	-- Clean the blip table
	blipsEMS = {}

	-- Enable blip?
	if Config.MaxInService ~= -1 and not playerInService then
		return
	end

	if not Config.EnableJobBlip then
		return
	end

	-- Is the player a cop? In that case show all the blips for other cops
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then
		ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'ambulance' then
					local id = GetPlayerFromServerId(players[i].source)
					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						createBlip(id)
					end
				end
			end
		end)
	end

end)

-- Create blip for colleagues
function createBlip(id)
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then -- Add blip and create head display on player
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)
		ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
		SetBlipNameToPlayerName(blip, id) -- update blip name
		SetBlipScale(blip, 0.85) -- set scale
		SetBlipAsShortRange(blip, true)

		table.insert(blipsEMS, blip) -- add blip to array so we can remove it later
	end
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if Config.MaxInService ~= -1 then
			TriggerServerEvent('esx_service:disableService', 'ambulance')
		end
	end
end)

function OpenMobileAmbulanceActionsMenu()
	ESX.UI.Menu.CloseAll()
	local elements = {
		{label = "<font color=#FF0000>" .. _U('ems_menu') .. "</font>", value = 'citizen_interaction'},
		{label = "<font color=#33FFFF>" .. _U('ems_bed_menu') .. "</font>", value = 'stretcher'},
		{label = '<font color=ef6c00>قائمة الإكسسوارات</font>', value = "access"},
		{label = "<font color=#66FF66>اظهار كم شخص من الوظائف المعتمده متصل ✔️</font>", value = 'get_players'},
		{label = "<font color=#FFFF33>معرفة معلوماتك في وقت المباشرة 🕒</font>", value = "get_my_info_ambulance_job"}
	}
	if ESX.PlayerData.job.grade == 11 or ESX.PlayerData.job.grade == 12 then
		table.insert(elements, {label = "<font color=#FFCCCC>معرفة معلومات وقت المباشرة لأقرب شخص اليك 👦🏻🕒</font>", value = "get_info_closest_player"})
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_ambulance_actions', {
		title    = "<font color=#FF0000>" .. _U('ambulance') .. "</font>",
		align    = 'top-left',
		elements = elements
	}, function(data3, menu3)
		if data3.current.value == "get_players" then
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
					table.insert(em, {label = "<font color=#00FF00>امن المنشات</font> <font color=white>:</font> [<font color=#00FF00>" .. players.counter_agent .. "</font><font color=white>]</font>"})
					table.insert(em, {label = "<font color=#EB3C3C>الهلال الأحمر</font> <font color=white>:</font> [<font color=#EB3C3C>" .. players.counter_ambulance .. "</font><font color=white>]</font>"})
					table.insert(em, {label = "<font color=#606060>كراج الميكانيك</font> <font color=white>:</font> [<font color=#606060>" .. players.counter_mechanic .. "</font><font color=white>]</font>"})
				end
				ESX.UI.Menu.Open("default", GetCurrentResourceName(), 'm3gon_get_player', {
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
		if data3.current.value == "get_info_closest_player" then
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
						TriggerEvent("esx_admin:getInfoPlayerAmbulanceJob", data3.current.playerId)
					end, function(data3, menu3)
						menu2.close()
				end)
				end, GetPlayerServerId(playerNearby_s))
			end
		end
		if data3.current.value == "get_my_info_ambulance_job" then
			TriggerEvent("esx_admin:getInfoPlayerAmbulanceJob", GetPlayerServerId(PlayerId()))
		end
		if data3.current.value == "access" then
			local elements2 = {}
			table.insert(elements2, { label = 'سترة <font color=red>الهلال الأحمر</font>', value = 'strh_hilal_alahmr'})
			table.insert(elements2, { label = 'سماعة طبية', value = 'sama3h' })
			table.insert(elements2, { label = 'حزام', value = '7ezaam' })
			table.insert(elements2, { label = '<font color=red>إزالة جميع الإكسسوارات</font>', value = 'removeall' })
			ESX.UI.Menu.Open( 'default', GetCurrentResourceName(), 'ambulance_cloakroom_accs', {
				title    = '<font color=ef6c00>قائمة الإكسسوارات</font>',
				align = 'top-left',
				elements = elements2
			}, function(data12, menu12)
				if data12.current.value then
					setUniform(data12.current.value, PlayerPedId(), data12.current.value)
				end
			end, function(data12, menu12)
				menu12.close()
			end)
		end
		if data3.current.value == 'citizen_interaction' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = _U('ems_menu_title'),
				align    = 'top-left',
				elements = {
					{label = _U('ems_menu_revive'), value = 'revive'},
					{label = _U('ems_menu_small'), value = 'small'},
					{label = _U('ems_menu_big'), value = 'big'},
					{label = _U('ems_menu_putincar'), value = 'put_in_vehicle'},
					--{label = _U('ems_menu_search'), value = 'search'}
			}}, function(data, menu)
				if isBusy then return end

				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if data.current.value == 'search' then
					TriggerServerEvent('esx_ambulancejob:svsearch')
				elseif closestPlayer == -1 or closestDistance > 1.0 then
					ESX.ShowNotification(_U('no_players'))
				else
					if data.current.value == 'revive' then
						menu3.close()
						menu.close()
						local eeee = {}
						local ped222 = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 3.0)
						for k_s,playerNearby_s in ipairs(ped222) do
							ESX.TriggerServerCallback('esx_adminjob:getNameplayer', function(name_player_s)
								table.insert(eeee, {label = name_player_s.name, playerId = name_player_s.id, coords_player = name_player_s.coords_player})
								ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stretcher_menu3',
								{
									title		= 'حدد من المسقط',
									align		= 'top-left',
									elements	= eeee
								}, function(data3, menu3)
									menu3.close()
									revivePlayer(data3.current.playerId)
								end, function(data3, menu3)
									menu3.close()
							end)
							end, GetPlayerServerId(playerNearby_s))
						end
					elseif data.current.value == 'sgl_6be' then
						OpenCriminalRecordsEMS(closestPlayer)
					elseif data.current.value == 'small' then
						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)

								if health > 0 then
									local playerPed = PlayerPedId()

									isBusy = true
									ESX.ShowNotification(_U('heal_inprogress'))
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)

									TriggerServerEvent('esx_ambulancejob:removeItem', 'bandage')
									TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
									ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
									isBusy = false
								else
									ESX.ShowNotification(_U('player_not_conscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_bandage'))
							end
						end, 'bandage')

					elseif data.current.value == 'big' then

						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)

								if health > 0 then
									local playerPed = PlayerPedId()

									isBusy = true
									ESX.ShowNotification(_U('heal_inprogress'))
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)

									TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
									TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
									ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
									isBusy = false
								else
									ESX.ShowNotification(_U('player_not_conscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_medikit'))
							end
						end, 'medikit')

					elseif data.current.value == 'put_in_vehicle' then
						TriggerServerEvent('esx_ambulancejob:putInVehicle', GetPlayerServerId(closestPlayer))
					elseif data.current.value == 'ragdoll' then
						TriggerEvent('adrp_fix:ragdoll')
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		elseif data3.current.value == 'stretcher' then
			local closestPlayer2, closestDistance2 = ESX.Game.GetClosestPlayer()
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stretcher_menu',
			{
				title		= "<font color=orange>"..data3.current.label.."</font>",
				align		= 'top-left',
				elements	= {
					{label = "<font color=orange>حرك السرير</font>", value = "pushstreacherss"},
					{label = "<font color=green>افتح باب الأسعاف</font>", value = "opendoors"},
					{label = "<font color=yellow>تثبيت ب الأسعاف</font>", value = "togglestrincar"},
					{label = "<font color=green>وضع المسقط على السرير</font>", value = "getintostretcher"},
					{label = "<font color=orange>انزال المسقط من السرير</font>", value = "getintostretcher_out"},
					{label = "<font color=orange>رسبن السرير</font>", value = "spawnstr"},
					{label = "<font color=white>اذا رسبن السرير وتبي تفكه من يدك اضغط عضلة ال X او زر ال X</font>"},
				}
			}, function(data2, menu2)
				if data2.current.value == "pushstreacherss" then
					TriggerEvent('ARPF-EMS:pushstreacherss')
				elseif data2.current.value == "getintostretcher" then
					local eeee = {}
					local ped222 = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 3.0)
					for k_s,playerNearby_s in ipairs(ped222) do
						ESX.TriggerServerCallback('esx_adminjob:getNameplayer', function(name_player_s)
							table.insert(eeee, {label = name_player_s.name, playerId = name_player_s.id, coords_player = name_player_s.coords_player})
							ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stretcher_menu3',
							{
								title		= 'حدد من المسقط',
								align		= 'top-left',
								elements	= eeee
							}, function(data3, menu3)
								menu3.close()
								--TriggerServerEvent("esx_ambulancejob:setPlayerDeadAnim", data3.current.playerId, true, "srer")
								TriggerServerEvent("esx:getintostr", data3.current.playerId)
							end, function(data3, menu3)
								menu3.close()
						end)
						end, GetPlayerServerId(playerNearby_s))
					end
				elseif data2.current.value == "opendoors" then
					--opendoors()
					ExecuteCommand("openbaydoors_lka;la387g6g@;a38")
				elseif data2.current.value == "togglestrincar" then
					--togglestrincar()
					ExecuteCommand("togglestr_;adja38dgy:a;oh")
				elseif data2.current.value == 'getintostretcher_out' then
					local eeee = {}
					local ped222 = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 3.0)
					for k_s,playerNearby_s in ipairs(ped222) do
						ESX.TriggerServerCallback('esx_adminjob:getNameplayer', function(name_player_s)
							table.insert(eeee, {label = name_player_s.name, playerId = name_player_s.id, coords_player = name_player_s.coords_player})
							ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stretcher_menu3',
							{
								title		= 'حدد من المسقط',
								align		= 'top-left',
								elements	= eeee
							}, function(data3, menu3)
								menu3.close()
								TriggerServerEvent('esx_close:en', data3.current.playerId)
								--TriggerServerEvent("esx_ambulancejob:setPlayerDeadAnim", data3.current.playerId, false, "srer")
							end, function(data3, menu3)
								menu2.close()
						end)
						end, GetPlayerServerId(playerNearby_s))
					end
				elseif data2.current.value == "removestr" then
					--removestr()
					ExecuteCommand("delStr")
				elseif data2.current.value == "spawnstr" then
					ExecuteCommand("spawnstr_kal;da38ydg,b3ydadu;ad;a;;3t7")
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end

	end, function(data3, menu3)
		menu3.close()
	end)
end
--]]
--حذف سرير الاسعاف

function OpenCriminalRecordsEMS(closestPlayer)
    ESX.TriggerServerCallback('esx_qalle_brottsregister:grabEMS', function(ems_sgl_re)

        local elements = {}

        table.insert(elements, {label = 'إضافة سجل', value = 'crime'})
        table.insert(elements, {label = '----= السجلات =----', value = 'spacer'})

        for i=1, #ems_sgl_re, 1 do
            table.insert(elements, {label = ems_sgl_re[i].date .. ' - ' .. ems_sgl_re[i].ems_sgl, value = ems_sgl_re[i].ems_sgl, name = ems_sgl_re[i].name})
        end


        ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'brottsregister',
            {
                title    = 'السجل الطبي',
				align = 'bottom-right',
                elements = elements
            },
        function(data2, menu2)

            if data2.current.value == 'crime' then
                ESX.UI.Menu.Open(
                    'dialog', GetCurrentResourceName(), 'brottsregister_second',
                    {
                        title = 'اكتب السجل?'
                    },
                function(data3, menu3)
                    local ems_new_sgl = (data3.value)
					menu2.close()
					menu3.close()
					TriggerServerEvent('esx_qalle_brottsregister:addEMS', GetPlayerServerId(closestPlayer), ems_new_sgl)
					ESX.ShowNotification('تم اضافة السجل بنجاح')
					Citizen.Wait(100)
					OpenCriminalRecordsEMS(closestPlayer)

                end,
            function(data3, menu3)
                menu3.close()
            end)
        else
            ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'remove_confirmation',
                    {
                    title    = 'ازلة?',
                    elements = {
                        {label = 'نعم', value = 'yes'},
                        {label = 'لا', value = 'no'}
                    }
                },
            function(data3, menu3)

                if data3.current.value == 'yes' then
                    menu2.close()
                    menu3.close()
                    TriggerServerEvent('esx_qalle_brottsregister:removeEMS', GetPlayerServerId(closestPlayer), data2.current.value)
                    ESX.ShowNotification('تم إزالة السجل')
                    Citizen.Wait(100)
                    OpenCriminalRecordsEMS(closestPlayer)
                else
                    menu3.close()
                end

                end,
            function(data3, menu3)
                menu3.close()
            end)
        end

        end,
        function(data2, menu2)
            menu2.close()
        end)

    end, GetPlayerServerId(closestPlayer))
end
AddEventHandler('esx_ambulancejob:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' and IsPedOnFoot(playerPed) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('remove_prop')
		CurrentActionData = {entity = entity}
	end

	if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed)

			for i=0, 7, 1 do
				SetVehicleTyreBurst(vehicle, i, true, 1000)
			end
		end
	end
end)

--[[]]
AddEventHandler('esx_ambulancejob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

-- Enter / Exit entity zone events
Citizen.CreateThread(function()
	local trackedEntities = {
		'prop_ld_binbag_01', --سرير الاسعاف
	}

	while true do
		Citizen.Wait(500)

		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)

		local closestDistance = -1
		local closestEntity   = nil

		for i=1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(playerCoords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

			if DoesEntityExist(object) then
				local objCoords = GetEntityCoords(object)
				local distance = #(playerCoords - objCoords)

				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestEntity   = object
				end
			end
		end

		if closestDistance ~= -1 and closestDistance <= 3.0 then
			if LastEntity ~= closestEntity then
				TriggerEvent('esx_ambulancejob:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
			end
		else
			if LastEntity then
				TriggerEvent('esx_ambulancejob:hasExitedEntityZone', LastEntity)
				LastEntity = nil
			end
		end
	end
end)
--]]

local revcount = -1
local canrevive = true
Citizen.CreateThread(function()
	while true do
		Wait(1000)
		if revcount ~= -1 then
			if revcount > 0 then
				revcount = revcount - 1
			else
				revcount = -1
				canrevive = true
			end
		end
	end
end)

function FastTravel(coords, heading)
	local playerPed = PlayerPedId()

	DoScreenFadeOut(800)

	while not IsScreenFadedOut() do
		Citizen.Wait(500)
	end

	ESX.Game.Teleport(playerPed, coords, function()
		DoScreenFadeIn(800)

		if heading then
			SetEntityHeading(playerPed, heading)
		end
	end)
end

-- Draw markers & Marker logic
Citizen.CreateThread(function()
    Citizen.Wait(1000)
	while true do
		Citizen.Wait(0)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
			local playerCoords = GetEntityCoords(PlayerPedId())
			local letSleep, isInMarker, hasExited = true, false, false
			local currentHospital, currentPart, currentPartNum

			for hospitalNum,hospital in pairs(Config.Hospitals) do
				-- Ambulance Actions
				for k,v in ipairs(hospital.AmbulanceActions) do
					local distance = #(playerCoords - v)

					if distance < Config.DrawDistance then
						DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
						letSleep = false

						if distance < Config.Marker.x then
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'AmbulanceActions', k
						end
					end
				end

				for k,v in ipairs(hospital.Vehicles) do
					local distance = #(playerCoords - v.Spawner)

					if distance < Config.DrawDistance then
						DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
						letSleep = false

						if distance < v.Marker.x then
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Vehicles', k
						end
					end
				end

				-- Helicopter Spawners
				for k,v in ipairs(hospital.Helicopters) do
					local distance = #(playerCoords - v.Spawner)

					if distance < Config.DrawDistance then
						DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
						letSleep = false

						if distance < v.Marker.x then
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Helicopters', k
						end
					end
				end

				-- Fast Travels (Prompt)
				for k,v in ipairs(hospital.FastTravelsPrompt) do
					local distance = #(playerCoords - v.From)

					if distance < Config.DrawDistance then
						DrawMarker(v.Marker.type, v.From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
						letSleep = false

						if distance < v.Marker.x then
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'FastTravelsPrompt', k
						end
					end
				end
			end

			-- Logic for exiting & entering markers
			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
				if
					(LastHospital ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
					(LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('esx_ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum = true, currentHospital, currentPart, currentPartNum

				TriggerEvent('esx_ambulancejob:hasEnteredMarker', currentHospital, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
			end

			if letSleep then
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Fast travels
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords, letSleep = GetEntityCoords(PlayerPedId()), true

		for hospitalNum,hospital in pairs(Config.Hospitals) do
			-- Fast Travels
			for k,v in ipairs(hospital.FastTravels) do
				local distance = #(playerCoords - v.From)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false

					if distance < v.Marker.x then
						FastTravel(v.To.coords, v.To.heading)
					end
				end
			end
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('esx_ambulancejob:hasEnteredMarker', function(hospital, part, partNum)
	if part == 'AmbulanceActions' then
		CurrentAction = part
		CurrentActionMsg = _U('actions_prompt')
		CurrentActionData = {}
	elseif part == 'Pharmacy' then
		CurrentAction = part
		CurrentActionMsg = _U('open_pharmacy')
		CurrentActionData = {}
	elseif part == 'Vehicles' then
		CurrentAction = part
		CurrentActionMsg = _U('garage_prompt')
		CurrentActionData = {hospital = hospital, partNum = partNum}
	elseif part == 'Helicopters' then
		CurrentAction = part
		CurrentActionMsg = _U('helicopter_prompt')
		CurrentActionData = {hospital = hospital, partNum = partNum}
	elseif part == 'FastTravelsPrompt' then
		local travelItem = Config.Hospitals[hospital][part][partNum]

		CurrentAction = part
		CurrentActionMsg = travelItem.Prompt
		CurrentActionData = {to = travelItem.To.coords, heading = travelItem.To.heading}
	end
end)

AddEventHandler('esx_ambulancejob:hasExitedMarker', function(hospital, part, partNum)
	if not isInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

function checkService()
	if Config.EnableESXService then
		ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
			if not isInService then
				playerInService = false
			else
				playerInService = true
			end
		end, 'ambulance')
	else
		playerInService = true
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		checkService()
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'AmbulanceActions' then
					OpenAmbulanceActionsMenu()
				elseif CurrentAction == 'Vehicles' then
				if playerInService then
					TriggerServerEvent('esx:swapPlayerTovehicle', 'car', CurrentActionData.hospital, CurrentAction, CurrentActionData.partNum)
				else
				ESX.ShowNotification(_U('service_not'))
				end
				elseif CurrentAction == 'Helicopters' then
				if playerInService then
					TriggerServerEvent('esx:swapPlayerTovehicle', 'helicopter', CurrentActionData.hospital, CurrentAction, CurrentActionData.partNum)
				else
				ESX.ShowNotification(_U('service_not'))
				end
				elseif CurrentAction == 'FastTravelsPrompt' then
					FastTravel(CurrentActionData.to, CurrentActionData.heading)
				end

				CurrentAction = nil
			end

            if IsControlJustReleased(0, 58) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then

				if CurrentAction == 'remove_entity' then
					DeleteEntity(CurrentActionData.entity)
				end

			end

		elseif ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' and not isDead then
			if isBusy then
				local ncasbcjhas = nil
			elseif not isBusy then
				if IsControlJustReleased(0, 167) then
					if Config.EnableServiceMain then
						if isBusyRevive then
							ESX.ShowNotification('حاليا تجري لديك عمليات انعاش لايمكنك تكرير العملية')
						else
							OpenMobileAmbulanceActionsMenu()
						end
					else
						ESX.ShowNotification(_U('service_not'))
					end
				end
			end
		else
			Citizen.Wait(500)
		end
	end
end)

--[[RegisterNetEvent('esx_ambulancejob:removeBlipPlayerAfterLeave')
AddEventHandler('esx_ambulancejob:removeBlipPlayerAfterLeave', function(id_pl)
	if Config.EnableServiceMain and ESX.PlayerData.job.name == "ambulance" then
		for i=1, #list_dead_player_blips, 1 do
			if i == id_pl then
				RemoveBlip(v)
				list_dead_player_blips[i] = nil
			end
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:removeBlipPlayerDead')
AddEventHandler('esx_ambulancejob:removeBlipPlayerDead', function(id_pl)
	if Config.EnableServiceMain and ESX.PlayerData.job.name == "ambulance" then
		for i=1, #list_dead_player_blips, 1 do
			if i == id_pl then
				RemoveBlip(v)
				list_dead_player_blips[i] = nil
			end
		end
	end
end)--]]


local spawnedVehicles = {}
RegisterNetEvent('esx:OpenVehicleSpawnerMenu')
AddEventHandler('esx:OpenVehicleSpawnerMenu', function(type, hospital, part, partNum)
	local playerCoords = GetEntityCoords(PlayerPedId())

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle', {
		title    = _U('garage_title'),
		align    = 'top-left',
		elements = {
			{label = _U('garage_storeditem'), action = 'garage'},
			{label = _U('garage_storeitem'), action = 'store_garage'},
		--	{label = _U('garage_buyitem'), action = 'buy_vehicle'}
	}}, function(data, menu)
		if data.current.action == 'buy_vehicle' then
			local shopElements = {}
			local authorizedVehicles = Config.AuthorizedVehicles[type][ESX.PlayerData.job.grade_name]
			local shopCoords = Config.Hospitals[hospital][part][partNum].InsideShop

			if #authorizedVehicles > 0 then
				for k,vehicle in ipairs(authorizedVehicles) do
					if IsModelInCdimage(vehicle.model) then
						local vehicleLabel = GetLabelText(GetDisplayNameFromVehicleModel(vehicle.model))

						table.insert(shopElements, {
							label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', ESX.Math.GroupDigits(vehicle.price))),
							name  = vehicle.label,
							model = vehicle.model,
							price = vehicle.price,
							props = vehicle.props,
							type  = type
						})
					end
				end

				if #shopElements > 0 then
					OpenShopMenu(shopElements, playerCoords, shopCoords)
				end
			end
		elseif data.current.action == 'garage' then
			local garage = {}

			ESX.TriggerServerCallback('esx_advancedvehicleshop:retrieveJobVehicles', function(jobVehicles)
				if #jobVehicles > 0 then
					local allVehicleProps = {}

					for k,v in ipairs(jobVehicles) do
						local props = json.decode(v.vehicle)

						if IsModelInCdimage(props.model) then
							local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(props.model))
							local label = ('%s - <span style="color:darkgoldenrod;">%s</span>: '):format(props.plate, v.name)

							if v.stored then
								label = label .. ('<span style="color:green;">%s</span>'):format(_U('garage_stored'))
							else
								label = label .. ('<span style="color:darkred;">%s</span>'):format(_U('garage_notstored'))
							end

							table.insert(garage, {
								label = label,
								stored = v.stored,
								model = props.model,
								plate = props.plate
							})

							allVehicleProps[props.plate] = props
						end
					end

					if #garage > 0 then
						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_garage', {
							title    = _U('garage_title'),
							align    = 'top-left',
							elements = garage
						}, function(data2, menu2)
							if data2.current.stored then
								local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(hospital, part, partNum)

								if foundSpawn then
									menu2.close()

									ESX.Game.SpawnVehicle(data2.current.model, spawnPoint.coords, spawnPoint.heading, function(vehicle)
										local vehicleProps = allVehicleProps[data2.current.plate]
										ESX.Game.SetVehicleProperties(vehicle, vehicleProps)

										TriggerServerEvent('esx_vehicleshop:setJobVehicleState', data2.current.plate, false)
										ESX.ShowNotification(_U('garage_released'))
									end)
								end
							else
								ESX.ShowNotification(_U('garage_notavailable'))
							end
						end, function(data2, menu2)
							menu2.close()
						end)
					else
						ESX.ShowNotification(_U('garage_empty'))
					end
				else
					ESX.ShowNotification(_U('garage_empty'))
				end
			end, type)
		elseif data.current.action == 'store_garage' then
			StoreNearbyVehicle(playerCoords)
		end
	end, function(data, menu)
		menu.close()
	end)
end)

function StoreNearbyVehicle(playerCoords)
	local vehicles, vehiclePlates = ESX.Game.GetVehiclesInArea(playerCoords, 30.0), {}

	if #vehicles > 0 then
		for k,v in ipairs(vehicles) do

			-- Make sure the vehicle we're saving is empty, or else it wont be deleted
			if GetVehicleNumberOfPassengers(v) == 0 and IsVehicleSeatFree(v, -1) then
				table.insert(vehiclePlates, {
					vehicle = v,
					plate = ESX.Math.Trim(GetVehicleNumberPlateText(v))
				})
			end
		end
	else
		ESX.ShowNotification(_U('garage_store_nearby'))
		return
	end

	ESX.TriggerServerCallback('esx_ambulancejob:storeNearbyVehicle', function(storeSuccess, foundNum)
		if storeSuccess then
			local vehicleId = vehiclePlates[foundNum]
			local attempts = 0
			ESX.Game.DeleteVehicle(vehicleId.vehicle)
			isBusy = true

			Citizen.CreateThread(function()
				while isBusy do
					Citizen.Wait(0)
					drawLoadingText(_U('garage_storing'), 255, 255, 255, 255)
				end
			end)

			-- Workaround for vehicle not deleting when other players are near it.
			while DoesEntityExist(vehicleId.vehicle) do
				Citizen.Wait(500)
				attempts = attempts + 1

				-- Give up
				if attempts > 30 then
					break
				end

				vehicles = ESX.Game.GetVehiclesInArea(playerCoords, 30.0)
				if #vehicles > 0 then
					for k,v in ipairs(vehicles) do
						if ESX.Math.Trim(GetVehicleNumberPlateText(v)) == vehicleId.plate then
							ESX.Game.DeleteVehicle(v)
							break
						end
					end
				end
			end

			isBusy = false
			ESX.ShowNotification(_U('garage_has_stored'))
		else
			ESX.ShowNotification(_U('garage_has_notstored'))
		end
	end, vehiclePlates)
end

function GetAvailableVehicleSpawnPoint(hospital, part, partNum)
	local spawnPoints = Config.Hospitals[hospital][part][partNum].SpawnPoints
	local found, foundSpawnPoint = false, nil

	for i=1, #spawnPoints, 1 do
		if ESX.Game.IsSpawnPointClear(spawnPoints[i].coords, spawnPoints[i].radius) then
			found, foundSpawnPoint = true, spawnPoints[i]
			break
		end
	end

	if found then
		return true, foundSpawnPoint
	else
		ESX.ShowNotification(_U('garage_blocked'))
		return false
	end
end

function OpenShopMenu(elements, restoreCoords, shopCoords)
	local playerPed = PlayerPedId()
	isInShopMenu = true

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop', {
		title    = _U('vehicleshop_title'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop_confirm', {
			title    = _U('vehicleshop_confirm', data.current.name, data.current.price),
			align    = 'top-left',
			elements = {
				{label = _U('confirm_no'), value = 'no'},
				{label = _U('confirm_yes'), value = 'yes'}
		}}, function(data2, menu2)
			if data2.current.value == 'yes' then
				local newPlate = exports['esx_vehicleshop']:GeneratePlate()
				local vehicle  = GetVehiclePedIsIn(playerPed, false)
				local props    = ESX.Game.GetVehicleProperties(vehicle)
				props.plate    = newPlate

				ESX.TriggerServerCallback('esx_ambulancejob:buyJobVehicle', function(bought)
					if bought then
						ESX.ShowNotification(_U('vehicleshop_bought', data.current.name, ESX.Math.GroupDigits(data.current.price)))

						isInShopMenu = false
						ESX.UI.Menu.CloseAll()

						DeleteSpawnedVehicles()
						FreezeEntityPosition(playerPed, false)
						SetEntityVisible(playerPed, true)

						ESX.Game.Teleport(playerPed, restoreCoords)
					else
						ESX.ShowNotification(_U('vehicleshop_money'))
						menu2.close()
					end
				end, props, data.current.type, data.current.name)
			else
				menu2.close()
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		isInShopMenu = false
		ESX.UI.Menu.CloseAll()

		DeleteSpawnedVehicles()
		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)

		ESX.Game.Teleport(playerPed, restoreCoords)
	end, function(data, menu)
		DeleteSpawnedVehicles()
		WaitForVehicleToLoad(data.current.model)

		ESX.Game.SpawnLocalVehicle(data.current.model, shopCoords, 0.0, function(vehicle)
			table.insert(spawnedVehicles, vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
			SetModelAsNoLongerNeeded(data.current.model)

			if data.current.props then
				ESX.Game.SetVehicleProperties(vehicle, data.current.props)
			end
		end)
	end)

	WaitForVehicleToLoad(elements[1].model)
	ESX.Game.SpawnLocalVehicle(elements[1].model, shopCoords, 0.0, function(vehicle)
		table.insert(spawnedVehicles, vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
		SetModelAsNoLongerNeeded(elements[1].model)

		if elements[1].props then
			ESX.Game.SetVehicleProperties(vehicle, elements[1].props)
		end
	end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if isInShopMenu then
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		else
			Citizen.Wait(500)
		end
	end
end)

function DeleteSpawnedVehicles()
	while #spawnedVehicles > 0 do
		local vehicle = spawnedVehicles[1]
		ESX.Game.DeleteVehicle(vehicle)
		table.remove(spawnedVehicles, 1)
	end
end

function WaitForVehicleToLoad(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		BeginTextCommandBusyspinnerOn('STRING')
		AddTextComponentSubstringPlayerName(_U('vehicleshop_awaiting_model'))
		EndTextCommandBusyspinnerOn(4)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)
			DisableAllControlActions(0)
		end

		BusyspinnerOff()
	end
end

RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
			end
		end
	end
end)

--[[
function OpenCloakroomMenu()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = _U('cloakroom'),
		align    = 'top-left',
		elements = {
			{label = _U('ems_clothes_civil'), value = 'citizen_wear'},
			{label = _U('ems_clothes_ems'), value = 'ambulance_wear'},
			{label = ('اللبس الميداني'), value = 'ambulance0_wear'},
	}}, function(data, menu)
		if data.current.value == 'citizen_wear' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
				isOnDuty = false

				for playerId,v in pairs(deadPlayerBlips) do
					RemoveBlip(v)
					deadPlayerBlips[playerId] = nil
				end
			end)
		elseif data.current.value == 'ambulance0_wear' then
			menu.close()
		--OnDuty = true
        TriggerEvent('skinchanger:getSkin', function(skin)

          if skin.sex == 0 then

            local clothesSkin = {
              ['tshirt_1'] = 19,
              ['tshirt_2'] = 1,
	          ['shoes_1'] = 42,
	          ['helmet_1'] = 10,
              ['torso_1'] = 250,
              ['torso_2'] = 0,
              ['decals_1'] = 0,
              ['decals_2'] = 0,
              ['arms'] = 0,
              ['pants_1'] = 4,
              ['pants_2'] = 1,
              ['ears_1'] = 3,
			  ['chain_1'] = 30,
              ['ears_2'] = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			isOnDuty = true
				end
			end)
		elseif data.current.value == 'ambulance_wear' then

			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
				else
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
				end

				isOnDuty = true
				TriggerEvent('esx_ambulancejob:setDeadPlayers', deadPlayers)
			end)
		end

		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end
--]]

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(healType, quiet)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'big' then
		SetEntityHealth(playerPed, maxHealth)
	end

	if not quiet then
		ESX.ShowNotification(_U('healed'))
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	if isOnDuty and job ~= 'ambulance' then
		for playerId,v in pairs(deadPlayerBlips) do
			RemoveBlip(v)
			deadPlayerBlips[playerId] = nil
		end

		isOnDuty = false
	end
end)

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




local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum
local isBusy, deadPlayers, deadPlayerBlips, isOnDuty = false, {}, {}, false
isInShopMenu = false

local Timmingg = 0

Citizen.CreateThread( function()
  while true do
    Citizen.Wait(0)
    if Timmingg > 0 then
      Citizen.Wait(1000)
      Timmingg = Timmingg - 1
    else
		Citizen.Wait(500)
    end
  end
end)

function OpenAmbulanceActionsMenu()
	local elements = {{label = "<font color=white>::: <font color=00FF00>غرفة تبديل <font color=white>:::", value = 'cloakroom'}}
	if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions', {
		title    ="<font color=#FF0000>" .. _U('ambulance') .. "</font>",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'cloakroom' then
			OpenCloakroomMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
				menu.close()
			end, {wash = false})
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenAmbulanceActionsMenu222()
	local gradee = ESX.PlayerData.job.grade_name
	if gradee == 'boss' or gradee == 'boss2' or gradee == 'boss3' then
		ESX.UI.Menu.CloseAll()
		TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
			menu.close()
		end, {wash = false, employees = true, grades = false})
	else
		ESX.ShowNotification('خزنة الطوارئ الطبية<font color=red> غير متاحة </font>لمستواك')
	end
end

RegisterNetEvent('esx_ambulancejob:setPlayerDeadAnim:client')
AddEventHandler('esx_ambulancejob:setPlayerDeadAnim:client', function()
	SetEntityHealth(PlayerPedId(), 0)
end)
function revivePlayer(closestPlayer)
	isBusyRevive = true
	ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
		if quantity > 0 then
			local closestPlayerPed = GetPlayerPed(closestPlayer)
			--TriggerServerEvent('esx_ambulancejob:setPlayerDeadAnim', closestPlayer, true)
			ESX.TriggerServerCallback("esx_ambulancejob:checkPlayerIsDead", function(data)
				if data then
					local playerPed = PlayerPedId()
					local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'
					ESX.ShowNotification(_U('revive_inprogress'))
					--TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 8.0, 'ems', 0.8)
					local position = GetEntityCoords(PlayerPedId())
					PlayerPanicSound(position)
					for i=1, 15 do
						Citizen.Wait(900)

						ESX.Streaming.RequestAnimDict(lib, function()
							TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
						end)
					end

					TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
					TriggerServerEvent('esx_ambulancejob:revive', closestPlayer)
					--TriggerServerEvent('esx_ambulancejob:setPlayerDeadAnim', closestPlayer, false)
					Timmingg = 60
				else
					ESX.ShowNotification(_U('player_not_unconscious'))
				end
			end, closestPlayer)
		else
			ESX.ShowNotification(_U('not_enough_medikit'))
		end
	end, 'medikit')
	isBusyRevive = false
end

function FastTravel(coords, heading)
	local playerPed = PlayerPedId()

	DoScreenFadeOut(800)

	while not IsScreenFadedOut() do
		Citizen.Wait(500)
	end

	ESX.Game.Teleport(playerPed, coords, function()
		DoScreenFadeIn(800)

		if heading then
			SetEntityHeading(playerPed, heading)
		end
	end)
end

-- Draw markers & Marker logic
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
			local playerCoords = GetEntityCoords(PlayerPedId())
			local letSleep, isInMarker, hasExited = true, false, false
			local currentHospital, currentPart, currentPartNum

			for hospitalNum,hospital in pairs(Config.Hospitals) do
				-- Ambulance Actions
				for k,v in ipairs(hospital.AmbulanceActions) do
					local distance = #(playerCoords - v)

					if distance < Config.DrawDistance then
						DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
						letSleep = false

						if distance < Config.Marker.x then
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'AmbulanceActions', k
						end
					end
				end
				-- Ambulance Actions222
				if hospital.AmbulanceActions222 then
					for k,v in ipairs(hospital.AmbulanceActions222) do
						if isOnDuty then
								local distance = #(playerCoords - v)

								if distance < Config.DrawDistance then
									DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
									letSleep = false

									if distance < Config.Marker.x then
										isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'AmbulanceActions222', k
									end
								end
						end
					end
				end
			end

			-- Logic for exiting & entering markers
			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
				if
					(LastHospital ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
					(LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('esx_ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum = true, currentHospital, currentPart, currentPartNum

				TriggerEvent('esx_ambulancejob:hasEnteredMarker', currentHospital, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
			end

			if letSleep then
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('esx_ambulancejob:hasEnteredMarker', function(hospital, part, partNum)
	if part == 'AmbulanceActions' then
		CurrentAction = part
		CurrentActionMsg = _U('actions_prompt')
		CurrentActionData = {}
	elseif part == 'AmbulanceActions222' then
		CurrentAction = part
		CurrentActionMsg = _U('actions_prompt')
		CurrentActionData = {}
	end
end)

AddEventHandler('esx_ambulancejob:hasExitedMarker', function(hospital, part, partNum)
	if not isInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'AmbulanceActions' then
					OpenAmbulanceActionsMenu()
				elseif CurrentAction == 'AmbulanceActions222' then
					OpenAmbulanceActionsMenu222()
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
			end
		end
	end
end)

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function setUniform(uniform, playerPed, type)
	TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject

		if skin.sex == 0 then -- male
			if type == 'ambulance' then
				uniformObject = Config.Uniform[uniform].m
			elseif type == 'sama3h' then
				uniformObject = {['chain_1'] = 126,    ['chain_2'] = 0}
			elseif type == "strh_hilal_alahmr" then
				uniformObject = {['chain_1'] = 13,  ['chain_2'] = 0}
			elseif type == '7ezaam' then
				uniformObject = {['tshirt_1'] = 129,  ['tshirt_2'] = 0}
			elseif type == 'jehaz' then
				uniformObject = {['bags_1'] = 38, ['bags_2'] = 0}
			elseif type == 'mask' then
				uniformObject = {['mask_1'] = 52, ['mask_2'] = 0}
			elseif type == 'removeall' then
				uniformObject = {
					['chain_1'] = 0,    ['chain_2'] = 0,
					['tshirt_1'] = 15,  ['tshirt_2'] = 0,
					['bags_1'] = 0, ['bags_2'] = 0,
					['mask_1'] = 0, ['mask_2'] = 0,
				}
			end
		else
			if type == 'ambulance' then
				uniformObject = Config.Uniform[uniform].f
			elseif type == "strh_hilal_alahmr" then
				uniformObject = {['chain'] = 13,  ['chain'] = 0}
			elseif type == 'sama3h' then
				uniformObject = {['chain_1'] = 96,    ['chain_2'] = 0}
			elseif type == '7ezaam' then
				uniformObject = {['tshirt_1'] = 159,  ['tshirt_2'] = 0}
			elseif type == 'jehaz' then
				uniformObject = {['bags_1'] = 38, ['bags_2'] = 0}
			elseif type == 'mask' then
				uniformObject = {['mask_1'] = 52, ['mask_2'] = 0}
			elseif type == 'removeall' then
				uniformObject = {
					['chain_1'] = 0,    ['chain_2'] = 0,
					['tshirt_1'] = 14,  ['tshirt_2'] = 0,
					['bags_1'] = 0, ['bags_2'] = 0,
					['mask_1'] = 0, ['mask_2'] = 0,
				}
			end
		end

		if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)

			if uniform == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		else
			ESX.ShowNotification('خطأ. لايوجد لبس مناسب لك')
		end
	end)
end



function OpenCloakroomMenu()
	ESX.UI.Menu.CloseAll()

	local playerPed = PlayerPedId()
	local grade = ESX.PlayerData.job.grade
	local gradelabel = ESX.PlayerData.job.grade_label

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = "<font color=white>::: <font color=00FF00>غرفة تبديل <font color=white>:::",
		align    = 'top-left',
		elements = {
			{label = _U('ems_clothes_civil'), value = 'citizen_wear'},
			{label = '<font color=orange>'..gradelabel..'</font>', Uniform = grade, type = 'ambulance'},
			{label = '<font color=ef6c00>قائمة الإكسسوارات</font>', value = 'access'},
	}}, function(data, menu)
		cleanPlayer(playerPed)

		if data.current.value == 'citizen_wear' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
				isOnDuty = false
				Config.EnableServiceMain = false
				for playerId,v in pairs(deadPlayerBlips) do
					RemoveBlip(v)
					deadPlayerBlips[playerId] = nil
				end
				ESX.ShowNotification('تم <font color=red>تسجيل الخروج</font> من الخدمة بنجاح')
			end)
		elseif data.current.value == 'access' then
			if isOnDuty then
				local elements2233 = {}
				table.insert(elements2233, { label = 'سترة <font color=red>الهلال الأحمر</font>', value = 'strh_hilal_alahmr'})
				table.insert(elements2233, { label = 'سماعة طبية', value = 'sama3h' })
				table.insert(elements2233, { label = 'حزام راديو', value = '7ezaam' })
				table.insert(elements2233, { label = '<font color=red>إزالة جميع الإكسسوارات</font>', value = 'removeall' })
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom_2', {
					title    = '<font color=ef6c00>قائمة الإكسسوارات</font>',
					align    = 'top-left',
					elements = elements2233
				}, function(data2, menu2)
					if data2.current.value then
						setUniform(data2.current.value, playerPed, data2.current.value)
					end
				end, function(data2, menu2)
					menu2.close()
				end)
			else
				ESX.ShowNotification('<font color=red>يجب تسجيل الدخول للإستفادة من الإكسسوارات</font>')
			end
		end

		if data.current.Uniform then
			ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
				if canTakeService then
					Config.EnableServiceMain = true
					setUniform(data.current.Uniform, playerPed, data.current.type)
					isOnDuty = true
					TriggerEvent('esx_ambulancejob:setDeadPlayers', deadPlayers)
					TriggerServerEvent("esx_ambulancejob:sendToAllPlayersNotficiton", ESX.PlayerData.job.grade_label)
					ESX.ShowNotification('تم <font color=green>تسجيل الدخول</font> في الخدمة بنجاح')
				else
					ESX.ShowNotification('<font color=red>العدد مكتمل في الخدمة <font color=orange>'..inServiceCount..'/'..maxInService)
				end
			end, 'ambulance')
		end
	end, function(data, menu)
		menu.close()
	end)
end

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(healType, quiet)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'big' then
		SetEntityHealth(playerPed, maxHealth)
	end

	if not quiet then
		ESX.ShowNotification(_U('healed'))
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	if isOnDuty and job ~= 'ambulance' then
		for playerId,v in pairs(deadPlayerBlips) do
			RemoveBlip(v)
			deadPlayerBlips[playerId] = nil
		end

		isOnDuty = false
	end
end)

RegisterNetEvent('esx_ambulancejob:setDeadPlayers')
AddEventHandler('esx_ambulancejob:setDeadPlayers', function(_deadPlayers, coords)
	deadPlayers = _deadPlayers

	if isOnDuty then
		for playerId,v in pairs(deadPlayerBlips) do
			RemoveBlip(v)
			deadPlayerBlips[playerId] = nil
		end

		for playerId,status in pairs(deadPlayers) do
			if status == 'distress' then
				local blip = AddBlipForCoord(coords.x, coords.y, coord.z)
				SetBlipSprite(blip, 303)
				SetBlipColour(blip, 1)
				SetBlipFlashes(blip, true)
				SetBlipCategory(blip, 7)

				BeginTextCommandSetBlipName('STRING')
				AddTextComponentSubstringPlayerName(_U('blip_dead'))
				EndTextCommandSetBlipName(blip)

				deadPlayerBlips[playerId] = blip
			end
		end
	end
end)


--[[Citizen.CreateThread(function()
	local DeathReason, Killer, DeathCauseHash, Weapon

	while true do
		Citizen.Wait(0)
		local PedKiller = GetPedSourceOfDeath(PlayerPedId())
		local killername = GetPlayerName(PedKiller)
		if IsEntityDead(PlayerPedId()) then
			Citizen.Wait(0)
			local PedKiller = GetPedSourceOfDeath(PlayerPedId())
			local killername = GetPlayerName(PedKiller)
			DeathCauseHash = GetPedCauseOfDeath(PlayerPedId())
			if IsEntityAPed(PedKiller) and IsPedAPlayer(PedKiller) then
				Killer = NetworkGetPlayerIndexFromPed(PedKiller)
			elseif IsEntityAVehicle(PedKiller) and IsEntityAPed(GetPedInVehicleSeat(PedKiller, -1)) and IsPedAPlayer(GetPedInVehicleSeat(PedKiller, -1)) then
				Killer = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(PedKiller, -1))
			end
			if (Killer == PlayerId()) then
				DeathReason = 'committed suicide'
			elseif (Killer == nil) then
				DeathReason = 'died'
			else
				if IsMelee(DeathCauseHash) then
					DeathReason = 'murdered'
				elseif IsTorch(DeathCauseHash) then
					DeathReason = 'torched'
				elseif IsKnife(DeathCauseHash) then
					DeathReason = 'knifed'
				elseif IsPistol(DeathCauseHash) then
					DeathReason = 'pistoled'
				elseif IsSub(DeathCauseHash) then
					DeathReason = 'riddled'
				elseif IsRifle(DeathCauseHash) then
					DeathReason = 'rifled'
				elseif IsLight(DeathCauseHash) then
					DeathReason = 'machine gunned'
				elseif IsShotgun(DeathCauseHash) then
					DeathReason = 'pulverized'
				elseif IsSniper(DeathCauseHash) then
					DeathReason = 'sniped'
				elseif IsHeavy(DeathCauseHash) then
					DeathReason = 'obliterated'
				elseif IsMinigun(DeathCauseHash) then
					DeathReason = 'shredded'
				elseif IsBomb(DeathCauseHash) then
					DeathReason = 'bombed'
				elseif IsVeh(DeathCauseHash) then
					DeathReason = 'mowed over'
				elseif IsVK(DeathCauseHash) then
					DeathReason = 'flattened'
				else
					DeathReason = 'killed'
				end
			end
			if DeathReason == 'committed suicide' or DeathReason == 'died' then
				--print(PlayerId(),_Killier,DeathReason,Weapon)
			else
				--print(PlayerId(),GetPlayerServerId(Killer),DeathReason,Weapon)
			end
			Killer = nil
			DeathReason = nil
			DeathCauseHash = nil
			Weapon = nil
		end
		while IsEntityDead(PlayerPedId()) do
			Citizen.Wait(0)
		end
	end
end)--]]


-- XSOUND
xSound = exports.xsound

local musicId
local playing = false
local pos
--[[Citizen.CreateThread(function()
    Citizen.Wait(1000)
    musicId = "music_id_" .. PlayerPedId()
    while true do
        Citizen.Wait(100)
        if xSound:soundExists(musicId) and playing then
            if xSound:isPlaying(musicId) then
                TriggerServerEvent("esx_misc4:xsound:playe3dsound", "position", musicId, { position = pos })
            else
                Citizen.Wait(1000)
            end
        else
            Citizen.Wait(1000)
        end
    end
end)--]]

function PlayerPanicSound(position)
    pos = position
    playing = true
    TriggerServerEvent("esx_misc4:xsound:playe3dsound", "play", musicId, { position = pos, link = "https://cdn.discordapp.com/attachments/662449900226609173/861485316505206794/ems.ogg" })
end

RegisterNetEvent("esx_misc4:xsound:playe3dsound")
AddEventHandler("esx_misc4:xsound:playe3dsound", function(type, musicId, data)
    if type == "position" then
        if xSound:soundExists(musicId) then
            xSound:Position(musicId, data.position)
            xSound:setVolumeMax(musicId, 0.55)
        end
    end

    if type == "play" then
        xSound:PlayUrlPos(musicId, data.link, 1, data.position)
        xSound:Distance(musicId, 15)
        xSound:setVolumeMax(musicId, 0.55)
    end
end)

RegisterNetEvent('esx_ambulancejob:setDeadPlayers')
AddEventHandler('esx_ambulancejob:setDeadPlayers', function(_deadPlayers, coords)
	deadPlayers = _deadPlayers

	if isOnDuty then
		for playerId,v in pairs(deadPlayerBlips) do
			RemoveBlip(v)
			deadPlayerBlips[playerId] = nil
		end

		for playerId,status in pairs(deadPlayers) do
			if status == 'distress' then
				local blip = AddBlipForCoord(coords.x, coords.y, coord.z)

				SetBlipSprite(blip, 303)
				SetBlipColour(blip, 1)
				SetBlipFlashes(blip, true)
				SetBlipCategory(blip, 7)

				BeginTextCommandSetBlipName('STRING')
				AddTextComponentSubstringPlayerName(_U('blip_dead'))
				EndTextCommandSetBlipName(blip)

				deadPlayerBlips[playerId] = blip
			end
		end
	end
end)
