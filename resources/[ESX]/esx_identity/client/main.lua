ESX = nil
local loadingScreenFinished = false
local RpNameDone = false
local myName = '<font color=gray>حصل خطأ ولم نستطيع أيجاد أسمك</font>'

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_identity:alreadyRegistered')
AddEventHandler('esx_identity:alreadyRegistered', function()
	while not loadingScreenFinished do
		Citizen.Wait(100)
	end

	TriggerEvent('esx_skin:playerRegistered')
end)

AddEventHandler('esx:loadingScreenOff', function()
	loadingScreenFinished = true
end)

if not Config.UseDeferrals then
	local guiEnabled, isDead = false, false

	AddEventHandler('esx:onPlayerDeath', function(data)
		isDead = true
	end)

	AddEventHandler('esx:onPlayerSpawn', function(spawn)
		isDead = false
	end)

	function EnableGui(state)
		SetNuiFocus(state, state)
		guiEnabled = state

		SendNUIMessage({
			type = "enableui",
			enable = state
		})
	end

	RegisterNetEvent('esx_identity:showRegisterIdentity')
	AddEventHandler('esx_identity:showRegisterIdentity', function()
		TriggerEvent('esx_skin:resetFirstSpawn')

		if not isDead then
			EnableGui(true)
		end
	end)

	RegisterNUICallback('register', function(data, cb)
		ESX.TriggerServerCallback('esx_identity:registerIdentity', function(callback)
			if callback then
				ESX.ShowNotification(_U('thank_you_for_registering'))
				EnableGui(false)
				TriggerEvent('esx_skin:playerRegistered')
				TriggerEvent('esx_scoreboard:refreshscoreboard')
			else
				ESX.ShowNotification(_U('registration_error'))
			end
		end, data)
	end)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)

			if guiEnabled then
				DisableControlAction(0, 1,   true) -- LookLeftRight
				DisableControlAction(0, 2,   true) -- LookUpDown
				DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
				DisableControlAction(0, 142, true) -- MeleeAttackAlternate
				DisableControlAction(0, 30,  true) -- MoveLeftRight
				DisableControlAction(0, 31,  true) -- MoveUpDown
				DisableControlAction(0, 21,  true) -- disable sprint
				DisableControlAction(0, 24,  true) -- disable attack
				DisableControlAction(0, 25,  true) -- disable aim
				DisableControlAction(0, 47,  true) -- disable weapon
				DisableControlAction(0, 58,  true) -- disable weapon
				DisableControlAction(0, 263, true) -- disable melee
				DisableControlAction(0, 264, true) -- disable melee
				DisableControlAction(0, 257, true) -- disable melee
				DisableControlAction(0, 140, true) -- disable melee
				DisableControlAction(0, 141, true) -- disable melee
				DisableControlAction(0, 143, true) -- disable melee
				DisableControlAction(0, 75,  true) -- disable exit vehicle
				DisableControlAction(27, 75, true) -- disable exit vehicle
			else
				Citizen.Wait(500)
			end
		end
	end)
end

-----------------------------------
-----------------------------------
---تسجيل هوية جديدة وحذف القديمة---
-----------------------------------
-----------------------------------

Citizen.CreateThread(function() --  مدينة 101 بالخريطة
	local blip = AddBlipForCoord(Config.ChangeIdentityCoords)
	SetBlipSprite (blip, 498)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.9)
	SetBlipColour (blip, 29)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('<FONT FACE="A9eelsh">ﺔﻳﻮﻬﻟﺍ ﻞﻴﺠﺴﺗ')
	EndTextCommandSetBlipName(blip)
end)

-- Draw markers and more
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

			local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed)
			local isInMarker, hasExited, letSleep = false, false, true
			local currentStation, currentPart, currentPartNum
					local distance = #(playerCoords - Config.ChangeIdentityCoords )
					if distance < 10 then
						DrawMarker(1--[[marker Type]],Config.ChangeIdentityCoords , 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 0.5, 50--[[R]], 50--[[G]], 204--[[B]], 100, false, true, 2, true, false, false, false)
						letSleep = false

						if distance < 1.5 then
						if not RpNameDone then
						TriggerServerEvent('esx_identity:GetMeRpName', Config.pas)
						RpNameDone = true
						end
							isInMarker, currentPart, currentPartNum = true, 'changeI', i
						end
			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
				if
					(LastStation and LastPart and LastPartNum) and
					(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('esx_identity:hasExitedMarker', LastStation, LastPart, LastPartNum)
					hasExited = true
					ESX.UI.Menu.CloseAll()
				CurrentAction = nil
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				if currentPart == 'changeI' then
				CurrentAction     = 'ChangeIdentity'
		        CurrentActionMsg  = '~y~E~w~ ﺓﺪﻳﺪﺟ ﺔﻳﻮﻫ ﻞﻴﺠﺴﺗ'
		        CurrentActionData = {}
				end
			end
			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				ESX.UI.Menu.CloseAll()
				CurrentAction = nil
			end
			if letSleep then
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)
		end
		end
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

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction == 'ChangeIdentity' then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if Cooldown_count == 0 then 
	            Cooldown(10)
				ESX.UI.Menu.CloseAll()				  
				TriggerEvent('pogressBar:drawBar', 1000, '<font size=5 color=white>جاري التنفيذ')
				--- --- --- --- --- --- ---
				disableAllControlActions = true	
					Citizen.CreateThread(function()
				  while disableAllControlActions do
					  Citizen.Wait(0)
					  DisableAllControlActions(0)
				  end
			  end)
			   --- --- --- --- --- --- ---
				Citizen.Wait(1000)
				disableAllControlActions = false
					OpenChangeIdentityMenu()
				else
				ESX.ShowNotification('<font color=red>يجب الأنتظار</font>. <font color=orange>'..Cooldown_count..' ثانية')
				end
			        

				CurrentAction = nil
			end
		end

	end
end)

RegisterNetEvent('esx_identity:RpName')
AddEventHandler('esx_identity:RpName', function(Name)
	myName = Name
end)

function OpenChangeIdentityMenu()
    TriggerServerEvent('esx_identity:GetMeRpName', Config.pas)
ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
			title = 'هل أنت متأكد من تسجيل هوية جديدة وتغير أسمك بمقابل <font color=green>$'..Config.ChangeIdentityPrice..'</font>؟',
			align = 'top-left',
			elements = {
				{label = '<font color=red>رجوع</font>', value = 'no'},
				{label = 'نعم أريد دفع <font color=green>$'..Config.ChangeIdentityPrice..'</font> وتسجيل هوية جديدة', value = 'yes'},
				{label = 'اسمك المسجل بالهوية الحالي <font color=gold>'..myName..'</font>'}
		}}, function(data, menu)
	local distance = #(GetEntityCoords(PlayerPedId()) - Config.ChangeIdentityCoords )
	if distance < 1.5 then
	else
		ESX.ShowNotification("<font color=red>انت خارج نقطة تسجيل الهوية</font>")
		ESX.UI.Menu.CloseAll()		
		return
	end
    if data.current.value == 'no' then
		menu.close()
	end
	if data.current.value == 'yes' then
		menu.close()
	    ESX.TriggerServerCallback("esx_identity:ChangeIdentityMenu", function(isHaveMoney)
	if isHaveMoney then
	    Cooldown(100)
		menu.close()
	else		
		ESX.ShowNotification("لاتملك مبلغ كافي في بالكاش <font color=green>$"..Config.ChangeIdentityPrice.."</font>")
	end
	end)
	end
	end)
end