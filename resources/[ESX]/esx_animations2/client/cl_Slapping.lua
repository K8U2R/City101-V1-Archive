local Langue = "fr"
local VolumeDeLaMusique = 0.2
local CoolDownTime = 60 -- مدة الأنتظار مابين كل كف
local TargetCoolDownTime = 5 -- كم ثانية إنتظار بعد أخذ كف من شخص
local TakeXP = 10 -- كم خبرة يخصم على الكلف الواحد

if Langue == "fr" then
    Notif1 = "~r~Aucun citoyen face a vous~s~"
    Notif2 = "๐‘๐พ ~g~Vous venez de vous faire gifler~s~"
elseif Langue == "en" then
    Notif1 = "~r~No citizen in front of you~s~"
    Notif2 = "๐‘๐พ ~g~You have just been slapped~s~"
elseif Langue == "es" then
    Notif1 = "~r~Ningรบn ciudadano frente a ti~s~"
    Notif2 = "๐‘๐พ ~g~Te acaban de abofetear~s~"
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
    local ply = GetPlayerPed(-1)
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

local count = 0
	
	local function slapCoolDown(sec)
		CreateThread(function()
			count = sec
			while count ~= 0 do
				count = count - 1
				Wait(1000)
			end	
			count = 0
		end)	
	end

RegisterNetEvent('RebornProject:SyncAnimation')
AddEventHandler('RebornProject:SyncAnimation', function(playerNetId)
    --Wait(250)
	slapCoolDown(TargetCoolDownTime)
    Wait(50)
	if IsPedInAnyVehicle(PlayerPedId(), false) then
	else
		--SetPedToRagdoll(GetPlayerPed(-1), 2000, 2000, 0, 0, 0, 0) -- old
	    ChargementAnimation("melee@unarmed@streamed_variations")
        TaskPlayAnim(GetPlayerPed(-1), "melee@unarmed@streamed_variations", "victim_takedown_front_backslap", 8.0, 1.0, 1500, 1, 0, 0, 0, 0)
	    ESX.ShowNotification('✋ لـقد تـم صـفعـك')
	end			
end)

RegisterNetEvent("RebornProject:Notification")
AddEventHandler('RebornProject:Notification', function(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(true, false)
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
        if IsControlPressed(1, 19) and IsControlJustPressed(1, 38) then  -- alt + G
            if IsPedArmed(GetPlayerPed(-1), 7) then
                SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey('WEAPON_UNARMED'), true)
            end
            if (DoesEntityExist(GetPlayerPed(-1)) and not IsEntityDead(GetPlayerPed(-1))) then
                RequestAnimDict("rcmnigel1c")
				while not HasAnimDictLoaded("rcmnigel1c") do
					Citizen.Wait(100)
				end
                TaskPlayAnim(GetPlayerPed(-1), "rcmnigel1c", "hailing_whistle_waive_a", 2.7, 2.7, 1500, 49, 0, 0, 0, 0)
            end
        end
    end
end)

CreateThread(function()
    local SlapPass = 'kd92jjKKKkNdnm2'
    while true do
        Wait(0)
        if IsControlPressed(1, 19) and IsControlJustPressed(1, 47) then  -- alt + G
            local CitoyenCible, distance = getNearPlayer()
            if (distance ~= -1 and distance < 2.0001) then
                if count == 0 then 
                    if IsPedArmed(GetPlayerPed(-1), 7) then
                        SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey('WEAPON_UNARMED'), true)
                    end

                    if (DoesEntityExist(GetPlayerPed(-1)) and not IsEntityDead(GetPlayerPed(-1))) then
					if IsPedInAnyVehicle(PlayerPedId(), false) then
	                else
                        slapCoolDown(CoolDownTime)
                        exports.SvStore_xplevel:ESXP_Remove(TakeXP)
                        ChargementAnimation("melee@unarmed@streamed_variations")
                        --TaskPlayAnim(GetPlayerPed(-1), "melee@unarmed@streamed_variations", "plyr_takedown_front_slap", 8.0, 1.0, 1500, 1, 0, 0, 0, 0) -- old
                        TaskPlayAnim(GetPlayerPed(-1), "melee@unarmed@streamed_variations", "plyr_takedown_front_backslap", 8.0, 1.0, 1500, 1, 0, 0, 0, 0)
                        TriggerServerEvent("RebornProject:SyncGiffle", GetPlayerServerId(CitoyenCible), SlapPass)
						Wait(400)
						TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 3.0, "slap", 0.3)
                    end
                    end
                else
					ESX.ShowNotification('<font color=red>يجب الأنتظار</font>. <font color=orange>'..count..' ثانية</font>')
                end
            else		  
				ESX.ShowNotification('لا يـوجد لاعـب بالـقرب مـنـك')
            end
        end
    end
end)

CreateThread(function()
    local doneK = false
    while true do
        Wait(0)
        if IsControlPressed(1, 19) and IsControlJustPressed(1, 74) and not doneK then  -- alt + H
           ExecuteCommand("k")
		   doneK = true
		   Wait(1500)
		   doneK = false
      end
    end
end)