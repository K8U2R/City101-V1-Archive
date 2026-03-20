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

local cokeQTE       			= 0
ESX 			    			= nil
local PlayerData = {}
--local LeoJobs = {'police','agent','admin','ambulance'}
local LeoJobs = {'police','agent','ambulance'}

local currentPort = 1
local currentZones = Config.Zones[currentPort]

local coke_poochQTE 			= 0
local weedQTE					= 0
local weed_poochQTE 			= 0
local methQTE					= 0
local meth_poochQTE 			= 0
local opiumQTE					= 0
local opium_poochQTE 			= 0
local myJob 					= nil
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local isInZone                  = false
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}

local cant_sell_drugs = false

local drugsBlips = {}

RegisterFontFile('sharlock')
fontId = RegisterFontId('sharlock')


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(500)
	end
	
	
	PlayerData = ESX.GetPlayerData()
	
	refreshBLips()	
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	
	deleteBlips()
	refreshBLips()
end)

RegisterNetEvent('esx_misc:currentPortNum')
AddEventHandler('esx_misc:currentPortNum', function(port)
	--print('# port number changed ['..port..']')
	currentPort = port
	currentZones = Config.Zones[currentPort]
	Citizen.Wait(1)
	deleteBlips()
	refreshBLips()
end)

RegisterNetEvent('esx_drugs:Update')
AddEventHandler('esx_drugs:Update', function(Update)
	cant_sell_drugs = Update
end)

AddEventHandler('esx_drugs:hasEnteredMarker', function(zone)
	--if myJob == 'police' or myJob == 'ambulance' or myJob == 'admin' or myJob == 'agent' then
	if myJob == 'police' or myJob == 'ambulance' or myJob == 'agent' then
		return
	end

	ESX.UI.Menu.CloseAll()
	
	if zone == 'exitMarker' then
		CurrentAction     = zone
		CurrentActionMsg  = _U('exit_marker')
		CurrentActionData = {}
	end
	
	if zone == 'CokeField' then
		CurrentAction     = zone
		CurrentActionMsg  = _U('press_collect_coke')
		CurrentActionData = {}
	end

	if zone == 'CokeProcessing' then
		if cokeQTE >= 5 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_process_coke')
			CurrentActionData = {}
		end
	end

	if zone == 'CokeDealer' then
		if coke_poochQTE >= 1 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_sell_coke')
			CurrentActionData = {}
		end
	end

	if zone == 'MethField' then
		CurrentAction     = zone
		CurrentActionMsg  = _U('press_collect_meth')
		CurrentActionData = {}
	end

	if zone == 'MethProcessing' then
		if methQTE >= 5 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_process_meth')
			CurrentActionData = {}
		end
	end

	if zone == 'MethDealer' then
		if meth_poochQTE >= 1 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_sell_meth')
			CurrentActionData = {}
		end
	end

	if zone == 'WeedField' then
		CurrentAction     = zone
		CurrentActionMsg  = _U('press_collect_weed')
		CurrentActionData = {}
	end

	if zone == 'WeedProcessing' then
		if weedQTE >= 5 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_process_weed')
			CurrentActionData = {}
		end
	end

	if zone == 'WeedDealer' then
		if weed_poochQTE >= 1 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_sell_weed')
			CurrentActionData = {}
		end
	end

	if zone == 'OpiumField' then
		CurrentAction     = zone
		CurrentActionMsg  = _U('press_collect_opium')
		CurrentActionData = {}
	end

	if zone == 'OpiumProcessing' then
		if opiumQTE >= 5 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_process_opium')
			CurrentActionData = {}
		end
	end

	if zone == 'OpiumDealer' then
		if opium_poochQTE >= 1 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_sell_opium')
			CurrentActionData = {}
		end
	end
end)


AddEventHandler('esx_drugs:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()

	TriggerServerEvent('esx_K6dr2H2ugs:Server', 'Stop')
end)


-- Weed Effect
RegisterNetEvent('esx_drugs:onPot')
AddEventHandler('esx_drugs:onPot', function()
	RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
	while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
		Citizen.Wait(0)
	end
	TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_SMOKING_POT", 0, true)
	Citizen.Wait(10000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	SetTimecycleModifier("spectator5")
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(GetPlayerPed(-1), true)
	DoScreenFadeIn(1000)
	Citizen.Wait(600000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	ResetPedMovementClipset(GetPlayerPed(-1), 0)
	SetPedIsDrunk(GetPlayerPed(-1), false)
	SetPedMotionBlur(GetPlayerPed(-1), false)
end)

-- Opium Effect
RegisterNetEvent('esx_drugs:onOpium')
AddEventHandler('esx_drugs:onOpium', function()
	RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
	while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
		Citizen.Wait(0)
	end
	TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_SMOKING_POT", 0, true)
	Citizen.Wait(10000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	SetTimecycleModifier("spectator5")
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(GetPlayerPed(-1), true)
	DoScreenFadeIn(1000)
	Citizen.Wait(600000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	ResetPedMovementClipset(GetPlayerPed(-1), 0)
	SetPedIsDrunk(GetPlayerPed(-1), false)
	SetPedMotionBlur(GetPlayerPed(-1), false)
end)

-- Meth Effect
RegisterNetEvent('esx_drugs:onMeth')
AddEventHandler('esx_drugs:onMeth', function()
	RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
	while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
		Citizen.Wait(0)
	end
	TaskStartScenarioInPlace(GetPlayerPed(-1), "mp_player_intdrink", 0, true)
	Citizen.Wait(10000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	SetTimecycleModifier("spectator5")
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(GetPlayerPed(-1), true)
	DoScreenFadeIn(1000)
	Citizen.Wait(600000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	ResetPedMovementClipset(GetPlayerPed(-1), 0)
	SetPedIsDrunk(GetPlayerPed(-1), false)
	SetPedMotionBlur(GetPlayerPed(-1), false)
end)

-- Coke Effect
RegisterNetEvent('esx_drugs:onCoke')
AddEventHandler('esx_drugs:onCoke', function()
	RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
	while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
		Citizen.Wait(0)
	end
	TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_SMOKING_POT", 0, true)
	Citizen.Wait(10000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	SetTimecycleModifier("spectator5")
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(GetPlayerPed(-1), true)
	DoScreenFadeIn(1000)
	Citizen.Wait(600000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	ResetPedMovementClipset(GetPlayerPed(-1), 0)
	SetPedIsDrunk(GetPlayerPed(-1), false)
	SetPedMotionBlur(GetPlayerPed(-1), false)
end)

local draw = false
-- Render markers
function refreshDrawMarker()
	while ESX == nil or PlayerData == nil do
		Citizen.Wait(5)
	end
	
	local sleep = 0
	
	Citizen.CreateThread(function()
		while drugsBlips[1] ~= nil do
			
			local coords = GetEntityCoords(GetPlayerPed(-1))
			draw = false
			
			for k,v in pairs(currentZones) do
				local dist = GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true)
				if dist < Config.DrawDistance then
					if v.MarkerType ~= -1 then
						DrawMarker(v.MarkerType, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.ZoneSize.x, v.ZoneSize.y, v.ZoneSize.z, v.MarkerColor.r, v.MarkerColor.g, v.MarkerColor.b, v.Opacity, false, true, 2, v.Rotate, false, false, false)
					end
					draw = true
				end
			end
			
			if draw then
				sleep = 1
			else
				sleep = 5
			end
			
			Citizen.Wait(sleep)
		end
	end)
end

-- Create blips
function refreshBLips()
	while ESX == nil or PlayerData.job == nil do
		Citizen.Wait(500)
	end
	
	if Config.ShowBlips then
		if not isLoeJob() then
			for k,v in pairs(currentZones) do
				local blip = AddBlipForCoord(v.x, v.y, v.z)
				
				SetBlipSprite (blip, v.sprite)
				SetBlipDisplay(blip, 4)
				SetBlipScale  (blip, 0.9)
				SetBlipColour (blip, v.color)
				SetBlipAsShortRange(blip, true)
				
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(v.name)
				EndTextCommandSetBlipName(blip)
				table.insert(drugsBlips, blip)
			end
		end	
	end
	refreshDrawMarker()
end

--check if player job is leo
function isLoeJob()
	while PlayerData == nil do
		Citizen.Wait(500)
	end
	
	local check = false
	
	for i=1, #LeoJobs, 1 do
		if PlayerData.job.name == LeoJobs[i] then
			check = true
			break
		end
	end

	if check then
		return true
	else
		return false
	end
end	







function deleteBlips()
	if drugsBlips[1] ~= nil then
		for i=1, #drugsBlips, 1 do
			RemoveBlip(drugsBlips[i])
			drugsBlips[i] = nil
		end
	end
end

-- RETURN NUMBER OF ITEMS FROM SERVER
RegisterNetEvent('esx_drugs:ReturnInventory')
AddEventHandler('esx_drugs:ReturnInventory', function(cokeNbr, cokepNbr, methNbr, methpNbr, weedNbr, weedpNbr, opiumNbr, opiumpNbr, jobName, currentZone)
	cokeQTE	   = cokeNbr
	coke_poochQTE = cokepNbr
	methQTE 	  = methNbr
	meth_poochQTE = methpNbr
	weedQTE 	  = weedNbr
	weed_poochQTE = weedpNbr
	opiumQTE	   = opiumNbr
	opium_poochQTE = opiumpNbr
	myJob		 = jobName
	TriggerEvent('esx_drugs:hasEnteredMarker', currentZone)
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

			for k,v in pairs(currentZones) do
				if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.ZoneSize.x / 2) then
					isInMarker  = true
					currentZone = k
				end
			end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			lastZone				= currentZone
			TriggerServerEvent('esx_K20drugs:GetUserInventory_H', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_drugs:hasExitedMarker', lastZone)
		end

		if isInMarker and isInZone then
			TriggerEvent('esx_drugs:hasEnteredMarker', 'exitMarker')
		end
	end
end)

--[[
-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local data = exports.esx_misc:isNoCrimetime() --return table with 3 values {active(boolen),location,label}
		
		if CurrentAction ~= nil then
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)
			if IsControlJustReleased(0, Keys['E']) and IsPedOnFoot(PlayerPedId()) then
                    if exports['Peace']:GetStatusPeace() then 
						ESX.ShowNotification('<font color=purple>يمنع الأجرام في وقت الراحة</font>')
					else			
				if CurrentAction == 'exitMarker' then
					TriggerEvent('esx_drugs:hasExitedMarker', lastZone)
					Citizen.Wait(1000)
				elseif CurrentAction == 'CokeField' then
					TriggerServerEvent('esx_K6dr2H2ugs:Server', 'startHarvest', 'Coke')
				elseif CurrentAction == 'CokeProcessing' then
					TriggerServerEvent('esx_K6dr2H2ugs:Server', 'startTransFromDrug', 'Coke')
				elseif CurrentAction == 'CokeDealer' then
					if data.active and (data.location == 'sea_port_close' or data.location == 'internationa_close' or data.location == 'seaport_west_close') then
			        --print('# 1')
			        ESX.ShowNotification('لايمكن البيع اثناء اعلان</br><font color=gray>اغلاق '..data.label)
		            else
					if cant_sell_drugs then
					ESX.ShowNotification('<font color=white> لايمكنك البيع . التهريب مغلق من</font> <font color=red>الرقابة و التفتيش</font>')
                    else					
					TriggerServerEvent('esx_K6dr2H2ugs:Server', 'startSell', 'Coke')
					end
					end
				elseif CurrentAction == 'MethField' then
					TriggerServerEvent('esx_K6dr2H2ugs:Server', 'startHarvest', 'Meth')
				elseif CurrentAction == 'MethProcessing' then
					TriggerServerEvent('esx_K6dr2H2ugs:Server', 'startTransFromDrug', 'Meth')
				elseif CurrentAction == 'MethDealer' then
					if data.active and (data.location == 'sea_port_close' or data.location == 'internationa_close' or data.location == 'seaport_west_close') then
			        --print('# 1')
			        ESX.ShowNotification('لايمكن البيع اثناء اعلان</br><font color=gray>اغلاق '..data.label)
		           else
					if cant_sell_drugs then
					ESX.ShowNotification('<font color=white> لايمكنك البيع . التهريب مغلق من</font> <font color=red>الرقابة و التفتيش</font>')
					else
					TriggerServerEvent('esx_K6dr2H2ugs:Server', 'startSell', 'Meth')
					end
					end
				elseif CurrentAction == 'WeedField' then
					TriggerServerEvent('esx_K6dr2H2ugs:Server', 'startHarvest', 'Weed')
					--TriggerEvent('esx_drugs:HarvestWeedAnimation')
				elseif CurrentAction == 'WeedProcessing' then
					TriggerServerEvent('esx_K6dr2H2ugs:Server', 'startTransFromDrug', 'Weed')
				--	TriggerEvent('esx_drugs:TransformWeedAnimation')
				elseif CurrentAction == 'WeedDealer' then
					if data.active and (data.location == 'sea_port_close' or data.location == 'internationa_close' or data.location == 'seaport_west_close') then
			        --print('# 1')
			        ESX.ShowNotification('لايمكن البيع اثناء اعلان</br><font color=gray>اغلاق '..data.label)
		           else
					if cant_sell_drugs then
					ESX.ShowNotification('<font color=white> لايمكنك البيع . التهريب مغلق من</font> <font color=red>الرقابة و التفتيش</font>')
                    else					
					TriggerServerEvent('esx_K6dr2H2ugs:Server', 'startSell', 'Weed')
					end
					end
					--TriggerEvent('esx_drugs:SellWeedAnimation')
				elseif CurrentAction == 'OpiumField' then
					TriggerServerEvent('esx_K6dr2H2ugs:Server', 'startHarvest', 'Opium')
				elseif CurrentAction == 'OpiumProcessing' then
					TriggerServerEvent('esx_K6dr2H2ugs:Server', 'startTransFromDrug', 'Opium')
				elseif CurrentAction == 'OpiumDealer' then
					if data.active and (data.location == 'sea_port_close' or data.location == 'internationa_close' or data.location == 'seaport_west_close') then
			        --print('# 1')
			        ESX.ShowNotification('لايمكن البيع اثناء اعلان</br><font color=gray>اغلاق '..data.label)
		           else
					if cant_sell_drugs then
					ESX.ShowNotification('<font color=white> لايمكنك البيع . التهريب مغلق من</font> <font color=red>الرقابة و التفتيش</font>')
                    else						
					TriggerServerEvent('esx_K6dr2H2ugs:Server', 'startSell', 'Opium')
					end
					end
				else
					isInZone = false -- not a esx_drugs zone
				end
				CurrentAction = nil
			end
			end
		end
	end
end)]]
local cansell = true
-- Key Controls
Citizen.CreateThread(function()
	while true do
		if draw then
			Citizen.Wait(10)
			if CurrentAction ~= nil then
				ESX.ShowHelpNotification(CurrentActionMsg)
	
				if IsControlJustReleased(0, Keys['E']) and IsPedOnFoot(PlayerPedId()) then
					
					local data = exports.esx_misc:isNoCrimetime2() --return table with 3 values {active(boolen),location,label}
					local data2 = exports.esx_misc:isNoCrimetime2() --return table with 3 values {active(boolen),name,label}
					
					if data.active and data.location == 'peace_time' then
						--print('# 1')
						ESX.ShowNotification('لايمكن العمل بالممنوعات اثناء اعلان</br><font color=B748E2>'..data.label)
					elseif data.active and data.location == 'restart_time' then
					    ESX.ShowNotification('لايمكن العمل بالممنوعات اثناء اعلان</br><font color=red>'..data.label)
					else
					
						if CurrentAction == 'CokeField' then
							if exports.ESX_SystemXpLevel.ESXP_GetRank() >= Config.Cokexp then
								TriggerServerEvent('esx_K6dr2H2ugs:Server', 'startHarvest', 'Coke')
							else
								ESX.ShowNotification('مستواك اقل من <span style="color:#ff0000;">'..Config.Cokexp..'</span>')
							end
						elseif CurrentAction == 'CokeProcessing' then
							if exports.ESX_SystemXpLevel.ESXP_GetRank() >= Config.Cokexp then
								TriggerServerEvent('esx_K6dr2H2ugs:Server', 'startTransFromDrug', 'Coke')
							else
								ESX.ShowNotification('مستواك اقل من <span style="color:#ff0000;">'..Config.Cokexp..'</span>')
							end
						elseif CurrentAction == 'MethField' then
							if exports.ESX_SystemXpLevel.ESXP_GetRank() >= Config.Methxp then
								TriggerServerEvent('esx_K6dr2H2ugs:Server', 'startHarvest', 'Meth')
							else
								ESX.ShowNotification('مستواك اقل من <span style="color:#ff0000;">'..Config.Methxp..'</span>')
							end
						elseif CurrentAction == 'MethProcessing' then
							if exports.ESX_SystemXpLevel.ESXP_GetRank() >= Config.Methxp then
								TriggerServerEvent('esx_K6dr2H2ugs:Server', 'startTransFromDrug', 'Meth')
							else
								ESX.ShowNotification('مستواك اقل من <span style="color:#ff0000;">'..Config.Methxp..'</span>')
							end
						elseif CurrentAction == 'WeedField' then
							if exports.ESX_SystemXpLevel.ESXP_GetRank() >= Config.weedxp then
								TriggerServerEvent('esx_K6dr2H2ugs:Server', 'startHarvest', 'Weed')
							else
								ESX.ShowNotification('مستواك اقل من <span style="color:#ff0000;">'..Config.weedxp..'</span>')
							end
						elseif CurrentAction == 'WeedProcessing' then
							if exports.ESX_SystemXpLevel.ESXP_GetRank() >= Config.weedxp then
								TriggerServerEvent('esx_K6dr2H2ugs:Server', 'startTransFromDrug', 'Weed')
							else
								ESX.ShowNotification('مستواك اقل من <span style="color:#ff0000;">'..Config.weedxp..'</span>')
							end
						elseif CurrentAction == 'OpiumField' then
							if exports.ESX_SystemXpLevel.ESXP_GetRank() >= Config.Opiumxp then
								TriggerServerEvent('esx_K6dr2H2ugs:Server', 'startHarvest', 'Opium')
							else
								ESX.ShowNotification('مستواك اقل من <span style="color:#ff0000;">'..Config.Opiumxp..'</span>')
							end
						elseif CurrentAction == 'OpiumProcessing' then
							if exports.ESX_SystemXpLevel.ESXP_GetRank() >= Config.Opiumxp then
								TriggerServerEvent('esx_K6dr2H2ugs:Server', 'startTransFromDrug', 'Opium')
							else
								ESX.ShowNotification('مستواك اقل من <span style="color:#ff0000;">'..Config.Opiumxp..'</span>')
							end
						elseif data.active and data.location == 'sea_port_close' or data.location == 'internationa_close' or data.location == 'seaport_west_close' then
							--print('# 2')
							ESX.ShowNotification('لايمكن بيع الممنوعات اثناء اعلان</br><font color=gray>اغلاق '..data2.label)
						elseif data2.active and data2.location == 'NoCrimetime' or data2.location == 'SellDrugs' then
						    ESX.ShowNotification('لايمكن بيع الممنوعات اثناء اعلان</br><font color=red> '..data2.label)
						else	
						    ESX.TriggerServerCallback('esx_misc:getstatusselldrugs', function(check_is_t)
								if check_is_t.is_is_is  then 
									cansell = false
								else
									cansell = true
								end
							end)
							if cansell then 
								if CurrentAction == 'WeedDealer' then
									if exports.ESX_SystemXpLevel.ESXP_GetRank() >= Config.weedxp then
										TriggerServerEvent('esx_K6dr2H2ugs:Server', 'startSell', 'Weed')
									else
										ESX.ShowNotification('مستواك اقل من <span style="color:#ff0000;">'.. Config.weedxp ..'</span>')
									end
								elseif CurrentAction == 'OpiumDealer' then
									if exports.ESX_SystemXpLevel.ESXP_GetRank() >= Config.Opiumxp then
										TriggerServerEvent('esx_K6dr2H2ugs:Server', 'startSell', 'Opium')
									else
										ESX.ShowNotification('مستواك اقل من <span style="color:#ff0000;">'.. Config.Opiumxp ..'</span>')
									end
								elseif CurrentAction == 'CokeDealer' then
									if exports.ESX_SystemXpLevel.ESXP_GetRank() >= Config.Cokexp then
										TriggerServerEvent('esx_K6dr2H2ugs:Server', 'startSell', 'Coke')
									else
										ESX.ShowNotification('مستواك اقل من <span style="color:#ff0000;">'.. Config.Cokexp ..'</span>')
									end
								elseif CurrentAction == 'MethDealer' then
									if exports.ESX_SystemXpLevel.ESXP_GetRank() >= Config.Methxp then
										TriggerServerEvent('esx_K6dr2H2ugs:Server', 'startSell', 'Meth')
									else
										ESX.ShowNotification('مستواك اقل من <span style="color:#ff0000;">'.. Config.Methxp ..'</span>')
									end
								end	
							else
								ESX.ShowNotification(' <span style="color:#ff0000;">لايمكن التهريب في وقت منع التهريب</span>')
							end
						end
					
					end
					
					CurrentAction = nil
				end
			end
		else
			Citizen.Wait(3000)
		end
	end
end)

local function DisplayScaleform(title, description, time)
    if time == nil then time = 4000 end
    Citizen.CreateThread(function()
      local scaleform = RequestScaleformMovie("mp_big_message_freemode")
      while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
      end
    
      BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
      PushScaleformMovieMethodParameterString(title)
      PushScaleformMovieMethodParameterString(description)
      PushScaleformMovieMethodParameterInt(5)
      EndScaleformMovieMethod()
      
      local show = true
      Citizen.SetTimeout(4000, function()
        show = false
      end)
    
      while show do
        Citizen.Wait(0)
        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255) -- Draw the scaleform fullscreen
      end
    end)
end

RegisterNetEvent("SalvzTurki:esx_drugs:cantselldrugs_cl_aldih376")
AddEventHandler("SalvzTurki:esx_drugs:cantselldrugs_cl_aldih376", function(selldrugs)
    cant_sell_drugs = selldrugs
	TriggerEvent("esx_misc:watermark_promotion", 'selldrugs', selldrugs)
	if cant_sell_drugs then
	    PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
        DisplayScaleform("<FONT FACE='sharlock'>~w~ﻖﻠﻐﻣ ﺐﻳﺮﻬﺘﻟﺍ", "<FONT FACE='sharlock'>~r~ﻥﻷﺍ ﺀﺎﻨﻴﻤﻟﺎﺑ ﺕﺍﺭﺪﺨﻤﻟﺍ ﺐﻳﺮﻬﺗ ﻦﻜﻤﻳ ﻻ ﻖﻠﻐﻣ ﺐﻳﺮﻬﺘﻟﺍ</font>")
	else
        PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
        DisplayScaleform("<FONT FACE='sharlock'>~w~ﺡﺎﺘﻣ ﺐﻳﺮﻬﺘﻟﺍ", "<FONT FACE='sharlock'>~g~ﻥﻷﺍ ﺀﺎﻨﻴﻤﻟﺎﺑ ﺕﺍﺭﺪﺨﻤﻟﺍ ﺐﻳﺮﻬﺗ ﻦﻜﻤﻳ ﺡﺎﺘﻣ ﺐﻳﺮﻬﺘﻟﺍ</font>")
	end
end)

----------------------------------------------------------
--------------------HARVEST WEED ANIMATION----------------
----------------------------------------------------------
RegisterNetEvent('esx_drugs:HarvestWeedAnimation')
AddEventHandler('esx_drugs:HarvestWeedAnimation', function()
    local ped = GetPlayerPed(-1)
	local x,y,z = table.unpack(GetEntityCoords(playerPed, true))
    if not IsEntityPlayingAnim(ped, "anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_stand_checkingleaves_kneeling_01_inspector", 3) then
        RequestAnimDict("anim@amb@business@weed@weed_inspecting_lo_med_hi@")
        while not HasAnimDictLoaded("anim@amb@business@weed@weed_inspecting_lo_med_hi@") do
            Citizen.Wait(100)
        end
		SetEntityCoords(PlayerPedId(), 2094.31, 4918.51, 41.04)
        SetEntityHeading(PlayerPedId(), 227.87)
        Wait(100)
        TaskPlayAnim(ped, "anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_stand_checkingleaves_kneeling_01_inspector", 8.0, -8, -1, 49, 0, 0, 0, 0)
        Wait(2000)
        while IsEntityPlayingAnim(ped, "anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_stand_checkingleaves_kneeling_01_inspector", 3) do
            Wait(1)
            if (IsControlPressed(0, 32) or IsControlPressed(0, 33) or IsControlPressed(0, 34) or IsControlPressed(0, 35)) then
                ClearPedTasksImmediately(ped)
                break
            end
        end
    end
end)
----------------------------------------------------------
--------------------HARVEST WEED ANIMATION----------------
----------------------------------------------------------


----------------------------------------------------------
--------------------TRANSFORM WEED ANIMATION--------------
----------------------------------------------------------
RegisterNetEvent('esx_drugs:TransformWeedAnimation')
AddEventHandler('esx_drugs:TransformWeedAnimation', function()
    local ped = GetPlayerPed(-1)
	local x,y,z = table.unpack(GetEntityCoords(playerPed, true))
    if not IsEntityPlayingAnim(ped, "anim@amb@business@weed@weed_sorting_seated@", "sorter_right_sort_v3_sorter02", 3) then
        RequestAnimDict("anim@amb@business@weed@weed_sorting_seated@")
        while not HasAnimDictLoaded("anim@amb@business@weed@weed_sorting_seated@") do
            Citizen.Wait(100)
        end
		SetEntityCoords(PlayerPedId(), -1368.09, -318.305, 39.516)
        SetEntityHeading(PlayerPedId(), 293.52)
        Wait(100)
        ----TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_SEAT_CHAIR", 0, false) ---Does not work
        TaskPlayAnim(ped, "anim@amb@business@weed@weed_sorting_seated@", "sorter_right_sort_v3_sorter02", 8.0, -8, -1, 49, 0, 0, 0, 0)
        Wait(2000)
        while IsEntityPlayingAnim(ped, "anim@amb@business@weed@weed_sorting_seated@", "sorter_right_sort_v3_sorter02", 3) do
            Wait(1)
            if (IsControlPressed(0, 32) or IsControlPressed(0, 33) or IsControlPressed(0, 34) or IsControlPressed(0, 35)) then
                ClearPedTasksImmediately(ped)
                break
            end
        end
    end
end)
----------------------------------------------------------
--------------------TRANSFORM WEED ANIMATION--------------
----------------------------------------------------------



----------------------------------------------------------
--------------------SELL WEED ANIMATION-------------------
----------------------------------------------------------
--[[RegisterNetEvent('esx_drugs:SellWeedAnimation')
AddEventHandler('esx_drugs:SellWeedAnimation', function()
    local ped = GetPlayerPed(-1)
	local x,y,z = table.unpack(GetEntityCoords(playerPed, true))
    if not IsEntityPlayingAnim(ped, "anim@heists@biolab@ig_1_karen_codes", "handover_cam", 3) then
        RequestAnimDict("anim@heists@money_grab@briefcase")
        while not HasAnimDictLoaded("anim@heists@money_grab@briefcase") do
            Citizen.Wait(100)
        end
		--SetEntityCoords(PlayerPedId(), 1037.53, -3205.37, -39.18)
        --SetEntityHeading(PlayerPedId(), 269.5)
        --Wait(100)
        ----TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_SEAT_CHAIR", 0, false) ---Does not work
        TaskPlayAnim(ped, "anim@heists@money_grab@briefcase", "handover_cam", 8.0, -8, -1, 49, 0, 0, 0, 0)
        Wait(2000)
        while IsEntityPlayingAnim(ped, "anim@heists@money_grab@briefcase", "handover_cam", 3) do
            Wait(1)
            if (IsControlPressed(0, 32) or IsControlPressed(0, 33) or IsControlPressed(0, 34) or IsControlPressed(0, 35)) then
                ClearPedTasksImmediately(ped)
                break
            end
        end
    end
end)]]--
----------------------------------------------------------
--------------------SELL WEED ANIMATION-------------------
----------------------------------------------------------


-- Disable Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerPed = PlayerPedId(-1)

		if HasAlreadyEnteredMarker then
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
		else
			Citizen.Wait(500)
		end
	end
end)
