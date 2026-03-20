local seatsTaken = {}
local currentPort = 1
local identifier_player = nil
local status_is_in_jail_or_no = nil
local is_player_have_double_xp_from_store = {}
local timer_player_in_store = {}
local is_player_have_ra3i_from_store = {}
local timer_player_in_ra3i = {}
local player_c = 0
local player_in_jail = {}
local data_ra3i = {}
local player_in_astnfar = {}
local dublexpjob = false
ESX = nil

TriggerEvent("esx:getSharedObject", function(library) 
	ESX = library 
end)

RegisterNetEvent("esx_wesam:setPlayerJailed")
AddEventHandler("esx_wesam:setPlayerJailed", function(jailtime)
	local xTarget = ESX.GetPlayerFromId(source)
	if xTarget then

		player_in_jail[xTarget.identifier] = {}

		player_in_jail[xTarget.identifier] = true

	end
end)

RegisterNetEvent("esx_wesam:setPlayerUnJailed")
AddEventHandler("esx_wesam:setPlayerUnJailed", function()
	local xTarget = ESX.GetPlayerFromId(source)
	if xTarget then
		if player_in_jail[xTarget.identifier] then

			player_in_jail[xTarget.identifier] = nil

		end
	end
end)

ESX.RegisterServerCallback("sistema_bebidas:validarcompra", function(source, callback) -- مكينة الكوكوكولا
	local player = ESX.GetPlayerFromId(source)

	if player then
		if player.getMoney() >= Config.colaprice then
			player.removeMoney(Config.colaprice)
			callback(true)
		else
			callback(false)
		end
	else
		callback(false)
	end
end) --]]

RegisterServerEvent('esx_tgo_watercoolers:refillThirst') -- برادة الماء
AddEventHandler('esx_tgo_watercoolers:refillThirst', function()
	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
end) --]]

RegisterServerEvent('va:getPlayerIdentifiers') -- رسائل الشات التلقائية
AddEventHandler('va:getPlayerIdentifiers', function()
    if GetPlayerIdentifiers(source) ~= nil then
        TriggerClientEvent('va:setPlayerIdentifiers', source, GetPlayerIdentifiers(source))
    end
end) -- end رسائل الشات التلقائية

RegisterServerEvent("lvc_TogDfltSrnMuted_s") -- نظام السفتي lux_vehcontrol
AddEventHandler("lvc_TogDfltSrnMuted_s", function(toggle)
	TriggerClientEvent("lvc_TogDfltSrnMuted_c", -1, source, toggle)
end)

RegisterServerEvent("lvc_SetLxSirenState_s")
AddEventHandler("lvc_SetLxSirenState_s", function(newstate)
	TriggerClientEvent("lvc_SetLxSirenState_c", -1, source, newstate)
end)

RegisterServerEvent("lvc_TogPwrcallState_s")
AddEventHandler("lvc_TogPwrcallState_s", function(toggle)
	TriggerClientEvent("lvc_TogPwrcallState_c", -1, source, toggle)
end)

RegisterServerEvent("lvc_SetAirManuState_s")
AddEventHandler("lvc_SetAirManuState_s", function(newstate)
	TriggerClientEvent("lvc_SetAirManuState_c", -1, source, newstate)
end)

RegisterServerEvent("lvc_TogIndicState_s")
AddEventHandler("lvc_TogIndicState_s", function(newstate)
	TriggerClientEvent("lvc_TogIndicState_c", -1, source, newstate)
end) -- end نظام السفتي lux_vehcontrol

local blockedItems = {
    [`blimp`] = true,
    [`blimp2`] = true,
    [`blimp3`] = true,
    [`frogger`] = true
}

AddEventHandler('entityCreating', function(entity)
    local model = GetEntityModel(entity)
    if blockedItems[model] then
        CancelEvent()
    end
end) -- afk kick end

RegisterServerEvent('esx_misc:tryTackle') -- ktackle شفت + G
AddEventHandler('esx_misc:tryTackle', function(target)
	local targetPlayer = ESX.GetPlayerFromId(target)
	local xPlayer = ESX.GetPlayerFromId(source)
    
	if xPlayer.job.name == 'police' or xPlayer.job.name == 'agent' or xPlayer.job.name == 'admin' then
		TriggerClientEvent('esx_misc:getTackled', targetPlayer.source, source)
		TriggerClientEvent('esx_misc:playTackle', source)
	else
		print(('esx_misc: %s attempted to tryTackle (not cop)!'):format(xPlayer.identifier))
	end
end)
RegisterServerEvent('esx_misc:onlineplayersserver') 
AddEventHandler('esx_misc:onlineplayersserver', function()
	TriggerClientEvent("esx_misc:onlineplayers", -1, GetPlayers())	
end)

RegisterNetEvent('esx_misc:set_original_player_server')
AddEventHandler('esx_misc:set_original_player_server', function(counter_new_player_original)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.identifier == "06ad5523e658aaa16b8bc47327a34e423d0ce090" or xPlayer.identifier == "c8f437ebc84144bf12518a726fa67df096b3724b" or xPlayer.identifier == "06ad5523e658aaa16b8bc47327a34e423d0ce090" then
		TriggerClientEvent('esx_misc:set_new_player', -1, "too_match", counter_new_player_original)
	end
end)

RegisterNetEvent('esx_misc:set_new_player_server')
AddEventHandler('esx_misc:set_new_player_server', function(info, firstName, last_name)
	local GETP = GetPlayers()
	local GET = #GETP
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.identifier == "06ad5523e658aaa16b8bc47327a34e423d0ce090" or xPlayer.identifier == "c8f437ebc84144bf12518a726fa67df096b3724b" or xPlayer.identifier == "06ad5523e658aaa16b8bc47327a34e423d0ce090" then
		if info.type == "n" then
			if info.na == "with_s" then
				TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2 تسجيل دخول | ^3جديد او من غير هوية^7 |^7 ' .. firstName .. " " .. last_name ..'')
				TriggerClientEvent('esx_misc:set_new_player', -1, "new")
				player_c = player_c + 1
			elseif info.na == "with_out_s" then
				TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2 تسجيل دخول | ^3جديد او من غير هوية^7 |^7 ' .. firstName ..'')
				TriggerClientEvent('esx_misc:set_new_player', -1, "new")
				player_c = player_c + 1
			end
		elseif info.type == "g" then
			TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2 تسجيل دخول |^7 ' ..firstName .. ' ' .. last_name..' ')
			TriggerClientEvent('esx_misc:set_new_player', -1, "new")
			player_c = player_c + 1
		elseif info.type == "l" then
			TriggerClientEvent('esx_misc:set_new_player', -1, "leave")
			player_c = player_c - 1
		end
	end
end)



RegisterServerEvent('esx_misc:unhandcuff')
AddEventHandler('esx_misc:unhandcuff', function(target)
	local targetPlayer = ESX.GetPlayerFromId(target)
    local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' or xPlayer.job.name == 'agent' or xPlayer.job.name == 'admin' then
		TriggerClientEvent('esx_misc:unhand', targetPlayer.source, source)
	    TriggerClientEvent('esx_misc:unhands', source)
	else
	print(('esx_misc: %s attempted to unhandcuff (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_misc:drag')
AddEventHandler('esx_misc:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' or xPlayer.job.name == 'agent' or xPlayer.job.name == 'admin' then
		TriggerClientEvent('esx_misc:drag', target, source)
	else
		print(('esx_misc: %s attempted to drag (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_misc:putInVehicle')
AddEventHandler('esx_misc:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' or xPlayer.job.name == 'agent' or xPlayer.job.name == 'admin' then
		TriggerClientEvent('esx_misc:putInVehicle', target)
	else
		print(('esx_misc: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_misc:OutVehicle')
AddEventHandler('esx_misc:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' or xPlayer.job.name == 'agent' or xPlayer.job.name == 'admin' then
		TriggerClientEvent('esx_misc:OutVehicle', target)
	else
		print(('esx_misc: %s attempted to drag out from vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

local Cooldown_count = 0
function Cooldown(sec)
	CreateThread(function()
		Cooldown_count = sec
		while Cooldown_count ~= 0 do
			Cooldown_count = Cooldown_count - 1
			Wait(1000)
		end	
		Cooldown_count = 0
	end)	
end
----------------
---PanicButton--
----------------

Pnaic_Data = { -- chatStart='عند البدأ', chatEnd='عند إطفاء حالة الأمن تظهر هاذه الرسالة',
    --# admin things
	['peace_time'] = {state=false, timePeriod=0, panic_time = 0, chatEnd='تم إنتهاء ^6وقت الراحة^0', Thelabel='وقت راحة', DrawText='ﺔﺣﺍﺭ ﺖﻗﻭ', Thecoords=vector3(124.6,1676.8,228.3), Thedistance=7000.0},
	['restart_time'] = {state=false, timePeriod=0, panic_time = 0, chatEnd='تم إنتهاء ^1وقت ريستارت^0', Thelabel='ﻭﻗﺖ ﺭﻳﺴﺘﺎﺭﺕ', DrawText='ﺕﺭﺎﺘﺴﻳﺭ ﺖﻗﻭ', Thecoords=vector3(124.6,1676.8,228.3), Thedistance=7000.0},
	['hacker'] = {chatStart='تم إطلاق صافرة إنذار ^3مكافحة الهكر^0 الرجاء التحلي بالهدوء الى أن يتم التخلص من الحثالة', chatEnd='إنتهاء صافرة إنذار ^3مكافحة الهكر^0. شكرا لتعاونكم',state=false, Thelabel='مكافحة الهكر', DrawText='ﺮﻜﻬﻟﺍ ﺔﺤﻓﺎﻜﻣ', Thecoords=vector3(124.6,1676.8,228.3), Thedistance=7000.0},
	['9eanh_time'] = {state=false, timePeriod=0, panic_time = 0, chatEnd='تم إنتهاء ^1وقت صيانة^0', Thelabel='ﻭﻗﺖ صيانة', DrawText='ﺔﻧﺎﻴﺻ ﺖﻗﻭ', Thecoords=vector3(124.6,1676.8,228.3), Thedistance=7000.0},

	
	['my_location_safezone'] = {chatStart='تم إعلان حالة ^2ﻣﻮﻗﻊ ﺁﻣﻦ^0 الرجاء اتباع ارشادات المراقب في ^2الموقع^0 والالتزام بالقوانين', chatEnd='إنتهاء حالة ^2ﻣﻮﻗﻊ ﺁﻣﻦ^0', state=false, Thelabel='ﻣﻮﻗﻊ ﺁﻣﻦ', DrawText='ﻦﻣﺁ ﻊﻗﻮﻣ', ThecoordsN=nil, Thedistance=250.0},
	['restricted_area'] = {chatStart='تم إعلان ^3منطقة محظورة^0 يجب الأبتعاد وعدم المرور ^3بالمنطقة^0 وإتباع إرشادات المراقب', chatEnd='إنتهاء ^3منطقة محظورة^0 يمكن الذهاب و المرور بالمنطقة الأن', state=false, Thelabel='ﻣﻨﻄﻘﺔ ﻣﺤﻈﻮﺭﺓ', DrawText='ﺓﺭﻮﻈﺤﻣ ﺔﻘﻄﻨﻣ', ThecoordsN=nil, Thedistance=250.0},
	
	['event_start'] = {chatStart='تم إعلان ^6نقطة بداية فعالية', chatEnd='إنتهاء ^6نقطة بداية فعالية', state=false, Thelabel='', DrawText='ﺔﻴﻟﺎﻌﻓ ﺔﻳﺍﺪﺑ ﺔﻄﻘﻧ', ThecoordsN=nil, Thedistance=250.0},--نقطة بداية فعالية
	['event_location'] = {chatStart='تم إعلان ^6موقع الفعالية', chatEnd='إنتهاء ^6موقع الفعالية', state=false, Thelabel='', DrawText='ﺔﻴﻟﺎﻌﻔﻟﺍ ﻊﻗﻮﻣ', ThecoordsN=nil, Thedistance=250.0},--موقع الفعالية
	['event_registration'] = {chatStart='تم إعلان ^6موقع تسجيل الفعالية', chatEnd='إنتهاء ^6موقع تسجيل الفعالية', state=false, Thelabel='', DrawText='ﺔﻴﻟﺎﻌﻔﻟﺍ ﻞﻴﺠﺴﺗ ﻊﻗﻮﻣ', ThecoordsN=nil, Thedistance=250.0},--موقع تسجيل الفعالية
	['event_end'] = {chatStart='تم إعلان ^6نقطة نهاية الفعالية', chatEnd='إنتهاء ^6نقطة نهاية الفعالية', state=false, Thelabel='', DrawText='ﺔﻴﻟﺎﻌﻔﻟﺍ ﺔﻳﺎﻬﻧ ﺔﻄﻘﻧ', ThecoordsN=nil, Thedistance=250.0},--نقطة نهاية الفعالية
	--# Stnfar/helpme
	[1] = {chatStart='^8نداء إستغاثة', chatEnd='إنتهاء ^3نداء إستغاثة', state=false, Thelabel='نداء إستغاثة', DrawText='ﺔﺛﺎﻐﺘﺳﺇ ﺀﺍﺪﻧ', ThecoordsN=nil, Thedistance=100.0, number = 1},
	[2] = {chatStart='^8نداء إستغاثة', chatEnd='إنتهاء ^3نداء إستغاثة', state=false, Thelabel='نداء إستغاثة', DrawText='ﺔﺛﺎﻐﺘﺳﺇ ﺀﺍﺪﻧ', ThecoordsN=nil, Thedistance=100.0, number = 2},
	[3] = {chatStart='^8نداء إستغاثة', chatEnd='إنتهاء ^3نداء إستغاثة', state=false, Thelabel='نداء إستغاثة', DrawText='ﺔﺛﺎﻐﺘﺳﺇ ﺀﺍﺪﻧ', ThecoordsN=nil, Thedistance=100.0, number = 3},
	[4] = {chatStart='^8نداء إستغاثة', chatEnd='إنتهاء ^3نداء إستغاثة', state=false, Thelabel='نداء إستغاثة', DrawText='ﺔﺛﺎﻐﺘﺳﺇ ﺀﺍﺪﻧ', ThecoordsN=nil, Thedistance=100.0, number = 4},
	[5] = {chatStart='^8نداء إستغاثة', chatEnd='إنتهاء ^3نداء إستغاثة', state=false, Thelabel='نداء إستغاثة', DrawText='ﺔﺛﺎﻐﺘﺳﺇ ﺀﺍﺪﻧ', ThecoordsN=nil, Thedistance=100.0, number = 5},
	[6] = {chatStart='^8نداء إستغاثة', chatEnd='إنتهاء ^3نداء إستغاثة', state=false, Thelabel='نداء إستغاثة', DrawText='ﺔﺛﺎﻐﺘﺳﺇ ﺀﺍﺪﻧ', ThecoordsN=nil, Thedistance=100.0, number = 6},
	[7] = {chatStart='^8نداء إستغاثة', chatEnd='إنتهاء ^3نداء إستغاثة', state=false, Thelabel='نداء إستغاثة', DrawText='ﺔﺛﺎﻐﺘﺳﺇ ﺀﺍﺪﻧ', ThecoordsN=nil, Thedistance=100.0, number = 7},
	[8] = {chatStart='^8نداء إستغاثة', chatEnd='إنتهاء ^3نداء إستغاثة', state=false, Thelabel='نداء إستغاثة', DrawText='ﺔﺛﺎﻐﺘﺳﺇ ﺀﺍﺪﻧ', ThecoordsN=nil, Thedistance=100.0, number = 8},
	[9] = {chatStart='^8نداء إستغاثة', chatEnd='إنتهاء ^3نداء إستغاثة', state=false, Thelabel='نداء إستغاثة', DrawText='ﺔﺛﺎﻐﺘﺳﺇ ﺀﺍﺪﻧ', ThecoordsN=nil, Thedistance=100.0, number = 9},
	[10] = {chatStart='^8نداء إستغاثة', chatEnd='إنتهاء ^3نداء إستغاثة', state=false, Thelabel='نداء إستغاثة', DrawText='ﺔﺛﺎﻐﺘﺳﺇ ﺀﺍﺪﻧ', ThecoordsN=nil, Thedistance=100.0, number = 10},
	
	['my_location'] = {chatStart='تجربة بدأ استنفار مكان عام', chatEnd='تجربة إنهاء استنفار مكان عام', state=false, Thelabel='مكان عام', DrawText='ﻡﺎﻋ ﻥﺎﻜﻣ', ThecoordsN=nil, Thedistance=250.0, number = 1},
	['my_location_2'] = {chatStart='تجربة بدأ استنفار مكان عام', chatEnd='تجربة إنهاء استنفار مكان عام', state=false, Thelabel='مكان عام', DrawText='ﻡﺎﻋ ﻥﺎﻜﻣ', ThecoordsN=nil, Thedistance=250.0, number = 2},
	['my_location_3'] = {chatStart='تجربة بدأ استنفار مكان عام', chatEnd='تجربة إنهاء استنفار مكان عام', state=false, Thelabel='مكان عام', DrawText='ﻡﺎﻋ ﻥﺎﻜﻣ', ThecoordsN=nil, Thedistance=250.0, number = 3},
	['my_location_4'] = {chatStart='تجربة بدأ استنفار مكان عام', chatEnd='تجربة إنهاء استنفار مكان عام', state=false, Thelabel='مكان عام', DrawText='ﻡﺎﻋ ﻥﺎﻜﻣ', ThecoordsN=nil, Thedistance=250.0, number = 4},
	['my_location_5'] = {chatStart='تجربة بدأ استنفار مكان عام', chatEnd='تجربة إنهاء استنفار مكان عام', state=false, Thelabel='مكان عام', DrawText='ﻡﺎﻋ ﻥﺎﻜﻣ', ThecoordsN=nil, Thedistance=250.0, number = 5},
	['my_location_6'] = {chatStart='تجربة بدأ استنفار مكان عام', chatEnd='تجربة إنهاء استنفار مكان عام', state=false, Thelabel='مكان عام', DrawText='ﻡﺎﻋ ﻥﺎﻜﻣ', ThecoordsN=nil, Thedistance=250.0, number = 6},
	['my_location_7'] = {chatStart='تجربة بدأ استنفار مكان عام', chatEnd='تجربة إنهاء استنفار مكان عام', state=false, Thelabel='مكان عام', DrawText='ﻡﺎﻋ ﻥﺎﻜﻣ', ThecoordsN=nil, Thedistance=250.0, number = 7},
	['my_location_8'] = {chatStart='تجربة بدأ استنفار مكان عام', chatEnd='تجربة إنهاء استنفار مكان عام', state=false, Thelabel='مكان عام', DrawText='ﻡﺎﻋ ﻥﺎﻜﻣ', ThecoordsN=nil, Thedistance=250.0, number = 8},
	['my_location_9'] = {chatStart='تجربة بدأ استنفار مكان عام', chatEnd='تجربة إنهاء استنفار مكان عام', state=false, Thelabel='مكان عام', DrawText='ﻡﺎﻋ ﻥﺎﻜﻣ', ThecoordsN=nil, Thedistance=250.0, number = 9},
	['my_location_10'] = {chatStart='تجربة بدأ استنفار مكان عام', chatEnd='تجربة إنهاء استنفار مكان عام', state=false, Thelabel='مكان عام', DrawText='ﻡﺎﻋ ﻥﺎﻜﻣ', ThecoordsN=nil, Thedistance=250.0, number = 10},
	['my_location_11'] = {chatStart='تجربة بدأ استنفار مكان عام', chatEnd='تجربة إنهاء استنفار مكان عام', state=false, Thelabel='مكان عام', DrawText='ﻡﺎﻋ ﻥﺎﻜﻣ', ThecoordsN=nil, Thedistance=250.0, number = 11},
	['my_location_12'] = {chatStart='تجربة بدأ استنفار مكان عام', chatEnd='تجربة إنهاء استنفار مكان عام', state=false, Thelabel='مكان عام', DrawText='ﻡﺎﻋ ﻥﺎﻜﻣ', ThecoordsN=nil, Thedistance=250.0, number = 12},
	['my_location_13'] = {chatStart='تجربة بدأ استنفار مكان عام', chatEnd='تجربة إنهاء استنفار مكان عام', state=false, Thelabel='مكان عام', DrawText='ﻡﺎﻋ ﻥﺎﻜﻣ', ThecoordsN=nil, Thedistance=250.0, number = 13},
	['my_location_14'] = {chatStart='تجربة بدأ استنفار مكان عام', chatEnd='تجربة إنهاء استنفار مكان عام', state=false, Thelabel='مكان عام', DrawText='ﻡﺎﻋ ﻥﺎﻜﻣ', ThecoordsN=nil, Thedistance=250.0, number = 14},
	['my_location_15'] = {chatStart='تجربة بدأ استنفار مكان عام', chatEnd='تجربة إنهاء استنفار مكان عام', state=false, Thelabel='مكان عام', DrawText='ﻡﺎﻋ ﻥﺎﻜﻣ', ThecoordsN=nil, Thedistance=250.0, number = 15},

	['sea_port'] = {state=false, Thelabel='ميناء مدينة 101 البحري', DrawText='ﻱﺮﺤﺒﻟﺍ 101 ﺔﻨﻳﺪﻣ ﺀﺎﻨﻴﻣ', Thecoords=vector3(1025.65,-3116.86,5.9), Thedistance=350.0},
	['seaport_west'] = {state=false, Thelabel='ميناء مدينة 101 الغربي', DrawText='ﻲﺑﺮﻐﻟﺍ 101 ﺔﻨﻳﺪﻣ ﺀﺎﻨﻴﻣ', Thecoords=vector3(-82.3909,-2446.72,6.0085), Thedistance=190.0},
	['international_airport'] = {state=false, Thelabel='مطار الملك عبدالعزيز الدولي', DrawText='ﻲﻟﻭﺪﻟﺍ ﺰﻳﺰﻌﻟﺍﺪﺒﻋ ﻚﻠﻤﻟﺍ رﺎﻄﻣ', Thecoords=vector3(-1329.27,-2487.14,13.945), Thedistance=450.0},
	['sandy_airport'] = {state=false, Thelabel='مطار ساندي', DrawText='ﻱﺪﻧﺎﺳ ﺭﺎﻄﻣ', Thecoords=vector3(1572.59,3194.25,40.85), Thedistance=300.0},
	['farm_airport'] = {state=false, Thelabel='مطار المزارع', DrawText='ﻉﺭﺍﺰﻤﻟﺍ ﺭﺎﻄﻣ', Thecoords=vector3(2058.22,4772.77,41.11), Thedistance=150.0},
	--# Banks
	['pacific_bank'] = {state=false, Thelabel='البنك المركزي', DrawText='ﻱﺰﻛﺮﻤﻟﺍ ﻚﻨﺒﻟﺍ', Thecoords=vector3(236.81,217.99,106.29), Thedistance=250.0},
	['paleto_bank'] = {state=false, Thelabel='بنك بليتو', DrawText='ﻮﺘﻴﻠﺑ ﻚﻨﺑ', Thecoords=vector3(-109.27,6464.39,31.63), Thedistance=200.0},
	['sandy_bank'] = {state=false, Thelabel='بنك ساندي', DrawText='ﻱﺪﻧﺎﺳ ﻚﻨﺑ', Thecoords=vector3(1174.95,2705.32,38.09), Thedistance=250.0},
	--# public_garage
	['public_car_garage_los_santos'] = {state=false, Thelabel='كراج سيارات لوس', DrawText='ﺱﻮﻟ ﺕﺍﺭﺎﻴﺳ ﺝﺍﺮﻛ', Thecoords=vector3(207.32,-1464.71,29.15), Thedistance=250.0},
	['public_car_garage_sandy'] = {state=false, Thelabel='كراج سيارات ساندي', DrawText='ﻱﺪﻧﺎﺳ ﺕﺍﺭﺎﻴﺳ ﺝﺍﺮﻛ', Thecoords=vector3(1729.4,3711.37,34.22), Thedistance=250.0},
	['public_car_garage_paleto'] = {state=false, Thelabel='كراج سيارات بوليتو', DrawText='ﻮﺘﻴﻟﻮﺑ ﺕﺍﺭﺎﻴﺳ ﺝﺍﺮﻛ', Thecoords=vector3(-216.32,6251.73,31.48), Thedistance=250.0},
	--# Other location
	['army_base'] = {state=false, Thelabel='القاعدة العسكرية', DrawText='ﺔﻳﺮﻜﺴﻌﻟﺍ ﺓﺪﻋﺎﻘﻟﺍ', Thecoords=vector3(-2169.85,3121.25,32.82), Thedistance=500.0},
	['alshaheed_gardeen'] = {state=false, Thelabel='الحديقة العامة', DrawText='ﺔﻣﺎﻌﻟﺍ ﺔﻘﻳﺪﺤﻟﺍ', Thecoords=vector3(214.63,-1028.35,29.34), Thedistance=250.0},
	
	--# ports close
	['sea_port_close'] = {chatStart='تم إعلان اغلاق ^3ميناء مدينة 101 البحري^0 يمنع دخول ^3الموقع^0 حتى يتم اعلان الافتتاح', chatEnd='تم افتتاح ^3ميناء مدينة 101 البحري^0 يمكنك الاَن بيع واستلام البضائع من الموقع', state=false, Thelabel='ﺍﻟﻤﻴﻨﺎﺀ ﺍﻟﺒﺤﺮﻱ ﺍﻟﺮﺋﻴﺴﻲ', DrawText='ﻖﻠﻐﻣ ﻱﺮﺤﺒﻟﺍ 101 ﺔﻨﻳﺪﻣ ﺀﺎﻨﻴﻣ', Thecoords=vector3(1025.65,-3116.86,5.9), Thedistance=320.0},
	['seaport_west_close'] = {chatStart='تم إعلان اغلاق ^3ميناء مدينة 101 الغربي^0 يمنع دخول ^3الموقع^0 حتى يتم اعلان الافتتاح', chatEnd='تم افتتاح ^3ميناء مدينة 101 الغربي^0 يمكنك الاَن بيع واستلام البضائع من الموقع', state=false, Thelabel='ﺍﻟﻤﻴﻨﺎﺀ ﺍﻟﺒﺤﺮﻱ ﺍﻟﻐﺮﺑﻲ', DrawText='ﻖﻠﻐﻣ ﻲﺑﺮﻐﻟﺍ 101 ﺔﻨﻳﺪﻣ ﺀﺎﻨﻴﻣ', Thecoords=vector3(-82.3909,-2446.72,6.0085), Thedistance=200.0},
	['internationa_close'] = {chatStart='تم إعلان اغلاق ^3مطار الملك عبدالعزيز الدولي^0 يمنع دخول ^3الموقع^0 حتى يتم اعلان الافتتاح', chatEnd='تم افتتاح ^3مطار الملك عبدالعزيز الدولي^0 يمكنك الاَن بيع واستلام البضائع من الموقع', state=false, Thelabel='مطار الملك عبدالعزيز الدولي', DrawText='ﻖﻠﻐﻣ ﻲﻟﻭﺪﻟﺍ ﺰﻳﺰﻌﻟﺍﺪﺒﻋ ﻚﻠﻤﻟﺍ رﺎﻄﻣ', Thecoords=vector3(-1329.27,-2487.14,13.945), Thedistance=500.0},
	
}

--لاتعدل نهائيا START
Time_Data = {
	[1] = 60000,
	[2] = 120000,
	[3] = 180000,
	[4] = 240000,
	[5] = 300000,
	[6] = 360000,
	[7] = 420000,
	[8] = 480000,
	[9] = 54000,
	[10] = 600000,
	[11] = 1,
}
--لاتعدل نهائيا END

local shopItems = {}

MySQL.ready(function()

	MySQL.Async.fetchAll('SELECT * FROM weashops', {}, function(result)
		for i=1, #result, 1 do
			if shopItems[result[i].zone] == nil then
				shopItems[result[i].zone] = {}
			end

			table.insert(shopItems[result[i].zone], {
				item  = result[i].item,
				price = result[i].price,
				label = ESX.GetWeaponLabel(result[i].item),
				level = result[i].level,
			})
		end

		TriggerClientEvent('esx_weaponshop:sendShop', -1, shopItems)
	end)

end)

ESX.RegisterServerCallback('esx_weaponshop:getShop', function(source, cb)
	cb(shopItems)
end)

function GetPrice(weaponName, zone)
	local price = MySQL.Sync.fetchScalar('SELECT price, level FROM weashops WHERE zone = @zone AND item = @item', {
		['@zone'] = zone,
		['@item'] = weaponName
	})

	if price then
		return price
	else
		return 0
	end
end

ESX.RegisterServerCallback('esx_weaponshop:buyWeapon', function(source, cb, weaponName, zone)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = GetPrice(weaponName, zone)

	if price == 0 then
		print(('esx_weaponshop: %s attempted to buy a unknown weapon!'):format(xPlayer.identifier))
		cb(false)
	else
		if xPlayer.hasWeapon(weaponName) then
			xPlayer.showNotification(_U('already_owned'))
			cb(false)
		else
			if zone == 'BlackWeashop' then
				if xPlayer.getAccount('black_money').money >= price then
					xPlayer.removeAccountMoney('black_money', price)
					TriggerEvent("send:discordLogs", xPlayer.source, "**blackmarket**\nweapon : "..weaponName.."\n price: "..price, "#3AF241", "weaponbuy")
					xPlayer.addWeapon(weaponName, 100)
					
					cb(true)
				else
					xPlayer.showNotification(_U('not_enough_black'))
					cb(false)
				end
			else
				if xPlayer.getMoney() >= price then
					xPlayer.removeMoney(price)
					TriggerEvent("send:discordLogs", xPlayer.source, "**weaponshop**\nweapon : "..weaponName.."\n price: "..price, "#3AF241", "weaponbuy")
					xPlayer.addWeapon(weaponName, 100)
	
					cb(true)
				else
					xPlayer.showNotification(_U('not_enough'))
					cb(false)
				end
			end
		end
	end
end)

ESX.RegisterServerCallback('esx_weaponshop:buyLicense', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.LicensePrice then
		xPlayer.removeMoney(Config.LicensePrice)

		TriggerEvent('esx_license:addLicense', source, 'weapon', function()
			cb(true)
		end)
	else
		xPlayer.showNotification(_U('not_enough'))
		cb(false)
	end
end)

local alarm, WaitForNewStart = {}, false


RegisterServerEvent('esx_misc:TogglePanicButton')
AddEventHandler('esx_misc:TogglePanicButton', function(data1, data2, data3, data4)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	local rpname = xPlayer.getName()
	local locationsData = Config.panicButton.locationsData
	
	local deleteAllAlarms = false
	local PanicName = data1
	local coordss = data2
	local distance = 250.0
	local DrawText = ''
	local labell = ''
	local StartAfrer = ''
	if xPlayer.job.name == 'admin' or xPlayer.job.name == 'police' or xPlayer.job.name == 'agent' or xPlayer.identifier == "06ad5523e658aaa16b8bc47327a34e423d0ce090" then
		if Cooldown_count > 0 then 
			xPlayer.showNotification('<font color=red>يجب الأنتظار</font>. <font color=orange>'..Cooldown_count..' ثانية')
			return
		end
		Cooldown(5)

	  	if PanicName == 'peace_time' or PanicName == 'restart_time' or PanicName == '9eanh_time' and not WaitForNewStart then -- 60000
	  		Pnaic_Data[PanicName].timePeriod = data4
			Pnaic_Data[PanicName].panic_time = data4 * 60
	  	elseif PanicName == 'peace_time' or PanicName == 'restart_time' or PanicName == '9eanh_time' and WaitForNewStart then
	  		TriggerClientEvent('esx:showNotification', source, 'يوجد وقت راحة/ريستارت/صيانة سوف يفعل بالفعل أنتظر')
	  		return
	  	end
	  	if Pnaic_Data[PanicName].Thecoords then
	  		coordss = Pnaic_Data[PanicName].Thecoords
	  	else
	  		Pnaic_Data[PanicName].ThecoordsN = coordss
	  	end
	  	if Pnaic_Data[PanicName].Thedistance then
	  		distance = Pnaic_Data[PanicName].Thedistance
	  	end
      	if Pnaic_Data[PanicName].DrawText then
	  		TheDrawText = Pnaic_Data[PanicName].DrawText
	  	end
      	if Pnaic_Data[PanicName].Thelabel then
	  		labell = Pnaic_Data[PanicName].Thelabel
	  	end
      	if not locationsData[PanicName] then
	  		Pnaic_Data[PanicName].chatStart = 'استنفار امني في ^3'..Pnaic_Data[PanicName].Thelabel..'^0 الرجاء مغادرة ^3الموقع^0 فورا وعدم الاقتراب او محاولة الدخول حتى انتهاء حالة الخطر'
	  		Pnaic_Data[PanicName].chatEnd = 'إنتهاء حالة الخطر في ^3'..Pnaic_Data[PanicName].Thelabel..'^0'
	  	end
		
	  	print('^3'..GetPlayerName(source)..'^0 Has Toggled ^2'..data1..'^0 Panic Button ^5'..xPlayer.identifier..'^0')
		

		WASremoved = false
	  	if Pnaic_Data[PanicName].state then
	  		toRemove = 0
			if #alarm > 0 then
				for i=1, #alarm, 1 do
					if alarm[i].location == PanicName then
					    alarm[i].siren = false
						toRemove = i
					end
				end
			end

			if toRemove > 0 then
			    Pnaic_Data[PanicName].state = false
				TriggerClientEvent('esx_misc:updateStatus', -1, alarm, PanicName, true, false, false, false)
				WASremoved = true
				Wait(50)
			end
		end
		
		if WASremoved then
			MSGS = Pnaic_Data[PanicName].chatEnd
			if PanicName == "my_location" or PanicName == "my_location_2" or PanicName == "my_location_3" or PanicName == "my_location_4" or PanicName == "my_location_5" or PanicName == "my_location_6" or PanicName == "my_location_7" or PanicName == "my_location_8" or PanicName == "my_location_9" or PanicName == "my_location_10" or PanicName == "my_location_11" or PanicName == "my_location_12" or PanicName == "my_location_13" or PanicName == "my_location_14" or PanicName == "my_location_15" then
				local dead_counter = 0
				local police_job_counter = 0
				local not_police_job_counter = 0
				local level = 0
				local disconnected = 0
				local location_foor_loop = player_in_astnfar[PanicName]
				for i,x in pairs(location_foor_loop) do
					if player_in_astnfar[PanicName][i].isdead then
						dead_counter = dead_counter + 1
					end
					if player_in_astnfar[PanicName][i].isjobpolice then
						police_job_counter = police_job_counter + 1
						if level == 0 then
							level = 50
						else
							level = level + 50
						end
					end
					if player_in_astnfar[PanicName][i].isjobnotpolice then
						not_police_job_counter = not_police_job_counter + 1
					end
				end
				for i,x in pairs(location_foor_loop) do
					local xPlayer = ESX.GetPlayerFromIdentifier(i)
					if xPlayer then
						--print()
					else
						disconnected = disconnected + 1
					end
				end
				for i,x in pairs(location_foor_loop) do
					local id_me = player_in_astnfar[PanicName][i].source
					local money = police_job_counter .. "0000"
					local xPlayer = ESX.GetPlayerFromIdentifier(i)
					if xPlayer then
						if xPlayer.job.name == "police" then
							if police_job_counter == 1 then
								xPlayer.addAccountMoney("bank", tonumber(money))
								TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', id_me, 'add', level, 'تقرير الأستنفار')
								TriggerClientEvent("pNotify:SendNotification", id_me, {
									text = "<p align=center><b>الأمن <font color=#00BFFF>"..police_job_counter.."</font> | مجرم <font color=#FF0000>"..tonumber(not_police_job_counter).."</font>".."<p align=center><b>".."<font color=orange>"..dead_counter.."</font>".." مسقط" .. "<p align=center><b>" .. "<font color=orange>"..disconnected.."</font>".." فصل<p align=center><b>مكافاّة<p align=center><b>إجمالي:$<font color=#00FF00>" .. money .. "</font><p align=center><b>حصتك:$<font color=#00FF00>" .. money .. "</font><p align=center><b>خبرة<p align=center><b>إجمالي:<font color=#1E90FF>" .. level .. "</font><p align=center><b>حصتك:<font color=#1E90FF>" .. level .. "</font>",
									type = "info",
									queue = "right",
									timeout = 20000,
									layout = "centerright"
								})
							else
								xPlayer.addAccountMoney("bank", tonumber(math.floor(money / police_job_counter)))
								TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', id_me, 'add', math.floor(level / police_job_counter), 'تقرير الأستنفار')
								TriggerClientEvent("pNotify:SendNotification", id_me, {
									text = "<p align=center><b>الأمن <font color=#00BFFF>"..police_job_counter.."</font> | مجرم <font color=#FF0000>" .. tonumber(not_police_job_counter) .. "</font>".."<p align=center><b>".."<font color=orange>"..dead_counter.."</font>".." مسقط" .. "<p align=center><b>" .. "<font color=orange>"..disconnected.."</font>".." فصل<p align=center><b>مكافاّة<p align=center><b>إجمالي:$<font color=#00FF00>" .. money .. "</font><p align=center><b>حصتك:$<font color=#00FF00>" .. tonumber(math.floor(money / police_job_counter)) .. "</font><p align=center><b>خبرة<p align=center><b>إجمالي:<font color=#1E90FF>" .. level .. "</font><p align=center><b>حصتك:<font color=#1E90FF>" .. tonumber(math.floor(level / police_job_counter)) .. "</font>",
									type = "info",
									queue = "right",
									timeout = 20000,
									layout = "centerright"
								})
							end
						end
					end
					player_in_astnfar[PanicName][i] = nil
				end
				player_in_astnfar[PanicName] = nil
			end
	  		if xPlayer["job"]["name"] == "admin" then
				if PanicName == 'peace_time' or PanicName == 'restart_time' or PanicName == '9eanh_time' then
					TriggerClientEvent('esx_ambulancejob:setGodMode', -1, "set_false")
				end
	  			TriggerClientEvent('chatMessage', -1, " ⭐ الرقابة و التفتيش  " ,  {198, 40, 40} ,  MSGS)
				if PanicName == "restart_time" then
					local data_select_car = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles')
					for i=1, #data_select_car, 1 do
						MySQL.Async.execute('UPDATE owned_vehicles SET stored = @stored WHERE plate = @plate', {
							['@plate'] = data_select_car[i].plate,
							['@stored'] = 1,
						}, function(result_0)
							--print()
						end)
					end
					local xPlayersKicked = ESX.GetPlayers()
					for i=1, #xPlayersKicked, 1 do
						local xPlayer = ESX.GetPlayerFromId(xPlayersKicked[i])
						if xPlayer then
							if xPlayer.job.name == "admin" then
								--print()
							else
								DropPlayer(xPlayer.source, 'تم طردك من السيرفر لأنتهاء وقت الريستارت\nيمكنك متابعة حالة السيرفر\nhttps://discord.gg/dhsPHxDDvQ')
							end
						end
					end
				end
	  		elseif xPlayer["job"]["name"] == "police" then
	   			TriggerClientEvent('chatMessage', -1, "👮 إدارة الشرطة | " .. rpname .." " ,  { 17, 69, 191 }, MSGS)
	  		elseif xPlayer["job"]["name"] == "agent" then
	   			TriggerClientEvent('chatMessage', -1, "💂‍ حرس الحدود  | " .. rpname .." " ,  { 78, 198, 78 }, MSGS)	
	    	elseif xPlayer["job"]["name"] == "ambulance" then
	   			TriggerClientEvent('chatMessage', -1, " 🚨 الدفاع المدني | " .. rpname .." " ,  { 196, 20, 20 }, MSGS)		
	   		else
	   			return
	  		end
			return
		end
		if PanicName == 'peace_time' or PanicName == 'restart_time' or PanicName == '9eanh_time' then -- 60000
			if data3 ~= 11 then
				if PanicName == 'peace_time' then
					TriggerClientEvent('chatMessage', -1, " ⭐ الرقابة و التفتيش  " ,  {198, 40, 40} ,  ' تم إعلان ^6وقت راحة^0 لمدة ^6'..Pnaic_Data[PanicName].timePeriod..'^0 دقيقة . يبدأ بعد ^3'..data3..'^0 دقيقة')
				elseif PanicName == 'restart_time' then
					TriggerClientEvent('chatMessage', -1, " ⭐ الرقابة و التفتيش  " ,  {198, 40, 40} ,  ' تم إعلان ^1وقت ريستارت^0 لمدة ^1'..Pnaic_Data[PanicName].timePeriod..'^0 دقيقة . يبدأ بعد ^3'..data3..'^0 دقيقة')
				elseif PanicName == '9eanh_time' then
				 TriggerClientEvent('chatMessage', -1, " ⭐ الرقابة و التفتيش  " ,  {198, 40, 40} ,  ' تم إعلان ^1وقت صيانة^0 لمدة ^1'..Pnaic_Data[PanicName].timePeriod..'^0 دقيقة . يبدأ بعد ^3'..data3..'^0 دقيقة')
				end
			end
			WaitForNewStart = true
			Wait(Time_Data[data3])
			WaitForNewStart = false		
			if #alarm > 0 then
				for i=1, #alarm, 1 do
					alarm[i].siren = false
				end
			end
		 	Wait(1)
		 	TriggerClientEvent('esx_misc:updateStatus_notifieNO', -1, alarm)
		 	Wait(1)
		   	TriggerEvent('esx_misc:timing_panic', Pnaic_Data[PanicName].timePeriod, PanicName)
	   	end

	  	if PanicName == 'peace_time' then
			TriggerClientEvent('esx_ambulancejob:setGodMode', -1, "set_true")
	   		TriggerClientEvent('chatMessage', -1, " ⭐ الرقابة و التفتيش  " ,  {198, 40, 40} ,  'تم إعلان ^6وقت راحة^0 لمدة '..'^6'..Pnaic_Data[PanicName].timePeriod..'^0 دقيقة'..' يمنع العمل الاجرامي وتعطل جميع الدوائر الحكومية والخاصة حتى انقضاء المدة')
	   	elseif PanicName == 'restart_time' then
			TriggerClientEvent('esx_ambulancejob:setGodMode', -1, "set_true")
	   		TriggerClientEvent('chatMessage', -1, " ⭐ الرقابة و التفتيش  " ,  {198, 40, 40} ,  'تم إعلان ^1وقت ريستارت^0 لمدة '..'^1'..Pnaic_Data[PanicName].timePeriod..'^0 دقيقة'..' يمنع عمل سناريو جديد وحاول ان تفصل قبل انقضاء الوقت المحدد.تشدد عقوبة التخريب اثناء وقت الرستارت.')
	   	elseif PanicName == '9eanh_time' then
			TriggerClientEvent('esx_ambulancejob:setGodMode', -1, "set_true")
			TriggerClientEvent('chatMessage', -1, " ⭐ الرقابة و التفتيش  " ,  {198, 40, 40} ,  'تم إعلان ^6وقت صيانة^0 لمدة '..'^6'..Pnaic_Data[PanicName].timePeriod..'^0 دقيقة'..' يمنع العمل الاجرامي وتعطل جميع الدوائر الحكومية والخاصة حتى انقضاء المدة')
	   	else
			MSGS = Pnaic_Data[PanicName].chatStart
	  		if xPlayer["job"]["name"] == "admin" then
	  			TriggerClientEvent('chatMessage', -1, " ⭐ الرقابة و التفتيش  " ,  {198, 40, 40} ,  MSGS)
	  		elseif xPlayer["job"]["name"] == "police" then
	   			TriggerClientEvent('chatMessage', -1, "👮 إدارة الشرطة | " .. rpname .." " ,  { 17, 69, 191 }, MSGS)
	  		elseif xPlayer["job"]["name"] == "agent" then
	   			TriggerClientEvent('chatMessage', -1, "💂‍ حرس الحدود  | " .. rpname .." " ,  { 78, 198, 78 }, MSGS)	
	    	elseif xPlayer["job"]["name"] == "ambulance" then
	   			TriggerClientEvent('chatMessage', -1, " 🚨 الدفاع المدني | " .. rpname .." " ,  { 196, 20, 20 }, MSGS)		
	  		end
	  	end
	  	local yes_i = false
		local is_my = false
	  	if PanicName == 1 or PanicName == 2 or PanicName == 3 or PanicName == 4 or PanicName == 5 or PanicName == 6 or PanicName == 7 or PanicName == 8 or PanicName == 9 or PanicName == 10 then
			table.insert(alarm, {location = PanicName, name = TheDrawText, coords=coordss, dist = distance, siren = true, label = labell, helpMe = true})
			yes_i = true
		elseif PanicName == "my_location" or PanicName == "my_location_2" or PanicName == "my_location_3" or PanicName == "my_location_4" or PanicName == "my_location_5" or PanicName == "my_location_6" or PanicName == "my_location_7" or PanicName == "my_location_8" or PanicName == "my_location_9" or PanicName == "my_location_10" or PanicName == "my_location_11" or PanicName == "my_location_12" or PanicName == "my_location_13" or PanicName == "my_location_14" or PanicName == "my_location_15" then
			table.insert(alarm, {location = PanicName, name = TheDrawText, coords=coordss, dist = distance, siren = true, label = labell, myLoc = true, enable = true})
			is_my = true
	  	else
			table.insert(alarm, {location = PanicName, name = TheDrawText, coords=coordss, dist = distance, siren = true, label = labell})
	  	end
	  	Pnaic_Data[PanicName].state = true
	  	Wait(100)
	  	if yes_i then
	  		TriggerClientEvent('esx_misc:updateStatus', -1, alarm, PanicName, false, {name_run = PanicName, number = Pnaic_Data[PanicName].number, helpMe = true})
		elseif is_my then
			TriggerClientEvent('esx_misc:updateStatus', -1, alarm, PanicName, false, {name_run = PanicName, number = Pnaic_Data[PanicName].number, myLoc = true}, coordss, distance)
	  	else
			TriggerClientEvent('esx_misc:updateStatus', -1, alarm, PanicName, true, false, false, false)
	  	end
	else
		print(('esx_misc: ^1%s^0 attempted to TogglePanicButton %s (not allowed!)!'):format(xPlayer.identifier, data1))
	end
end)

local myLocationList = {
	'my_location',
	'my_location_2',
	'my_location_3',
	'my_location_4',
	'my_location_5',
	'my_location_6',
	'my_location_7',
	'my_location_8',
	'my_location_9',
	'my_location_10',
	'my_location_11',
	'my_location_12',
	'my_location_13',
	'my_location_14',
	'my_location_15'
}

ESX.RegisterServerCallback("esx_wesam:esx_misc:getListAstnfarStateTrue", function(source, cb)
	local list_location_started = {}
	for k,v in pairs(myLocationList) do
		if Pnaic_Data[v].state then
			table.insert(list_location_started, v)
		end
	end
	cb(list_location_started)
end)

ESX.RegisterServerCallback("esx_wesam:esx_misc:getListPlayerInAstnfar", function(source, cb, location)
	local locationData = player_in_astnfar[location]
	local list_player = {}
	if player_in_astnfar[location] then
		for k,v in pairs(locationData) do
			local xPlayer = ESX.GetPlayerFromIdentifier(k)
			if xPlayer then
				if xPlayer.job.name == "police" then
					table.insert(list_player, {label = xPlayer.getName()})
				end
			end
		end
		cb(list_player)
	end
end)

RegisterNetEvent("esx_misc:addListAstnfar")
AddEventHandler("esx_misc:addListAstnfar", function(location, info)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		if player_in_astnfar[location] == nil then
			player_in_astnfar[location] = {}
			player_in_astnfar[location][xPlayer.identifier] = {}
			player_in_astnfar[location][xPlayer.identifier] = {is_in_astnfar = info.is_in_astnfar, isdead = info.isdead, isjobpolice = info.isjobpolice, isjobnotpolice = info.isjobnotpolice, source = xPlayer.source}
		else
			if info.is_want_remove_from_list then
				player_in_astnfar[location][xPlayer.identifier] = nil
			else
				player_in_astnfar[location][xPlayer.identifier] = {is_in_astnfar = info.is_in_astnfar, isdead = info.isdead, isjobpolice = info.isjobpolice, isjobnotpolice = info.isjobnotpolice, source = xPlayer.source}
			end
		end
	end
end)

function isNoCrimetime()
	local noCrimeZone = Config.panicButton.noCrimeZone
	local data = {}
	for k,v in pairs (alarm) do
		if v.siren then
			for i=1,#noCrimeZone,1 do
				if v.location == noCrimeZone[i] then
					data.active = true
					data.location = v.location
					data.label = v.label
					return data
				end	
			end
		end
	end
	data.active = false
	return data
end

function Timer(PanicName, time)

    if Pnaic_Data[PanicName].panic_time == 0 then

		if Pnaic_Data[PanicName].state then

			toRemove = 0

			if #alarm > 0 then

				for i=1, #alarm, 1 do

					if alarm[i].location == PanicName then

						alarm[i].siren = false

						toRemove = i

					end

				end

			end

			if toRemove > 0 then

				Pnaic_Data[PanicName].state = false

				TriggerClientEvent('esx_misc:updateStatus', -1, alarm, PanicName)

				Pnaic_Data[PanicName].panic_time = 0

				TriggerClientEvent('chatMessage', -1, " ⭐ الرقابة و التفتيش  " ,  {198, 40, 40} ,  Pnaic_Data[PanicName].chatEnd)
				
			end

		end

	end

    TriggerClientEvent("esx_misc:updatePeacetimePeriod", -1, Pnaic_Data[PanicName].panic_time, PanicName)
	
    Wait(1000)

	if Pnaic_Data[PanicName].panic_time ~= 0 then

		Pnaic_Data[PanicName].panic_time = Pnaic_Data[PanicName].panic_time - 1

	end

	if Pnaic_Data[PanicName].state then

		Timer(PanicName, Pnaic_Data[PanicName].panic_time)

	end

end

RegisterNetEvent('esx_misc:timing_panic')
AddEventHandler('esx_misc:timing_panic', function(time, PanicName)
    Timer(PanicName, time)
end)

RegisterServerEvent("esx_misc:togglePort")
AddEventHandler("esx_misc:togglePort", function(newport)
    local xPlayer = ESX.GetPlayerFromId(source)
	local name_player = xPlayer.getName()
	if xPlayer.job.name == 'admin' or (xPlayer.job.name == 'agent' and xPlayer.job.grade >= 7) or (xPlayer.job.name == 'police' and xPlayer.job.grade >= 7) then
		if newport ~= currentPort then
			if Cooldown_count == 0 then 
				Cooldown(12)
				if newport == 1 then
					MSG = 'ميناء مدينة 101 البحري'
					currentPort = 1
					TriggerClientEvent("esx_misc:currentPortNum", -1, currentPort)
					TriggerClientEvent('esx_misc:watermark_port', -1, currentPort)
					MinaPlaceLog((' تحويل موقع التصدير '),"موقع التصدير ميناء مدينة 101 البحري", "*من قبل* \n"..xPlayer.job.label.."\nSteam: `".. GetPlayerName(source).."` \n "..GetPlayerIdentifiers(source)[1].." \n "..GetPlayerIdentifiers(source)[5].." \nInGame name: `"..xPlayer.getName().."`",15158332)
				elseif newport == 2 then
					MSG = 'ميناء مدينة 101 الغربي'
					currentPort = 2
					TriggerClientEvent("esx_misc:currentPortNum", -1, currentPort)
					TriggerClientEvent('esx_misc:watermark_port', -1, currentPort)
					MinaPlaceLog((' تحويل موقع التصدير '),"موقع التصدير ميناء مدينة 101 الغربي", "*من قبل* \n"..xPlayer.job.label.."\nSteam: `".. GetPlayerName(source).."` \n "..GetPlayerIdentifiers(source)[1].." \n "..GetPlayerIdentifiers(source)[5].." \nInGame name: `"..xPlayer.getName().."`",15158332)
				elseif newport == 3 then
					MSG = 'مطار الملك عبدالعزيز الدولي'
					currentPort = 3
					TriggerClientEvent("esx_misc:currentPortNum", -1, currentPort)
					TriggerClientEvent('esx_misc:watermark_port', -1, currentPort)
					MinaPlaceLog((' تحويل موقع التصدير '),"موقع التصدير مطار الملك عبدالعزيز الدولي", "*من قبل* \n"..xPlayer.job.label.."\nSteam: `".. GetPlayerName(source).."` \n "..GetPlayerIdentifiers(source)[1].." \n "..GetPlayerIdentifiers(source)[5].." \nInGame name: `"..xPlayer.getName().."`",15158332)
				elseif newport == 11 then
					MSG = 'ميناء مدينة 101 التوسعة 1'
					currentPort = 11
					TriggerClientEvent("esx_misc:currentPortNum", -1, currentPort)
					TriggerClientEvent('esx_misc:watermark_port', -1, currentPort)
					MinaPlaceLog((' افتتاح توسعة 1 '),'ميناء مدينة 101 التوسعة 1', "*من قبل* \n"..xPlayer.job.label.."\nSteam: `".. GetPlayerName(source).."` \n "..GetPlayerIdentifiers(source)[1].." \n "..GetPlayerIdentifiers(source)[5].." \nInGame name: `"..xPlayer.getName().."`",15158332) 
				elseif newport == 12 then
					MSG = 'ميناء مدينة 101 التوسعة 2'
					currentPort = 12
					TriggerClientEvent("esx_misc:currentPortNum", -1, currentPort)
					TriggerClientEvent('esx_misc:watermark_port', -1, currentPort)
					MinaPlaceLog((' افتتاح توسعة 2 '),'ميناء مدينة 101 التوسعة 2', "*من قبل* \n"..xPlayer.job.label.."\nSteam: `".. GetPlayerName(source).."` \n "..GetPlayerIdentifiers(source)[1].." \n "..GetPlayerIdentifiers(source)[5].." \nInGame name: `"..xPlayer.getName().."`",15158332) 
				elseif newport == 13 then
					MSG = 'ميناء مدينة 101 التوسعة 3'
					currentPort = 13
					TriggerClientEvent("esx_misc:currentPortNum", -1, currentPort)
					TriggerClientEvent('esx_misc:watermark_port', -1, currentPort)
					MinaPlaceLog((' افتتاح توسعة 3 '),'ميناء مدينة 101 التوسعة 3', "*من قبل* \n"..xPlayer.job.label.."\nSteam: `".. GetPlayerName(source).."` \n "..GetPlayerIdentifiers(source)[1].." \n "..GetPlayerIdentifiers(source)[5].." \nInGame name: `"..xPlayer.getName().."`",15158332) 
				elseif newport == 14 then
					MSG = 'ميناء مدينة 101 التوسعة 4'
					currentPort = 14
					TriggerClientEvent("esx_misc:currentPortNum", -1, currentPort)
					TriggerClientEvent('esx_misc:watermark_port', -1, currentPort)
					MinaPlaceLog((' افتتاح توسعة 4 '),'ميناء مدينة 101 التوسعة 4', "*من قبل* \n"..xPlayer.job.label.."\nSteam: `".. GetPlayerName(source).."` \n "..GetPlayerIdentifiers(source)[1].." \n "..GetPlayerIdentifiers(source)[5].." \nInGame name: `"..xPlayer.getName().."`",15158332) 
				elseif newport == "location_sell_drugs_1" then
					MSG = 'موقع 1'
					currentPort = "location_sell_drugs_1"
					TriggerClientEvent("esx_misc:currentPortNum", -1, currentPort)
					MinaPlaceLog((' افتتاح موقع تهريب 1 '),"افتتاح موقع تهريب 1", "*من قبل* \n"..xPlayer.job.label.."\nSteam: `".. GetPlayerName(source).."` \n "..GetPlayerIdentifiers(source)[1].." \n "..GetPlayerIdentifiers(source)[5].." \nInGame name: `"..xPlayer.getName().."`",15158332) 
				elseif newport == "location_sell_drugs_2" then
					MSG = 'موقع 2'
					currentPort = "location_sell_drugs_2"
					TriggerClientEvent("esx_misc:currentPortNum", -1, currentPort)
					MinaPlaceLog((' افتتاح موقع تهريب 2 '),"افتتاح موقع تهريب 2", "*من قبل* \n"..xPlayer.job.label.."\nSteam: `".. GetPlayerName(source).."` \n "..GetPlayerIdentifiers(source)[1].." \n "..GetPlayerIdentifiers(source)[5].." \nInGame name: `"..xPlayer.getName().."`",15158332) 
				elseif newport == "location_sell_drugs_3" then
					MSG = 'موقع 3'
					currentPort = "location_sell_drugs_3"
					TriggerClientEvent("esx_misc:currentPortNum", -1, currentPort)
					MinaPlaceLog((' افتتاح موقع تهريب 3 '),"افتتاح موقع تهريب 3", "*من قبل* \n"..xPlayer.job.label.."\nSteam: `".. GetPlayerName(source).."` \n "..GetPlayerIdentifiers(source)[1].." \n "..GetPlayerIdentifiers(source)[5].." \nInGame name: `"..xPlayer.getName().."`",15158332) 
				end

				if newport == "location_sell_drugs_1" or newport == "location_sell_drugs_2" or newport == "location_sell_drugs_3" then
					MSGS = 'منطقة التهريب الاَن ^3'..MSG
				else
					MSGS = 'منطقة التصدير الاَن ^3'..MSG
				end

				if xPlayer["job"]["name"] == "admin" then
					TriggerClientEvent('chatMessage', -1, " ⭐ الرقابة و التفتيش  " ,  {198, 40, 40} ,  MSGS)
				elseif xPlayer["job"]["name"] == "police" then
					TriggerClientEvent('chatMessage', -1, "👮 إدارة الشرطة | " .. name_player .." " ,  { 17, 69, 191 }, MSGS)
				elseif xPlayer["job"]["name"] == "agent" then
					TriggerClientEvent('chatMessage', -1, "💂‍ حرس الحدود  | " .. name_player .." " ,  { 78, 198, 78 }, MSGS)	
				elseif xPlayer["job"]["name"] == "ambulance" then
					TriggerClientEvent('chatMessage', -1, " 🚨 الدفاع المدني | " .. name_player .." " ,  { 196, 20, 20 }, MSGS)		
				else
					return
				end
			else
				xPlayer.showNotification('<font color=red>يجب الأنتظار</font>. <font color=orange>'..Cooldown_count..' ثانية')
			end
		else
			TriggerClientEvent('esx:showNotification', source, 'موقع التصدير هاذه فعال بالفعل')
		end
   	else
   		print(('esx_misc: %s attempted to change port (not allowed!)!'):format(xPlayer.identifier))
   	end
end)


local NoCrimetime = {}

NoCrimetime_Data = {

	['SandyAndPoleto'] = {label='ممنوع الأجرام في ساندي و بوليتو', state=false,timer=false, time = 0, Cancel=false},

	['LosSantonNoCrime'] = {label='ممنوع الأجرام في لوس', state=false,timer=false, time = 0, Cancel=false},

	['SandyNoCrime'] = {label='ممنوع الأجرام في ساندي', state=false,timer=false, time = 0, Cancel=false},

	['PoletoNoCrime'] = {label='ممنوع الأجرام في بوليتو', state=false,timer=false, time = 0, Cancel=false},

	['NoCrimetime'] = {label='ممنوع الأجرام', state=false,timer=false, time = 0, Cancel=false},

	['NoCrimetimeToAll'] = {label='ممنوع الأجرام للجميع', state=false,timer=false, time = 0, Cancel=false},

	['NewScenario'] = {label='ممنوع بدأ سيناريو جديد', state=false,timer=false, time = 0, Cancel=false},

	['deleteallcars'] = {label='حذف جميع المركبات', state=false,timer=false, time = 0, Cancel=false},

	['MainBank'] = {label='ممنوع سرقة البنك المركزي', state=false,timer=false, time = 0, Cancel=false},

	['MainBankHave'] = {label='لايمكنك سرقة البنك المركزي لوجود سرقة حاليا', state=false,timer=false, time = 0, Cancel=false},

	['SmallBanks'] = {label='ممنوع سرقة البنوك الصغيرة', state=false,timer=false, time = 0, Cancel=false},

	['SmallBanksHave'] = {label='لايمكنك سرقة البنوك الصغيره لوجود سرقة حاليا', state=false,timer=false, time = 0, Cancel=false},

	['Stores'] = {label='ممنوع سرقة المتاجر', state=false,timer=false, time = 0, Cancel=false},

	['StoresHave'] = {label='لايمكنك سرقة المتاجر لوجود سرقة حاليا', state=false,timer=false, time = 0, Cancel=false},

	['SellDrugs'] = {label='ممنوع تهريب الممنوعات', state=false,timer=false, time = 0, Cancel=false},

	['TpAutoMatic'] = {label='انتقال تلقائي', state=false,timer=false, time = 0, Cancel=false},

	['threb'] = {label='تهريب الممنوعات', state=false,timer=false, time = 0, Cancel=false},

	["miner"] = {label='ضعف الأجر المعادن', state=false,timer=false, time = 0, Cancel=false},

	["9ndo8_almtagr"] = {label='ضعف صندوق المتاجر', state=false,timer=false, time = 0, Cancel=false},

	["lumberjack"] = {label='ضعف الأجر الأخشاب', state=false,timer=false, time = 0, Cancel=false},

	["all"] = {label='ضعف الأجر جميع الوظائف', state=false,timer=false, time = 0, Cancel=false},

	["slaughterer"] = {label='ضعف الأجر الدواجن', state=false,timer=false, time = 0, Cancel=false},

	["tailor"] = {label='ضعف الأجر الأقمشة', state=false,timer=false, time = 0, Cancel=false},

	["fueler"] = {label='ضعف الأجر نفط و غاز', state=false,timer=false, time = 0, Cancel=false},

	["farmer"] = {label='ضعف الأجر العنب', state=false,timer=false, time = 0, Cancel=false},

	["fisherman"] = {label='ضعف الأجر الأسماك', state=false,timer=false, time = 0, Cancel=false},

	["doubleXP"] = {label='ضعف الخبرة', state=false,timer=false, time = 0, Cancel=false},

	["alfnon"] = {label='ممنوع سرقة معرض الفنون', state=false,timer=false, time = 0, Cancel=false},

	["alfnon_have"] = {label='يوجد حاليا سرقة معرض الفنون', state=false,timer=false, time = 0, Cancel=false},

}

RegisterNetEvent('esx_misc:checkNocrimeTimeAndSecnarioIsEnabled')
AddEventHandler('esx_misc:checkNocrimeTimeAndSecnarioIsEnabled', function()
	if NoCrimetime_Data['NoCrimetime'].state then
		TriggerClientEvent('esx_wesam:setnow', source, true, "n")
	elseif NoCrimetime_Data['NewScenario'].state then
		TriggerClientEvent('esx_wesam:setnow', source, true, "s")
	end
end)

ESX.RegisterServerCallback('esx_misc:TpAutoMaticAfterJoin', function(source, cb)
	cb({check_status_tp_automatic = NoCrimetime_Data['TpAutoMatic'].state})
end)

RegisterNetEvent('esx_misc:setTrueOrFalseInStatusTpAutoMatic')
AddEventHandler('esx_misc:setTrueOrFalseInStatusTpAutoMatic', function(true_or_false_set_this)
	if true_or_false_set_this then
		NoCrimetime_Data['TpAutoMatic'].state = true
	else
		NoCrimetime_Data['TpAutoMatic'].state = false
	end
end)

function isNoCrimetime2() --return table with 3 values {active(boolen),name,label}
    local noCrimeZone2 = Config.panicButton.noCrimeTime2
	local data2 = {}
	for k,v in pairs (NoCrimetime) do
		if v.active then
			for i=1,#noCrimeZone2,1 do
				if v.name == noCrimeZone2[i] then
					data2.active = true
					data2.name = v.name
					data2.label = v.label
					return data2
				end	
			end
		end
	end
	--print('# no crime zone found')
	data2.active = false
	return data2
end

RegisterNetEvent('esx_misc:setdubelxpjob')
AddEventHandler('esx_misc:setdubelxpjob', function()
	if not dublexpjob then 
		dublexpjob = true

	else
		dublexpjob = false
	end
end)
ESX.RegisterServerCallback('esx_misc:getstatusselldrugs', function(source, cb, cuurent)
	cb({is_is_is = NoCrimetime_Data['SellDrugs'].state, cuurent = cuurent})
end)

ESX.RegisterServerCallback('esx_misc:getStatusStolen', function(source, cb)
	cb({sss1 = NoCrimetime_Data['SmallBanksHave'].state,is_is_is = NoCrimetime_Data['SellDrugs'].state, mmm2 = NoCrimetime_Data['MainBankHave'].state,nnn6 = NoCrimetime_Data['Stores'].state, ddd2 = NoCrimetime_Data['StoresHave'].state, crime_status = NoCrimetime_Data['NoCrimetime'].state, senario_status = NoCrimetime_Data['NewScenario'].state, peace_time = Pnaic_Data["peace_time"].state, restart_time = Pnaic_Data["restart_time"].state, seanh_time = Pnaic_Data["9eanh_time"].state, alfnon = NoCrimetime_Data['alfnon'].state, alfnon_have = NoCrimetime_Data['alfnon_have'].state})
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(timer_player_in_store) do
			if timer_player_in_store[k].status then
				if timer_player_in_store[k].time <= 0 then
					local xPlayer = ESX.GetPlayerFromId(timer_player_in_store[k].id)
					if xPlayer then
						TriggerEvent('SystemXpLevel:DoubleXpLevelStore', xPlayer.source, "stop")
						TriggerClientEvent('esx_misc:watermark_promotion', xPlayer.source, "707Store_store", false, 2)
						TriggerClientEvent("esx_misc:updatePromotionTimer", timer_player_in_store[k].id, "707Store_store", false)
					end
					is_player_have_double_xp_from_store[k] = nil
					timer_player_in_store[k] = nil
					MySQL.Async.fetchAll("DELETE FROM 707store WHERE identifier = @identifier",{['@identifier'] = k})
					local xPlayer = ESX.GetPlayerFromId(timer_player_in_store[k].id)
				elseif timer_player_in_store[k].time >= 1 then
					if not NoCrimetime_Data['doubleXP'].state then 
						timer_player_in_store[k].time = timer_player_in_store[k].time - 1
						TriggerEvent('SystemXpLevel:DoubleXpLevelStore', ESX.GetPlayerFromId(timer_player_in_store[k].id), "start")
						TriggerClientEvent("esx_misc:updatePromotionTimer", timer_player_in_store[k].id, "707Store_store", true, timer_player_in_store[k].time)
					else
						TriggerClientEvent("SystemXpLevel:StoreDoubleXpLevel", timer_player_in_store[k].id, true)
						TriggerEvent('SystemXpLevel:DoubleXpLevelStore', ESX.GetPlayerFromId(timer_player_in_store[k].id), "stop")
						TriggerClientEvent("esx_misc:updatePromotionTimer", timer_player_in_store[k].id, "707Store_store", false, timer_player_in_store[k].time)
					end
				end
			end
		end
	end
end)

function TimerConvert(time)

	local TimerS = time

	local remainingseconds = TimerS/ 60

	local seconds = string.format("%02.f", math.floor(TimerS) % 60 )

	local remainingminutes = remainingseconds / 60

	local minutes = string.format("%02.f", math.floor(remainingseconds) % 60 )

	local remaininghours = remainingminutes / 24

	local hours = string.format("%02.f", math.floor(remainingminutes) % 24 )

	local remainingdays = remaininghours / 365

	local days = string.format("%02.f", math.floor(remaininghours) % 365 )

	return '</span>يوم :'..'<span style="color:686868;"> ' .. days .. '</span> | ساعة :' .. '<span style="color:686868;"> ' .. hours .. '</span> | دقيقة :' .. '<span style="color:686868;"> ' .. minutes .. '</span> | ثانيه :'..'<span style="color:686868;"> ' .. seconds

end

ESX.RegisterServerCallback("esx_misc:wesam:getTimeSponser", function(source, cb, name)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		for k1,v1 in pairs(is_player_have_ra3i_from_store) do
			for k,v in pairs(is_player_have_ra3i_from_store[k1]) do
				if k == xPlayer.identifier then
					if v.name_table == name then
						cb(TimerConvert(v.time))
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
    local data = MySQL.Sync.fetchAll('SELECT * FROM 707store')
    for i=1, #data, 1 do
		is_player_have_double_xp_from_store[data[i].identifier] = {status = true, time = data[i].timer}
    end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(playerId, xPlayer)
    if is_player_have_double_xp_from_store[xPlayer.identifier] then
		if timer_player_in_store[xPlayer.identifier] then
			TriggerEvent('SystemXpLevel:DoubleXpLevelStore', playerId, "start")
			TriggerClientEvent('esx_misc:watermark_promotion', playerId, "707Store_store", true, 2)
			TriggerClientEvent("esx_misc:updatePromotionTimer", playerId, "707Store_store", true, timer_player_in_store[xPlayer.identifier].time)
			TriggerClientEvent('esx_misc:updateNoCrimetime', playerId, "707Store_store")
			timer_player_in_store[xPlayer.identifier] = {status = true, time = timer_player_in_store[xPlayer.identifier].time, id = playerId}
		else
			TriggerEvent('SystemXpLevel:DoubleXpLevelStore', playerId, "start")
			TriggerClientEvent('esx_misc:watermark_promotion', playerId, "707Store_store", true, 2)
			TriggerClientEvent("esx_misc:updatePromotionTimer", playerId, "707Store_store", true, is_player_have_double_xp_from_store[xPlayer.identifier].time)
			TriggerClientEvent('esx_misc:updateNoCrimetime', playerId, "707Store_store")
			timer_player_in_store[xPlayer.identifier] = {status = true, time = is_player_have_double_xp_from_store[xPlayer.identifier].time, id = playerId}
		end
    end
end)

AddEventHandler("playerDropped", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		if is_player_have_double_xp_from_store[xPlayer.identifier] then
			if timer_player_in_store[xPlayer.identifier] then
				MySQL.Async.execute('UPDATE 707store SET timer = @timer WHERE identifier = @identifier', {
					['@identifier'] = xPlayer.identifier,
					['@timer'] = timer_player_in_store[xPlayer.identifier].time,
				}, function(result_0)
					--print()
				end)
				timer_player_in_store[xPlayer.identifier] = {status = false, time = timer_player_in_store[xPlayer.identifier].time, id = source}
			else
				MySQL.Async.execute('UPDATE 707store SET timer = @timer WHERE identifier = @identifier', {
					['@identifier'] = xPlayer.identifier,
					['@timer'] = is_player_have_double_xp_from_store[xPlayer.identifier].time,
				}, function(result_0)
					--print()
				end)
				timer_player_in_store[xPlayer.identifier] = {status = false, time = is_player_have_double_xp_from_store[xPlayer.identifier].time, id = source}
			end
		end
	end
end)

ESX.RegisterServerCallback('esx_misc:getStatusCrime', function(source, cb)
	cb({sss12 = NoCrimetime_Data['NoCrimetime'].state})
end)

RegisterNetEvent('esx_misc:setNoCrimeTo')
AddEventHandler('esx_misc:setNoCrimeTo', function()
	TriggerClientEvent('esx_wesam:setnow', source, true, "n_to_all")
end)

RegisterNetEvent('esx_misc:setNoCrimeTo2')
AddEventHandler('esx_misc:setNoCrimeTo2', function()
	TriggerClientEvent('esx_wesam:setnow', source, true, "n")
end)



RegisterServerEvent("esx_misc:NoCrimetime")
AddEventHandler('esx_misc:NoCrimetime', function(promotionName, isToggle, time)

    local xPlayer = ESX.GetPlayerFromId(source)
	
	if isToggle then

		print(('esx_misc: ^3%s^0 Has Toggled '..promotionName):format(GetPlayerName(source)))

		if NoCrimetime_Data[promotionName].state then

			if promotionName == "NoCrimetime" then

				TriggerClientEvent('esx_wesam:setnow', -1, false, "n")

			elseif promotionName == "NoCrimetimeToAll" then

				TriggerClientEvent('esx_wesam:setnow', -1, false, "n")

			elseif promotionName == "NewScenario" then

				TriggerClientEvent('esx_wesam:setnow', -1, false, "s")

			end

			if promotionName == "doubleXP" then

				TriggerClientEvent("esx_wesam:SystemXplevel", -1, "end", "cmd")

				TriggerClientEvent("SystemXpLevel:Promotion_client", -1, false)

			end

			if promotionName == "miner" then
				
				--TriggerClientEvent('esx_jobs:wesam:togglePromotion_duble_swap', -1, promotionName)
				
			elseif promotionName == "9ndo8_almtagr" then

				--TriggerClientEvent('esx_jobs:wesam:9ndo8Almtajr_end', -1)

			elseif promotionName == "lumberjack" then

				--TriggerClientEvent('esx_jobs:wesam:togglePromotion_duble_swap', -1, promotionName)

			elseif promotionName == "slaughterer" then

				--TriggerClientEvent('esx_jobs:wesam:togglePromotion_duble_swap', -1, promotionName)
			
			elseif promotionName == "tailor" then

				--TriggerClientEvent('esx_jobs:wesam:togglePromotion_duble_swap', -1, promotionName)

			elseif promotionName == "fueler" then

				--TriggerClientEvent('esx_jobs:wesam:togglePromotion_duble_swap', -1, promotionName)
			
			elseif promotionName == "farmer" then

				--TriggerClientEvent('esx_jobs:wesam:togglePromotion_duble_swap', -1, promotionName)
			
			elseif promotionName == "fisherman" then

				--TriggerClientEvent('esx_jobs:wesam:togglePromotion_duble_swap', -1, promotionName)

			elseif promotionName == "vegetables" then

				--TriggerClientEvent('esx_jobs:wesam:togglePromotion_duble_swap', -1, promotionName)

			else

				TriggerClientEvent('esx_misc:watermark_promotion', -1, promotionName, false, 2)

			end

			NoCrimetime_Data[promotionName].state = false
			
			if #NoCrimetime > 0 then

				for i=1, #NoCrimetime, 1 do

					if NoCrimetime[i].name == promotionName then

						NoCrimetime[i].active = false

					end

				end

			end

			TriggerClientEvent('esx_misc:updateNoCrimetime', -1, NoCrimetime)

		else

			if promotionName == "NoCrimetime" then

				TriggerClientEvent('esx_wesam:setnow', -1, true, "n")

			elseif promotionName == "NoCrimetimeToAll" then

				TriggerClientEvent('esx_wesam:setnow', -1, true, "n_to_all")

			elseif promotionName == "NewScenario" then

				TriggerClientEvent('esx_wesam:setnow', -1, true, "s")

			end

			if promotionName == "doubleXP" then

				TriggerClientEvent("esx_wesam:SystemXplevel", -1, "start", "cmd")

				TriggerClientEvent("SystemXpLevel:Promotion_client", -1, true)

			end

			NoCrimetime_Data[promotionName].state = true

			table.insert(NoCrimetime, {name = promotionName, label = NoCrimetime_Data[promotionName].label, active=true})

			if promotionName == "miner" then
					
				--
				
			elseif promotionName == "9ndo8_almtagr" then

				--

			elseif promotionName == "lumberjack" then

				--

			elseif promotionName == "slaughterer" then

				--
			
			elseif promotionName == "tailor" then

				--

			elseif promotionName == "fueler" then

				--
			
			elseif promotionName == "farmer" then

				--
			
			elseif promotionName == "fisherman" then

				--

			elseif promotionName == "vegetables" then

				--

			else

				TriggerClientEvent('esx_misc:watermark_promotion', -1, promotionName, true, 2)

				TriggerClientEvent('esx_misc:updateNoCrimetime', -1, NoCrimetime)

			end

		end

	elseif not isToggle then

		NoCrimetime_Data[promotionName].time = time*60

		print(('esx_misc: ^3%s^0 Has rest the time to ^1%s^0 for %s'):format(GetPlayerName(source),time,promotionName))

		if time == 111 then

			timing(promotionName, true)

		else

			if time*60 > 0 and not NoCrimetime_Data[promotionName].timer then

				timing(promotionName, false)

			end

		end

	end

end)


function timing(promotionName, pasCancel)
	
    NoCrimetime_Data[promotionName].timer = true
	
    time = NoCrimetime_Data[promotionName].time
	
	if pasCancel then
		
		NoCrimetime_Data[promotionName].timer = false

		TriggerClientEvent("esx_misc:updatePromotionTimer", -1, promotionName, false)

		return

	end

    if NoCrimetime_Data[promotionName].time == 0 then

		NoCrimetime_Data[promotionName].timer = false

		if NoCrimetime_Data[promotionName].state then

			NoCrimetime_Data[promotionName].state = false

			if promotionName == "NoCrimetime" then

				TriggerClientEvent('esx_wesam:setnow', -1, false, "n")

				TriggerClientEvent('esx_misc:watermark_promotion', -1, promotionName, false, 2)

			elseif promotionName == "NoCrimetimeToAll" then

				TriggerClientEvent('esx_wesam:setnow', -1, false, "n")

				TriggerClientEvent('esx_misc:watermark_promotion', -1, promotionName, false, 2)

			elseif promotionName == "NewScenario" then

				TriggerClientEvent('esx_wesam:setnow', -1, false, "s")

				TriggerClientEvent('esx_misc:watermark_promotion', -1, promotionName, false, 2)

			elseif promotionName == "miner" then
				
				TriggerClientEvent('esx_jobs:wesam:togglePromotion_duble_swap', -1, promotionName, false, "cmd")
				
			elseif promotionName == "9ndo8_almtagr" then

				TriggerClientEvent('esx_jobs:wesam:9ndo8Almtajr_end', -1)

			elseif promotionName == "lumberjack" then

				TriggerClientEvent('esx_jobs:wesam:togglePromotion_duble_swap', -1, promotionName, false, "cmd")

			elseif promotionName == "slaughterer" then

				TriggerClientEvent('esx_jobs:wesam:togglePromotion_duble_swap', -1, promotionName, false, "cmd")
			
			elseif promotionName == "tailor" then

				TriggerClientEvent('esx_jobs:wesam:togglePromotion_duble_swap', -1, promotionName, false, "cmd")

			elseif promotionName == "fueler" then

				TriggerClientEvent('esx_jobs:wesam:togglePromotion_duble_swap', -1, promotionName, false, "cmd")
			
			elseif promotionName == "farmer" then

				TriggerClientEvent('esx_jobs:wesam:togglePromotion_duble_swap', -1, promotionName, false, "cmd")
			
			elseif promotionName == "fisherman" then

				TriggerClientEvent('esx_jobs:wesam:togglePromotion_duble_swap', -1, promotionName, false, "cmd")

			elseif promotionName == "vegetables" then

				TriggerClientEvent('esx_jobs:wesam:togglePromotion_duble_swap', -1, promotionName, false, "cmd")

			end

			if promotionName == "doubleXP" then

				TriggerClientEvent("esx_wesam:SystemXplevel", -1, "end", "cmd")

				TriggerClientEvent("SystemXpLevel:Promotion_client", -1, false)

			end
		
			if #NoCrimetime > 0 then

				for i=1, #NoCrimetime, 1 do

					if NoCrimetime[i].name == promotionName then

						NoCrimetime[i].active = false

					end

				end

			end

			TriggerClientEvent('esx_misc:watermark_promotion', -1, promotionName, false, 2)

			TriggerClientEvent('esx_misc:updateNoCrimetime', -1, NoCrimetime)

			TriggerClientEvent("esx_misc:updatePromotionTimer", -1, promotionName, false)

			return

		else

			return

		end

	end

    TriggerClientEvent("esx_misc:updatePromotionTimer", -1, promotionName, true, NoCrimetime_Data[promotionName].time)
	
    Wait(1000)

	if NoCrimetime_Data[promotionName].time ~= 0 then

		NoCrimetime_Data[promotionName].time = NoCrimetime_Data[promotionName].time - 1

	end

	if NoCrimetime_Data[promotionName].timer then

		timing(promotionName, false)

	end

end

----------------------
---Teleport START-----
----------------------

----------------------
---Auto Gifts START---
----------------------
local GiftMoney = 5000
local GiftTime = 59


local AutoGift = {}

RegisterServerEvent("esx_misc:StartAutoGift")
AddEventHandler('esx_misc:StartAutoGift', function()
    local xPlayer = ESX.GetPlayerFromId(source)
	local Playeridentifier = xPlayer.identifier
	
	--# Check if is active
	isactive = false
	if #AutoGift > 0 then
				for i=1, #AutoGift, 1 do
					if AutoGift[i].identifier == Playeridentifier then
					    AutoGift[i].active = true
						AutoGift[i].id = xPlayer.source
						isactive = true
					end
				end
			end
	
	if isactive then
	--TriggerClientEvent('esx_misc:print', source, '# There is active taple for your identifier all Ready - ^1CancelEvent^0')
	return
	end
	
	--# Start Auto Gift
	table.insert(AutoGift, {id = xPlayer.source, identifier = Playeridentifier, active=true, time=GiftTime})
   --TriggerClientEvent('esx_misc:print', source, '# taple '..xPlayer.source..'/'..Playeridentifier..'')
   
end)

Citizen.CreateThread(function()
   Wait(1)
   while true do
   Wait(1000 *  60) -- 1 min
        --# جاري تقليل دقيقة من الوقت في حال اللاعب متصل
   if #AutoGift > 0 then
				for i=1, #AutoGift, 1 do
					if AutoGift[i].active and AutoGift[i].time > 0 then
					local xPlayer = ESX.GetPlayerFromId(AutoGift[i].id)
					if xPlayer then
						AutoGift[i].time = AutoGift[i].time - 1
					else
					AutoGift[i].active = false
					end
				end
			end
		end
		--# تم إزالة دقيقة من الوقت في حال اللاعب متصل
		
		--# تسليم المكافأة في حال انتهى الوقت المحدد
		if #AutoGift > 0 then
				for i=1, #AutoGift, 1 do
					if AutoGift[i].active and AutoGift[i].time == 0 then
					local xPlayer = ESX.GetPlayerFromId(AutoGift[i].id)
					if xPlayer then
						AutoGift[i].time = GiftTime
						xPlayer.addAccountMoney('bank', GiftMoney)
						TriggerClientEvent('esx_misc:receiveGift', xPlayer.source, GiftMoney)
						
					local ids = ExtractIdentifiers(xPlayer.source)
	                _discordID ="<@" ..ids.discord:gsub("discord:", "")..">"
	                _identifierID ="**identifier:  ** " ..xPlayer.identifier..""
	                DiscordLogReward('سجل المكافأة التلقائية', 'أستلام المكافأة', ''..xPlayer.getName()..'\n'.._discordID..'\n'.._identifierID..'\n\nالمبلغ: $'..GiftMoney..'', '15844367')
					else
					AutoGift[i].active = false
					end
				end
			end
		end
		
   end
end)

ESX.RegisterServerCallback('esx_misc:GetRewardRemainingtime', function(source, cb, id)
    local xPlayer = ESX.GetPlayerFromId(source)
	local Playeridentifier = xPlayer.identifier
	
     Time = nil
	 if #AutoGift > 0 then
				for i=1, #AutoGift, 1 do
					if AutoGift[i].identifier == Playeridentifier then
					Time = AutoGift[i].time
				end
			end
		end
    
	cb(Time)
end)

function DiscordLogReward(name, title, message, color)
	
	local embeds = {
		{
			["title"]=title,
			["type"]="rich",
            ["description"] = message,
			["color"] =color,
			["footer"]=  { ["text"]= "مدينة 101 | سجل المكافأة التلقائية", 
            ["icon_url"] = "https://l.top4top.io/p_3025orsal1.png"},
		}
	}
	
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest('https://discord.com/api/webhooks/1228610557402419232/J1xCrlQsDIpol6bzpfY9a9ozevh8X04JXkKmlzcuEqFjUnsvTwnMPfpoldCRPwohgnLm', function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

--wesam is king

ESX.RegisterServerCallback('esx_policejob:checkJailAll', function(source, cb)
	MySQL.Async.fetchAll("SELECT jail FROM users WHERE identifier = @identifier", {
		['@identifier'] = identifier_player
	}, function(result_jail)
		if result_jail[1].jail > 0 then
			cb(true)
		else
			cb(false)
		end
	end)
end)

Citizen.CreateThread(function()
    local data = MySQL.Sync.fetchAll('SELECT * FROM users')
    for i=1, #data, 1 do
		if tonumber(data[i].jail) > 0 then
			player_in_jail[data[i].identifier] = {}
        	player_in_jail[data[i].identifier] = true
		end
    end
end)

ESX.RegisterServerCallback("esx_jail:retrieveJailTime", function(source, cb)
	
	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	
	if xPlayer then

		if player_in_jail[xPlayer.identifier] then

			MySQL.Async.fetchAll("SELECT jail FROM users WHERE identifier = @identifier", {
				["@identifier"] = xPlayer.identifier
			}, function(result)
				cb(true, result[1].jail)
			end)

		else

			cb(false)

		end

	end
	
end)

RegisterServerEvent("esx_misc:GiveTeleportMenu")
AddEventHandler('esx_misc:GiveTeleportMenu', function(To)
    local xPlayer = ESX.GetPlayerFromId(source)
	if To == "all" then
		print('^3'..GetPlayerName(source)..'^0 Has gived TeleportMenu To all')
		local xPlayers1 = ESX.GetPlayers()
		for i=1, #xPlayers1, 1 do
			local xPlayer2 = ESX.GetPlayerFromId(xPlayers1[i])
			if xPlayer2 then
				if player_in_jail[xPlayer2.identifier] then
					--print('')
				else
					TriggerClientEvent("esx_misc:StartTeleport", xPlayer2.source)
				end
			end
		end
	else
		local xTarget = ESX.GetPlayerFromId(To)
		if xTarget then
			if player_in_jail[xTarget.identifier] then
				--print()
			else
				TriggerClientEvent("esx_misc:StartTeleport", xTarget.source)
			end
		else
			TriggerClientEvent('esx:showNotification', source, 'اللاعب غير متصل')
		end
	end
end)

RegisterServerEvent("esx_misc:SwapPlayer")
AddEventHandler('esx_misc:SwapPlayer', function(PlayerId, men, xT)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(PlayerId)
	if not tel and not men then
		xPlayer.triggerEvent("esx_misc:StartTeleportPlayer", PlayerId, xPlayer, xTarget)
	elseif men and not tel then
		xPlayer.triggerEvent("esx_misc:OpenMenu", PlayerId)
	end
end)
RegisterServerEvent("esx_misc:SwapPlayer2")
AddEventHandler('esx_misc:SwapPlayer2', function(PlayerId, coo, hen)
	local xTarget = ESX.GetPlayerFromId(PlayerId)
	TriggerClientEvent("esx_misc:Teleport", xTarget.source, coo, hen)
	--TriggerClientEvent('chatMessage', -1, " ⭐ الرقابة و التفتيش  " ,  {198, 40, 40} , "تم نقل الاعب ^3 " .. xTarget.getName() .. " ^0 من قبل المراقب")
end)

local count_agent_in = 0

ESX.RegisterServerCallback('esx_misc:getPlayerOnlineAgent', function(source, cb)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer == 'agent' then
			count_agent_in = count_agent_in + 1
		end
	end
	if count_agent_in >= 3 then
		cb(count_agent_in)
	else
		cb(count_agent_in)
	end
end)


ESX.RegisterServerCallback('esx_misc:getPlayerCounter', function(source, cb)
	local players_counter = 0
	MySQL.Async.fetchAll("SELECT player_counter FROM players", {
	}, function(result_players_select)
		if result_players_select[1].player_counter == 0 then
			players_counter = result_players_select[1].player_counter
			cb(players_counter)
		elseif result_players_select[1].player_counter < 0 then
			MySQL.Async.execute('UPDATE players SET player_counter = @player_counter', {
				['@player_counter'] = tonumber(0),
			}, function(result_0)
				--print()
			end)
			players_counter = result_players_select[1].player_counter
			cb(players_counter)
		elseif result_players_select[1].player_counter >= 1 then
			players_counter = result_players_select[1].player_counter
			cb(players_counter)
		end
	end)
end)


RegisterServerEvent('esx_misc:GetCache')
AddEventHandler('esx_misc:GetCache', function()
    local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('esx_adminjob:getP', source)
    TriggerClientEvent("esx_misc:currentPortNum", source, currentPort)
	for i=1, #alarm, 1 do
		if alarm[i].location == "my_location" or alarm[i].location == "my_location_2" or alarm[i].location == "my_location_3" or alarm[i].location == "my_location_4" or alarm[i].location == "my_location_5" or alarm[i].location == "my_location_6" or alarm[i].location == "my_location_7" or alarm[i].location == "my_location_8" or alarm[i].location == "my_location_9" or alarm[i].location == "my_location_10" or alarm[i].location == "my_location_11" or alarm[i].location == "my_location_12" or alarm[i].location == "my_location_13" or alarm[i].location == "my_location_14" or alarm[i].location == "my_location_15" then
			TriggerClientEvent('esx_misc:updateStatus', source, alarm, alarm[i].location, false, {name_run = alarm[i].location, number = Pnaic_Data[alarm[i].location].number, myLoc = true}, alarm[i].coords, alarm[i].dist)
		elseif alarm[i].location == 1 or alarm[i].location == 2 or alarm[i].location == 3 or alarm[i].location == 4 or alarm[i].location == 5 or alarm[i].location == 6 or alarm[i].location == 7 or alarm[i].location == 8 or alarm[i].location == 9 or alarm[i].location == 10 then
			TriggerClientEvent('esx_misc:updateStatus', source, alarm, alarm[i].location, false, {name_run = alarm[i].location, number = Pnaic_Data[alarm[i].location].number, helpMe = true})
		end
	end
	TriggerClientEvent('esx_misc:set_new_player', source, "after_join", player_c)
	TriggerClientEvent('esx_misc:updateStatus_notifieNO', source, alarm)
	local ND = NoCrimetime_Data
	TriggerClientEvent('esx_misc:updatePromotionStatus', source, 'NoCrimetime', ND['NoCrimetime'].state)
	TriggerClientEvent('esx_misc:updatePromotionStatus', source, 'NoCrimetimeToAll', ND['NoCrimetimeToAll'].state)
	TriggerClientEvent('esx_misc:updatePromotionStatus', source, 'NewScenario', ND['NewScenario'].state)
	TriggerClientEvent('esx_misc:updatePromotionStatus', source, 'MainBank', ND['MainBank'].state)
	TriggerClientEvent('esx_misc:updatePromotionStatus', source, 'SellDrugs', ND['SellDrugs'].state)
	TriggerClientEvent('esx_misc:updatePromotionStatus', source, 'SmallBanks', ND['SmallBanks'].state)
	TriggerClientEvent('esx_misc:updatePromotionStatus', source, 'Stores', ND['Stores'].state)
	TriggerClientEvent('esx_misc:updatePromotionStatus', source, 'SandyAndPoleto', ND['SandyAndPoleto'].state)
	TriggerClientEvent('esx_misc:updatePromotionStatus', source, 'LosSantonNoCrime', ND['LosSantonNoCrime'].state)
	TriggerClientEvent('esx_misc:updatePromotionStatus', source, 'SandyNoCrime', ND['SandyNoCrime'].state)
	TriggerClientEvent('esx_misc:updatePromotionStatus', source, 'PoletoNoCrime', ND['PoletoNoCrime'].state)
	TriggerClientEvent('esx_misc:updatePromotionStatus', source, 'MainBankHave', ND['MainBankHave'].state)
	TriggerClientEvent('esx_misc:updatePromotionStatus', source, 'SmallBanksHave', ND['SmallBanksHave'].state)
	TriggerClientEvent('esx_misc:updatePromotionStatus', source, 'StoresHave', ND['StoresHave'].state)
	TriggerClientEvent('esx_misc:updatePromotionStatus', source, 'deleteallcars', ND['deleteallcars'].state)
	TriggerClientEvent('esx_misc:updatePromotionStatus', source, 'TpAutoMatic', ND['TpAutoMatic'].state)
	TriggerClientEvent("esx_misc:updatePromotionStatus", source, 'doubleXP', ND['doubleXP'].state)
	TriggerClientEvent("esx_misc:updatePromotionStatus", source, 'alfnon', ND['alfnon'].state)
	TriggerClientEvent("esx_misc:updatePromotionStatus", source, 'alfnon_have', ND['alfnon_have'].state)
	TriggerClientEvent("SystemXpLevel:Promotion_client", source, ND['doubleXP'].state)
	TriggerClientEvent('esx_misc:updateNoCrimetime', source, NoCrimetime)
end)

function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = "",
        fivem = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
		elseif string.find(id, "fivem") then
            identifiers.fivem = id
        end
    end

    return identifiers
end


function TebexDiscordLog(name, title, message, color)
	local DiscordWebHook = Config.webhookmtgr
	
	local embeds = {
		{
			["title"]=title,
			["type"]="rich",
            ["description"] = message,
			["color"] =color,
			["footer"]=  { ["text"]= "متجر مدينة 101",
            ["icon_url"] = "https://cdn.discordapp.com/attachments/950654664129523762/966322626882584586/ab4c6f5e057b02b6.png"},
		}
	}
	
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
-- productName == رقم البكج
RegisterServerEvent('tebexstore:bkgat')
AddEventHandler('tebexstore:bkgat', function(targetid,productName,productstatus)
	local xTarget = ESX.GetPlayerFromId(targetid)
	local SteamName = GetPlayerName(targetid)
	local timer_tebex = nil
	local is_timer = false
	if xTarget then
		if productstatus == 'give' then
			xTarget.addAccountMoney("bank", Config.product[productName].rewardMoney)
			xTarget.addAccountMoney("black_money", Config.product[productName].rewardBlackMoney)
			TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', xTarget.source, 'add', Config.product[productName].rewardXp, 'المتجر تسليم باقة: '..Config.product[productName].label)
			TriggerClientEvent('esx_misc:tebexStoreScaleform', xTarget.source, productName, productstatus)
			if Config.product[productName].registerInRecord then
				if Config.product[productName].rewardMoney >= 1 then
					rewardMoneyXtra = 'مبلغ: '..Config.product[productName].rewardMoney
					xTarget.addAccountMoney("bank", Config.product[productName].rewardMoney)
				else
					rewardMoneyXtra = ''
				end
				if Config.product[productName].timer then
					timer_tebex = Config.product[productName].timer
					is_timer = true
				end
				if Config.product[productName].rewardBlackMoney >= 1 then
					rewardBlackMoneyXtra = 'أموال حمراء: '..Config.product[productName].rewardBlackMoney
					xTarget.addAccountMoney("black_money", Config.product[productName].rewardBlackMoney)
				else
					rewardBlackMoneyXtra = ''
				end
				if Config.product[productName].rewardXp >= 1 then
					rewardXPXtra = 'خبرة: '..Config.product[productName].rewardXp
					TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', xTarget.source, 'addnoduble', Config.product[productName].rewardXp, Config.product[productName].label, 'AbdurhmanOnTop')
				else
					rewardXPXtra = ''
				end
				if Config.product[productName].ra3i then
					MySQL.Async.execute('INSERT INTO roa3e (identifier, name, time, number) VALUES (@identifier, @name, @time, @number)',
					{
						['@identifier'] = xTarget.identifier,
						['@name'] = Config.product[productName].name,
						['@time'] = Config.product[productName].timer,
						['@number'] = productName
					})
				end
				if Config.product[productName].car then
					TriggerClientEvent("esx_giveownedcar:spawnVehicle2", xTarget.source, xTarget.source, Config.product[productName].model, Config.product[productName].carmodel, Config.product[productName].label, xTarget.getName(), "console")
				end
				TriggerEvent('esx_qalle_brottsregister:add_TebexStore', xTarget.source, Config.product[productName].label..' '..rewardMoneyXtra..' '..rewardBlackMoneyXtra..' '..rewardXPXtra..'')
				if is_timer then
					MySQL.Async.execute('INSERT INTO 707store (identifier, timer) VALUES (@identifier, @timer)',
					{
						['@identifier'] = xTarget.identifier,
						['@timer'] = timer_tebex
					})
					TriggerEvent('SystemXpLevel:DoubleXpLevelStore', xTarget.source, "start")
					TriggerClientEvent('esx_misc:watermark_promotion', xTarget.source, "707Store_store", true, 2)
					TriggerClientEvent("esx_misc:updatePromotionTimer", xTarget.source, "707Store_store", true, timer_tebex)
					TriggerClientEvent('esx_misc:updateNoCrimetime', xTarget.source, "707Store_store")
					is_player_have_double_xp_from_store[xTarget.identifier] = {status = true, time = timer_tebex}
					timer_player_in_store[xTarget.identifier] = {status = true, time = timer_tebex, id = xTarget.source}
				end
			end
			TriggerClientEvent('chatMessage', -1, "🛒 متجر مدينة 101 اونلاين  " ,  { 255, 191, 0 } ,  "تسليم ^3"..xTarget.getName().."^0  "..Config.product[productName].label)
			TebexDiscordLog(('متجر مدينة 101 اونلاين'), 'تسليم '..Config.product[productName].label, 'هوية اللاعب: `'..xTarget.getName()..'`\n\n'..xTarget.identifier..'', '15844367')
		elseif productstatus == 'expire' then
			TriggerClientEvent('esx_misc:tebexStoreScaleform', xTarget.source, productName, productstatus)
		elseif productstatus == "remove" then
			TriggerClientEvent('esx_misc:tebexStoreScaleform', xTarget.source, productName, productstatus)
			TriggerEvent("esx_qalle_brottsregister:remove_TebexStore_ra3i", productName)
		elseif productstatus == 'take' then
			xTarget.removeAccountMoney("bank", Config.product[productName].rewardMoney)
			xTarget.removeAccountMoney("black_money", Config.product[productName].rewardBlackMoney)
			TriggerEvent('esx_xp:removeXP', xTarget.source, Config.product[productName].rewardXp)
			TriggerEvent('esx_qalle_brottsregister:add_TebexStore', xTarget.source, Config.product[productName].label..' - حجز مشتريات ⛔')
			TriggerClientEvent('chatMessage', -1, "🛒 متجر مدينة 101 اونلاين " ,  { 255, 191, 0 } ,  "^1حجز مشتريات ^3"..xTarget.getName().."^0 ")
		end
	else
		TebexDiscordLog(('متجر منطقة مدينة 101'), 'خطأ بتسليم '..Config.product[productName].label, 'اللاعب لم يكن متصل\n ستيم من المتجر: `'..SteamName..'`', '15158332')
		PerformHttpRequest(Config.webhookmtgr, function(err, text, headers) end, 'POST', json.encode({ username = 'متجر مدينة 101 ', content = '@everyone !'}), { ['Content-Type'] = 'application/json' })
	end
end)
-- sponserBronze
-------------------------
----tebex store END------
-------------------------


function MinaStatus (name, title, message, color)
	local DiscordWebHook = "https://discord.com/api/webhooks/1219052188047900773/cE8Qo99-DAH_P-6wDq6XCpyKb4p-jgoJInxYpOHOfVpSfprvJxWsxd7In87_2sYR0sF1"
	
	local embeds = {
		{
			["title"]=title,
			["type"]="rich",
            ["description"] = message,
			["color"] =color,
			["footer"]=  { ["text"]= "حالة الميناء", 
            ["icon_url"] = ""},
		}
	}
	
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function MinaPlace (name, title, message, color)
	local DiscordWebHook = "https://discord.com/api/webhooks/1219052188047900773/cE8Qo99-DAH_P-6wDq6XCpyKb4p-jgoJInxYpOHOfVpSfprvJxWsxd7In87_2sYR0sF1"
	
	local embeds = {
		{
			["title"]=title,
			["type"]="rich",
            ["description"] = message,
			["color"] =color,
			["footer"]=  { ["text"]= "موقع التصدير"},
		}
	}
	
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function MinaStatusLog (name, title, message, color)
	local DiscordWebHook = "https://discord.com/api/webhooks/1219052188047900773/cE8Qo99-DAH_P-6wDq6XCpyKb4p-jgoJInxYpOHOfVpSfprvJxWsxd7In87_2sYR0sF1"
	
	local embeds = {
		{
			["title"]=title,
			["type"]="rich",
            ["description"] = message,
			["color"] =color,
			["footer"]=  { ["text"]= "موقع التصدير"},
		}
	}
	
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function MinaPlaceLog (name, title, message, color)
	local DiscordWebHook = "https://discord.com/api/webhooks/1219052188047900773/cE8Qo99-DAH_P-6wDq6XCpyKb4p-jgoJInxYpOHOfVpSfprvJxWsxd7In87_2sYR0sF1"
	
	local embeds = {
		{
			["title"]=title,
			["type"]="rich",
            ["description"] = message,
			["color"] =color,
			["footer"]=  { ["text"]= "موقع التصدير"},
		}
	}
	
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function license_revoke (name, title, message, color)
	local DiscordWebHook = "https://discord.com/api/webhooks/1219052541158101112/mRyVpD0loVNdtDlUw5M5avjhR9F7JaC50UTnxcCpuj_JLOpJD5FsFjGK53xaZMqESbtw"
	
	local embeds = {
		{
			["title"]=title,
			["type"]="rich",
            ["description"] = message,
			["color"] =color,
			["footer"]=  { ["text"]= "سحب الرخص"},
		}
	}
	
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function killkickfreeze (name, title, message, color)
	local DiscordWebHook = "https://discord.com/api/webhooks/1219048510461186120/Z0OS6hUvnlQyLY39ToGRTR2LkfDS1vQq9DDxL_gnuX5jXjijwu3PhfIWUx-D9AY3x2e6"
	
	local embeds = {
		{
			["title"]=title,
			["type"]="rich",
            ["description"] = message,
			["color"] =color,
			["footer"]=  { ["text"]= "طرد / تجميد/ قتل"},
		}
	}
	
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function killkickfreeze (name, title, message, color)
	local DiscordWebHook = "https://discord.com/api/webhooks/1219048510461186120/Z0OS6hUvnlQyLY39ToGRTR2LkfDS1vQq9DDxL_gnuX5jXjijwu3PhfIWUx-D9AY3x2e6"
	
	local embeds = {
		{
			["title"]=title,
			["type"]="rich",
            ["description"] = message,
			["color"] =color,
			["footer"]=  { ["text"]= "طرد / تجميد/ قتل"},
		}
	}
	
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function f6revive (name, title, message, color)
	local DiscordWebHook = "https://discord.com/api/webhooks/1219048510461186120/Z0OS6hUvnlQyLY39ToGRTR2LkfDS1vQq9DDxL_gnuX5jXjijwu3PhfIWUx-D9AY3x2e6"
	
	local embeds = {
		{
			["title"]=title,
			["type"]="rich",
            ["description"] = message,
			["color"] =color,
			["footer"]=  { ["text"]= "انعاش لاعب عبر f6"},
		}
	}
	
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function gotobring (name, title, message, color)
	local DiscordWebHook = "https://discord.com/api/webhooks/1219048510461186120/Z0OS6hUvnlQyLY39ToGRTR2LkfDS1vQq9DDxL_gnuX5jXjijwu3PhfIWUx-D9AY3x2e6"
	
	local embeds = {
		{
			["title"]=title,
			["type"]="rich",
            ["description"] = message,
			["color"] =color,
			["footer"]=  { ["text"]= "أنتقال / سحب لاعب"},
		}
	}
	
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function f6kickallLog (name, title, message, color)
	local DiscordWebHook = "https://discord.com/api/webhooks/1219048510461186120/Z0OS6hUvnlQyLY39ToGRTR2LkfDS1vQq9DDxL_gnuX5jXjijwu3PhfIWUx-D9AY3x2e6"
	
	local embeds = {
		{
			["title"]=title,
			["type"]="rich",
            ["description"] = message,
			["color"] =color,
			["footer"]=  { ["text"]= "طرد جميع الاعبين"},
		}
	}
	
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end


function logme1 (name, title, message, color) -- لوق ضعف الاجر
	local DiscordWebHook = "https://discord.com/api/webhooks/1219053660894531674/uqwEU7wP055U1SzgORV905Pp7eC0FJq48jWXZlADOVpYTEnBuha_iKjHExxmwjR9SPz-" -- سيرفر الوقات
	
	local embeds = {
		{
			["title"]=title,
			["type"]="rich",
            ["description"] = message,
			["color"] =color,
			["footer"]=  { ["text"]= "ضعف الأجر"},
		}
	}
	
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end


RegisterServerEvent('Mina:mg8i92aadminjob:kickallf6') -- لوق طرد جميع الاعبين
AddEventHandler('Mina:mg8i92aadminjob:kickallf6', function(name, title, message, color)
    f6kickallLog(name, title, message, color)
end)

RegisterServerEvent('Mina:8adoji2adminjob:killkickfreeze') -- لوج قتل تجميد طرد رقابة
AddEventHandler('Mina:8adoji2adminjob:killkickfreeze', function(name, title, message, color)
    killkickfreeze(name, title, message, color)
end)

RegisterServerEvent('Mina:ol2349oadminjob:gotobring') --
AddEventHandler('Mina:ol2349oadminjob:gotobring', function(name, title, message, color)
    gotobring(name, title, message, color)
end)

RegisterServerEvent('Mina:lad97ygadminjob:f6revive')
AddEventHandler('Mina:lad97ygadminjob:f6revive', function(name, title, message, color)
    f6revive(name, title, message, color)
end)

RegisterServerEvent('Mina:dlpayLogadj38')
AddEventHandler('Mina:dlpayLogadj38', function(name, title, message, color)
    logme1(name, title, message, color)
end)

RegisterServerEvent('Mina:msg')
AddEventHandler('Mina:msg', function(name, title, message, color)
    MinaStatus(name, title, message, color)
end)

RegisterServerEvent('MinaPlace:msg')
AddEventHandler('MinaPlace:msg', function(name, title, message, color)
    MinaPlace(name, title, message, color)
end)

RegisterServerEvent('MinaStatusLog:msg')
AddEventHandler('MinaStatusLog:msg', function(name, title, message, color)
    MinaStatusLog(name, title, message, color)
end)

RegisterServerEvent('MinaPlaceLog:msg')
AddEventHandler('MinaPlaceLog:msg', function(name, title, message, color)
    MinaPlaceLog(name, title, message, color)
end)

RegisterServerEvent('license_revokeLog:msg')
AddEventHandler('license_revokeLog:msg', function(name, title, message, color) -- license_revoke
    license_revoke(name, title, message, color)
end)