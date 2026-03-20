ESX = nil

local timing, isPlayerWhitelisted = math.ceil(Config.Timer * 60000), false
local streetName, playerGender
local list_shot_fire = {}
local counter_shot_fire = 0
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

	TriggerEvent('skinchanger:getSkin', function(skin)
		playerGender = skin.sex
	end)

	isPlayerWhitelisted = refreshPlayerWhitelisted()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, 20) then
			if ESX.PlayerData.job.name == "police" or ESX.PlayerData.job.name == "agent" then
				if #list_shot_fire == 0 then
					ESX.UI.Menu.Open("default", GetCurrentResourceName(), "menu_list_shot_fire_none_in_adminx", {
						title = "قائمة بلاغات اطلاق النار",
						align = "top-left",
						elements = {
							{label = "<font color=orange>لايوجد اي بلاغ اطلاق نار</font>"}
						}
					}, function(data_list_shot_fire_none_in_admin, menu_list_shot_fire_none_in_admin)
					end, function(data_list_shot_fire_none_in_admin, menu_list_shot_fire_none_in_admin)
						menu_list_shot_fire_none_in_admin.close()
					end)
				else
					local elements = {}
					local coords = nil
					table.insert(elements, {label = "<font color=orange>حذف جميع بلاغات اطلاق النار</font>", value = "remove_all_shot_fire"})
					for i,v in ipairs(list_shot_fire) do
						table.insert(elements, {label = "<font color=orange>بلاغ</font> <font color=red>اطلاق نار</font> <font color=orange>رقم</font><font color=white>:</font> " .. tonumber(i), value = tonumber(i), coords = v})
					end
					ESX.UI.Menu.Open("default", GetCurrentResourceName(), "menu_list_shot_fire_in_admins", {
						title = "قائمة بلاغات اطلاق النار",
						align = "top-left",
						elements = elements
					}, function(data_list_shot_fire_in_admin, menu_list_shot_fire_in_admin)
						menu_list_shot_fire_in_admin.close()
						if data_list_shot_fire_in_admin.current.value == "remove_all_shot_fire" then
							for i,v in pairs(list_shot_fire) do
								list_shot_fire[i] = nil
							end
							ESX.ShowNotification("<font color=#33FF33>تم حذف جميع بلاغات اطلاق النار بنجاح</font>")
						else
							ESX.UI.Menu.Open("default", GetCurrentResourceName(), "check_sure", {
								title = "<font color=orange>هل انت متأكد</font>",
								align = "top-left",
								elements = {
									{label = "<font color=#33FF33>نعم</font>", value = "yes"},
									{label = "<font color=red>لا</font>", value = "no"}
								}
							}, function(data_sure_admin, menu_sure_admin)
								if data_sure_admin.current.value == "yes" then
									menu_sure_admin.close()
									SetNewWaypoint(tonumber(data_list_shot_fire_in_admin.current.coords.x), tonumber(data_list_shot_fire_in_admin.current.coords.y))
								elseif data_sure_admin.current.value == "no" then
									menu_sure_admin.close()
								end
							end, function(data_sure_admin, menu_sure_admin)
								menu_sure_admin.close()
							end)
						end
					end, function(data_list_shot_fire_in_admin, menu_list_shot_fire_in_admin)
						menu_list_shot_fire_in_admin.close()
					end)
				end
			end
		end
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job

	isPlayerWhitelisted = refreshPlayerWhitelisted()
end)

RegisterNetEvent('esx_wesam:goTolistShotFireClient')
AddEventHandler('esx_wesam:goTolistShotFireClient', function()
	if ESX.PlayerData.job.name == "admin" then
		if #list_shot_fire == 0 then
			ESX.UI.Menu.Open("default", GetCurrentResourceName(), "menu_list_shot_fire_none_in_adminx", {
				title = "قائمة بلاغات اطلاق النار",
				align = "top-left",
				elements = {
					{label = "<font color=orange>لايوجد اي بلاغ اطلاق نار</font>"}
				}
			}, function(data_list_shot_fire_none_in_admin, menu_list_shot_fire_none_in_admin)
			end, function(data_list_shot_fire_none_in_admin, menu_list_shot_fire_none_in_admin)
				menu_list_shot_fire_none_in_admin.close()
			end)
		else
			local elements = {}
			local coords = nil
			table.insert(elements, {label = "<font color=orange>حذف جميع بلاغات اطلاق النار</font>", value = "remove_all_shot_fire"})
			for i,v in ipairs(list_shot_fire) do
				table.insert(elements, {label = "<font color=orange>بلاغ</font> <font color=red>اطلاق نار</font> <font color=orange>رقم</font><font color=white>:</font> " .. tonumber(i), value = tonumber(i), coords = v})
			end
			ESX.UI.Menu.Open("default", GetCurrentResourceName(), "menu_list_shot_fire_in_admins", {
				title = "قائمة بلاغات اطلاق النار",
				align = "top-left",
				elements = elements
			}, function(data_list_shot_fire_in_admin, menu_list_shot_fire_in_admin)
				menu_list_shot_fire_in_admin.close()
				if data_list_shot_fire_in_admin.current.value == "remove_all_shot_fire" then
					ESX.UI.Menu.Open("default", GetCurrentResourceName(), "check_sure", {
						title = "<font color=orange>هل انت متأكد</font>",
						align = "top-left",
						elements = {
							{label = "<font color=#33FF33>نعم</font>", value = "yes"},
							{label = "<font color=red>لا</font>", value = "no"}
						}
					}, function(data_sure_admin, menu_sure_admin)
						if data_sure_admin.current.value == "yes" then
							menu_sure_admin.close()
							for i,v in pairs(list_shot_fire) do
								list_shot_fire[i] = nil
							end
							ESX.ShowNotification("<font color=#33FF33>تم حذف جميع بلاغات اطلاق النار بنجاح</font>")
						elseif data_sure_admin.current.value == "no" then
							menu_sure_admin.close()
						end
					end, function(data_sure_admin, menu_sure_admin)
						menu_sure_admin.close()
					end)
				else
					ESX.UI.Menu.Open("default", GetCurrentResourceName(), "check_sure", {
						title = "<font color=orange>هل انت متأكد</font>",
						align = "top-left",
						elements = {
							{label = "<font color=#33FF33>نعم</font>", value = "yes"},
							{label = "<font color=red>لا</font>", value = "no"}
						}
					}, function(data_sure_admin, menu_sure_admin)
						if data_sure_admin.current.value == "yes" then
							menu_sure_admin.close()
							SetNewWaypoint(tonumber(data_list_shot_fire_in_admin.current.coords.x), tonumber(data_list_shot_fire_in_admin.current.coords.y))
						elseif data_sure_admin.current.value == "no" then
							menu_sure_admin.close()
						end
					end, function(data_sure_admin, menu_sure_admin)
						menu_sure_admin.close()
					end)
				end
			end, function(data_list_shot_fire_in_admin, menu_list_shot_fire_in_admin)
				menu_list_shot_fire_in_admin.close()
			end)
		end
	elseif ESX.PlayerData.job.name == "police" or ESX.PlayerData.job.name == "agent" then
		if #list_shot_fire == 0 then
			ESX.UI.Menu.Open("default", GetCurrentResourceName(), "menu_list_shot_fire_none_in_adminx", {
				title = "قائمة بلاغات اطلاق النار",
				align = "top-left",
				elements = {
					{label = "<font color=orange>لايوجد اي بلاغ اطلاق نار</font>"}
				}
			}, function(data_list_shot_fire_none_in_admin, menu_list_shot_fire_none_in_admin)
			end, function(data_list_shot_fire_none_in_admin, menu_list_shot_fire_none_in_admin)
				menu_list_shot_fire_none_in_admin.close()
			end)
		else
			local elements = {}
			local coords = nil
			table.insert(elements, {label = "<font color=orange>حذف جميع بلاغات اطلاق النار</font>", value = "remove_all_shot_fire"})
			for i,v in ipairs(list_shot_fire) do
				table.insert(elements, {label = "<font color=orange>بلاغ</font> <font color=red>اطلاق نار</font> <font color=orange>رقم</font><font color=white>:</font> " .. tonumber(i), value = tonumber(i), coords = v})
			end
			ESX.UI.Menu.Open("default", GetCurrentResourceName(), "menu_list_shot_fire_in_admins", {
				title = "قائمة بلاغات اطلاق النار",
				align = "top-left",
				elements = elements
			}, function(data_list_shot_fire_in_admin, menu_list_shot_fire_in_admin)
				menu_list_shot_fire_in_admin.close()
				if data_list_shot_fire_in_admin.current.value == "remove_all_shot_fire" then
					for i,v in pairs(list_shot_fire) do
						list_shot_fire[i] = nil
					end
					ESX.ShowNotification("<font color=#33FF33>تم حذف جميع بلاغات اطلاق النار بنجاح</font>")
				else
					ESX.UI.Menu.Open("default", GetCurrentResourceName(), "check_sure", {
						title = "<font color=orange>هل انت متأكد</font>",
						align = "top-left",
						elements = {
							{label = "<font color=#33FF33>نعم</font>", value = "yes"},
							{label = "<font color=red>لا</font>", value = "no"}
						}
					}, function(data_sure_admin, menu_sure_admin)
						if data_sure_admin.current.value == "yes" then
							menu_sure_admin.close()
							SetNewWaypoint(tonumber(data_list_shot_fire_in_admin.current.coords.x), tonumber(data_list_shot_fire_in_admin.current.coords.y))
						elseif data_sure_admin.current.value == "no" then
							menu_sure_admin.close()
						end
					end, function(data_sure_admin, menu_sure_admin)
						menu_sure_admin.close()
					end)
				end
			end, function(data_list_shot_fire_in_admin, menu_list_shot_fire_in_admin)
				menu_list_shot_fire_in_admin.close()
			end)
		end
	end
end)

RegisterNetEvent('esx_outlawalert:outlawNotify12')
AddEventHandler('esx_outlawalert:outlawNotify12', function(case,gender,place,temp,info_player_is, coords_player)
	if isPlayerWhitelisted then
		if info_player_is and place and temp and gender and case then
			if ESX.PlayerData.job.name == "admin" then
				if #list_shot_fire == 0 then
					counter_shot_fire = 1
				else
					for i=1, #list_shot_fire, 1 do
						counter_shot_fire = counter_shot_fire + 1
					end
				end
				list_shot_fire = {coords = coords_player, name = info_player_is.name_player, id_p = tonumber(info_player_is.playerid), identifier = info_player_is.iden_player, job = info_player_is.job .. " - " .. info_player_is.grade_job, steam = info_player_is.steam}
				ESX.ShowNotification(case..
					"<font size=4><p align=right><b>المشتبه به:  ".."<font color=orange>"..gender.."</font>"..
					"</br><font size=4><p align=right>".."<font color=orange>"..place.."</font>".."  :المكان شارع"..
					"<font size=5><p align=right><b>مستوى البلاغ: <font color=red> خطر</font></font>"..
					"<font size=4><p align=right><b>هوية الشخص:  ".."<font color=orange>"..info_player_is.name_player.."</font>"..
					"<font size=4><p align=right><b>ايدي الشخص:  ".."<font color=orange>"..info_player_is.playerid.."</font>"..
					"<font size=4><p align=right><b>رقم ستيمه:  ".."<font color=orange>"..info_player_is.iden_player.."</font>"..
					"<font size=4><p align=right><b>الوظيفة:  ".."<font color=orange>"..info_player_is.job .. " - " .. info_player_is.grade_job .."</font>"..
					"<font size=4><p align=right><b>ستيم:  ".."<font color=orange>"..info_player_is.steam.."</font>")
			else
				table.insert(list_shot_fire, coords_player)
				ESX.ShowNotification(case..
					"<font size=4><p align=right><b>المشتبه به:  ".."<font color=orange>"..gender.."</font>"..
					"</br><font size=4><p align=right>".."<font color=orange>"..place.."</font>".."  :المكان شارع"..
					"<font size=5><p align=right><b>مستوى البلاغ: <font color=red> خطر</font></font>")
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)

		if NetworkIsSessionStarted() then
			DecorRegister('isOutlaw', 3)
			DecorSetInt(PlayerPedId(), 'isOutlaw', 1)

			return
		end
	end
end)

-- Gets the player's current street.
-- Aaalso get the current player gender
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
		local playerCoords = GetEntityCoords(PlayerPedId())
		streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
		streetName = GetStreetNameFromHashKey(streetName)
	end
end)

AddEventHandler('skinchanger:loadSkin', function(character)
	playerGender = character.sex
end)

function refreshPlayerWhitelisted()
	if not ESX.PlayerData then
		return false
	end

	if not ESX.PlayerData.job then
		return false
	end

	for k,v in ipairs(Config.WhitelistedCops) do
		if v == ESX.PlayerData.job.name then
			return true
		end
	end

	return false
end

RegisterNetEvent('esx_outlawalert:carJackInProgress')
AddEventHandler('esx_outlawalert:carJackInProgress', function(targetCoords)
	if isPlayerWhitelisted then
		if Config.CarJackingAlert then
			local alpha = 250
			local thiefBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipJackingRadius)

			SetBlipHighDetail(thiefBlip, true)
			SetBlipColour(thiefBlip, 1)
			SetBlipAlpha(thiefBlip, alpha)
			SetBlipAsShortRange(thiefBlip, true)

			while alpha ~= 0 do
				Citizen.Wait(Config.BlipJackingTime * 4)
				alpha = alpha - 1
				SetBlipAlpha(thiefBlip, alpha)

				if alpha == 0 then
					RemoveBlip(thiefBlip)
					return
				end
			end

		end
	end
end)

RegisterNetEvent('esx_outlawalert:gunshotInProgress2')
AddEventHandler('esx_outlawalert:gunshotInProgress2', function(targetCoords)
	if isPlayerWhitelisted and Config.GunshotAlert then
		local alpha = 150
		local gunshotBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipGunRadius)

		SetBlipHighDetail(gunshotBlip, true)
		SetBlipColour(gunshotBlip, 1)
		SetBlipAlpha(gunshotBlip, alpha)
		SetBlipAsShortRange(gunshotBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.BlipGunTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(gunshotBlip, alpha)

			if alpha == 0 then
				RemoveBlip(gunshotBlip)
				return
			end
		end
	end
end)

RegisterNetEvent('esx_outlawalert:combatInProgress')
AddEventHandler('esx_outlawalert:combatInProgress', function(targetCoords)
	if isPlayerWhitelisted and Config.MeleeAlert then
		local alpha = 150
		local meleeBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipMeleeRadius)

		SetBlipHighDetail(meleeBlip, true)
		SetBlipColour(meleeBlip, 17)
		SetBlipAlpha(meleeBlip, alpha)
		SetBlipAsShortRange(meleeBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.BlipMeleeTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(meleeBlip, alpha)

			if alpha == 0 then
				RemoveBlip(meleeBlip)
				return
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)

		if DecorGetInt(PlayerPedId(), 'isOutlaw') == 2 then
			Citizen.Wait(timing)
			DecorSetInt(PlayerPedId(), 'isOutlaw', 1)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local player_id = GetPlayerServerId(PlayerId())
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)

		-- is jackin'
		if (IsPedTryingToEnterALockedVehicle(playerPed) or IsPedJacking(playerPed)) and Config.CarJackingAlert then

			Citizen.Wait(3000)
			local vehicle = GetVehiclePedIsIn(playerPed, true)

			if vehicle and ((isPlayerWhitelisted and Config.ShowCopsMisbehave) or not isPlayerWhitelisted) then
				local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

				ESX.TriggerServerCallback('esx_outlawalert:isVehicleOwner', function(owner)
					if not owner then

						local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
						vehicleLabel = GetLabelText(vehicleLabel)

						DecorSetInt(playerPed, 'isOutlaw', 2)

						TriggerServerEvent('esx_outlawalert:carJackInProgress', {
							x = ESX.Math.Round(playerCoords.x, 1),
							y = ESX.Math.Round(playerCoords.y, 1),
							z = ESX.Math.Round(playerCoords.z, 1)
						}, streetName, vehicleLabel, playerGender)
					end
				end, plate)
			end

		elseif IsPedInMeleeCombat(playerPed) and Config.MeleeAlert then

			Citizen.Wait(3000)

			if (isPlayerWhitelisted and Config.ShowCopsMisbehave) or not isPlayerWhitelisted then
				DecorSetInt(playerPed, 'isOutlaw', 2)

				TriggerServerEvent('esx_outlawalert:combatInProgress', {
					x = ESX.Math.Round(playerCoords.x, 1),
					y = ESX.Math.Round(playerCoords.y, 1),
					z = ESX.Math.Round(playerCoords.z, 1)
				}, streetName, playerGender)
			end

		elseif IsPedShooting(playerPed) and not IsPedCurrentWeaponSilenced(playerPed) and Config.GunshotAlert then
			ClearEntityLastDamageEntity(playerPed)
			Citizen.Wait(3000)

			if (isPlayerWhitelisted and Config.ShowCopsMisbehave) or not isPlayerWhitelisted then
				DecorSetInt(playerPed, 'isOutlaw', 2)

				TriggerServerEvent('esx_outlawalert:gunshotInProgress2', {
					x = ESX.Math.Round(playerCoords.x, 1),
					y = ESX.Math.Round(playerCoords.y, 1),
					z = ESX.Math.Round(playerCoords.z, 1)
				}, streetName, playerGender, player_id)
			end

		end
	end
end)
