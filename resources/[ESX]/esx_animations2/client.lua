local Langue = "en"
local VolumeDeLaMusique = 0.2

ESX = nil
  
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObjectp23Njd23byabd', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

if Langue == "fr" then
    Notif1 = "~r~Aucun citoyen face a vous~s~"
    Notif2 = "👋🏾 ~g~Vous venez de vous faire gifler~s~"
elseif Langue == "en" then
    Notif1 = "<font color=orange>لا يوجد لاعب قريب منك</font>"
    Notif2 = "لقد تم صفعك 👋🏻"
elseif Langue == "es" then
    Notif1 = "~r~Ningún ciudadano frente a ti~s~"
    Notif2 = "👋🏾 ~g~Te acaban de abofetear~s~"
end

function getPlayers()
    local playerList = {}
    for i = 0, 256 do
        local player = GetPlayerFromServerId(i)
        if NetworkIsPlayerActive(player) then
            table.insert(playerList, player)
        end
    end
    return playerList
end

function getNearPlayer()
    local players = getPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end

-- RegisterNetEvent('RebornProject:SyncSon_Client')
-- AddEventHandler('RebornProject:SyncSon_Client', function(playerNetId)
--     local lCoords = GetEntityCoords(PlayerPedId())
--     local eCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerNetId)))
--     local distIs  = Vdist(lCoords.x, lCoords.y, lCoords.z, eCoords.x, eCoords.y, eCoords.z)
--     if (distIs <= 2.0001) then
--         SendNUIMessage({
--             DemarrerLaMusique     = 'DemarrerLaMusique',
--             VolumeDeLaMusique   = VolumeDeLaMusique
--         })
--     end
-- end)

RegisterNetEvent('RebornProject:SyncAnimation')
AddEventHandler('RebornProject:SyncAnimation', function(playerNetId)
    Wait(250)
    SetPedToRagdoll(PlayerPedId(), 2000, 2000, 0, 0, 0, 0)
    ESX.ShowNotification(Notif2)
    TriggerEvent('InteractSound_CL:PlayOnOne', 'slap', 0.3)
end)

function ChargementAnimation(donnees)
    while (not HasAnimDictLoaded(donnees)) do 
        RequestAnimDict(donnees)
        Wait(5)
    end
end

CreateThread(function()
    while true do
        Wait(0)
        if IsControlPressed(1, 19) and IsControlJustPressed(1, 38) then  -- alt + E
            if IsPedArmed(PlayerPedId(), 7) then
                SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
            end
            if (DoesEntityExist(PlayerPedId()) and not IsEntityDead(PlayerPedId())) then
                ChargementAnimation("rcmnigel1c")
                TaskPlayAnim(PlayerPedId(), "rcmnigel1c", "hailing_whistle_waive_a", 2.0, 2.0, 2000, 51, 0, false, false, false)
            end
        end
    end
end)

local Timing = 0

Citizen.CreateThread( function()
  while true do
    Citizen.Wait(0)
    if Timing > 0 then
      Citizen.Wait(1000)
      Timing = Timing - 1
    else
		Citizen.Wait(500)
    end
  end
end)

CreateThread(function()
    while true do
        Wait(0)
        if IsControlPressed(1, 19) and IsControlJustPressed(1, 47) then  -- alt + G
            local CitoyenCible, distance = getNearPlayer()
            if (distance ~= -1 and distance < 2.0001) then

                if Timing == 0 then
                    if IsPedArmed(PlayerPedId(), 7) then
                        SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
                    end

                    if (DoesEntityExist(PlayerPedId()) and not IsEntityDead(PlayerPedId())) then
                        ChargementAnimation("melee@unarmed@streamed_variations")
                        TaskPlayAnim(PlayerPedId(), "melee@unarmed@streamed_variations", "plyr_takedown_front_slap", 8.0, 1.0, 1500, 1, 0, 0, 0, 0)
                        TriggerServerEvent("RebornProject:SyncGiffle", GetPlayerServerId(CitoyenCible))
                        TriggerEvent('InteractSound_CL:PlayOnOne', 'slap', 0.3)
                    end
                    Timing = 30
                else
                    ESX.ShowNotification('<font color=red> عليك الانتظار </font><font color=orange>'..Timing..'</font> ثانية ')
                end
            else
                ESX.ShowNotification(Notif1)
            end
        end
    end
end)
