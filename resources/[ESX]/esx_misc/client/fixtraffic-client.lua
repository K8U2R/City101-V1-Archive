local zones = {
{location = 'seaPort', coords = vector3(986.02, -3111.96, 5.9), dist = 600.0, clearArea = true, ZeroTraffic = true},
{location = 'armyBase', coords = vector3(-2074.18, 3144.97, 32.81), dist = 600.0, clearArea = true, ZeroTraffic = true},
{location = 'armyBase_seaport', coords = vector3(514.86, 514.86, 6.07), dist = 150.0, clearArea = true, ZeroTraffic = true},
{location = 'internationalAirport', coords = vector3(-1298.77, -3072.86, 13.94), dist = 500.0, clearArea = true, ZeroTraffic = true},
{location = 'losSantonHeliPad', coords = vector3(-736.89, -1454.32, 5.0), dist = 100.0, clearArea = true, ZeroTraffic = true},
{location = 'minerField', coords = vector3(2865.96, 2847.22, 60.78), dist = 300.0, clearArea = false, ZeroTraffic = true},
{location = 'StFiacreHospital', coords = vector3(1176.78, -1498.17, 34.7), dist = 150.0, clearArea = false, ZeroTraffic = true},
{location = 'downtown_Hospital_parking_1', coords = vector3(329.27,-1474.22,29.77), dist = 15.0, clearArea = true, ZeroTraffic = false},
{location = 'downtown_Hospital_parking_2', coords = vector3(369.19,-1455.65,29.36), dist = 15.0, clearArea = true, ZeroTraffic = false},
{location = 'downtown_Hospital_parking_3', coords = vector3(403.91,-1428.31,29.45), dist = 15.0, clearArea = true, ZeroTraffic = false},
{location = 'phillbox_Hospital', coords = vector3(329.54, -586.86, 31.43), dist = 150.0, clearArea = false, ZeroTraffic = true},
{location = 'SandyHospital', coords = vector3(1835.78, 3681.3, 35.65), dist = 25.0, clearArea = true, ZeroTraffic = false},
{location = 'ssfd', coords = vector3(1697.84, 3594.81, 35.73), dist = 25.0, clearArea = false, ZeroTraffic = false},
{location = 'pbfd', coords = vector3(-383.81, 6122.75, 31.48), dist = 20.0, clearArea = true, ZeroTraffic = false},
{location = 'jail', coords = vector3(1696.78, 2604.86, 45.56), dist = 50.0, clearArea = false, ZeroTraffic = true},
--{location = 'sandyairfield', coords = vector3(1827.04, 3277.76, 43.34), dist = 100.0, clearArea = true},
{location = 'aucation_seacity', coords = vector3(-1646.93, -889.6, 8.85), dist = 100.0, clearArea = true, ZeroTraffic = true},
{location = 'new_boat_dealearship', coords = vector3(-747.83, -1370.11, 2.98), dist = 150.0, clearArea = true, ZeroTraffic = true},
{location = 'job_event', coords = vector3(-408.46, 1184.23, 325.53), dist = 200.0, clearArea = true, ZeroTraffic = true},
{location = 'mission_raw_pd', coords = vector3(449.87, -981.25, 43.69), dist = 50.0, clearArea = false, ZeroTraffic = true},
{location = 'lsCenteralStation', coords = vector3(-637.77, -107.55, 38.0), dist = 15.0, clearArea = false, ZeroTraffic = true},
{location = 'paelto_showroom', coords = vector3(642.25, 6517.33, 28.25), dist = 100.0, clearArea = false, ZeroTraffic = true},
{location = 'paelto_store', coords = vector3(-142.61,6357.07,31.49), dist = 15.0, clearArea = true, ZeroTraffic = false},
--{location = 'sandy_highway_checkpoint', coords = vector3(1706.02, 1483.84, 84.93), dist = 300},
}

local playersOnline = 0
local closestZone = 1

--Getting your distance from any one of the locations
Citizen.CreateThread(function()
	if Config.OnesyncInfinty then
		return
	end
	
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(500)
	end
	
	while true do
		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)
		local minDistance = 100000
		
		for i = 1, #zones, 1 do
			dist = GetDistanceBetweenCoords(pedCoords, zones[i].coords, true) 
			
			if dist < minDistance then
				minDistance = dist
				closestZone = i
			end
		end
		
		Citizen.Wait(3000)
	end
end)

--set trafficDensity and pedDensity "From 0.0 to 1.0"
Citizen.CreateThread(function()	
	if Config.OnesyncInfinty then
		return
	end
	
	while PlayerData == nil or not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(500)
	end
	
	local trafficDensity = 0.0
	local pedDensity = 0.0
	
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		--local pedCoords = GetEntityCoords(ped)
		local dist = GetDistanceBetweenCoords(x, y, z, zones[closestZone].coords, true) 
		
		if dist <= zones[closestZone].dist and zones[closestZone].clearArea then 			
			local clearAreaDist =  zones[closestZone].dist
			if zones[closestZone].dist > 500 then
				clearAreaDist = 150.0
			end
			ClearAreaOfVehicles(x, y, z, clearAreaDist, false, false, false, false, false)
			RemoveVehiclesFromGeneratorsInArea(x - clearAreaDist, y - clearAreaDist, z - clearAreaDist, x + clearAreaDist, y + clearAreaDist, z + clearAreaDist);
		end
		
		if dist <= zones[closestZone].dist and zones[closestZone].ZeroTraffic then
			trafficDensity = 0.0
			pedDensity = 0.0
		else
			if playersOnline <= 1 then
				trafficDensity = 1.0
				pedDensity = 1.0
			elseif playersOnline <= 5 then
				trafficDensity = 0.7
				pedDensity = 0.7
			elseif playersOnline <= 12 then
				trafficDensity = 0.6
				pedDensity = 0.6
			elseif playersOnline <= 22 then	
				trafficDensity = 0.4
				pedDensity = 0.4
			elseif playersOnline <= 32 then	
				trafficDensity = 0.2
				pedDensity = 0.2	
			elseif playersOnline <= 42 then		
				trafficDensity = 0.1
				pedDensity = 0.2
			else --players more than 42 player		
				trafficDensity = 0.0
				pedDensity = 0.1
				
				SetGarbageTrucks(false) -- Stop garbage trucks from randomly spawning
				SetRandomBoats(false) -- Stop random boats from spawning in the water
				
				ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
				RemoveVehiclesFromGeneratorsInArea(x - 500, y - 500, z - 500, x + 500, y + 500, z + 500);
			end
		end	
		
		-- These natives have to be called every frame.
		SetVehicleDensityMultiplierThisFrame(trafficDensity) -- set traffic density to 0 
		SetPedDensityMultiplierThisFrame(pedDensity) -- set npc/ai peds density to 0
		SetRandomVehicleDensityMultiplierThisFrame(trafficDensity) -- set random vehicles (car scenarios / cars driving off from a parking spot etc.) to 0
		SetParkedVehicleDensityMultiplierThisFrame(trafficDensity) -- set random parked vehicles (parked car scenarios) to 0
		SetScenarioPedDensityMultiplierThisFrame(pedDensity, pedDensity) -- set random npc/ai peds or scenario peds to 0
	end	
end)

--count online players
Citizen.CreateThread(function()
	if Config.OnesyncInfinty then
		return
	end
	
	while true do
		
		local countPlayers = 0
		
		for _,player in ipairs(GetActivePlayers()) do
			countPlayers = countPlayers + 1
		end
		
		playersOnline = countPlayers
		
		Citizen.Wait(60000)	
	end
end)