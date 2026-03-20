local PlayerData = {}
ESX = nil
Citizen.CreateThread(function()
	while true do
		Wait(5)
		if ESX ~= nil then
		
		else
			ESX = nil
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		end
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
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

local fishing = false
local lastInput = 0
local pause = false
local pausetimer = 0
local correct = 0

local bait = "none"

local blip = AddBlipForCoord(23.37, -2778.49, 4.7)

			SetBlipSprite (blip, 427)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 1.1)
			SetBlipColour (blip, 18)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			--AddTextComponentString("Fish selling")
			AddTextComponentString("<FONT FACE='A9eelsh'>ﺏﺭﺍﻮﻘﻟﺍ ﺮﻴﺟﺄﺗ</font>")
			EndTextCommandSetBlipName(blip)
			

					
	
Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)

		-- Rental Markers
		for k, v in pairs(Config.MarkerZones) do
			if #(pedCoords - v.Marker) < 100.0 then
				DrawMarker(1, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 1.0, 255, 255, 0, 100, 0, 0, 0, 0)	
			end
			if #(pedCoords - v.Return) < 100.0 and IsPedInAnyVehicle(ped) then
				DrawMarker(1, v.Return, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 15.0, 15.0, 2.0, 255, 0, 0, 100, false, true, 2, false, false, false, false)
				if #(pedCoords - v.Return) < 15.0 then
					if DoesEntityExist(veh) and GetVehiclePedIsIn(ped) == veh then
						DisplayHelpText('<FONT FACE="A9eelsh">ﺏﺭﺎﻘﻟﺍ ﺓﺩﺎﻋﻹ ~y~E~w~ ﻂﻐﺿﺍ')
						if IsControlJustReleased(0, Keys['E']) then
							for _, q in pairs(Config.RentalBoats) do
								if GetEntityModel(veh) == GetHashKey(q.model) then
									local deposit = math.floor(q.price)
									TriggerServerEvent('esx_jobs:delete_plate', plate)
									TriggerServerEvent('fishing:returnDeposit', GetHashKey(q.model))
									local msg = 'لقد قمت بإسترجاع <font color=orange> مبلغ تأمين القارب <font color=white>المقدر '..'$'..deposit
		                            sendFishingMsg('alert','centerLeft',5000,true,msg)	
								end
							end
							SetEntityAsMissionEntity(veh)
							DeleteEntity(veh)
							TriggerServerEvent("deleteThisEntity", NetworkGetNetworkIdFromEntity(veh))
							SetEntityCoords(ped, v.Marker)
						end
					else
						DisplayHelpText('ﺓﺮﺟﺄﺘﺴﻣ ﺖﺴﻴﻟ ﺔﺒﻛﺮﻤﻟﺍ ﻩﺬﻫ')
					end
				end
			end
		end
    end
end)
			
function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

--fishing control
function startFishing()
	Citizen.CreateThread(function()
		
		ESX.UI.Menu.CloseAll()
		
		playerPed = GetPlayerPed(-1)
		
		while fishing do
			Citizen.Wait(0)
			
			local pos = GetEntityCoords(playerPed)
			
			if IsControlJustReleased(0, Keys['N1']) then
				input = 1
			elseif IsControlJustReleased(0, Keys['N2']) then
				input = 2
			elseif IsControlJustReleased(0, Keys['N3']) then
				input = 3
			elseif IsControlJustReleased(0, Keys['N4']) then
				input = 4
			elseif IsControlJustReleased(0, Keys['N5']) then
				input = 5
			elseif IsControlJustReleased(0, Keys['N6']) then
				input = 6
			elseif IsControlJustReleased(0, Keys['N7']) then
				input = 7
			elseif IsControlJustReleased(0, Keys['N8']) then
				input = 8
			elseif IsControlJustReleased(0, Keys['X']) then
				fishing = false
				ClearPedTasks(GetPlayerPed(-1))
				ESX.ShowNotification("ﻚﻤﺴﻟﺍ ﺪﻴﺻ ﺀﺎﻐﻟﺇ")
			end
			
				
			if pos.y >= 7700 or pos.y <= -4000 or pos.x <= -3700 or pos.x >= 4300 or IsPedInAnyVehicle(playerPed) then
				
			else
				fishing = false
				ESX.ShowNotification("ﻚﻤﺴﻟﺍ ﺪﻴﺻ ﺀﺎﻐﻟﺇ")
				ClearPedTasks(playerPed)
			end
			
			if IsEntityDead(playerPed) or IsEntityInWater(playerPed) then
				fishing = false
				ClearPedTasks(playerPed)
				ESX.ShowNotification("ﻚﻤﺴﻟﺍ ﺪﻴﺻ ﺀﺎﻐﻟﺇ")
			end
					
			if pausetimer > 3 then
				input = 99
			end
			
			if pause and input ~= 0 then
				pause = false
				if input == correct then
					TriggerServerEvent('fishing:catch', bait)
				else
					--ESX.ShowNotification("تحررت السمكه من الطعم")
					local msg = '<font color=red>تحررت السمكه من الطعم'
					sendFishingMsg('error','bottomCenter',2000,true,msg)
				end
			end
		end
	end)
end


function disableControls()
	Citizen.CreateThread(function()
		while PlayerData == nil do
			Citizen.Wait(500)
		end
		
		local playerPed = PlayerPedId()
		
		while fishing do
			Citizen.Wait(0)
			
			if IsPedInAnyVehicle(playerPed) then
				DisableControlAction(0, 1, true) -- Disable pan
				DisableControlAction(0, 2, true) -- Disable tilt
			end
			
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, Keys['W'], true) -- W
			DisableControlAction(0, Keys['A'], true) -- A
			DisableControlAction(0, Keys['E'], true) -- A
			DisableControlAction(0, 31, true) -- S (fault in Keys table!)
			DisableControlAction(0, 30, true) -- D (fault in Keys table!)
	
			DisableControlAction(0, Keys['R'], true) -- Reload
			DisableControlAction(0, Keys['SPACE'], true) -- Jump
			DisableControlAction(0, Keys['Q'], true) -- Cover
			DisableControlAction(0, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(0, Keys['F'], true) -- Also 'enter'?
	
			DisableControlAction(0, Keys['F1'], true) -- Disable phone
			DisableControlAction(0, Keys['F3'], true) -- Animations
			DisableControlAction(0, Keys['F6'], true) -- Job
			
			DisableControlAction(0, Keys['1'], true) -- Job
			DisableControlAction(0, Keys['2'], true) -- Job
			DisableControlAction(0, Keys['3'], true) -- Job
			DisableControlAction(0, Keys['4'], true) -- Job
			DisableControlAction(0, Keys['5'], true) -- Job
			DisableControlAction(0, Keys['6'], true) -- Job
			DisableControlAction(0, Keys['7'], true) -- Job
			DisableControlAction(0, Keys['8'], true) -- Job
	
			DisableControlAction(0, Keys['V'], true) -- Disable changing view
			DisableControlAction(0, Keys['C'], true) -- Disable looking behind
			DisableControlAction(2, Keys['P'], true) -- Disable pause screen
	
			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle
	
			DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth
	
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
	
		end
	end)
end
				

--fishing 
function randomMathFish()
	Citizen.CreateThread(function()
		while fishing do
			local wait = math.random(Config.FishTime.a , Config.FishTime.b)
			
			Citizen.Wait(wait)
			
			pause = true
			correct = math.random(4,8)
			--ESX.ShowNotification("علقت سمكة بالطعم. اضغط <span style='color:orange'>" .. correct .. "</span> لسحبها من الماء")
			local msg = "علقت سمكة بالطعم. اضغط"..
						"</br><font color=orange size=8'>"..correct.."</font>"..
						"</br>لسحبها من الماء"
			sendFishingMsg('alert','center',2000,true,msg)
			input = 0
			pausetimer = 0
		end
	end)
end

function sendFishingMsg(typ,pos,time,kile,msg)
	PlaySoundFrontend(-1, "OTHER_TEXT", "HUD_AWARDS", true)
	
	TriggerEvent("pNotify:SendNotification",{
		text = '<font color=white size=5><center><b>'..msg,
		type = typ,
		timeout = (time),
		layout = pos,
		queue = "center",
		killer = kile,
		theme = "gta",
		--[[sounds = {
		   sources = {"alert4.wav"}, -- For sounds to work, you place your sound in the html folder and then add it to the files array in the __resource.lua file.
		   volume = 0.1,
		   conditions = {"docVisible"}
		}
		]]
	})
end

RegisterNetEvent('fishing:message')
AddEventHandler('fishing:message', function(message)
	--ESX.ShowNotification(message)
	sendFishingMsg('alert','centerLeft',5000,true,message)
end)
RegisterNetEvent('fishing:break')
AddEventHandler('fishing:break', function()
	fishing = false
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('fishing:spawnPed')
AddEventHandler('fishing:spawnPed', function()
	
	RequestModel( GetHashKey( "A_C_SharkTiger" ) )
		while ( not HasModelLoaded( GetHashKey( "A_C_SharkTiger" ) ) ) do
			Citizen.Wait( 1 )
		end
	local pos = GetEntityCoords(GetPlayerPed(-1))
	
	local ped = CreatePed(29, 0x06C3F072, pos.x, pos.y, pos.z, 90.0, true, false)
	SetEntityHealth(ped, 0)
end)

RegisterNetEvent('fishing:setbait')
AddEventHandler('fishing:setbait', function(bool)
	bait = bool
end)

--reset timer when pause
function resetTime()
	Citizen.CreateThread(function()
		while fishing do
			Wait(600)
			
			if pause and fishing then
				pausetimer = pausetimer + 1
			end
		end
	end)
end

RegisterNetEvent('fishing:fishstart')
AddEventHandler('fishing:fishstart', function()
	
	
	
	playerPed = GetPlayerPed(-1)
	local pos = GetEntityCoords(GetPlayerPed(-1))
	if IsPedInAnyVehicle(playerPed) then
		ESX.ShowNotification("ﺔﺒﻛﺮﻤﻟﺍ ﻦﻣ ﺪﻴﺼﻟﺍ ﻦﻜﻤﻳﻻ")
	else
		if pos.y >= 7700 or pos.y <= -4000 or pos.x <= -3700 or pos.x >= 4300 then
			TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_FISHING", 0, true)
			fishing = true
			
			resetTime()
			startFishing()
			randomMathFish()
			disableControls()
		else
			local msg = '<font color=red>يجب الإبتعاد أكثر عن اليابسة'
			sendFishingMsg('error','bottomCenter',2000,true,msg)
		end
	end
	
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
	
        for k, v in pairs(Config.MarkerZones) do
        	local ped = PlayerPedId()
            local pedcoords = GetEntityCoords(ped, false)
            local distance = Vdist(pedcoords.x, pedcoords.y, pedcoords.z, v.Marker)
            if distance <= 1.40 then

					DisplayHelpText('<FONT FACE="A9eelsh">ﺏﺭﺎﻗ ﺮﻴﺟﺄﺘﻟ ~y~E~w~ ﻂﻐﺿﺍ')
					
					if IsControlJustPressed(0, Keys['E']) then
						OpenBoatsMenu(v.Spawn, v.SpawnHeading)
					end 
			elseif distance < 1.45 then
				ESX.UI.Menu.CloseAll()
            end
        end
    end
end)

function OpenBoatsMenu(xyz, h)
	local ped = PlayerPedId()
	PlayerData = ESX.GetPlayerData()
	local elements = {}
	
	table.insert(elements, {label = '<span style="color:orange;">5000$</span> <span style="color:white;">- قارب صغير</span>', value = 'boat'})		
	--If user has police job they will be able to get free Police Predator boat
	if PlayerData.job.name == "police" then
		table.insert(elements, {label = '<span style="color:green;">قارب الشرطة</span>', value = 'police'})
	end	

	if PlayerData.job.name == "agent" then
		table.insert(elements, {label = '<span style="color:green;">قارب حرس الحدود</span>', value = 'agent'})	
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'client', {
		title    = 'تأجير القوارب',
		align    = 'bottom-right',
		elements = elements,
    }, function(data, menu)
		if data.current.value == 'boat' then
			ESX.UI.Menu.CloseAll()
			TriggerServerEvent("fishing:lowmoney", 5000) 
			local msg = 'لقد قمت بتأجير <font color=orange> قارب صغير <font color=white>مقابل '..'$5000'
			sendFishingMsg('alert','centerLeft',5000,true,msg)
			RequestTheModel("dinghy4")
			veh = CreateVehicle("dinghy4", xyz, h, true, false)
			SetPedIntoVehicle(ped, veh, -1)
			TriggerEvent("ls:newVehicle", GetVehicleNumberPlateText(veh), veh, 0)
			DecorSetInt(veh, "ControlCar", 1)
			TriggerServerEvent('esx_jobs:addToDataBoat', GetVehicleNumberPlateText(veh))
		end
		ESX.UI.Menu.CloseAll()
    end, function(data, menu)
		menu.close()
	end)
end

function RequestTheModel(model)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(0)
	end
end
