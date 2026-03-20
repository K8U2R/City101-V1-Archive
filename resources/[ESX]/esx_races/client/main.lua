ESX                           = nil

local RaceVehicle = nil

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj 
        end)

        Citizen.Wait(1)
    end
end) 
  
Citizen.CreateThread(function()

    for race, val in pairs(Config.RaceInformations) do
        local Blip = AddBlipForCoord(val['StartRace']['x'], val['StartRace']['y'], val['StartRace']['z'])
    
        SetBlipSprite (Blip, val['Sprite'])
        SetBlipDisplay(Blip, 4)
        SetBlipScale  (Blip, 0.8)
        SetBlipColour (Blip, 75)
        SetBlipAsShortRange(Blip, true)
    
        BeginTextCommandSetBlipName("STRING")
        --AddTextComponentString(race)
        AddTextComponentString("<FONT FACE='A9eelsh'>ﺔﻋﺎﺴﻟﺍ ﺪﺿ ﻕﺎﺒﺳ")
        EndTextCommandSetBlipName(Blip)
    end

    Citizen.Wait(0) -- init load esx

    while true do
        local sleep = 500

        for race, val in pairs(Config.RaceInformations) do
            local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), val['StartRace']['x'], val['StartRace']['y'], val['StartRace']['z'], true)

            if distance < Config.DrawDistance then
                sleep = 5

				if (val['type'] ~= -1) then
					DrawMarker(val['type'], val['StartRace']['x'], val['StartRace']['y'], val['StartRace']['z'], 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, Config.Opacity, false, true, 2, Config.Rotate, false, false, false)		
				end

                if distance < 1.5 then
					AddTextEntry("USED_CAR", '<FONT FACE="A9eelsh">ﻕﺎﺒﺴﻟﺍ ﺢﺘﻔﻟ ~y~E~w~ ﻂﻐﺿﺍ')
					DisplayHelpTextThisFrame("USED_CAR",false )
					
                    if IsControlJustReleased(0, 38) then
                        OpenRaceMenu(race)
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end

end)

function StartRace(currentRace, race_name)
    local currentCheckPoint = 1
    local nextCheckPoint = 2
    local isRacing = true
	local checkpointDeleteVehilcleDist = 300.0
    StartTime = GetGameTimer()
	
	if currentRace == 'AirStunt-Race' then
		checkpointDeleteVehilcleDist = 650.0
	end
	
    Citizen.CreateThread(function()

        CheckPoint = CreateCheckpoint(5, Config.CheckPoints[currentRace][currentCheckPoint].x,  Config.CheckPoints[currentRace][currentCheckPoint].y,  Config.CheckPoints[currentRace][currentCheckPoint].z + 2, Config.CheckPoints[currentRace][nextCheckPoint].x, Config.CheckPoints[currentRace][nextCheckPoint].y, Config.CheckPoints[currentRace][nextCheckPoint].z, 8.0, 255, 255, 255, 100, 0)
        Blip = AddBlipForCoord(Config.CheckPoints[currentRace][currentCheckPoint].x, Config.CheckPoints[currentRace][currentCheckPoint].y, Config.CheckPoints[currentRace][currentCheckPoint].z)   
		
        while isRacing do
            Citizen.Wait(5)

            local PlayerCoords = GetEntityCoords(PlayerPedId())

            local currentTime,timeNumber = formatTimer(StartTime, GetGameTimer())
			--addon for testing
			local currentCheckPointCoord = { x = Config.CheckPoints[currentRace][currentCheckPoint].x,  y = Config.CheckPoints[currentRace][currentCheckPoint].y,  z = Config.CheckPoints[currentRace][currentCheckPoint].z}
			
            --if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.RaceInformations[currentRace]['StartPosition']['x'], Config.RaceInformations[currentRace]['StartPosition']['y'], Config.RaceInformations[currentRace]['StartPosition']['z'], true) >= 500.0 then
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), currentCheckPointCoord.x, currentCheckPointCoord.y, currentCheckPointCoord.z, true) >= checkpointDeleteVehilcleDist then
                ESX.Game.DeleteVehicle(RaceVehicle)
                ESX.ShowNotification("ﻕﺎﺒﺴﻟﺍ ﺭﺎﺴﻣ ﻦﻋ ﺍﺪﺟ ﺪﻴﻌﺑ ﺖﻧﺍ")
                DeleteCheckpoint(CheckPoint)
                RemoveBlip(Blip)
                isRacing = false
                return
            end


            if not IsPedInAnyVehicle(PlayerPedId(), false) then
                ESX.Game.DeleteVehicle(RaceVehicle)
                --ESX.ShowNotification("You left your vehicle, which canceled the race!")
                ESX.ShowNotification("ﺔﺒﻛﺮﻤﻟﺍ ﻦﻣ ﻚﺟﻭﺮﺧ ﺐﺒﺴﺑ ﻕﺎﺒﺴﻟﺍ ﺀﺎﻐﻟﺇ ﻢﺗ")
                DeleteCheckpoint(CheckPoint)
                RemoveBlip(Blip)
                isRacing = false
                return
            end

            ESX.Game.Utils.DrawText3D({x = PlayerCoords.x, y = PlayerCoords.y, z = PlayerCoords.z + 1.2}, currentCheckPoint .. ' / ' ..GetMaxCheckPoints(Config.CheckPoints, currentRace), 1.5)
            ESX.Game.Utils.DrawText3D({x = PlayerCoords.x, y = PlayerCoords.y, z = PlayerCoords.z + 1.4}, currentTime, 1.5)

            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.CheckPoints[currentRace][currentCheckPoint].x,  Config.CheckPoints[currentRace][currentCheckPoint].y,  Config.CheckPoints[currentRace][currentCheckPoint].z) < 7.5 then

                if currentCheckPoint == GetMaxCheckPoints(Config.CheckPoints, currentRace) - 1 then
                    currentCheckPoint = GetMaxCheckPoints(Config.CheckPoints, currentRace)
                    PlaySoundFrontend(-1, "RACE_PLACED", "HUD_AWARDS")
                    DeleteCheckpoint(CheckPoint)
                    RemoveBlip(Blip)
                    CheckPoint = CreateCheckpoint(9, Config.CheckPoints[currentRace][currentCheckPoint].x,  Config.CheckPoints[currentRace][currentCheckPoint].y,  Config.CheckPoints[currentRace][currentCheckPoint].z + 2, Config.CheckPoints[currentRace][nextCheckPoint].x, Config.CheckPoints[currentRace][nextCheckPoint].y, Config.CheckPoints[currentRace][nextCheckPoint].z, 8.0, 255, 255, 255, 100, 0)
                elseif currentCheckPoint == GetMaxCheckPoints(Config.CheckPoints, currentRace) then
                    PlaySoundFrontend(-1, "ScreenFlash", "WastedSounds")
                    DeleteCheckpoint(CheckPoint)
                    RemoveBlip(Blip)
                    ESX.ShowNotification("تم إنهاء السباق <font color=gold>" .. currentRace .. "</font> خلال <font color=red>" .. currentTime .. "</font> د")
                    TriggerServerEvent('esx-qalle-races:addTime', timeNumber, currentRace)
                    TriggerServerEvent('race:sendToDiscordAddRace', ESX.Math.GroupDigits(timeNumber), race_name)
					Citizen.Wait(3000)
                else
                    PlaySoundFrontend(-1, "RACE_PLACED", "HUD_AWARDS")
                    DeleteCheckpoint(CheckPoint)
                    RemoveBlip(Blip)
                    currentCheckPoint = currentCheckPoint + 1

                    nextCheckPoint = nextCheckPoint + 1
                    CheckPoint = CreateCheckpoint(5, Config.CheckPoints[currentRace][currentCheckPoint].x,  Config.CheckPoints[currentRace][currentCheckPoint].y,  Config.CheckPoints[currentRace][currentCheckPoint].z + 2, Config.CheckPoints[currentRace][nextCheckPoint].x, Config.CheckPoints[currentRace][nextCheckPoint].y, Config.CheckPoints[currentRace][nextCheckPoint].z, 8.0, 255, 255, 255, 100, 0)
                    Blip = AddBlipForCoord(Config.CheckPoints[currentRace][currentCheckPoint].x, Config.CheckPoints[currentRace][currentCheckPoint].y, Config.CheckPoints[currentRace][currentCheckPoint].z)   
                end

            end
        end
    end)
end

function StartCountdown(race, race_what)

    DoScreenFadeOut(500)

	Citizen.Wait(600)

    local raceInfo = Config.RaceInformations[race]

    local playerPed = PlayerPedId()

    if IsPedInAnyVehicle(playerPed) then

        local vehicle1  = GetVehiclePedIsUsing(PlayerPedId())

        local veh = GetEntityModel(vehicle1)

        local displayName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle1))

        local plate = GetVehicleNumberPlateText(vehicle1)

        local vehProps = ESX.Game.GetVehicleProperties(vehicle1)

        ESX.Game.SpawnVehicle(veh, raceInfo['StartPosition'], raceInfo['heading'], function(vehicle)

            DeleteVehicle(vehicle1)

            ESX.Game.SetVehicleProperties(vehicle, vehProps)

            TriggerEvent("advancedFuel:setEssence", 100, plate, displayName)

            TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)

        end)

    end

    Citizen.Wait(2000)

    DoScreenFadeIn(500)

    local countDownTimer = 4
   
    FreezeEntityPosition(GetVehiclePedIsUsing(PlayerPedId()), true)

    for i = 1, countDownTimer, 1 do

        countDownTimer = countDownTimer - 1
        
        ESX.Scaleform.ShowFreemodeMessage("Get Ready!", countDownTimer, 0.8)

    end

    FreezeEntityPosition(GetVehiclePedIsUsing(PlayerPedId()), false)

    StartRace(race, race_what)

end

function OpenRaceMenu(race)
	
	if race == 'MX-Race' then
		raceTitle = 'سباق دراجات نارية'
	elseif race == 'Jail-Race' then
		raceTitle = 'سباق السرعة حول السجن المركزي'
	elseif race == 'Dirt-Race' then
		raceTitle = 'حلبة سباق سيارات الرملي'
	elseif race == 'Chiliad-Race' then
		raceTitle = 'سباق الدراجات الجبلية'
	elseif race == 'Offroad-Sandy-Race' then
		raceTitle = 'سباق المركبات اووفرود - ساندي'
	elseif race == 'Seashark-Race' then
		raceTitle = 'سباق الجت سكي'
	elseif race == 'AirStunt-Race' then
		raceTitle = 'سباق طائرة الاستعراض'
	end	
		
	ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'racing_menu',
        {
            title    = raceTitle,
            align    = 'top-right',
            elements = {
                {label = '<span style="color:FF0E0E">بدأ السباق</span> ( ' .. Config.Price .. '<span style="color:00EE4F">$</span> رسوم)', value = 'start'},
                {label = '<span style="color:FFAE00">التحقق من نتائج السباق</span>', 					value = 'scoreboard'}
            }
        },
        function(data, menu)
            local action = data.current.value

            if action == 'start' then
                if ESX.Game.IsSpawnPointClear(Config.RaceInformations[race]['StartPosition'], 5.0) then
                    ESX.TriggerServerCallback('esx-qalle-races:getMoney', function(hasEnough)
                        if hasEnough then
                            menu.close()
                            StartCountdown(race, raceTitle)
                        else
                            --ESX.ShowNotification("ﻕﺎﺒﺳ ﺃﺪﺒﻟ ﻲﻓﺎﻛ ﻎﻠﺒﻣ ﻚﻳﺪﻟ ﺲﻴﻟ " .. race)
                            ESX.ShowNotification("لاتملك مال كافي لبدأ السباق")
                        end
                    end, Config.Price)
                else
                    ESX.ShowNotification("ﻕﺎﺒﺴﻟﺍ ﻕﻼﻄﻧﺍ ﺔﻄﻘﻧ ﺀﻼﺧﺍ ﺐﺠﻳ")
                end

            elseif action == 'scoreboard' then
                OpenScoreboard(race)
            end
        end,
    function(data, menu)
        menu.close()
    end)

end

function OpenScoreboard(race)
	
    local elem = {}
	
	if race == 'MX-Race' then
		raceTitle = 'سباق دراجات نارية'
	elseif race == 'Jail-Race' then
		raceTitle = 'سباق السرعة حول السجن المركزي'
	elseif race == 'Jail-Dirt-Race' then
		raceTitle = 'حلبة سباق سيارات الرملي'
	elseif race == 'Chiliad-Race' then
		raceTitle = 'سباق الدراجات الجبلية'
	elseif race == 'Offroad-Sandy-Race' then
		raceTitle = 'سباق المركبات اووفرود - ساندي'
	elseif race == 'Seashark-Race' then
		raceTitle = 'سباق الجت سكي'
	elseif race == 'AirStunt-Race' then
		raceTitle = 'سباق طائرة الاستعراض'
	end	
	
    ESX.TriggerServerCallback('esx-qalle-races:getScoreboard', function(Races)
		
		for i=1, #Races, 1 do
			table.insert(elem, {label = Races[i].name..' <font color=orange>'..Races[i].time..'</font> ثانية'})
        end

        ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'racing_scoreboard',
            {
                title    = 'نتائج '.. raceTitle,
                align    = 'top-right',
                elements = elem
            },
            function(data, menu)

            end,
        function(data, menu)
            menu.close()
        end)
    end, race)

end

--Counts the Config.checkpoints
function GetMaxCheckPoints(table, race)
    local checkpoints = 0

    for index, values in pairs(table[race]) do
        checkpoints = checkpoints + 1 
    end

    return checkpoints
end

function formatTimer(startTime, currTime)
    local newString = currTime - startTime
	local timeNumber = newString
    local ms = string.sub(newString, -3, -2)
    local sec = string.sub(newString, -5, -4)
    local min = string.sub(newString, -7, -6)
    newString = string.format("%s%s.%s", min, sec, ms)

    return newString, timeNumber
end

LoadModel = function(model)
    while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(10)
    end
end
