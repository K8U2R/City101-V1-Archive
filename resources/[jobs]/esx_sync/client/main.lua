Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config.getSharedObject, function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
	PlayerData = ESX.GetPlayerData()
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.TriggerServerCallback('esx_adminjob:syncgetvar', function(data)
	if data then
	TriggerServerEvent('esx_adminjob:getAllOnlinePlayers', true)
	end
	end)
end)

RegisterNetEvent('esx_adminjob:banHackerParment')
AddEventHandler('esx_adminjob:banHackerParment', function(state)
    TriggerServerEvent('esx_adminjob:getAllOnlinePlayers', state)
end)

local _cooldownsky = false
RegisterNetEvent('esx:sendToPlayer')
AddEventHandler('esx:sendToPlayer', function(type, state)
    if type == 'send_to_admin' then
        BusyspinnerOff()
    else
        local playerPed = GetPlayerPed(-1)
        if state then
        ESX.UI.Menu.CloseAll()
        _cooldownsky = true
        SwitchOutPlayer(playerPed,0,1)
        FreezeEntityPosition(playerPed, true)
        if IsInVehicle() then
            veh = GetVehiclePedIsIn(playerPed)
            FreezeEntityPosition(veh, true)
        end
        Citizen.CreateThread(function()
            while _cooldownsky do
                Citizen.Wait(0)
                DisableAllControlActions(0) 
            end
        end)
        Wait(3000)
        BeginTextCommandBusyspinnerOn("STRING")
        AddTextComponentString('Syncing server data')
        EndTextCommandBusyspinnerOn(1)
        else 
            BusyspinnerOff()
            SwitchInPlayer(playerPed) 
            while GetPlayerSwitchState() ~= 12 do
                Citizen.Wait(0)
            end
            SetEntityCollision(playerPed, true, true)
            FreezeEntityPosition(playerPed, false)
            if IsInVehicle() then
                veh = GetVehiclePedIsIn(playerPed)
                FreezeEntityPosition(veh, false)
            end
            _cooldownsky = false
        end
    end
end)

function IsInVehicle()
return GetPedInVehicleSeat(GetVehicle(), -1)
end

function GetVehicle()
return GetVehiclePedIsIn(GetPlayerPed(-1), false)
end