

local sharedpanic, sharedpanicready = nil, false
RegisterNetEvent('esx_misc:UpdatePanic')
AddEventHandler('esx_misc:UpdatePanic', function(data)
    sharedpanic = data
    sharedpanicready = true
    TriggerEvent('esx_misc:getportnumber', data['area_port'].port)
end)

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('esx_adminjob:swapToAutoMatic')
    TriggerServerEvent('esx_misc:spawned')
end)

RegisterFontFile('Font')
font = RegisterFontId('A9eelsh')

local value = true
local godmodStarted = false

--God Mode
function startGodmod()
	godmodStarted = true
	local isAntiExplotionEnabled, previousVehicleModel, previousVehicleHandle
	
	Citizen.CreateThread(function()
	--when godmod ON		
		local player = PlayerPedId()
		local ped = PlayerId()
		
		--safezone
		ClearPlayerWantedLevel(PlayerId())
		SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
		--godmode
		SetPedCanRagdoll(player, false)
		
		while sharedpanic['peace_time'].state or sharedpanic['9eanh_time'].state do
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
			SetEntityHealth(player, 200)
			
			NetworkRequestControlOfEntity(GetVehiclePedIsIn(-1))
			SetVehicleEngineHealth(GetVehiclePedIsIn(player, false), 1000.0)
			
			--safezone
            --DisableControlAction(2, 37, false) -- disable weapon wheel (Tab)
            --DisablePlayerFiring(player,false) -- Disables firing all together if they somehow bypass inzone Mouse Disable
            --DisableControlAction(0, 106, false) -- Disable in-game mouse controls
            DisableControlAction(0, 140, false) -- Disable Reload and melle
            DisableControlAction(0, 141, false) -- Disable melle
			
			--anti explosion
			local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed)
			local isInVehicle, vehiclePedIsIn = IsPedInAnyVehicle(playerPed, false)
	
			if isInVehicle then vehiclePedIsIn = GetVehiclePedIsIn(playerPed, false) end
	
			-- explosion anti cheat
			if IsExplosionInSphere(8, playerCoords.x, playerCoords.y, playerCoords.z, 50.0) or IsExplosionInSphere(31, playerCoords.x, playerCoords.y, playerCoords.z, 50.0) then
				isAntiExplotionEnabled = true
				SetEntityProofs(playerPed, false, true, true, false, false, false, false, false)
	
				if isInVehicle then
					SetVehicleExplodesOnHighExplosionDamage(vehiclePedIsIn, true)
				end
			elseif isAntiExplotionEnabled then
				SetEntityProofs(playerPed, false, false, false, false, false, false, false, false)
	
				if isInVehicle then
					SetVehicleExplodesOnHighExplosionDamage(vehiclePedIsIn, false)
				end
			end
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
		
		godmodStarted = false

        -----
        TriggerEvent('esx_status:add', 'hunger', 250000)
        TriggerEvent('esx_status:add', 'thirst', 250000)
        Citizen.Wait(25000)
		ESX.ShowNotification('<font color=green>تم تعبئة الأكل والشرب')
	end)	
end



--Duble XP

Citizen.CreateThread( function(); while not sharedpanicready do Citizen.Wait(1000) end;
	while true do
		Wait(1)
		if value then
			if Config.Duble == 2 then
				DrawTextD()
			else
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function DrawTextD()
	RegisterFontFile('Font')
	font = RegisterFontId('A9eelsh')
	SetTextFont(font)
	SetTextProportional(1)
	SetTextScale(0.0, 0.3)
	--SetTextColour(128, 128, 128, 255)
--	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	--SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString("~b~ﺓﺮﺒﺧ ﻒﻌﺿ")
	DrawText(0.17, 0.857)
end

local SendDubleXP = false

--code
Citizen.CreateThread( function(); while not sharedpanicready do Citizen.Wait(1000) end;
    while true do
        local letsleep = true
        for location,data in pairs(Config.panic_zones) do
            if sharedpanic[location].state then

                if location ~= 'DUBLEXP' then
                    -- inZone
                    local ped = PlayerPedId()
                    local PlayerCoords = GetEntityCoords(ped)
                    if GetDistanceBetweenCoords(PlayerCoords, sharedpanic[location].coords.x, sharedpanic[location].coords.y, sharedpanic[location].coords.z, true) <= sharedpanic[location].coords.r then
                        --SendNotifications
                        if not Config.panic_zones[location].sendnotification then
                            Config.panic_zones[location].sendnotification = true

                            resetDrawTextY()
                            Citizen.CreateThread( function()
                                if IsPanic(location) and leojob2 then
                                else
                                    if Config.panic_zones[location].notification[1] ~= nil then
                                        ESX.ShowNotification(Config.panic_zones[location].notification[1])
                                    end
                                    Citizen.Wait(8000)
                                    if Config.panic_zones[location].notification[2] ~= nil then
                                        ESX.ShowNotification(Config.panic_zones[location].notification[2])
                                    end
                                    Citizen.Wait(8000)
                                    if Config.panic_zones[location].notification[3] ~= nil then
                                        ESX.ShowNotification(Config.panic_zones[location].notification[3])
                                    end
                                    Citizen.Wait(8000)
                                    if Config.panic_zones[location].notification[4] ~= nil then
                                        ESX.ShowNotification(Config.panic_zones[location].notification[4])
                                    end
                                    Citizen.Wait(8000)
                                    if Config.panic_zones[location].notification[5] ~= nil then
                                        ESX.ShowNotification(Config.panic_zones[location].notification[5])
                                    end
                                end
                            end)

                            Citizen.CreateThread( function()
                                while sharedpanic[location].state do
                                    Citizen.Wait(30000)
                                    local ped = PlayerPedId()
                                    local PlayerCoords = GetEntityCoords(ped)
                                    if GetDistanceBetweenCoords(PlayerCoords, sharedpanic[location].coords.x, sharedpanic[location].coords.y, sharedpanic[location].coords.z, true) <= sharedpanic[location].coords.r then
                                        if Config.panic_zones[location].takexp then
                                            if not govjob then
                                                TriggerServerEvent('SystemXpLevel:updateCurrentPlayerXP_clientSide', 'remove', 30)
                                            end
                                        elseif Config.panic_zones[location].givexp then
                                            if leojob2 then
                                                TriggerServerEvent('SystemXpLevel:updateCurrentPlayerXP_clientSide', 'addnoduble', 15)
                                            end
                                        end
                                    end
                                end
                            end)
                        end

                        if value then
                            letsleep = false
                            --DrawText
                            SetTextColour(Config.panic_zones[location].color.r,Config.panic_zones[location].color.g,Config.panic_zones[location].color.b,255)
                            SetTextFont(font)
                            SetTextScale(0.4, 0.4)
                            SetTextWrap(0.0, 1.0)
                            SetTextCentre(true)
                            SetTextDropshadow(2, 2, 0, 0, 0)
                            SetTextEdge(1, 0, 0, 0, 205)
                            SetTextEntry("STRING")
                            if sharedpanic[location].time == nil then
                                AddTextComponentString('[' .. Config.panic_zones[location].label .. ']')
                            else
                                if sharedpanic[location].time > 0 then
                                    AddTextComponentString('[' .. sharedpanic[location].time .. ']'..' '..'[' .. Config.panic_zones[location].label .. ']')
                                end
                            end
                            DrawText(0.500,Config.panic_zones[location].DrawTextY)
                        end

                        ---peace_time
                        if location == 'peace_time' or location == '9eanh_time' then
                            if not godmodStarted then
                                startGodmod()
                            end
                        end
                    else
                        Config.panic_zones[location].sendnotification = false
                    end

                    -- outZone
                    if not Config.panic_zones[location].done then
                        Config.panic_zones[location].done = true

                        if IsPanic(location) and leojob2 then
                            Citizen.CreateThread( function()
                                if location == 'help_me_police' or location == 'help_me_police2' then
                                    ESX.ShowNotification('تم طلب<font color=orange> نداء إستغاثة')
                                    Citizen.Wait(8000)
                                    ESX.ShowNotification('منطقة نداء إستغاثة تمنحك <font color=orange>خبرة إضافية')
                                else
                                    ESX.ShowNotification('تم تفعيل <font color=red>إستنفار أمني')
                                    Citizen.Wait(8000)
                                    ESX.ShowNotification('منطقة إستنفار أمني تمنحك <font color=orange>خبرة إضافية')
                                end
                            end)
                        end

                        if Config.panic_zones[location].BlipPanic then
                            PlayerPanicSound(vector3(sharedpanic[location].coords.x, sharedpanic[location].coords.y, sharedpanic[location].coords.z))
                        end

                        --creat Blip
                        if not Config.panic_zones[location].BlipPanic then
                            Config.panic_zones[location].Blip = AddBlipForRadius(sharedpanic[location].coords.x, sharedpanic[location].coords.y, sharedpanic[location].coords.z, sharedpanic[location].coords.r)
                            SetBlipColour(Config.panic_zones[location].Blip, Config.panic_zones[location].bColor)
                            SetBlipAlpha(Config.panic_zones[location].Blip, 120) 
                        else
                            Citizen.CreateThread( function()
                                Config.panic_zones[location].Blip = AddBlipForRadius(sharedpanic[location].coords.x, sharedpanic[location].coords.y, sharedpanic[location].coords.z, sharedpanic[location].coords.r)
                                while Config.panic_zones[location].Blip do
                                    SetBlipColour(Config.panic_zones[location].Blip, 1)
                                    SetBlipAlpha(Config.panic_zones[location].Blip, 160)
                                    Citizen.Wait(500)
                                    SetBlipColour(Config.panic_zones[location].Blip, 38)
                                    SetBlipAlpha(Config.panic_zones[location].Blip, 160)
                                    Citizen.Wait(500)
                                end
                            end)
                        end

                        if Config.panic_zones[location].doSoundAndAnimation then
                            TriggerEvent('InteractSound_CL:PlayOnOne', 'peace', 0.3)
                            TriggerEvent('JoinTransistion:start')
                        end
                    end
                else
                    if not SendDubleXP then
                        Config.Duble = 2
                        local mes1 = '<font face="A9eelsh">ﺓﺮﺒﺧ ﻒﻌﺿ'
                        local mes2 = '<font face="A9eelsh">ﺀﺎﻨﺜﺘﺳﺍ ﻥﻭﺩ ﻒﺋﺎﻇﻮﻟﺍ ﻊﻴﻤﺠﻟ'
                        ESX.Scaleform.ShowFreemodeMessage('<font face="A9eelsh">~b~'..mes1, '~g~'..mes2, 5)
                        SendDubleXP = true
                    end
                end
            else
                if location == 'DUBLEXP' then
                    if SendDubleXP then
                        Config.Duble = 1
                        local mes1 = '<font face="A9eelsh">ﺓﺮﺒﺧ ﻒﻌﺿ'
                        local mes2 = '<font face="A9eelsh">ﺽﺮﻌﻟﺍ ﺀﺎﻬﺘﻧﺇ'
                        ESX.Scaleform.ShowFreemodeMessage('<font face="A9eelsh">~b~'..mes1, '~r~'..mes2, 5)
                        SendDubleXP = false
                    end
                end
            end
        end

        if letsleep then
            Citizen.Wait(500)
        end
        Citizen.Wait(1)
    end
end)

function IsPanic(location)
    if location == 'peace_time' or location == 'restart_time' or location == 'area_port' or location == '9eanh_time' then
        return false
    end
    return true
end

AddEventHandler('ShowID:trueORfalse', function(value2)
    if value2 == true then
        value = true
    else
        value = false
    end
end)

Citizen.CreateThread(function(); while not sharedpanicready do Citizen.Wait(1000) end;
    while true do
        Citizen.Wait(1)
        local letsleep = true
        if value then
            letsleep = false
 --           portDrawText(sharedpanic['area_port'].label ..' : ﺮﻳﺪﺼﺘﻟﺍ ﻊﻗﻮﻣ')
        end

        if letsleep then
            Citizen.Wait(500)
        end
    end
end)

local DrawTextYbase = 0.860
function resetDrawTextY()
	local count = 1
	local y
	
	for location,data in pairs(Config.panic_zones) do
		if sharedpanic[location].state then
			if count == 1 then
				Config.panic_zones[location].DrawTextY = DrawTextYbase
				y = DrawTextYbase
			else
				y = y - 0.025
				Config.panic_zones[location].DrawTextY = y
			end
			count = count + 1
		end
	end	
end

--panicstate
function panicstate()
    while not sharedpanicready do
         Citizen.Wait(1000) 
    end
    
	return sharedpanic
end

function portDrawText(text)
	SetTextFont(font)
	SetTextProportional(1)
	SetTextScale(0.0, 0.3)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.17, 0.88)
end

RegisterNetEvent('esx_misc:changeport')
AddEventHandler('esx_misc:changeport', function(kjgfdwhif)
    while ESX == nil do 
        Citizen.Wait(100)
    end
    local mes1 = '<font face="A9eelsh">'..kjgfdwhif
    local mes2 = '<font face="A9eelsh">ﺮﻳﺪﺼﺘﻟﺍ ﻊﻗﻮﻣ'
    ESX.Scaleform.ShowFreemodeMessage('<font face="A9eelsh">~b~'..mes1, '~g~'..mes2, 5)
end)

RegisterNetEvent('esx_misc:removeblip')
AddEventHandler('esx_misc:removeblip', function(kjgfdwhif)
    RemoveBlip( Config.panic_zones[kjgfdwhif].Blip)
    Config.panic_zones[kjgfdwhif].Blip = nil
    Config.panic_zones[kjgfdwhif].done = false
end)

--help me F10
local helpmetime = 15 -- seconds disable F10 if pressed

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(100)
    end
    
    local counter = 4
    
    local function DrawCounter()
        Citizen.CreateThread(function()
            while IsControlPressed(0, 57) and counter ~= 0 do
                Citizen.Wait(1)
                
                SetTextColour(255,0,0,150)
                SetTextFont(font)
                SetTextScale(1.0, 1.0)
                SetTextWrap(0.0, 1.0)
                SetTextCentre(true)
                SetTextDropshadow(2, 2, 0, 0, 0)
                SetTextEdge(1, 0, 0, 0, 205)
                SetTextEntry("STRING")
                AddTextComponentString(counter..' ﺔﺛﺎﻐﺘﺳﺍ ﺀﺍﺪﻧ')
                DrawText(0.500, 0.500)
                if counter == 0 then
                    break
                end
            end	
        end)	
    end
    
    while true do
        Citizen.Wait(0)
        
        if IsControlPressed(0, 57) and GetLastInputMethod(0) and leojob2 then
            counter = 4
            DrawCounter()
            
            while IsControlPressed(0, 57) and counter ~= 0 do
                counter = counter - 1
                Citizen.Wait(1000)
            end
            
            if counter ~= 0 then
                ESX.ShowNotification('<font color=orange>نداء الإستغاثة</font></br>لمدة 3 ثواني '..'F10'..' استمر بضغط')
            end
        end
        
        if counter == 0 then
            local ped = PlayerPedId()
            local pedCoords = GetEntityCoords(ped)
            
            local panic = exports.esx_misc4:panicstate()
            if not panic['peace_time'].state or not panic['9eanh_time'].state then
                TriggerServerEvent("esx_misc:StartPanicSSs", pedCoords)
            else
                ESX.ShowNotification('لا يمكن طلب نداء إستغاثة أثناء إعلان<font color=800080> وقت راحة')
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
                
                if IsControlJustReleased(0, 57) and GetLastInputMethod( 0 ) and leojob2 then
                    ESX.ShowNotification('<font color=red>نداء الاستغاثة</font> عليك الانتظار: <font color=orange>'..helpmetime..'</font> ثانية')
                end
            end
            counter = 4
        end
    end
end)