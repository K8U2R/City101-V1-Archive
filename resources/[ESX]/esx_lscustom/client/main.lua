ESX = nil
local Vehicles = {}
local lsMenuIsShowed = false
local isInLSMarker = false
local myCar = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true

	
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx_lscustom:installMod')
AddEventHandler('esx_lscustom:installMod', function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	myCar = ESX.Game.GetVehicleProperties(vehicle)
	TriggerServerEvent('esx_K0lscusDDDtom:refreshOwnedVehicle', myCar)
end)

RegisterNetEvent('esx_lscustom:cancelInstallMod')
AddEventHandler('esx_lscustom:cancelInstallMod', function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	if (GetPedInVehicleSeat(vehicle, -1) ~= PlayerPedId()) then
		 vehicle = GetPlayersLastVehicle(PlayerPedId())
	end
		ESX.Game.SetVehicleProperties(vehicle, myCar)
	if not (myCar.modTurbo) then
		ToggleVehicleMod(vehicle,  18, false)
	end
	if not (myCar.modXenon) then
		ToggleVehicleMod(vehicle,  22, false)
	end
	if not (myCar.windowTint) then
		SetVehicleWindowTint(vehicle, 0)
	end
end)

RegisterNetEvent('esx_lscustom:sendbill')
AddEventHandler('esx_lscustom:sendbill', function(xPlayerOwner, price, label)
	--TriggerServerEvent('esx_billing:sendBill', xPlayerOwner.source, '', label, price)
end)

local Cooldown_count = 0
	
	local function Cooldown(sec)
		CreateThread(function()
			Cooldown_count = sec
			while Cooldown_count ~= 0 do
				Cooldown_count = Cooldown_count - 1
				Wait(1000)
			end	
			Cooldown_count = 0
		end)	
	end

function buyMod(price, modName, xp, mechanicprofit)
	local playerPed = PlayerPedId()
	local vehicle   = GetVehiclePedIsIn(playerPed)
	local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
	local to_5znh_mechanic = price - mechanicprofit
	TriggerServerEvent('esx_society:depositMoney', "mechanic", to_5znh_mechanic)
	
	if modName == 'null' or modName == nil then
		label = 'قطع غيار عامة <font color=00EE4F>$</font>'..price
	end
	
	ESX.TriggerServerCallback('esx_lscustom:getVehicleInfos', function(retrivedInfo)
		local ownerIdentifier = nil
		
		if retrivedInfo ~= nil then
			ownerIdentifier = retrivedInfo.identifier
		end
		TriggerServerEvent("esx_K0lscusDDDtom:buyMod", price, ownerIdentifier, modName, vehicleData.plate, xp, mechanicprofit)
	end, vehicleData.plate)
end

function buyMod_Check(price, modName, xp, mechanicprofit)
	disableAllControlActions = true	
					Citizen.CreateThread(function()
				  while disableAllControlActions do
					  Citizen.Wait(0)
					  DisableAllControlActions(0) --disable all control (comment it if you want to detect how many time key pressed)
				  end
			  end)
	TriggerEvent('pogressBar:drawBar', 1000, 'جاري التعديل')
    Citizen.Wait(1000)	
	disableAllControlActions = false
			  
	buyMod(price, modName, xp, mechanicprofit)
end

function OpenLSMenu(elems, menuName, menuTitle, parent)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), menuName,
	{
		title    = menuTitle,
		align    = 'top-left',
		elements = elems
	}, function(data, menu)
		local isRimMod, found = false, false
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

		if data.current.modType == "modFrontWheels" then
			isRimMod = true
		end

		for k,v in pairs(Config.Menus) do

			if k == data.current.modType or isRimMod then

				if data.current.label == _U('by_default') or string.match(data.current.label, _U('installed')) then
					ESX.ShowNotification(_U('already_own', data.current.label))
					TriggerEvent('esx_lscustom:installMod')
				else
					
					local playerPed = PlayerPedId()
					local vehicle2   = GetVehiclePedIsIn(playerPed)
					local vehicleData = ESX.Game.GetVehicleProperties(vehicle2)
					local name_car = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle2))

					for i=1, #Config.VehiclesShop, 1 do
						if Config.VehiclesShop[i].model == name_car then
							vehiclePrice = Config.VehiclesShop[i].price
							break
						end
					end
					
			
					if isRimMod then
						price = math.floor(vehiclePrice * data.current.price / 100)
						xp = Config.Wheelsxp
						mechanicprofit = math.floor(vehiclePrice * data.current.price / 1000)
						--buyMod(price, data.current.label, xp, mechanicprofit)
						buyMod_Check(price, data.current.label, xp, mechanicprofit)
					elseif v.modType == 11 or v.modType == 12 or v.modType == 13 or v.modType == 15 or v.modType == 16 then
						price = math.floor(vehiclePrice * v.price[data.current.modNum + 1] / 100)
						xp = ((data.current.modNum + 1) * Config.Upgradesxp )
						mechanicprofit = math.floor(vehiclePrice * v.price[data.current.modNum + 1] / 1000)
						--buyMod(price, data.current.label , xp, mechanicprofit)
						buyMod_Check(price, data.current.label , xp, mechanicprofit)
					elseif v.modType == 17 then
						price = math.floor(vehiclePrice * v.price[1] / 100)
						xp = Config.Turboxp
						mechanicprofit = math.floor(vehiclePrice * v.price[1] / 1000)
						--buyMod(price, data.current.label, xp, mechanicprofit)
						buyMod_Check(price, data.current.label, xp, mechanicprofit)
					else
						price = math.floor(vehiclePrice * v.price / 100)
						xp = Config.Otherxp
						mechanicprofit = math.floor(vehiclePrice * v.price / 1000)
						--buyMod(price, data.current.label, xp, mechanicprofit)
						buyMod_Check(price, data.current.label, xp, mechanicprofit)
					end
				end

				menu.close()
				found = true
				break
			end

		end

		if not found then
			GetAction(data.current)
		end
	end, function(data, menu) -- on cancel
		menu.close()
		TriggerEvent('esx_lscustom:cancelInstallMod')

		local playerPed = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		SetVehicleDoorsShut(vehicle, false)

		if parent == nil then
			lsMenuIsShowed = false
			local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			FreezeEntityPosition(vehicle, false)
			myCar = {}
		end
	end, function(data, menu) -- on change
		UpdateMods(data.current)
	end)
end

function UpdateMods(data)
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

	if data.modType then
		local props = {}
		
		if data.wheelType then
			props['wheels'] = data.wheelType
			ESX.Game.SetVehicleProperties(vehicle, props)
			props = {}
		elseif data.modType == 'neonColor' then
			if data.modNum[1] == 0 and data.modNum[2] == 0 and data.modNum[3] == 0 then
				props['neonEnabled'] = { false, false, false, false }
			else
				props['neonEnabled'] = { true, true, true, true }
			end
			ESX.Game.SetVehicleProperties(vehicle, props)
			props = {}
		elseif data.modType == 'tyreSmokeColor' then
			props['modSmokeEnabled'] = true
			ESX.Game.SetVehicleProperties(vehicle, props)
			props = {}
		end

		props[data.modType] = data.modNum
		ESX.Game.SetVehicleProperties(vehicle, props)
	end
end

function GetAction(data)
	local elements  = {}
	local menuName  = ''
	local menuTitle = ''
	local parent    = nil

	local playerPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	local currentMods = ESX.Game.GetVehicleProperties(vehicle)

	if data.value == 'modSpeakers' or
		data.value == 'modTrunk' or
		data.value == 'modHydrolic' or
		data.value == 'modEngineBlock' or
		data.value == 'modAirFilter' or
		data.value == 'modStruts' or
		data.value == 'modTank' then
		SetVehicleDoorOpen(vehicle, 4, false)
		SetVehicleDoorOpen(vehicle, 5, false)
	elseif data.value == 'modDoorSpeaker' then
		SetVehicleDoorOpen(vehicle, 0, false)
		SetVehicleDoorOpen(vehicle, 1, false)
		SetVehicleDoorOpen(vehicle, 2, false)
		SetVehicleDoorOpen(vehicle, 3, false)
	else
		SetVehicleDoorsShut(vehicle, false)
	end

	
	local playerPed = PlayerPedId()
	local vehicle2   = GetVehiclePedIsIn(playerPed)
	local vehicleData = ESX.Game.GetVehicleProperties(vehicle2)
	
	local name_car = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle2)))
	local successf = false
	for i=1, #Config.VehiclesShop, 1 do
		if Config.VehiclesShop[i].model == name_car then
			successf = true
			vehiclePrice = Config.VehiclesShop[i].price
			break
		end
	end
	if not successf then
		vehiclePrice = 200000
	end

	for k,v in pairs(Config.Menus) do

		if data.value == k then

			menuName  = k
			menuTitle = v.label
			parent    = v.parent

			if v.modType then
				
				if v.modType == 22 then
					table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = false})
				elseif v.modType == 'neonColor' or v.modType == 'tyreSmokeColor' then -- disable neon
					table.insert(elements, {label = " " ..  _U('by_default'), modType = k, modNum = {0, 0, 0}})
				elseif v.modType == 'color1' or v.modType == 'color2' or v.modType == 'pearlescentColor' or v.modType == 'wheelColor' then
					local num = myCar[v.modType]
					table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = num})
				elseif v.modType == 17 then
					table.insert(elements, {label = " " .. _U('no_turbo'), modType = k, modNum = false})
 				else
					table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = -1})
				end

				if v.modType == 14 then -- HORNS
					for j = 0, 51, 1 do
						local _label = ''
						if j == currentMods.modHorns then
							_label = GetHornName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = math.floor(vehiclePrice * v.price / 100)
							_label = GetHornName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j})
					end
				elseif v.modType == 'plateIndex' then -- PLATES
					for j = 0, 4, 1 do
						local _label = ''
						if j == currentMods.plateIndex then
							_label = GetPlatesName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = math.floor(vehiclePrice * v.price / 100)
							_label = GetPlatesName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j})
					end
				elseif v.modType == 22 then -- NEON
					local _label = ''
					if currentMods.modXenon then
						_label = _U('neon') .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
					else
						price = math.floor(vehiclePrice * v.price / 100)
						_label = _U('neon') .. ' - <span style="color:green;">$' .. price .. ' </span>'
					end
					table.insert(elements, {label = _label, modType = k, modNum = true})
				elseif v.modType == 'neonColor' or v.modType == 'tyreSmokeColor' then -- NEON & SMOKE COLOR
					local neons = GetNeons()
					price = math.floor(vehiclePrice * v.price / 100)
					for i=1, #neons, 1 do
						table.insert(elements, {
							label = '<span style="color:rgb(' .. neons[i].r .. ',' .. neons[i].g .. ',' .. neons[i].b .. ');">' .. neons[i].label .. ' - <span style="color:green;">$' .. price .. '</span>',
							modType = k,
							modNum = { neons[i].r, neons[i].g, neons[i].b }
						})
					end
				elseif v.modType == 'color1' or v.modType == 'color2' or v.modType == 'pearlescentColor' or v.modType == 'wheelColor' then -- RESPRAYS
					local colors = GetColors(data.color)
					for j = 1, #colors, 1 do
						local _label = ''
						price = math.floor(vehiclePrice * v.price / 100)
						_label = colors[j].label .. ' - <span style="color:green;">$' .. price .. ' </span>'
						table.insert(elements, {label = _label, modType = k, modNum = colors[j].index})
					end
				elseif v.modType == 'windowTint' then -- WINDOWS TINT
					for j = 1, 5, 1 do
						local _label = ''
						if j == currentMods.modHorns then
							_label = GetWindowName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = math.floor(vehiclePrice * v.price / 100)
							_label = GetWindowName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j})
					end
				elseif v.modType == 23 then -- WHEELS RIM & TYPE
					local props = {}

					props['wheels'] = v.wheelType
					ESX.Game.SetVehicleProperties(vehicle, props)

					local modCount = GetNumVehicleMods(vehicle, v.modType)
					for j = 0, modCount, 1 do
						local modName = GetModTextLabel(vehicle, v.modType, j)
						if modName then
							local _label = ''
							if j == currentMods.modFrontWheels then
								_label = GetLabelText(modName) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
							else
								price = math.floor(vehiclePrice * v.price / 100)
								_label = GetLabelText(modName) .. ' - <span style="color:green;">$' .. price .. ' </span>'
							end
							table.insert(elements, {label = _label, modType = 'modFrontWheels', modNum = j, wheelType = v.wheelType, price = v.price})
						end
					end
				elseif v.modType == 11 or v.modType == 12 or v.modType == 13 or v.modType == 15 or v.modType == 16 then
					SetVehicleModKit(vehicle, 0)
					local modCount = GetNumVehicleMods(vehicle, v.modType) -- UPGRADES
					for j = 0, modCount, 1 do
						local _label = ''
						if j == currentMods[k] then
							_label = _U('level', j+1) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = math.floor(vehiclePrice * v.price[j+1] / 100)
							_label = _U('level', j+1) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j})
						if j == modCount-1 then
							break
						end
					end
				elseif v.modType == 17 then -- TURBO
					local _label = ''
					if currentMods[k] then
						_label = 'Turbo - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
					else
						_label = 'Turbo - <span style="color:green;">$' .. math.floor(vehiclePrice * v.price[1] / 100) .. ' </span>'
					end
					table.insert(elements, {label = _label, modType = k, modNum = true})
				else
					local modCount = GetNumVehicleMods(vehicle, v.modType) -- BODYPARTS
					for j = 0, modCount, 1 do
						local modName = GetModTextLabel(vehicle, v.modType, j)
						if modName then
							local _label = ''
							if j == currentMods[k] then
								_label = GetLabelText(modName) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
							else
								price = math.floor(vehiclePrice * v.price / 100)
								_label = GetLabelText(modName) .. ' - <span style="color:green;">$' .. price .. ' </span>'
							end
							table.insert(elements, {label = _label, modType = k, modNum = j})
						end
					end
				end
			else
				if data.value == 'primaryRespray' or data.value == 'secondaryRespray' or data.value == 'pearlescentRespray' or data.value == 'modFrontWheelsColor' then
					for i=1, #Config.Colors, 1 do
						if data.value == 'primaryRespray' then
							table.insert(elements, {label = Config.Colors[i].label, value = 'color1', color = Config.Colors[i].value})
						elseif data.value == 'secondaryRespray' then
							table.insert(elements, {label = Config.Colors[i].label, value = 'color2', color = Config.Colors[i].value})
						elseif data.value == 'pearlescentRespray' then
							table.insert(elements, {label = Config.Colors[i].label, value = 'pearlescentColor', color = Config.Colors[i].value})
						elseif data.value == 'modFrontWheelsColor' then
							table.insert(elements, {label = Config.Colors[i].label, value = 'wheelColor', color = Config.Colors[i].value})
						end
					end
				else
					for l,w in pairs(v) do
						if l ~= 'label' and l ~= 'parent' then
							table.insert(elements, {label = w, value = l})
						end
					end
				end
			end
			break
		end
	end

	table.sort(elements, function(a, b)
		return a.label < b.label
	end)

	OpenLSMenu(elements, menuName, menuTitle, parent)
end


-- Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.ls9.Pos.x, Config.Zones.ls9.Pos.y, Config.Zones.ls9.Pos.z)

		SetBlipSprite(blip, 72)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('blip_name'))
		EndTextCommandSetBlipName(blip)
end)
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.ls10.Pos.x, Config.Zones.ls10.Pos.y, Config.Zones.ls10.Pos.z)

		SetBlipSprite(blip, 72)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('blip_name'))
		EndTextCommandSetBlipName(blip)
end)
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.ls11.Pos.x, Config.Zones.ls11.Pos.y, Config.Zones.ls11.Pos.z)

		SetBlipSprite(blip, 72)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('blip_name'))
		EndTextCommandSetBlipName(blip)
end)
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.ls12.Pos.x, Config.Zones.ls12.Pos.y, Config.Zones.ls12.Pos.z)

		SetBlipSprite(blip, 72)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('blip_name'))
		EndTextCommandSetBlipName(blip)
end)
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.ls13.Pos.x, Config.Zones.ls13.Pos.y, Config.Zones.ls13.Pos.z)

	SetBlipSprite(blip, 72)
	SetBlipScale(blip, 0.8)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('blip_name'))
	EndTextCommandSetBlipName(blip)
end)
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.ls14.Pos.x, Config.Zones.ls14.Pos.y, Config.Zones.ls14.Pos.z)

	SetBlipSprite(blip, 72)
	SetBlipScale(blip, 0.8)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('blip_name'))
	EndTextCommandSetBlipName(blip)
end)
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.ls15.Pos.x, Config.Zones.ls15.Pos.y, Config.Zones.ls15.Pos.z)

	SetBlipSprite(blip, 72)
	SetBlipScale(blip, 0.8)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('blip_name'))
	EndTextCommandSetBlipName(blip)
end)
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.ls16.Pos.x, Config.Zones.ls16.Pos.y, Config.Zones.ls16.Pos.z)

	SetBlipSprite(blip, 72)
	SetBlipScale(blip, 0.8)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('blip_name'))
	EndTextCommandSetBlipName(blip)
end)
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.ls17.Pos.x, Config.Zones.ls17.Pos.y, Config.Zones.ls17.Pos.z)

	SetBlipSprite(blip, 72)
	SetBlipScale(blip, 0.8)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('blip_name'))
	EndTextCommandSetBlipName(blip)
end)
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.ls18.Pos.x, Config.Zones.ls18.Pos.y, Config.Zones.ls18.Pos.z)

	SetBlipSprite(blip, 72)
	SetBlipScale(blip, 0.8)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('blip_name'))
	EndTextCommandSetBlipName(blip)
end)
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.ls19.Pos.x, Config.Zones.ls19.Pos.y, Config.Zones.ls19.Pos.z)

	SetBlipSprite(blip, 72)
	SetBlipScale(blip, 0.8)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('blip_name'))
	EndTextCommandSetBlipName(blip)
end)
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.ls20.Pos.x, Config.Zones.ls20.Pos.y, Config.Zones.ls20.Pos.z)

	SetBlipSprite(blip, 72)
	SetBlipScale(blip, 0.8)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('blip_name'))
	EndTextCommandSetBlipName(blip)
end)
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.ls21.Pos.x, Config.Zones.ls21.Pos.y, Config.Zones.ls21.Pos.z)

	SetBlipSprite(blip, 72)
	SetBlipScale(blip, 0.8)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('blip_name'))
	EndTextCommandSetBlipName(blip)
end)
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.ls22.Pos.x, Config.Zones.ls22.Pos.y, Config.Zones.ls22.Pos.z)

	SetBlipSprite(blip, 72)
	SetBlipScale(blip, 0.8)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('blip_name'))
	EndTextCommandSetBlipName(blip)
end)
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.ls23.Pos.x, Config.Zones.ls23.Pos.y, Config.Zones.ls23.Pos.z)

	SetBlipSprite(blip, 72)
	SetBlipScale(blip, 0.8)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('blip_name'))
	EndTextCommandSetBlipName(blip)
end)
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.ls24.Pos.x, Config.Zones.ls24.Pos.y, Config.Zones.ls24.Pos.z)

	SetBlipSprite(blip, 72)
	SetBlipScale(blip, 0.8)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('blip_name'))
	EndTextCommandSetBlipName(blip)
end)
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.ls25.Pos.x, Config.Zones.ls25.Pos.y, Config.Zones.ls25.Pos.z)

	SetBlipSprite(blip, 72)
	SetBlipScale(blip, 0.8)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('blip_name'))
	EndTextCommandSetBlipName(blip)
end)
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.ls26.Pos.x, Config.Zones.ls26.Pos.y, Config.Zones.ls26.Pos.z)

	SetBlipSprite(blip, 72)
	SetBlipScale(blip, 0.8)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('blip_name'))
	EndTextCommandSetBlipName(blip)
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed, false) then
			local coords = GetEntityCoords(PlayerPedId())
			local currentZone, zone, lastZone

			if (ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic'or ESX.PlayerData.job.name == 'mec') or not Config.IsMechanicJobOnly then
				for k,v in pairs(Config.Zones) do
					if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x and not lsMenuIsShowed then
						isInLSMarker  = true
						ESX.ShowHelpNotification(v.Hint)
						break
					else
						isInLSMarker  = false
					end
				end
			end

			if IsControlJustReleased(0, 38) and not lsMenuIsShowed and isInLSMarker then
				if (ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' or ESX.PlayerData.job.name == 'mec') or not Config.IsMechanicJobOnly then
					lsMenuIsShowed = true

					local vehicle = GetVehiclePedIsIn(playerPed, false)
					FreezeEntityPosition(vehicle, true)

					myCar = ESX.Game.GetVehicleProperties(vehicle)

					ESX.UI.Menu.CloseAll()
					GetAction({value = 'main'})
				end
			end

			if isInLSMarker and not hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = true
			end

			if not isInLSMarker and hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = false
			end

		end
	end
end)

-- Prevent Free Tunning Bug
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if lsMenuIsShowed then
			DisableControlAction(2, 288, true)
			DisableControlAction(2, 289, true)
			DisableControlAction(2, 170, true)
			DisableControlAction(2, 167, true)
			DisableControlAction(2, 168, true)
			DisableControlAction(2, 23, true)
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		else
			Citizen.Wait(500)
		end
	end
end)
