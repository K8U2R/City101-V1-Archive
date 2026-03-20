ESX = nil

PlayerData = {}

MycurrentJobLeo = false

RegisterFontFile('A9eelsh')
fontId = RegisterFontId('A9eelsh')

Citizen.CreateThread(function()
		
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(500)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(500)
	end
	
	PlayerData = ESX.GetPlayerData()
	
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

    for i = 0, 256 do
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

	if check then
		MycurrentJobLeo = true
		Config.cooldownCurrent = Config.cooldownPolice
	else
		MycurrentJobLeo = false
		Config.cooldownCurrent = Config.cooldownCitizen
	end
end	