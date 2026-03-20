--[[ ESX	= nil
local HasAlreadyEnteredMarker, isDead = false, false
local LastZone, CurrentAction, CurrentActionMsg
local CurrentActionData	= {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function OpenAccessoryMenu()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'set_unset_accessory', {
		title = _U('set_unset'),
		align = 'top-left',
		elements = {
			{label = _U('helmet'), value = 'Helmet'},
			{label = _U('ears'), value = 'Ears'},
			{label = _U('mask'), value = 'Mask'},
			{label = _U('glasses'), value = 'Glasses'}
		}}, function(data, menu)
		menu.close()
		SetUnsetAccessory(data.current.value)
	end, function(data, menu)
		menu.close()
	end)
end

function SetUnsetAccessory(accessory)
	ESX.TriggerServerCallback('esx_accessories:get', function(hasAccessory, accessorySkin)
		local _accessory = string.lower(accessory)

		if hasAccessory then
			TriggerEvent('skinchanger:getSkin', function(skin)
				local mAccessory = -1
				local mColor = 0

				if _accessory == "mask" then
					mAccessory = 0
				end

				if skin[_accessory .. '_1'] == mAccessory then
					mAccessory = accessorySkin[_accessory .. '_1']
					mColor = accessorySkin[_accessory .. '_2']
				end

				local accessorySkin = {}
				accessorySkin[_accessory .. '_1'] = mAccessory
				accessorySkin[_accessory .. '_2'] = mColor
				TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
			end)
		else
			ESX.ShowNotification(_U('no_' .. _accessory))
		end
	end, accessory)
end

function OpenShopMenu(accessory)
	local _accessory = string.lower(accessory)
	local restrict = {}

	restrict = { _accessory .. '_1', _accessory .. '_2' }

	TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)

		menu.close()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
			title = _U('valid_purchase'),
			align = 'top-left',
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes', ESX.Math.GroupDigits(Config.Price)), value = 'yes'}
			}}, function(data, menu)
			menu.close()
			if data.current.value == 'yes' then
				ESX.TriggerServerCallback('esx_accessories:checkMoney', function(hasEnoughMoney)
					if hasEnoughMoney then
						TriggerServerEvent('esx_accessories:pay')
						TriggerEvent('skinchanger:getSkin', function(skin)
							TriggerServerEvent('esx_accessories:save', skin, accessory)
						end)
					else
						TriggerEvent('esx_skin:getLastSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
						end)
						ESX.ShowNotification(_U('not_enough_money'))
					end
				end)
			end

			if data.current.value == 'no' then
				local player = PlayerPedId()
				TriggerEvent('esx_skin:getLastSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
				if accessory == "Ears" then
					ClearPedProp(player, 2)
				elseif accessory == "Mask" then
					SetPedComponentVariation(player, 1, 0 ,0, 2)
				elseif accessory == "Helmet" then
					ClearPedProp(player, 0)
				elseif accessory == "Glasses" then
					SetPedPropIndex(player, 1, -1, 0, 0)
				end
			end
			CurrentAction     = 'shop_menu'
			CurrentActionMsg  = _U('press_access')
			CurrentActionData = {}
		end, function(data, menu)
			menu.close()
			CurrentAction     = 'shop_menu'
			CurrentActionMsg  = _U('press_access')
			CurrentActionData = {}
		end)
	end, function(data, menu)
		menu.close()
		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = _U('press_access')
		CurrentActionData = {}
	end, restrict)
end

AddEventHandler('esx:onPlayerSpawn', function() isDead = false end)
AddEventHandler('esx:onPlayerDeath', function() isDead = true end)

AddEventHandler('esx_accessories:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = _U('press_access')
	CurrentActionData = { accessory = zone }
end)

AddEventHandler('esx_accessories:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Create Blips --
Citizen.CreateThread(function()
	for k,v in pairs(Config.ShopsBlips) do
		if v.Pos ~= nil then
			for i=1, #v.Pos, 1 do
				local blip = AddBlipForCoord(v.Pos[i])

				SetBlipSprite (blip, v.Blip.sprite)
				SetBlipDisplay(blip, 4)
				SetBlipScale  (blip, 1.0)
				SetBlipColour (blip, v.Blip.color)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('shop', _U(string.lower(k))))
				EndTextCommandSetBlipName(blip)
			end
		end
	end
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(PlayerPedId())
		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
				if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i], true) < Config.DrawDistance) then
					DrawMarker(Config.Type, v.Pos[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(200)

		local coords = GetEntityCoords(PlayerPedId())
		local isInMarker = false
		local currentZone = nil
		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
				if GetDistanceBetweenCoords(coords, v.Pos[i], true) < Config.Size.x then
					isInMarker  = true
					currentZone = k
				end
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone = currentZone
			TriggerEvent('esx_accessories:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_accessories:hasExitedMarker', LastZone)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) and CurrentActionData.accessory then
				OpenShopMenu(CurrentActionData.accessory)
				CurrentAction = nil
			end
		elseif CurrentAction and not Config.EnableControls then
			Citizen.Wait(500)
		end

		if Config.EnableControls then
			if IsControlJustReleased(0, 311) and IsInputDisabled(0) and not isDead then
				OpenAccessoryMenu()
			end
		end
	end
end)
 ]]

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
	
ESX									= nil
local HasAlreadyEnteredMarker		= false
local LastZone						= nil
local CurrentAction					= nil
local CurrentActionMsg				= ''
local CurrentActionData				= {}
local isDead						= false
local PlayerData = {}
local recording = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(500)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(500)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

--[[ Cooldown function start ]]-- cooldown is used in daily reward
local count = 0
	
	local function Cooldown()
		CreateThread(function()
			count = 10 -- مدة الكول داون بالثواني
			while count ~= 0 do
				count = count - 1
				Wait(1000)
			end	
			count = 0
		end)	
	end
--[[ Cooldown function end ]]

function OpenAccessoryMenu()
	
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'personal_menu',
		{
			title = _U('personal_menu'),
			align = 'top-left',
			elements = {
				{label = _U('idcards_MenuName'), value = 'idcards'},
				{label = _U('accessories'), value = 'accessories'},
				--{label = 'اظهار مواقع محطة المترو بالخريطة 🚇', value = 'metro'},
				--{label = _U('reward'), value = 'reward'},
				--{label = _U('reward')..' <font color=gray>غير متاح</font>'},
				{label = '<font color=orange>الوقت المتبقي للمكافأة التلقائية</font>', value = 'RewardRemainingtime'},
				{label = _U('xp_check'), value = 'xp'},
				{label = _U('tebex_records'), value = 'tebex'},
				{label = _U('Graphics_MenuName'), value = 'GraphicsMenu'},
				{label = _U('rockstarEditor_MenuName'), value = 'rockstarEditor'},
				
			}
		},

		
		
		function(data, menu)
			local action = data.current.value
			
			if action == 'business' then
				getBusinessDataForNearbyPlayer()
			elseif action == 'idcards' then
				idcards()
			elseif action == 'accessories' then
				------------
				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'set_unset_accessory',
					{
						title = _U('set_unset'),
						align = 'top-left',
						elements = {
							{label = _U('helmet'), value = 'Helmet'},
							{label = _U('ears'), value = 'Ears'},
							{label = _U('mask'), value = 'Mask'},
							{label = _U('glasses'), value = 'Glasses'},
						}
					},
					function(data2, menu2)
						menu2.close()
						SetUnsetAccessory(data2.current.value)
			
					end,
					function(data2, menu2)
						menu2.close()
					end
				)
				------------
			elseif action == 'reward' then
			if count == 0 then 
			Cooldown()
			----------
			menu.close()
			
			local waittime = 500
			TriggerEvent('pogressBar:drawBar', waittime, '<font size=5>جاري التنفيذ')
			Citizen.Wait(waittime+ 380)
			
			TriggerEvent('daily_reward:toggleFreeMenu',true)
			----------
			else
	        ESX.ShowNotification('<font color=red>يجب الأنتظار</font>. <font color=orange>'..count..' ثانية')
			end
			
			elseif action == 'xp' then
				TriggerEvent("esx:ESXP")
			elseif action == 'RewardRemainingtime' then
			TriggerEvent('esx_misc:RewardRemainingtime')
			elseif action == 'GraphicsMenu' then
				GraphicsMenu()
			elseif action == 'tebex' then
				OpenTebexStoreRecordsTebexStore()
			elseif action == 'metro' then
				TriggerEvent('blaine_trains:BlipMap')
			elseif action == 'rockstarEditor' then
				OpenRockstarEditorMenu()			
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function GraphicsMenu() 

    local elements = {
		  {label = 'تحسين <font color=gold>FPS</font>',		value = 'fps'},	   
      {label = 'جرافيكس أفضل 🌌',		value = 'fps7'},	       
      {label = 'تحسين مظهر & إضائات',		value = 'fps5'},   
      --{label = 'RP Scene Mode',		value = 'fps6'}, -- i don't Know wtf is this
		  {label = 'طبيعي',		value = 'fps2'},									          
        }
  
    ESX.UI.Menu.CloseAll()
  
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'headbagging',
      {
        title    = 'قائمة الجرافيكس',
        align    = 'top-left',
        elements = elements
        },
  
            function(data2, menu2)
  
  
  
  
              if data2.current.value == 'fps' then
                SetTimecycleModifier('yell_tunnel_nodirect')

             

             elseif data2.current.value == 'fps2' then
                SetTimecycleModifier()
                ClearTimecycleModifier()
                ClearExtraTimecycleModifier()
              elseif data2.current.value == 'fps5' then
                SetTimecycleModifier('tunnel') 
              elseif data2.current.value == 'fps6' then
                ExecuteCommand('cinema')  
                
              elseif data2.current.value == 'fps7' then
                  SetTimecycleModifier('MP_Powerplay_blend')
                  SetExtraTimecycleModifier('reflection_correct_ambient')    
                elseif data2.current.value == 'fps8' then    
                  DisplayRadar(false)
                elseif data2.current.value == 'fps9' then      
                  DisplayRadar(true)
              else
              end
            end,
      function(data2, menu2)
        menu2.close()
      end
    )
  
  end
  

function SetUnsetAccessory(accessory)
	
	ESX.TriggerServerCallback('esx_accessories:get', function(hasAccessory, accessorySkin)
		local _accessory = string.lower(accessory)

		if hasAccessory then
			TriggerEvent('skinchanger:getSkin', function(skin)
				local mAccessory = -1
				local mColor = 0	  
				if _accessory == "mask" or _accessory == "glasses" then
					mAccessory = 0
				end
				if skin[_accessory .. '_1'] == mAccessory then
					mAccessory = accessorySkin[_accessory .. '_1']
					mColor = accessorySkin[_accessory .. '_2']
				end
				local accessorySkin = {}
				accessorySkin[_accessory .. '_1'] = mAccessory
				accessorySkin[_accessory .. '_2'] = mColor
				TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
			end)
		else
			ESX.ShowNotification(_U('no_' .. _accessory))
		end

	end, accessory)
end

function OpenShopMenu(accessory)

	local _accessory = string.lower(accessory)
	local restrict = {}

	restrict = { _accessory .. '_1', _accessory .. '_2' }
	
	TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)

		menu.close()

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'shop_confirm',
			{
				title = _U('valid_purchase'),
				align = 'top-left',
				elements = {
					{label = _U('yes'), value = 'yes'},
					{label = _U('no'), value = 'no'},
				}
			},
			function(data, menu)
				menu.close()
				if data.current.value == 'yes' then
					ESX.TriggerServerCallback('esx_accessories:checkMoney', function(hasEnoughMoney)
						if hasEnoughMoney then
							TriggerServerEvent('esx_accessories:pay')
							TriggerEvent('skinchanger:getSkin', function(skin)
								TriggerServerEvent('esx_accessories:save', skin, accessory)
							end)
						else
							TriggerEvent('esx_skin:getLastSkin', function(skin)
								TriggerEvent('skinchanger:loadSkin', skin)
							end)
							ESX.ShowNotification(_U('not_enough_money'))
						end
					end)
				end

				if data.current.value == 'no' then
					local player = GetPlayerPed(-1)
					TriggerEvent('esx_skin:getLastSkin', function(skin)
						TriggerEvent('skinchanger:loadSkin', skin)
					end)
					if accessory == "Ears" then
						ClearPedProp(player, 2)
					elseif accessory == "Mask" then
						SetPedComponentVariation(player, 1, 0 ,0 ,2)
					elseif accessory == "Helmet" then
						ClearPedProp(player, 0)
					elseif accessory == "Glasses" then
						SetPedPropIndex(player, 1, -1, 0, 0)
					end
				end
				CurrentAction	 = 'shop_menu'
				CurrentActionMsg  = _U('press_access')
				CurrentActionData = {}
			end,
			function(data, menu)
				menu.close()
				CurrentAction	 = 'shop_menu'
				CurrentActionMsg  = _U('press_access')
				CurrentActionData = {}

			end
		)

	end, 
	function(data, menu)
		menu.close()
		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = _U('press_access')
		CurrentActionData = {}
	end, restrict)

end

AddEventHandler('playerSpawned', function()
	isDead = false
end)

AddEventHandler('esx:onPlayerDeath', function()
	isDead = true
end)

AddEventHandler('esx_accessories:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = _U('press_access')
	CurrentActionData = { accessory = zone }
end)

AddEventHandler('esx_accessories:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Create Blips --
Citizen.CreateThread(function()
	for k,v in pairs(Config.ShopsBlips) do
		if v.Pos ~= nil then
			for i=1, #v.Pos, 1 do
				local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

				SetBlipSprite (blip, v.Blip.sprite)
				SetBlipDisplay(blip, 4)
				SetBlipScale  (blip, 1.0)
				SetBlipColour (blip, v.Blip.color)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("<FONT FACE='A9eelsh'>ﺔﻌﻨﻗﺍ ﺮﺠﺘﻣ")
				EndTextCommandSetBlipName(blip)
			end
		end
	end
end)

--[[ Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
				if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < Config.DrawDistance) then
					DrawMarker(Config.Type, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end
	end
end)]]

Citizen.CreateThread(function()
	while true do
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil
		local draw = false
		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
				local dist = GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true)
				if dist < Config.Size.x then
					isInMarker  = true
					currentZone = k
				end
				if dist < Config.DrawDistance then
					draw = true
					DrawMarker(Config.Type, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
				else
					darw = false
				end
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone = currentZone
			TriggerEvent('esx_accessories:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_accessories:hasExitedMarker', LastZone)
		end
		
		if not isInMarker and not draw then
			Citizen.Wait(1000)
		else
			Citizen.Wait(10)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		
		if CurrentAction ~= nil then
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlJustReleased(0, 38) and CurrentActionData.accessory ~= nil then
				OpenShopMenu(CurrentActionData.accessory)
				CurrentAction = nil
			end
		end

		if Config.EnableControls then
			if IsControlJustReleased(0, Keys['F5']) and GetLastInputMethod(2) and not isDead then
				OpenAccessoryMenu()
			end
		end

	end
end)

--open business menu
--[[
function getBusinessDataForNearbyPlayer()
  
	ESX.TriggerServerCallback('esx_accessories:getBusinessIdentityCard', function(business)
		local businessElements = {}
		
		if business ~= nil then
			
			table.insert(businessElements, {label = '<font color=gray>اسم المنظمة</font>: <font color=white>'..business.name..'</font>', value, nil})
			table.insert(businessElements, {label = '<font color=gray>المنصب</font>: <font color=orange>'..business.position..'</font>', value, nil})
			table.insert(businessElements, {label = '<font color=gray>عدد الاعضاء</font>: <font color=orange>'..business.employeesCount..'</font>', value = nil})
			table.insert(businessElements, {label = '<font color=gray>العنوان</font>: <font color=white>'..business.address..'</font>', value = nil})
			table.insert(businessElements, {label = '<font color=gray>الوصف</font>: <font color=white>'..business.description..'</font>', value = nil})
			table.insert(businessElements, {label = '<font color=gray>سعر البضاعة</font>: <font color=green>$</font><font color=white>'..business.stock_price..'</font>', value = nil})
			table.insert(businessElements, {label = '<font color=gray>قيمة الضريبة</font>: <font color=red>'..business.taxrate..'</font>%', value = nil})
			table.insert(businessElements, {label = '<font color=gray>المكسب بالساعة</font>: <font color=green>$</font><font color=white>'..business.earnings..'</font>', value = nil})
			table.insert(businessElements, {label = '<font color=gray>رأس المال</font>: <font color=green>$</font><font color=white>'..business.price..'</font>', value = nil})
		else
			table.insert(businessElements, {label = '<font color=red>انت غير مسجل في منظمة</font>'})
		end
			
			
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'business_status',
		{
			title    = 'بيانات المنظمة',
			align    = 'top-left',
			elements = businessElements,
		}, function(data2, menu2)
			-------------------
			
			-------------------
		end, function(data2, menu2)
			menu2.close()
		end)
		
	end)
end
--]]

function getBusinessDataForNearbyPlayer()
  ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'business_status',
	{
		title    = 'بيانات المنظمة',
		align = 'top-left',
		elements = {
			{label = '<font color=red>انت غير مسجل في منظمة</font>'},
		}
	},
	function(data2, menu2)
		local val = data2.current.value
		
		if val == 'checkID' then
			--TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
			ESX.UI.HUD.SetDisplay(0.0)
		elseif val == 'checkDriver' then
			ESX.UI.HUD.SetDisplay(0.0)
			--TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
		elseif val == 'checkFirearms' then
			ESX.UI.HUD.SetDisplay(0.0)
			--TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
			ESX.UI.HUD.SetDisplay(0.0)
		elseif val == 'sponser' then
			openSponserRolesMenu(data2.current.label)
			--TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'sponser')
		else
			local player, distance = ESX.Game.GetClosestPlayer()
			
			if distance ~= -1 and distance <= 3.0 then
				if val == 'showID' then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
				elseif val == 'showDriver' then
			--TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
				elseif val == 'showFirearms' then
			--TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
				end
			else
			  --ESX.ShowNotification('لايوجد احد قريب منك')
			end
		end
	end,
	function(data2, menu2)
		menu2.close()
	end)
end
--]]
--open idcards menu
function idcards()
  ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'id_card_menu',
	{
		title    = 'البطاقات الشخصية',
		align = 'top-left',
		elements = {
			{label = 'التأكد من اثباتك الشخصي', value = 'checkID'},
			{label = 'اظهار اثباتك الشخصي لاقرب شخص', value = 'showID'},
			{label = 'التأكد من رخصة القيادة', value = 'checkDriver'},
			{label = 'اظهار رخصة القيادة لأقرب شخص', value = 'showDriver'},
			{label = 'التأكد من ترخيص السلاح', value = 'checkFirearms'},
			{label = 'اظهار رخصة السلاح لأقرب شخص', value = 'showFirearms'},
			{label = '<font color=orange>بطاقة الداعمين</font>', value = 'sponser'},
		}
	},
	function(data2, menu2)
		local val = data2.current.value
		
		if val == 'checkID' then
			--TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
			ESX.UI.HUD.SetDisplay(0.0)
		elseif val == 'checkDriver' then
			ESX.UI.HUD.SetDisplay(0.0)
			--TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
		elseif val == 'checkFirearms' then
			ESX.UI.HUD.SetDisplay(0.0)
			--TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
			ESX.UI.HUD.SetDisplay(0.0)
		elseif val == 'sponser' then
			openSponserRolesMenu(data2.current.label)
			--TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'sponser')
		else
			local player, distance = ESX.Game.GetClosestPlayer()
			
			if distance ~= -1 and distance <= 3.0 then
				if val == 'showID' then
				--TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
				elseif val == 'showDriver' then
			--TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
				elseif val == 'showFirearms' then
			--TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
				end
			else
			  ESX.ShowNotification('لايوجد احد قريب منك')
			end
		end
	end,
	function(data2, menu2)
		menu2.close()
	end)
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(0, 322) or IsControlJustReleased(0, 177) then
			ESX.UI.HUD.SetDisplay(1.0)
		end
	end
end)
function openSponserRolesMenu(menulabel)
	--ESX.TriggerServerCallback('discord_perms:getSponserRoles', function(isSponser,playerSponserRoles,RPname)
	ESX.TriggerServerCallback('esx_misc:getSponserRoles', function(isSponser,playerSponserRoles,RPname)
		if isSponser then
			local fullname = RPname.firstname..' '..RPname.lastname
			local elements = {}
			
			for i=1, #playerSponserRoles, 1 do
				table.insert(elements, {label = playerSponserRoles[i].label, value = playerSponserRoles[i].name})
			end
			
			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'sponser_roles_menu',
			{
				title    = menulabel..' '..fullname,
				align = 'top-left',
				elements = elements
			},
			function(data3, menu3)
				local val3 = data3.current.value
				

				
			
	

				-----------
				ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'sponser_roles_menu_action',
				{
					title    = data3.current.label,
					align = 'top-left',
					elements = {
						{label = 'التأكد من البطاقة', value = 'me'},
						{label = 'اظهار البطاقة لأقرب شخص', value = 'target'},
					}	
				},
		
				function(data4, menu4)
					local val4 = data4.current.value
					local data = {
						firstname = RPname.firstname,
						lastname = RPname.lastname,
						rolename = data3.current.value,
						job = PlayerData.job.label,
					}
					local vallo=data3.current.label
					local spons = 'sponser'

					if ( vallo== "🥈 بطاقة فضية") then
						spons= 'sponserSilver'
					
					elseif(vallo == "🏅 بطاقة ذهبية")then
					spons = 'gold'

					elseif(vallo == "🥉 بطاقة برونزية")then
					spons = 'sponser'
				elseif
	
			 (vallo == "⚡ بطاقة بلاتينية")then
					spons = 'plat'
				elseif
			 (vallo == "💎 بطاقة الماسية")then
				spons = 'daimend'
			elseif
		 (vallo == "🏆 بطاقة رسمية")then
			spons = 'sponserOfficial'
		elseif
		(vallo == "بطاقة منسوبي الامن العام")then
			spons = 'bht'
		elseif
		(vallo == "بطاقة خاصة")then
			spons = 'dmtard'
		elseif
	 (vallo == "💠 بطاقة استراتيجية")then
		spons = 'sponserStrategy'
	 end
	

					if val4 == 'me' then
						--TriggerEvent('jsfour-idcard:open', data, spons)
						--TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'sponser')
					elseif val4 == 'target' then
						local player, distance = ESX.Game.GetClosestPlayer()
			
						if distance ~= -1 and distance <= 3.0 then
					
							--TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), spons, data, spons)
						else
							ESX.ShowNotification('لايوجد احد قريب منك')
						end	
					end
					
				end,
				function(data4, menu4)
					menu4.close()
				end)
				-----------
			end,
			function(data3, menu3)
				menu3.close()
			end)
		else
			ESX.ShowNotification('<font color=red>انت لاتحمل بطاقة الداعمين حاليا</font>')
		end
	end)	
end




--Tebex Store Records TebexStore
        function OpenTebexStoreRecordsTebexStore()
        ESX.TriggerServerCallback('esx_qalle_brottsregister:grab_TebexStore', function(crimes, _FivemID, iname, _steamID ,_discordID)
		
        local elements = {}
		if _FivemID == nil or _FivemID == '' then
			_FivemID = '<font color=red>حسابك الفايف ام غير مرتبط</br>يجب ربط الحساب حتى تستلم المشتريات من المتجر بشكل تلقائي</font>'
		end
        table.insert(elements, {label = '<font color=gray>[____ بياناتك الشخصية صورها في التكت في حال طلب المساعدة ____]</font><font color=#CCCCCC></br>'.._FivemID..'</br>'..iname..'</br>'.._steamID..'</br>'.._discordID..'</font>', value = 'spacer'})
        table.insert(elements, {label = '<font color=gray>[______ السجل ______]</font>', value = 'spacer'})

        for i=1, #crimes, 1 do
            table.insert(elements, {label = '<font color=gray>'..crimes[i].date .. '</font> - ' .. crimes[i].crime, value = crimes[i].crime, name = crimes[i].name})
        end


        ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'brottsregister',
            {
                title    = ':::: سجل متجر مدينة 101 ::::',
                elements = elements
            },
        function(data2, menu2)
		--[[
        if data2.current.value == 'crime' then
                ESX.UI.Menu.Open(
                    'dialog', GetCurrentResourceName(), 'brottsregister_second',
                    {
                        title = 'اكتب وصف الحالة المطلوب تقيدها في السجل'
                    },
                function(data3, menu3)
                    local crime = (data3.value)

                    if crime == tonumber(data3.value) then
                        ESX.ShowNotification('Action Impossible')
                        menu3.close()               
                    else
                        menu2.close()
                        menu3.close()
                        TriggerServerEvent('esx_qalle_brottsregister:add_TebexStore', GetPlayerServerId(closestPlayer), crime)
                        ESX.ShowNotification('Added to register!')
                        Citizen.Wait(100)
                        OpenCriminalRecords(closestPlayer)
                    end

                end,
            function(data3, menu3)
                menu3.close()
            end)
        else
            ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'remove_confirmation',
                    {
                    title    = 'تأكيد حذف السجل؟',
                    elements = {
                        {label = 'حذف سجل', value = 'yes'},
                        {label = 'رجوع', value = 'no'}
                    }
                },
            function(data3, menu3)

                if data3.current.value == 'yes' then
                    menu2.close()
                    menu3.close()
                    TriggerServerEvent('esx_qalle_brottsregister:remove_TebexStore', GetPlayerServerId(closestPlayer), data2.current.value)
                    ESX.ShowNotification('Removed!')
                    Citizen.Wait(100)
                    OpenCriminalRecords(closestPlayer)
                else
                    menu3.close()
                end                         

                end,
            function(data3, menu3)
                menu3.close()
            end)                 
        end ]]

        end,
        function(data2, menu2)
            menu2.close()
        end)

    end, GetPlayerServerId(PlayerId()))
end --]]

function OpenRockstarEditorMenu()
	local elements = {}
  
	if recording then
		table.insert(elements,{label = '<font color=red>وقف التصوير</font>', value = 'stop'})
	else
		table.insert(elements,{label = '<font color=green>بدأ التصوير</font>', value = 'start'})
	end
	
  ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'id_card_menu',
	{
		title    = 'البطاقات الشخصية',
		align = 'top-left',
		elements = elements
	},
	function(data2, menu2)
		local currentvalue = data2.current.value
		if currentvalue == 'start' then
			recording = true
			StartRecording(1)
		elseif currentvalue == 'stop' then
			recording = false
			StopRecordingAndSaveClip()
		end
		menu2.close()
	end,
	function(data2, menu2)
		menu2.close()
	end)
end