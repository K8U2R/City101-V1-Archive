--------------------------------------------------------------------------------------------------------------
------------First off, many thanks to @anders for help with the majority of this script. ---------------------
------------Also shout out to @setro for helping understand pNotify better.              ---------------------
--------------------------------------------------------------------------------------------------------------
------------To configure: Add/replace your own coords in the sectiong directly below.    ---------------------
------------        Goto LINE 90 and change "50" to your desired SafeZone Radius.        ---------------------
------------        Goto LINE 130 to edit the Marker( Holographic circle.)               ---------------------
--------------------------------------------------------------------------------------------------------------
-- Place your own coords here!
local zones = {
	{x= 1847.91,y= 3675.81,z= 33.76, dist=50.0}, --sandy pd
	{x= 442.93,y= -997.96,z= 27.63, dist=50.0 }, --mission row
	{x= -448.38,y= 6014.36,z= 31.72, dist=50.0 }, --paleto pd
	{x= 313.2,y= -1450.77,z= 28.97, dist=50.0 },
	{x=274.6334, y=-2500.2515, z=6.4403, dist=15.0}, -- الحجز الي عند ميناء 101 الغربي
	{x= -603.9956,y= -348.5802,z= 35.22778, dist=50.0 }, --city job center
	{x= -1081.07,y= -249.22,z= 37.76, dist=50.0 },
	{x= -51.62,y= -1095.83,z= 26.42, dist=50.0 },
	{x= -481.28,y= -338.15,z= 34.39, dist=50.0 },	-- mount zonah medical center ouside
	{x= -458.3,y= -364.38,z= -186.46, dist=50.0 },	-- mount zonah medical center inside
	--{x= -44.87,y= -1683.25,z= 29.41, dist=50.0 },	-- used showroom
	{x= 1847.08,y= 2586.01,z= 45.67, dist=25.0 },	-- خارج ومواقف السجن
	{x= 1793.52,y= 2483.52,z= -122.7, dist=25.0 },	-- داخل السجن الرئيسي
	{x= -362.14,y= -134.94,z= 38.68, dist=50.0 },	-- main mechanic
	{x= -736.62,y= -1354.23,z= 8.42, dist=30.0 }, -- baot dealer
	{x= -1094.16,y= -848.55,z= 8.87, dist=50.0 },	-- vespucci test
	{x= 370.23,y= -1643.25,z= 34.17, dist=50.0 },	-- city impound 
	{x= -568.46,y= -158.18,z= 38.07, dist=50.0 },	-- Rockford Hills test
	{x= 825.38,y= -1290.4,z= 28.24, dist=50.0 },	    -- La Mesa test
	{x= -969.39,y= -3001.04, z= 13.95, dist=18.0 },	-- aircraft dealer
	{x= 2233.95,y= 2908.23,z= 45.95, dist=50.0 },	-- Route68 Cars Dealer
	{x= 623.6,y= -0.7,z= 48.33, dist=50.0 },	-- رقابة وتفتيش الرئيسي
	{x= -253.25,y= 6322.88,z= 32.43, dist=50.0 },	--PaletoBayHospital
	{x= 653.49,y= 6490.9,z= 33.78, dist=65.0 },	--PaletoBay used showroom
	{x= 810.07,y= -2915.46,z= 6.13, dist=27.0 },	--seaport center
	--{x= 1652.07,y= 3511.4,z= 38.27, dist=25.0 },	--diwan blaine sandyshores
	{x= 190.06,y= 3187.91,z= 43.84, dist=25.0 },		--mechanic route 68 new sandy 1
	{x= 190.06,y= 3164.35,z= 43.84, dist=25.0 },		--mechanic route 68 new sandy 1
	
	{x= 1224.85,y= 2721.19,z= 38.0, dist=15.0 },	--trucks used showroom
	
	--fire stations
	{x= -1071.19,y= -2377.11,z= 13.95, dist=35.0 }, --international
	{x= 207.12,y= -1649.63, z= 29.8, dist=30.0 }, --LS macdonald st
	{x= 1137.85,y= -1576.35,z= 16.01, dist=50.0 },	-- مستشفى ومطافي داخلي
	{x= 1174.83,y= -1524.6,z= 34.69, dist=90.0 },	-- مستشفى ومطافي خارجي
	{x= 1702.28,y= 3600.11,z= 37.55, dist=20.0 },	-- sandy
	{x= -368.49,y= 6113.45,z= 30.88, dist=30.0 },	-- paleto
	
	{x= 815.94,y= -3030.39,z= 5.74, dist=25.0 },	-- seaport assemble point
	{x= 338.23,y= -590.28,z= 43.28, dist=38.0 },	-- seaport assemble point
	{x= -607.8461,y= -1123.846,z= 22.32092, dist=25.0}, -- معرض مدينة 101 للسيارات
	{x= -576.4088,y= -1120.127,z= 22.37146, dist=25.0}, -- معرض مدينة 101 للسيارات
	{x = -575.2879, y = -1154.624, z = 22.16919, dist=25.0}, -- معرض مدينة 101 للسيارات
	{x = -610.7736, y = -1153.266, z = 22.32092, dist=25.0}, -- معرض مدينة 101 للسيارات
	{x = -612.5934, y = -1093.622, z = 22.32092, dist=25.0}, -- معرض مدينة 101 للسيارات
	{x = -577.767, y = -1092.501, z = 22.16919, dist=25.0}, -- معرض مدينة 101 للسيارات
	{x = -605.1561, y = -1131.191, z =22.32092, dist=25.0}, -- معرض مدينة 101 للسيارات
	{x = 787.8079, y = -2968.4766, z =6.0338, dist=40.0}, -- مركز حرس الحدود
	{x = 822.6503, y = -957.4993, z =26.0281, dist=40.0} -- مركز حرس الحدود
}

local notifIn = false
local notifOut = false
local closestZone = 1
ESX                           = nil
local PlayerData              = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
	
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
		PlayerData.job = job
end)

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		PlayerData = ESX.GetPlayerData()
		local playerPed = GetPlayerPed(-1)
		local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
		local minDistance = 100000
		for i = 1, #zones, 1 do
			dist = Vdist(zones[i].x, zones[i].y, zones[i].z, x, y, z)
			if dist < minDistance then
				minDistance = dist
				closestZone = i
			end
		end
		Citizen.Wait(4000)
	end
end)

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
---------   Setting of friendly fire on and off, disabling your weapons, and sending pNoty   -----------------
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		Citizen.Wait(0)
		local player = GetPlayerPed(-1)
		local x,y,z = table.unpack(GetEntityCoords(player, true))
		local dist = Vdist(zones[closestZone].x, zones[closestZone].y, zones[closestZone].z, x, y, z)
	
		if dist <= zones[closestZone].dist then  ------------------------------------------------------------------------------ Here you can change the RADIUS of the Safe Zone. Remember, whatever you put here will DOUBLE because 
			if not notifIn then																			  -- it is a sphere. So 50 will actually result in a diameter of 100. I assume it is meters. No clue to be honest.
				NetworkSetFriendlyFireOption(false)
				ClearPlayerWantedLevel(PlayerId())
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
					local msg = '<font color=#F6F6F6 size=5><center><b>أنت في  آمنة</b></center></font>'
					--safeZoneNotification(msg,'success')
					TriggerEvent('esx_misc:updatePromotionStatus', 'SafeZone', true)
				notifIn = true
				notifOut = false
			end
		else
			if not notifOut then
				NetworkSetFriendlyFireOption(true)
					local msg = '<font color=#F6F6F6 size=5><center><b>أنت خارج حدود ال الآمنة</b></center></font>'
					--safeZoneNotification(msg,'error')
					TriggerEvent('esx_misc:updatePromotionStatus', 'SafeZone', false)
				notifOut = true
				notifIn = false
			end
		end
		if notifIn then
		if PlayerData.job.name == 'police' or PlayerData.job.name == 'admin' or PlayerData.job.name == 'agent' then
			
		else
		DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
		DisablePlayerFiring(player,true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
		DisableControlAction(0, 106, true) -- Disable in-game mouse controls
		DisableControlAction(0, 45, true) -- Disable R Button
		DisableControlAction(0, 24, true) -- Disable R Button
		DisableControlAction(0, 69, true)
		DisableControlAction(0, 92, true)
		DisableControlAction(0, 106, true)
		DisableControlAction(0, 140, true)
		
			if IsDisabledControlJustPressed(2, 37) then --if Tab is pressed, send error message
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) -- if tab is pressed it will set them to unarmed (this is to cover the vehicle glitch until I sort that all out)
				ESX.ShowNotification('لايمكن إستعمال الأسلحة في <font color=##2ECC71> اَمنة</font>')
			end
			if IsDisabledControlJustPressed(0, 106) then --if LeftClick is pressed, send error message
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) -- If they click it will set them to unarmed
				ESX.ShowNotification('لايمكن إستعمال القوة في <font color=##2ECC71> اَمنة</font>')
			end
			if IsDisabledControlJustPressed(0, 140) then --if R is pressed, send error message
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) -- If they click it will set them to unarmed
				ESX.ShowNotification('لايمكن إستعمال القوة في <font color=##2ECC71> اَمنة</font>')
			end
		end
		end
		-- Comment out lines 142 - 145 if you dont want a marker.
        --if DoesEntityExist(player) then	      --The -1.0001 will place it on the ground flush		-- SIZING CIRCLE |  x    y    z | R   G    B   alpha| *more alpha more transparent*
	 	--	DrawMarker(1, zones[closestZone].x, zones[closestZone].y, zones[closestZone].z-1.0001, 0, 0, 0, 0, 0, 0, 100.0, 100.0, 2.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0) -- heres what all these numbers are. Honestly you dont really need to mess with any other than what isnt 0.
	 		--DrawMarker(type, float posX, float posY, float posZ, float dirX, float dirY, float dirZ, float rotX, float rotY, float rotZ, float scaleX, float scaleY, float scaleZ, int red, int green, int blue, int alpha, BOOL bobUpAndDown, BOOL faceCamera, int p19(LEAVE AS 2), BOOL rotate, char* textureDict, char* textureName, BOOL drawOnEnts)
	 	--end
	end
end)

function safeZoneNotification(msg,msgType)
	
	TriggerEvent("pNotify:SendNotification",{
		text = msg,
		type = msgType,
		timeout = (3000),
		layout = "bottomcenter",
		queue = "safezoneBottom",
		killer = true,
		theme = "metroui",
		sounds = {
		   sources = {"alert4.wav"}, -- For sounds to work, you place your sound in the html folder and then add it to the files array in the __resource.lua file.
		   volume = 0.1,
		   conditions = {"docVisible"}
		 }
	})
end