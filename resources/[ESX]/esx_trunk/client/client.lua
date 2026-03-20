Keys = {
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


local refreshtime = 400
local OpenInventoryboolean = false
local OpenInventoryVboolean = false

local controlCount = 0 -- dont change it
Citizen.CreateThread( function()
	while true do
		Citizen.Wait(300)
		controlCount = 0
	end
end)

Citizen.CreateThread( function()
	while true do
		Citizen.Wait(1)
		if IsControlJustReleased(0, Keys['L']) then
			local playerPed = PlayerPedId()
			local PlayerLocation = GetEntityCoords(playerPed)
			local veh, distance  = ESX.Game.GetClosestVehicle(PlayerLocation)
			if DoesEntityExist(veh) then
				if IsPedInAnyVehicle(playerPed, false) then
					--ESX.ShowNotification('<font color=red>لا يمكن فتح الشنطة داخل المركبة</font>')
				else
					local health         = GetVehicleEngineHealth(veh)
					if health > 0.0 then
						local vehState       = GetVehicleDoorLockStatus(veh)
						if vehState == 1 then
							local class          = GetVehicleClass(veh)
							if class == 10 then -- bigger distance
								if distance <= 4.0 then
									local plate          = GetVehicleNumberPlateText(veh)
									local model          = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
									OpenInventoryV(plate, model, veh)
								end
							else
								if distance <= 2.2 then
									local plate          = GetVehicleNumberPlateText(veh)
									local model          = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
									OpenInventoryV(plate, model, veh)
								end
							end
						else
							ESX.ShowNotification('الشنطة. المركبة مغلقة')
						end
					else
						ESX.ShowNotification('<font color=red>لا يمكن فتح شنطة مركبة متضررة</font>')
					end
				end
			end
		end
	end
end)

local dkdjjfjfjf = 0

Citizen.CreateThread( function()
	while true do
		Citizen.Wait(1)
		if dkdjjfjfjf > 0 then
			Citizen.Wait(1000)
			dkdjjfjfjf = dkdjjfjfjf - 1
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread( function()
	while true do
		Citizen.Wait(1)
		--close and open doors
		if IsControlJustReleased(0, Keys['E']) then
			controlCount = controlCount + 1
			if controlCount >= 2 then
				local playerPed = PlayerPedId()
				local PlayerLocation = GetEntityCoords(playerPed)
				local veh, distance  = ESX.Game.GetClosestVehicle(PlayerLocation)
				if DoesEntityExist(veh) and dkdjjfjfjf == 0 then
					if not IsPedInAnyVehicle(playerPed, false) then
						local class = GetVehicleClass(veh)
						if class == 10 then -- bigger distance
							if distance <= 4.0 then
								local plate = GetVehicleNumberPlateText(veh)
								CloseAndOpenVehicleDoors(veh, plate)
								dkdjjfjfjf = 1
							end
						else
							if distance <= 2.2 then
								local plate = GetVehicleNumberPlateText(veh)
								CloseAndOpenVehicleDoors(veh, plate)
								dkdjjfjfjf = 1
							end
						end
					end
				end
			end
		end
	end
end)

function CloseAndOpenVehicleDoors(veh, plate)
	-- plate = 'WOKE 292 '
	-- playerPlate[i] = 'WOKE 292' without space
	ESX.TriggerServerCallback('esx_trunk:canCLoseDoORs', function(CanOpen)
		plate = string.gsub(plate, " ", "")
		local playerPlate = exports.esx_jobs:GetWorkVehicles()
		if playerPlate[1] then
			for i = 1, #playerPlate, 1 do
				if CanOpen or tostring(playerPlate[i]) == plate then
					local vehState = GetVehicleDoorLockStatus(veh)
					if vehState > 2 then
						SetVehicleDoorsLocked(veh, 1)
						SetVehicleDoorsLockedForAllPlayers(veh, false)
						playHornSound(veh, false)
						drawTxt(0.5,0.5 ,0.4, 'ﺔﺒﻛﺮﻤﻟﺍ ﺢﺘﻓ', 0,255,0,255)
					elseif vehState <= 2 then
						SetVehicleDoorsLocked(veh, 4)
						SetVehicleDoorsLockedForAllPlayers(veh, 1)
						playHornSound(veh, true)
						drawTxt(0.5,0.5 ,0.4, 'ﺔﺒﻛﺮﻤﻟﺍ ﻞﻔﻗ', 255,0,0,255)
					end
				end
			end
		else
			if CanOpen then
				local vehState = GetVehicleDoorLockStatus(veh)
				if vehState > 2 then
					SetVehicleDoorsLocked(veh, 1)
					SetVehicleDoorsLockedForAllPlayers(veh, false)
					playHornSound(veh, false)
					drawTxt(0.5,0.5 ,0.4, 'ﺔﺒﻛﺮﻤﻟﺍ ﺢﺘﻓ', 0,255,0,255)
				elseif vehState <= 2 then
					SetVehicleDoorsLocked(veh, 4)
					SetVehicleDoorsLockedForAllPlayers(veh, 1)
					playHornSound(veh, true)
					drawTxt(0.5,0.5 ,0.4, 'ﺔﺒﻛﺮﻤﻟﺍ ﻞﻔﻗ', 255,0,0,255)
				end
			end
		end
	end, plate)         
end

function GetWeightModel(model)

	for k,v in pairs(Config.WeightModel) do
		if string.lower(k) == string.lower(model) then
			return v
		end
	end

	return Config.DefaultWeightModel
end

--player invetory
function OpenInventory(plate, CarMaxWeight, CarWeight, veh)
	ESX.TriggerServerCallback('esx_trunk:showItemsPlayeyHave', function(inventory)
		local elements = {}
		table.insert(elements, { label = '<font color=red>:::::: العودة لشنطة المركبة ::::::</font>', value = 'OpenInventoryV', type = 'OpenInventoryV' })
		if inventory.blackMoney ~= false then
			table.insert(elements, { label = '<font color=red>أموال غير شرعية</font>: <font color=green> $'..tostring(ESX.Math.GroupDigits(inventory.blackMoney))..'</font><font color=orange> ('..(Config.BlackMoneyWeight*inventory.blackMoney)..' كجم) </font>', value = '', type = 'black_money' , ammo = '', weight = Config.BlackMoneyWeight})
		end
		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]
			if item.count > 0 then
				table.insert(elements, {label = item.label..' x'..item.count..'<font color=orange> ('..(1*item.count)..' كجم) </font>', value = item.name, type = 'item', ammo = '', weight = 1})
			end
		end
		local playerPed  = PlayerPedId()
		local weaponList = ESX.GetWeaponList()
		for i=1, #weaponList, 1 do
		  local weaponHash = GetHashKey(weaponList[i].name)
		  	if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
				local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
				table.insert(elements, {label = weaponList[i].label .. ' <font color=gray>[' .. ammo .. ']</font> طلقة <font color=orange>('..Config.WeaponsWeight..' كجم) </font>', value = weaponList[i].name, type = 'weapon', ammo = ammo, weight = Config.WeaponsWeight})
			end
		end

		if inventory.CanOpen then
				OpenInventoryboolean = true
				ESX.UI.Menu.Open( 'default', GetCurrentResourceName(), 'trunk_1', 
				{
					title    = '<font color=red>إيداع</font> أغراض في الشنطة '..'<font color=orange> '..plate..' </font><font color=gray>('..CarWeight..'/'..GetWeightModel(CarMaxWeight)..' كجم)</font>',
					align = 'top-left', 
					elements = elements
				},
				function(data, menu)
					if data.current.type == 'weapon' or data.current.type == 'OpenInventoryV' then
						if data.current.value ~= 'OpenInventoryV' then
							if (GetWeightModel(CarMaxWeight) - CarWeight) >= (data.current.weight) then
								TriggerServerEvent('esx_trunk:put', data.current.value, data.current.type, data.current.ammo, plate)
								menu.close()
								Citizen.SetTimeout(refreshtime, function()
									OpenInventoryV(plate, CarMaxWeight, veh)
								end)
								OpenInventoryboolean = false
							else
								ESX.ShowNotification('<font color=red>لا توجد مساحة كافية في الشنطة</font>')
							end	
						else
							menu.close()
							OpenInventoryV(plate, CarMaxWeight, veh)
							OpenInventoryboolean = false
						end
					else
						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'trunk_2',
							{
								title = ' كم تريد إيداع ؟'
							},
						function(data2, menu2)
							if data2.value ~= nil then
								local howMany = ESX.Math.Round(data2.value)
								if (GetWeightModel(CarMaxWeight) - CarWeight) >= (howMany * data.current.weight) then
									TriggerServerEvent('esx_trunk:put', data.current.value, data.current.type, howMany, plate)
									menu2.close()
									menu.close()
									Citizen.SetTimeout(refreshtime, function()
										OpenInventoryV(plate, CarMaxWeight, veh)
									end)
									OpenInventoryboolean = false
								else
									ESX.ShowNotification('<font color=red>لا توجد مساحة كافية في الشنطة</font>')
								end	
							else
								ESX.ShowNotification('<font color=red>قيمة خاطئة</font>')
							end
						end, function(data2, menu2)
							menu2.close()
						end)
					end
			end, function(data, menu) 
				menu.close()
				OpenInventoryboolean = false
				SetVehicleDoorShut(veh, 5, false)
			end)
		else
			ESX.ShowNotification('<font color=red>يمكن فقط لصاحب المركبة إيداع الأغراض</font>')
		end
	end, plate)
end

--vehicle invetory
function OpenInventoryV(plate, CarMaxWeight, veh)
	ESX.TriggerServerCallback('esx_trunk:showItemsPlayeyHaveV', function(inventory)
		local elements = {}
		local CarWeight = 0
		table.insert(elements, { label = '<font color=red>:::::: إيداع أغراض ::::::</font>', value = 'OpenInventory', type = 'OpenInventory' })
		if inventory.blackMoney ~= false then
			table.insert(elements, { label = '<font color=red>أموال غير شرعية</font>: <font color=green> $'..tostring(ESX.Math.GroupDigits(inventory.blackMoney))..'</font><font color=orange> ('..(Config.BlackMoneyWeight*inventory.blackMoney)..' كجم) </font>', value = '', type = 'black_money' , ammo = ''})
			CarWeight = CarWeight + (Config.BlackMoneyWeight*inventory.blackMoney)
		end
		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]
			table.insert(elements, {label = item.label..' x'..item.count..'<font color=orange> ('..(1*item.count)..' كجم) </font>', value = item.name, type = 'item', ammo = ''})
			CarWeight = CarWeight + (1*item.count)
		end
		for i=1, #inventory.weapons, 1 do
			local weaponList = inventory.weapons[i]
			local weaponLabel = ESX.GetWeaponLabel(weaponList.name)
			if weaponLabel ~= nil then
				table.insert(elements, {label = weaponLabel .. ' <font color=gray>[' .. weaponList.ammo .. ']</font> طلقة <font color=orange>('..Config.WeaponsWeight..' كجم) </font>', value = weaponList.name, type = 'weapon', ammo = weaponList.ammo})
				CarWeight = CarWeight + (Config.WeaponsWeight)
			end
		end

		if inventory.CanOpen then
				OpenInventoryVboolean = true
				SetVehicleDoorOpen(veh, 5, false, false)
				ESX.UI.Menu.Open( 'default', GetCurrentResourceName(), 'trunk_1_1', 
				{
					title    = '<font color=red>أخذ</font> أغراض من الشنطة '..'<font color=orange> '..plate..' </font><font color=gray>('..CarWeight..'/'..GetWeightModel(CarMaxWeight)..' كجم)</font>',
					align = 'top-left', 
					elements = elements
				},
				function(data, menu)
					if data.current.type == 'weapon' or data.current.type == 'OpenInventory' then
						if data.current.value == 'OpenInventory' then
							OpenInventoryVboolean = false
							menu.close()
							OpenInventory(plate, CarMaxWeight, CarWeight, veh)
						else
							TriggerServerEvent('esx_trunk:take', data.current.value, data.current.type, data.current.ammo, plate)
							menu.close()
							Citizen.SetTimeout(refreshtime, function()
								OpenInventoryV(plate, CarMaxWeight, veh)
							end)
						end
					else
						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'trunk_2_2',
							{
								title = ' كم تريد أخذ ؟'
							},
						function(data2, menu2)
							if data2.value == nil then
								ESX.ShowNotification('<font color=red>قيمة خاطئة</font>')
							else
								local howMany = ESX.Math.Round(data2.value)
								TriggerServerEvent('esx_trunk:take', data.current.value, data.current.type, howMany, plate)
								menu2.close()
								menu.close()
								Citizen.SetTimeout(refreshtime, function()
									OpenInventoryV(plate, CarMaxWeight, veh)
								end)
							end
						end, function(data2, menu2)
							menu2.close()
						end)
					end
			end, function(data, menu) 
				menu.close()
				OpenInventoryVboolean = false
				SetVehicleDoorShut(veh, 5, false)
			end)
		else
			ESX.ShowNotification('<font color=red>يمكن فقط لصاحب المركبة ورجال الأمن فتح شنطة المركبة</font>')
		end
	end, plate)
end

--close vehilce 
RegisterFontFile('Font')
local fontId = RegisterFontId('BC Arabic')
local drawTxtCount = 50

function drawTxt(x, y, scale, text, r,g,b,a)
	Citizen.CreateThread(function()
		drawTxtCount = 0
		drawTxtCount = 50
		
		while drawTxtCount >= 0 do
			Citizen.Wait(0)
			
			SetTextFont(0)
			SetTextProportional(0)
			SetTextScale(scale, scale)
			SetTextColour(r, g, b, a)
			SetTextDropShadow(0, 0, 0, 0,255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("<FONT FACE='BC Arabic'>"..text)
			DrawText(x,y)
			
			drawTxtCount = drawTxtCount -1
		end
	end)	
end

function playHornSound(vehicle,status)
	Citizen.CreateThread(function()
		
		if not IsPedInVehicle(PlayerPedId(),vehicle,true) then
			--anim
			local lib = 'anim@mp_player_intmenu@key_fob@'
			--local anim = 'fob_click_fp'
			local anim = 'fob_click'
			
			RequestAnimDict(lib)
			while not HasAnimDictLoaded( lib) do
				Citizen.Wait(1)
			end
			TaskPlayAnim(PlayerPedId(), lib ,anim ,8.0, -8.0, -1, 0, 0, false, false, false)
			Citizen.Wait(600)
		
			--horn
			local sleep = 60
			local count = sleep
			
			SetVehicleLights(vehicle,2)
			
			repeat
				SoundVehicleHornThisFrame(vehicle)
				count = count - 1
			until count == 0
			
			Citizen.Wait(150)
			
			if not status then -- true = locked (double horn)	
				count = sleep
				
				repeat
					SoundVehicleHornThisFrame(vehicle)
					count = count - 1
				until count == 0
			end	
			
			SetVehicleLights(vehicle,0)
			
		end
		
	end)	
end