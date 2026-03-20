local ESX, PlayerData = exports['es_extended']:getSharedObject(), {}
Citizen.CreateThread(function()
    while not ESX.GetPlayerData().job do
        Citizen.Wait(500)
    end
    PlayerData = ESX.GetPlayerData()
end)
RegisterNetEvent("esx:playerLoaded", function(xPlayer) PlayerData = xPlayer end)
RegisterNetEvent("esx:setJob", function(job) PlayerData.job = job end)


function GetCurrentPlayers()
    local TotalPlayers = 0

    for _, player in ipairs(GetActivePlayers()) do
        TotalPlayers = TotalPlayers + 1
    end

    return TotalPlayers
end

Citizen.CreateThread(function()
    while true do
        ESX.TriggerServerCallback('callbackplayers', function(data)     
            cagent = data.cagent
            cpolice = data.cpolice
            cslaughterer = data.cslaughterer
            cmedic = data.cmedic
            cstaffs = data.cstaffs
            slaughterer = data.slaughterer
            cmechanic = data.cmechanic
            players = GetCurrentPlayers()
        end)
        Citizen.Wait(Config.UpdateTime)
    end
end)

