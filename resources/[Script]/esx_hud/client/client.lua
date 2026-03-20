frameworkObject = nil
speedMultiplier = Config.DefaultSpeedUnit == "kmh" and 3.6 or 2.23694
CinematicHeight = 0.2
CinematicModeOn = false
w = 0
preferencesData = {}
forceHide = true
playerLoaded = false
displayRadarEnable = true

RegisterNetEvent('codem-blvckhudv2:Loaded')
AddEventHandler('codem-blvckhudv2:Loaded', function()
    playerLoaded = true
end)


RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
    TriggerEvent('codem-blackhudv2:SetForceHide', true)
    playerLoaded = false
end)




Citizen.CreateThread(function()
    frameworkObject = GetFrameworkObject()
end)
playerPed = PlayerPedId()

Citizen.CreateThread(function()
    while true do
        playerPed = PlayerPedId()
        Citizen.Wait(3000)
    end
end)

local editModeActive = false
RegisterNUICallback('editModeActive', function(data)
    local toggle = data.toggle
    editModeActive = toggle
    if toggle then
        SetNuiFocus(true, true)
    end
end)

function ShowHelpNotification(msg)
    AddTextEntry('notification', msg)
	BeginTextCommandDisplayHelp('notification')
	EndTextCommandDisplayHelp(0, false, true, -1)
end

Citizen.CreateThread(function()
    while true do
        if editModeActive then
            Citizen.Wait(0)
            ShowHelpNotification(Config.SettingsLocale["esc_to_exit"])
        else
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
end)

Citizen.CreateThread(function()
    while true do
        playerCoords = GetEntityCoords(playerPed)
        Citizen.Wait(1750)
    end
end)


Citizen.CreateThread(function()
    while true do
        if preferencesData then
            if tonumber(preferencesData.refreshRate) then
                Citizen.Wait(tonumber(preferencesData.refreshRate))
            else
                Citizen.Wait(Config.DefaultRefreshRate)
            end
        else
            Citizen.Wait(Config.DefaultRefreshRate)
        end
        if IsPedInAnyVehicle(playerPed) then

            local vehicle = GetVehiclePedIsIn(playerPed, false)
            if vehicle then
                local currSpeed = GetEntitySpeed(vehicle)
                local speed = ("%.1d"):format(math.ceil(currSpeed * speedMultiplier))
                SendNUIMessage({
                    type = "speed_update",
                    speed = speed,
                    rpm =  GetVehicleCurrentRpm(vehicle),
                })
            end
        end
    end
end)


function WaitPlayer()
    if Config.Framework == "esx" then
        while frameworkObject == nil do
            Citizen.Wait(0)
        end
        while frameworkObject.GetPlayerData()  == nil do
            Citizen.Wait(0)
        end
        while frameworkObject.GetPlayerData().job == nil do
            Citizen.Wait(0)
        end
    else
        while frameworkObject == nil do
            Citizen.Wait(0)
        end
        while frameworkObject.Functions.GetPlayerData() == nil do
            Citizen.Wait(0)
        end
        while frameworkObject.Functions.GetPlayerData().metadata == nil do
            Citizen.Wait(0)
        end
    end
end


RegisterNetEvent('codem-blvckhudv2:OnAddedMoney')
AddEventHandler("codem-blvckhudv2:OnAddedMoney", function(amount, minus, moneyType)
    SendNUIMessage({ type="on_added_money",  amount = amount, minus = minus, moneyType = moneyType})
end)

Citizen.CreateThread(function()
    while true do
        local player = playerPed
        local oxygen = 100 - GetPlayerSprintStaminaRemaining(PlayerId())
        SendNUIMessage({ type="set_status",       statustype = "stamina", value = oxygen})
        Citizen.Wait(1000)
    end
end)

local inWater = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if IsEntityInWater(playerPed) then
            local oxygen = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10
            if not inWater then
                inWater = true
                SendNUIMessage({
                    type = 'toggle_oxy',
                    toggle = true
                })
            end
            SendNUIMessage({ type="set_status",   statustype = "oxy", value = oxygen})
        else
            if inWater then
                inWater = false
                SendNUIMessage({
                    type = 'toggle_oxy',
                    toggle = false
                })
            end
        end
    end
end)

local micIsOn = true
local firstCheck = true
if Config.Voice == 'mumble' or Config.Voice == 'pma' then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1500)
            if not MumbleIsConnected() then
                if micIsOn or firstCheck then
                    micIsOn = false
                    SendNUIMessage({
                        type = 'toggle_muted',
                        toggle = true
                    })
                end
            else
                if not micIsOn or firstCheck then
                    micIsOn = true
                    firstCheck = false
                    SendNUIMessage({
                        type = 'toggle_muted',
                        toggle = false
                    })
                end
            end
        end
    end)
else
    RegisterNetEvent('SaltyChat_PluginStateChanged')
    AddEventHandler('SaltyChat_PluginStateChanged', function(state)
        if state == 0 or state == -1 then
            SendNUIMessage({
                type = 'toggle_muted',
                toggle = true
            })
        elseif state == 2 then
            SendNUIMessage({
                type = 'toggle_muted',
                toggle = false
            })
        end
    end)
    RegisterNetEvent('SaltyChat_MicStateChanged')
    AddEventHandler('SaltyChat_MicStateChanged', function(isMicrophoneMuted)
        while not response do
            Citizen.Wait(0)
        end
        if isMicrophoneMuted then
            SendNUIMessage({
                type = 'toggle_muted',
                toggle = true
            })
        else
            SendNUIMessage({
                type = 'toggle_muted',
                toggle = false
            })
        end
   end)
end



response = false

RegisterNUICallback('SendResponse', function(data, cb)
    response = true
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        SendNUIMessage({
            type = "send_response",
            resourceName = GetCurrentResourceName()
        })
        if response then
            return
        end
    end
end)

Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Citizen.Wait(0)
    SetRadarBigmapEnabled(false, false)
    while true do
        Citizen.Wait(0)
        Citizen.InvokeNative(0xF6E48914C7A8694E, minimap, "SETUP_HEALTH_ARMOUR")
        Citizen.InvokeNative(0xC3D0841A0CC546A6, 3)
        Citizen.InvokeNative(0xC6796A8FFA375E53)
        Citizen.InvokeNative(0xC6796A8FFA375E53)
    end
end)

RegisterNUICallback('ToggleMinimap', function()
    Config.DisplayMapOnWalk = not Config.DisplayMapOnWalk
    SendNUIMessage({
        type = "DisplayMapOnWalk",
        value = Config.DisplayMapOnWalk,
    })
end)
RegisterNUICallback('HideWaterMarkElement', function(data)
    local type = data.type
    HideWaterMarkElement(type)
end)



function HideWaterMarkElement(type)
    local types = {
        id = true,
        logo = true,
        cash = true,
        bank_money = true,
        boss_money = Config.Framework == 'esx' and true or false,
        black_money = Config.Framework == 'esx' and true or false,
        weapon = true,
        ammo = true,
        job = true,
        all = true,
    }
    if types[type] then
        if preferencesData.waterMarkHudVisibleData == nil then
            preferencesData.waterMarkHudVisibleData = types
        end
        preferencesData.waterMarkHudVisibleData[type] = not preferencesData.waterMarkHudVisibleData[type]

        if type == 'all' then
            for _,v in pairs(preferencesData.waterMarkHudVisibleData) do
                if _ ~= 'all' then
                    if preferencesData.waterMarkHudVisibleData['all'] then
                        preferencesData.waterMarkHudVisibleData[_] = true
                    else
                        preferencesData.waterMarkHudVisibleData[_] = false
                    end
                end
            end

        end
        TriggerServerEvent('codem-blvckhudv2:UpdateData', "waterMarkHudVisibleData", preferencesData.waterMarkHudVisibleData)
    end
end


Citizen.CreateThread(function()
    WaitPlayer()
    while preferencesData.waterMarkHudVisibleData == nil do
        Citizen.Wait(0)
    end

    while not response  do
        Citizen.Wait(0)
    end
    Citizen.Wait(1000)
    SendNUIMessage({type = 'SetFramework', value = Config.Framework})
    SendNUIMessage({ type="watermark_text",  text1 =Config.WaterMarkText1, text2 = Config.WaterMarkText2})
    SendNUIMessage({type = 'EnableToggleMapButton', value = Config.EnableToggleMapButton})
    SendNUIMessage({ type="set_id",  value = GetPlayerServerId(PlayerId())})
    SendNUIMessage({ type="set_useNitro",  value = Config.EnableNitro})
    SendNUIMessage({ type="set_DateDisplay",  value = Config.EnableDateDisplay})
    SendNUIMessage({ type="set_EnableArmor",  value = Config.EnableArmor})
    SendNUIMessage({ type="set_EnableThirst",  value = Config.EnableThirst})
    SendNUIMessage({ type="set_EnableHunger",  value = Config.EnableHunger})
    SendNUIMessage({ type="set_EnableHealth",  value = Config.EnableHealth})
    SendNUIMessage({ type="set_EnableStamina",  value = Config.EnableStamina})
    SendNUIMessage({ type="set_cruiseDisplay",  value = Config.EnableCruise})
    SendNUIMessage({ type="set_seatbeltDisplay",  value = Config.EnableSeatbelt})
    SendNUIMessage({ type="set_locales",  value = Config.SettingsLocale})
    SendNUIMessage({ type="set_EnableHUD",  value = Config.EnableHud})
    SendNUIMessage({ type="set_EnableSpeedometer",  value = Config.EnableSpeedometer})
    SendNUIMessage({ type="UseStress",  value = Config.UseStress})
    SendNUIMessage({ type="DisplayRealTime",  value = Config.DisplayRealTime})
    SendNUIMessage({ type="UseWaterMarkText",  value = Config.UseWaterMarkText})
    SendNUIMessage({ type="WaterMarkLogo",  value = Config.WaterMarkLogo})
    SendNUIMessage({ type="SetStyles",  text1 = Config.Text1Style, text2 = Config.Text2Style})
    SendNUIMessage({ type="SetLogoSize",  width = Config.LogoWidth, height = Config.LogoHeight})
    SendNUIMessage({ type="set_watermarkhud",  value = Config.EnableWaterMarkHud})
    SendNUIMessage({type = 'EnableWaterMarkHudHideButtons', value = Config.EnableWaterMarkHudHideButtons})
    SendNUIMessage({type = 'SetAccountSizes', value = Config.AccountSize})
    SendNUIMessage({type = 'EnableCompass', value = Config.EnableCompass})


    if Config.Framework ~= 'esx' then
        Config.EnableWatermarkBlackMoney = false
        Config.EnableWatermarkBossMoney  = false
    end

    SendNUIMessage({type = 'EnableWatermarkId', value = Config.EnableId})
    SendNUIMessage({type = 'EnableWatermarkCash', value = Config.EnableWatermarkCash})
    SendNUIMessage({type = 'EnableWatermarkBlackMoney', value = Config.EnableWatermarkBlackMoney})
    SendNUIMessage({type = 'EnableWatermarkBossMoney', value = Config.EnableWatermarkBossMoney})
    SendNUIMessage({type = 'EnableWatermarkBankMoney', value = Config.EnableWatermarkBankMoney})
    SendNUIMessage({type = 'EnableWatermarkJob', value = Config.EnableWatermarkJob})
    SendNUIMessage({type = 'EnableWatermarkWeaponImage', value = Config.EnableWatermarkWeaponImage})
    SendNUIMessage({type = 'DisableWaterMarkTextAndLogo', value = Config.DisableWaterMarkTextAndLogo})
    SendNUIMessage({ type="set_EnableAmmohud",  value = Config.EnableAmmoHud})
end)


local shouldDisableMinimap = false
RegisterNetEvent('codem-blackhudv2:SetForceHide')
AddEventHandler('codem-blackhudv2:SetForceHide', function(val, disableMinimap)
    while true do
        Citizen.Wait(0)

        if NetworkIsSessionStarted() then
            break
        end
    end
    while not response do
        Citizen.Wait(0)
    end
    SendNUIMessage({ type="set_force_hide",  value = val})
    forceHide = val
    if val then
        if disableMinimap then
            DisplayRadar(false)
        end
        shouldDisableMinimap = disableMinimap
    else
        shouldDisableMinimap = false
    end
end)


exports('IsVisible', function()
    return not forceHide
end)



RegisterNetEvent('codemblvckhudv2:ShowAccounts')
AddEventHandler('codemblvckhudv2:ShowAccounts', function(type, money)
    if Config.EnableCashAndBankCommands then
        if type == "cash" then
            Config.Notification(string.format(Config.Notifications["cash_display"]["message"], money), Config.Notifications["cash_display"]["type"])
        else
            Config.Notification(string.format(Config.Notifications["bank_display"]["message"], money), Config.Notifications["bank_display"]["type"])
        end
    end
end)

local lastArmour = nil
Citizen.CreateThread(function()
    while not response do
        Citizen.Wait(0)
    end
    while true do
        Citizen.Wait(1200)
        local playerPed = playerPed
        local armour = GetPedArmour(playerPed)
        if lastArmour ~= armour then
            SendNUIMessage({
                type = "set_status",
                statustype = "armour",
                value = armour,
            })
            lastArmour = armour
        end
    end
end)



local inSettings = false
RegisterCommand(Config.HudSettingsCommand, function()
    SendNUIMessage({
        type = "open_hudsettings",
    })
    inSettings = true
    SetNuiFocus(true, true)
end)

RegisterNetEvent('codem-blackhudv2:PreventDisplayRadar')
AddEventHandler('codem-blackhudv2:PreventDisplayRadar', function()
    displayRadarEnable = false
end)

RegisterNetEvent('codem-blackhudv2:EnableDisplayRadar')
AddEventHandler('codem-blackhudv2:EnableDisplayRadar', function()
    displayRadarEnable = true
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if inSettings or not playerLoaded and displayRadarEnable then
            DisplayRadar(false)
        end
    end
end)

RegisterNUICallback('ExitSettings', function()
    SetNuiFocus(false, false)
    inSettings = false
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    if vehicle ~= 0 and not shouldDisableMinimap and displayRadarEnable then
        DisplayRadar(true)
    end
    if Config.DisplayMapOnWalk and displayRadarEnable and not shouldDisableMinimap then
        DisplayRadar(true)
    end
end)


Citizen.CreateThread(function()
    Citizen.Wait(2000)
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    if vehicle ~= 0 then
        SendNUIMessage({
            type = "show_speedometer",
            displayOnWalk = Config.DisplayMapOnWalk,
        })
        if nitro[GetVehicleNumberPlateText(vehicle)] ~= nil then
            SendNUIMessage({ type="set_status",  statustype = "nitro", value = nitro[GetVehicleNumberPlateText(vehicle)] })

        else
            SendNUIMessage({ type="set_status",  statustype = "nitro", value = 0})

        end
        alreadyInVehicle = true
        if not shouldDisableMinimap and displayRadarEnable then
            DisplayRadar(true)
        end
    else
        SendNUIMessage({
            type = "hide_speedometer",
            displayOnWalk = Config.DisplayMapOnWalk,
        })
        alreadyInVehicle = false
        if displayRadarEnable and not shouldDisableMinimap then
            if Config.DisplayMapOnWalk then
                DisplayRadar(true)
            else
                if displayRadarEnable then
                    DisplayRadar(false)
                end
            end
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1300)
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        if vehicle ~= 0 then
            if not alreadyInVehicle then
                SendNUIMessage({
                    type = "show_speedometer",
                    displayOnWalk = Config.DisplayMapOnWalk,
                })
                if nitro[GetVehicleNumberPlateText(vehicle)] ~= nil then
                    SendNUIMessage({ type="set_status",       statustype = "nitro", value = nitro[GetVehicleNumberPlateText(vehicle)] })

                else
                    SendNUIMessage({ type="set_status",       statustype = "nitro", value = 0})

                end
                alreadyInVehicle = true
            end
            SendNUIMessage({
                type = 'SetEngineHealth',
                value = GetVehicleEngineHealth(vehicle)
            })
            if not shouldDisableMinimap then
                if displayRadarEnable then
                    DisplayRadar(true)
                end
            end
        else
            if alreadyInVehicle then
                SendNUIMessage({
                    type = "hide_speedometer",
                    displayOnWalk = Config.DisplayMapOnWalk,

                })
                alreadyInVehicle = false
            end
            if displayRadarEnable and not shouldDisableMinimap then
                if Config.DisplayMapOnWalk then
                    DisplayRadar(true)
                else
                    DisplayRadar(false)
                end
            end
        end
    end
end)


RegisterNetEvent('codem-blvckhudv2:client:UpdateSettings')
AddEventHandler('codem-blvckhudv2:client:UpdateSettings', function(data)
    while not response do
        Citizen.Wait(0)
    end
    data.forceHide = forceHide
    preferencesData = data


    SendNUIMessage({
        type = "update_settings",
        val = data,
    })
    SendNUIMessage({
        type = "update_settings",
        val = data,
    })
    SendNUIMessage({
        type = "update_settings",
        val = data,
    })
    SendNUIMessage({
        type = "update_settings",
        val = data,
    })
    local types = {
        ["id"] = {
            nuiMessageType = 'EnableWatermarkId',
            setFunction = function()
                Config.EnableId = not Config.EnableId
                return Config.EnableId
            end
        },
        ["logo"] = {
            nuiMessageType = 'DisableWaterMarkTextAndLogo',
            setFunction = function()
                Config.DisableWaterMarkTextAndLogo = not Config.DisableWaterMarkTextAndLogo
                return Config.DisableWaterMarkTextAndLogo
            end
        },
        ["cash"] = {
            nuiMessageType = 'EnableWatermarkCash',
            setFunction = function()
                Config.EnableWatermarkCash = not Config.EnableWatermarkCash
                return Config.EnableWatermarkCash
            end
        },
        ["bank_money"] = {
            nuiMessageType = 'EnableWatermarkBankMoney',
            setFunction = function()
                Config.EnableWatermarkBankMoney = not Config.EnableWatermarkBankMoney
                return Config.EnableWatermarkBankMoney
            end
        },
        ["boss_money"] = {
            nuiMessageType = 'EnableWatermarkBossMoney',
            setFunction = function()
                Config.EnableWatermarkBossMoney = not Config.EnableWatermarkBossMoney
                return Config.EnableWatermarkBossMoney
            end
        },
        ["black_money"] = {
            nuiMessageType = 'EnableWatermarkBlackMoney',
            setFunction = function()
                Config.EnableWatermarkBlackMoney = not Config.EnableWatermarkBlackMoney
                return Config.EnableWatermarkBlackMoney
            end
        },
        ["weapon"] = {
            nuiMessageType = 'EnableWatermarkWeaponImage',
            setFunction = function()
                Config.EnableWatermarkWeaponImage = not Config.EnableWatermarkWeaponImage
                return Config.EnableWatermarkWeaponImage
            end
        },
        ["ammo"] = {
            nuiMessageType = 'set_EnableAmmohud',
            setFunction = function()
                Config.EnableAmmoHud = not Config.EnableAmmoHud
                return Config.EnableAmmoHud
            end
        },
        ["job"] = {
            nuiMessageType = 'EnableWatermarkJob',
            setFunction = function()
                Config.EnableWatermarkJob = not Config.EnableWatermarkJob
                return Config.EnableWatermarkJob
            end,

        },
    }
    SendNUIMessage({
        type = "update_settings",
        val = data,
    })
    if displayRadarEnable then
        if data.hide then
            DisplayRadar(false)
        end
    end

    speedMultiplier = data.speedtype == "kmh" and 3.6 or 2.23694
    if data.maptype == "rectangle" then
        LoadRectMinimap(data.hud)
    else
        LoadRadialMap()
    end
    if data.hud == "radial" then
        local playerPed = playerPed
        local armour = GetPedArmour(playerPed)
        SendNUIMessage({
            type = "armour_update",
            armour = armour,
        })
        if Config.Framework ~= "esx" then
            local myhunger = frameworkObject.Functions.GetPlayerData().metadata["hunger"]
            local mythirst = frameworkObject.Functions.GetPlayerData().metadata["thirst"]
            SendNUIMessage({
                type = "set_status",
                statustype = "hunger",
                value =  myhunger,
            })
            SendNUIMessage({
                type = "set_status",
                statustype = "thirst",
                value =  mythirst,
            })
        end



        local health = GetEntityHealth(playerPed)
        local val = health-100

        SendNUIMessage({
            type = "set_status",
            statustype = "health",
            value = val,
        })
    end
end)


RegisterNetEvent('codem-blvkhudv2:EnableCinematic')
AddEventHandler('codem-blvkhudv2:EnableCinematic', function()
    CinematicShow(true)
end)

RegisterNetEvent('codem-blvkhudv2:DisableCinematic')
AddEventHandler('codem-blvkhudv2:DisableCinematic', function()
    CinematicShow(false)
end)

function CinematicShow(bool)

    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
    CinematicModeOn = bool
    if CinematicModeOn then
        forceHide= true
    else
        forceHide = false
    end
    if bool then
        TriggerEvent('codem-blvckhudv2:client:OnCinematicModeEnable')
    else
        TriggerEvent('codem-blvckhudv2:client:OnCinematicModeDisable')
    end
    TriggerEvent('codem-blvckhudv2:client:UpdateSettings', preferencesData)
    if bool then
        for i = CinematicHeight, 0, -1.0 do
            Wait(10)
            w = i
        end
    else
        for i = 0, CinematicHeight, 1.0 do
            Wait(10)
            w = i
        end
    end
    if w > 0 then
        Citizen.CreateThread(function()
            local minimap = RequestScaleformMovie("minimap")
            if not HasScaleformMovieLoaded(minimap) then
                RequestScaleformMovie(minimap)
                while not HasScaleformMovieLoaded(minimap) do
                    Wait(1)
                end
            end
            while w > 0 do
                Wait(0)
                BlackBars()
                DisplayRadar(0)
            end
        end)
    end


end

function BlackBars()
    DrawRect(0.0, 0.0, 2.0, w, 0, 0, 0, 255)
    DrawRect(0.0, 1.0, 2.0, w, 0, 0, 0, 255)
end

RegisterNUICallback('toggleCinematic', function(data, cb)
    if not CinematicModeOn then
        CinematicShow(true)
    else
        CinematicShow(false)
    end

    cb(CinematicModeOn)
end)

Citizen.CreateThread(function()
    while true do
        if IsPedInAnyVehicle(playerPed) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            if vehicle then
                local fuel = Config.GetVehicleFuel(vehicle)
                SendNUIMessage({
                    type = "fuel_update",
                    fuel = fuel,
                })
            end
        end
        Citizen.Wait(2500)
    end
end)
local directions = {
    N = 360, 0,
    NE = 315,
    E = 270,
    SE = 225,
    S = 180,
    SW = 135,
    W = 90,
    NW = 45
    --  N = 0, <= will result in the HUD breaking above 315deg
  }

local lastZone = nil
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.LocationUpdateTime)
        local position = playerCoords
		local var1, var2 = GetStreetNameAtCoord(position.x, position.y, position.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
        local zone = GetNameOfZone(position.x, position.y, position.z);
		local zoneLabel = GetLabelText(zone);
		hash1 = GetStreetNameFromHashKey(var1);
		hash2 = GetStreetNameFromHashKey(var2);
        local street2;
		street2 = zoneLabel;
        local heading = GetEntityHeading(playerPed);
        for k, v in pairs(directions) do
            if (math.abs(heading - v) < 22.5) then
                heading = k;

                if (heading == 1) then
                    heading = 'N';
                    break;
                end

                break;
            end
        end
        SendNUIMessage({
            type = "location_update",
            street = hash1,
			zone = street2,
            heading = heading,
        })
    end
end)

Citizen.CreateThread(function()
    if not Config.DisplayRealTime then
        while true do
            Citizen.Wait(1000)
            local hours = GetClockHours()
            local minutes = GetClockMinutes()
            if hours < 10 then
                hours = '0'..hours
            end
            if minutes < 10 then
                minutes = '0'..minutes
            end
            SendNUIMessage({type = "clock_update", minutes = minutes, hours=hours})
        end
    end
end)

cruiseIsOn = false
if Config.EnableCruise then
    local cruiseSpeed = 999.0

    RegisterKeyMapping('cruise', 'Cruise Control', 'keyboard', Config.DefaultCruiseControlKey)
    local cruiseSpam = 0
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1700)
            if cruiseSpam > 0 then
                Citizen.Wait(3500)
                cruiseSpam = 0
            end
        end
    end)

    RegisterCommand('cruise', function()
        if cruiseSpam >= 3 then
            if Config.EnableSpamNotification  then
                Config.Notification(Config.Notifications["spam"]["message"], Config.Notifications["spam"]["type"])
            end
            return
        end
        local player = playerPed
        local vehicle = GetVehiclePedIsIn(player, false)
        if (GetPedInVehicleSeat(vehicle, -1) == player and vehicle ~= 0) then
            cruiseIsOn = not cruiseIsOn
            if cruiseIsOn then
                Config.Notification(Config.Notifications["cruise_actived"]["message"], Config.Notifications["cruise_actived"]["type"])
            else
                Config.Notification(Config.Notifications["cruise_disabled"]["message"], Config.Notifications["cruise_disabled"]["type"])
            end
            local currSpeed = GetEntitySpeed(vehicle)
            cruiseSpeed = currSpeed
            local maxSpeed = cruiseIsOn and cruiseSpeed or GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveMaxFlatVel")
            SetEntityMaxSpeed(vehicle, maxSpeed)
            SendNUIMessage({type = "toggle_cruise", toggle = cruiseIsOn})
            cruiseSpam = cruiseSpam + 1
        end
    end, false)
end


local lastCheckIsAlreadyEngineRunning = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1200)
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        if vehicle ~= 0 then
            local isRunning = GetIsVehicleEngineRunning(vehicle)
            if isRunning ~= lastCheckIsAlreadyEngineRunning then
                lastCheckIsAlreadyEngineRunning = isRunning
                if isRunning then
                    SendNUIMessage({
                        type = "toggle_engine",
                        toggle = true,
                    })
                else
                    SendNUIMessage({
                        type = "toggle_engine",
                        toggle = false,
                    })
                end
            end
        end
    end
end)

local alreadyInHeli = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1700)
        if IsPedInAnyHeli(playerPed) or IsPedInAnyPlane(playerPed) then
            if not alreadyInHeli then
                SendNUIMessage({
                    type = "update_altitude",
                    val = true
                })
                alreadyInHeli = true
            end
                local veh = GetVehiclePedIsUsing(playerPed)

            SendNUIMessage({ type="set_status",       statustype = "altitude", value = GetEntityHeightAboveGround(veh)})

        else
            if  alreadyInHeli then
                SendNUIMessage({
                    type = "update_altitude",
                    val = false
                })
                alreadyInHeli = false
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1700)
        if GetPedParachuteState(playerPed) >= 0 then
            SendNUIMessage({ type="set_status",       statustype = "altitude", value = GetEntityHeightAboveGround(playerPed)})
        end
    end
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2500)
        if GetPedParachuteState(playerPed) >= 0 then
            SendNUIMessage({
                type = "update_parachute",
                val = true,
            })
        else
            SendNUIMessage({
                type = "update_parachute",
                val = false,
            })
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        local player = playerPed
        local vehicle = GetVehiclePedIsIn(player, true)
        local vehicleVal,vehicleLights,vehicleHighlights  = GetVehicleLightsState(vehicle)
        local vehicleIsLightsOn
        if vehicleLights == 1 and vehicleHighlights == 0 then
            vehicleIsLightsOn = true
        elseif (vehicleLights == 1 and vehicleHighlights == 1) or (vehicleLights == 0 and vehicleHighlights == 1) then
            vehicleIsLightsOn = true
        else
            vehicleIsLightsOn = false
        end
        SendNUIMessage({type = "update_ligths", state = vehicleIsLightsOn})
        Citizen.Wait(1600)
    end
end)

if Config.EnableEngineToggle then
    local engineRunning = true
    local lastVehicle = nil
    RegisterCommand('engine', function()
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        if vehicle == 0 or GetPedInVehicleSeat(vehicle, -1) ~= playerPed then return end
        if GetIsVehicleEngineRunning(vehicle) then
            Config.Notification(Config.Notifications["engine_off"]["message"], Config.Notifications["engine_off"]["type"])
        else
            Config.Notification(Config.Notifications["engine_on"]["message"], Config.Notifications["engine_on"]["type"])
        end
        engineRunning = not GetIsVehicleEngineRunning(vehicle)
        lastVehicle = vehicle
        SetVehicleEngineOn(vehicle, not GetIsVehicleEngineRunning(vehicle), false, true)

    end)

    RegisterNetEvent('codem-blackhud-v2:client:ToggleEngine')
    AddEventHandler('codem-blackhud-v2:client:ToggleEngine', function(toggle)
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        if vehicle == 0 or GetPedInVehicleSeat(vehicle, -1) ~= playerPed then return end
        if not toggle then
            Config.Notification(Config.Notifications["engine_off"]["message"], Config.Notifications["engine_off"]["type"])
        else
            Config.Notification(Config.Notifications["engine_on"]["message"], Config.Notifications["engine_on"]["type"])
        end
        engineRunning =  toggle
        lastVehicle = vehicle
        SetVehicleEngineOn(vehicle,  toggle, false, true)
    end)


    RegisterKeyMapping('engine', 'Toggle Engine', 'keyboard',  Config.VehicleEngineToggleKey)
end


local lastAmmo = nil
local lastMaxAmmo = nil

local displayAmmo = false

local AllWeapons = json.decode('{"melee":{"dagger":"0x92A27487","bat":"0x958A4A8F","bottle":"0xF9E6AA4B","crowbar":"0x84BD7BFD","unarmed":"0xA2719263","flashlight":"0x8BB05FD7","golfclub":"0x440E4788","hammer":"0x4E875F73","hatchet":"0xF9DCBF2D","knuckle":"0xD8DF3C3C","knife":"0x99B507EA","machete":"0xDD5DF8D9","switchblade":"0xDFE37640","nightstick":"0x678B81B1","wrench":"0x19044EE0","battleaxe":"0xCD274149","poolcue":"0x94117305","stone_hatchet":"0x3813FC08"},"handguns":{"pistol":"0x1B06D571","pistol_mk2":"0xBFE256D4","combatpistol":"0x5EF9FEC4","appistol":"0x22D8FE39","stungun":"0x3656C8C1","pistol50":"0x99AEEB3B","snspistol":"0xBFD21232","snspistol_mk2":"0x88374054","heavypistol":"0xD205520E","vintagepistol":"0x83839C4","flaregun":"0x47757124","marksmanpistol":"0xDC4DB296","revolver":"0xC1B3C3D1","revolver_mk2":"0xCB96392F","doubleaction":"0x97EA20B8","raypistol":"0xAF3696A1"},"smg":{"microsmg":"0x13532244","smg":"0x2BE6766B","smg_mk2":"0x78A97CD0","assaultsmg":"0xEFE7E2DF","combatpdw":"0xA3D4D34","machinepistol":"0xDB1AA450","minismg":"0xBD248B55","raycarbine":"0x476BF155"},"shotguns":{"pumpshotgun":"0x1D073A89","pumpshotgun_mk2":"0x555AF99A","sawnoffshotgun":"0x7846A318","assaultshotgun":"0xE284C527","bullpupshotgun":"0x9D61E50F","musket":"0xA89CB99E","heavyshotgun":"0x3AABBBAA","dbshotgun":"0xEF951FBB","autoshotgun":"0x12E82D3D"},"assault_rifles":{"assaultrifle":"0xBFEFFF6D","assaultrifle_mk2":"0x394F415C","carbinerifle":"0x83BF0278","carbinerifle_mk2":"0xFAD1F1C9","advancedrifle":"0xAF113F99","specialcarbine":"0xC0A3098D","specialcarbine_mk2":"0x969C3D67","bullpuprifle":"0x7F229F94","bullpuprifle_mk2":"0x84D6FAFD","compactrifle":"0x624FE830"},"machine_guns":{"mg":"0x9D07F764","combatmg":"0x7FD62962","combatmg_mk2":"0xDBBD7280","gusenberg":"0x61012683"},"sniper_rifles":{"sniperrifle":"0x5FC3C11","heavysniper":"0xC472FE2","heavysniper_mk2":"0xA914799","marksmanrifle":"0xC734385A","marksmanrifle_mk2":"0x6A6C02E0"},"heavy_weapons":{"rpg":"0xB1CA77B1","grenadelauncher":"0xA284510B","grenadelauncher_smoke":"0x4DD2DC56","minigun":"0x42BF8A85","firework":"0x7F7497E5","railgun":"0x6D544C99","hominglauncher":"0x63AB0442","compactlauncher":"0x781FE4A","rayminigun":"0xB62D1F67"},"throwables":{"grenade":"0x93E220BD","bzgas":"0xA0973D5E","smokegrenade":"0xFDBC8A50","flare":"0x497FACC3","molotov":"0x24B17070","stickybomb":"0x2C3731D9","proxmine":"0xAB564B93","snowball":"0x787F0BB","pipebomb":"0xBA45E8B8","ball":"0x23C9F95C"},"misc":{"petrolcan":"0x34A67B97","fireextinguisher":"0x60EC506","parachute":"0xFBAB5776"}}')


Citizen.CreateThread(function()
    if Config.EnableAmmoHud then
        while true do
            Citizen.Wait(200)
            local _, weaponHash = GetCurrentPedWeapon(playerPed)
            if IsPedArmed(playerPed, 7) then
                for key,value in pairs(AllWeapons) do
			        for keyTwo,valueTwo in pairs(AllWeapons[key]) do
                        if weaponHash == GetHashKey('weapon_'..keyTwo) then
                            SendNUIMessage({ type = 'SetWeaponImage', value = keyTwo })
                        end
                    end
                end
            else
                SendNUIMessage({ type = 'SetWeaponImage', value = "" })
            end
            if _ then
                if not displayAmmo then
                    if  IsPedArmed(playerPed, 4 ) then
                        SendNUIMessage({type = "display_weapon_ammo", toggle = true})
                        displayAmmo = true
                    end
                end

                local _, ammo = GetAmmoInClip(playerPed, weaponHash)
                local maxammo = GetAmmoInPedWeapon(playerPed, weaponHash)
                if IsControlPressed(0, 24) or lastAmmo ~= ammo or  lastMaxAmmo ~= maxammo then
                    if  IsPedArmed(playerPed, 4 ) then
                        SendNUIMessage({type = "update_weapon_ammo", maxammo = maxammo-ammo, ammo = ammo})
                        lastAmmo = ammo
                        lastMaxAmmo = maxammo
                        Citizen.Wait(100)
                    end
                end
            else
                if displayAmmo then
                    SendNUIMessage({type = "display_weapon_ammo", toggle = false})
                    displayAmmo = false
                end
            end
        end
    end
end)


RegisterNetEvent('SaltyChat_VoiceRangeChanged')
AddEventHandler('SaltyChat_VoiceRangeChanged', function(voiceRange, index, availableVoiceRanges)
    SendNUIMessage({ type="set_status",       statustype = "mic_level", value = index  + 1})
 end)

RegisterNetEvent('SaltyChat_TalkStateChanged')
AddEventHandler('SaltyChat_TalkStateChanged', function(isTalking)
    SendNUIMessage({ type="set_status",       statustype = "talking", value = isTalking})

end)

RegisterNetEvent('pma-voice:setTalkingMode')
AddEventHandler('pma-voice:setTalkingMode', function(voiceMode)
    SendNUIMessage({ type="set_status",       statustype = "mic_level", value = voiceMode})

end)

RegisterNetEvent("mumble:SetVoiceData")
AddEventHandler("mumble:SetVoiceData", function(player, key, value)
    if GetPlayerServerId(NetworkGetEntityOwner(playerPed)) == player and key == 'mode' then
         SendNUIMessage({ type="set_status",       statustype = "mic_level", value = value})
    end
end)

local checkTalkStatus = false
Citizen.CreateThread(function()
    Citizen.Wait(100)
    while true do
        if NetworkIsPlayerTalking(PlayerId()) then
            if not checkTalkStatus then
                checkTalkStatus = true
                SendNUIMessage({ type="set_status",       statustype = "talking", value = true})
            end
        else
            if checkTalkStatus then
                checkTalkStatus = false
                SendNUIMessage({ type="set_status",       statustype = "talking", value = false})

            end
        end
        Citizen.Wait(400)
    end
end)

local pauseActive = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(650)
        if IsPauseMenuActive() and not pauseActive then
            pauseActive = true
            TriggerEvent('codem-blackhudv2:SetForceHide', true)
        end
        if not IsPauseMenuActive() and pauseActive and not CinematicModeOn then
            pauseActive = false
            TriggerEvent('codem-blackhudv2:SetForceHide', false)
        end
    end
end)