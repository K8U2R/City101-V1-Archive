local ESX = nil
local PlayerData = {}
local onDuty = false
local longBlips = {}
local nearBlips = {}
local myBlip = {}

StopScreenEffect('DeathFailOut')

Citizen.CreateThread(function()

	while ESX == nil do

		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

		Wait(0)

	end

    while ESX.GetPlayerData().job == nil do

        Wait(100)

    end

	PlayerData = ESX.GetPlayerData()

    checkJob()

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)

	PlayerData = xPlayer

    checkJob()

end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)

	PlayerData.job = job

    if onDuty then

        goOffDuty()

    end

    checkJob()

end)

AddEventHandler('onResourceStop', function(resourceName)

    if GetCurrentResourceName() ~= resourceName then

        return

    end

    removeAllBlips()

end)

function checkJob()

    if PlayerData and PlayerData.job and Config.emergencyJobs[PlayerData.job.name] and Config.emergencyJobs[PlayerData.job.name].ignoreDuty then

        goOnDuty()

    end

end

function goOnDuty()

    onDuty = true

    TriggerServerEvent('wesam:esx_blipsjobs:setDuty', true)

end

function goOffDuty()

    onDuty = false

    TriggerServerEvent('wesam:esx_blipsjobs:setDuty', false)

    removeAllBlips()

end

function removeAllBlips()

    restoreBlip(myBlip.blip or GetMainPlayerBlipId())

    for k, v in pairs(nearBlips) do

        RemoveBlip(v.blip)

    end

    for k, v in pairs(longBlips) do

        RemoveBlip(v.blip)

    end

    nearBlips = {}

    longBlips = {}

    myBlip = {}

end

RegisterNetEvent('wesam:esx_blipsjobs:removeUser')
AddEventHandler('wesam:esx_blipsjobs:removeUser', function(plyId)

    if nearBlips[plyId] then

        RemoveBlip(nearBlips[plyId].blip)

        nearBlips[plyId] = nil

    end

    if longBlips[plyId] then

        RemoveBlip(longBlips[plyId].blip)

        longBlips[plyId] = nil

    end

end)



RegisterNetEvent('wesam:esx_blipsjobs:receiveData')
AddEventHandler('wesam:esx_blipsjobs:receiveData', function(myId, data)

    for k, v in pairs(data) do

        local cId = GetPlayerFromServerId(v.playerId)

        local canSee = Config.emergencyJobs[v.job].canSee and Config.emergencyJobs[v.job].canSee[PlayerData.job.name]

        if canSee then

            if myId ~= v.playerId then

                if cId ~= -1 then

                    if nearBlips[v.playerId] == nil then

                        if longBlips[v.playerId] then

                            RemoveBlip(longBlips[v.playerId].blip)

                            longBlips[v.playerId] = nil
                            
                        end

                        nearBlips[v.playerId] = {}

                        nearBlips[v.playerId].blip = AddBlipForEntity(GetPlayerPed(cId))

                        setupBlip(nearBlips[v.playerId].blip, v)

                    end

                else

                    if longBlips[v.playerId] == nil then

                        if nearBlips[v.playerId] then

                            RemoveBlip(nearBlips[v.playerId].blip)

                            nearBlips[v.playerId] = nil
                            
                        end

                        longBlips[v.playerId] = {}

                        longBlips[v.playerId].blip = AddBlipForCoord(v.coords)

                        setupBlip(longBlips[v.playerId].blip, v)

                    else

                        if longBlips[v.playerId] then

                            RemoveBlip(longBlips[v.playerId].blip)

                        end

                        longBlips[v.playerId].blip = AddBlipForCoord(v.coords)

                        setupBlip(longBlips[v.playerId].blip, v)

                    end

                end

            end

        end

    end

end)

function setupBlip(blip, data)
    
    local cId2 = GetPlayerFromServerId(data.playerId)

	SetBlipSprite(blip, Config.emergencyJobs[data.job].blip.sprite)

	SetBlipDisplay(blip, 2)

	SetBlipScale(blip, Config.emergencyJobs[data.job].blip.scale or 1.0)

	SetBlipColour(blip, Config.emergencyJobs[data.job].blip.color)

    SetBlipFlashes(blip, false)

    if cId2 == -1 then

        ShowHeadingIndicatorOnBlip(blip, false)

    else

        ShowHeadingIndicatorOnBlip(blip, true)

    end

    SetBlipCategory(blip, 7)

	BeginTextCommandSetBlipName("STRING")


    AddTextComponentString("<font face='A9eelsh'>" .. data.name .. "</font>")


	EndTextCommandSetBlipName(blip)

end

function restoreBlip(blip)

    SetBlipSprite(blip, 6)

    SetBlipDisplay(blip, 4)

    SetBlipScale(blip, 0.7)

    SetBlipColour(blip, 0)

    ShowHeadingIndicatorOnBlip(blip, false)

    BeginTextCommandSetBlipName("STRING")

    AddTextComponentString(GetPlayerName(PlayerId()))

    EndTextCommandSetBlipName(blip)

    SetBlipCategory(blip, 1)

end