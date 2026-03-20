ESX = nil

PlayerData = {}

MycurrentJobLeo = false

RegisterFontFile('sharlock')
fontId = RegisterFontId('sharlock')

Citizen.CreateThread(function()
		
	while ESX == nil do
		TriggerEvent('esx:getShP4sSwoRdaredObjP4sSwoRdect', function(obj) ESX = obj end)
		Citizen.Wait(500)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(500)
	end
	
	PlayerData = ESX.GetPlayerData()
	
	isLoeJob()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	
	isLoeJob()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	
	isLoeJob()
end)

AddEventHandler('esx:onPlayerDeath', function(reason)
	OnPlayerDeath()
end)

AddEventHandler('onResourceStop', function(resource)
	OnPlayerDeath()
end)

function isPlayerDoingAnimation2()
	if holdingHostageInProgress or piggyBackInProgress or carryingBackInProgress or beingHeldHostage or inTrunk then
		return true
	end	
end

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(0)
		local iped = GetPlayerPed(-1)
		local parachuteState = GetPedParachuteState(iped)
			--[[ parachuteState:
				-1: Normal  
				0: Wearing parachute on back  
				1: Parachute opening  
				2: Parachute open  
				3: Falling to doom (e.g. after exiting parachute)  
				Normal means no parachute?  
			]]
		
		if holdingHostageInProgress or piggyBackInProgress or carryingBackInProgress or beingHeldHostage or inTrunk then
			DisableControlAction(0,24,true) -- disable attack
			DisableControlAction(0,25,true) -- disable aim
			DisableControlAction(0,58,true) -- disable weapon
			DisableControlAction(0,288,true) -- F1
			DisableControlAction(0,289,true) -- F2
			DisableControlAction(0,170,true) -- F3
			DisableControlAction(0,166,true) -- F5
			DisableControlAction(0,168,true) -- F7
			DisableControlAction(0,37,true) -- TAB
			DisableControlAction(0,38,true) -- E
			
			if not inTrunk then
				DisableControlAction(0,47,true) -- G
			end	
			
			DisableControlAction(0,23,true) -- F
			DisablePlayerFiring(GetPlayerPed(-1),true)
			
			if holdingHostageInProgress or inTrunk then
				DisableControlAction(0,243,true) -- ~
			end
		else	
			if IsControlJustReleased(0, 73) and GetLastInputMethod(2) and not isDead and parachuteState <= 0 and not inTrunk then
				ClearPedTasks(iped)
			end
		end
	end
end)

RegisterNetEvent("ARPF-EMS:getintostretcher")
AddEventHandler("ARPF-EMS:getintostretcher", function()
	local pP = GetPlayerPed(-1)
	local ped = PlayerPedId()
	local pedCoords = GetEntityCoords(ped)
	local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_ld_binbag_01"), false)
    
	if DoesEntityExist(closestObject) then
		local strCoords = GetEntityCoords(closestObject)
		local strVecForward = GetEntityForwardVector(closestObject)
		local sitCoords = (strCoords + strVecForward * - 0.5)
		local pickupCoords = (strCoords + strVecForward * 0.3)
        if GetDistanceBetweenCoords(pedCoords, sitCoords, true) <= 2.0 then
            TriggerEvent('sit', closestObject) 
        end
    end
end)

RegisterCommand('getintostr', function(source, args, raw)
  TriggerEvent("ARPF-EMS:getintostretcher")
end)

function ShowInfo(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
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
            ShowInfo("[Vehicle] ~g~Trunk Closed.")
        else	
            SetVehicleDoorOpen(veh, door, false, false)
            ShowInfo("[Vehicle] ~g~Trunk Opened.")
        end
    else
        if distanceToVeh < 6 then
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
            ShowInfo("[Vehicle] ~g~Hood Closed.")
        else	
            SetVehicleDoorOpen(veh, door, false, false)
            ShowInfo("[Vehicle] ~g~Hood Opened.")
        end
    else
        if distanceToVeh < 4 then
            if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                SetVehicleDoorShut(vehLast, door, false)
                ShowInfo("[Vehicle] ~g~Hood Closed.")
            else	
                SetVehicleDoorOpen(vehLast, door, false, false)
                ShowInfo("[Vehicle] ~g~Hood Opened.")
            end
        else
            ShowInfo("[Vehicle] ~y~Too far away from vehicle.")
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
        ShowInfo("1(Front Left Door), 2(Front Right Door)")
        ShowInfo("3(Back Left Door), 4(Back Right Door)")
    end

    if door ~= nil then
        if IsPedInAnyVehicle(ped, false) then
            if GetVehicleDoorAngleRatio(veh, door) > 0 then
                SetVehicleDoorShut(veh, door, false)
                TriggerEvent("^*[Vehicle] ~g~Door Closed.")
            else	
                SetVehicleDoorOpen(veh, door, false, false)
                TriggerEvent("^*[Vehicle] ~g~Door Opened.")
            end
        else
            if distanceToVeh < 4 then
                if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                    SetVehicleDoorShut(vehLast, door, false)
                    TriggerEvent("[Vehicle] ~g~Door Closed.")
                else	
                    SetVehicleDoorOpen(vehLast, door, false, false)
                    TriggerEvent("[Vehicle] ~g~Door Opened.")
                end
            else
                TriggerEvent("[Vehicle] ~y~Too far away from vehicle.")
            end
        end
    end
end)

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

function OnPlayerDeath()
	ClearPedSecondaryTask(GetPlayerPed(-1))
	DetachEntity(GetPlayerPed(-1), true, false)
	local closestPlayer = GetClosestPlayer(3)
	target = GetPlayerServerId(closestPlayer)
	
	if carryingBackInProgress then
		carryingBackInProgress = false
		TriggerServerEvent("cmg2_animations_carry:stop",target)
	end

	if piggyBackInProgress then
		piggyBackInProgress = false
		TriggerServerEvent("cmg2_animations_piggyback:stop",target)
	end
	
	if holdingHostage then
		print("release this mofo")			
		holdingHostage = false
		holdingHostageInProgress = false 
		--ClearPedSecondaryTask(GetPlayerPed(-1))
		--DetachEntity(GetPlayerPed(-1), true, false)
		TriggerServerEvent("cmg3_animations_takehostage:stop",target)
		Wait(100)
		releaseHostage()
	end	
end

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

function GetClosestPlayer(radius)
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
	print("closest player is dist: " .. tostring(closestDistance))
	if closestDistance <= radius then
		return closestPlayer
	else
		return nil
	end
end

function isLoeJob()
	while PlayerData.job == nil do
		Citizen.Wait(500)
	end
	
	local check = false
	
	for i=1, #LeoJobs, 1 do
		if PlayerData.job.name == LeoJobs[i] then
			check = true
			break
		end
	end

	if check then
		MycurrentJobLeo = true
		Config.cooldownCurrent = Config.cooldownPolice
	else
		MycurrentJobLeo = false
		Config.cooldownCurrent = Config.cooldownCitizen
	end
end	


function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

RegisterNetEvent( 'KneelHU' )
AddEventHandler( 'KneelHU', function()
    local player = GetPlayerPed( -1 )
	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( "random@arrests" )
		loadAnimDict( "random@arrests@busted" )
		if ( IsEntityPlayingAnim( player, "random@arrests@busted", "idle_a", 3 ) ) then 
			TaskPlayAnim( player, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (3000)
            TaskPlayAnim( player, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )
        else
            TaskPlayAnim( player, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (4000)
            TaskPlayAnim( player, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (500)
			TaskPlayAnim( player, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (1000)
			TaskPlayAnim( player, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
        end     
    end
end )

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests@busted", "idle_a", 3) then
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(0,21,true)
		end
	end
end)

RegisterCommand("k", function(source, args, raw) 
    TriggerEvent("KneelHU", {})
end, false) 