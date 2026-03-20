local ESX = nil
local dutyTable = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()

    while true do

        local sendTable = {}

        for k, v in pairs(dutyTable) do

            local coords = GetEntityCoords(GetPlayerPed(k))

            local tempVar = v

            tempVar.playerId = k

            tempVar.coords = coords

            table.insert(sendTable, tempVar)

        end

        for player, kekw in pairs(dutyTable) do

            TriggerClientEvent('wesam:esx_blipsjobs:receiveData', player, player, sendTable)

        end

        Citizen.Wait(15000)

    end

end)

RegisterNetEvent('wesam:esx_blipsjobs:setDuty')
AddEventHandler('wesam:esx_blipsjobs:setDuty', function(onDuty)

    local src = source

    if onDuty then

        local xPlayer = ESX.GetPlayerFromId(src)

        local playerJob = xPlayer.getJob()

        if Config.emergencyJobs[playerJob.name] then

            local cfg = Config.emergencyJobs[playerJob.name]

            dutyTable[src] = {job = playerJob.name, name = GetPlayerName(src)}

        end

    else

        if dutyTable[src] then

            dutyTable[src] = nil
            for k, v in pairs(dutyTable) do

                TriggerClientEvent('wesam:esx_blipsjobs:removeUser', k, src)

            end

        end

    end

end)

AddEventHandler('playerDropped', function(reason)

    local src = source

    if dutyTable[src] then
        
        dutyTable[src] = nil

        for k, v in pairs(dutyTable) do

            TriggerClientEvent('wesam:esx_blipsjobs:removeUser', k, src)

        end

    end

end)