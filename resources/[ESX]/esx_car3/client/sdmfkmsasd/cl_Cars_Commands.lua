----------------------------------------------
-- External Vehicle Commands, Made by FAXES --
----------------------------------------------

--- Code ---

function ShowInfo(text)
	BeginTextCommandThefeedPost("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandThefeedPostTicker(false, false)
end

RegisterCommand("trunk", function(source, args, raw)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    local vehLast = GetPlayersLastVehicle()
    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
    local door = 5

    if IsPedInAnyVehicle(ped, false) then
        if GetVehicleDoorAngleRatio(veh, door) > 0 then
            SetVehicleDoorShut(veh, door, false)
            ESX.ShowNotification('<font color=#3498DB>اغلاق شنطة المركبة')
        else	
            SetVehicleDoorOpen(veh, door, false, false)
            ESX.ShowNotification('<font color=#3498DB>فتح شنطة المركبة')
        end
    else
        if distanceToVeh < 6 then
            if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                SetVehicleDoorShut(vehLast, door, false)
                ESX.ShowNotification('<font color=#3498DB>اغلاق شنطة المركبة')
            else
                SetVehicleDoorOpen(vehLast, door, false, false)
                ESX.ShowNotification('<font color=#3498DB>فتح شنطة المركبة')
            end
        else
            ESX.ShowNotification('<font color=#3498DB>انت بعيد جدا عن المركبة') -- بعيد جدا عن السيارة

        end
    end
end)

RegisterCommand("hood", function(source, args, raw)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    local vehLast = GetPlayersLastVehicle()
    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
    local door = 4

    if IsPedInAnyVehicle(ped, false) then
        if GetVehicleDoorAngleRatio(veh, door) > 0 then
            SetVehicleDoorShut(veh, door, false)
            ESX.ShowNotification('<font color=#3498DB>اغلاق كبوت المركبة')
        else	
            SetVehicleDoorOpen(veh, door, false, false)
            ESX.ShowNotification('<font color=#3498DB>فتح كبوت المركبة')
        end
    else
        if distanceToVeh < 4 then
            if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                SetVehicleDoorShut(vehLast, door, false)
                ESX.ShowNotification('<font color=#3498DB>اغلاق كبوت المركبة')
            else	
                SetVehicleDoorOpen(vehLast, door, false, false)
                ESX.ShowNotification('<font color=#3498DB>فتح كبوت المركبة')
            end
        else
            ESX.ShowNotification('<font color=#3498DB>انت بعيد جدا عن المركبة')
        end
    end
end)

RegisterCommand("door", function(source, args, raw)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    local vehLast = GetPlayersLastVehicle()
    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
    
    if args[1] == "1" then -- Front Left Door
        door = 0
    elseif args[1] == "2" then -- Front Right Door
        door = 1
    elseif args[1] == "3" then -- Back Left Door
        door = 2
    elseif args[1] == "4" then -- Back Right Door
        door = 3
    else
        door = nil
        ShowInfo("Usage: ~n~~b~/door [door]")
        ShowInfo("~y~Possible doors:")
        ShowInfo("1: Front Left Door~n~2: Front Right Door")
        ShowInfo("3: Back Left Door~n~4: Back Right Door")
    end

    if door ~= nil then
        if IsPedInAnyVehicle(ped, false) then
            if GetVehicleDoorAngleRatio(veh, door) > 0 then
                SetVehicleDoorShut(veh, door, false)
                ESX.ShowNotification('<font color=#3498DB>اغلاق باب المركبة')
            else	
                SetVehicleDoorOpen(veh, door, false, false)
                ESX.ShowNotification('<font color=#3498DB>فتح باب المركبة')
            end
        else
            if distanceToVeh < 4 then
                if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                    SetVehicleDoorShut(vehLast, door, false)
                    ESX.ShowNotification('<font color=#3498DB>فتح باب المركبة')
                else	
                    SetVehicleDoorOpen(vehLast, door, false, false)
                    ESX.ShowNotification('<font color=#3498DB>اغلاق باب المركبة')
                end
            else
                ESX.ShowNotification('<font color=#3498DB>انت بعيد جدا عن المركبة')
            end
        end
    end
end)

if usingKeyPress then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(10)
            local ped = GetPlayerPed(-1)
            local veh = GetVehiclePedIsUsing(ped)
            local vehLast = GetPlayersLastVehicle()
            local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
            local door = 5
            if IsControlPressed(1, 224) and IsControlJustPressed(1, togKey) then
                if not IsPedInAnyVehicle(ped, false) then
                    if distanceToVeh < 4 then
                        if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                            SetVehicleDoorShut(vehLast, door, false)
                            ShowInfo("[Vehicle] ~g~Trunk Closed.")
                        else	
                            SetVehicleDoorOpen(vehLast, door, false, false)
                            ShowInfo("[Vehicle] ~g~Trunk Opened.")
                        end
                    else
                        ShowInfo("[Vehicle] ~y~Too far away from vehicle.")
                    end
                end
            end
        end
    end)
end



--[[ SEAT SHUFFLE ]]--
--[[ BY JAF ]]--

local disableShuffle = true
function disableSeatShuffle(flag)
	disableShuffle = flag
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				end
			end
		end
	end
end)

RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		disableSeatShuffle(false)
		Citizen.Wait(5000)
		disableSeatShuffle(true)
	else
		CancelEvent()
	end
end)

RegisterCommand("shuff", function(source, args, raw) --change command here
    TriggerEvent("SeatShuffle")
end, false) --False, allow everyone to run it