-- PARAMETERS
local brakeLightSpeedThresh = 0.25

-- Main thread
Citizen.CreateThread(function()
	while true do
        -- Loop forever and update every frame
        Citizen.Wait(0)
        
        -- Get player and vehicle player is in
        local player = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(player, false)
        local letsleep = true

        -- If player is in a vehicle and it's not moving
        if (vehicle ~= nil) and (GetEntitySpeed(vehicle) <= brakeLightSpeedThresh) then
            -- Set brake lights
            letsleep = false
            SetVehicleBrakeLights(vehicle, true)
        end

        if letsleep then
            Citizen.Wait(500)
        end
	end
end)
