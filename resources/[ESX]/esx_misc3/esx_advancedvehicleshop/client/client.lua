local CurrentActionData, JobBlips = {}, {}
local HasAlreadyEnteredMarker, IsInMainMenu, YesAlready = false, false, false
local LastZone, CurrentAction, CurrentActionMsg, currentDisplayVehicle, CurrentVehicleData
function getVehiclePrice()
	return Config.VehiclesShop
end

ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('esx_misc3:vehicleshop:deletevehicle')
AddEventHandler('esx_misc3:vehicleshop:deletevehicle', function()

	if IsInMainMenu then
		ESX.UI.Menu.CloseAll()

		local playerPed = PlayerPedId()
		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)
	end

	DeleteDisplayVehicleInsideShop()

	IsInMainMenu, YesAlready = false, false
end)

function DeleteDisplayVehicleInsideShop()
	local attempt = 0

	if currentDisplayVehicle and DoesEntityExist(currentDisplayVehicle) then
		while DoesEntityExist(currentDisplayVehicle) and not NetworkHasControlOfEntity(currentDisplayVehicle) and attempt < 100 do
			Citizen.Wait(100)
			NetworkRequestControlOfEntity(currentDisplayVehicle)
			attempt = attempt + 1
		end

		if DoesEntityExist(currentDisplayVehicle) and NetworkHasControlOfEntity(currentDisplayVehicle) then
			ESX.Game.DeleteVehicle(currentDisplayVehicle)
		end
	end
end

function StartShopRestriction()
	Citizen.CreateThread(function()
		while IsInMainMenu do
			Citizen.Wait(0)

			DisableControlAction(0, 75, true) -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		end
	end)
end

-- Buy Car Menu
function BuyCarMenu2(typee, tiiittllee, carjobb, typeindata, locationsss)

	if Config.VehiclesShop[typee] == nil or #Config.VehiclesShop[typee].Categories == 0 or #Config.VehiclesShop[typee].Vehicles == 0 then
		ESX.ShowNotification('<font color=red>لاتوجد مركبات في المعرض</font>')
		return
	end

	IsInMainMenu = true

	StartShopRestriction()
	ESX.UI.Menu.CloseAll()

	local playerPed = PlayerPedId()

	--FreezeEntityPosition(playerPed, true)
	--SetEntityVisible(playerPed, false)
	SetEntityCoords(playerPed,  Config.Zones_esx_advancedvehicleshop[locationsss.inside].Pos)

	local vehiclesByCategory = {}
	local elements = {}
	local firstVehicleData = nil

	for i=1, #Config.VehiclesShop[typee].Categories, 1 do
		vehiclesByCategory[Config.VehiclesShop[typee].Categories[i].name] = {}
	end

	for i=1, #Config.VehiclesShop[typee].Vehicles, 1 do
		if IsModelInCdimage(GetHashKey(Config.VehiclesShop[typee].Vehicles[i].model)) then
			if carjobb == "police" or carjobb == "ambulance" or carjobb == "agent" then
				for k,v in pairs(Config.VehiclesShop[typee].Vehicles[i].grade) do
					if ESXDATA.job.grade_name == v then
						table.insert(vehiclesByCategory[Config.VehiclesShop[typee].Vehicles[i].category], Config.VehiclesShop[typee].Vehicles[i])
					end
				end
			else
				table.insert(vehiclesByCategory[Config.VehiclesShop[typee].Vehicles[i].category], Config.VehiclesShop[typee].Vehicles[i])
			end
		else
			--print(('[esx_advancedvehicleshop] [^3ERROR^7] Vehicle "%s" does not exist'):format(Config.VehiclesShop[typee].Vehicles[i].model))
		end
	end

	for k,v in pairs(vehiclesByCategory) do
		table.sort(v, function(a, b)
			return a.name < b.name
		end)
	end

	for i=1, #Config.VehiclesShop[typee].Categories, 1 do
		local category = Config.VehiclesShop[typee].Categories[i]
		local categoryVehicles = vehiclesByCategory[category.name]
		local options = {}

		for j=1, #categoryVehicles, 1 do
			local vehicle = categoryVehicles[j]

			if i == 1 and j == 1 then
				firstVehicleData = vehicle
			end
			table.insert(options, '<font color=gray> الإسم : <font color=white>'..vehicle.name..' </font> | المستوى : <font color=orange> '.. vehicle.level..' </font></font>')
		end

		table.sort(options)

		table.insert(elements, {
			name = category.name,
			label = category.label,
			value = 0,
			type = 'slider',
			max = #Config.VehiclesShop[typee].Categories[i],
			options = options
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'car_buy', {
		title = tiiittllee,
		align = GetConvar('esx_MenuAlign', 'top-left'),
		elements = elements
	}, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]

		--if vehicleData.price > 0 then
			if exports.ESX_SystemXpLevel.ESXP_GetRank() >= vehicleData.level then
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'car_confirm', {
					title = _U('buy_vehicle', vehicleData.name, ESX.Math.GroupDigits(vehicleData.price)),
					align = GetConvar('esx_MenuAlign', 'top-left'),
					elements = {
						{label = _U('no'), value = 'no'},
						{label = _U('yes'), value = 'yes'}
				}}, function(data2, menu2)
					if data2.current.value == 'yes' and not YesAlready then
						YesAlready = true
						local generatedPlate = GeneratePlate()
						if ESX.Game.IsSpawnPointClear(Config.Zones_esx_advancedvehicleshop[locationsss.outside].Pos, 5.0) then
							TriggerServerEvent('esx_misc3:buyveh', generatedPlate, vehicleData.name, carjobb, typeindata)
							TriggerServerEvent("esx_wesam:addowner", generatedPlate, json.encode({model = GetHashKey(vehicleData.model), plate = generatedPlate, engineHealth = 1000.0, bodyHealth = 1000.0}))
							ESX.TriggerServerCallback('esx_advancedvehicleshop:buyVehicleC', function(success)
								if success then
									IsInMainMenu, YesAlready = false, false
									menu2.close()
									menu.close()
									DeleteDisplayVehicleInsideShop()
									if vehicleData.model == "bensonc" or vehicleData.model == "bensonc2" then
										TriggerEvent("esx_mechanicjob:wesam:addvehtolist", ESX.PlayerData.identifier, generatedPlate)
									end
									ESX.Game.SpawnVehicle(vehicleData.model, Config.Zones_esx_advancedvehicleshop[locationsss.outside].Pos, Config.Zones_esx_advancedvehicleshop[locationsss.outside].Heading, function(vehicle)
										if ESX.PlayerData.job.name == "police" then
											if vehicleData.model == "doreat4" then
												SetVehicleLivery(vehicle, 2)
											elseif vehicleData.model == "doreat8" or vehicleData.model == "doreat11" then
												SetVehicleLivery(vehicle, 5)
											elseif vehicleData.model == "doreat3" or vehicleData.model == "doreat10" or vehicleData.model == "doreat5" or vehicleData.model == "doreat2" or vehicleData.model == "doreatb1" then
												SetVehicleLivery(vehicle, 4)
											elseif vehicleData.model == "doreat6" then
												SetVehicleLivery(vehicle, 3)
											end
										elseif ESX.PlayerData.job.name == "agent" then
											if vehicleData.model == "doreat3" or vehicleData.model == "doreat10" or vehicleData.model == "doreat5" or vehicleData.model == "doreat2" or vehicleData.model == "doreatb1" or vehicleData.model == "doreat6" or vehicleData.model == "doreat8" or vehicleData.model == "doreat11" then
												SetVehicleLivery(vehicle, 2)
											end
										end
										TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
										SetVehicleNumberPlateText(vehicle, generatedPlate)

										FreezeEntityPosition(playerPed, false)
										SetEntityVisible(playerPed, true)
									end)
								else
									ESX.ShowNotification(_U('not_enough_money'))
								end

							end, vehicleData.model, generatedPlate, vehicleData.category, vehicleData.name, typee, typeindata, carjobb,vehicleData.price,vehicleData.level)
						else
							YesAlready = false
							ESX.ShowNotification(_U('spawnpoint_blocked'))
						end
					else
						menu2.close()
					end
				end, function(data2, menu2)
					menu2.close()
				end)
			end
		--end
	end, function(data, menu)
		menu.close()
		DeleteDisplayVehicleInsideShop()
		local playerPed = PlayerPedId()

		CurrentAction = 'car_menu'
		CurrentActionMsg = _U('car_menu')
		CurrentActionData = {}

		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)
		SetEntityCoords(playerPed,  Config.Zones_esx_advancedvehicleshop[locationsss.enter].Pos)

		IsInMainMenu, YesAlready = false, false
	end, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
		local playerPed = PlayerPedId()

		DeleteDisplayVehicleInsideShop()
		WaitForVehicleToLoad(vehicleData.model)
		ESX.Game.SpawnLocalVehicle(vehicleData.model,  Config.Zones_esx_advancedvehicleshop[locationsss.inside].Pos,  Config.Zones_esx_advancedvehicleshop[locationsss.inside].Heading, function(vehicle)
			currentDisplayVehicle = vehicle
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
			SetModelAsNoLongerNeeded(vehicleData.model)
		end)
	end)

	DeleteDisplayVehicleInsideShop()
	if firstVehicleData.model then
		WaitForVehicleToLoad(firstVehicleData.model)
	end
	ESX.Game.SpawnLocalVehicle(firstVehicleData.model,  Config.Zones_esx_advancedvehicleshop[locationsss.inside].Pos,  Config.Zones_esx_advancedvehicleshop[locationsss.inside].Heading, function(vehicle)
		currentDisplayVehicle = vehicle
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
		SetModelAsNoLongerNeeded(firstVehicleData.model)
	end)
end

function BuyCarMenu()
	while ESXDATA.job == nil do 
		Citizen.Wait(500)
	end
	ESX.UI.Menu.CloseAll()
	local Locations = {
		enter = 'ShopEnteringCar',
		outside = 'ShopOutsideCar',
		inside = 'ShopInsideCar',
	}
	local elements515 = {}
	table.insert(elements515, { label = '<font color=green>عرض المركبات</font>', value = 'citizeen' })
	table.insert(elements515, { label = '<font color=green>معرض الدراجات</font>', value = 'citizeen2' })
	if ESXDATA.job.name == 'police' then
		table.insert(elements515, { label = 'معرض <font color=#0070CD> الشرطة </font>', value = 'police' })
	elseif ESXDATA.job.name == 'agent' then
		table.insert(elements515, { label = 'معرض <font color=#656f8b> حرس الحدود  </font>', value = 'agent' })
	elseif ESXDATA.job.name == 'mzad' then
		table.insert(elements515, { label = 'معرض <font color=#656f8b> مزادات  </font>', value = 'mzad' })
	elseif ESXDATA.job.name == 'admin' then
		table.insert(elements515, { label = 'معرض <font color=#3D3D3D> ادارة الرقابة و التفتيش </font>', value = 'admin' })
	elseif ESXDATA.job.name == 'ambulance' then
		table.insert(elements515, { label = 'معرض <font color=#E73030> الدفاع المدني </font>', value = 'ambulance' })
	elseif ESXDATA.job.name == 'mechanic' then
		table.insert(elements515, { label = 'معرض <font color=#D26612> الميكانيكي </font>', value = 'mechanic' })
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'BuyCarMenu__2', {
		title = _U('car_dealer'),
		align = GetConvar('esx_MenuAlign', 'top-left'),
		elements = elements515
	}, function(data2, menu2)
		if data2.current.value == 'citizeen' then
			ESX.UI.Menu.CloseAll()
			BuyCarMenu2('Cars', _U('car_dealer'), 'civ', 'car', Locations)
		elseif data2.current.value == 'citizeen2' then
			ESX.UI.Menu.CloseAll()
			BuyCarMenu2('Bikes', _U('car_dealer'), 'civ', 'car', Locations)
		elseif data2.current.value == 'police' then
			ESX.UI.Menu.CloseAll()
			BuyCarMenu2('PoliceCars', _U('police_dealer'), 'police', 'car', Locations)
		elseif data2.current.value == 'mzad' then
				ESX.UI.Menu.CloseAll()
				BuyCarMenu2('mzad', _U('car_dealer'), 'civ', 'car', Locations)
		elseif data2.current.value == 'agent' then
			ESX.UI.Menu.CloseAll()
			BuyCarMenu2('agentCars', _U('agent_dealer'), 'agent', 'car', Locations)
		elseif data2.current.value == 'admin' then
			ESX.UI.Menu.CloseAll()
			BuyCarMenu2('AdminCars', _U('admin_dealer'), 'admin', 'car', Locations)
		elseif data2.current.value == 'ambulance' then
			ESX.UI.Menu.CloseAll()
			BuyCarMenu2('AmbulanceCars', _U('ambulance_dealer'), 'ambulance', 'car', Locations)
		elseif data2.current.value == 'mechanic' then
			ESX.UI.Menu.CloseAll()
			BuyCarMenu2('MechanicCars', _U('mechanic_dealer'), 'mechanic', 'car', Locations)
		end
	end, function(data2, menu2)
		menu2.close()
	end)
end

function BuyBoatMenu()
	while ESXDATA.job == nil do 
		Citizen.Wait(500)
	end
	ESX.UI.Menu.CloseAll()
	local Locations = {
		enter = 'ShopEnteringBoat',
		outside = 'ShopOutsideBoat',
		inside = 'ShopInsideBoat',
	}
	local elements515 = {}
	table.insert(elements515, { label = '<font color=green>عرض القوارب</font>', value = 'citizen' })
	if ESXDATA.job.name == 'police' then
		table.insert(elements515, { label = 'معرض <font color=#0070CD> الشرطة </font>', value = 'police' })
	elseif ESXDATA.job.name == 'agent' then
		table.insert(elements515, { label = 'معرض <font color=#656f8b> حرس الحدود  </font>', value = 'agent' })
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'BuyCarMenu__2', {
		title = _U('boat_dealer'),
		align = GetConvar('esx_MenuAlign', 'top-left'),
		elements = elements515
	}, function(data2, menu2)
		if data2.current.value == 'citizen' then
			ESX.UI.Menu.CloseAll()
			BuyCarMenu2('Boats', _U('boat_dealer'), 'civ', 'boat', Locations)
		elseif data2.current.value == 'police' then
			ESX.UI.Menu.CloseAll()
			BuyCarMenu2('PoliceBoats', _U('police_dealer'), 'police', 'boat', Locations)
		elseif data2.current.value == 'agent' then
			ESX.UI.Menu.CloseAll()
			BuyCarMenu2('agentBoats', _U('agent_dealer'), 'agent', 'boat', Locations)
		end
	end, function(data2, menu2)
		menu2.close()
	end)
end

function BuyTruckMenu()
	while ESXDATA.job == nil do 
		Citizen.Wait(500)
	end
	ESX.UI.Menu.CloseAll()
	local Locations = {
		enter = 'ShopEnteringTruck',
		outside = 'ShopOutsideTruck',
		inside = 'ShopInsideTruck',
	}
	local elements515 = {}
	table.insert(elements515, { label = '<font color=green>عرض الشاحنات</font>', value = 'citizen' })
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'BuyCarMenu__2', {
		title = _U('truck_dealer'),
		align = GetConvar('esx_MenuAlign', 'top-left'),
		elements = elements515
	}, function(data2, menu2)
		if data2.current.value == 'citizen' then
			ESX.UI.Menu.CloseAll()
			BuyCarMenu2('Trucks', _U('truck_dealer'), 'civ', 'truck', Locations)
		end
	end, function(data2, menu2)
		menu2.close()
	end)
end

function BuyAircraftMenu()
	while ESXDATA.job == nil do 
		Citizen.Wait(500)
	end
	ESX.UI.Menu.CloseAll()
	local Locations = {
		enter = 'ShopEnteringAircraft',
		outside = 'ShopOutsideAircraft',
		inside = 'ShopInsideAircraft',
	}
	local elements515 = {}
	table.insert(elements515, { label = '<font color=green>عرض الطائرات</font>', value = 'citizen' })
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'BuyCarMenu__2', {
		title = _U('aircraft_dealer'),
		align = GetConvar('esx_MenuAlign', 'top-left'),
		elements = elements515
	}, function(data2, menu2)
		if data2.current.value == 'citizen' then
			ESX.UI.Menu.CloseAll()
			BuyCarMenu2('Aircrafts', _U('aircraft_dealer'), 'civ', 'aircraft', Locations)
		end
	end, function(data2, menu2)
		menu2.close()
	end)
end

function BuyHelicopterMenu()
	while ESXDATA.job == nil do 
		Citizen.Wait(500)
	end
	ESX.UI.Menu.CloseAll()
	local Locations = {
		enter = 'ShopEnteringHelicopter',
		outside = 'ShopOutsideHelicopter',
		inside = 'ShopInsideHelicopter',
	}
	local elements515 = {}
	table.insert(elements515, { label = '<font color=green>عرض المروحيات</font>', value = 'citizen' })
	if ESXDATA.job.name == 'police' then
		table.insert(elements515, { label = 'معرض <font color=#0070CD> الشرطة </font>', value = 'police' })
	elseif ESXDATA.job.name == 'agent' then
		table.insert(elements515, { label = 'معرض <font color=#656f8b> حرس الحدود  </font>', value = 'agent' })
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'BuyCarMenu__2', {
		title = _U('helicopter_dealer'),
		align = GetConvar('esx_MenuAlign', 'top-left'),
		elements = elements515
	}, function(data2, menu2)
		if data2.current.value == 'citizen' then
			ESX.UI.Menu.CloseAll()
			BuyCarMenu2('Helicopters', _U('helicopter_dealer'), 'civ', 'helicopter', Locations)
		elseif data2.current.value == 'police' then
			ESX.UI.Menu.CloseAll()
			BuyCarMenu2('PoliceHelicopters', _U('police_dealer'), 'police', 'helicopter', Locations)
		elseif data2.current.value == 'agent' then
			ESX.UI.Menu.CloseAll()
			BuyCarMenu2('agentHelicopters', _U('agent_dealer'), 'agent', 'helicopter', Locations)
		end
	end, function(data2, menu2)
		menu2.close()
	end)
end


-- Entered Marker
AddEventHandler('esx_advancedvehicleshop:hasEnteredMarker', function(zone)
	if zone == 'ShopEnteringAircraft' then
		if Config.Aircraft_esx_advancedvehicleshop.Shop then
			CurrentAction = 'aircraft_menu'
			CurrentActionMsg = _U('aircraft_menu')
			CurrentActionData = {}
		end
	elseif zone == 'ShopEnteringBoat' then
		if Config.Boat_esx_advancedvehicleshop.Shop then
			CurrentAction = 'boat_menu'
			CurrentActionMsg = _U('boat_menu')
			CurrentActionData = {}
		end
	elseif zone == 'ShopEnteringCar' then
		if Config.Car_esx_advancedvehicleshop.Shop then
			CurrentAction = 'car_menu'
			CurrentActionMsg = _U('car_menu')
			CurrentActionData = {}
		end
	elseif zone == 'ShopEnteringTruck' then
		if Config.Truck_esx_advancedvehicleshop.Shop then
			CurrentAction = 'truck_menu'
			CurrentActionMsg = _U('truck_menu')
			CurrentActionData = {}
		end
	elseif zone == 'ShopEnteringHelicopter' then
		if Config.Helicopter_esx_advancedvehicleshop.Shop then
			CurrentAction = 'helicopter_menu'
			CurrentActionMsg = _U('helicopter_menu')
			CurrentActionData = {}
		end
	end
end)

-- Exited Marker
AddEventHandler('esx_advancedvehicleshop:hasExitedMarker', function(zone)
	if not IsInMainMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

-- Resource Stop
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if IsInMainMenu then
			ESX.UI.Menu.CloseAll()

			local playerPed = PlayerPedId()
			FreezeEntityPosition(playerPed, false)
			SetEntityVisible(playerPed, true)
		end

		DeleteDisplayVehicleInsideShop()
	end
end)

-- Create Blips
Citizen.CreateThread(function(); while not ConfigReady do; Citizen.Wait(1000); end
	if Config.Boat_esx_advancedvehicleshop.Shop and Config.Boat_esx_advancedvehicleshop.Blips then
		local blip = AddBlipForCoord(Config.Boat_esx_advancedvehicleshop.Blip.Coords)

		SetBlipSprite (blip, Config.Boat_esx_advancedvehicleshop.Blip.Sprite)
		SetBlipColour (blip, Config.Boat_esx_advancedvehicleshop.Blip.Color)
		SetBlipDisplay(blip, Config.Boat_esx_advancedvehicleshop.Blip.Display)
		SetBlipScale  (blip, Config.Boat_esx_advancedvehicleshop.Blip.Scale)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('boat_dealer_b'))
		EndTextCommandSetBlipName(blip)
	end

	if Config.Car_esx_advancedvehicleshop.Shop and Config.Car_esx_advancedvehicleshop.Blips then
		local blip = AddBlipForCoord(Config.Car_esx_advancedvehicleshop.Blip.Coords)

		SetBlipSprite (blip, Config.Car_esx_advancedvehicleshop.Blip.Sprite)
		SetBlipColour (blip, Config.Car_esx_advancedvehicleshop.Blip.Color)
		SetBlipDisplay(blip, Config.Car_esx_advancedvehicleshop.Blip.Display)
		SetBlipScale  (blip, Config.Car_esx_advancedvehicleshop.Blip.Scale)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('car_dealer_b'))
		EndTextCommandSetBlipName(blip)
	end

	if Config.Truck_esx_advancedvehicleshop.Shop and Config.Truck_esx_advancedvehicleshop.Blips then
		local blip = AddBlipForCoord(Config.Truck_esx_advancedvehicleshop.Blip.Coords)

		SetBlipSprite (blip, Config.Truck_esx_advancedvehicleshop.Blip.Sprite)
		SetBlipColour (blip, Config.Truck_esx_advancedvehicleshop.Blip.Color)
		SetBlipDisplay(blip, Config.Truck_esx_advancedvehicleshop.Blip.Display)
		SetBlipScale  (blip, Config.Truck_esx_advancedvehicleshop.Blip.Scale)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('truck_dealer_b'))
		EndTextCommandSetBlipName(blip)
	end

	if Config.Helicopter_esx_advancedvehicleshop.Shop and Config.Helicopter_esx_advancedvehicleshop.Blips then
		local blip = AddBlipForCoord(Config.Helicopter_esx_advancedvehicleshop.Blip.Coords)

		SetBlipSprite (blip, Config.Helicopter_esx_advancedvehicleshop.Blip.Sprite)
		SetBlipColour (blip, Config.Helicopter_esx_advancedvehicleshop.Blip.Color)
		SetBlipDisplay(blip, Config.Helicopter_esx_advancedvehicleshop.Blip.Display)
		SetBlipScale  (blip, Config.Helicopter_esx_advancedvehicleshop.Blip.Scale)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('helicopter_dealer_b'))
		EndTextCommandSetBlipName(blip)
	end
	if Config.Aircraft_esx_advancedvehicleshop.Shop and Config.Aircraft_esx_advancedvehicleshop.Blips then
		local blip = AddBlipForCoord(Config.Aircraft_esx_advancedvehicleshop.Blip.Coords)

		SetBlipSprite (blip, Config.Aircraft_esx_advancedvehicleshop.Blip.Sprite)
		SetBlipColour (blip, Config.Aircraft_esx_advancedvehicleshop.Blip.Color)
		SetBlipDisplay(blip, Config.Aircraft_esx_advancedvehicleshop.Blip.Display)
		SetBlipScale  (blip, Config.Aircraft_esx_advancedvehicleshop.Blip.Scale)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('helicopter_dealer_b'))
		EndTextCommandSetBlipName(blip)
	end
end)

-- Draw 3D Text
function Draw3DText(x, y, z, scl_factor, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov * scl_factor
    if onScreen then
        SetTextScale(0.0, scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

local distance_until_text_disappears = 10

-- Enter / Exit marker events & Draw Markers
Citizen.CreateThread(function(); while not ConfigReady do; Citizen.Wait(1000); end
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local isInMarker, letSleep, currentZone = false, true

		for k,v in pairs(Config.Zones_esx_advancedvehicleshop) do
			local distance = #(playerCoords - v.Pos)

			if distance < Config.Main_esx_advancedvehicleshop.DrawDistance then
				letSleep = false

				if v.Type ~= -1 then
					if v.ShopId == 5 then
						if Config.Aircraft_esx_advancedvehicleshop.Shop then
							DrawMarker(v.Type, v.Pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Marker.r, v.Marker.g, v.Marker.b, 100, false, true, 2, false, nil, nil, false)
							if Vdist2(GetEntityCoords(PlayerPedId(), false), v.Pos) < distance_until_text_disappears then
								Draw3DText(v.Pos.x, v.Pos.y, v.Pos.z + 1.0, 0.5, "<font face='A9eelsh'>~y~ﺪﻳﺪﺟ~w~ ﺕﺍﺮﺋﺎﻃ ﺽﺮﻌﻣ")
							end
						end
					end

					if v.ShopId == 6 then
						if Config.Boat_esx_advancedvehicleshop.Shop then
							DrawMarker(v.Type, v.Pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Marker.r, v.Marker.g, v.Marker.b, 100, false, true, 2, false, nil, nil, false)
							if Vdist2(GetEntityCoords(PlayerPedId(), false), v.Pos) < distance_until_text_disappears then
								Draw3DText(v.Pos.x, v.Pos.y, v.Pos.z + 1.0, 0.5, "<font face='A9eelsh'>~y~ﺪﻳﺪﺟ~w~ ﺏﺭﺍﻮﻗ ﺽﺮﻌﻣ")
							end
						end
					end

					if v.ShopId == 7 then
						if Config.Car_esx_advancedvehicleshop.Shop then
							DrawMarker(v.Type, v.Pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Marker.r, v.Marker.g, v.Marker.b, 100, false, true, 2, false, nil, nil, false)
							if Vdist2(GetEntityCoords(PlayerPedId(), false), v.Pos) < distance_until_text_disappears then
								Draw3DText(v.Pos.x, v.Pos.y, v.Pos.z + 1.0, 0.5, "<font face='A9eelsh'>~y~ﺪﻳﺪﺟ~w~ ﺕﺎﺒﻛﺮﻣ ﺽﺮﻌﻣ")
							end
						end
					end

					if v.ShopId == 8 then
						if Config.Truck_esx_advancedvehicleshop.Shop then
							DrawMarker(v.Type, v.Pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Marker.r, v.Marker.g, v.Marker.b, 100, false, true, 2, false, nil, nil, false)
							if Vdist2(GetEntityCoords(PlayerPedId(), false), v.Pos) < distance_until_text_disappears then
								Draw3DText(v.Pos.x, v.Pos.y, v.Pos.z + 1.0, 0.5, "<font face='A9eelsh'>~y~ﺪﻳﺪﺟ~w~ ﺕﺎﻨﺣﺎﺷ ﺽﺮﻌﻣ")
							end
						end
					end

					if v.ShopId == 11 then
						if Config.Helicopter_esx_advancedvehicleshop.Shop then
							DrawMarker(v.Type, v.Pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Marker.r, v.Marker.g, v.Marker.b, 100, false, true, 2, false, nil, nil, false)
							if Vdist2(GetEntityCoords(PlayerPedId(), false), v.Pos) < distance_until_text_disappears then
								Draw3DText(v.Pos.x, v.Pos.y, v.Pos.z + 1.0, 0.5, "<font face='A9eelsh'>~y~ﺪﻳﺪﺟ~w~ ﺕﺎﻴﺣﻭﺮﻣ ﺽﺮﻌﻣ")
							end
						end
					end
				end

				if distance < v.Size.x then
					isInMarker, currentZone = true, k
				end
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker, LastZone = true, currentZone
			LastZone = currentZone
			TriggerEvent('esx_advancedvehicleshop:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_advancedvehicleshop:hasExitedMarker', LastZone)
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
				if CurrentAction == 'aircraft_menu' then
					if Config.Aircraft_esx_advancedvehicleshop.Shop then
						if Config.Aircraft_esx_advancedvehicleshop.License then
							ESX.TriggerServerCallback('esx_license:checkLicense', function(hasAircraftLicense)
								if hasAircraftLicense then
									BuyAircraftMenu()
								else
									ESX.ShowNotification(_U('aircraft_missing'))
									ESX.ShowNotification(_U('go_to'))
								end
							end, GetPlayerServerId(PlayerId()), 'drive_aircraft')
						else
							BuyAircraftMenu()
						end
					end
				elseif CurrentAction == 'boat_menu' then
					if Config.Boat_esx_advancedvehicleshop.Shop then
						if Config.Boat_esx_advancedvehicleshop.License then
							ESX.TriggerServerCallback('esx_license:checkLicense', function(hasBoatingLicense)
								if hasBoatingLicense then
									BuyBoatMenu()
								else
									ESX.ShowNotification(_U('boat_missing'))
									ESX.ShowNotification(_U('go_to'))
								end
							end, GetPlayerServerId(PlayerId()), 'drive_boat')
						else
							BuyBoatMenu()
						end
					end
				elseif CurrentAction == 'car_menu' then
					if Config.Car_esx_advancedvehicleshop.Shop then
						if Config.Car_esx_advancedvehicleshop.License then
							ESX.TriggerServerCallback('esx_license:checkLicense', function(hasdriverLicense)
								if hasdriverLicense then
									BuyCarMenu()
								else
									ESX.ShowNotification(_U('car_missing'))
								end
							end, GetPlayerServerId(PlayerId()), 'drive')
						else
							BuyCarMenu()
						end
					end
				elseif CurrentAction == 'truck_menu' then
					if Config.Truck_esx_advancedvehicleshop.Shop then
						if Config.Truck_esx_advancedvehicleshop.License then
							ESX.TriggerServerCallback('esx_license:checkLicense', function(hasCommercialLicense)
								if hasCommercialLicense then
									BuyTruckMenu()
								else
									ESX.ShowNotification(_U('truck_missing'))
								end
							end, GetPlayerServerId(PlayerId()), 'drive_truck')
						else
							BuyTruckMenu()
						end
					end
				elseif CurrentAction == 'helicopter_menu' then
					if Config.Helicopter_esx_advancedvehicleshop.Shop then
						if Config.Helicopter_esx_advancedvehicleshop.License then
							ESX.TriggerServerCallback('esx_license:checkLicense', function(hasCommercialLicense)
								if hasCommercialLicense then
									BuyHelicopterMenu()
								else
									ESX.ShowNotification(_U('helicopter_missing'))
								end
							end, GetPlayerServerId(PlayerId()), 'drive_aircraft')
						else
							BuyHelicopterMenu()
						end
					end
				end
				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	RequestIpl('shr_int') -- Load walls and floor

	local interiorID = 7170
	LoadInterior(interiorID)
	EnableInteriorProp(interiorID, 'csr_beforeMission') -- Load large window
	RefreshInterior(interiorID)
end)


function WaitForVehicleToLoad(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		BeginTextCommandBusyspinnerOn('STRING')
		AddTextComponentSubstringPlayerName(_U('shop_awaiting_model'))
		EndTextCommandBusyspinnerOn(4)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)
			DisableAllControlActions(0)
		end

		BusyspinnerOff()
	end
end