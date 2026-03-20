
ESX = nil

local playerData = {}	
local onDuty = false	  
local isInMarker = false  
local menuIsOpen = false  
local taskPoints = {}	  
local forkBlips = {}       
local currentZone = 'none'
local Blips = {}		   
local packetsDelivered = 0 
local currentJob = 'none'  
local currentBox = nil	  
local lastDelivery = -1   
local lastPickup = -2   
local zOffset = -0.65	
local hintToDisplay = "no hint to display"				
local displayHint = false								
local currentVehicle = nil											
local currentPlate = ''												


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
    
	local currentPort = 1
    local objPoints = Config.objPoints[currentPort]
	
	PlayerData = ESX.GetPlayerData()
	
	refreshBlips()
end)

RegisterFontFile('A9eelsh')
local fontId = RegisterFontId('A9eelsh')

function elementAt(tab, indx)
  local count = 0
  local ret = nil
  for k, v in pairs(tab) do
    count = count + 1
	if count == indx then
	ret = v
	break
	end
  end
  return ret
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)		
    playerData = xPlayer							
    refreshBlips()									
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  playerData.job = job						
  onDuty = false							
  deleteBlips()								
  refreshBlips()						
end)

RegisterNetEvent('esx_misc:currentPortNum')
AddEventHandler('esx_misc:currentPortNum', function(port)
	--print('# port number changed ['..port..']')
	currentPort = port
	objPoints = Config.objPoints[currentPort]	
	deleteBlips()								
	refreshBlips()
end)

Citizen.CreateThread(function()
	if Config.enableVehDamageProtection then
		local sleep = 0
		while true do
			sleep = 1000
			if playerData.job ~= nil and playerData.job.name == "fork" then
				if onDuty and IsPedInAnyVehicle(GetPlayerPed(-1)) and isMyCar() then
					local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
					if GetVehicleEngineHealth(vehicle) <= 800 then
						SetEntityHealth(vehicle, 1000)
						SetVehicleEngineHealth(vehicle, 1000)
						SetVehicleEngineOn(vehicle, true, true)
					end
				end
			else	
				sleep = 3000
			end			
			Citizen.Wait(sleep)
		end
	end
end)

function drawBlip(coords, icon, text)
  local blip = AddBlipForCoord(coords.x, coords.y, coords.z)	
  SetBlipSprite (blip, icon)		
  SetBlipDisplay(blip, 4)			
  SetBlipScale  (blip, 0.9)			
  SetBlipColour (blip, 3)			
  SetBlipAsShortRange(blip, true)	
	
  BeginTextCommandSetBlipName("STRING")	
  AddTextComponentString(text)		
  EndTextCommandSetBlipName(blip)	
  table.insert(forkBlips, blip)	   
end

function refreshBlips()
	if playerData.job ~= nil and playerData.job.name == 'fork' then 	
		drawBlip(Config.locker[currentPort], 444, "<FONT FACE='A9eelsh'>ﺊﻧﺍﻮﻤﻟﺍ ﺕﺎﻣﺪﺧ ﺔﻛﺮﺷ")			 	
		--drawBlip(Config.carSpawner[currentPort], 479, "Trukin lunastus")					
		--drawBlip(Config.carDelete[currentPort], 490, "Trukin palautus")				
	end
end

function deleteBlips()
  if forkBlips[1] ~= nil then 	
    for i = 1, #forkBlips, 1 do	
      RemoveBlip(forkBlips[i])	
      forkBlips[i] = nil		
    end
  end
end

Citizen.CreateThread(function()
	local sleep = 0
	while true do
		sleep = 50
		if playerData.job ~= nil and playerData.job.name == "fork" then
			if displayHint then							
				SetTextComponentFormat("STRING")				
				AddTextComponentString(hintToDisplay)			
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)	
			end
		else
			sleep = 3000
		end
		Citizen.Wait(sleep)
  end
end)

function displayMarker(coords,marker)
	DrawMarker(marker.Type, coords.x, coords.y, coords.z + marker.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, marker.color.r, marker.color.g, marker.color.b, 100, false, true, 2, false, false, false, false) 
end

function isMyCar()
	return currentPlate == GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))
end

function spawnFork()							
	local vehicleModel = GetHashKey('forklift2')	
	--local vehicleModel = GetHashKey('forklift')	
	RequestModel(vehicleModel)				
	while not HasModelLoaded(vehicleModel) do	
		Citizen.Wait(0)
	end
	currentCar = CreateVehicle(vehicleModel, Config.carSpawnPoint[currentPort].x, Config.carSpawnPoint[currentPort].y, Config.carSpawnPoint[currentPort].z, Config.carSpawnPoint[currentPort].h, true, false)
	SetVehicleHasBeenOwnedByPlayer(currentCar,  true)														
	SetEntityAsMissionEntity(currentCar,  true,  true)														
	SetVehicleNumberPlateText(currentCar, "PORT" .. math.random(1000, 9999))								
	local id = NetworkGetNetworkIdFromEntity(currentCar)													
	SetNetworkIdCanMigrate(id, true)																																																
	TaskWarpPedIntoVehicle(GetPlayerPed(-1), currentCar, -1)											
	local props = {																							
		modEngine       = 1,
		modTransmission = 1,
		modSuspension   = 1,
		modTurbo        = true,																			
		modLivery        = 0,																			
	}
	ESX.Game.SetVehicleProperties(currentCar, props)
	Wait(1000)																							
	currentPlate = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))
end

function trackBox()
	Citizen.CreateThread(function()
		while currentJob == 'pickup' do
			Citizen.Wait(5)
			if currentBox ~= nil and DoesEntityExist(currentBox) then
				local coords = GetEntityCoords(currentBox)
				local playerCoords = GetEntityCoords(GetPlayerPed(-1))
				setGPS(coords)	
				if playerIsInside(playerCoords, coords, 4) then
					goDeliver()
				end
				if playerIsInside(playerCoords, coords, 100) then
					local temp = {x = coords.x, y = coords.y, z = coords.z + Config.boxZ}
					displayMarker(temp,Config.marker)
				end
			end
		end
	end)
end

function spawnBox(coords)
	Citizen.CreateThread(function()
		repeat
			Citizen.Wait(500)
		until boxCanSpawn(taskPoints['deliver'])
		
		ESX.Game.SpawnObject('prop_boxpile_07d', {
			x = coords.x,
			y = coords.y,
			z = coords.z
		}, function(obj)
			SetEntityHeading(obj, coords.h)
			PlaceObjectOnGroundProperly(obj)
			currentBox = obj
		end)
	end)
end

function deleteBox()
	if currentBox ~= nil and DoesEntityExist(currentBox) then
		DeleteEntity(currentBox)
		return true
	end
	return false
end

function deleteCurrentBox()
	if currentBox ~= nil and DoesEntityExist(currentBox) then
		DeleteEntity(currentBox)
	end
end

function giveWork()
	local indA = 0
	local indB = 0
	repeat 
		indA = math.random(1, #objPoints)	
	until indA ~= lastPickup
	local temp = objPoints[indA]
	taskPoints['pickup'] = { x = temp.x, y = temp.y, z = temp.z, h = temp.h}
	repeat
		indB = math.random(1, #objPoints)
	until indB ~= indA and indB ~= lastDelivery and isFar(taskPoints['pickup'], objPoints[indB], Config.minDistance)
	local temp2 = objPoints[indB]
	taskPoints['deliver'] = { x = temp2.x, y = temp2.y, z = temp2.z, h = temp2.h}
	lastPickup = indA
	lastDelivery = indB
end

function boxIsInside(coords)
	if currentBox ~= nil and DoesEntityExist(currentBox) then
        local objCoords = GetEntityCoords(currentBox)
        local distance  = GetDistanceBetweenCoords(coords.x,  coords.y,  coords.z,  objCoords.x,  objCoords.y,  objCoords.z,  true)
		return distance < 1.25
	else
		return false
	end
end

function boxCanSpawn(coords)
	if coords ~= nill then
		local object = GetClosestObjectOfType(coords.x,  coords.y,  coords.z,  3.0,  GetHashKey('prop_boxpile_07d'), false, false, false)
		if DoesEntityExist(object) then
			local objCoords = GetEntityCoords(object)
			local distance  = GetDistanceBetweenCoords(coords.x,  coords.y,  coords.z,  objCoords.x,  objCoords.y,  objCoords.z,  true)
			return distance > 5.0
		else
			return true
		end
	end	
end

function goDeliver()
	ESX.ShowNotification('وصل الشحنة إلى الموقع المطلوب')
	setGPS(taskPoints['deliver'])
	currentJob = 'deliver'
end

function goPickup()
	ESX.ShowNotification('اذهب بالرافعة الشوكية لاستلام الشحنة')
	setGPS(taskPoints['pickup'])
	currentJob = 'pickup'
	trackBox()
	spawnBox(taskPoints['pickup'])
end

function nextJob()
	packetsDelivered = packetsDelivered + 1
	giveWork()
	goPickup()
	--print('# packetsDelivered ['..packetsDelivered..']')
end

function startWork()
	packetsDelivered = 0
	spawnFork()
	giveWork()
	goPickup()
	--print('# packetsDelivered ['..packetsDelivered..']')
end

function deleteCar()
	local entity = GetVehiclePedIsIn(GetPlayerPed(-1), false)	
	ESX.Game.DeleteVehicle(entity)							
end

local PaidPass = 'K2md%2adk2GHG90jJ'
function getPaid()
	setGPS(0)													
	if IsPedInAnyVehicle(GetPlayerPed(-1)) and isMyCar() then			
		deleteCar()												
		TriggerServerEvent('esx_seaportjob:getPaid', packetsDelivered, PaidPass)
		PlaySoundFrontend(-1, "OTHER_TEXT", "HUD_AWARDS", true)
	else
		TriggerServerEvent('esx_seaportjob:getPaid',  packetsDelivered, PaidPass)
		PlaySoundFrontend(-1, "OTHER_TEXT", "HUD_AWARDS", true)
	end
	currentJob = 'none'											
	currentPlate = ''												
	currentVehicle = nil											
	packetsDelivered = 0											
	taskPoints = {}													
	deleteCurrentBox()												
end

function isFar(coords1, coords2, distance) 
	local vecDiffrence = GetDistanceBetweenCoords(coords1.x, coords1.y, coords1.z, coords2.x, coords2.y, coords2.z, false)
	return vecDiffrence > distance			
end

function setGPS(coords)
	if Blips['fork'] ~= nil then 	
		RemoveBlip(Blips['fork'])	
		Blips['fork'] = nil			
	end
	if coords ~= 0 then
		Blips['fork'] = AddBlipForCoord(coords.x, coords.y, coords.z)		
		SetBlipRoute(Blips['buzz'], true)								
	end
end

function playerIsInside(playerCoords, coords, distance) 	
	local vecDiffrence = GetDistanceBetweenCoords(playerCoords, coords.x, coords.y, coords.z, false)
	return vecDiffrence < distance		
end

function taskTrigger(zone)				
	if zone == 'locker' then				
		openMenu()
	elseif zone == 'start' then	
		if exports['Mina']:GetStatus() == 'closed' then 		
			ESX.ShowNotification('خدمات الموانئ خارج الخدمة اثناء اعلان</br><font color=gray>اغلاق الميناء')
			Citizen.Wait(100)
		else
			startWork()
		end	
	elseif zone == 'pay' then	
		getPaid()
	end
end

Citizen.CreateThread(function()
	local sleep = 0
	while true do
		sleep = 10
		if playerData.job ~= nil and playerData.job.name == "fork" and onDuty then
			local playerCoords = GetEntityCoords(GetPlayerPed(-1))
			if currentJob == 'deliver' and taskPoints['deliver'] ~= nil and playerIsInside(playerCoords, taskPoints['deliver'], 5.5) and boxIsInside(taskPoints['deliver']) then
				if deleteBox() then
					nextJob()
				end
			end
		else
			sleep = 3000
		end	
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	local sleep = 0
	while true do																
		sleep = 10				
		if playerData.job ~= nil and playerData.job.name == "fork" then
			if not menuIsOpen then
				local playerCoords = GetEntityCoords(GetPlayerPed(-1))
				if  playerIsInside(playerCoords, Config.locker[currentPort], 2.5) then 				
					isInMarker = true
					displayHint = true																
					hintToDisplay = "<FONT FACE='A9eelsh'>ﺲﺑﻼﻤﻟﺍ ﺮﻴﻴﻐﺘﻟ E ﻂﻐﺿﺍ"									
					currentZone = 'locker'																
				elseif onDuty and taskPoints['deliver'] == nil and playerIsInside(playerCoords, Config.carSpawner[currentPort], 2.5) then	
					isInMarker = true
					displayHint = true
					hintToDisplay = "<FONT FACE='A9eelsh'>ﺔﻤﻬﻤﻟﺍ ﺀﺪﺒﻟ E ﻂﻐﺿﺍ"
					currentZone = 'start'
				elseif onDuty and currentJob == 'deliver' and taskPoints['deliver'] ~= nil and playerIsInside(playerCoords, taskPoints['deliver'], Config.pickupDistance) then
					isInMarker = true
					displayHint = true
					hintToDisplay = "<FONT FACE='A9eelsh'>ﺔﻄﻳﺮﺨﻟﺎﺑ ﻊﻗﻮﻤﻟﺍ ﻰﻟﺇ ﺔﻨﺤﺸﻟﺍ ﻞﻘﻧﺍ"
					currentZone = 'none' 
				elseif  currentPlate ~= '' and playerIsInside(playerCoords, Config.carDelete[currentPort], 1.5) then  				
					isInMarker = true
					displayHint = true
					hintToDisplay = "<FONT FACE='A9eelsh'>ﺔﻨﺣﺎﺸﻟﺍ ﺓﺩﺎﻋﻹ E ﻂﻐﺿﺍ"
					currentZone = 'pay'
				else																			
					isInMarker = false
					displayHint = false
					hintToDisplay = "No hint to display"
					currentZone = 'none'
				end
				if IsControlJustReleased(0, 38) and isInMarker then
					taskTrigger(currentZone)													
					Citizen.Wait(500)
				end
			end
		else
			sleep = 3000
		end	
		Citizen.Wait(sleep)	
	end	
end)

--[[ Main OLD
Citizen.CreateThread(function()
	local sleep = 0
	while true do																
		sleep = 10
		if playerData.job ~= nil and playerData.job.name == "fork" then
			local playerCoords = GetEntityCoords(GetPlayerPed(-1))
			if  playerIsInside(playerCoords, Config.locker[currentPort], 100) then 
				displayMarker(Config.locker[currentPort],Config.markerLocker)
			end
			if onDuty and currentJob == 'none' and playerIsInside(playerCoords, Config.carSpawner[currentPort], 100) then			
				displayMarker(Config.carSpawner[currentPort],Config.markerSpawner)
			end
			if onDuty and currentJob == 'deliver' and playerIsInside(playerCoords, taskPoints['deliver'], 100) then 			
				displayMarker(taskPoints['deliver'],Config.marker)
			end
			if  onDuty and currentPlate ~= '' and playerIsInside(playerCoords, Config.carDelete[currentPort], 100) then  		
				displayMarker(Config.carDelete[currentPort],Config.markerDelete)
				
			end
			if  onDuty and currentPlate ~= '' then
				displayText()
			end			
		else
			sleep = 3000
		end
		Citizen.Wait(sleep)	
	end
end)]]

--[[ New]]
Citizen.CreateThread(function()
	local sleep = 0
	while true do																
		sleep = 0
		if playerData.job ~= nil and playerData.job.name == "fork" then
			local playerCoords = GetEntityCoords(GetPlayerPed(-1))
			if  playerIsInside(playerCoords, Config.locker[currentPort], 100) then 
				displayMarker(Config.locker[currentPort],Config.markerLocker)
			end
			if onDuty and currentJob == 'none' and playerIsInside(playerCoords, Config.carSpawner[currentPort], 100) then			
				displayMarker(Config.carSpawner[currentPort],Config.markerSpawner)
			end
			if onDuty and currentJob == 'deliver' and playerIsInside(playerCoords, taskPoints['deliver'], 100) then 			
				displayMarker(taskPoints['deliver'],Config.marker)
			end
			if  onDuty and currentPlate ~= '' and playerIsInside(playerCoords, Config.carDelete[currentPort], 100) then  		
				displayMarker(Config.carDelete[currentPort],Config.markerDelete)
				
			end
			if  onDuty and currentPlate ~= '' then
				displayText()
			end			
		else
			sleep = 3000
		end
		Citizen.Wait(sleep)	
	end
end)
--]]

--displayText
local colorwhite = {r=255,g=255,b=255}
function displayText()
	SetTextColour(colorwhite.r,colorwhite.g,colorwhite.b,255)
	SetTextFont(fontId)
	SetTextScale(0.3, 0.3)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(true)
	SetTextDropshadow(2, 2, 0, 0, 0)
	SetTextEdge(1, 0, 0, 0, 205)
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(packetsDelivered..' : ﺎﻬﻠﻴﺻﻮﺗ ﻢﺗ ﻖﻳﺩﺎﻨﺼﻟﺍ ﺩﺪﻋ')
	DrawText(0.500, 0.01)
end

function openMenu()									
  menuIsOpen = true
  ESX.UI.Menu.CloseAll()										
  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'locker',			
    {
		title    = "غرفة التبديل",	
		align    = 'bottom-right',						
      elements = {
        {label = '<span style="color:00EE4F">تسجيل دخول 👷🏽</span>', value = 'fork_wear'},		
        {label = '<span style="color:FF0E0E">تسجيل خروج 👦🏻</span>', value = 'everyday_wear'}	
      }
    },
    function(data, menu)									
      if data.current.value == 'everyday_wear' then			
        onDuty = false										
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)	
            TriggerEvent('skinchanger:loadSkin', skin)						
        end)
      end
      if data.current.value == 'fork_wear' then
        onDuty = true
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
          if skin.sex == 0 then
              TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
          else
              TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
          end
        end)
      end
      menu.close()
	  menuIsOpen = false
    end,
    function(data, menu)
      menu.close()
	  menuIsOpen = false
    end
  )
end

