inTrunk = false

Citizen.CreateThread(function()
    local sleep = 0
	while true do
        sleep = 0
		if inTrunk then
			sleep = 0
            local vehicle = GetEntityAttachedTo(PlayerPedId())
            if DoesEntityExist(vehicle) or not IsPedDeadOrDying(PlayerPedId()) or not IsPedFatallyInjured(PlayerPedId()) then
                local coords = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, 'boot'))
                SetEntityCollision(PlayerPedId(), false, false)
                DrawText3D_hideTrunk(coords, '[G] ﺔﻄﻨﺸﻟﺍ ﻦﻣ ﺝﻭﺮﺧ')

                if GetVehicleDoorAngleRatio(vehicle, 5) < 0.9 then
                    SetEntityVisible(PlayerPedId(), false, false)
                else
                    if not IsEntityPlayingAnim(PlayerPedId(), 'timetable@floyd@cryingonbed@base', 3) then
                        loadDict('timetable@floyd@cryingonbed@base')
                        TaskPlayAnim(PlayerPedId(), 'timetable@floyd@cryingonbed@base', 'base', 8.0, -8.0, -1, 1, 0, false, false, false)

                        SetEntityVisible(PlayerPedId(), true, false)
                    end
                end
                if IsControlJustReleased(0, 47) and inTrunk then
                    SetCarBootOpen(vehicle)
                    SetEntityCollision(PlayerPedId(), true, true)
                    Wait(750)
                    inTrunk = false
                    DetachEntity(PlayerPedId(), true, true)
                    SetEntityVisible(PlayerPedId(), true, false)
                    ClearPedTasks(PlayerPedId())
                    SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -0.5, -0.75))
                    Wait(250)
                    SetVehicleDoorShut(vehicle, 5)
                end
            else
                SetEntityCollision(PlayerPedId(), true, true)
                DetachEntity(PlayerPedId(), true, true)
                SetEntityVisible(PlayerPedId(), true, false)
                ClearPedTasks(PlayerPedId())
                SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -0.5, -0.75))
            end
        end
		
        Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while not NetworkIsSessionStarted() or ESX == nil do Wait(1) end
	
    while true do
        local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 6.0, 0, 70)
        if DoesEntityExist(vehicle) and Config.hidetrunk.blacklisted_model[GetEntityModel(vehicle)] == nil then
			Citizen.Wait(0)
            local trunk = GetEntityBoneIndexByName(vehicle, 'boot')
            if trunk ~= -1 then
                local coords = GetWorldPositionOfEntityBone(vehicle, trunk)
                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), coords, true) <= 1.5 then
                    if not inTrunk then
                        if GetVehicleDoorAngleRatio(vehicle, 5) < 0.9 then
                            DrawText3D_hideTrunk(coords, '[G] ﺔﻄﻨﺸﻟﺎﺑ ﺀﺎﺒﺘﺧﺍ\n[H] ﺔﻄﻨﺸﻟﺍ ﺢﺘﻓ')
                            if IsControlJustReleased(0, 74) then
                                -- SetVehicleDoorOpen(vehicle, 5, false, false)
                                SetCarBootOpen(vehicle)
                            end
                        else
                            DrawText3D_hideTrunk(coords, '[G] ﺔﻄﻨﺸﻟﺎﺑ ﺀﺎﺒﺘﺧﺍ\n[H] ﺔﻄﻨﺸﻟﺍ ﻖﻠﻏ')
                            if IsControlJustReleased(0, 74) then
                                SetVehicleDoorShut(vehicle, 5)
                            end
                        end
                    end
                    if IsControlJustReleased(0, 47) and not inTrunk then
                        local player = ESX.Game.GetClosestPlayer()
                        local playerPed = GetPlayerPed(player)
                        if DoesEntityExist(playerPed) then
                            if not IsEntityAttached(playerPed) or GetDistanceBetweenCoords(GetEntityCoords(playerPed), GetEntityCoords(PlayerPedId()), true) >= 5.0 then
                                SetCarBootOpen(vehicle)
								SetCurrentPedWeapon(GetPlayerPed(-1),GetHashKey("WEAPON_UNARMED"),true)
                                Wait(350)
                                AttachEntityToEntity(PlayerPedId(), vehicle, -1, 0.0, -2.2, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)	
                                loadDict('timetable@floyd@cryingonbed@base')
                                TaskPlayAnim(PlayerPedId(), 'timetable@floyd@cryingonbed@base', 'base', 8.0, -8.0, -1, 1, 0, false, false, false)
                                Wait(50)
                                inTrunk = true

                                Wait(1500)
                                SetVehicleDoorShut(vehicle, 5)
                            else
                                ESX.ShowNotification('<font color=red>يوجد شخص داخل الشنطة')
                            end
                        end
                    end
                end
            end
        else
			Citizen.Wait(3000)
		end
    end
end)

loadDict = function(dict)
    while not HasAnimDictLoaded(dict) do Wait(500) RequestAnimDict(dict) end
end

function DrawText3D_hideTrunk(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
  
    SetTextScale(0.4, 0.4)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
  
    AddTextComponentString(text)
    DrawText(_x, _y)
end