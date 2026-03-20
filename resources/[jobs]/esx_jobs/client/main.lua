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

local dolava = nil
local currentPort = 1
local tws3h1 = false
local tws3h2 = false
local tws3h3 = false
local tws3h4 = false
PlayerData = {}
local menuIsShowed = false
local hintIsShowed = false
local hasAlreadyEnteredMarker = false
local Blips = {}
local JobBlips = {}

local collectedItem = nil
local collectedQtty = 0
local isInMarker = false
local isInPublicMarker = false

local hintToDisplay = "no hint to display"
local spawner = 0
local myPlate = {}
local isJobVehicleDestroyed = false

local cautionVehicleInCaseofDrop = 0
local maxCautionVehicleInCaseofDrop = 0
local vehicleObjInCaseofDrop = nil
local vehicleInCaseofDrop = nil
local vehicleHashInCaseofDrop = nil
local vehicleMaxHealthInCaseofDrop = nil
local vehicleOldHealthInCaseofDrop = nil
local MyCurrentJob = false

onDuty = false

ESX = nil

local ourJobs = {
	'fueler',
	'lumberjack',
	'fisherman',
	'farmer',	
	'miner',
	'reporter',
	'slaughterer',
	'tailor',
	'vegetables',
}

local rgb = {r = 100, g = 100, b = 100}

-- Text transparency --
-- Default: 255
local alpha = 255

-- Text scale
-- Default: 0.4
-- NOTE: Number needs to be a float (so instead of 1 do 1.0)
local scale = 0.31

-- Text Font --
-- 0 - 5 possible
-- Default: 1
--1 ok italic
--4 ok normal
local font = 4

-- Rainbow Text --

local bringontherainbows = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
    
	
	PlayerData = ESX.GetPlayerData()
	isOurJob()
	refreshBlips()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	--refreshBlips()
	isOurJob()
end)

function RGBRainbow(frequency)
    local result = {}
    local curtime = GetGameTimer() / 1000

    result.r = math.floor(math.sin(curtime * frequency + 0) * 127 + 128)
    result.g = math.floor(math.sin(curtime * frequency + 2) * 127 + 128)
    result.b = math.floor(math.sin(curtime * frequency + 4) * 127 + 128)

    return result
end

RegisterNetEvent("esx_jobs:setData")
AddEventHandler("esx_jobs:setData", function(prm, data)

	TriggerServerEvent("esx_misc:NoCrimetime", prm, data)
	
end)

function OpenMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom',
	{
		title    = _U('cloakroom'),
		align    = 'bottom-right',
		elements = {
			{label = _U('job_wear'),     value = 'job_wear'},
			{label = _U('citizen_wear'), value = 'citizen_wear'}
		}
	}, function(data, menu)
		if data.current.value == 'citizen_wear' then
			onDuty = false
			deleteBlips()
			refreshBlips()
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
			ESX.ShowNotification('<font color=red>تم تسجيل الخروج بنجاح</font>')
			TriggerServerEvent('esx_service:disableService', PlayerData.job.name)
		elseif data.current.value == 'job_wear' then
			ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
				onDuty = true
				deleteBlips()
				refreshBlips()
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skin, Config.jobSkiin[PlayerData.job.name].m)
					else
						TriggerEvent('skinchanger:loadClothes', skin, Config.jobSkiin[PlayerData.job.name].f)
					end
				end)
				ESX.ShowNotification('<font color=green>تم تسجيل الدخول بنجاح</font>')
			end, PlayerData.job.name)
		end

		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

--function GetOnDuty(id)
	--local c = -1 

	--ESX.TriggerServerCallback('esx_service:getInServiceList', function(InService)
	--	c = InService
--	end, id)
--	while c == -1 do 
	--	Wait(0)
	--end
--	print(c)
	--return c 
--end
RegisterNetEvent('esx_misc:currentPortNum')
AddEventHandler('esx_misc:currentPortNum', function(port)
	if port == 11 then
		tws3h1 = true
	elseif port == 12 then
		tws3h2 = true
	elseif port == 13 then
		tws3h3 = true
	elseif port == 14 then
		tws3h4 = true
	end
	currentPort = port
	Citizen.Wait(1)
	deleteBlips()
	refreshBlips()
end)

RegisterNetEvent('esx_jobs:wesam:togglePromotion_duble_swap')
AddEventHandler('esx_jobs:wesam:togglePromotion_duble_swap', function(pr, data, type)

	TriggerServerEvent('esx_jobs:togglePromotion_duble', pr, data, type)

end)

AddEventHandler('esx_jobs:action', function(job, zone)
	menuIsShowed = true
	if zone.Type == "cloakroom" then
		OpenMenu()
	elseif zone.Type == "work" then
		hintToDisplay = "no hint to display"
		hintIsShowed = false
		local playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed, false) then
			ESX.ShowNotification(_U('foot_work'))
		else
			TriggerServerEvent('esx_jobs:A_start_2KNK2_Work', zone.Item, Config.pas)
		end
	elseif zone.Type == "vehspawner" or zone.Type == "vehspawnpt" then
		local spawnPoint = nil
		local vehicle = nil
		for k,v in pairs(Config.Jobs) do
			if PlayerData.job.name == k or PlayerData.job.name == 'admin' then
				for l,w in pairs(v.Zones) do
					if w.Type == "vehspawnpt" and w.Spawner == zone.Spawner then
						spawnPoint = w
						spawner = w.Spawner
					end
				end

				for m,x in pairs(v.Vehicles) do
					if x.Spawner == zone.Spawner then
						vehicle = x
					end
				end
			end
		end
		ESX.TriggerServerCallback('esx_license:checkLicense', function(hasdriverLicense)
			if hasdriverLicense then
				if ESX.Game.IsSpawnPointClear(spawnPoint.Pos, 5.0) then
					spawnVehicle(spawnPoint, vehicle, zone.Caution)
				else
					exports.pNotify:SendNotification({
						text = _U('spawn_blocked'), 
						type = "alert",
						queue = "killer",
						timeout = 7000,
						layout = "centerLeft",
					})
				end
			else
				ESX.ShowNotification('<font color=red>أنت لا تملك رخصة قيادة</font>')
			end
		end, GetPlayerServerId(PlayerId()), 'drive')
		--	ESX.ShowNotification(_U('spawn_blocked'))
			

	elseif zone.Type == "vehdelete" then
		local looping = true

		for k,v in pairs(Config.Jobs) do
			if PlayerData.job.name == k or PlayerData.job.name == 'admin' then
				--print("job checked!")
				for l,w in pairs(v.Zones) do
					if w.Type == "vehdelete" and w.Spawner == zone.Spawner then
						--print("type checked!")
						local playerPed = PlayerPedId()

						if IsPedInAnyVehicle(playerPed, false) then
							--print("car detected")
							local vehicle = GetVehiclePedIsIn(playerPed, false)
							local plate = GetVehicleNumberPlateText(vehicle)
							plate = string.gsub(plate, " ", "")
							local driverPed = GetPedInVehicleSeat(vehicle, -1)
							--print("car logged")
							if playerPed == driverPed then
								--print("driver correct")
								for i=1, #myPlate, 1 do
									if string.gsub(myPlate[i], " ", "") == plate then
										local vehicleHealth = GetVehicleEngineHealth(vehicleInCaseofDrop)
										local giveBack = ESX.Math.Round(vehicleHealth / vehicleMaxHealthInCaseofDrop, 2)
										TriggerServerEvent('esx_jobs:delete_plate', plate)
										TriggerServerEvent('esx_jobs:A_K2dRcaution_v63j', Config.pas, "give_back", giveBack, 0, 0, plate)
										DeleteVehicle(GetVehiclePedIsIn(playerPed, false))
										if w.Teleport ~= 0 then
											ESX.Game.Teleport(playerPed, w.Teleport)
										end

										table.remove(myPlate, i)

										if vehicleObjInCaseofDrop.HasCaution then
											vehicleInCaseofDrop = nil
											vehicleObjInCaseofDrop = nil
											vehicleMaxHealthInCaseofDrop = nil
										end

										break
									end
								end

							else
								ESX.ShowNotification(_U('not_your_vehicle'))
							end

						end

						looping = false
						break
					end

					if looping == false then
						break
					end
				end
			end
			if looping == false then
				break
			end
		end
	elseif zone.Type == "delivery" then
		if Blips['delivery'] ~= nil then
			RemoveBlip(Blips['delivery'])
			Blips['delivery'] = nil
		end
        -------------
		local data = exports.esx_misc:isNoCrimetime() --return table with 3 values {active(boolen),location,label}
		
		if data.active and (data.location == 'sea_port_close' or data.location == 'internationa_close' or data.location == 'seaport_west_close') then
			--print('# 1')
			ESX.ShowNotification('لايمكن البيع اثناء اعلان</br><font color=gray>اغلاق '..data.label)
		else
		hintToDisplay = "no hint to display"
		hintIsShowed = false
		TriggerServerEvent('esx_jobs:A_start_2KNK2_Work', zone.Item, Config.pas)
	end
	end
	--nextStep(zone.GPS)
end)

function nextStep(gps)
	if gps ~= 0 then
		if Blips['delivery'] ~= nil then
			RemoveBlip(Blips['delivery'])
			Blips['delivery'] = nil
		end

		Blips['delivery'] = AddBlipForCoord(gps.x, gps.y, gps.z)
		SetBlipRoute(Blips['delivery'], true)
		ESX.ShowNotification(_U('next_point'))
	end
end

AddEventHandler('esx_jobs:hasExitedMarker', function(zone)
	TriggerServerEvent('esx_jobs:stopWork')
	hintToDisplay = "no hint to display"
	menuIsShowed = false
	hintIsShowed = false
	isInMarker = false
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	onDuty = false
	myPlate = {} -- loosing vehicle caution in case player changes job.
	spawner = 0
	isOurJob()
	deleteBlips()
	refreshBlips()
end)

function deleteBlips()
	if JobBlips[1] ~= nil then
		for i=1, #JobBlips, 1 do
			RemoveBlip(JobBlips[i])
			JobBlips[i] = nil
		end
	end
end

function removLastBlip(Lastblip)
	RemoveBlip(Lastblip)
end
function refreshBlips()
	local zones = {}
	local blipInfo = {}
	if PlayerData.job ~= nil then
		for jobKey,jobValues in pairs(Config.Jobs) do
			if jobKey == PlayerData.job.name or PlayerData.job.name == 'admin' or PlayerData.job.name == 'agent' then
				for zoneKey,zoneValues in pairs(jobValues.Zones) do
					if tws3h1 then
						if  PlayerData.job.name == 'agent' and zoneValues.Type == 'cloakroom' or not onDuty and zoneValues.Type == 'cloakroom' then
							local blip = AddBlipForCoord(zoneValues.Pos.x, zoneValues.Pos.y, zoneValues.Pos.z)
							SetBlipSprite  (blip, jobValues.BlipInfos.Sprite)
							SetBlipDisplay (blip, 4)
							SetBlipScale   (blip, 1.0)
							SetBlipCategory(blip, 3)
							SetBlipColour  (blip, jobValues.BlipInfos.Color)
							SetBlipAsShortRange(blip, true)
		
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString(zoneValues.Name)
							EndTextCommandSetBlipName(blip)
							table.insert(JobBlips, blip)
						elseif PlayerData.job.name == 'admin' or PlayerData.job.name == 'agent' or onDuty then
							if zoneValues.Blip and zoneValues.Type == 'delivery' then
								local blip = AddBlipForCoord(zoneValues.Pos[currentPort].x, zoneValues.Pos[currentPort].y, zoneValues.Pos[currentPort].z)
								SetBlipSprite  (blip, jobValues.BlipInfos.Sprite)
								SetBlipDisplay (blip, 4)
								SetBlipScale   (blip, 1.0)
								SetBlipCategory(blip, 3)
								SetBlipColour  (blip, jobValues.BlipInfos.Color)
								SetBlipAsShortRange(blip, true)
		
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString(zoneValues.Name)
								EndTextCommandSetBlipName(blip)
								table.insert(JobBlips, blip)
							elseif zoneValues.Blip then
								local blip = AddBlipForCoord(zoneValues.Pos.x, zoneValues.Pos.y, zoneValues.Pos.z)
								SetBlipSprite  (blip, jobValues.BlipInfos.Sprite)
								SetBlipDisplay (blip, 4)
								SetBlipScale   (blip, 1.0)
								SetBlipCategory(blip, 3)
								SetBlipColour  (blip, jobValues.BlipInfos.Color)
								SetBlipAsShortRange(blip, true)
		
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString(zoneValues.Name)
								EndTextCommandSetBlipName(blip)
								table.insert(JobBlips, blip)
							end
						end
					elseif tws3h2 then
						if  PlayerData.job.name == 'agent' or PlayerData.job.name == 'agent' and zoneValues.Type == 'cloakroom' or not onDuty and zoneValues.Type == 'cloakroom' then
							local blip = AddBlipForCoord(zoneValues.Pos.x, zoneValues.Pos.y, zoneValues.Pos.z)
							SetBlipSprite  (blip, jobValues.BlipInfos.Sprite)
							SetBlipDisplay (blip, 4)
							SetBlipScale   (blip, 1.0)
							SetBlipCategory(blip, 3)
							SetBlipColour  (blip, jobValues.BlipInfos.Color)
							SetBlipAsShortRange(blip, true)
		
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString(zoneValues.Name)
							EndTextCommandSetBlipName(blip)
							table.insert(JobBlips, blip)
						elseif PlayerData.job.name == 'admin' or PlayerData.job.name == 'agent' or PlayerData.job.name == 'agent' or onDuty then
							if zoneValues.Blip and zoneValues.Type == 'delivery' then
								local blip = AddBlipForCoord(zoneValues.Pos[currentPort].x, zoneValues.Pos[currentPort].y, zoneValues.Pos[currentPort].z)
								SetBlipSprite  (blip, jobValues.BlipInfos.Sprite)
								SetBlipDisplay (blip, 4)
								SetBlipScale   (blip, 1.0)
								SetBlipCategory(blip, 3)
								SetBlipColour  (blip, jobValues.BlipInfos.Color)
								SetBlipAsShortRange(blip, true)
		
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString(zoneValues.Name)
								EndTextCommandSetBlipName(blip)
								table.insert(JobBlips, blip)
							elseif zoneValues.Blip then
								local blip = AddBlipForCoord(zoneValues.Pos.x, zoneValues.Pos.y, zoneValues.Pos.z)
								SetBlipSprite  (blip, jobValues.BlipInfos.Sprite)
								SetBlipDisplay (blip, 4)
								SetBlipScale   (blip, 1.0)
								SetBlipCategory(blip, 3)
								SetBlipColour  (blip, jobValues.BlipInfos.Color)
								SetBlipAsShortRange(blip, true)
		
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString(zoneValues.Name)
								EndTextCommandSetBlipName(blip)
								table.insert(JobBlips, blip)
							end
						end
					elseif tws3h3 then
						if  PlayerData.job.name == 'agent' or PlayerData.job.name == 'agent' and zoneValues.Type == 'cloakroom' or not onDuty and zoneValues.Type == 'cloakroom' then
							local blip = AddBlipForCoord(zoneValues.Pos.x, zoneValues.Pos.y, zoneValues.Pos.z)
							SetBlipSprite  (blip, jobValues.BlipInfos.Sprite)
							SetBlipDisplay (blip, 4)
							SetBlipScale   (blip, 1.0)
							SetBlipCategory(blip, 3)
							SetBlipColour  (blip, jobValues.BlipInfos.Color)
							SetBlipAsShortRange(blip, true)
		
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString(zoneValues.Name)
							EndTextCommandSetBlipName(blip)
							table.insert(JobBlips, blip)
						elseif PlayerData.job.name == 'admin' or PlayerData.job.name == 'agent' or PlayerData.job.name == 'agent' or onDuty then
							if zoneValues.Blip and zoneValues.Type == 'delivery' then
								local blip = AddBlipForCoord(zoneValues.Pos[currentPort].x, zoneValues.Pos[currentPort].y, zoneValues.Pos[currentPort].z)
								SetBlipSprite  (blip, jobValues.BlipInfos.Sprite)
								SetBlipDisplay (blip, 4)
								SetBlipScale   (blip, 1.0)
								SetBlipCategory(blip, 3)
								SetBlipColour  (blip, jobValues.BlipInfos.Color)
								SetBlipAsShortRange(blip, true)
		
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString(zoneValues.Name)
								EndTextCommandSetBlipName(blip)
								table.insert(JobBlips, blip)
							elseif zoneValues.Blip then
								local blip = AddBlipForCoord(zoneValues.Pos.x, zoneValues.Pos.y, zoneValues.Pos.z)
								SetBlipSprite  (blip, jobValues.BlipInfos.Sprite)
								SetBlipDisplay (blip, 4)
								SetBlipScale   (blip, 1.0)
								SetBlipCategory(blip, 3)
								SetBlipColour  (blip, jobValues.BlipInfos.Color)
								SetBlipAsShortRange(blip, true)
		
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString(zoneValues.Name)
								EndTextCommandSetBlipName(blip)
								table.insert(JobBlips, blip)
							end
						end
					elseif tws3h4 then
						if  PlayerData.job.name == 'agent' and zoneValues.Type == 'cloakroom' or not onDuty and zoneValues.Type == 'cloakroom' then
							local blip = AddBlipForCoord(zoneValues.Pos.x, zoneValues.Pos.y, zoneValues.Pos.z)
							SetBlipSprite  (blip, jobValues.BlipInfos.Sprite)
							SetBlipDisplay (blip, 4)
							SetBlipScale   (blip, 1.0)
							SetBlipCategory(blip, 3)
							SetBlipColour  (blip, jobValues.BlipInfos.Color)
							SetBlipAsShortRange(blip, true)
		
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString(zoneValues.Name)
							EndTextCommandSetBlipName(blip)
							table.insert(JobBlips, blip)
						elseif PlayerData.job.name == 'admin' or PlayerData.job.name == 'agent' or onDuty then
							if zoneValues.Blip and zoneValues.Type == 'delivery' then
								local blip = AddBlipForCoord(zoneValues.Pos[currentPort].x, zoneValues.Pos[currentPort].y, zoneValues.Pos[currentPort].z)
								SetBlipSprite  (blip, jobValues.BlipInfos.Sprite)
								SetBlipDisplay (blip, 4)
								SetBlipScale   (blip, 1.0)
								SetBlipCategory(blip, 3)
								SetBlipColour  (blip, jobValues.BlipInfos.Color)
								SetBlipAsShortRange(blip, true)
		
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString(zoneValues.Name)
								EndTextCommandSetBlipName(blip)
								table.insert(JobBlips, blip)
							elseif zoneValues.Blip then
								local blip = AddBlipForCoord(zoneValues.Pos.x, zoneValues.Pos.y, zoneValues.Pos.z)
								SetBlipSprite  (blip, jobValues.BlipInfos.Sprite)
								SetBlipDisplay (blip, 4)
								SetBlipScale   (blip, 1.0)
								SetBlipCategory(blip, 3)
								SetBlipColour  (blip, jobValues.BlipInfos.Color)
								SetBlipAsShortRange(blip, true)
		
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString(zoneValues.Name)
								EndTextCommandSetBlipName(blip)
								table.insert(JobBlips, blip)
							end
						end
					else
						if  PlayerData.job.name == 'agent' and zoneValues.Type == 'cloakroom' or not onDuty and zoneValues.Type == 'cloakroom' then
							local blip = AddBlipForCoord(zoneValues.Pos.x, zoneValues.Pos.y, zoneValues.Pos.z)
							SetBlipSprite  (blip, jobValues.BlipInfos.Sprite)
							SetBlipDisplay (blip, 4)
							SetBlipScale   (blip, 1.0)
							SetBlipCategory(blip, 3)
							SetBlipColour  (blip, jobValues.BlipInfos.Color)
							SetBlipAsShortRange(blip, true)
		
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString(zoneValues.Name)
							EndTextCommandSetBlipName(blip)
							table.insert(JobBlips, blip)
						elseif PlayerData.job.name == 'admin' or PlayerData.job.name == 'agent' or onDuty then
							if zoneValues.Blip and zoneValues.Type == 'delivery' then
								local blip = AddBlipForCoord(zoneValues.Pos[currentPort].x, zoneValues.Pos[currentPort].y, zoneValues.Pos[currentPort].z)
								SetBlipSprite  (blip, jobValues.BlipInfos.Sprite)
								SetBlipDisplay (blip, 4)
								SetBlipScale   (blip, 1.0)
								SetBlipCategory(blip, 3)
								SetBlipColour  (blip, jobValues.BlipInfos.Color)
								SetBlipAsShortRange(blip, true)
		
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString(zoneValues.Name)
								EndTextCommandSetBlipName(blip)
								table.insert(JobBlips, blip)
							elseif zoneValues.Blip then
								local blip = AddBlipForCoord(zoneValues.Pos.x, zoneValues.Pos.y, zoneValues.Pos.z)
								SetBlipSprite  (blip, jobValues.BlipInfos.Sprite)
								SetBlipDisplay (blip, 4)
								SetBlipScale   (blip, 1.0)
								SetBlipCategory(blip, 3)
								SetBlipColour  (blip, jobValues.BlipInfos.Color)
								SetBlipAsShortRange(blip, true)
		
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString(zoneValues.Name)
								EndTextCommandSetBlipName(blip)
								table.insert(JobBlips, blip)
							end
						end
					end	
				end
			end
		end
	end
end

function spawnVehicle(spawnPoint, vehicle, vehicleCaution)
	hintToDisplay = 'no hint to display'
	hintIsShowed = false
	TriggerServerEvent('esx_jobs:A_K2dRcaution_v63j', Config.pas, 'take', vehicleCaution, spawnPoint, vehicle)
end

RegisterNetEvent('esx_jobs:spawnJobVehicle')
AddEventHandler('esx_jobs:spawnJobVehicle', function(spawnPoint, vehicle)
	local playerPed = PlayerPedId()
	ESX.Game.SpawnVehicle(vehicle.Hash, spawnPoint.Pos, spawnPoint.Heading, function(spawnedVehicle)

		if vehicle.Trailer ~= "none" then
			ESX.Game.SpawnVehicle(vehicle.Trailer, spawnPoint.Pos, spawnPoint.Heading, function(trailer)
				AttachVehicleToTrailer(spawnedVehicle, trailer, 1.1)
			end)
		end

		-- save & set plate
		local plate = 'WRK ' .. math.random(1000, 9999)
		SetVehicleNumberPlateText(spawnedVehicle, plate)
		table.insert(myPlate, plate)
		TriggerServerEvent('esx_jobs:addToData', plate)
		TriggerServerEvent('esx_wesam:addowner', plate, json.encode({model = GetHashKey("nissanditsun"), plate = plate, engineHealth = 1000.0, bodyHealth = 1000.0}))
		plate = string.gsub(plate, " ", "")
		TaskWarpPedIntoVehicle(playerPed, spawnedVehicle, -1)
		isJobVehicleDestroyed = false
		local vehicleProps = ESX.Game.GetVehicleProperties(spawnedVehicle)
		if vehicle.HasCaution then
			vehicleInCaseofDrop = spawnedVehicle
			vehicleHashInCaseofDrop = vehicle.Hash
			vehicleObjInCaseofDrop = vehicle
			vehicleMaxHealthInCaseofDrop = GetEntityMaxHealth(spawnedVehicle)
			vehicleOldHealthInCaseofDrop = vehicleMaxHealthInCaseofDrop
		end
		
		if vehicle.Livery ~= nil  then
			SetVehicleLivery(spawnedVehicle, 0)
		end
	end)
end)

-- Show top left hint
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if hintIsShowed then
			if hintToDisplay then 
				ESX.ShowHelpNotification(hintToDisplay)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function isOurJob()
	while PlayerData.job == nil do
		Citizen.Wait(500)
	end
	
	--local check = false
	local check = true
	
	for i=1, #ourJobs, 1 do
		if PlayerData.job.name == ourJobs[i] then
			check = true
			break
		end
	end

	if check then
		MyCurrentJob = true
		--Config.cooldownCurrent = Config.cooldownPolice
	else
		MycurrentJob = false
		--Config.cooldownCurrent = Config.cooldownCitizen
	end
end	

draw = false

-- Display markers (only if on duty and the player's job ones)
Citizen.CreateThread(function()
	local sleep = 0
	
	while true do
		draw = false
		
		if MyCurrentJob then
			local zones = {}
	
			if PlayerData.job ~= nil then
				for k,v in pairs(Config.Jobs) do
					if PlayerData.job.name == k or PlayerData.job.name == 'admin' then
						zones = v.Zones
					end
				end
	
				local coords = GetEntityCoords(PlayerPedId())
				for k,v in pairs(zones) do
					if onDuty or v.Type == "cloakroom" then
						local dist 
							if v.Type == 'delivery' then --multi port
								dist = GetDistanceBetweenCoords(coords, v.Pos[currentPort].x, v.Pos[currentPort].y, v.Pos[currentPort].z, true)
							else	
								dist = GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true)
							end
						if dist < Config.DrawDistance then
							draw = true
							if  v.Marker ~= -1 and v.Type == 'delivery' then --multi port
								DrawMarker(v.Marker, v.Pos[currentPort].x, v.Pos[currentPort].y, v.Pos[currentPort].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size[currentPort].x, v.Size[currentPort].y, v.Size[currentPort].z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
								draw = true
							elseif v.Marker ~= -1 then -- one point only
								DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
								draw = true
							end	
						end
					end
				end
			end
			
			if draw then
				sleep = 1
			else
				sleep = 1
			end	
		else
			sleep = 1
		end
		
		Citizen.Wait(sleep)
	end
end)

draw_public = false

-- Display public markers
Citizen.CreateThread(function()
	local sleep = 0
	
	while true do
		draw_public = false
		if MyCurrentJob then
			local coords = GetEntityCoords(PlayerPedId())
			for k,v in pairs(Config.PublicZones) do
				local dist = GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true)
				if dist < Config.DrawDistance then
					draw = true
					if  v.Marker ~= -1 then
						DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
						draw_public = true
					end	
				end
			end
			
			if draw_public then
				sleep = 1
			else
				sleep = 1
			end	
		else
			sleep = 1
		end
		
		Citizen.Wait(sleep)
	end
end)

-- Activate public marker
Citizen.CreateThread(function()
	local sleep = 0
	
	while true do
		if draw or draw_public then
			local coords      = GetEntityCoords(PlayerPedId())
			local position    = nil
			local zone        = nil
			
			for k,v in pairs(Config.PublicZones) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInPublicMarker = true
					position = v.Teleport
					zone = v
					break
				else
					isInPublicMarker  = false
				end
			end
	
			if IsControlJustReleased(0, Keys['E']) and isInPublicMarker then
				ESX.Game.Teleport(PlayerPedId(), position)
				isInPublicMarker = false
			end
	
			-- hide or show top left zone hints
			if isInPublicMarker then
				hintToDisplay = zone.Hint
				hintIsShowed = true
			else
				if not isInMarker then
					hintToDisplay = "no hint to display"
					hintIsShowed = false
				end
			end
			sleep = 1
		else
			sleep = 1
		end
		
		Citizen.Wait(sleep)
	end
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	local sleep = 0
	
	while true do
		if draw or draw_public then
			if PlayerData.job ~= nil and PlayerData.job.name ~= 'unemployed' then
				local zones = nil
				local job = nil
	
				for k,v in pairs(Config.Jobs) do
					if PlayerData.job.name == k or PlayerData.job.name == 'admin' then
						job = v
						zones = v.Zones
					end
				end
	
				if zones ~= nil then
					local coords      = GetEntityCoords(PlayerPedId())
					local currentZone = nil
					local zone        = nil
					local lastZone    = nil
	
					for k,v in pairs(zones) do
						if v.Type == 'delivery' then
							if GetDistanceBetweenCoords(coords, v.Pos[currentPort].x, v.Pos[currentPort].y, v.Pos[currentPort].z, true) < v.Size[currentPort].x then
								isInMarker  = true
								currentZone = k
								zone        = v
								break
							end	
						elseif GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x then
							isInMarker  = true
							currentZone = k
							zone        = v
							break
						else
							isInMarker  = false
						end
					end
	
					if IsControlJustReleased(0, Keys['E']) and not menuIsShowed and isInMarker then
					
						ESX.UI.Menu.CloseAll()
						
						local glitch = nil
						local WaitingTime = Config.WaitingTime
						
						local msg = '<font size=5 color=white>جاري التنفيذ'
						TriggerEvent('pogressBar:drawBar', waitingTime, msg)
						
						glitch = glitchDetect(zone.Type)
						
						while glitch == nil do	
							Citizen.Wait(0)
						end	
						
						if not glitch then -- add this for detect glitch   
							if onDuty or zone.Type == "cloakroom" or PlayerData.job.name == "reporter" then
								TriggerEvent('esx_jobs:action', job, zone)
							end
						end
					end
					-- hide or show top left zone hints
					if isInMarker and not menuIsShowed then
						hintIsShowed = true
						if (onDuty or zone.Type == "cloakroom" or PlayerData.job.name == "reporter") and zone.Type ~= "vehdelete" then
							hintToDisplay = zone.Hint
							hintIsShowed = true
						elseif zone.Type == "vehdelete" and (onDuty or PlayerData.job.name == "reporter") then
							local playerPed = PlayerPedId()
	
							if IsPedInAnyVehicle(playerPed, false) then
								local vehicle = GetVehiclePedIsIn(playerPed)
								local driverPed = GetPedInVehicleSeat(vehicle, -1)
								local isVehicleOwner = false
								local plate = GetVehicleNumberPlateText(vehicle)
								plate = string.gsub(plate, " ", "")
	
								for i=1, #myPlate, 1 do
									if myPlate[i] == plate and playerPed == driverPed then
										hintToDisplay  = _U('security_deposit', zone.Hint)
										isVehicleOwner = true
										break
									end
								end
	
								if not isVehicleOwner then
									hintToDisplay = _U('not_your_vehicle')
								end
							else
								hintToDisplay = _U('in_vehicle')
							end
							hintIsShowed = true
						elseif onDuty and zone.Spawner ~= spawner then
							hintToDisplay = _U('wrong_point')
							hintIsShowed = true
						else
							if not isInPublicMarker then
								hintToDisplay = "no hint to display"
								hintIsShowed = false
							end
						end
					end
	
					if isInMarker and not hasAlreadyEnteredMarker then
						hasAlreadyEnteredMarker = true
					end
	
					if not isInMarker and hasAlreadyEnteredMarker then
						hasAlreadyEnteredMarker = false
						TriggerEvent('esx_jobs:hasExitedMarker', zone)
					end
				end
			end
			sleep = 1
		else
			sleep = 1
		end
		
		Citizen.Wait(sleep)	
	end
end)

Citizen.CreateThread(function()
	-- Slaughterer
	RemoveIpl("CS1_02_cf_offmission")
	RequestIpl("CS1_02_cf_onmission1")
	RequestIpl("CS1_02_cf_onmission2")
	RequestIpl("CS1_02_cf_onmission3")
	RequestIpl("CS1_02_cf_onmission4")

	-- Tailor
	RequestIpl("id2_14_during_door")
	RequestIpl("id2_14_during1")
end)


function glitchDetect(zoneType)

	local countTime = Config.WaitingTime --time to check player not glitching
	local countEpress = 1
	
	while countTime ~= 0 do
		Citizen.Wait(0)
		
		----------------------------
		DisableAllControlActions(0) --disable all control (comment it if you want to detect how many time key pressed)
		----------------------------
		
		if IsControlJustReleased(0, Keys['E']) and not menuIsShowed and isInMarker then
			countEpress = countEpress + 1
		end 
		
		countTime = countTime - 20
	end
	
	if countEpress ~= 1 then
		local fine = countEpress * Config.GlitchFineCost
		TriggerEvent("pNotify:SendNotification", {
			text = "<h1><center><font color=red><i>".."تنبيه !!".."</i></font></h1>"..
			"<font size=5 color=white><p align=right><b>انت تحاول استغلال ثغرات برمجية عدد مرات الضغط: <font color=FFAE00>"..countEpress.."<font color=white> وعليه تم ابلاغ <font color=FFAE00>الرقابة والتفتيش <font color=white> وتغريمك مبلغ: <font color=red>"..fine.."</font>",
			type = "error",
			queue = left,
			timeout = 5000,
			killer = true,
			theme = "gta",
			layout = "center"})

		if zoneType == 'cloakroom' then
			zoneType = 'غرفة تبديل'
		elseif zoneType == 'work' then
			zoneType = 'اخد مواقع العمل'
		elseif zoneType == 'vehspawner' then
			zoneType = 'استلام مركبة العمل'
		elseif zoneType == 'vehdelete' then
			zoneType = 'تسليم مركبة العمل'
		elseif zoneType == 'delivery' then
			zoneType = 'التصدير والبيع'
		else
			zoneType = zoneType
		end
		
		local jobName =  PlayerData.job.name
		local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
		
		--TriggerServerEvent('esx_phone:send', 'adminjob', GetPlayerName(PlayerId())..' تم رصد الموظف في '..jobName..' يحاول استغلال الثغرات البرمجية في '..zoneType..' عدد مرات الضغط: '..countEpress, true, {x =x, y =y, z =z})
		--TriggerServerEvent('esx_jobs:takeMoneyForGLitching', countEpress, zoneType) --take money from player
		
		return true
	else
		return false
	end	
end

function GetWorkVehicles()
	return myPlate
end

exports('GetWorkVehicles', GetWorkVehicles)