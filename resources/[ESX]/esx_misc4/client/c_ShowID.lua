local value = true

Citizen.CreateThread(function()
    Wait(1)
    while true do
        Citizen.Wait(1)
		local letsleep = true
        if value then
			letsleep = false
 --           miid(1.0,1.0,0.27,"~w~" .. GetPlayerServerId(NetworkGetEntityOwner(PlayerPedId())) .. " ~y~ : ﺔﻌﻃﺎﻘﻤﻟﺎﺑ ﻚﻤﻗﺭ", 255, 255, 255, 255)
            DrawText(0.235, 0.969)
        end

		if letsleep then
			Citizen.Wait(500)
		end
    end
end)

RegisterFontFile('Font')
font = RegisterFontId('A9eelsh')

function miid(width,height,scale, text, r,g,b,a, outline)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
	SetTextColour( 0,0,0, 255 )
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
	SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
   -- DrawText(0.23, 0.97)
end

AddEventHandler('ShowID:trueORfalse', function(value2)
    if value2 == true then
        value = true
    else
        value = false
    end
end)

-- Display Time HUD -- 

local displayTime = true
local useMilitaryTime = false

local timeAndDateString = nil
local hour
local minute

-- Display Time and Date at top right of screen -- format: | 12:13 | Wednesday | January 17, 2017 |
Citizen.CreateThread(function()
	while true do
		Wait(1)
		local letsleep = true
        if value then
			letsleep = false
			timeAndDateString = ""
			
			if displayTime == true then
				CalculateTimeToDisplay()
--				timeAndDateString = timeAndDateString .. " " .. hour .. ":" .. minute .. "<font face='A9eelsh'> | 101 مدينة ﺖـﻴـﻗﻮـﺗ"
			end
			
			SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.30, 0.27)
			SetTextColour(150, 150, 150, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(5, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
		--	SetTextRightJustify(true)
			--SetTextWrap(0,0.95)
			SetTextEntry("STRING")
			
			AddTextComponentString(timeAndDateString)
			DrawText(0.912, 0.49000)
		end
		if letsleep then
			Citizen.Wait(500)
		end
	end
end)

function CalculateTimeToDisplay()
	hour = GetClockHours()
	minute = GetClockMinutes()

	if useMilitaryTime == false then
		if hour == 0 or hour == 24 then
			hour = 12
		elseif hour >= 13 then
			hour = hour - 12
		end
	end

	if hour <= 9 then
		hour = "0" .. hour
	end
	if minute <= 9 then
		minute = "0" .. minute
	end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0) -- prevent crashing

        -- These natives have to be called every frame.
        SetVehicleDensityMultiplierThisFrame(0.0) -- set traffic density to 0 
        SetPedDensityMultiplierThisFrame(0.0) -- set npc/ai peds density to 0
        SetRandomVehicleDensityMultiplierThisFrame(0.0) -- set random vehicles (car scenarios / cars driving off from a parking spot etc.) to 0
        SetParkedVehicleDensityMultiplierThisFrame(0.0) -- set random parked vehicles (parked car scenarios) to 0
        SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0) -- set random npc/ai peds or scenario peds to 0
        SetGarbageTrucks(false) -- Stop garbage trucks from randomly spawning
        SetRandomBoats(false) -- Stop random boats from spawning in the water.
        SetCreateRandomCops(false) -- disable random cops walking/driving around.
        SetCreateRandomCopsNotOnScenarios(false) -- stop random cops (not in a scenario) from spawning.
        SetCreateRandomCopsOnScenarios(false) -- stop random cops (in a scenario) from spawning.
        
        local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
        ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
        RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);
    end
end)