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
ESX 			    			= nil
local showblip = false
local done_take_money = false
local TimerStolen = false
local Id = nil
local blip_take_money = nil
local syncingTimer = 20
local displayedBlips = {}
local AllBlips = {}
local number = nil
local BLOCKINPUTCONTROL = false
function getshoptype(ndndndndndnnd)
	for k,v in pairs(Config.Zones) do
		if v.Pos.number == ndndndndndnnd then
			return v.Type
		end
	end
end

local PlayerData = {}

configready = true

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

AddEventHandler('onResourceStop', function(resource)
	  if resource == GetCurrentResourceName() then
		  SetNuiFocus(false, false)
	  end
end)
  
RegisterNUICallback('escape', function(data, cb)
	 
	  SetNuiFocus(false, false)
  
	  SendNUIMessage({
		  type = "close",
	  })
end)

RegisterNUICallback('bossactions', function(data, cb)
	 
	SetNuiFocus(false, false)

	SendNUIMessage({
		type = "close",
	})

	ESX.TriggerServerCallback('esx_shops2:getOwnedShop', function(data)
		exports['pogressBar']:drawBar(1000, 'جار التنفيذ')
		Citizen.SetTimeout(1000, function()
			if data.owneroremps then
				OpenBoss(data.owner)
			else
				ESX.ShowNotification('<font color=red>إدارة المتجر متاحة لصاحب المتجر والموظفين فقط</font>')
			end
		end)
	end)
end)

local Cart = {}

RegisterNUICallback('putcart', function(data, cb)
	table.insert(Cart, {item = data.item, label = data.label, count = data.count, id = data.id, price = data.price})
	cb(Cart)
end)

RegisterNUICallback('notify', function(data, cb)
	ESX.ShowNotification(data.msg)
end)

RegisterNUICallback('refresh', function(data, cb)
	 
	Cart = {}

		ESX.TriggerServerCallback('esx_kr_shop:getOwnedShop', function(data)
			ESX.TriggerServerCallback('esx_kr_shop:getShopItems', function(result)
				if data ~= nil then
					Owner = true
				end

				if result ~= nil then
					local type2 = getshoptype(number)

					SetNuiFocus(true, true)
			
					SendNUIMessage({
						type = "shop",
						type2 = type2,
						result = result,
						ShopName = data[1].ShopName,
						owner = Owner,
					})
				end

			end, number, ShopId)
		end, number, ShopId)
end)

RegisterNUICallback('emptycart', function(data, cb)
	Cart = {}
	
end)

local ShopId           = nil
local Msg        = nil
local HasAlreadyEnteredMarker = false
local LastZone                = nil

Citizen.CreateThread(function()
	Citizen.Wait(500)
	local blip = AddBlipForCoord(835.69, -3193.38, 14.5)
	
	SetBlipSprite (blip, 473)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, 2)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("<FONT FACE='A9eelsh'>ﻲﺴﻴﺋﺮﻟﺍ ﻉﺩﻮﺘﺴﻤﻟﺍ")
	EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
	Citizen.Wait(500)
	local blip = AddBlipForCoord(-120.18, -2505.69, 14.64)
	
	SetBlipSprite (blip, 473)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, 2)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("<FONT FACE='A9eelsh'>ﻲﺑﺮﻐﻟﺍ ﻉﺩﻮﺘﺴﻤﻟﺍ")
	EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
	Citizen.Wait(500)
	local blip = AddBlipForCoord(232.94, 216.1, 157.62)
	
	SetBlipSprite (blip, 536)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.80)
	SetBlipColour (blip, 59)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("<FONT FACE='A9eelsh'>ﻱﺰﻛﺮﻤﻟﺍ ﻚﻨﺒﻟﺍ")
	EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
	Citizen.Wait(500)
	local blip = AddBlipForCoord(148.98, -1039.98, 49.22)
	
	SetBlipSprite (blip, 276)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.590)
	SetBlipColour (blip, 2)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("<FONT FACE='A9eelsh'>ﺪﻴﻬﺸﻟﺍ ﺔﻘﻳﺪﺣ ﻚﻨﺑ")
	EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
	Citizen.Wait(500)
	local blip = AddBlipForCoord(-1215.71, -333.07, 42.12)
	
	SetBlipSprite (blip, 276)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.590)
	SetBlipColour (blip, 2)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("<FONT FACE='A9eelsh'>( 1 ) ﻲﻋﺮﻔﻟﺍ 101 ﺔﻨﻳﺪﻣ ﻚﻨﺑ")
	EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
	Citizen.Wait(500)
	local blip = AddBlipForCoord(-349.17, -46.24, 90.91)
	
	SetBlipSprite (blip, 276)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.590)
	SetBlipColour (blip, 2)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("<FONT FACE='A9eelsh'>( 2 ) ﻲﻋﺮﻔﻟﺍ 101 ﺔﻨﻳﺪﻣ ﻚﻨﺑ")
	EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
	Citizen.Wait(500)
	local blip = AddBlipForCoord(314.46, -277.59, 91.08)
	
	SetBlipSprite (blip, 276)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.590)
	SetBlipColour (blip, 2)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("<FONT FACE='A9eelsh'>( 3 ) ﻲﻋﺮﻔﻟﺍ 101 ﺔﻨﻳﺪﻣ ﻚﻨﺑ")
	EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
	Citizen.Wait(500)
	local blip = AddBlipForCoord(-2959.27, 481.13, 25.67)
	
	SetBlipSprite (blip, 276)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.590)
	SetBlipColour (blip, 2)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("<FONT FACE='A9eelsh'>( 1 ) ﻲﻟﺎﻤﺸﻟﺍ 101 ﺔﻨﻳﺪﻣ ﻚﻨﺑ")
	EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
	Citizen.Wait(500)
	local blip = AddBlipForCoord(-109.23, 6464.49, 37.22)
	
	SetBlipSprite (blip, 276)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.590)
	SetBlipColour (blip, 2)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("<FONT FACE='A9eelsh'>ﻲﺴﻴﺋﺮﻟﺍ ﻮﺘﻴﻟﻮﺑ ﻚﻨﺑ")
	EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
	Citizen.Wait(500)
	local blip = AddBlipForCoord(1174.66, 2711.8, 42.85)
	
	SetBlipSprite (blip, 276)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.590)
	SetBlipColour (blip, 2)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("<FONT FACE='A9eelsh'>ﻲﺑﻮﻨﺠﻟﺍ ﻱﺪﻧﺎﺳ ﻚﻨﺑ")
	EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
	Citizen.Wait(500)
	local blip = AddBlipForCoord(5.23, -707.73, 222.73)
	
	SetBlipSprite (blip, 276)
	SetBlipDisplay(blip, 0)
	SetBlipScale  (blip, 1.30)
	SetBlipColour (blip, 70)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("<FONT FACE='A9eelsh'>ﻲﻤﻟﺎﻌﻟﺍ 101 ﺔﻨﻳﺪﻣ ﻚﻨﺑ")
	EndTextCommandSetBlipName(blip)
end)

AddEventHandler('esx_kr_shop:hasEnteredMarker', function(zone, plate)
	if zone == 2000 then --foodtruck
		ShopId = zone
	    local isOwnerOpen = false
		local IsPlate = false
		ESX.TriggerServerCallback('esx_kr_shop:getOwnedShop', function(data, grade)
			if data ~= nil then
				if grade > 0 then 
					isOwnerOpen = true
				end
				if data.plate == plate then
					IsPlate = true
				end
			end
			if IsPlate == true then				
				if isOwnerOpen then
					ShopId = zone
					number = plate
					Msg  = _U('press_to_open_owner')
				else
					ShopId = zone
					number = plate
					Msg  = _U('press_to_open')
				end
			else
			end
		end, plate, ShopId)
		
	else
		if zone == 'center' then
			ShopId = zone
			number = zone
			Msg  = _U('press_to_open_center')
		elseif zone == 'crafting' then
			ShopId = zone
			Msg  = '<font face="A9eelsh">ﺡﻼﺴﻟﺍ ﻊﻴﻨﺼﺘﻟ ~y~E ~w~ﻂﻐﺿﺇ'
		elseif zone <= 100 then
			ShopId = zone
			number = zone
			Msg  = _U('press_to_open')
		elseif zone >= 100 then
			ShopId = zone
			number = zone
			Msg  = _U('press_to_rob')
		end
	end
end)

AddEventHandler('esx_kr_shop:hasExitedMarker', function(zone)
	BLOCKINPUTCONTROL = false
	ShopId = nil
end)

local TimerrrrkNdd = 0

Citizen.CreateThread(function (); while not configready do Citizen.Wait(1000) end
 	 while true do
		Citizen.Wait(0)

		if ShopId ~= nil then

			SetTextComponentFormat('STRING')
			AddTextComponentString(Msg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if not IsControlPressed(1, 19) and IsControlJustReleased(0, Keys['E']) then
				if TimerrrrkNdd == 0 then
					TimerrrrkNdd = 1
					Citizen.SetTimeout(3000, function()
						TimerrrrkNdd = 0
					end)
					if ShopId == 'center' then
						exports['pogressBar']:drawBar(1000, 'جار التنفيذ')
						Citizen.SetTimeout(1000, function()
							OpenShopCenter()
						end)
					elseif ShopId == 'crafting' then
						exports['pogressBar']:drawBar(1000, 'جار التنفيذ')
						Citizen.SetTimeout(1000, function()
							CraftingWeapons()
						end)
					elseif ShopId == 2000 then
						local msg = '<font size=5 color=white>جاري التنفيذ'
						TriggerEvent('pogressBar:drawBar', 2000, msg)
						DisableAllControlActions(0)
						Citizen.Wait(2000)
						if number == nil then
							ESX.ShowNotification("<font size=5 color=orange>هاذا المتجر ليس مملوك لشخص</font>")
							_disableAllControlActions = false
						else
							ESX.TriggerServerCallback('esx_kr_shop:getOwnedShop', function(data, grade)
								ESX.TriggerServerCallback('esx_kr_shop:getShopItems', function(result, shopname)
									if data ~= nil then
										if grade > 0 then 
											Owner = true
										end
									end	
									if result ~= nil then
										SetNuiFocus(true, true)
										SendNUIMessage({type = "shop", result = result, owner = Owner})
									end	
								end, number, ShopId)
							end, number, ShopId)
							Citizen.Wait(2000)
							_disableAllControlActions = false
						end
					elseif ShopId <= 100 then
						ESX.TriggerServerCallback('esx_kr_shop:getOwnedShop', function(data)
							ESX.TriggerServerCallback('esx_kr_shop:getShopItems', function(result)
								if data ~= nil then
									Owner = true
								end
	
								if result ~= nil then
									local type2 = getshoptype(number)
									SetNuiFocus(true, true)
									exports['pogressBar']:drawBar(1000, 'جار التنفيذ')
									Citizen.SetTimeout(1000, function()
										SendNUIMessage({type = "shop", type2 = type2, result = result, ShopName =  data[1].ShopName, owner = Owner})
									end)
								end
							end, number, ShopId)
						end, number, ShopId)
					elseif ShopId >= 100 then
						exports['pogressBar']:drawBar(1000, 'جار التنفيذ')
						Citizen.SetTimeout(1000, function()
							local panic = exports.esx_misc4:panicstate()
							ESX.TriggerServerCallback('esx_misc:getStatusStolen', function(check_is_t)
								if check_is_t.mmm2 then
									ESX.ShowNotification('<font color=orange>لايمكنك سرقة المتجر لوجود سرقة حاليا في البنك المركزي</font>')
								elseif check_is_t.sss1 then
									ESX.ShowNotification('<font color=orange>لايمكنك سرقة المتجر لوجود سرقة حاليا في بنك صغير </font>')
								elseif check_is_t.ddd2 then
									ESX.ShowNotification('<font color=orange>لايمكنك سرقة المتجر لوجود سرقة حاليا في متجر</font>')
								elseif check_is_t.crime_status then
									ESX.ShowNotification('<font color=orange>لايمكنك سرقة المتجر لوجود ممنوع الأجرام</font>')
								elseif check_is_t.senario_status then
									ESX.ShowNotification('<font color=orange>لايمكنك سرقة المتجر لوجود ممنوع ممنوع بدأ سيناريو جديد</font>')
								else
									ESX.TriggerServerCallback('getPlayerCheckOnlineBywesam:check', function(add_police)
										if add_police == 2 or add_police == 1 or add_police == 0 then
											if PlayerData.job.name == 'mechanic' or PlayerData.job.name == 'police' or PlayerData.job.name == 'agent' or PlayerData.job.name == 'ambulance' then
												ESX.ShowNotification('<font color=red>انت في وظيفة لاتسمح لك ب السرقة</font>')
											else
												ESX.ShowNotification('<font color=red>لايمكن السرقة لعدم وجود عدد كافي من الشرطة <font color=orange> 3 <font color=white>/ <font color=orange>' .. add_police)
											end
										elseif add_police >= 3 then
											if not panic['peace_time'].state and not panic['restart_time'].state and not panic['9eanh_time'].state then
												if PlayerData.job.name == 'mechanic' or PlayerData.job.name == 'police' or PlayerData.job.name == 'agent' or PlayerData.job.name == 'ambulance' then
													ESX.ShowNotification('<font color=red>انت في وظيفة لاتسمح لك ب السرقة</font>')
												else
													if exports.ESX_SystemXpLevel.ESXP_GetRank() >= 10 then
														Robbery(number - 100)
													else
														ESX.ShowNotification('<font color=orange>يجب ان تكون في مستوى 10 لسرقة المتجر</font>')
													end
												end
											else
												if PlayerData.job.name == 'mechanic' or PlayerData.job.name == 'police' or PlayerData.job.name == 'agent' or PlayerData.job.name == 'ambulance' then
													ESX.ShowNotification('<font color=red>انت في وظيفة لاتسمح لك ب السرقة</font>')
												else
													if panic['peace_time'].state then
														ESX.ShowNotification('يمنع سرقة المتاجر أثناء إعلان<font color=800080> وقت راحة')
													elseif panic['9eanh_time'].state then
														ESX.ShowNotification('يمنع سرقة المتاجر أثناء إعلان<font color=800080> وقت صيانة')
													else
														ESX.ShowNotification('يمنع سرقة المتاجر أثناء إعلان<font color=800000> وقت رستارت')
													end
												end
											end
										end
									end, 'police')
								end
							end)
						end)	
					end
				end
			elseif IsControlJustReleased(0, Keys['H']) and ShopId == 2000 then
				_disableAllControlActions = true
				Citizen.CreateThread(function()
					while _disableAllControlActions do
						Citizen.Wait(0)
						DisableAllControlActions(0)
					end
				end)
				local Owner = false		
				ESX.TriggerServerCallback('esx_kr_shop:getOwnedShop', function(data, grade)
					if data ~= nil then
						if grade > 0 then
							Owner = true
						end
					end
					if Owner then
						local msg = '<font size=5 color=white>جاري التنفيذ'
						TriggerEvent('pogressBar:drawBar', 2000, msg)
						DisableAllControlActions(0)
						Citizen.Wait(2000)						
						OpenBoss(false, 0)
						opened = true
					else
						exports.pNotify:SendNotification({text = '<center><b style="color:#ea1f1f;font-size:26px;"> إدارة المتجر متاح للموظفين والمالك فقط ',type = "alert",queue = "killer",timeout = 8000,layout = "centerLeft",})
					end
					_disableAllControlActions = false						
				end, number, ShopId)
			elseif IsControlJustReleased(0, Keys['H']) and ShopId ~= 2000 then
				ESX.TriggerServerCallback('esx_shops2:GetOwnShopNumber', function(data)
					exports['pogressBar']:drawBar(1000, 'جار التنفيذ')
					Citizen.SetTimeout(1000, function()
						if data.owneroremps and number == data.number then
							OpenBoss(data.owner, data.number)
						else
							ESX.ShowNotification('<font color=red>إدارة المتجر متاحة لصاحب المتجر والموظفين فقط</font>')
						end
					end)
				end)
			end
		end
	end
end)

RegisterNUICallback('buy', function(data, cb)
	local type = nil
	local playerPed = PlayerPedId()
	if ShopId == 2000 then
		type = "foodtruck"
	else
		type = getshoptype(number)
	end
	for i=1, #Config.Items[type], 1 do
		if Config.Items[type][i].itemConvert == data.Item then
			if Config.Items[type][i].info then
				if exports.ESX_SystemXpLevel.ESXP_GetRank() >= Config.Items[type][i].info.xp then
					if Config.Items[type][i].info.lisence then
						ESX.TriggerServerCallback('esx_license:checkLicense', function(hasLicense)
							if hasLicense then
								local hasWeapon = HasPedGotWeapon(playerPed, GetHashKey(data.Item), false)
								if hasWeapon then
									ESX.ShowNotification("لديك <font color=red>" .. Config.Items[type][i].weapon_label .. "</font> ب الفعل")
								else
									TriggerServerEvent('esx_kr_shops:Buy', number, data.Item, data.Count, securityToken, ShopId)
								end
							else
								ESX.ShowNotification('<font color=red>أنت لا تملك رخصة سلاح</font>')
							end
						end, GetPlayerServerId(PlayerId()), Config.Items[type][i].info.lisence)
					end
				else
					ESX.ShowNotification('<font color=red>الخبرة المطلوبة للسلعة </font><font color=orange>'..tostring(Config.Items[type][i].info.xp))
				end
			else
				if Config.limit_can_inv[data.Item] then
					print(data.Count)
					if tonumber(data.Count) <= tonumber(Config.limit_can_inv[data.Item].limit) then
						TriggerServerEvent('esx_kr_shops:Buy', number, data.Item, data.Count, securityToken, ShopId)
					else
						ESX.ShowNotification('لايمكنك شراء اكثر من <font color=orange>20</font> عدة عمل')
					end
				else
					TriggerServerEvent('esx_kr_shops:Buy', number, data.Item, data.Count, securityToken, ShopId)
				end
			end
		end
	end
	Cart = {}
end)

function OpenBoss(isowner_shop, number)

  	ESX.TriggerServerCallback('esx_kr_shop:getOwnedShop', function(data)

		local elements = {}
		local number = number
		local name_mtjr = nil

		if data.plate then

			number = data.plate

			name_mtjr = "المتنقل"

			table.insert(elements, {label = '<font color=#999999> رصيد المتجر المتنقل : <font color=#00EE4F>$<font color=#ffffff>' .. data.money ,    value = ''})

			table.insert(elements, {label = 'اضافة سلعة للبيع في المتجر المتنقل', value = 'putitem'})
			
			table.insert(elements, {label = 'سحب سلعة من المتجر المتنقل', value = 'takeitem'})

			table.insert(elements, {label = 'تغير سعر السلعة', value = 'resellitem'})

			table.insert(elements, {label = 'سحب نقود من رصيد المتجر المتنقل', value = 'takemoney'})

			table.insert(elements, {label = '<span style="color:#FF0E0E">بيع المتجر المتنقل: </span><span style="color:#00EE4F">$</span>' .. math.floor(data.ShopValue / Config.SellValue).."<br><span  style='color:#FF0E0E;font-size:15'>تنبيه: <span style='color:gray;'>ستفقد المركبة مع المتجر المتنقل عند البيع", value = 'sell'})

		else

			name_mtjr = data[1].ShopName

			number = number

			table.insert(elements, {label = '<font color=#999999> رصيد المتجر : <font color=#00EE4F>$<font color=#ffffff>' .. data[1].money ,    value = ''})

			table.insert(elements, {label = 'اضافة سلعة للبيع', value = 'putitem'})
			if Config.stopstore then 
				stop = data[1].stop
				--<font color=red> عدد الانذارات من   </font><font color=orange>'..data[1].stop.. "</font><font color=red>/".. Config.maxthder.. '</font>'
				table.insert(elements, {label = ' <font color=red> عدد الانذارات من   </font><font color=orange>'..data[1].stop.. "</font><font color=red>/".. Config.maxthder.. '</font><br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">  في حال كان لديك '..Config.maxthder..' انذارات فسوف يتم سحب المتجر (تلقائي)', value = ''})
				if stop >= Config.maxthder then
					table.insert(elements, {label = '<font color=#CB120D> سوف يتم اغلاق المتجر بعد 60 ثانية يرجى سحب الاموال  </font>',    value = 'putmoney'})
				end
			end	
			if isowner_shop then

				table.insert(elements, {label = 'سحب سلعة من المتجر',    value = 'takeitem'})
			end

			table.insert(elements, {label = '<font color=orange>ايداع</font> نقود في رصيد المتجر',    value = 'putmoney'})

			if isowner_shop then

				table.insert(elements, {label = '<font color=orange>سحب</font> نقود من رصيد المتجر',    value = 'takemoney'})

			end

			table.insert(elements, {label = 'تغيير سعر سلعة في المتجر',    value = 'resellitem'})

			if isowner_shop then

				table.insert(elements, {label = 'إدارة الموظفين',    value = 'emps'})

				table.insert(elements, {label = '<font color=#F98A1B>تغيير اسم المتجر مقابل : <font color=#00EE4F>$<font color=#ffffff>' .. Config.ChangeNamePrice,    value = 'changename'})

				table.insert(elements, {label = '<font color=#CB120D>بيع متجرك مقابل : <font color=#00EE4F>$<font color=#ffffff>' .. math.floor(data[1].ShopValue / Config.SellValue),   value = 'sell'})

			end
		end
		if Config.stopstore then 
			if stop >= Config.maxthder then
				ESX.TriggerServerCallback('esx_adminjob:wesamwzarhshop', function() 
				end)
			end
		end	
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boss', {
			title    = 'إدارة متجر <font color=gray>'..name_mtjr..'</font>',
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
			if data.current.value == 'putitem' then
				exports['pogressBar']:drawBar(1000, 'جار التنفيذ')
				Citizen.SetTimeout(1000, function()
					PutItem(number)
				end)
			elseif data.current.value == 'resellitem' then
				if name_mtjr == "المتنقل" then
					resellitem(number, true)
				else
					resellitem(number, false)
				end
			elseif data.current.value == 'emps' then
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'emps', {
					title    = 'إدارة الموظفين',
					align    = 'bottom-right',
					elements = {
						{label = '<font color=green>توظيف</font>', value = 'add_emp'},
						{label = '<font color=red>طرد</font>', value = 'remove_emp'},
					}
				}, function(data2, menu2)
					if data2.current.value == 'add_emp' then
						local playerPed = PlayerPedId()
						local playersNearby = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)

						if #playersNearby > 0 then
							local players = {}
							elements = {}

							for k,playerNearby in ipairs(playersNearby) do
								players[GetPlayerServerId(playerNearby)] = true
							end

							ESX.TriggerServerCallback('esx:getPlayerNames', function(returnedPlayers)
								for playerId,playerName in pairs(returnedPlayers) do
									table.insert(elements, {
										label = playerName,
										playerId = playerId
									})
								end

								ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'add_emp', {
									title    = 'اختر الشخص المراد توظيفه',
									align    = 'bottom-right',
									elements = elements
								}, function(data2, menu2)
									local selectedPlayer, selectedPlayerId = GetPlayerFromServerId(data2.current.playerId), data2.current.playerId
									playersNearby = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
									playersNearby = ESX.Table.Set(playersNearby)

									if playersNearby[selectedPlayer] then
										local selectedPlayerPed = GetPlayerPed(selectedPlayer)

										if IsPedOnFoot(selectedPlayerPed) and not IsPedFalling(selectedPlayerPed) then
											TriggerServerEvent('esx_shops2:setemps', number, selectedPlayerId)
										else
											ESX.ShowNotification('لايمكن توظيف اي شخص داخل المركبة')
										end
									else
										ESX.ShowNotification('<font color=red>لايوجد لاعب قريب منك</font>')
										menu2.close()
									end
								end, function(data2, menu2)
									menu2.close()
								end)
							end, players)
						else
							ESX.ShowNotification('<font color=red>لايوجد لاعب قريب منك</font>')
						end
					elseif data2.current.value == 'remove_emp' then
						ESX.TriggerServerCallback('esx_shops2:getempslist', function(data) 
								local elements3 = {}
								for i = 1, #data, 1 do
									if data[i] then
										table.insert(elements3, { label = data[i].firstname.. ' ' ..data[i].lastname, value = data[i].identifier })
									end
								end
								ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'remove_emp', {
									title    = 'اختر الشخص المراد طرده',
									align    = 'bottom-right',
									elements = elements3
								}, function(data2, menu2)
									TriggerServerEvent('esx_shops2:removeemps', number, data2.current.value)
									ESX.UI.Menu.CloseAll()
								end, function(data2, menu2)
									menu2.close()
								end)
						end, number)
					end
				end, function(data2, menu2)
					menu2.close()
				end)
			elseif data.current.value == 'takeitem' then  
				exports['pogressBar']:drawBar(1000, 'جار التنفيذ')
				Citizen.SetTimeout(1000, function()
					TakeItem(number)
				end)
			elseif data.current.value == 'takemoney' then
	
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'takeoutmoney', {
					title = 'كم تريد أن تسحب'
				}, function(data2, menu2)
					local amount = tonumber(data2.value)
					ESX.UI.Menu.CloseAll()
					TriggerServerEvent('esx_kr_shops:takeOutMoney', amount, number, securityToken, ShopId)
					menu2.close()
				end, function(data2, menu2)
					menu2.close()
				end)

			elseif data.current.value == 'putmoney' then
				ESX.UI.Menu.CloseAll()
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'putinmoney', {
				title = 'كم تريد أن تودع؟'
				}, function(data3, menu3)
					local amount = tonumber(data3.value)
					ESX.UI.Menu.CloseAll()
					TriggerServerEvent('esx_kr_shops:addMoney', amount, number, ShopId)
					menu3.close()
				end, function(data3, menu3)
					menu3.close()
				end)

			elseif data.current.value == 'sell' then
				ESX.UI.Menu.CloseAll()    

				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sell', {
					title = 'اكتب: ( نعم ) بدون أقواس للتأكيد'
				}, function(data4, menu4)
					
					if data4.value == 'نعم' then
						ESX.UI.Menu.CloseAll()
						TriggerServerEvent('esx_kr_shops:SellShop', number, securityToken, ShopId)
						menu4.close()
					end
				end, function(data4, menu4)
					menu4.close()
				end)

			elseif data.current.value == 'changename' then
				ESX.UI.Menu.CloseAll()
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'changename', {
					title = 'ماذا تريد تسمية متجرك؟'
				}, function(data5, menu5)
					TriggerServerEvent('esx_kr_shops:changeName', number, data5.value)
					menu5.close()
				end, function(data5, menu5)
					menu5.close()
				end)
			end
		end, function(data, menu)
			menu.close()
		end)
    end, number, ShopId)
end

function GetAllShipments(id, is_food_truck)

	local elements = {}

	ESX.TriggerServerCallback('esx_kr_shop:getTime', function(time)
		if is_food_truck then
			ESX.TriggerServerCallback('esx_kr_shop:getAllShipments', function(items)

				local once = true
				local once2 = true

				for i=1, #items, 1 do

					if time - items[i].time >= Config.DeliveryTime and once2 then
						table.insert(elements, {label = '<font color=white>-- <font color=green>طلبات جاهزة للتسليم<font color=white> --'})
						once2 = false
					end

					if time - items[i].time >= Config.DeliveryTime then
						table.insert(elements, {label = '<font color=white>'..items[i].label..'<font color=gray>[<font color=orange>'..items[i].count..'<font color=gray>]', value = items[i].item, price = items[i].price, idd = items[i].idd })
					end

					if time - items[i].time <= Config.DeliveryTime and once then
						table.insert(elements, {label = '<font color=white>--<font color=red>طلبات جاري شحنها للمتجر<font color=white>--'})
						once = false
					end

					if time - items[i].time <= Config.DeliveryTime then
						times = time - items[i].time
						table.insert(elements, {label = '<font color=orange>'..items[i].label .. ' - <font color=#1B76F9> الكمية : <font color=white>'..items[i].count .. ' - <font color=#1B76F9> الوقت المتبقي : <font color=white>' .. math.floor((Config.DeliveryTime - times) / 60) .. ' دقيقة' })
					end

				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'allshipments', {
					title    = '<font color=#ffffff>المستودع العام - <font color=orange>تتبع شحنات',
					align    = 'bottom-right',
					elements = elements
				}, function(data, menu)
					TriggerServerEvent('esx_kr_shops:GetAllItems', id, data.current.value, data.current.idd, securityToken, 2000)
				end, function(data, menu)
					menu.close()
				end)

			end, id, 2000)
		else
			ESX.TriggerServerCallback('esx_kr_shop:getAllShipments', function(items)

				local once = true
				local once2 = true
	
				for i=1, #items, 1 do
	
					if time - items[i].time >= Config.DeliveryTime and once2 then
						table.insert(elements, {label = '<font color=white>-- <font color=green>طلبات جاهزة للتسليم<font color=white> --'})
						once2 = false
					end
	
					if time - items[i].time >= Config.DeliveryTime then
						table.insert(elements, {label = '<font color=white>'..items[i].label..'<font color=gray>[<font color=orange>'..items[i].count..'<font color=gray>]', value = items[i].item, price = items[i].price, idd = items[i].idd })
					end
	
					if time - items[i].time <= Config.DeliveryTime and once then
						table.insert(elements, {label = '<font color=white>--<font color=red>طلبات جاري شحنها للمتجر<font color=white>--'})
						once = false
					end
	
					if time - items[i].time <= Config.DeliveryTime then
						times = time - items[i].time
						table.insert(elements, {label = '<font color=orange>'..items[i].label .. ' - <font color=#1B76F9> الكمية : <font color=white>'..items[i].count .. ' - <font color=#1B76F9> الوقت المتبقي : <font color=white>' .. math.floor((Config.DeliveryTime - times) / 60) .. ' دقيقة' })
					end
	
				end
	
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'allshipments', {
					title    = '<font color=#ffffff>المستودع العام - <font color=orange>تتبع شحنات',
					align    = 'bottom-right',
					elements = elements
				}, function(data, menu)
					TriggerServerEvent('esx_kr_shops:GetAllItems', id, data.current.value, data.current.idd, securityToken, 1)
				end, function(data, menu)
					menu.close()
				end)
	
			end, id, 1)
		end
	end)
end

function OpenShipmentDelivery(id, is_food_truck)
	ESX.UI.Menu.CloseAll()
	local elements = {}
	local type = nil
	if is_food_truck then
		type = "foodtruck"
	else
		type = getshoptype(id)
	end
	for i=1, #Config.Items[type], 1 do
		if Config.Items[type][i].Storge == nil or Config.Items[type][i].Storge ~= false then
			table.insert(elements, {labels =  Config.Items[type][i].label, label =  '<font color=white> '.. Config.Items[type][i].label .. '<font color=red> | <font color=green> $<font color=white>' .. Config.Items[type][i].price..'<font color=red> | <font color=orange>'..Config.Items[type][i].count..'</font><font color=gray> في الصندوق </font>',	value = Config.Items[type][i].item, price = Config.Items[type][i].price})
		end
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shipitem',{
		title    = '<font color=#ffffff>المستودع العام - <font color=orange>طلب منتجات جديدة',
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		menu.close()
		ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'krille', {
		title = 'كم تريد شراء ؟'
		}, function(data2, menu2)
			menu2.close()
			if is_food_truck then
				ESX.TriggerServerCallback('esx_shops2:canorder', function(canorder)
					if canorder + tonumber(data2.value) <= Config.BoxMax[type] then
						TriggerServerEvent('esx_kr_shop:MakeShipment', id, data.current.value, data.current.price, tonumber(data2.value), data.current.labels, 2000)
					else
						ESX.ShowNotification('<font color=red>لا يمكن طلب أكثر من <font color=orange>'..Config.BoxMax[type]..'</font> صندوق</font>')
					end
				end, id, 2000)
			else
				ESX.TriggerServerCallback('esx_shops2:canorder', function(canorder)
					if (canorder + tonumber(data2.value)) <= Config.BoxMax[type] or canorder == nil then
						TriggerServerEvent('esx_kr_shop:MakeShipment', id, data.current.value, data.current.price, tonumber(data2.value), data.current.labels, id)
					else
						ESX.ShowNotification('<font color=red>لا يمكن طلب أكثر من <font color=orange>'..Config.BoxMax[type]..'</font> صندوق</font>')
					end
				end, id, 1)
			end
		end, function(data2, menu2)
			menu2.close()
		end)

	end, function(data, menu)
		menu.close()
	end)
end


function TakeItem(number2)
  	local elements = {}

  	ESX.TriggerServerCallback('esx_kr_shop:getShopItems', function(result)
		for i=1, #result, 1 do
			if result[i].count > 0 then
				table.insert(elements, {name_label_remove_from_store = result[i].label, label = '<font color=gray>'..result[i].label..'</font> | <font color=orange>'..result[i].count..'</font><font color=gray> في المتجر</font> | <font color=green>$'..result[i].price..'</font>', value = 'removeitem', ItemName = result[i].item})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'takeitem', {
			title    = 'إدارة المتجر',
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
			local name = data.current.ItemName
			if data.current.value == 'removeitem' then
				menu.close()
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'howmuch', {
					title = 'كم تريد أن تأخذ؟'
				}, function(data2, menu2)
					local count = tonumber(data2.value)
					menu2.close()
					TriggerServerEvent('esx_kr_shops:RemoveItemFromShop', number2, count, name, securityToken, data.current.name_label_remove_from_store, ShopId)
				end, function(data2, menu2)
					menu2.close()
				end)
			end
		end, function(data, menu)
			menu.close()
		end)
	end, number2, ShopId)
end


function resellitem(number2, is_food_truck)

	local elements = {}
  
	ESX.TriggerServerCallback('esx_kr_shop:getShopItems', function(result)
	  	for i=1, #result, 1 do
			if result[i].count > 0 then
				table.insert(elements, {label_name_in_elem = result[i].label, label = '<font color=gray>'..result[i].label..'</font> | <font color=orange>'..result[i].count..'</font><font color=gray> في المتجر</font> | <font color=green>$'..result[i].price..'</font>', value = 'resellitem', ItemName = result[i].item})
		  	end
	  	end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'resellitem', {
			title    = 'تغيير سعر سلعة',
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
			local name = data.current.ItemName
			if data.current.value == 'resellitem' then
				menu.close()
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'resellitem2', {
					title = 'السعر الجديد'
				},function(data2, menu2)
					local count = ESX.Math.Round(tonumber(data2.value))
					menu2.close()
					if is_food_truck then
						if tonumber(data2.value) < tonumber(Config.LimitPriceFoodTruck[name].down) then
							if tonumber(data2.value) > tonumber(Config.LimitPriceFoodTruck[name].up) then
								TriggerServerEvent('esx_kr_shops:resellItem', number2, count, name, data.current.label_name_in_elem, ShopId)
								ESX.ShowNotification('<font color=green>تم تغيير سعر المنتج بنجاح</font>')
							else
								ESX.ShowNotification("لايمكنك وضع سعر المنتج اعلى من <font color=orange>" .. Config.LimitPriceFoodTruck[name].up .. "</font>")
							end
						else
							ESX.ShowNotification("لايمكنك وضع سعر المنتج اقل من <font color=orange>" .. Config.LimitPriceFoodTruck[name].down .. "</font>")
						end
					else
						print(Config.LimitPriceStores[name].down)
						print(data2.value)
						if tonumber(data2.value) >= tonumber(Config.LimitPriceStores[name].down) then
							if tonumber(data2.value) <= tonumber(Config.LimitPriceStores[name].up) then
								TriggerServerEvent('esx_kr_shops:resellItem', number2, count, name, data.current.label_name_in_elem, ShopId)
								ESX.ShowNotification('<font color=green>تم تغيير سعر المنتج بنجاح</font>')
							else
								ESX.ShowNotification("لايمكنك وضع سعر المنتج اعلى من <font color=orange>" .. Config.LimitPriceStores[name].up .. "</font>")
							end
						else
							ESX.ShowNotification("لايمكنك وضع سعر المنتج اقل من <font color=orange>" .. Config.LimitPriceStores[name].down .. "</font>")
						end
					end
				end, function(data2, menu2)
					menu2.close()
				end)
			end

		end, function(data, menu)
			menu.close()
		end)

	end, number2, ShopId)
end


function PutItem(number2)

	local type = getshoptype(number2)

  	local elements = {}

	ESX.TriggerServerCallback('esx_kr_shop:getInventory', function(result)
		for i=1, #result.items, 1 do
			
		local invitem = result.items[i]
		
			if invitem.count > 0 then
				table.insert(elements, { label = '<font color=gray>'..invitem.label .. '</font> | <font color=orange>' .. invitem.count .. '</font><font color=gray> في الحقيبة </font>', count = invitem.count, name = invitem.name})
			end
		end
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'putitem', {
			title    = 'إدارة المتجر',
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.name
			local invcount = data.current.count

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sell', {
				title = _U('how_much')
			}, function(data2, menu2)

				local count = tonumber(data2.value)
			
				if count > invcount then
					ESX.ShowNotification('<font color=red>لا يمكنك بيع أكثر مما تملك')
					menu2.close()
					menu.close()
				else
					menu2.close()
					menu.close()
					if ShopId == 2000 then
						type = "market"
					end
					for i = 1, #Config.Items[type], 1 do
						if Config.Items[type][i].item == itemName then
							if Config.Items[type][i].instore == nil or Config.Items[type][i].instore ~= false then
								local ccount = (Config.Items[type][i].count * count)
								local tyyppeeep = Config.Items[type][i].type or false
								local weaponsname = ESX.GetWeaponLabel(Config.Items[type][i].itemConvert) or false
								local levveell = 0

								if Config.Items[type][i].info then
									levveell = Config.Items[type][i].info.xp
								end
								if not tyyppeeep then
									ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sellprice', {
										title = _U('set_price')
									}, function(data3, menu3)
											local done = false
											local price = tonumber(data3.value)
											menu3.close()
											TriggerServerEvent('esx_kr_shops:setToSell', number2, Config.Items[type][i].itemConvert, ccount, price, itemName, count, Config.Items[type][i].label, tyyppeeep, weaponsname, levveell, ShopId)
									end, function(data3, menu3)
										menu3.close()
									end)
								else
									TriggerServerEvent('esx_kr_shops:setToSell', number2, Config.Items[type][i].itemConvert, ccount, Config.Items[type][i].info.price, itemName, count, Config.Items[type][i].label, tyyppeeep, weaponsname, levveell, ShopId)
								end
								done = true
								break
							end
						end
					end
					if done ~= true then
						ESX.ShowNotification('<font color=red>لا يمكن عرض هذه السلعة</font>')
					end
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
    end)
end


Citizen.CreateThread(function (); while not configready do Citizen.Wait(1000) end
  while true do
	Citizen.Wait(1)

	local coords = GetEntityCoords(PlayerPedId())
	local letsleep = true

		for k,v in pairs(Config.Zones) do
			if(27 ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 20.0 ) then
				letsleep = false
				if v.Pos.red then
					DrawMarker(23, v.Pos.x, v.Pos.y, v.Pos.z + 0.05, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.2, 180, 0, 0, 200, false, true, 2, false, false, false, false)
					DrawMarker(29, v.Pos.x, v.Pos.y, v.Pos.z + 1.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 180, 0, 0, 200, false, true, 2, false, false, false, false)
				elseif v.Pos.craft then	
					DrawMarker(1, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 0.5, 180, 0, 0, 200, false, true, 2, false, false, false, false)
				else
					DrawMarker(23, v.Pos.x, v.Pos.y, v.Pos.z + 0.05, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.2, 0, 180, 0, 200, false, true, 2, false, false, false, false)
					DrawMarker(29, v.Pos.x, v.Pos.y, v.Pos.z + 1.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 180, 0, 200, false, true, 2, false, false, false, false)
				end
	        end
	    end

		if letsleep then
			Citizen.Wait(500)
		end
    end
end)


Citizen.CreateThread(function();
	while not configready do
		Citizen.Wait(1000)
	end

	local sleep = 0

  	while true do

		sleep = 500

		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.2) then
				isInMarker  = true
				currentZone = v.Pos.number
			end
		end

		local foodTruck = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 7.0, 1951180813, 70)
		if DoesEntityExist(foodTruck) then
			local coords = GetOffsetFromEntityInWorldCoords(foodTruck, 1.2, -0.95, -1.0)
			if (GetVehicleDoorAngleRatio(foodTruck, 5)) ~= 0.0 then
				local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), coords, true)
				if distance <= 7.0 then
					DrawMarker(23, coords.x, coords.y, coords.z + 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.2, 0, 180, 0, 200, false, true, 2, false, false, false, false)
					DrawMarker(29, coords.x, coords.y, coords.z + 1.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 180, 0, 200, false, true, 2, false, false, false, false)
					sleep = 0
				end
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), coords, true) <= 1.5 then
					isInMarker = true
					currentZone = 2000
				end
			else
				DrawText3D({x=coords.x,y=coords.y,z=coords.z+2.0}, 'ﻖﻠﻐﻣ', {r=255,g=0,b=0,a=255}, 0.5)
				sleep = 0
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone = currentZone
			if currentZone == 2000 then
				plate = ESX.Game.GetVehicleProperties(foodTruck).plate
			end
			TriggerEvent('esx_kr_shop:hasEnteredMarker', currentZone, plate)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_kr_shop:hasExitedMarker', LastZone)
		end

		Citizen.Wait(sleep)
  	end
end)

function DrawText3D(coords, text, color, scale)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    --local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
  
    SetTextScale(scale, scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(color.r,color.g,color.b,color.a)
    SetTextOutline()
  
    AddTextComponentString("<FONT FACE='A9eelsh'>"..text)
    DrawText(_x, _y)
end

RegisterNetEvent('esx_kr_shops:setBlip')
AddEventHandler('esx_kr_shops:setBlip', function()

  	ESX.TriggerServerCallback('esx_kr_shop:getOwnedBlips', function(blips)
		if blips ~= nil then
			createBlip(blips)
	  	end
   	end)
end)

RegisterNetEvent('esx_kr_shops:removeBlip')
AddEventHandler('esx_kr_shops:removeBlip', function()

	for i=1, #displayedBlips do
    	RemoveBlip(displayedBlips[i])
	end

end)

AddEventHandler('playerSpawned', function(spawn)
	Citizen.Wait(500)

	ESX.TriggerServerCallback('esx_kr_shop:getOwnedBlips', function(blips)

		if blips ~= nil then
			createBlip(blips)
		end
	end)
end)



Citizen.CreateThread(function(); while not configready do Citizen.Wait(1000) end
	Citizen.Wait(500)

	ESX.TriggerServerCallback('esx_kr_shop:getOwnedBlips', function(blips)

		if blips ~= nil then
			createBlip(blips)
		end
	end)
end)

function createBlip(blips)
	while not configready do Citizen.Wait(1000) end
	for i=1, #displayedBlips do
    	RemoveBlip(displayedBlips[i])
		displayedBlips[i] = nil
	end
	for i=1, #blips, 1 do
  		for k,v in pairs(Config.Zones) do
			if v.Pos.number == blips[i].ShopNumber then
				local blip = AddBlipForCoord(vector3(v.Pos.x, v.Pos.y, v.Pos.z))
				if v.Type == 'market' then -- بقالة 
					SetBlipSprite (blip, 52)
					if blips[i].identifier == ESX.PlayerData.identifier then
						SetBlipColour (blip, 5)
					else
						SetBlipColour (blip, 2)
					end
					SetBlipDisplay(blip, 4)
				elseif v.Type == 'pharmacie' then -- صيدلية
					SetBlipSprite (blip, 153)
					if blips[i].identifier == ESX.PlayerData.identifier then
						SetBlipColour (blip, 5)
					else
						SetBlipColour (blip, 2)
					end
					SetBlipDisplay(blip, 4)
				elseif v.Type == 'rts' then -- المطاعم
					SetBlipSprite (blip, 628)
					if blips[i].identifier == ESX.PlayerData.identifier then
						SetBlipColour (blip, 5)
					else
						SetBlipColour (blip, 46)
					end
					SetBlipDisplay(blip, 2)
				elseif v.Type == 'bar' then -- بار
					SetBlipSprite (blip, 93)
					if blips[i].identifier == ESX.PlayerData.identifier then
						SetBlipColour (blip, 5)
					else
						SetBlipColour (blip, 50)
					end
					SetBlipDisplay(blip, 4)
				elseif v.Type == 'weapons' then -- محل اسلحة
					SetBlipSprite (blip, 110)
					if blips[i].identifier == ESX.PlayerData.identifier then
						SetBlipColour (blip, 5)
					else
						SetBlipColour (blip, 64)
					end
					SetBlipDisplay(blip, 4)
				elseif v.Type == 'SodaMachine' then -- براد
					SetBlipSprite (blip, 619)
					if blips[i].identifier == ESX.PlayerData.identifier then
						SetBlipColour (blip, 5)
					else
						SetBlipColour (blip, 64)
					end
					SetBlipDisplay(blip, 5)
				end
				SetBlipScale  (blip, 1.2)
				SetBlipAsShortRange(blip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("<FONT FACE='A9eelsh'>" .. blips[i].ShopName)
				EndTextCommandSetBlipName(blip)
				table.insert(displayedBlips, blip)
			end
 		end
	end
end


function createForSaleBlips()
	if showblip then

		IDBLIPS = {
			[1] = {x = 373.875,   y = 325.896,  z = 102.566, n = 1},
			[2] = {x = 2557.458,  y = 382.282,  z = 107.622, n = 2},
			[3] = {x = -3038.939, y = 585.954,  z = 6.908, n = 3},
			[4] = {x = -1487.553, y = -379.107,  z = 39.163, n = 4},
			[5] = {x = 1392.562,  y = 3604.684,  z = 33.980, n = 5},
			[6] = {x = -2968.243, y = 390.910,   z = 14.043, n = 6},
			[7] = {x = 2678.916,  y = 3280.671, z = 54.241, n = 7},
			[8] = {x = -48.519,   y = -1757.514, z = 28.421, n = 8},
			[9] = {x = 1163.373,  y = -323.801,  z = 68.205, n = 9},
			[10] = {x = -707.501,  y = -914.260,  z = 18.215, n = 10},
			[11] = {x = -1820.523, y = 792.518,   z = 137.118, n = 11},
			[12] = {x = 1698.388,  y = 4924.404,  z = 41.063, n = 12},
			[13] = {x = 1961.464,  y = 3740.672, z = 31.343, n = 13},
			[14] = {x = 1135.808,  y = -982.281,  z = 45.415, n = 14},
			[15] = {x = 25.88,     y = -1347.1,   z = 28.5, n = 15},
			[16] = {x = -1393.409, y = -606.624,  z = 29.319, n = 16},
			[17] = {x = 547.431,   y = 2671.710, z = 41.156, n = 17},
			[18] = {x = -3241.927, y = 1001.462, z = 11.830, n = 18},
			[19] = {x = 1166.024,  y = 2708.930,  z = 37.157, n = 19},
			[20] = {x = 1729.216,  y = 6414.131, z = 34.037, n = 20},
		}

		for i=1, #IDBLIPS, 1 do

			local blip2 = AddBlipForCoord(vector3(IDBLIPS[i].x, IDBLIPS[i].y, IDBLIPS[i].z))
				
				SetBlipSprite (blip2, 52)
				SetBlipDisplay(blip2, 4)
				SetBlipScale  (blip2, 0.8)
				SetBlipColour (blip2, 1)
				SetBlipAsShortRange(blip2, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString('ID: ' .. IDBLIPS[i].n)
				EndTextCommandSetBlipName(blip2)
				table.insert(AllBlips, blip2)
		end

		else
			for i=1, #AllBlips, 1 do
				RemoveBlip(AllBlips[i])
			end
		ESX.UI.Menu.CloseAll()
	end
end

--ROBBERY

RegisterNetEvent("esx_shops2_and_bnk_almrkzy:sendnui")
AddEventHandler("esx_shops2_and_bnk_almrkzy:sendnui", function(type, list, count)
	if type == "updateplayerList" then
		SendNUIMessage({action  = 'updatePlayerList', players = table.concat(list), count = count})
		SendNUIMessage({action = 'toggle'})
	elseif type == "close" then
		SendNUIMessage({action = "close"})
	end
end)

RegisterNetEvent("esx_shops2:refreshListhtml")
AddEventHandler("esx_shops2:refreshListhtml", function(shopid)
	ESX.TriggerServerCallback('esx_shops2:getlistplayersinstolen', function(playerslist, count)
		local list_player_addedd = {}
		for k,v in pairs(playerslist) do
			table.insert(list_player_addedd, ('<tr><td>%s</td>'):format(playerslist[k]["name"]))
		end
		for k4,v5 in pairs(playerslist) do
			SendNUIMessage({action  = 'updatePlayerList', players = table.concat(list_player_addedd), count = count})
			SendNUIMessage({action = 'toggle'})
		end
	end, shopid)
end)

RegisterNetEvent("esx_shops2:drawTextAcceptInviteToStolen")
AddEventHandler("esx_shops2:drawTextAcceptInviteToStolen", function(shopid)
	syncingTimer = 30
	Citizen.CreateThread(function()
		while syncingTimer > 0 do
			Citizen.Wait(1000)
			if syncingTimer > 0 then
				syncingTimer = syncingTimer - 1
			end
		end
	end)
	
	Citizen.CreateThread(function()
		while syncingTimer > 0 do
			Citizen.Wait(0)
			ESX.ShowHelpNotification(syncingTimer .. ' ﺔﻗﺮﺴﻟﺍ ﻞﻴﺠﺴﺗ ~r~ﻞﻔﻗ~y~ Y ~w~ﻂﻐﺿﺍ')
			if IsControlPressed(0, 246) then
				Citizen.Wait(500)
				TriggerServerEvent("esx_shops2:setPlayerinListStolen", GetPlayerServerId(PlayerId()), false, shopid)
				draw_list_player(shopid)
				break
			end
		end
		if syncingTimer < 1 then
			Citizen.Wait(500)
			TriggerServerEvent("esx_shops2:setPlayerinListStolen", GetPlayerServerId(PlayerId()), false, shopid)
			draw_list_player(shopid)
		end
	end)
end)

function DrawScaleform(title, description, time)
    if time == nil then
		time = 4000
	end
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
      Citizen.SetTimeout(6000, function()
        show = false
      end)
    
      while show do
        Citizen.Wait(0)
        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255) -- Draw the scaleform fullscreen
      end
    end)
end


function draw_list_player(shopid)
	TriggerServerEvent("esx_shops2:refreshToplayerClient", shopid)
	ESX.TriggerServerCallback('esx_shops2:getlistplayersinstolen', function(playerslist, count)
		local list_player_addedd = {}
		for k,v in pairs(playerslist) do
			table.insert(list_player_addedd, ('<tr><td>%s</td>'):format(playerslist[k]["name"]))
		end
		for k4,v5 in pairs(playerslist) do
			SendNUIMessage({action  = 'updatePlayerList', players = table.concat(list_player_addedd), count = count})
			SendNUIMessage({action = 'toggle'})
		end
	end, shopid)
end

function secondsToClock(seconds)
	local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

	if seconds <= 0 then
		return 0, 0
	else
		local hours = string.format("%02.f", math.floor(seconds / 3600))
		local mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)))
		local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))

		return mins, secs
	end
end

function ShowTimer()
	TimerStolen = true
	local timer = 1800
	Citizen.CreateThread(function()
		while timer > 0 do
			Citizen.Wait(1000)

			if timer > 0 then
				timer = timer - 1
			end
		end
	end)
	
	Citizen.CreateThread(function()

		while timer > 0 do
			Citizen.Wait(0)
			if TimerStolen then
				local mt, st = secondsToClock(timer)
				portDrawText(mt.. ':'..st..' : ﺔﻗﺮﺴﻟﺍ ﺖﻗﻭ')
			else
				break
			end
		end
		if timer < 1 then
			if Id ~= nil then
				TriggerServerEvent("esx_shops2:cancelstolen", Id, "end_time")
			end
		end
	end)
end

function portDrawText(text)
	SetTextFont(font)
	SetTextProportional(1)
	SetTextScale(0.0, 0.3)
	SetTextColour(187, 90, 17, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString("<FONT FACE='A9eelsh'>"..text.."</font>")
	DrawText(0.200, 0.930)
end

RegisterNetEvent("esx_shops2:cancelsuccess")
AddEventHandler("esx_shops2:cancelsuccess", function(type, name, shopid)
	if type == "owner" then
		TimerStolen = false
		DrawScaleform("<FONT FACE='A9eelsh'>~w~ﺔﻗﺮﺴﻟﺍ ﺖﻗﻭ", "<FONT FACE='A9eelsh'>~r~ﻪﻗﺮﺴﻟﺍ ﺖﻗﻭ ﻰﻬﺘﻧﺍ</font>", 6000)
		PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
		SendNUIMessage({
			action = "close",
		})
	elseif type == "not_owner" then
		SendNUIMessage({
			action = "close",
		})
		ESX.ShowNotification('<font color=red> تم إلغاء السرقة <font color=red> (لقد ذهب السارق بعيدا عن الخزنة)')
	elseif type == "end_time" then
		if blip_take_money ~= nil then
			RemoveBlip(blip_take_money)
			blip_take_money = nil
		end
		if done_take_money == true then
			done_take_money = false
		end
		if TimerStolen == true then
			TimerStolen = false
		end
		DrawScaleform("<FONT FACE='A9eelsh'>~w~ﺔﻗﺮﺴﻟﺍ ﺖﻗﻭ", "<FONT FACE='A9eelsh'>~r~ﻪﻗﺮﺴﻟﺍ ﺖﻗﻭ ﻰﻬﺘﻧﺍ</font>", 6000)
		PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
		SendNUIMessage({
			action = "close",
		})
		ESX.ShowNotification("لقد انتهى وقت السرقة")
	elseif type == "player_disconnect_from_server_the_owner" then
		if blip_take_money ~= nil then
			blip_take_money = nil
		end
		if done_take_money == true then
			done_take_money = false
		end
		if TimerStolen == true then
			TimerStolen = false
		end
		DrawScaleform("<FONT FACE='A9eelsh'>~w~ﺔﻗﺮﺴﻟﺍ ﺖﻗﻭ", "<FONT FACE='A9eelsh'>~r~ﻪﻗﺮﺴﻟﺍ ﺖﻗﻭ ﻰﻬﺘﻧﺍ</font>", 6000)
		PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
		SendNUIMessage({
			action = "close",
		})
		ESX.ShowNotification("لقد فصل " .. name .. " وتم الغاء السرقة لانه هو السارق")
	elseif type == "player_disconnect_from_server" then
		TriggerServerEvent("esx_shops2:refreshToplayerClient", shopid)
		ESX.ShowNotification("لقد فصل " .. name .. " من السيرفر وتم ازالته من السرقة")
	end
end)

RegisterNetEvent('esx_shops2:takemoney')
AddEventHandler('esx_shops2:takemoney', function(criminalscount, totalMoneyAmountend, criminalsMoneyAmountend, shopid, coords_take_money)
	done_take_money = true
	blip_take_money = AddBlipForCoord(coords_take_money)
	SetBlipSprite(blip_take_money, 500)
	SetBlipScale(blip_take_money, 0.8)
	SetBlipColour(blip_take_money, 1)
	SetBlipAsShortRange(blip_take_money, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("<FONT FACE='A9eelsh'>ﺕﺎﻗﻭﺮﺴﻤﻟﺍ ﻢﻴﻠﺴﺗ</font>")
	EndTextCommandSetBlipName(blip_take_money)
	while true do
		Citizen.Wait(0)
		if done_take_money then
			local ped = PlayerPedId()
			local mycoords = GetEntityCoords(ped)
			local dst = GetDistanceBetweenCoords(mycoords, coords_take_money, true)
			if dst < 25 then
				DrawMarker(1, coords_take_money.x, coords_take_money.y, coords_take_money.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 1.0, 255, 0, 0, 200, false, true, 2, false, false, false, false)
				if dst < 5 then
					ESX.ShowHelpNotification('~w~ﺔﻗﺮﺴﻟﺍ ﻎﻠﺒﻣ ﻡﻼﺘﺳﺍ ~y~E ~w~ ﻂﻐﺿﺍ')
					if dst < 2 then
						if IsControlPressed(0, 38) then
							TimerStolen = false
							done_take_money = false
							TriggerServerEvent("esx_shops2:getMYmoney", criminalsMoneyAmountend, shopid)
							TriggerEvent("pNotify:SendNotification", {
								text = "<font size=5 color=FFFFFF><p align=center><b> عدد المسجلين بلسرقة ".."<font size=5 color=FFAE00>"..criminalscount.."</font>"..
								"</br><font size=5 color=FFFFFF><p align=center><b>اموال غير قانوينة"..
								"</br><font size=5 color=FFFFFF><p align=center><b>اجمالي: ".."<font size=5 color=FFAE00>"..totalMoneyAmountend.."</font>"..    										
								"</br><font size=5 color=FFFFFF><p align=center><b> حصتك: ".."<font size=5 color=FFAE00>"..criminalsMoneyAmountend.."</font>",     										
								type = "success",
								queue = "left",
								timeout = 7000,
								killer = true,
								theme = "gta",
								layout = "centerLeft"
							})
							DrawScaleform("<FONT FACE='A9eelsh'>~w~ﺔﻗﺮﺴﻟﺍ ﺖﻗﻭ", "<FONT FACE='A9eelsh'>~r~ﻪﻗﺮﺴﻟﺍ ﺖﻗﻭ ﻰﻬﺘﻧﺍ</font>", 6000)
							PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
							RemoveBlip(blip_take_money)
							SendNUIMessage({
								action = "close",
							})
							break
						end
					end
				end
			end
		else
			RemoveBlip(blip_take_money)
			break
		end
	end
end)

local Var = nil
local Coordss = nil
local OnRobbery = false
local Name = nil

function Robbery(id)	

    -- TriggerServerEvent('esx_kr_shops:UpdateCurrentShop', id)

	ESX.TriggerServerCallback('esx_kr_shop-robbery:getUpdates', function(result)
		ESX.TriggerServerCallback('esx_kr_shop-robbery:getOnlinePolices', function(results)
			ESX.TriggerServerCallback('esx_misc:getStatusStolen', function(check_is_t)
				if check_is_t.mmm2 then
					ESX.ShowNotification('<font color=orange>لايمكنك سرقة المتجر لوجود سرقة حاليا في البنك المركزي</font>')
				elseif check_is_t.sss1 then
					ESX.ShowNotification('<font color=orange>لايمكنك سرقة المتجر لوجود سرقة حاليا في بنك صغير </font>')
				elseif check_is_t.nnn6 then
					ESX.ShowNotification('<font color=orange>لايمكنك سرقة المتجر لوجود ممنوع السرقة </font>')
				elseif check_is_t.ddd2 then
					ESX.ShowNotification('<font color=orange>لايمكنك سرقة المتجر لوجود سرقة حاليا في متجر</font>')
				elseif check_is_t.crime_status then
					ESX.ShowNotification('<font color=orange>لايمكنك سرقة المتجر لوجود ممنوع الأجرام</font>')
				elseif check_is_t.senario_status then
					ESX.ShowNotification('<font color=orange>لايمكنك سرقة المتجر لوجود ممنوع ممنوع بدأ سيناريو جديد</font>')
				else
					if result.cb ~= nil then
						if results >= Config.RequiredPolices then
							TriggerEvent('esx_status:getStatus', 'drunk', function(status)
								if status.val >= 250000 then
									local listtt = {}
									table.insert(listtt, '<tr><td>' .. GetPlayerName(PlayerId())  .. '</td>')
									TriggerServerEvent('esx_kr_shops-robbery:UpdateCanRob', id)
									DrawScaleform("<FONT FACE='A9eelsh'>~w~ﺔﻗﺮﺴﻟﺍ ﺖﻗﻭ", "<FONT FACE='A9eelsh'>~r~ﺔﻗﺮﺴﻟﺍ ﺖﻗﻭ ﺃﺪﺑ</font>", 6000)
									PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
									ShowTimer()
									TriggerServerEvent("esx_shops2:setPlayerinListStolen", GetPlayerServerId(PlayerId()), true, ShopId)
									SendNUIMessage({action  = 'updatePlayerList', players = table.concat(listtt), count = 1})
									SendNUIMessage({action = 'toggle'})
									local eeee = {}
									local ped222 = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 3.0)
									for k_s,playerNearby_s in ipairs(ped222) do
										TriggerServerEvent("esx_shops2:InvitePlayer", GetPlayerServerId(playerNearby_s), ShopId)
									end
									local playerPed = PlayerPedId()
									local myPos = GetEntityCoords(playerPed)
									local GPS = 'GPS: ' .. myPos.x .. ', ' .. myPos.y
									TriggerServerEvent('gksphone:jbmessage', "سرقة متجر", 0, "سرقة متجر | الموقع " .. GPS, 0, GPS, "police")
									TriggerServerEvent('gksphone:jbmessage', "سرقة متجر", 0, "سرقة متجر | الموقع " .. GPS, 0, GPS, "agent")
									TriggerServerEvent('gksphone:jbmessage', "سرقة متجر", 0, "سرقة متجر | الموقع " .. GPS, 0, GPS, "admin")
									TriggerServerEvent("esx_wesam_or_707Store:sendtochat_store")
									local coords = {
										x = Config.Zones[id].Object.x,
										y = Config.Zones[id].Object.y,
										z = Config.Zones[id].Object.z,
									}
									TriggerServerEvent("esx_misc:NoCrimetime", "StoresHave", false, 15)
									TriggerServerEvent("esx_misc:NoCrimetime", "StoresHave", true)
									TriggerServerEvent('Mody:Log:StoreLog', ""..result.name.."", "Mohammed")
									TriggerServerEvent('esx_kr_shops-robbery:NotifyOwner', "<font color=red>متجرك <font color=gray>(" .. result.name .. ')<font color=red> تحت السطو', id, 1, result.name)
									
									ESX.Game.SpawnObject(1089807209, coords, function(safe)
									SetEntityHeading(safe,  Config.Zones[id].Object.h)
									FreezeEntityPosition(safe, true)

									SetEntityHealth(safe, 7000)
									OnRobbery = true
									Var = safe
									Id = id
									Coordss = coords
									Name = result.name
									end)
								else
									ESX.ShowNotification('<font color=red> يجب أن تكون في حالة سكر بنسبة %25 لسرقة المتجر </font>')
								end
							end)
						else
							ESX.ShowNotification("<font color=red> لا يوجد عدد كافي من الشرطة " .. results .. '/' .. Config.RequiredPolices)
						end
					else
						ESX.ShowNotification("<font color=orange> هذا المتجر قد تعرض للسرقة بالفعل ، يرجى الانتظار" ..  math.floor((Config.TimeBetweenRobberies - result.time)  / 60) .. ' دقيقة ')
					end
				end
			end)
		end, 'police')
	end, id)
end




Citizen.CreateThread(function()
	while true do
        Wait(0)
			local playerpos = GetEntityCoords(PlayerPedId())
			local letsleep = true
				if OnRobbery and GetDistanceBetweenCoords(playerpos.x, playerpos.y, playerpos.z, Coordss.x, Coordss.y, Coordss.z, true) <= 15 then
					letsleep = false
					local hp = GetEntityHealth(Var)
					TriggerEvent("mt:missiontext", "~r~" .. hp/100 .. "~o~%" .. ' ~w~<font face="A9eelsh">ﺔﻧﺰﺨﻟﺍ ﺮﺴﻛ', 1000)

					if hp == 0 then
						OnRobbery = false
						syncingTimer = 0
						TriggerServerEvent('esx_kr_shops-robbery:GetReward', Id, securityToken)
						TriggerServerEvent("esx_kr_shops-robbery:NotifyOwner", '<font color=red>تم سرقة متجرك <font color=gray>(' .. Name ..')<font color=red> للأسف', Id, 2, Name)
						DeleteEntity(Var)
					end

				elseif OnRobbery and GetDistanceBetweenCoords(playerpos.x, playerpos.y, playerpos.z, Coordss.x, Coordss.y, Coordss.z, true) >= 15 then
					letsleep = false
					OnRobbery = false
					DeleteEntity(Var)
					TriggerServerEvent("esx_shops2:cancelstolen", Id, "go")
					TriggerServerEvent('esx_kr_shops-robbery:NotifyOwner', "<font color=red>محاولة سرقة في متجرك <font color=gray>(" .. Name .. ')<font color=green> فاشلة', Id, 3, Name)
					ESX.ShowNotification(_U("robbery_cancel"))	
				end
				
				if letsleep then
					Citizen.Wait(500)
				end
	end
end)

RegisterNetEvent("mt:missiontext") -- credits: https://github.com/schneehaze/fivem_missiontext/blob/master/MissionText/missiontext.lua
AddEventHandler("mt:missiontext", function(text, time)
		ClearPrints()
		SetTextEntry_2("STRING")
		AddTextComponentString(text)
		DrawSubtitleTimed(time, 1)
end)



--------------------
--	   Storge	  --
--------------------

Citizen.CreateThread( function(); while not configready do Citizen.Wait(1000) end
		while true do
			local letsleep = true
			for	i = 1, #Config.Storge, 1 do
				local ped = PlayerPedId()
				local PedLocation = GetEntityCoords(ped)
				local MarkkerNumbber = 10
				local raduis = GetDistanceBetweenCoords(PedLocation, Config.Storge[i].pos.x, Config.Storge[i].pos.y, Config.Storge[i].pos.z, true)
				if raduis <= 35.0 then
					letsleep = false
					if i == 1 then MarkkerNumbber = 11 end;if i == 2 then MarkkerNumbber = 12 end;if i == 3 then MarkkerNumbber = 13 end;if i == 4 then MarkkerNumbber = 14 end;if i == 5 then MarkkerNumbber = 15 end;if i == 6 then MarkkerNumbber = 16 end;if i == 7 then MarkkerNumbber = 17 end;if i == 8 then MarkkerNumbber = 18 end;if i == 9 then MarkkerNumbber = 19 end;
					DrawMarker(MarkkerNumbber, Config.Storge[i].pos.x, Config.Storge[i].pos.y, Config.Storge[i].pos.z + 0.2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 150, false, true, 2, false, false, false, false)
					DrawMarker(25, Config.Storge[i].pos.x, Config.Storge[i].pos.y, Config.Storge[i].pos.z - 1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 150, false, true, 2, false, false, false, false)
					if 	raduis <= 1.2 then
						ESX.ShowHelpNotification('<font face="A9eelsh">~y~E ~w~ﻡﺎﻌﻟﺍ ﻉﺩﻮﺘﺴﻤﻟﺍ ﻦﻣ ﺐﻠﻄﻠﻟ')
						if IsControlJustReleased(0, Keys['E']) then 
							ESX.TriggerServerCallback('esx_shops2:GetOwnShopNumber', function(data)
								exports['pogressBar']:drawBar(1000, 'جار التنفيذ')
								Citizen.SetTimeout(1000, function()
									if data.owneroremps then
										if data.is_food_truck then
											OpenBoss2(data.number, data.owner, true)
										else
											OpenBoss2(data.number, data.owner)
										end
									else
										ESX.ShowNotification('<font color=red>الطلب من المستودع العام لأصحاب المتاجر والموظفين فقط</font>')
									end
								end)
							end)
						end
					end
				end	
			end

			if letsleep then
				Citizen.Wait(500)
			end
			Citizen.Wait(2)
		end
end)

function OpenBoss2(number2, isowner, is_food_truck)
	ESX.UI.Menu.CloseAll()
	if is_food_truck then
		ESX.TriggerServerCallback('esx_kr_shop:getOwnedShop', function(data)
			local elements = {}
			name_m = "المتنقل"
			table.insert(elements, {label = '<font color=#999999> رصيد المتجر المتنقل : <font color=#00EE4F>$<font color=#ffffff>' .. data.money ,    value = ''})
			table.insert(elements, {label = '<font color=orange>ايداع</font> نقود في رصيد المتجر', value = 'putmoney'})
			table.insert(elements, {label = 'طلب منتجات جديدة', value = 'buy'})
			table.insert(elements, {label = '<font color=#1B76F9> تتبع الطلبات ', value = 'shipments'})
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boss', {
				title    = 'إدارة متجر <font color=orange>المتنقل</font>',
				align    = 'bottom-right',
				elements = elements
			}, function(data, menu)
				if data.current.value == 'putmoney' then
					ESX.UI.Menu.CloseAll()
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'putinmoney', {
						title = 'كم تريد أن تودع؟'
					}, function(data3, menu3)
						local amount = tonumber(data3.value)
						TriggerServerEvent('esx_kr_shops:addMoney', amount, number2, 2000)
						menu3.close()
					end, function(data3, menu3)
						menu3.close()
					end)
				elseif data.current.value == 'shipments' then
					ESX.UI.Menu.CloseAll()
					GetAllShipments(number2, true)
				elseif data.current.value == 'buy' then
					ESX.UI.Menu.CloseAll()
					OpenShipmentDelivery(number2, true)
				end
			end, function(data, menu)
				menu.close()
			end)
		end, number2, 2000)
	else
		ESX.TriggerServerCallback('esx_kr_shop:getOwnedShop', function(data)
			local elements = {}
			table.insert(elements, {label = '<font color=#999999> رصيد المتجر : <font color=#00EE4F>$<font color=#ffffff>' .. data[1].money ,    value = ''})
			table.insert(elements, {label = '<font color=orange>ايداع</font> نقود في رصيد المتجر',    value = 'putmoney'})
			table.insert(elements, {label = 'طلب منتجات جديدة', value = 'buy'})
			table.insert(elements, {label = '<font color=#1B76F9> تتبع الطلبات ', value = 'shipments'})
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boss', {
				title    = 'إدارة متجر <font color=orange>'..data[1].ShopName..'</font>',
				align    = 'bottom-right',
				elements = elements
			}, function(data, menu)
				if data.current.value == 'putmoney' then
					ESX.UI.Menu.CloseAll()
	
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'putinmoney', {
						title = 'كم تريد أن تودع؟'
					}, function(data3, menu3)
						local amount = tonumber(data3.value)
						TriggerServerEvent('esx_kr_shops:addMoney', amount, number2, 1)
						menu3.close()
					end, function(data3, menu3)
						menu3.close()
					end)
				elseif data.current.value == 'shipments' then
					ESX.UI.Menu.CloseAll()
					GetAllShipments(number2, false)
				elseif data.current.value == 'buy' then
					ESX.UI.Menu.CloseAll()
					OpenShipmentDelivery(number2, false)
				end
			end, function(data, menu)
				menu.close()
			end)
		end, number2, 1)
	end
end


--Mazad
local ShopLabell = {
	['market'] = '<font color=0059BE>متجر</font>',
	['bar'] = '<font color=7C00BE>بار</font>',
	['pharmacie'] = '<font color=F53030>صيدلية</font>',
	['rts'] = '<font color=f9a825>المطاعم</font>',
	['weapons'] = '<font color=EC7710>محل أسلحة</font>',
	['SodaMachine'] = '<font color=ECA71B>براد</font>',
}
local ShopLabell2 = {
	['market'] = 'متجر',
	['bar'] = 'بار',
	['pharmacie'] = 'صيدلية',
	['rts'] = 'مطعم',
	['weapons'] = 'محل أسلحة',
	['SodaMachine'] = 'براد',
}

function OpenShopCenter()
	ESX.UI.Menu.CloseAll()
  	local elements = {}
	local alr8m = nil
	local alfah = nil
	ESX.TriggerServerCallback('esx_kr_shop:getShopList', function(ress)
		for i=1, #ress, 1 do	
			for k,v in pairs(Config.Zones) do
				if Config.Zones[k].Pos.number == ress[i].ShopNumber then
					alfah = ShopLabell2[Config.Zones[k].Type]
					alr8m = ress[i].ShopNumber
					table.insert(elements, {label = '<font color=gray>الفئة : ' .. ShopLabell2[Config.Zones[k].Type].. ' | رقم ال'..ShopLabell2[Config.Zones[k].Type]..' : '.. ress[i].ShopNumber ..' | السعر : $'..ESX.Math.GroupDigits(ress[i].ShopValue)..'</font>', value = '3rd', number = ress[i].ShopNumber, type = Config.Zones[k].Type, data = ress[i]})
				end
			end
		end

			ESX.UI.Menu.Open( 'default', GetCurrentResourceName(), 'mazad',
            {
                title    = 'مزاد المتاجر',
                align = 'top-left', 
                elements = elements
            },
            function(data, menu) 
                local action = data.current.value

				if action == '3rd' then
					if PlayerData.job.name == 'admin' then
						--------------------------------------
						--------------------------------------
						--------------------------------------
						
						ESX.TriggerServerCallback('esx_shops2:checkmazadstartornot', function(resssss) 
							local elements5 = {}
							if resssss.done then
								table.insert(elements5, {label = '<font color=green>عرض</font>', value = '3rd2'})
								table.insert(elements5, {label = '<font color=red>رجوع</font>', value = 'cancel'})
							else
								if resssss.data.player_in_mazad_is == "is==true" then
									--print('')
								else
									for k,v in pairs(resssss.data.player_in_mazad_is) do
										local name = v.name_player
										local money = v.money
										local number = v.number
										if data.current.number == number then
											table.insert(elements5, {label = '<font color=red>المزايدين | ' .. name .. " | $" .. ESX.Math.GroupDigits(money) .. '</font>'})
										end
									end
								end
								table.insert(elements5, {label = '<font color=yellow>أعلى مزايدة | ' .. resssss.data.name_player .. ' | $'..ESX.Math.GroupDigits(resssss.data.money)..'</font>'})
								table.insert(elements5, {label = '<font color=green>المزايدة</font>', value = '3rd3222222'})
								table.insert(elements5, {label = 'إنهاء المزاد واعتماده', value = '3rd32'})
								table.insert(elements5, {label = '<font color=red>إلغاء المزاد</font>', value = '3rd3'})
							end
							ESX.UI.Menu.Open( 'default', GetCurrentResourceName(), 'mazad2',
								{
									title    = 'التحكم بال'..ShopLabell2[data.current.type]..' رقم '..data.current.number,
									align = 'top-left', 
									elements = elements5
								},
								function(data2, menu2)
									local action2 = data2.current.value

									if action2 == '3rd2' then
										TriggerServerEvent('esx_shops2:mazaddd', data.current.data, ShopLabell2[data.current.type], 0, 'add', securityToken, ShopLabell2[data.current.type], ShopLabell2[data.current.type], data.current.number)
										menu2.close()
									elseif action2 == 'cancel' then
										menu2.close()
									elseif action2 == '3rd3' then
										TriggerServerEvent('esx_shops2:mazaddd', data.current.data, ShopLabell2[data.current.type], 0, 'remove', securityToken)
										menu2.close()
									elseif action2 == '3rd32' then
										TriggerServerEvent('esx_shops2:mazaddd', data.current.data, ShopLabell2[data.current.type], 0, 'close', securityToken, ShopLabell2[data.current.type], ShopLabell2[data.current.type], data.current.number, ESX.Math.GroupDigits(resssss.data.money))
										menu2.close()
									elseif action2 == '3rd3222222' then
										ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'SSSSSSSSSS', {
											title = 'المزايدة من $'..ESX.Math.GroupDigits(Config.Mazad.L)..' إلى $'..ESX.Math.GroupDigits(Config.Mazad.H)
										}, function(data3, menu3)
							  
											local amountttttt = tonumber(data3.value)
										
											TriggerServerEvent('esx_shops2:mazaddd', data.current.data, ShopLabell2[data.current.type], amountttttt, 'playermazad', securityToken)
											menu3.close()
										end, function(data3, menu3)
											menu3.close()
										end)
									end

								end, function(data2, menu2)
									menu2.close()
								end)
						end, data.current.number)
					else

						ESX.TriggerServerCallback('esx_shops2:checkmazadstartornot', function(resssss) 
							local elements5 = {}
							if resssss.done then
								--table.insert(elements5, {label = '<font color=yellow>أعلى مزايدة | ' .. "لايوجد احد مزايد" .. ' | $0</font>', value = ''})
							else
								if resssss.data.player_in_mazad_is == "is==true" then
									--print('')
								else
									for k,v in pairs(resssss.data.player_in_mazad_is) do
										local name = v.name_player
										local money = v.money
										local number = v.number
										if data.current.number == number then
											table.insert(elements5, {label = '<font color=red>المزايدين | ' .. name .. " | $" .. ESX.Math.GroupDigits(money) .. '</font>'})
										end
									end
								end
								table.insert(elements5, {label = '<font color=yellow>أعلى مزايدة | ' .. resssss.data.name_player .. ' | $'..ESX.Math.GroupDigits(resssss.data.money)..'</font>'})
								table.insert(elements5, {label = '<font color=green>المزايدة</font>', value = '3rd3222222'})
							end
							ESX.UI.Menu.Open( 'default', GetCurrentResourceName(), 'mazad2',
								{
									title    = 'التحكم بال'..ShopLabell2[data.current.type]..' رقم '..data.current.number,
									align = 'top-left', 
									elements = elements5
								},
								function(data2, menu2)
									local action2 = data2.current.value

									if action2 == '3rd2' then
										TriggerServerEvent('esx_shops2:mazaddd', data.current.data, ShopLabell2[data.current.type], 0, 'add', securityToken)
										menu2.close()
									elseif action2 == 'cancel' then
										menu2.close()
									elseif action2 == '3rd3' then
										TriggerServerEvent('esx_shops2:mazaddd', data.current.data, ShopLabell2[data.current.type], 0, 'remove', securityToken)
										menu2.close()
									elseif action2 == '3rd32' then
										TriggerServerEvent('esx_shops2:mazaddd', data.current.data, ShopLabell2[data.current.type], 0, 'close', securityToken)
										menu2.close()
									elseif action2 == '3rd3222222' then
										ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'SSSSSSSSSS', {
											title = 'المزايدة من $'..ESX.Math.GroupDigits(Config.Mazad.L)..' إلى $'..ESX.Math.GroupDigits(Config.Mazad.H)
										}, function(data3, menu3)
							  
											local amountttttt = tonumber(data3.value)
										
											TriggerServerEvent('esx_shops2:mazaddd', data.current.data, ShopLabell2[data.current.type], amountttttt, 'playermazad', securityToken)
											menu3.close()
										end, function(data3, menu3)
											menu3.close()
										end)
									end

								end, function(data2, menu2)
									menu2.close()
								end)
						end, data.current.number)

						--------------------------------------
						--------------------------------------
						--------------------------------------
					end
				end

            end, function(data, menu) 
                menu.close()
            end)
	end)
end

---------------------
-- WEAPONS - CRAFT --
---------------------

Citizen.CreateThread( function()
	while true do
		Citizen.Wait(1)
		if BLOCKINPUTCONTROL then
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
			DisableControlAction(0, Keys['F2'], true) -- Inventory
			DisableControlAction(0, Keys['F3'], true) -- Animations
			DisableControlAction(0, Keys['F6'], true) -- Job

			DisableControlAction(0, Keys['V'], true) -- Disable changing view
			DisableControlAction(0, Keys['C'], true) -- Disable looking behind
			DisableControlAction(0, Keys['X'], true) -- Disable clearing animation
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
	end
end)


function CraftingWeapons()
	ESX.TriggerServerCallback('esx_shops2:CraftWeap9923ons2', function(okk2)
		if okk2 then
			ESX.UI.Menu.Open( 'default', GetCurrentResourceName(), 'CRAFT',
			{
				title    = 'قائمة تصنيع سلاح',
				align = 'top-left', 
				elements = {
					{ label = 'رشاش مايكرو', value = 'WEAPON_MICROSMG_box' },
					{ label = 'شوزن', value = 'WEAPON_PUMPSHOTGUN_box' },
				}
			},
			function(data2, menu2)
					ESX.TriggerServerCallback('esx_shops2:CraftWeap9923ons', function(okk)
						if okk then
							BLOCKINPUTCONTROL = true
							local msgg = 'تتم الآن عملية تصنيع سلاح</br><font size=4>النوع: '..data2.current.label..'</br><font color=orange>الرجاء الإنتظار</font></font>'
							TriggerEvent("pNotify:SendNotification", {
								text = "<font size=5 color=white><center><b>"..msgg,
								type = 'success',
								queue = left,
								timeout = Config.WeaponCraftTime,
								killer = false,
								theme = "gta",
								layout = "CenterLeft",
							})
							ESX.UI.Menu.CloseAll()
							Citizen.Wait(Config.WeaponCraftTime)
							BLOCKINPUTCONTROL = false
							ESX.ShowNotification('<font color=green>تم تصنيع السلاح بنجاح</font>')
						end
					end, data2.current.value)
			end, function(data2, menu2)
				menu2.close()
			end)
		else
			ESX.ShowNotification('<font color=red>تصنيع السلاح متاح لمالك متجر الأسلحة والموظفين</font>')
		end
	end)
end

-- Create blips
Citizen.CreateThread(function(); while not configready do; Citizen.Wait(1000); end
	local pPSOS = Config.Zones.crafting.Pos
	local blip = AddBlipForCoord(pPSOS.x, pPSOS.y, pPSOS.z)

	SetBlipSprite (blip, 110)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, 1)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName('<FONT FACE="A9eelsh">ﺡﻼﺳ ﻊﻴﻨﺼﺗ')
	EndTextCommandSetBlipName(blip)
end)

local blipRobbery = nil

function setblip_robbery(position)
	blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
	SetBlipSprite(blipRobbery , 161)
	SetBlipScale(blipRobbery , 2.0)
	SetBlipColour(blipRobbery, 3)
	PulseBlip(blipRobbery)
end

RegisterNetEvent('esx_shops2:RobberyStartLeoJob')
AddEventHandler('esx_shops2:RobberyStartLeoJob', function(type, position)
	if type == 'start' then
		setblip_robbery(position)
	elseif type == 'stop' then
		RemoveBlip(blipRobbery)
	end
end)