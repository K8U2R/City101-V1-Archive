ESX = exports['es_extended']:getSharedObject()

local currentlyTowedVehicle = nil

function isTargetVehicleATrailer(modelHash)
    if GetVehicleClassFromName(modelHash) == 11 then
        return true
    else
        return false
    end
end

local xoff = 0.0
local yoff = 0.0
local zoff = 0.0

function isVehicleATowTruck(vehicle)
    local isValid = false
    for model,posOffset in pairs(wesam.allowedTowModels) do
        if IsVehicleModel(vehicle, model) then
            xoff = posOffset.x
            yoff = posOffset.y
            zoff = posOffset.z
            isValid = true
            break
        end
    end
    return isValid
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local playerped = PlayerPedId()
        local pedCoords = GetEntityCoords(playerped)
        local closesvehicle = GetClosestVehicle(pedCoords, 10.0, GetHashKey('flatbed'), 70)
        local vehicle = GetVehiclePedIsIn(playerped, true)
    
        local isVehicleTow = isVehicleATowTruck(vehicle)

        if isVehicleTow then
            if DoesEntityExist(closesvehicle) and IsVehicleSeatFree(closesvehicle,-1) and isVehicleATowTruck(closesvehicle) then
                local d1,d2 = GetModelDimensions(GetEntityModel(closesvehicle))
                local enginePos = GetOffsetFromEntityInWorldCoords(closesvehicle, -2.0,d1.y+2.8,-1.0)
                local enginePos2 = GetOffsetFromEntityInWorldCoords(closesvehicle, 0.0,d1.y-3.8,-1.0)
                local vehDistance = (GetDistanceBetweenCoords(pedCoords, vector3(enginePos.x, enginePos.y, enginePos.z), true))
                local vehCoords = vector3(enginePos.x, enginePos.y, enginePos.z+0.6)
                local vehCoords2 = vector3(enginePos2.x, enginePos2.y, enginePos2.z+0.6)

                if vehDistance <= 9.0 then
                    DrawMarker(1, enginePos.x, enginePos.y, enginePos.z-0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.3, 1.3, 1.0, 255, 255, 255, 200, false, true, 2, false, false, false, false)
                    DrawMarker(1, enginePos2.x, enginePos2.y, enginePos2.z-0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.3, 2.3, 1.0, 255, 0, 0, 200, false, true, 2, false, false, false, false)
                    if vehDistance <= 2.0 then
                        ESX.ShowHelpNotification('ﺔﺒﻛﺮﻤﻟﺍ ﻊﻓﺮﻟ ~y~E ~w~ﻂﻐﻀﺎ  ')
                        if IsControlJustPressed(0, 38) then
                            local coordA = GetEntityCoords(playerped, 1)
                            local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
                            local targetVehicle, targetVehicledistance = ESX.Game.GetClosestVehicle(vehCoords2)
                        
                            Citizen.CreateThread(function()
                                while true do
                                    Citizen.Wait(0)
                                    isVehicleTow = isVehicleATowTruck(vehicle)
                                    local roll = GetEntityRoll(GetVehiclePedIsIn(PlayerPedId(), true))
                                    if IsEntityUpsidedown(GetVehiclePedIsIn(PlayerPedId(), true)) and isVehicleTow or roll > 70.0 or roll < -70.0 then
                                        DetachEntity(currentlyTowedVehicle, false, false)
                                        currentlyTowedVehicle = nil
                                        exports['es_extended']:ShowNotification("يبدو أن الكابلات المثبتة على السيارة قد تحطمت")
                                        break
                                    end
                                end
                            end)

                            if currentlyTowedVehicle == nil then
                                if DoesEntityExist(targetVehicle) and targetVehicledistance <= 3.0 then
                                    local targetVehicleLocation = GetEntityCoords(targetVehicle, true)
                                    local towTruckVehicleLocation = GetEntityCoords(vehicle, true)
                                    local targetModelHash = GetEntityModel(targetVehicle)
                                    
                                    if not ((not allowTowingBoats and IsThisModelABoat(targetModelHash)) or (not allowTowingHelicopters and IsThisModelAHeli(targetModelHash)) or (not allowTowingPlanes and IsThisModelAPlane(targetModelHash)) or (not allowTowingTrains and IsThisModelATrain(targetModelHash)) or (not allowTowingTrailers and isTargetVehicleATrailer(targetModelHash))) then 
                                        if not IsPedInAnyVehicle(playerped, true) then
                                            if vehicle ~= targetVehicle and IsVehicleStopped(vehicle) then
                                                AttachEntityToEntity(targetVehicle, vehicle, GetEntityBoneIndexByName(vehicle, 'bodyshell'), 0.0 + xoff, -1.5 + yoff, 0.0 + zoff, 0, 0, 0, false, false, true, false, 0, true)
                                                currentlyTowedVehicle = targetVehicle
                                            else
                                                exports['es_extended']:ShowNotification("لا توجد أي مركبة على السطحة")
                                            end
                                        else
                                            exports['es_extended']:ShowNotification("يجب أن تكون خارج مركبتك")
                                        end
                                    else
                                        exports['es_extended']:ShowNotification("شاحنة السحب الخاصة بك غير مجهزة لسحب هذه المركبة")
                                    end
                                else
                                    exports['es_extended']:ShowNotification("لم يتم العثور على مركبة قابلة للرفع")
                                end
                            elseif IsVehicleStopped(vehicle) then
                                DetachEntity(currentlyTowedVehicle, false, false)
                                local vehiclesCoords = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -12.0, 0.0)
                                SetEntityCoords(currentlyTowedVehicle, vehiclesCoords["x"], vehiclesCoords["y"], vehiclesCoords["z"], 1, 0, 0, 1)
                                SetVehicleOnGroundProperly(currentlyTowedVehicle)
                                currentlyTowedVehicle = nil
                            end
                        end
                    end
                end
            end
        end
    end
end)
