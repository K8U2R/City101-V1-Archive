local alarm = nil
local meInzone = false
local notified = {}
local Dontnotified = {}
local NoCrimetime = {}
local alarm_leo_PlayWithinDistance = {}
local blipStatus  = {}
local blipDetail  = {}
local LeoDrawTextStatus = {}
local citizenDrawTextStatus = {}
local DrawTextY = {}
local godmodStarted = {}
local canUseGodmod = {}
local canUseTransition = {}
local transitionStarted = {}
local player_is_dead = {}
local timer = 0
local helpmetime = 5 -- seconds disable F10 if pressed
local peacetimePeriod = 0
local myLocCount = 0
local helpMeCount = 0
local myLocDraw = false
local myLocDrawName = ''
local helpMeDraw = false
local helpMeDrawName = ''
local timer_is_want_start = {}
local godmodLocations = Config.panicButton.godmodLocations
local locationsData = Config.panicButton.locationsData
local noXPzones = Config.panicButton.noXPzones
local skyTransitionLocations = Config.panicButton.skyTransitionLocations

--check alarm status from server side
Citizen.CreateThread(function()
	while PlayerData.job == nil do
		Citizen.Wait(500)
	end
end)

local isfriday = false
local helpMeZones = {
	[1] = false,
	[2] = false,
	[3] = false,
	[4] = false,
	[5] = false,
	[6] = false,
	[7] = false,
	[8] = false,
	[9] = false,
	[10] = false,
}

local myLocZones = {
	['my_location'] = false,
	['my_location_2'] = false,
	['my_location_3'] = false,
	['my_location_4'] = false,
	['my_location_5'] = false,
	['my_location_6'] = false,
	['my_location_7'] = false,
	['my_location_8'] = false,
	['my_location_9'] = false,
	['my_location_10'] = false,
	['my_location_11'] = false,
	['my_location_12'] = false,
	['my_location_13'] = false,
	['my_location_14'] = false,
	['my_location_15'] = false,
}

RegisterNetEvent("esx_misc:addPlayerToMiscDead")
AddEventHandler("esx_misc:addPlayerToMiscDead", function(ident, type)
	if type == "add" then
		player_is_dead[ident] = true
	elseif type == "remove" then
		player_is_dead[ident] = nil
	end
end)

RegisterNetEvent("esx_misc:updatePeacetimePeriod")
AddEventHandler("esx_misc:updatePeacetimePeriod", function(period, name)

	timer_is_want_start[name] = {time = period, name = name}

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

	if days == "00" then

		if hours == "00" then

			if minutes == "00" then

				if seconds == "00" then

					--print()

				else

					return seconds

				end
			
			else

				return minutes .. ':' .. seconds

			end

		else

			return hours .. ':' .. minutes .. ':' .. seconds

		end

	else

		return days .. ':' .. hours .. ':' .. minutes .. ':' .. seconds

	end

end

Citizen.CreateThread(function()
	while true do

		if alarm ~= nil then

			for i=1, #alarm, 1 do

				if alarm[i].siren and alarm[i].myLoc then

					local pedCoords = GetEntityCoords(GetPlayerPed(-1))
					if GetDistanceBetweenCoords(pedCoords, alarm[i].coords, true) <= alarm[i].dist then

						if player_is_dead[PlayerData.identifier] then

							if PlayerData.job.name == "police" then

								TriggerServerEvent("esx_misc:addListAstnfar", alarm[i].location, {is_in_astnfar = true, isdead = true, isjobpolice = true, isjobnotpolice = false, is_want_remove_from_list = false})
								
							else

								TriggerServerEvent("esx_misc:addListAstnfar", alarm[i].location, {is_in_astnfar = true, isdead = true, isjobpolice = false, isjobnotpolice = true, is_want_remove_from_list = false})
								
							end

						else

							if PlayerData.job.name == "police" then

								TriggerServerEvent("esx_misc:addListAstnfar", alarm[i].location, {is_in_astnfar = true, isdead = false, isjobpolice = true, isjobnotpolice = false, is_want_remove_from_list = false})
								
							else

								TriggerServerEvent("esx_misc:addListAstnfar", alarm[i].location, {is_in_astnfar = true, isdead = false, isjobpolice = false, isjobnotpolice = true, is_want_remove_from_list = false})
								
							end

						end

					else

						TriggerServerEvent("esx_misc:addListAstnfar", alarm[i].location, {is_in_astnfar = true, isdead = false, isjobpolice = false, isjobnotpolice = true, is_want_remove_from_list = true})

					end
				end
			end
		end
		Citizen.Wait(5000)
	end
end)

exports('TriggerMyLocPanicButton', function()

	local zoneChecks = myLocZones

	local endZone = nil

	local pedCoords = GetEntityCoords(GetPlayerPed(-1))


    for i=1, #alarm, 1 do

		if alarm[i].siren and alarm[i].myLoc then

			zoneChecks[alarm[i].location] = true

			if GetDistanceBetweenCoords(pedCoords, alarm[i].coords, true) <= alarm[i].dist then
				if myLocCount >= 2 then
					myLocCount = myLocCount - 1
				end

				zoneChecks[alarm[i].location] = false

				endZone = alarm[i].location

				break

			end

		end

	end


	if endZone ~= nil then
		TriggerServerEvent('esx_misc:TogglePanicButton', endZone, pedCoords)
		return

	end

	local started = false

	if not zoneChecks["my_location"] then
		TriggerServerEvent('esx_misc:TogglePanicButton', "my_location", pedCoords)

		started = true
	elseif not zoneChecks["my_location_2"] then
		TriggerServerEvent('esx_misc:TogglePanicButton', "my_location_2", pedCoords)

		started = true
	elseif not zoneChecks["my_location_3"] then
		TriggerServerEvent('esx_misc:TogglePanicButton', "my_location_3", pedCoords)

		started = true
	elseif not zoneChecks["my_location_4"] then
		TriggerServerEvent('esx_misc:TogglePanicButton', "my_location_4", pedCoords)

		started = true
	elseif not zoneChecks["my_location_5"] then
		TriggerServerEvent('esx_misc:TogglePanicButton', "my_location_5", pedCoords)

		started = true
	elseif not zoneChecks["my_location_6"] then
		TriggerServerEvent('esx_misc:TogglePanicButton', "my_location_6", pedCoords)

		started = true
	elseif not zoneChecks["my_location_7"] then
		TriggerServerEvent('esx_misc:TogglePanicButton', "my_location_7", pedCoords)

		started = true
	elseif not zoneChecks["my_location_8"] then
		TriggerServerEvent('esx_misc:TogglePanicButton', "my_location_8", pedCoords)

		started = true
	elseif not zoneChecks["my_location_9"] then
		TriggerServerEvent('esx_misc:TogglePanicButton', "my_location_9", pedCoords)

		started = true
	elseif not zoneChecks["my_location_10"] then
		TriggerServerEvent('esx_misc:TogglePanicButton', "my_location_10", pedCoords)

		started = true
	elseif not zoneChecks["my_location_11"] then
		TriggerServerEvent('esx_misc:TogglePanicButton', "my_location_11", pedCoords)

		started = true
	elseif not zoneChecks["my_location_12"] then
		TriggerServerEvent('esx_misc:TogglePanicButton', "my_location_12", pedCoords)

		started = true
	elseif not zoneChecks["my_location_13"] then
		TriggerServerEvent('esx_misc:TogglePanicButton', "my_location_13", pedCoords)

		started = true
	elseif not zoneChecks["my_location_14"] then
		TriggerServerEvent('esx_misc:TogglePanicButton', "my_location_14", pedCoords)

		started = true
	elseif not zoneChecks["my_location_15"] then
		TriggerServerEvent('esx_misc:TogglePanicButton', "my_location_15", pedCoords)

		started = true
	end


	if not started then

		ESX.ShowNotification('استحالة التنفيذ, تم الوصول للحد الاقصى من تشغيل حالة الامن هاذه بنفس الوقت </br></br><font color=red> أنتظر انتهاء احدى منها</font>')

	end
	
end)

--update alarm status from server side
local restricted_zones = {}
RegisterNetEvent("esx_misc:updateStatus")
AddEventHandler("esx_misc:updateStatus", function(status, location, is_want_remove, list, coords, distance)
	alarm = status
	if not is_want_remove then
		if list.name_run == 1 or list.name_run == 2 or list.name_run == 3 or list.name_run == 4 or list.name_run == 5 or list.name_run == 6 or list.name_run == 7 or list.name_run == 8 or list.name_run == 9 or list.name_run == 10 then
			helpMeCount = list.number
		elseif list.name_run == "my_location" or list.name_run == "my_location_2" or list.name_run == "my_location_3" or list.name_run == "my_location_4" or list.name_run == "my_location_5" or list.name_run == "my_location_6" or list.name_run == "my_location_7" or list.name_run == "my_location_8" or list.name_run == "my_location_9" or list.name_run == "my_location_10" or list.name_run == "my_location_11" or list.name_run == "my_location_12" or list.name_run == "my_location_13" or list.name_run == "my_location_14" or list.name_run == "my_location_15" then
			myLocCount = list.number
			
			local ped = PlayerPedId()
			local pedCoords = GetEntityCoords(ped)
			local check = 0
			
			check = GetDistanceBetweenCoords(pedCoords, coords, true)
		
			if check <= distance then
				meInzone = true
			else
				meInzone = false
			end
		end
	else
		if notified == nil then
			intialNotified()
		else
			for i=1, #alarm, 1 do
				if alarm[i].location == location then
					--[[if is_want_remove and location == "my_location" or location == "my_location_2" or location == "my_location_3" or location == "my_location_4" or location == "my_location_5" or location == "my_location_6" or location == "my_location_7" or location == "my_location_8" or location == "my_location_9" or location == "my_location_10" or location == "my_location_11" or location == "my_location_12" or location == "my_location_13" or location == "my_location_14" or location == "my_location_15" then
						StopScreenEffect('DeathFailOut')
						SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),GetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(),false),"CHandlingData","fInitialDriveMaxFlatVel"))
						EnableAllControlActions(0)
					end--]]
					checkSkyTransitionANDgodmod(i)	
					Dontnotified[i] = false
					if not alarm[i].siren and notified[i] then
						notified[i] = false
						alarm_leo_PlayWithinDistance[i] = false
					end
				end
			end
		end
	end
end)

RegisterNetEvent("esx_misc:updateStatus_notifieNO")
AddEventHandler("esx_misc:updateStatus_notifieNO", function(status)
	alarm = status

	for i=1, #alarm, 1 do
		Dontnotified[i] = true
		checkSkyTransitionANDgodmod(i)	
	end	
end)

RegisterNetEvent("esx_misc:updateNoCrimetime")
AddEventHandler("esx_misc:updateNoCrimetime", function(data)
	NoCrimetime = data
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
	--print('# no crime zone found')
	data.active = false
	return data
end

function isNoCrimetime2()
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

function intialNotified()
	for i=1, #alarm, 1 do
		notified[i] = false
		alarm_leo_PlayWithinDistance[i] = false
	end
end

function showNotification(i)
	if not exports.esx_visa:IsPlayerVisaTesting() then
		while alarm == nil or PlayerData == nil do
			Citizen.Wait(500)
		end
		
		notified[i] = true
		local location, label = alarm[i].location, alarm[i].label
		local msg = nil
		local XPmsg = nil
		local start = true
		local data = nil
		
		if locationsData[location] ~= nil then
			data = locationsData[location]
		end
		
		if (MycurrentJobLeo) then
			if data ~= nil and data.leo.notification ~= nil then
				msg = data.leo.notification
			end
		else
			if data ~= nil and data.citizen.notification ~= nil then
				msg = data.citizen.notification
			end
		end
		
		if msg == nil then
			if ( MycurrentJobLeo ) then
				msg = locationsData['other'].leo.notification
			else
				msg = locationsData['other'].citizen.notification
			end	
		end
		
		local function startSendNotification()
			Citizen.CreateThread(function()
				for j=1, #msg, 1 do
					if location == 'peace_time' or location == 'restart_time' or location == '9eanh_time' and alarm[i].siren then
						if start then
							start = false
							Citizen.Wait(3000)
							ESX.ShowNotification(msg[j]..label)
							PlaySoundFrontend(-1, "GOLF_NEW_RECORD", "HUD_AWARDS", true)
							
							while GetPlayerSwitchState() ~= 12 do
								Citizen.Wait(1)
							end
						else
							ESX.ShowNotification(msg[j])
							PlaySoundFrontend(-1, "OTHER_TEXT", "HUD_AWARDS", true)
							Citizen.Wait(7000)
						end
					elseif alarm[i].siren then
						if start then
							start = false
							if not Dontnotified[i] then
							Citizen.Wait(2000)
							ESX.ShowNotification(msg[j]..label)
							PlaySoundFrontend(-1, "GOLF_NEW_RECORD", "HUD_AWARDS", true)
							Citizen.Wait(7000)
							else
						    Dontnotified[i] = false
						end
						else
						if not Dontnotified[i] then
							ESX.ShowNotification(msg[j])
							PlaySoundFrontend(-1, "OTHER_TEXT", "HUD_AWARDS", true)
							Citizen.Wait(7000)
							else
						    Dontnotified[i] = false
						end
						end
					else
					    if not Dontnotified[i] then
						ESX.ShowNotification('<font color=green>تم إلغاء الحالة في<font color=orange> '..label)
						PlaySoundFrontend(-1, "OTHER_TEXT", "HUD_AWARDS", true)
						else
						Dontnotified[i] = false
						end
						break
					end
				end
				if alarm[i].siren and XPmsg ~= nil then
					ESX.ShowNotification(XPmsg)
					PlaySoundFrontend(-1, "OTHER_TEXT", "HUD_AWARDS", true)
				end
			end)
		end
		
		local function isNoXPzoneNotification(i)
			local found = false
			for j=1,#noXPzones,1 do
				if noXPzones[j] == location then
					found = true
					break
				end
			end
			if not found then
				XPmsg = 'منطقة استنفار<font color=orange> '..label..' </br><font color=#0094FF>تمنحك خبرة إضافية'
			end
		end
		
		if not ( MycurrentJobLeo )  then
			startSendNotification()
		elseif ( MycurrentJobLeo )  then
			isNoXPzoneNotification(i)
			startSendNotification()
		end
	end
end

--trigger alarm
RegisterNetEvent("esx_misc:TriggerPanicButton")
AddEventHandler("esx_misc:TriggerPanicButton", function(location, siren, label)	
	if location ~= 'peace_time' or location ~= '9eanh_time' and  location ~= 'sea_port_friday' and  location ~= 'blaine_meeting' then
		sendPhoneAlert(location, siren, label)
	end	
end)

--main
Citizen.CreateThread(function()
	while alarm == nil or PlayerData == nil do
		Citizen.Wait(500)
	end
	
	while true do
		Citizen.Wait(1)
		for i=1, #alarm, 1 do 
			if isInsideArea(i) and alarm[i].siren then
				
				if not ( MycurrentJobLeo ) and not notified[i] then
					showNotification(i)
					
					if isSirenZone(i) then
					--# Old is "risk" new is "risk2"
						TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 700, "risk2", 0.1)
					end
				elseif not alarm_leo_PlayWithinDistance[i] and isSirenZone(i) then
					TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 700, "risk2", 0.1)
					alarm_leo_PlayWithinDistance[i] = true
					
				end
			end
		end	
	end
end)

function isSirenZone(i)
	local location = alarm[i].location
	local noSirenZone = Config.panicButton.noSirenZone
	
	for i=1,#noSirenZone,1 do
		if noSirenZone[i] == location then
			return false
		end
	end
	
	return true
end

--xp level
local giveXP = {}
local takeXP = {}
Citizen.CreateThread(function()
	while alarm == nil or PlayerData == nil do
		Citizen.Wait(500)
	end
	
	local takeXPzones = Config.panicButton.takeXPzones
	
	local function isNoXPzones(i)
		for j=1,#noXPzones,1 do
			if alarm[i].location == noXPzones[j] then
				return false
			end
		end
		return true
	end
	
	local function isTakeXPzones(i)
		for j=1,#takeXPzones,1 do
			if alarm[i].location == takeXPzones[j] then
				return true
			end
		end
		return false
	end 
	
	for i=1, #alarm, 1 do
		giveXP[i] = false
		takeXP[i] = false
	end
	
	while true do
		Citizen.Wait(1)
		
		if ( MycurrentJobLeo ) then
			for i=1, #alarm, 1 do
				if alarm[i].siren and isInsideArea(i) and not giveXP[i] and isNoXPzones(i) then
					giveXP[i] = true
					startGiveXP(i)
				end
			end	
		end
		
		if not ( MycurrentJobLeo ) then
			for i=1, #alarm, 1 do
				if alarm[i].siren and isInsideArea(i) and not takeXP[i] and isTakeXPzones(i) then
					takeXP[i] = true
					startTakeXP(i)
				end
			end	
		end
	end	
end)

--give XP to leo jobs inside blip
function startGiveXP(i)
	Citizen.CreateThread(function()
		local waitime = Config.panicButton.giveXPtime
		local PlayerOnlineTime = -1
		local myxp = Config.panicButton.giveXPvalue
		
		while alarm[i].siren and isInsideArea(i) and ( MycurrentJobLeo ) do
			PlayerOnlineTime = PlayerOnlineTime + 1
			if Config.dev_mod then print('# startGiveXP PlayerOnlineTime='..PlayerOnlineTime..' waitime='..waitime) end
			if PlayerOnlineTime == waitime then
				if Config.dev_mod then print('# SystemXpLevel:AddPlayerXP'..myxp) end
				TriggerServerEvent('SystemXpLevel:updateCurrentPlayerXP_clientSide', 'add', myxp, 'الأستنفارات: التواجد في منطقة تمنح خبرة إضافية')
				PlayerOnlineTime = 0
			end	
			
			Citizen.Wait(60000)
		end
		if Config.dev_mod then print('# STOP startGiveXP') end
		giveXP[i] = false
	end)
end

function startTakeXP(i)
	if exports.esx_jail.isPlayerJailed() then
		return
	end
	
	Citizen.CreateThread(function()
		local waitime = Config.panicButton.takeXPtime
		local PlayerOnlineTime = -1
		local myxp = Config.panicButton.takeXPvalue
		
		while alarm[i].siren and isInsideArea(i) and not ( MycurrentJobLeo ) do
			PlayerOnlineTime = PlayerOnlineTime + 1
			if Config.dev_mod then print('# startTakeXP PlayerOnlineTime='..PlayerOnlineTime..' waitime='..waitime) end
			if PlayerOnlineTime == waitime then
				if Config.dev_mod then print('# SystemXpLevel:RemovePlayerXP = '..myxp) end
				TriggerServerEvent('SystemXpLevel:updateCurrentPlayerXP_clientSide', 'remove', myxp, 'الأستنفارات: التواجد في منطقة تخصم خبرة')
				ESX.ShowNotification('<font color=red>تم خصم <font color=orange> '..myxp..' <font color=red> من خبرتك</br>لتواجدك داخل منطقة محظورة')
				PlaySoundFrontend(-1, "OTHER_TEXT", "HUD_AWARDS", true)
				PlayerOnlineTime = 0
				if myxp ~= 100 then
					myxp = myxp + 10
				end	
			end	
			
			Citizen.Wait(60000)
		end
		if Config.dev_mod then print('# STOP startTakeXP') end
		takeXP[i] = false
	end)
end

--citizen draw text values
local msg1 = {}
local color1 = {}
--leo draw text values
local msg2 = {}
local color2 = {}
--general draw text values
local font = 1 	-- 0 or 1
local scale = 0.4
local DrawTextYbase = 0.860

--draw text citizen only
Citizen.CreateThread(function()
	while alarm == nil or PlayerData == nil do
		Citizen.Wait(500)
	end
	
	for i=1, #alarm, 1 do
		citizenDrawTextStatus[i] = false
		msg1[i] = nil
		color1[i] = {}
	end
	
	while true do
		Citizen.Wait(1)
		
		if not ( MycurrentJobLeo ) then
			for i=1, #alarm, 1 do
				if alarm[i].siren and isInsideArea(i) and not citizenDrawTextStatus[i] then
					if alarm[i].location == 'sea_port_close' then
						if exports.esx_jail.isPlayerJailed() then
							return
						end
					end
					citizenDrawTextStatus[i] = true
					citizenDrawText(i)
					resetDrawTextY() --reset draw text Y axisend	
				end
			end	
		end
	end	
end)

local zone_key = {
	DisabledKeys = { -- here you can choose what Keys you want to Disable -- هنا يمكنك اختيار المفاتيح التي تريد اطفائها
        {Index = 288, types = 0}, --(F1)
        {Index = 289, types = 0}, --(F2)
        {Index = 170, types = 0}, --(F3)
		{Index = 166, types = 0}, --(F5)
		{Index = 167, types = 0}, --(F6)
		{Index = 168, types = 0}, --(F7)
		{Index = 56, types = 0}, --(F9)
		{Index = 57, types = 0}, --(F10)
		{Index = 44, types = 0}, --(Q)
		{Index = 45, types = 0}, --(R)
		{Index = 245, types = 0}, --(T)
		{Index = 47, types = 0}, --(G)
		{Index = 74, types = 0}, --(H)
		{Index = 20, types = 0}, --(Z)
		{Index = 29, types = 0}, --(B)
		{Index = 244, types = 0}, --(M)
		{Index = 37, types = 0}, --(TAB)
		{Index = 137, types = 0}, --(CAPS)
		{Index = 21, types = 0}, --(LEFTSHIFT)
		{Index = 36, types = 0}, --(LEFTCTRL)
		{Index = 24, types = 0}, --(LEFTMOUSEBUTTON)
		{Index = 22, types = 0} --(SPACE)
    }
}

local DustyScreen = false
local car = false

local DustyScreen_restricted_area = false
local car_restricted_area = false

local DustyScreen_sea_port_close = false
local car_sea_port_close = false

local DustyScreen_seaport_west_close = false
local car_seaport_west_close = false

local DustyScreen_internationa_close = false
local car_internationa_close = false


function citizenDrawText(i)
	local check = false
	local data = nil
	
	if locationsData[alarm[i].location] ~= nil then
		data = locationsData[alarm[i].location]
		if data ~= nil and data.citizen.draw ~= nil and data.citizen.color ~= nil then	
			msg1[i] = '[ '..alarm[i].name..' ] '.. data.citizen.draw 
			color1[i] = data.citizen.color
			check = true
		end
	end
	
	if not check then
		msg1[i] = '[ '..alarm[i].name..' ] '..locationsData['other'].citizen.draw 
		color1[i] = locationsData['other'].citizen.color
	end
	
	--start draw
	Citizen.CreateThread(function()
		Citizen.Wait(100)
		
		while alarm[i].siren do
			Citizen.Wait(0)
			if isInsideArea(i) then
				SetTextColour(color1[i].r,color1[i].g,color1[i].b,color1[i].a)
				SetTextFont(fontId)
				SetTextScale(scale, scale)
				SetTextWrap(0.0, 1.0)
				SetTextCentre(true)
				SetTextDropshadow(2, 2, 0, 0, 0)
				SetTextEdge(1, 0, 0, 0, 205)
				SetTextEntry("STRING")
				if isAlarmTimerZone(i) then	
					if timer_is_want_start[alarm[i].location] then
						AddTextComponentString('['..TimerConvert(timer_is_want_start[alarm[i].location].time)..']  '..msg1[i])
					end
				elseif alarm[i].myLoc then
					AddTextComponentString('['..myLocCount..']  '..msg1[i])
					if PlayerData.job.name == "admin" or PlayerData.job.name == "police" or PlayerData.job.name == "agent" or PlayerData.job.name == "mechanic" or PlayerData.job.name == "ambulance" then
						SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),GetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(),false),"CHandlingData","fInitialDriveMaxFlatVel"))
						if DustyScreen then
							StopScreenEffect('DeathFailOut')
							DustyScreen = false
						end
						if car then
							if GetVehiclePedIsIn(PlayerPedId(),false) == 0 then
								car = false
							else
								SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),GetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(),false),"CHandlingData","fInitialDriveMaxFlatVel"))
								car = false
							end
						end
					else
						if meInzone then
							--print()
						else
							if DustyScreen then
								--print()
							else
								DustyScreen = true
								SetCurrentPedWeapon(PlayerPedId(),GetHashKey("WEAPON_UNARMED"),true)
								StartScreenEffect('DeathFailOut', 0, true)
							end
							for i, r in pairs(zone_key.DisabledKeys) do
								DisableControlAction(r['types'], r['Index'], true)
							end
							if not car then
								if GetVehiclePedIsIn(PlayerPedId(),false) == 0 then
									car = false
								else
									SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),(20/2.236936))
									car = true
								end
							end
						end
					end
				elseif alarm[i].helpMe then
					AddTextComponentString('['..helpMeCount..']  '..msg1[i])
				elseif alarm[i].location == "restricted_area" then
					AddTextComponentString(msg1[i])
					if PlayerData.job.name == "admin" then
						SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),GetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(),false),"CHandlingData","fInitialDriveMaxFlatVel"))
						if DustyScreen_restricted_area then
							StopScreenEffect('DeathFailOut')
							DustyScreen_restricted_area = false
						end
						if car_restricted_area then
							if GetVehiclePedIsIn(PlayerPedId(),false) == 0 then
								car_restricted_area = false
							else
								SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),GetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(),false),"CHandlingData","fInitialDriveMaxFlatVel"))
								car_restricted_area = false
							end
						end
					else
						if DustyScreen_restricted_area then
							--print()
						else
							DustyScreen_restricted_area = true
							SetCurrentPedWeapon(PlayerPedId(),GetHashKey("WEAPON_UNARMED"),true)
							StartScreenEffect('DeathFailOut', 0, true)
						end
						for i, r in pairs(zone_key.DisabledKeys) do
							DisableControlAction(r['types'], r['Index'], true)
						end
						if not car_restricted_area then
							if GetVehiclePedIsIn(PlayerPedId(),false) == 0 then
								car_restricted_area = false
							else
								SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),(20/2.236936))
								car_restricted_area = true
							end
						end
					end
				elseif alarm[i].location == "sea_port_close" then
					AddTextComponentString(msg1[i])
					if PlayerData.job.name == "admin" then
						SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),GetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(),false),"CHandlingData","fInitialDriveMaxFlatVel"))
						if DustyScreen_sea_port_close then
							StopScreenEffect('DeathFailOut')
							DustyScreen_sea_port_close = false
						end
						if car_sea_port_close then
							if GetVehiclePedIsIn(PlayerPedId(),false) == 0 then
								car_sea_port_close = false
							else
								SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),GetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(),false),"CHandlingData","fInitialDriveMaxFlatVel"))
								car_sea_port_close = false
							end
						end
					else
						if DustyScreen_sea_port_close then
							--print()
						else
							DustyScreen_sea_port_close = true
							SetCurrentPedWeapon(PlayerPedId(),GetHashKey("WEAPON_UNARMED"),true)
							StartScreenEffect('DeathFailOut', 0, true)
						end
						for i, r in pairs(zone_key.DisabledKeys) do
							DisableControlAction(r['types'], r['Index'], true)
						end
						if not car_sea_port_close then
							if GetVehiclePedIsIn(PlayerPedId(),false) == 0 then
								car_sea_port_close = false
							else
								SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),(20/2.236936))
								car_sea_port_close = true
							end
						end
					end
				elseif alarm[i].location == "seaport_west_close" then
					AddTextComponentString(msg1[i])
					if PlayerData.job.name == "admin" then
						SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),GetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(),false),"CHandlingData","fInitialDriveMaxFlatVel"))
						if DustyScreen_seaport_west_close then
							StopScreenEffect('DeathFailOut')
							DustyScreen_seaport_west_close = false
						end
						if car_seaport_west_close then
							if GetVehiclePedIsIn(PlayerPedId(),false) == 0 then
								car_seaport_west_close = false
							else
								SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),GetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(),false),"CHandlingData","fInitialDriveMaxFlatVel"))
								car_seaport_west_close = false
							end
						end
					else
						if DustyScreen_seaport_west_close then
							--print()
						else
							DustyScreen_seaport_west_close = true
							SetCurrentPedWeapon(PlayerPedId(),GetHashKey("WEAPON_UNARMED"),true)
							StartScreenEffect('DeathFailOut', 0, true)
						end
						for i, r in pairs(zone_key.DisabledKeys) do
							DisableControlAction(r['types'], r['Index'], true)
						end
						if not car_seaport_west_close then
							if GetVehiclePedIsIn(PlayerPedId(),false) == 0 then
								car_seaport_west_close = false
							else
								SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),(20/2.236936))
								car_seaport_west_close = true
							end
						end
					end
				elseif alarm[i].location == "internationa_close" then
					AddTextComponentString(msg1[i])
					if PlayerData.job.name == "admin" then
						SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),GetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(),false),"CHandlingData","fInitialDriveMaxFlatVel"))
						if DustyScreen_internationa_close then
							StopScreenEffect('DeathFailOut')
							DustyScreen_internationa_close = false
						end
						if car_internationa_close then
							if GetVehiclePedIsIn(PlayerPedId(),false) == 0 then
								car_internationa_close = false
							else
								SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),GetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(),false),"CHandlingData","fInitialDriveMaxFlatVel"))
								car_internationa_close = false
							end
						end
					else
						if DustyScreen_internationa_close then
							--print()
						else
							DustyScreen_internationa_close = true
							SetCurrentPedWeapon(PlayerPedId(),GetHashKey("WEAPON_UNARMED"),true)
							StartScreenEffect('DeathFailOut', 0, true)
						end
						for i, r in pairs(zone_key.DisabledKeys) do
							DisableControlAction(r['types'], r['Index'], true)
						end
						if not car_internationa_close then
							if GetVehiclePedIsIn(PlayerPedId(),false) == 0 then
								car_internationa_close = false
							else
								SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),(20/2.236936))
								car_internationa_close = true
							end
						end
					end
				else
					AddTextComponentString(msg1[i])
				end
				DrawText(0.500, DrawTextY[i])
			elseif not isInsideArea(i) then
				if alarm[i].location == "restricted_area" then
					if DustyScreen_restricted_area then
						StopScreenEffect('DeathFailOut')
						DustyScreen_restricted_area = false
					end
					if car_restricted_area then
						if GetVehiclePedIsIn(PlayerPedId(),false) == 0 then
							car_restricted_area = false
						else
							SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),GetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(),false),"CHandlingData","fInitialDriveMaxFlatVel"))
							car_restricted_area = false
						end
					end
				elseif alarm[i].location == "sea_port_close" then
					if DustyScreen_sea_port_close then
						StopScreenEffect('DeathFailOut')
						DustyScreen_sea_port_close = false
					end
					if car_sea_port_close then
						if GetVehiclePedIsIn(PlayerPedId(),false) == 0 then
							car_sea_port_close = false
						else
							SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),GetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(),false),"CHandlingData","fInitialDriveMaxFlatVel"))
							car_sea_port_close = false
						end
					end
				elseif alarm[i].location == "seaport_west_close" then
					if DustyScreen_seaport_west_close then
						StopScreenEffect('DeathFailOut')
						DustyScreen_seaport_west_close = false
					end
					if car_seaport_west_close then
						if GetVehiclePedIsIn(PlayerPedId(),false) == 0 then
							car_seaport_west_close = false
						else
							SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),GetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(),false),"CHandlingData","fInitialDriveMaxFlatVel"))
							car_seaport_west_close = false
						end
					end
				elseif alarm[i].location == "internationa_close" then
					if DustyScreen_internationa_close then
						StopScreenEffect('DeathFailOut')
						DustyScreen_internationa_close = false
					end
					if car_internationa_close then
						if GetVehiclePedIsIn(PlayerPedId(),false) == 0 then
							car_internationa_close = false
						else
							SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),GetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(),false),"CHandlingData","fInitialDriveMaxFlatVel"))
							car_internationa_close = false
						end
					end
				elseif alarm[i].myLoc then
					meInzone = false
					if DustyScreen then
						StopScreenEffect('DeathFailOut')
						DustyScreen = false
					end
					if car then
						SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),GetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(),false),"CHandlingData","fInitialDriveMaxFlatVel"))
						car = false
					end
				end
			end
		end
		
		citizenDrawTextStatus[i] = false
		resetDrawTextY()
	end)
end

--blib and leo draw text text for police
Citizen.CreateThread(function()
	while alarm == nil or PlayerData == nil do
		Citizen.Wait(500)
	end
	
	for i=1, #alarm, 1 do
		blipDetail[i] = AddBlipForRadius(alarm[i].coords, alarm[i].dist)
		SetBlipAlpha(blipDetail[i], 0)
		LeoDrawTextStatus[i] = false
		DrawTextY[i] = 0.0
		godmodStarted[i] = false
		color2[i] = {}
		msg2[i] = nil
	end
	
	while true do
		Citizen.Wait(1)
		for i=1, #alarm, 1 do
			if alarm[i].siren then
				if not blipStatus[i] then
					blipStatus[i] = true
					startBlip(i)
				end
				
				if ( MycurrentJobLeo ) then
					if not LeoDrawTextStatus[i] and (not alarm[i].myLoc or not myLocDraw) and (not alarm[i].helpMe or not helpMeDraw) then

						if alarm[i].myLoc then

							myLocDrawName = alarm[i].location

						elseif alarm[i].helpMe then

							helpMeDrawName = alarm[i].location

						end

						LeoDrawTextStatus[i] = true
						LeoDrawText(i) --call draw text for police function
						resetDrawTextY() --reset draw text Y axis
					end
					
					if not notified[i] then
						showNotification(i)
					end
				end	
			elseif not alarm[i].siren and blipStatus[i] then
				blipStatus[i] = false
				SetBlipAlpha(blipDetail[i], 0)
			end
		end	
		end	
end)

--start blip
function startBlip(i)
	while alarm[i].coords == nil do
		Citizen.Wait(0)
	end	
	
	--[[add this for alarm use current player location
	if alarm[i].location == 'my_location' then
		blipDetail[i] = AddBlipForRadius(alarm[i].coords, alarm[i].dist)
	elseif alarm[i].location == 'my_location_safezone' then
	    blipDetail[i] = AddBlipForRadius(alarm[i].coords, alarm[i].dist)
	elseif alarm[i].location == 'helpme' then
	    blipDetail[i] = AddBlipForRadius(alarm[i].coords, alarm[i].dist)
	elseif alarm[i].location == 'event_start' then
	    blipDetail[i] = AddBlipForRadius(alarm[i].coords, alarm[i].dist)
	elseif alarm[i].location == 'event_location' then
	    blipDetail[i] = AddBlipForRadius(alarm[i].coords, alarm[i].dist)
	elseif alarm[i].location == 'event_registration' then
	    blipDetail[i] = AddBlipForRadius(alarm[i].coords, alarm[i].dist)
	elseif alarm[i].location == 'event_end' then
	    blipDetail[i] = AddBlipForRadius(alarm[i].coords, alarm[i].dist)
	elseif alarm[i].location == 'restricted_area' then
	    blipDetail[i] = AddBlipForRadius(alarm[i].coords, alarm[i].dist)
	end]]
	
	blipDetail[i] = AddBlipForRadius(alarm[i].coords, alarm[i].dist)
	
	SetBlipHighDetail(blipDetail[i], true)
	SetBlipAlpha(blipDetail[i], 100)
	SetBlipAsShortRange(blipDetail[i], true)
	
	falshBlipcolor(i) --call blip color function
	
end

--blip function blip color
function falshBlipcolor(i)
	Citizen.CreateThread(function()
		local red = blipColor.red
		local blue = blipColor.blue
		local blipColor = blue
		local check = false
		local data = nil
		
		if locationsData[alarm[i].location] ~= nil then
			data = locationsData[alarm[i].location]
			if data.blipColor ~= nil and data.location == alarm[i].location then
				blipcolor = data.blipColor
				check = true
			end
		end	
		
		if check then
			local alpha = 100
			SetBlipColour(blipDetail[i], blipcolor) --set blip color
			
			while alarm[i].siren do --make blip alpha glow
				while alpha <= 140 do
					alpha = alpha + 1
					SetBlipAlpha(blipDetail[i], alpha)
					
					Citizen.Wait(1)
				end
				
				while alpha >= 60 do
					alpha = alpha - 1
					SetBlipAlpha(blipDetail[i], alpha)
					
					Citizen.Wait(1)
				end
				
				Citizen.Wait(500)
			end	
			
			SetBlipAlpha(blipDetail[i], 0)	
		else
			while alarm[i].siren do
				if blipColor == blue then
					blipColor = red
					SetBlipColour(blipDetail[i], blipColor)
				else
					blipColor = blue
					SetBlipColour(blipDetail[i], blipColor)
				end	
				Citizen.Wait(500)
			end	
			
			SetBlipAlpha(blipDetail[i], 0)
		end
	end)
end

--draw text for police function
function LeoDrawText(i)
	local check = false
	local data = nil

	if alarm[i].myLoc then

	    myLocDraw = true

	elseif alarm[i].helpMe then

		helpMeDraw = true

	end
		
	if locationsData[alarm[i].location] ~= nil then
		data = locationsData[alarm[i].location]
		if (data.leo.draw ~= nil and data.leo.color ~= nil and data.location == alarm[i].location) or alarm[i].helpMe then
			msg2[i] = '[ '..alarm[i].name..' ] '.. data.leo.draw
			color2[i] = data.leo.color
			check = true
		end
	end
	
	if not check then
		msg2[i] = '[ '..alarm[i].name..' ] '..locationsData.other.leo.draw
		color2[i] = locationsData.other.leo.color
	end
	
	Citizen.CreateThread(function()
		Citizen.Wait(100)
		
		while alarm[i].siren and ( MycurrentJobLeo ) do
		--while alarm[i].siren and ( MycurrentJobLeo or PlayerData.job == 'ambulance' ) or isInsideArea(i) do
			Citizen.Wait(0)
			if GetPlayerSwitchState() == 12 and not hidehud and alarm[i].siren then
				SetTextColour(color2[i].r,color2[i].g,color2[i].b,color2[i].a)
				SetTextFont(fontId)
				SetTextScale(scale, scale)
				SetTextWrap(0.0, 1.0)
				SetTextCentre(true)
				SetTextDropshadow(2, 2, 0, 0, 0)
				SetTextEdge(1, 0, 0, 0, 205)
				SetTextEntry("STRING")
				if isAlarmTimerZone(i) then
					if timer_is_want_start[alarm[i].location] then
						AddTextComponentString('['..TimerConvert(timer_is_want_start[alarm[i].location].time)..']  '..msg2[i])
					end
				
				elseif alarm[i].myLoc then

					AddTextComponentString('['..myLocCount..']  '..msg2[i])
				elseif alarm[i].helpMe then
					
					AddTextComponentString('['..helpMeCount..']  '..msg2[i])

				elseif alarm[i].location == "restricted_area" then
					if isInsideArea(i) then
						AddTextComponentString(msg2[i])
						if PlayerData.job.name == "admin" then
							if DustyScreen_restricted_area then
								StopScreenEffect('DeathFailOut')
								DustyScreen_restricted_area = false
							end
							if car_restricted_area then
								if GetVehiclePedIsIn(PlayerPedId(),false) == 0 then
									car_restricted_area = false
								else
									SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),GetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(),false),"CHandlingData","fInitialDriveMaxFlatVel"))
									car_restricted_area = false
								end
							end
						else
							if DustyScreen_restricted_area then
								--print()
							else
								DustyScreen_restricted_area = true
								SetCurrentPedWeapon(PlayerPedId(),GetHashKey("WEAPON_UNARMED"),true)
								StartScreenEffect('DeathFailOut', 0, true)
							end
							for i, r in pairs(zone_key.DisabledKeys) do
								DisableControlAction(r['types'], r['Index'], true)
							end
							if not car_restricted_area then
								if GetVehiclePedIsIn(PlayerPedId(),false) == 0 then
									car_restricted_area = false
								else
									SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),(20/2.236936))
									car_restricted_area = true
								end
							end
						end
					else
						if DustyScreen_restricted_area then
							StopScreenEffect('DeathFailOut')
							DustyScreen_restricted_area = false
						end
						if car_restricted_area then
							if GetVehiclePedIsIn(PlayerPedId(),false) == 0 then
								car_restricted_area = false
							else
								SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),GetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(),false),"CHandlingData","fInitialDriveMaxFlatVel"))
								car_restricted_area = false
							end
						end
					end
				else
					AddTextComponentString(msg2[i])
				end
				DrawText(0.500, DrawTextY[i])
			end
		end	
		
		if alarm[i].myLoc then

			myLocDraw = false

		elseif alarm[i].helpMe then

			helpMeDraw = false

		end

		LeoDrawTextStatus[i] = false
		resetDrawTextY()
	end)
end

function resetDrawTextY()
	local count = 1
	local k = 0
	local y

	if MycurrentJobLeo then

		for i=1, #alarm, 1 do
			if alarm[i].siren and (not alarm[i].myLoc or myLocDrawName == alarm[i].location) and (not alarm[i].helpMe or helpMeDrawName == alarm[i].location) then
				if count == 1 then
					DrawTextY[i] = DrawTextYbase
					y = DrawTextYbase
				else
					y = y - 0.025
					DrawTextY[i] = y
				end
				count = count + 1
			end
		end	

	else

		for i=1, #alarm, 1 do
			if alarm[i].siren then
				if count == 1 then
					DrawTextY[i] = DrawTextYbase
					y = DrawTextYbase
				else
					y = y - 0.025
					DrawTextY[i] = y
				end
				count = count + 1
			end
		end	

	end
end

--check if inside alert radiuas dist
function isInsideArea(i)
	local ped = PlayerPedId()
	local pedCoords = GetEntityCoords(ped)
	local check = 0
	
	check = GetDistanceBetweenCoords(pedCoords, alarm[i].coords, true)

	if check <= alarm[i].dist then
		return true
	else
		return false
	end		
end	

--send alert phone msg to police --DISABLE NOW FOR GCC PHONE
function sendPhoneAlert(location, siren, label)
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
	
	local msg = nil
	local msg2 = nil
	
	if location == 'hacker' then 
		msg = 'هذا بلاغ تلقائي.. تم اطلاق صافرة الانذار وحالة الاستنفار الأمني لمكافحة'..label..' من قبل: '
		msg2 = 'هذا بلاغ تلقائي.. تم إلغاء حالة الاستنفار الأمني لمكافحة '..label..' من قبل: '
	elseif location == 'my_location_safezone' then 
		msg = 'هذا بلاغ تلقائي.. تم اعلان حالة '..label..' من قبل: '
		msg2 = 'هذا بلاغ تلقائي.. تم إلغاء حالة '..label..' من قبل: '
	elseif location == 'peace_time' then 
		msg = 'هذا بلاغ تلقائي.. تم اعلان '..label..' من قبل: '
		msg2 = 'هذا بلاغ تلقائي.. تم انتهاء '..label..' من قبل: '
	elseif location == '9eanh_time' then 
		msg = 'هذا بلاغ تلقائي.. تم اعلان '..label..' من قبل: '
		msg2 = 'هذا بلاغ تلقائي.. تم انتهاء '..label..' من قبل: '
	elseif location == 'helpme' then 
		msg = 'هذا بلاغ تلقائي.. '..label..' من قبل: '
		msg2 = 'هذا بلاغ تلقائي.. تم انهاء '..label..' من قبل: '
	else
		msg = 'هذا بلاغ تلقائي.. تم اطلاق صافرة الانذار وحالة الاستنفار الأمني في '..label..' من قبل: '
		msg2 = 'هذا بلاغ تلقائي.. تم إلغاء حالة الاستنفار الأمني في '..label..' من قبل: '
	end
	
	
	for i=1, #LeoJobs, 1 do
		if siren then
			TriggerServerEvent('esx_phone:send', LeoJobs[i], msg..PlayerData.job.label, true, {x =x, y =y, z =z})
		else
			TriggerServerEvent('esx_phone:send', LeoJobs[i], msg2..PlayerData.job.label, true, {x =x, y =y, z =z})
		end
	end	
end

--check if player job is leo
--function ( MycurrentJobLeo or PlayerData.job == 'ambulance' ) this var defined in Config and used in "main_esx.lua"

function checkSkyTransitionANDgodmod(i)
--[[
	if isSkyTransitionZone(i) then
			canUseTransition[i] = true
		if Config.dev_mod then print('# canUseTransition is true for: '..alarm[i].location) end
		else
		if Config.dev_mod then print('# canUseTransition is false for: '..alarm[i].location) end
			canUseTransition[i] = false
		end]]
		
		--godmodStarted[i] = false
		--transitionStarted[i] = false
		
		if alarm[i].location == 'peace_time' or alarm[i].location == '9eanh_time' or alarm[i].location == 'restart_time' or alarm[i].location == 'hacker' or alarm[i].location == 'my_location_safezone' then
			canUseGodmod[i] = true
		else
			canUseGodmod[i] = false
		end
		
		
		if isSkyTransitionZone(i) and not canUseTransition[i] then
			canUseTransition[i] = true
		elseif canUseTransition[i] then
			canUseTransition[i] = true
		else
			canUseTransition[i] = false
		end
end

--godmod & sky transition
Citizen.CreateThread(function()
	while alarm == nil or PlayerData == nil do
		Citizen.Wait(500)
	end
	
	--[[
	for i=1, #alarm, 1 do
		godmodStarted[i] = false
		transitionStarted[i] = false
		
		for k=1, #godmodLocations, 1  do
			if godmodLocations[k] == alarm[i].location then
				canUseGodmod[i] = true
			else
				canUseGodmod[i] = false
			end
		end
		
		
		if isSkyTransitionZone(i) then
			canUseTransition[i] = true
			print('canUseTransition is true for: '..alarm[i].location)
		else
		print('canUseTransition is false for: '..alarm[i].location)
			canUseTransition[i] = false
		end
		]]
	
	
	while true do
		Citizen.Wait(1)
		for i=1, #alarm, 1 do
			--god mod
			if canUseGodmod[i] and alarm[i].siren then
				if not godmodStarted[i] and isInsideArea(i) then
					startGodmod(i)
				end
			end
		
			--sky transition
			if not transitionStarted[i] and alarm[i].siren and canUseTransition[i] then
				transitionStarted[i] = true
				if not exports.esx_visa:IsPlayerVisaTesting() then
					TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 1, "peace_time", 0.8)
					doSkyTransition()
				end	
			elseif transitionStarted[i] and not alarm[i].siren and  canUseTransition[i] then
				transitionStarted[i] = false
				if not exports.esx_visa:IsPlayerVisaTesting() then
					TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 1, "peace_time", 0.8)
					doSkyTransition()
				end	
			end
		end
	end	
end)


function isSkyTransitionZone(i)
	for k,v in pairs(Config.panicButton.skyTransitionLocations) do
		if alarm[i].location == v then
			return true
		end	
	end
end

function isAlarmTimerZone(i)
	for k,v in pairs(Config.panicButton.alarmTIMER) do
		if alarm[i].location == v then
			return true
		end	
	end
end

function startGodmod(i)
	godmodStarted[i] = true
	local isAntiExplotionEnabled, previousVehicleModel, previousVehicleHandle
	
	Citizen.CreateThread(function()
	--when godmod ON		
		local player = GetPlayerPed(-1)
		local ped = PlayerId()
		
		--safezone
		ClearPlayerWantedLevel(PlayerId())
		SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
		--godmode
		SetPedCanRagdoll(GetPlayerPed(-1), false)
		
		while isInsideArea(i) and alarm[i].siren do
			Citizen.Wait(0)
			--safezone
			NetworkSetFriendlyFireOption(false)
			--godmode
			SetPlayerInvincible(ped, true)
			SetEntityInvincible(player, true)
			ClearPedBloodDamage(player)
			ResetPedVisibleDamage(player)
			ClearPedLastWeaponDamage(player)
			SetEntityProofs(player, true, true, true, true, true, true, true, true)
			SetEntityOnlyDamagedByPlayer(player, false)
			SetEntityCanBeDamaged(player, false)
			SetEntityHealth(PlayerPedId(-1), 200)
			
			NetworkRequestControlOfEntity(GetVehiclePedIsIn(-1))
			SetVehicleEngineHealth(GetVehiclePedIsIn(player, false), 1000.0)
			--SetVehicleMaxSpeed(GetVehiclePedIsIn(player, false), 50)
			--SetVehicleFixed(GetVehiclePedIsIn(player, false))
			--SetVehicleDirtLevel(GetVehiclePedIsIn(player, false), 0.0)
			--SetVehicleLights(GetVehiclePedIsIn(player, false), 0)
			--SetVehicleBurnout(GetVehiclePedIsIn(player, false), false)
			--Citizen.InvokeNative(0x1FD09E7390A74D54, GetVehiclePedIsIn(player, false), 0)
			
			--safezone
			--if PlayerData.job.name ~= 'admin' then
				DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
				DisablePlayerFiring(player,true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
				DisableControlAction(0, 106, true) -- Disable in-game mouse controls
				DisableControlAction(0, 140, true) -- Disable Reload and melle
				DisableControlAction(0, 141, true) -- Disable melle
			--end
			
			--[[ -- m
			if GetSelectedPedWeapon(ped) == 883325847 or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") or GetSelectedPedWeapon(ped) == GetHashKey("weapon_fireextinguisher") then
			SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
			end]]
			
			--anti explosion
			local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed)
			local isInVehicle, vehiclePedIsIn = IsPedInAnyVehicle(playerPed, false)
	
			if isInVehicle then vehiclePedIsIn = GetVehiclePedIsIn(playerPed, false) end
	
			-- explosion anti cheat
			if IsExplosionInSphere(8, playerCoords.x, playerCoords.y, playerCoords.z, 50.0) or IsExplosionInSphere(31, playerCoords.x, playerCoords.y, playerCoords.z, 50.0) then
				print('Anti-explosions: explosion detected!')
				isAntiExplotionEnabled = true
				SetEntityProofs(playerPed, false, true, true, false, false, false, false, false)
	
				if isInVehicle then
					SetVehicleExplodesOnHighExplosionDamage(vehiclePedIsIn, true)
				end
			elseif isAntiExplotionEnabled then
				print('Anti-explosions: explosion ended!')
				SetEntityProofs(playerPed, false, false, false, false, false, false, false, false)
	
				if isInVehicle then
					SetVehicleExplodesOnHighExplosionDamage(vehiclePedIsIn, false)
				end
			end
	
			--[[model change anti cheat
			if isInVehicle then
				local vehicleModel = GetEntityModel(vehicle)
	
				if vehicle == previousVehicleHandle and vehicleModel ~= previousVehicleModel and previousVehicleModel then
					--print('Detected vehicle model swap!')
					TriggerServerEvent('blaine_blabla:foundhacker', 'vehicle_swap', vehicleModel, previousVehicleModel)
					DeleteEntity(vehicle)
				end
			end]]
		end
	
	--when godmod OFF	
		--safezone
		NetworkSetFriendlyFireOption(true)
		--godmode
		SetPlayerInvincible(ped, false)
		SetEntityInvincible(player, false)
		SetPedCanRagdoll(player, true)
		ClearPedLastWeaponDamage(player)
		SetEntityProofs(player, false, false, false, false, false, false, false, false)
		SetEntityOnlyDamagedByPlayer(player, true)
		SetEntityCanBeDamaged(player, true)
		
		godmodStarted[i] = false
		
	end)	
end

--help me F10
Citizen.CreateThread(function()
	while alarm == nil or PlayerData == nil do
		Citizen.Wait(500)
	end


	local counter = 4
	
	local function DrawCounter(endHelp)
		Citizen.CreateThread(function()
			while IsControlPressed(0, 57) and counter ~= 0 do
				--Citizen.Wait(10)
				Citizen.Wait(2)
				
				if endHelp then

					SetTextColour(0,255,0,150)

				else

					SetTextColour(255,0,0,150)

				end
				
				SetTextFont(fontId)
				SetTextScale(1.0, 1.0)
				SetTextWrap(0.0, 1.0)
				SetTextCentre(true)
				SetTextDropshadow(2, 2, 0, 0, 0)
				SetTextEdge(1, 0, 0, 0, 205)
				SetTextEntry("STRING")
				if endHelp then
					AddTextComponentString(counter..' ﺔﺛﺎﻐﺘﺳﺍ ﺀﺍﺪﻧ ﺀﺎﻬﻧﺍ')

				else

					AddTextComponentString(counter..' ﺔﺛﺎﻐﺘﺳﺍ ﺀﺍﺪﻧ ﻝﺎﺳﺭﺍ')

				end
				DrawText(0.500, 0.500)
				if counter == 0 then
					break
				end
			end	
		end)	
	end
	
	while true do
		Citizen.Wait(0)
		
		if IsControlPressed(0, 57) and GetLastInputMethod(0) and ( MycurrentJobLeo and PlayerData.job.name ~= "mechanic" and PlayerData.job.name ~= "ambulance" and PlayerData.job.name ~= "judgment" ) then
			counter = 4

			local foundInZone = false

			local pedCoords = GetEntityCoords(PlayerPedId())

			for i=1, #alarm, 1 do

				if alarm[i].siren and alarm[i].helpMe then
		
		
					if GetDistanceBetweenCoords(pedCoords, alarm[i].coords, true) <= alarm[i].dist then
		
						foundInZone = true
		
						break
		
					end
		
				end
		
			end

			DrawCounter(foundInZone)
			
			while IsControlPressed(0, 57) and counter ~= 0 do
				counter = counter - 1
				Citizen.Wait(1000)
			end
			
			if counter ~= 0 then
				ESX.ShowNotification('<font color=orange>نداء الإستغاثة</font></br>لمدة 3 ثواني '..'F10'..' استمر بضغط')
			end
		end
		
		if counter == 0 then

			local zoneChecks = helpMeZones

			local zoneName = nil

			local pedCoords = GetEntityCoords(PlayerPedId())

			for i=1, #alarm, 1 do

				if alarm[i].siren and alarm[i].helpMe then
		
					zoneChecks[alarm[i].location] = true
		
					if GetDistanceBetweenCoords(pedCoords, alarm[i].coords, true) <= alarm[i].dist then
						if helpMeCount >= 2 then
							helpMeCount = helpMeCount - 1
						end
						zoneName = alarm[i].location
		
						break
		
					end
		
				end
		
			end

			if zoneName == nil then

				for i=1, #zoneChecks, 1 do

					if not zoneChecks[i] then
			
						zoneName = i
			
						break
			
					end
			
				end

			end

			if zoneName ~= nil then

				local pedCoords = GetEntityCoords(PlayerPedId())
				
				TriggerServerEvent("esx_misc:TogglePanicButton", zoneName, pedCoords)

			else

				ESX.ShowNotification('استحالة التنفيذ, تم الوصول للحد الاقصى من تشغيل حالة الامن هاذه بنفس الوقت </br></br><font color=red> أنتظر انتهاء احدى منها</font>')

			end

			for name,status in pairs(helpMeZones) do

				helpMeZones[name] = false
		
			end
			
			Citizen.CreateThread(function()
				local reset = helpmetime
				
				while helpmetime ~= 0 do
					helpmetime = helpmetime -1
					Citizen.Wait(1000)
				end
				
				Citizen.Wait(100)
				helpmetime = reset
			end)
			
			while IsControlPressed(0, 57) do
				Citizen.Wait(100)
			end
			
			Citizen.Wait(1000)
			
			while helpmetime ~= 0 do
				Citizen.Wait(0)
				
				if IsControlJustReleased(0, 57) and GetLastInputMethod( 0 ) and ( MycurrentJobLeo and PlayerData.job.name ~= "mechanic" and PlayerData.job.name ~= "ambulance" and PlayerData.job.name ~= "judgment" ) then
					ESX.ShowNotification('<font color=red>نداء الاستغاثة</font> عليك الانتظار: <font color=orange>'..helpmetime..'</font> ثانية')
				end
			end
			counter = 4
		end
	end
end)

--- transition code ---
------- Configurable options  -------

-- set the opacity of the clouds
local cloudOpacity = 0.01 -- (default: 0.01)

-- setting this to false will NOT mute the sound as soon as the game loads 
-- (you will hear background noises while on the loading screen, so not recommended)
local muteSound = true -- (default: true)


------- Code -------
-- Mutes or un-mutes the game's sound using a short fade in/out transition.
function ToggleSound(state)
    if state then
        StartAudioScene("MP_LEADERBOARD_SCENE");
    else
        StopAudioScene("MP_LEADERBOARD_SCENE");
    end
end

-- Runs the initial setup whenever the script is loaded.
function InitialSetup()
    -- Disable sound (if configured)
    ToggleSound(muteSound)
    -- Switch out the player if it isn't already in a switch state.
    if not IsPlayerSwitchInProgress() then
        SwitchOutPlayer(PlayerPedId(), 0, 1)
    end
end


-- Hide radar & HUD, set cloud opacity, and use a hacky way of removing third party resource HUD elements.
function ClearScreen()
    SetCloudHatOpacity(cloudOpacity)
    HideHudAndRadarThisFrame()
    
    -- nice hack to 'hide' HUD elements from other resources/scripts. kinda buggy though.
    SetDrawOrigin(0.0, 0.0, 0.0, 0)
end

-- Sometimes this gets called too early, but sometimes it's perfectly timed,
-- we need this to be as early as possible, without it being TOO early, it's a gamble!

function doSkyTransition()
	ESX.UI.Menu.CloseAll()
	TriggerEvent("esx_misc:hidehud", true) -- hide hud in switch state
	
	Citizen.CreateThread(function()	
		while GetPlayerSwitchState() ~= 12 do
			Citizen.Wait(0)
			if PlayerData.job.name ~= 'admin' then
				DisableAllControlActions(0)
			end
		end
	end)
	
	local playerPed = GetPlayerPed(-1)
	local veh =
	
	FreezeEntityPosition(playerPed, true)
	if IsInVehicle() then
		veh = GetVehiclePedIsIn(playerPed)
		FreezeEntityPosition(veh, true)
	end	
	-- In case it was called too early before, call it again just in case.
	InitialSetup()
		
	-- Wait for the switch cam to be in the sky in the 'waiting' state (5).
	while GetPlayerSwitchState() ~= 5 do
		Citizen.Wait(0)
		ClearScreen()
	end
	
	ClearScreen()
	Citizen.Wait(0)
	DoScreenFadeOut(0)
	
	ClearScreen()
	Citizen.Wait(0)
	ClearScreen()
	DoScreenFadeIn(500)
	while not IsScreenFadedIn() do
		Citizen.Wait(0)
		ClearScreen()
	end
	
	local timer = GetGameTimer()
	
	--FreezeEntityPosition(GetPlayerPed(-1), true)
	
	local delaytime = 15 * 1000
	
	-- Re-enable the sound in case it was muted.
	ToggleSound(false)
	ShowLoadingPromt('Loading', delaytime, 3) -- loading icon
	while true do
		Citizen.Wait(0)
		ClearScreen()
		
		-- wait 20 seconds before starting the switch to the player
		if GetGameTimer() - timer > delaytime then
			
			-- Switch to the player.
			SwitchInPlayer(PlayerPedId())
			
			ClearScreen()
			
			-- Wait for the player switch to be completed (state 12).
			while GetPlayerSwitchState() ~= 12 do
				Citizen.Wait(0)
				ClearScreen()
			end
			-- Stop the infinite loop.
			break
		end
	end
	
	-- Reset the draw origin, just in case (allowing HUD elements to re-appear correctly)
	TriggerEvent("esx_misc:hidehud", false) -- show hud after switch state
	
	ClearDrawOrigin()
	Citizen.Wait(500)
	SetEntityVisible(GetPlayerPed(-1), true)
	
	FreezeEntityPosition(playerPed, false)
	if IsInVehicle() then
		veh = GetVehiclePedIsIn(playerPed)
		FreezeEntityPosition(veh, false)
	end
end

function ShowLoadingPromt(msg, time, type)
  Citizen.CreateThread(function()
    Citizen.Wait(0)
    BeginTextCommandBusyString("STRING")
    AddTextComponentString(msg)
    EndTextCommandBusyString(type)
    Citizen.Wait(time)
    RemoveLoadingPrompt()
  end)
end

function IsInVehicle ()
  return GetPedInVehicleSeat(GetVehicle(), -1)
end

function GetVehicle ()
  return GetVehiclePedIsIn(GetPlayerPed(-1), false)
end

--[[RegisterNetEvent('esx_misc:startTimer')
AddEventHandler('esx_misc:startTimer', function(i, peacetime)
	timer = peacetime
	
	Citizen.CreateThread(function()
		while timer > 0 and alarm[i].siren do
			Citizen.Wait(0)
			Citizen.Wait(1000)
			if(timer > 0)then
				timer = timer - 1
			end
		end
	end)
	
	Citizen.CreateThread(function()
		while alarm[i].siren do
			Citizen.Wait(0)
			--drawTxt(0.675, 1.22, 1.0,1.0,0.36, msg..timer, 255, 255, 255, 255)
			if GetPlayerSwitchState() == 12 then
				--label
				SetTextColour(138,0,198,255)
				SetTextFont(font)
				SetTextScale(0.4, 0.4)
				SetTextWrap(0.0, 1.0)
				SetTextCentre(false)
				SetTextDropshadow(2, 2, 0, 0, 0)
				SetTextEdge(1, 0, 0, 0, 205)
				SetTextEntry("STRING")
				AddTextComponentString('Remaining time ['..timer..']')
				DrawText(0.415, 0.010)
			end
		end
	end)
end)]]