--[[]]
Citizen.CreateThread(function() --- main

	while true do
	Citizen.Wait(1)
        -- This is the Application ID (Replace this with you own)
		SetDiscordAppId(1226756099676311593)

        -- Here you will have to put the image name for the "large" icon.
		SetDiscordRichPresenceAsset('logo')
        
        -- (11-11-2018) New Natives:

        -- Here you can add hover text for the "large" icon.
        --SetDiscordRichPresenceAssetText('discord.gg/HC')
		SetDiscordRichPresenceAssetText('101 City | مدينة 101')
       
        -- Here you will have to put the image name for the "small" icon.
        SetDiscordRichPresenceAssetSmall('logo2')

        -- Here you can add hover text for the "small" icon.
        SetDiscordRichPresenceAssetSmallText('101 City | مدينة 101')


        -- (26-02-2021) New Native:

        --[[ 
            Here you can add buttons that will display in your Discord Status,
            First paramater is the button index (0 or 1), second is the title and 
            last is the url (this has to start with "fivem://connect/" or "https://") 
        ]]--
        SetDiscordRichPresenceAction(0, "دخول الديسكورد", "https://discord.gg/bKa9YVR8")
        SetDiscordRichPresenceAction(1, "دخول السيرفر", "fivem://connect/cfx.re/join/memr4q")
        

        -- It updates every minute just in case.
		Citizen.Wait(60000)
	end
end)--]]

--[[
Citizen.CreateThread(function()
	while true do
		SetDiscordAppId(854820237329694722) --Discord app id
		SetDiscordRichPresenceAsset('s_logo') --Big picture asset name
        SetDiscordRichPresenceAssetText('discord.gg/HC') --Big picture hover text
        SetDiscordRichPresenceAssetSmall('s_logo_small') --Small picture asset name
        SetDiscordRichPresenceAssetSmallText('مـقـاطـعـة بـولـيـتـو') --Small picture hover text
		
        SetDiscordRichPresenceAction(0, "دسكورد", "https://discord.gg/mb7")
        SetDiscordRichPresenceAction(1, "دخول السيرفر", "fivem://connect/cfx.re/join/9l74oy")		
	
		Citizen.Wait(600000) --How often should this script check for updated assets? (in MS)
	end
end)
--]]
--No Need to mess with anything pass this point!
Citizen.CreateThread(function()
	while true do
		local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
		if VehName == "NULL" then VehName = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))) end
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
		local StreetHash = GetStreetNameAtCoord(x, y, z)
		local pId = GetPlayerServerId(PlayerId())
		local pName = GetPlayerName(PlayerId())

		Citizen.Wait(10000)
		if StreetHash ~= nil then
			StreetName = GetStreetNameFromHashKey(StreetHash)
			if IsPedOnFoot(PlayerPedId()) and not IsEntityInWater(PlayerPedId()) then
				if IsPedSprinting(PlayerPedId()) then
					SetRichPresence(" الأيدي: "..pId.." | "..pName.." يجري في الشارع "..StreetName)
				elseif IsPedRunning(PlayerPedId()) then
					SetRichPresence(" الأيدي: "..pId.." | "..pName.." يهرول في الشارع "..StreetName)
				elseif IsPedWalking(PlayerPedId()) then
					SetRichPresence(" الأيدي: "..pId.." | "..pName.." يمشي في الشارع "..StreetName)
				elseif IsPedStill(PlayerPedId()) then
					SetRichPresence(" الأيدي: "..pId.." | "..pName.." يقف على الشارع "..StreetName)
				end
			elseif GetVehiclePedIsUsing(PlayerPedId()) ~= nil and not IsPedInAnyHeli(PlayerPedId()) and not IsPedInAnyPlane(PlayerPedId()) and not IsPedOnFoot(PlayerPedId()) and not IsPedInAnySub(PlayerPedId()) and not IsPedInAnyBoat(PlayerPedId()) then
				local MPH = math.ceil(GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())) * 3.6)
				if MPH > 50 then
					SetRichPresence(" الأيدي: "..pId.." | "..pName.." تتسارع في الشارع "..StreetName.." بالسرعة "..MPH.."كم على المركبة "..VehName)
				elseif MPH <= 50 and MPH > 0 then
					SetRichPresence(" الأيدي: "..pId.." | "..pName.." أسفل الشارع "..StreetName.." بالسرعة "..MPH.."كم على المركبة "..VehName)
				elseif MPH == 0 then
					SetRichPresence(" الأيدي: "..pId.." | "..pName.." متوقف عند الشارع "..StreetName.." على المركبة "..VehName)
				end
			elseif IsPedInAnyHeli(PlayerPedId()) or IsPedInAnyPlane(PlayerPedId()) then
				if IsEntityInAir(GetVehiclePedIsUsing(PlayerPedId())) or GetEntityHeightAboveGround(GetVehiclePedIsUsing(PlayerPedId())) > 5.0 then
					SetRichPresence(" الأيدي: "..pId.." | "..pName.." يطير فوق "..StreetName.." على الطائرة "..VehName)
				else
					SetRichPresence(" الأيدي: "..pId.." | "..pName.." يهبط في "..StreetName.." من الطائرة "..VehName)
				end
			elseif IsEntityInWater(PlayerPedId()) then
				SetRichPresence(" الأيدي: "..pId.." | "..pName.." يسبح")
			elseif IsPedInAnyBoat(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
				SetRichPresence(" الأيدي: "..pId.." | "..pName.." يبحر في القارب "..VehName)
			elseif IsPedInAnySub(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
				SetRichPresence(" الأيدي: "..pId.." | "..pName.." في غواصة")
			end
			SetDiscordRichPresenceAssetText(ESX.PlayerData.job.label..' - '..ESX.PlayerData.job.grade_label) -- إظهار اسم وظيفة ورتبة وظيفة اللاعب
		end
	end
end)

--[[
Citizen.CreateThread(function()
	while true do
	Citizen.Wait(3000)
    SetDiscordRichPresenceAction(0, "حياك الديسكورد", "https://discord.gg/mb7")
    SetDiscordRichPresenceAction(1, "حياك ادخل السيرفر", "fivem://connect/cfx.re/join/gxo37z")
	Citizen.Wait(3000)
	SetDiscordRichPresenceAction(0, "إضغط هنا لدخول الديسكورد حياك", "https://discord.gg/mb7")
    SetDiscordRichPresenceAction(1, "إضغط هنا لدخول السيرفر بفايف ام حياك", "fivem://connect/cfx.re/join/gxo37z")
	Citizen.Wait(3000)
	SetDiscordRichPresenceAction(0, "ياهلا حياك ادخل تنورنا الديسكورد", "https://discord.gg/mb7")
    SetDiscordRichPresenceAction(1, "حياك للسيرفر بفايف ام", "fivem://connect/cfx.re/join/gxo37z")
	Citizen.Wait(3000)
	SetDiscordRichPresenceAction(0, "إضغط عشان تدخل الديسكورد وتلعب معانا وتستمتع", "https://discord.gg/mb7")
    SetDiscordRichPresenceAction(1, "إضغط هنا لدخول السيرفر بفايف ام", "fivem://connect/cfx.re/join/gxo37z")
	Citizen.Wait(3000)
	SetDiscordRichPresenceAction(0, "حياك الله معانا بالديسكورد", "https://discord.gg/mb7")
    SetDiscordRichPresenceAction(1, "حياك معانا الله بفايف ام", "fivem://connect/cfx.re/join/gxo37z")
	Citizen.Wait(3000)
	SetDiscordRichPresenceAction(0, "تشرفنا بالديسكورد", "https://discord.gg/mb7")
    SetDiscordRichPresenceAction(1, "تشرفنا بالفايف ام", "fivem://connect/cfx.re/join/gxo37z")
	Citizen.Wait(3000)
	SetDiscordRichPresenceAction(0, "إدخل معانا الديسكورد", "https://discord.gg/mb7")
    SetDiscordRichPresenceAction(1, "تعال فايف ام", "fivem://connect/cfx.re/join/gxo37z")
	Citizen.Wait(3000)
	SetDiscordRichPresenceAction(0, "إدخل معانا الديسكورد", "https://discord.gg/mb7")
    SetDiscordRichPresenceAction(1, "تعال فايف ام", "fivem://connect/cfx.re/join/gxo37z")
	Citizen.Wait(3000)
	SetDiscordRichPresenceAction(0, "حياك ديسكورد مـقـاطـعـة بـولـيـتـو", "https://discord.gg/mb7")
    SetDiscordRichPresenceAction(1, "حياك فايف ام", "fivem://connect/cfx.re/join/gxo37z")
	Citizen.Wait(3000)
	SetDiscordRichPresenceAction(0, "دخول الديسكورد", "https://discord.gg/mb7")
    SetDiscordRichPresenceAction(1, "دخول الفايف ام", "fivem://connect/cfx.re/join/gxo37z")
	Citizen.Wait(5000)
  end
end)
--]]

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job 
	Citizen.Wait(1)
	SetDiscordRichPresenceAssetText(ESX.PlayerData.job.label..' - '..ESX.PlayerData.job.grade_label) -- تحديث الوظيفة بشكل سريع
end)