local GUI          			  = {}
local hasAlreadyEnteredMarker = false
local isInWASHMarker 			  = false
local menuIsShowed   		  = false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_moneywash:animation') -- new
AddEventHandler('esx_moneywash:animation', function()
    disableAllControlActions = true

	Citizen.CreateThread(function()
		while disableAllControlActions do
			Citizen.Wait(0)
			DisableAllControlActions(0) --disable all control (comment it if you want to detect how many time key pressed)
			EnableControlAction(0, 249, true)  -- N
			EnableControlAction(0, 311, true)  -- K
			EnableControlAction(0, 45, true)  -- T = chat
			EnableControlAction(0, 1, true) -- Disable pan
			EnableControlAction(0, 2, true) -- Disable tilt
		end
	end)
	TriggerEvent('pogressBar:drawBar', 20000, 'جاري غسل الأموال')
	Citizen.Wait(20000)	
	disableAllControlActions = false
end)

-- Create Blips
Citizen.CreateThread(function()
	
	for i=1, #Config.Map, 1 do
		
		local blip = AddBlipForCoord(Config.Map[i].x, Config.Map[i].y, Config.Map[i].z)
		SetBlipSprite (blip, Config.Map[i].id)
		SetBlipDisplay(blip, 4)
		SetBlipColour (blip, Config.Map[i].color)
		SetBlipScale  (blip, Config.Map[i].scale)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Map[i].name)
		EndTextCommandSetBlipName(blip)
	end

end)

-- Render markers
Citizen.CreateThread(function()
	while true do		
		Wait(0)		
		local coords = GetEntityCoords(GetPlayerPed(-1))		
		for i=1, #Config.WASH, 1 do
			if(GetDistanceBetweenCoords(coords, Config.WASH[i].x, Config.WASH[i].y, Config.WASH[i].z, true) < Config.DrawDistance) then
				DrawMarker(Config.MarkerType, Config.WASH[i].x, Config.WASH[i].y, Config.WASH[i].z - Config.ZDiff, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		end
	end
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do		
		Wait(0)		
		local coords = GetEntityCoords(GetPlayerPed(-1))
		isInWASHMarker = false
		for i=1, #Config.WASH, 1 do
			if(GetDistanceBetweenCoords(coords, Config.WASH[i].x, Config.WASH[i].y, Config.WASH[i].z, true) < Config.ZoneSize.x / 2) then
				isInWASHMarker = true
				SetTextComponentFormat('STRING')
				AddTextComponentString(_U('press_e_wash'))
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)
			end
		end
		if isInWASHMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
		end
		if not isInWASHMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			SetNuiFocus(false)	
				menuIsShowed = false	
				SendNUIMessage({
					hideAll = true
			})
		end
	end
end)

-- Menu interactions
Citizen.CreateThread(function() 
	while true do
	  	Wait(0)
		if IsControlJustReleased(0, 38) and isInWASHMarker then
			local black_money = 0
			ESX.TriggerServerCallback('esx:getPlayerData', function(data)
				for i=1, #data.accounts, 1 do
					if data.accounts[i].name == "black_money" then
						black_money = data.accounts[i].money
					end
				end
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'send_money_wash', {
					title = 'كم تريد غسل اموال غير قانونية | $' .. black_money
				}, function(data_new, menu_new)
					menu_new.close()
					ESX.UI.Menu.CloseAll()
					TriggerServerEvent('esx_moneywash:withdraw_dakh5gyu3876ati', data_new.value)
				end, function(data_new, menu_new)
					menu_new.close()
				end)
			end)
		end
	end
end)
