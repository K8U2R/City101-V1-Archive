local CurrentActionData, Licenses = {}, {}
local HasAlreadyEnteredMarker, IsInMainMenu = false, false
local LastZone, CurrentAction, CurrentActionMsg

Citizen.CreateThread(function()
	while ESX == nil do
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	TriggerServerEvent('esx_licenseshop:ServerLoadLicenses')
end)

RegisterNetEvent('esx_licenseshop:loadLicenses')
AddEventHandler('esx_licenseshop:loadLicenses', function(licenses)
	Licenses = licenses
end)

-- xplevel function
function checkRequiredXPlevel(required)
	local xp = exports.esx_misc4:Exp_XNL_GetCurrentPlayerXP(PlayerId())
	local level = exports.esx_misc4:Exp_XNL_GetLevelFromXP(xp)
	
	if level >= required then
		return true
	else
		return false
	end
end

-- Open License Shop
function OpenLicenseShop()
	IsInMainMenu = true
	local ownedLicenses = {}

	for i=1, #Licenses, 1 do
		ownedLicenses[Licenses[i].type] = true
	end

	local elements = {}

	if Config.AdvancedVehicleShop then
		if not ownedLicenses['drive_aircraft'] then
			table.insert(elements, {label = ('%s - <span style="color: green;">%s</span>'):format(_U('license_aircraft'), _U('shop_menu_item', ESX.Math.GroupDigits(Config.Prices_esx_licenseshop.Aircraft))), value = 'buy_license_aircraft'})
		end

		if not ownedLicenses['drive_boat'] then
			table.insert(elements, {label = ('%s - <span style="color: green;">%s</span>'):format(_U('license_boating'), _U('shop_menu_item', ESX.Math.GroupDigits(Config.Prices_esx_licenseshop.Boating))), value = 'buy_license_boating'})
		end
	end

	if Config.AdvancedWeaponShop then
		if not ownedLicenses['weapon_melee'] and checkRequiredXPlevel(Config.Level_esx_licenseshop.melee) then
			table.insert(elements, {label = ('%s - <span style="color: green;">%s</span>'):format(_U('license_melee'), _U('shop_menu_item', ESX.Math.GroupDigits(Config.Prices_esx_licenseshop.Melee))), value = 'buy_license_melee'})
		elseif not ownedLicenses['weapon_melee'] and not checkRequiredXPlevel(Config.Level_esx_licenseshop.melee) then
            table.insert(elements, {label = ('%s - <font color=gray> مستوى <font color=gray> [<font color=orange>'..Config.Level_esx_licenseshop.melee..'<font color=gray>] <font color=white>'):format(_U('license_melee')), value = nil})
		end

		if not ownedLicenses['weapon_handgun'] and checkRequiredXPlevel(Config.Level_esx_licenseshop.handgun) then
			table.insert(elements, {label = ('%s - <span style="color: green;">%s</span>'):format(_U('license_handgun'), _U('shop_menu_item', ESX.Math.GroupDigits(Config.Prices_esx_licenseshop.Handgun))), value = 'buy_license_handgun'})
		elseif not ownedLicenses['weapon_handgun'] and not checkRequiredXPlevel(Config.Level_esx_licenseshop.handgun) then
            table.insert(elements, {label = ('%s - <font color=gray> مستوى <font color=gray> [<font color=orange>'..Config.Level_esx_licenseshop.handgun..'<font color=gray>] <font color=white>'):format(_U('license_handgun')), value = nil})
		end

		if not ownedLicenses['weapon_smg'] and checkRequiredXPlevel(Config.Level_esx_licenseshop.smg) then
			table.insert(elements, {label = ('%s - <span style="color: green;">%s</span>'):format(_U('license_smg'), _U('shop_menu_item', ESX.Math.GroupDigits(Config.Prices_esx_licenseshop.SMG))), value = 'buy_license_smg'})
		elseif not ownedLicenses['weapon_smg'] and not checkRequiredXPlevel(Config.Level_esx_licenseshop.smg) then
            table.insert(elements, {label = ('%s - <font color=gray> مستوى <font color=gray> [<font color=orange>'..Config.Level_esx_licenseshop.smg..'<font color=gray>] <font color=white>'):format(_U('license_smg')), value = nil})
		end

		if not ownedLicenses['weapon_shotgun'] and checkRequiredXPlevel(Config.Level_esx_licenseshop.shotgun) then
			table.insert(elements, {label = ('%s - <span style="color: green;">%s</span>'):format(_U('license_shotgun'), _U('shop_menu_item', ESX.Math.GroupDigits(Config.Prices_esx_licenseshop.Shotgun))), value = 'buy_license_shotgun'})
		elseif not ownedLicenses['weapon_shotgun'] and not checkRequiredXPlevel(Config.Level_esx_licenseshop.shotgun) then
            table.insert(elements, {label = ('%s - <font color=gray> مستوى <font color=gray> [<font color=orange>'..Config.Level_esx_licenseshop.shotgun..'<font color=gray>] <font color=white>'):format(_U('license_shotgun')), value = nil})
		end

		--[[if not ownedLicenses['weapon_assault'] and checkRequiredXPlevel(Config.Level_esx_licenseshop.assault) then
			table.insert(elements, {label = ('%s - <span style="color: green;">%s</span>'):format(_U('license_assault'), _U('shop_menu_item', ESX.Math.GroupDigits(Config.Prices_esx_licenseshop.Assault))), value = 'buy_license_assault'})
		elseif not ownedLicenses['weapon_assault'] and not checkRequiredXPlevel(Config.Level_esx_licenseshop.assault) then
            table.insert(elements, {label = ('%s - <font color=gray> مستوى <font color=gray> [<font color=orange>'..Config.Level_esx_licenseshop.assault..'<font color=gray>] <font color=white>'):format(_U('license_assault')), value = nil})
		end

		if not ownedLicenses['weapon_lmg'] then
			table.insert(elements, {label = ('%s - <span style="color: green;">%s</span>'):format(_U('license_lmg'), _U('shop_menu_item', ESX.Math.GroupDigits(Config.Prices_esx_licenseshop.LMG))), value = 'buy_license_lmg'})
		end

		if not ownedLicenses['weapon_sniper'] then
			table.insert(elements, {label = ('%s - <span style="color: green;">%s</span>'):format(_U('license_sniper'), _U('shop_menu_item', ESX.Math.GroupDigits(Config.Prices_esx_licenseshop.Sniper))), value = 'buy_license_sniper'})
		end]]
	end

	if Config.DMVSchool then
		if Config.SellDMV then
			if not ownedLicenses['dmv'] then
				table.insert(elements, {label = ('%s - <span style="color: green;">%s</span>'):format(_U('license_driversp'), _U('shop_menu_item', ESX.Math.GroupDigits(Config.Prices_esx_licenseshop.DriversP))), value = 'buy_license_driversp'})
			end
		end

		if not ownedLicenses['drive_truck'] then
			table.insert(elements, {label = ('%s - <span style="color: green;">%s</span>'):format(_U('license_commercial'), _U('shop_menu_item', ESX.Math.GroupDigits(Config.Prices_esx_licenseshop.Commercial))), value = 'buy_license_commercial'})
		end

		if not ownedLicenses['drive'] then
			table.insert(elements, {label = ('%s - <span style="color: green;">%s</span>'):format(_U('license_drivers'), _U('shop_menu_item', ESX.Math.GroupDigits(Config.Prices_esx_licenseshop.Drivers))), value = 'buy_license_drivers'})
		end

		if not ownedLicenses['drive_bike'] then
			table.insert(elements, {label = ('%s - <span style="color: green;">%s</span>'):format(_U('license_motorcycle'), _U('shop_menu_item', ESX.Math.GroupDigits(Config.Prices_esx_licenseshop.Motorcycle))), value = 'buy_license_motorcycle'})
		end
	end

	if Config.Drugs then
		if not ownedLicenses['weed_processing'] then
			table.insert(elements, {label = ('%s - <span style="color: green;">%s</span>'):format(_U('license_weed'), _U('shop_menu_item', ESX.Math.GroupDigits(Config.Prices_esx_licenseshop.Weed))), value = 'buy_license_weed'})
		end
	end

	if Config.WeaponShop then
		if not ownedLicenses['weapon'] then
			table.insert(elements, {label = ('%s - <span style="color: green;">%s</span>'):format(_U('license_weapon'), _U('shop_menu_item', ESX.Math.GroupDigits(Config.Prices_esx_licenseshop.Weapon))), value = 'buy_license_weapon'})
		end
	end

	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'license_shop_actions', {
		title = _U('buy_license'),
		align = GetConvar('esx_MenuAlign', 'top-left'),
		elements = elements
	}, function(data, menu)
		if data.current.value == 'buy_license_aircraft' then
			TriggerServerEvent('esx_licenseshop:buyLicenseAircraft')
			IsInMainMenu = false
			menu.close()
		elseif data.current.value == 'buy_license_boating' then
			TriggerServerEvent('esx_licenseshop:buyLicenseBoating')
			IsInMainMenu = false
			menu.close()
		elseif data.current.value == 'buy_license_melee' then
			TriggerServerEvent('esx_licenseshop:buyLicenseMelee')
			IsInMainMenu = false
			menu.close()
		elseif data.current.value == 'buy_license_handgun' then
			TriggerServerEvent('esx_licenseshop:buyLicenseHandgun')
			IsInMainMenu = false
			menu.close()
		elseif data.current.value == 'buy_license_smg' then
			TriggerServerEvent('esx_licenseshop:buyLicenseSMG')
			IsInMainMenu = false
			menu.close()
		elseif data.current.value == 'buy_license_shotgun' then
			TriggerServerEvent('esx_licenseshop:buyLicenseShotgun')
			IsInMainMenu = false
			menu.close()
		elseif data.current.value == 'buy_license_assault' then
			TriggerServerEvent('esx_licenseshop:buyLicenseAssault')
			IsInMainMenu = false
			menu.close()
		elseif data.current.value == 'buy_license_lmg' then
			TriggerServerEvent('esx_licenseshop:buyLicenseLMG')
			IsInMainMenu = false
			menu.close()
		elseif data.current.value == 'buy_license_sniper' then
			TriggerServerEvent('esx_licenseshop:buyLicenseSniper')
			IsInMainMenu = false
			menu.close()
		elseif data.current.value == 'buy_license_commercial' then
			TriggerServerEvent('esx_licenseshop:buyLicenseCommercial')
			IsInMainMenu = false
			menu.close()
		elseif data.current.value == 'buy_license_drivers' then
			TriggerServerEvent('esx_licenseshop:buyLicenseDrivers')
			IsInMainMenu = false
			menu.close()
		elseif data.current.value == 'buy_license_driversp' then
			TriggerServerEvent('esx_licenseshop:buyLicenseDriversP')
			IsInMainMenu = false
			menu.close()
		elseif data.current.value == 'buy_license_motorcycle' then
			TriggerServerEvent('esx_licenseshop:buyLicenseMotorcyle')
			IsInMainMenu = false
			menu.close()
		elseif data.current.value == 'buy_license_weed' then
			TriggerServerEvent('esx_licenseshop:buyLicenseWeed')
			IsInMainMenu = false
			menu.close()
		elseif data.current.value == 'buy_license_weapon' then
			TriggerServerEvent('esx_licenseshop:buyLicenseWeapon')
			IsInMainMenu = false
			menu.close()
		end
	end, function(data, menu)
		IsInMainMenu = false
		menu.close()

		CurrentAction = 'license_menu'
		CurrentActionMsg = _U('press_access')
		CurrentActionData = {}
	end)
end

-- Entered Marker
AddEventHandler('esx_licenseshop:hasEnteredMarker', function(zone)
	CurrentAction = 'license_menu'
	CurrentActionMsg = _U('press_access')
	CurrentActionData = {}
end)

-- Exited Marker
AddEventHandler('esx_licenseshop:hasExitedMarker', function(zone)
	if not IsInMainMenu or IsInMainMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

-- Resource Stop
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if IsInMainMenu then
			ESX.UI.Menu.CloseAll()
		end
	end
end)

-- Blips
Citizen.CreateThread(function(); while not ConfigReady do; Citizen.Wait(1000); end
	if Config.UseBlips then
		for k,v in pairs(Config.Zones_esx_licenseshop) do
			for i=1, #v.Coords, 1 do
				local blip = AddBlipForCoord(v.Coords[i])

				SetBlipSprite (blip, Config.BlipLicenseShop_esx_licenseshop.Sprite)
				SetBlipColour (blip, Config.BlipLicenseShop_esx_licenseshop.Color)
				SetBlipDisplay(blip, Config.BlipLicenseShop_esx_licenseshop.Display)
				SetBlipScale  (blip, Config.BlipLicenseShop_esx_licenseshop.Scale)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName('STRING')
				AddTextComponentSubstringPlayerName('<font face="A9eelsh">ﺺﺧﺮﻟﺍ ﺮﺠﺘﻣ')
				EndTextCommandSetBlipName(blip)
			end
		end
	end
end)

-- Enter / Exit marker events & Draw Markers
Citizen.CreateThread(function(); while not ConfigReady do; Citizen.Wait(1000); end
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local isInMarker, letSleep, currentZone = false, true

		for k,v in pairs(Config.Zones_esx_licenseshop) do
			for i=1, #v.Coords, 1 do
				local distance = #(playerCoords - v.Coords[i])

				if distance < Config.DrawDistance then
					letSleep = false

					if Config.MarkerInfo_esx_licenseshop.Type ~= -1 then
						DrawMarker(Config.MarkerInfo_esx_licenseshop.Type, v.Coords[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerInfo_esx_licenseshop.x, Config.MarkerInfo_esx_licenseshop.y, Config.MarkerInfo_esx_licenseshop.z, Config.MarkerInfo_esx_licenseshop.r, Config.MarkerInfo_esx_licenseshop.g, Config.MarkerInfo_esx_licenseshop.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance < Config.MarkerInfo_esx_licenseshop.x then
						isInMarker, currentZone = true, k
					end
				end
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker, LastZone = true, currentZone
			TriggerEvent('esx_licenseshop:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_licenseshop:hasExitedMarker', LastZone)
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function(); while not ConfigReady do; Citizen.Wait(1000); end
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'license_menu' then
					TriggerServerEvent('esx_licenseshop:ServerLoadLicenses')
					if Config.RequireDMV then
						local ownedLicenses = {}
						for i=1, #Licenses, 1 do
							ownedLicenses[Licenses[i].type] = true
						end
						
						if not ownedLicenses['dmv'] then
							ESX.ShowNotification(_U('need_dmv'))
						else
							OpenLicenseShop()
						end
					else
						OpenLicenseShop()
					end
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)
