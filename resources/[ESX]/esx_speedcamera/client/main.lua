-- BELOVE IS YOUR SETTINGS, CHANGE THEM TO WHATEVER YOU'D LIKE & MORE SETTINGS WILL COME IN THE FUTURE! --
local useBilling = false -- OPTIONS: (true/false)
local useCameraSound = false -- OPTIONS: (true/false)
local useFlashingScreen = true -- OPTIONS: (true/false)
local useBlips = false -- OPTIONS: (true/false)
local alertPolice = false -- OPTIONS: (true/false)
local alertSpeed = 180 -- OPTIONS: (1-5000 KMH)

-- ABOVE IS YOUR SETTINGS, CHANGE THEM TO WHATEVER YOU'D LIKE & MORE SETTINGS WILL COME IN THE FUTURE!
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

ESX = nil

local hasBeenCaught = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(500)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-- BLIP FOR SPEEDCAMERA (START)
local blips = {
	-- 60KM/H ZONES
	{title="Speedcamera (60KM/H)", colour=1, id=1, x = -524.2645, y = -1776.3569, z = 21.3384}, -- 60KM/H ZONE
	
	-- 80KM/H ZONES
	{title="Speedcamera (80KM/H)", colour=1, id=1, x = -90.11, 	y = 6275.83, 	z = 31.34 }, -- 80KM/H ZONE
	{title="Speedcamera (80KM/H)", colour=1, id=1, x = 224.8, 	y = -1049.2, 	z = 29.37 }, -- 80KM/H ZONE
	{title="Speedcamera (80KM/H)", colour=1, id=1, x = 1634.06, y = 2832.95, 	z = 39.81 }, -- 80KM/H ZONE
	{title="Speedcamera (80KM/H)", colour=1, id=1, x = 553.92, 	y = 3508.87,	z = 34.17 }, -- 80KM/H ZONE
	{title="Speedcamera (80KM/H)", colour=1, id=1, x = 2237.26, y = 3826.22, 	z = 34.06 }, -- 80KM/H ZONE
	{title="Speedcamera (80KM/H)", colour=1, id=1, x = -1487.09,y = 1609.38, 	z = 108.12}, -- 80KM/H ZONE
	{title="Speedcamera (80KM/H)", colour=1, id=1, x = 312.28, 	y = 1006.34, 	z = 210.52}, -- 80KM/H ZONE
	{title="Speedcamera (80KM/H)", colour=1, id=1, x = -923.12,	y = -2323.47,	z = 20.20 }, -- 80KM/H ZONE
	{title="Speedcamera (80KM/H)", colour=1, id=1, x = -385.01,	y = -379.46,	z = 31.68 }, -- 80KM/H ZONE
	{title="Speedcamera (80KM/H)", colour=1, id=1, x = -861.60,	y = 2750.63, 	z = 23.23 }, -- 80KM/H ZONE
	{title="Speedcamera (80KM/H)", colour=1, id=1, x = 129.82,	y = -1618.25,	z = 29.34 }, -- 80KM/H ZONE
	{title="Speedcamera (80KM/H)", colour=1, id=1, x = 724.50,	y = -2704.15,	z = 7.57  }, -- 80KM/H ZONE
	{title="Speedcamera (80KM/H)", colour=1, id=1, x = 41.27,	y = -2040.09,	z = 18.50 }, -- 80KM/H ZONE
	
	-- 120KM/H ZONES
	{title="Speedcamera (120KM/H)", colour=1, id=1, x = 1584.9281, y = -993.4557, z = 59.3923}, -- 120KM/H ZONE
	{title="Speedcamera (120KM/H)", colour=1, id=1, x = 2442.2006, y = -134.6004, z = 88.7765}, -- 120KM/H ZONE
	{title="Speedcamera (120KM/H)", colour=1, id=1, x = 2871.7951, y = 3540.5795, z = 53.0930}, -- 120KM/H ZONE
	{title="Speedcamera (120KM/H)", colour=1, id=1, x = -1885.3, 	 y = 4641.18, z = 57.05}, 	-- 120KM/H ZONE
	{title="Speedcamera (120KM/H)", colour=1, id=1, x = 2457.96,	 y = 5637.3,  z = 44.61}, -- 120KM/H ZONE
	{title="Speedcamera (120KM/H)", colour=1, id=1, x = 1818.54,	 y = 2016.51, z = 76.02}, -- 120KM/H ZONE
	{title="Speedcamera (120KM/H)", colour=1, id=1, x = -2468.64,	 y = -213.27, z = 17.48}, -- 120KM/H ZONE
	{title="Speedcamera (120KM/H)", colour=1, id=1, x = 1120.58, y = -1780.85,z = 28.87}, -- 120KM/H ZONE
	{title="Speedcamera (120KM/H)", colour=1, id=1, x = -2685.37,	 y = 2497.91, z = 16.69}, -- 120KM/H ZONE
	{title="Speedcamera (120KM/H)", colour=1, id=1, x = -1170.29,	 y = -660.68, z = 11.07}, -- 120KM/H ZONE
	{title="Speedcamera (120KM/H)", colour=1, id=1, x = -1649.99,	 y = -727.77, z = 11.41}, -- 120KM/H ZONE
	{title="Speedcamera (120KM/H)", colour=1, id=1, x = 724.82,	     y = -68.97,  z = 57.11}, -- 120KM/H ZONE
	{title="Speedcamera (120KM/H)", colour=1, id=1, x = -360.42,	 y = -2362.17,z = 62.95}, -- 120KM/H ZONE
	{title="Speedcamera (120KM/H)", colour=1, id=1, x = -396.59,	 y = -922.91, z = 37.19}, -- 120KM/H ZONE
	{title="Speedcamera (120KM/H)", colour=1, id=1, x = 871.69,	 	 y = -704.6,  z = 42.18}, -- 120KM/H ZONE
}

Citizen.CreateThread(function()
	for _, info in pairs(blips) do
		if useBlips == true then
			info.blip = AddBlipForCoord(info.x, info.y, info.z)
			SetBlipSprite(info.blip, 184)
			SetBlipDisplay(info.blip, 4)
			SetBlipScale(info.blip, 0.5)
			SetBlipColour(info.blip, info.colour)
			SetBlipAsShortRange(info.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(info.title)
			EndTextCommandSetBlipName(info.blip)
		end
	end
end)

-- BLIP FOR SPEEDCAMERA (END)
local Speedcamera60Zone = {
    {x = -524.2645,y = -1776.3569,z = 21.3384}
}

local Speedcamera80Zone = {
    {x = -90.11, 	y = 6275.83, z = 31.34 }, --paleto lane1 913
    {x = 224.8, 	y = -1049.2, z = 29.37 }, --حديقة الشهيد تقاطع1 حاره1
    {x = 1634.06, 	y = 2832.95, z = 39.81 }, --Route68 Lane1
    {x = 553.92, 	y = 3508.87, z = 34.17 }, --Joshua Rd Lane1 to west
    {x = 2237.26, 	y = 3826.22, z = 34.06 }, --East Joshua Rd Lane2 to west
    {x = -1487.09,  y = 1609.38, z = 108.12}, --Tongar Dr Lane2 to coccaain field
    {x = 312.28, 	y = 1006.34, z = 210.52},
	{x = -923.12,	y = -2323.47,z = 20.20 },  --Airport to LSIA
	{x = -385.01,	y = -379.46, z = 31.68 },  --mount zonta medical center
	{x = -861.60,	y = 2750.63, z = 23.23 }, 
	{x = 129.82,	y = -1618.25,z = 29.34 },
	{x = 724.50,	y = -2704.15,z = 7.57  },
	{x = 41.27,	 	y = -2040.09,z = 18.50 },
	{x = 1925.25, y = 3162.22,z = 46.28 },
    {x =  2541.27,	 y = 1700.01,  z = 26.91},
}

local Speedcamera120Zone = {
    {x = 1584.9281,	y = -993.4557,z = 59.3923},
    {x = 2442.2006,	y = -134.6004,z = 88.7765},
    {x = 2871.7951,	y = 3540.5795,z = 53.0930},
	{x = -1885.3, 	 y = 4641.18, z = 57.05},  --Great Ocean Hwy route1 23-24 	
    {x = 2457.96,	 y = 5637.3,  z = 44.61},  --Great Ocean Hwy route1 13-14
    {x = 1818.54,	 y = 2016.51, z = 76.02},  --LS FWY 5-12 - bridge toward sandy
    {x = -2468.64,	 y = -213.27, z = 17.48},  --Great Ocean Hwy 33-34 Lane2
    {x = 1120.58,	 y = -1780.85,z = 28.87},  
    {x = -2685.37,	 y = 2497.91, z = 16.69},  
    {x = -1170.29,	 y = -660.68, z = 11.07},  
    {x = -1649.99,	 y = -727.77, z = 11.41},  
    {x = 724.82,	 y = -68.97,  z = 57.11},  
    {x = -360.42,	 y = -2362.17,z = 62.95},  
    {x = -396.59,	 y = -922.91, z = 37.19},
    {x =  871.69,	 y = -704.6,  z = 42.18},
    {x=-797.85,y=5476.35,z=34.02},
	
}


local countInventoryRadar = 0

Citizen.CreateThread(function()
	while ESX == nil do
		Citizen.Wait(1000)
	end
	while true do
		if IsPedInAnyVehicle(GetPlayerPed(-1)) then
			
			local inventory = ESX.GetPlayerData().inventory
			
			for i=1, #inventory, 1 do
				if inventory[i].name == 'speedcamera_detector' then
					countInventoryRadar = inventory[i].count
				end
			end
			
			while IsPedInAnyVehicle(GetPlayerPed(-1)) do
				Citizen.Wait(3000)
			end
		else
			Citizen.Wait(3000)
		end
	end		
end)

-- Radar detector
Citizen.CreateThread(function() -- speedcamera_detector item
    exports.pNotify:SetQueueMax("left", 1)
	local extradist = 0.0
	
	while true do
		if IsPedInAnyVehicle(GetPlayerPed(-1)) then
			Wait(100)
			
			if countInventoryRadar >= 1 then
				if  GetEntitySpeed(GetPlayerPed(-1))*3.6 > 15.0 then
					--60 ZONE
					for k in pairs(Speedcamera60Zone) do
				
						local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
						local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Speedcamera60Zone[k].x, Speedcamera60Zone[k].y, Speedcamera60Zone[k].z)
						extradist = getdist()
						
						if dist <= Config.Detector.range60 + extradist then
							--TriggerServerEvent("InteractSound_SV:PlayOnSource", "speedcamera", 0.5)
							createblip({Speedcamera60Zone[k].x, Speedcamera60Zone[k].y, Speedcamera60Zone[k].z})
							exports.pNotify:SendNotification({
								text = "<font color=FFAE00 size=5><p align=center><b>انتبه!  كاميرا رادار 60 كم/س</font>",	   
									type = "alert",
									timeout = Config.Detector.timeout,
									layout = "centerleft",
									queue = "left",
									killer = true,
									sounds = {
											sources = {Config.Detector.soundfile}, -- For sounds to work, you place your sound in the html folder and then add it to the files array in the __resource.lua file.
											volume = Config.Detector.volume,
											conditions = {"docVisible"}
								}
							})
							Wait(15000)
						end
					end	
					
					--ZONE 80
					for k in pairs(Speedcamera80Zone) do
				
						local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
						local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Speedcamera80Zone[k].x, Speedcamera80Zone[k].y, Speedcamera80Zone[k].z)
						extradist = getdist()
						
						if dist <= Config.Detector.range80 + extradist then
							
							
							--if count > 0 then
								--TriggerServerEvent("InteractSound_SV:PlayOnSource", "speedcamera", 0.5)
								createblip({Speedcamera80Zone[k].x, Speedcamera80Zone[k].y, Speedcamera80Zone[k].z})
								exports.pNotify:SendNotification({
									text = "<font color=FFAE00 size=5><p align=center><b>انتبه!  كاميرا رادار 80 كم/س</font>",	   
										type = "alert",
										timeout = Config.Detector.timeout,
										layout = "centerleft",
										queue = "left",
										killer = true,
										sounds = {
												sources = {Config.Detector.soundfile}, -- For sounds to work, you place your sound in the html folder and then add it to the files array in the __resource.lua file.
												volume = Config.Detector.volume,
												conditions = {"docVisible"}
									}
								})
								Wait(15000)
							--end	
						end
					end
					
					-- 120 ZONE
					for k in pairs(Speedcamera120Zone) do
						local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
						local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Speedcamera120Zone[k].x, Speedcamera120Zone[k].y, Speedcamera120Zone[k].z)
						extradist = getdist()
						
						if dist <= Config.Detector.range120 + extradist then
							--TriggerServerEvent("InteractSound_SV:PlayOnSource", "speedcamera", 0.5)
							createblip({Speedcamera120Zone[k].x, Speedcamera120Zone[k].y, Speedcamera120Zone[k].z})
							exports.pNotify:SendNotification({
								text = "<font color=FFAE00 size=5><p align=center><b>انتبه!  كاميرا رادار 120 كم/س</font>",	   
									type = "alert",
									timeout = Config.Detector.timeout,
									layout = "centerleft",
									queue = "left",
									killer = true,
									sounds = {
											sources = {Config.Detector.soundfile}, -- For sounds to work, you place your sound in the html folder and then add it to the files array in the __resource.lua file.
											volume = Config.Detector.volume,
											conditions = {"docVisible"}
								}
							})
							Wait(15000)
						end
					end
				else
					Wait(1000)
				end
			else
				Wait(15000)
			end
		else
			Wait(3000)
		end	
	end	
end)

function createblip(coords)		
	Citizen.CreateThread(function()	
		local blip = AddBlipForCoord(coords[1], coords[2], coords[3])
		SetBlipSprite (blip, 184)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.0)
		SetBlipColour (blip, 1)
		SetBlipAsShortRange(blip, false)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Speed Camera')
		EndTextCommandSetBlipName(blip)
		Wait(14000)
		RemoveBlip(blip)
	end)	
end

function getdist()
	local SpeedKM = GetEntitySpeed(GetPlayerPed(-1))*3.6
	local dist = 0.0
	if SpeedKM >= 300.0 then
		dist = dist + 200.0
	elseif SpeedKM >= 250.0 then
		dist = dist + 150.0
	elseif SpeedKM >= 200.0 then
		dist = dist + 100.0
	elseif SpeedKM >= 150.0 then
		dist = dist + 80.0
	elseif SpeedKM >= 100.0 then
		dist = dist + 50.0
	end
	return dist
end

-- ZONE
Citizen.CreateThread(function()
    while true do
        if IsPedInAnyVehicle(GetPlayerPed(-1)) then
			Citizen.Wait(10)
			
			-- 60 ZONE
			for k in pairs(Speedcamera60Zone) do
	
				local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
				local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Speedcamera60Zone[k].x, Speedcamera60Zone[k].y, Speedcamera60Zone[k].z)
				
				if dist <= 20.0 then
					local playerPed = GetPlayerPed(-1)
					local playerCar = GetVehiclePedIsIn(playerPed, false)
					local veh = GetVehiclePedIsIn(playerPed)
					local SpeedKM = math.ceil(GetEntitySpeed(playerPed)*3.6)
					local maxSpeed = 60.0 -- THIS IS THE MAX SPEED IN KM/H
					
					local plate = GetVehicleNumberPlateText(veh)
					local driver = GetPedInVehicleSeat(playerCar, -1)
					local truespeed = SpeedKM			
					
					if SpeedKM > (maxSpeed + Config.ExtraSpeed) then
						if IsPedInAnyVehicle(playerPed, false) then
							if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then
								if hasBeenCaught == false then
									local class = GetVehicleClass(veh)
									if( class == 18) then
									-- VEHICLES ABOVE ARE BLACKLISTED
									else
										-- ALERT POLICE (START)
										if alertPolice == true then
											if SpeedKM > alertSpeed then
												local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
												TriggerServerEvent('esx_phone:send', 'police', 'كاميرا رادار...تم رصد مركبة سرعتها ' .. SpeedKM .. ' كم/س</br>'..plate..'لوحة: ', true, {x =x, y =y, z =z})
											end
										end
										-- ALERT POLICE (END)								
									
										-- FLASHING EFFECT (START)
										if useFlashingScreen == true then
											TriggerServerEvent('esx_speedcamera:openGUI')
										end
										
										if useCameraSound == true then
											TriggerServerEvent("InteractSound_SV:PlayOnSource", "speedcamera", 0.5)
										end
										
										if useFlashingScreen == true then
											Citizen.Wait(200)
											TriggerServerEvent('esx_speedcamera:closeGUI')
										end
										-- FLASHING EFFECT (END)								
										
	
										if truespeed >= 80 and truespeed < 90 then
											fineamount = Config.Fine.Zone60.no2
											finelevel = 'تجاوز حدود السرعة بما لايزيد عن 20 كم/س'
										elseif truespeed >= 90 and truespeed < 100 then
											fineamount = Config.Fine.Zone60.no3
											finelevel = 'تجاوز حدود السرعة بما لايزيد عن 30 كم/س'
										elseif truespeed >= 100 and truespeed < 110 then
											fineamount = Config.Fine.Zone60.no4
											finelevel = 'تجاوز حدود السرعة بما يزيد عن 40 كم/س'
										elseif truespeed > 110 then
											fineamount = Config.Fine.Zone60.no5
											finelevel = 'القيادة بسرعة جنونية في منطقة 60 كم/س'
										else
											fineamount = Config.Fine.Zone60.no1
											finelevel = 'تجاوز حدود السرعة بما لايزيد عن 10 كم/س'
										end     
										
										--TriggerEvent("pNotify:SendNotification", {text = "You've been caught by the speedcamera in a 60 zone!", type = "error", timeout = 5000, layout = "centerLeft"})
										
										exports.pNotify:SetQueueMax("right", 1)
										exports.pNotify:SendNotification({
																		text = "<h1><center><font color=E4E4E4><i>::: كـاميرا رادار :::</i></font></center></h1>" ..
																				"<font color=red size=5><p align=center><b>تم تحرير مخالفة بمباشرة</font>" ..
																				"</br><font size=3><p align=right>".."<font color=orange>" .. plate .. "</font>"	.."  :رقم اللوحة"..
																				"</br><font size=3><p align=right><b>قيمة المخالفة: "   .. "<font color=00EE4F>$ </font>"		.."<font color=orange>"..fineamount .."</font>"..
																				"</br><font size=3><p align=right><b>المخالفة: "        .. "<font color=orange>"	.. finelevel  	.."</font>"..
																				"</br><font size=3><p align=right><b>حدود السرعة: "     .. "<font color=00EE4F>"	.. maxSpeed  	.."</font>".. 
																				"</br><font size=5><p align=right><b>سرعتك: "           .. "<font color=red>"	.. SpeedKM ..
																				"<font color=yellow size=5><p align=center>تم سحب منك المبلغ بشكل تلقائي</font>",
																			type = "error",
																			timeout = 20000,
																			layout = "centerright",
																			queue = "right",
																			killer = true,
																			sounds = {
																					sources = {"camera.wav"}, -- For sounds to work, you place your sound in the html folder and then add it to the files array in the __resource.lua file.
																					volume = 0.6,
																					conditions = {"docVisible"}
																			}
										})
										
										if useBilling == true then
											TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_police', 'مخالفة حدود السرعة في منطقة <span style="color:#FF0E0E">60 </span>كم/س <span style="color:gray">- سرعتك: <span style="color:#FFAE00">'..SpeedKM..'</span>', fineamount) -- Sends a bill from the police
										else
											--TriggerServerEvent('esx_speedcamera:PayBill60Zone')
											TriggerServerEvent('esx_speedcamera:PayBill', fineamount)
										end
											
										hasBeenCaught = true
										Citizen.Wait(Config.DelayBeforeCaughtAgain) -- This is here to make sure the player won't get fined over and over again by the same camera!
									end
								end
							end
						end
						
						hasBeenCaught = false
					end
				end
			end
			
			-- 80 ZONE
			for k in pairs(Speedcamera80Zone) do
	
				local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
				local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Speedcamera80Zone[k].x, Speedcamera80Zone[k].y, Speedcamera80Zone[k].z)
	
				if dist <= 20.0 then
					local playerPed = GetPlayerPed(-1)
					local playerCar = GetVehiclePedIsIn(playerPed, false)
					local veh = GetVehiclePedIsIn(playerPed)
					local SpeedKM = math.ceil(GetEntitySpeed(playerPed)*3.6)
					local maxSpeed = 80.0 -- THIS IS THE MAX SPEED IN KM/H
					
					local plate = GetVehicleNumberPlateText(veh)
					local driver = GetPedInVehicleSeat(playerCar, -1)
					local truespeed = SpeedKM
					
					
					if SpeedKM > (maxSpeed + Config.ExtraSpeed) then
						if IsPedInAnyVehicle(playerPed, false) then
							if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then					
								if hasBeenCaught == false then
									local class = GetVehicleClass(veh)
									if( class == 18) then
									-- VEHICLES ABOVE ARE BLACKLISTED
									else
										-- ALERT POLICE (START)
										if alertPolice == true then
											if SpeedKM > alertSpeed then
												local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
												TriggerServerEvent('esx_phone:send', 'police', plate..'كاميرا رادار...تم رصد مركبة سرعتها ' .. SpeedKM .. ' كم/س', true, {x =x, y =y, z =z})
											end
										end
										-- ALERT POLICE (END)								
									
										-- FLASHING EFFECT (START)
										if useFlashingScreen == true then
											TriggerServerEvent('esx_speedcamera:openGUI')
										end
										
										if useCameraSound == true then
											TriggerServerEvent("InteractSound_SV:PlayOnSource", "speedcamera", 0.5)
										end
										
										if useFlashingScreen == true then
											Citizen.Wait(200)
											TriggerServerEvent('esx_speedcamera:closeGUI')
										end
										-- FLASHING EFFECT (END)								
										
										if truespeed >= 90 and truespeed < 100 then
											fineamount = Config.Fine.Zone80.no2
											finelevel = 'تجاوز حدود السرعة بما لايزيد عن 20 كم/س'
										elseif truespeed >= 100 and truespeed < 110 then
											fineamount = Config.Fine.Zone80.no3
											finelevel = 'تجاوز حدود السرعة بما لايزيد عن 30 كم/س'
										elseif truespeed >= 110 and truespeed < 120 then
											fineamount = Config.Fine.Zone80.no4
											finelevel = 'تجاوز حدود السرعة بما يزيد عن 40 كم/س'
										elseif truespeed > 120 then
											fineamount = Config.Fine.Zone80.no5
											finelevel = 'القيادة بسرعة جنونية في منطقة 80 كم/س'
										else
											fineamount = Config.Fine.Zone80.no1
											finelevel = 'تجاوز حدود السرعة بما لايزيد عن 10 كم/س'
										end     
										
										--TriggerEvent("pNotify:SendNotification", {text = "You've been caught by the speedcamera in a 80 zone!", type = "error", timeout = 5000, layout = "centerLeft"})
										
										exports.pNotify:SetQueueMax("right", 1)
										exports.pNotify:SendNotification({
																		text = "<h1><center><font color=E4E4E4><i>::: كـاميرا رادار :::</i></font></center></h1>" ..
																				"<font color=red size=5><p align=center><b>تم تحرير مخالفة بمباشرة</font>" ..
																				"</br><font size=3><p align=right>".."<font color=orange>" .. plate .. "</font>"	.."  :رقم اللوحة"..
																				"</br><font size=3><p align=right><b>قيمة المخالفة: "   .. "<font color=00EE4F>$ </font>"		.."<font color=orange>"..fineamount .."</font>"..
																				"</br><font size=3><p align=right><b>المخالفة: "        .. "<font color=orange>"	.. finelevel  	.."</font>"..
																				"</br><font size=3><p align=right><b>حدود السرعة: "     .. "<font color=00EE4F>"	.. maxSpeed  	.."</font>".. 
																				"</br><font size=5><p align=right><b>سرعتك: "           .. "<font color=red>"	.. SpeedKM ..
																				"<font color=yellow size=5><p align=center>تم سحب منك المبلغ بشكل تلقائي</font>",
																			type = "error",
																			timeout = 20000,
																			layout = "centerright",
																			queue = "right",
																			killer = true,
																			sounds = {
																					sources = {"camera.wav"}, -- For sounds to work, you place your sound in the html folder and then add it to the files array in the __resource.lua file.
																					volume = 0.6,
																					conditions = {"docVisible"}
																			}
										})
										
										if useBilling == true then
											TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_police', 'مخالفة حدود السرعة في منطقة <span style="color:#FF0E0E">80 </span>كم/س <span style="color:gray">- سرعتك: <span style="color:#FFAE00">'..SpeedKM..'</span>', fineamount) -- Sends a bill from the police
										else
											--TriggerServerEvent('esx_speedcamera:PayBill80Zone')
										    TriggerServerEvent('esx_speedcamera:PayBill', fineamount)
										end
											
										hasBeenCaught = true
										Citizen.Wait(Config.DelayBeforeCaughtAgain) -- This is here to make sure the player won't get fined over and over again by the same camera!
									end
								end
							end
						end
						
						hasBeenCaught = false
					end
				end
			end
			
			-- 120 ZONE
			for k in pairs(Speedcamera120Zone) do
	
				local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
				local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Speedcamera120Zone[k].x, Speedcamera120Zone[k].y, Speedcamera120Zone[k].z)
	
				if dist <= 30.0 then
					local playerPed = GetPlayerPed(-1)
					local playerCar = GetVehiclePedIsIn(playerPed, false)
					local veh = GetVehiclePedIsIn(playerPed)
					local SpeedKM = math.ceil(GetEntitySpeed(playerPed)*3.6)
					local maxSpeed = 120.0 -- THIS IS THE MAX SPEED IN KM/H
					
					local plate = GetVehicleNumberPlateText(veh)
					local driver = GetPedInVehicleSeat(playerCar, -1)
					local truespeed = SpeedKM
					
					if SpeedKM > (maxSpeed + Config.ExtraSpeed)then
						if IsPedInAnyVehicle(playerPed, false) then
							if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then 
								if hasBeenCaught == false then
									local class = GetVehicleClass(veh)
									if ( class == 18) then
									-- VEHICLES ABOVE ARE BLACKLISTED
									else
										-- ALERT POLICE (START)
										if alertPolice == true then
											if SpeedKM > alertSpeed then
												local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
												TriggerServerEvent('esx_phone:send', 'police', plate..'كاميرا رادار...تم رصد مركبة سرعتها ' .. SpeedKM .. ' كم/س', true, {x =x, y =y, z =z})
											end
										end
										-- ALERT POLICE (END)
									
										-- FLASHING EFFECT (START)
										if useFlashingScreen == true then
											TriggerServerEvent('esx_speedcamera:openGUI')
										end
										
										if useCameraSound == true then
											TriggerServerEvent("InteractSound_SV:PlayOnSource", "speedcamera", 0.5)
										end
										
										if useFlashingScreen == true then
											Citizen.Wait(200)
											TriggerServerEvent('esx_speedcamera:closeGUI')
										end
										-- FLASHING EFFECT (END)
										
	
										if truespeed >= 130 and truespeed < 140 then
											fineamount = Config.Fine.Zone120.no2
											finelevel = 'تجاوز حدود السرعة بما لايزيد عن 20 كم/س'
										elseif truespeed >= 140 and truespeed < 150 then
											fineamount = Config.Fine.Zone120.no3
											finelevel = 'تجاوز حدود السرعة بما لايزيد عن 30 كم/س'
										elseif truespeed >= 150 and truespeed < 160 then
											fineamount = Config.Fine.Zone120.no4
											finelevel = 'تجاوز حدود السرعة بما يزيد عن 40 كم/س'
										elseif truespeed >= 160 and truespeed < 200 then
											fineamount = Config.Fine.Zone120.no5
											finelevel = 'القيادة بسرعة قاتلة في منطقة 120 كم/س'
										elseif truespeed >= 200 and truespeed < 250 then
											fineamount = Config.Fine.Zone120.no6
											finelevel = 'القيادة بسرعة قاتلة في منطقة 120 كم/س'
										elseif truespeed >= 250 and truespeed < 300 then
											fineamount = Config.Fine.Zone120.no7
											finelevel = 'القيادة بسرعة قاتلة في منطقة 120 كم/س'		
										elseif truespeed > 300 then
											fineamount = Config.Fine.Zone120.no8
											finelevel = 'القيادة بسرعة قاتلة في منطقة 120 كم/س'	
										else
											fineamount = Config.Fine.Zone120.no1
											finelevel = 'تجاوز حدود السرعة بما لايزيد عن 10 كم/س'
										end     
	
										
										--TriggerEvent("pNotify:SendNotification", {text = "You've been caught by the speedcamera in a 120 zone!", type = "error", timeout = 5000, layout = "centerLeft"})
										
										exports.pNotify:SetQueueMax("right", 1)
										exports.pNotify:SendNotification({
																		text = "<h1><center><font color=E4E4E4><i>::: كـاميرا رادار :::</i></font></center></h1>" ..
																				"<font color=red size=5><p align=center><b>تم تحرير مخالفة بمباشرة</font>" ..
																				"</br><font size=3><p align=right>".."<font color=orange>" .. plate .. "</font>"	.."  :رقم اللوحة"..
																				"</br><font size=3><p align=right><b>قيمة المخالفة: "   .. "<font color=00EE4F>$ </font>"		.."<font color=orange>"..fineamount .."</font>"..
																				"</br><font size=3><p align=right><b>المخالفة: "        .. "<font color=orange>"	.. finelevel  	.."</font>"..
																				"</br><font size=3><p align=right><b>حدود السرعة: "     .. "<font color=00EE4F>"	.. maxSpeed  	.."</font>".. 
																				"</br><font size=5><p align=right><b>سرعتك: "           .. "<font color=red>"	.. SpeedKM ..
																				"<font color=yellow size=5><p align=center>تم سحب منك المبلغ بشكل تلقائي</font>",
																			type = "error",
																			timeout = 20000,
																			layout = "centerright",
																			queue = "right",
																			killer = true,
																			sounds = {
																					sources = {"camera.wav"}, -- For sounds to work, you place your sound in the html folder and then add it to the files array in the __resource.lua file.
																					volume = 0.6,
																					conditions = {"docVisible"}
																			}
										})
										
										if useBilling == true then
											TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_police', 'مخالفة حدود السرعة في منطقة <span style="color:#FF0E0E">120 </span>كم/س <span style="color:gray">- سرعتك: <span style="color:#FFAE00">'..SpeedKM..'</span>', fineamount) -- Sends a bill from the police
										else
											--TriggerServerEvent('esx_speedcamera:PayBill120Zone')
											TriggerServerEvent('esx_speedcamera:PayBill', fineamount)
										end
											
										hasBeenCaught = true
										Citizen.Wait(Config.DelayBeforeCaughtAgain) -- This is here to make sure the player won't get fined over and over again by the same camera!
									end
								end
							end
						end
						
						hasBeenCaught = false
					end
				end
			end
		
		else
			Citizen.Wait(3000)
		end
	end
end)

RegisterNetEvent('esx_speedcamera:openGUI')
AddEventHandler('esx_speedcamera:openGUI', function()
    SetNuiFocus(false,false)
    SendNUIMessage({type = 'openSpeedcamera'})
end)   

RegisterNetEvent('esx_speedcamera:closeGUI')
AddEventHandler('esx_speedcamera:closeGUI', function()
    SendNUIMessage({type = 'closeSpeedcamera'})
end)