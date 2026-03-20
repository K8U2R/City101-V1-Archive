
local currLevel = 2
local isTokovoip = true
Citizen.CreateThread(function()

	SendNUIMessage({
		action = 'voice',
		prox = 2
	})
	NetworkSetTalkerProximity(2.5)
	DisplayRadar(false)
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		local health = (GetEntityHealth(PlayerPedId()) -100)
		local armor = GetPedArmour(PlayerPedId()) 
	
		SendNUIMessage({action = "hud",
						health = health,
						armor = armor,
						thirst = thrist,
						hunger = hunger,
						})

		TriggerEvent('esx_status:getStatus', 'thirst', function(status)
			thrist = status.getPercent()
		end)
		
		TriggerEvent('esx_status:getStatus', 'hunger', function(status)
			hunger = status.getPercent()
		end)

	end
end)

AddEventHandler('HUD:trueORfalse', function(value)
	if value == true and not IsPauseMenuActive() then
		SendNUIMessage({
			action = 'showui'
		})
	else
		SendNUIMessage({
			action = 'hideui'
		})
	end
end)

--[[Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)

		if IsControlJustReleased(0, 344) then  -- "F11"
			showUi = not showUi
			if showUi then
				SendNUIMessage({
					action = 'showui'
				})
			else
				SendNUIMessage({
					action = 'hideui'
				})
			end
        end

		if isTokovoip then
			tokoVoipLevel =  exports.tokovoip_script:getPlayerData(GetPlayerServerId(PlayerId()), 'voip:mode')
			if tokoVoipLevel == 1 then
				SendNUIMessage({
					action = 'voice',
					prox = 1
				})
			elseif tokoVoipLevel == 2 then
				SendNUIMessage({
					action = 'voice',
					prox = 2
				})
			elseif tokoVoipLevel == 3 then
				SendNUIMessage({
					action = 'voice',
					prox = 0
				})
			end
		else
			if IsControlJustReleased(1, 20) then
				currLevel = (currLevel + 1) % 3
				if currLevel == 0 then
					SendNUIMessage({
						action = 'voice',
						prox = 0
					})
					vol = 26.0
					print("shout", vol)
				elseif currLevel == 1 then
					SendNUIMessage({
						action = 'voice',
						prox = 1
					})
					vol = 10.0
					print("normal", vol)
				elseif currLevel == 2 then
					SendNUIMessage({
						action = 'voice',
						prox = 2
					})
					vol = 2.5
					print("whisper", vol)
				end
				NetworkSetTalkerProximity(vol)
			end
		end
    end
end)


Citizen.CreateThread(function()
    while true do
		Citizen.Wait(200)

		if isTokovoip then
			SendNUIMessage({
				action = 'voice-color',
				isTalking = exports.tokovoip_script:getPlayerData(GetPlayerServerId(PlayerId()), 'voip:talking')
			})
		else
			if NetworkIsPlayerTalking(PlayerId()) then
				SendNUIMessage({
					action = 'voice-color',
					isTalking = 100
				})
			else
				SendNUIMessage({
					action = 'voice-color',
					isTalking = 0
				})
			end
		end
	end
end)]]




Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		local ped = PlayerPedId()
		
		if IsPedInAnyVehicle(ped, false) then
			DisplayRadar(true)
			-- local inCar = GetVehiclePedIsIn(ped, false)
			-- carSpeed = math.ceil(GetEntitySpeed(inCar) * 1.23)
			-- fuel = math.floor(GetVehicleFuelLevel(inCar)+0.0)	
			-- SendNUIMessage({
			-- 	action = 'car',
			-- 	showhud = true,
			-- 	speed = carSpeed,
			-- 	fuel = fuel,
			-- })
		else
			DisplayRadar(false)
			-- SendNUIMessage({
			-- 	action = 'car',
			-- 	showhud = false,
			-- })
		end
	end
end)


RegisterNetEvent("seatbelt:client:ToggleSeatbelt")
AddEventHandler("seatbelt:client:ToggleSeatbelt", function(toggle)
    if toggle == nil then
        seatbeltOn = not seatbeltOn
        SendNUIMessage({
            action = "seatbelt",
            seatbelt = seatbeltOn,
        })
    else
        seatbeltOn = toggle
        SendNUIMessage({
            action = "seatbelt",
            seatbelt = toggle,
        })
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- Frk👑 - np_hud
-----------------------------------------------------------------------------------------------------------------------------------------
 
 
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        disableHud()
 
        local UI = GetMinimapAnchor()
        local Breath = GetPlayerUnderwaterTimeRemaining(PlayerId()) / 6.0
           
        if IsPedSwimmingUnderWater(PlayerPedId()) and Breath >= 0.0 then
            drawRct(UI.Left_x + 0.001 , UI.Bottom_y - 0.002, (UI.Width - 0.002) * Breath , 0.009, 243, 214, 102, 200)
        end
 
    end
end)
 
 
function drawRct(x,y,Width,height,r,g,b,a)
    DrawRect(x+Width/2,y+height/2,Width,height,r,g,b,a)
end
 
function disableHud()
    HideHudComponentThisFrame(6)
    HideHudComponentThisFrame(7)   
    HideHudComponentThisFrame(8)   
    HideHudComponentThisFrame(9)
end
 
function GetMinimapAnchor()
    local safezone = GetSafeZoneSize()
    local safezone_x = 1.0 / 20.0
    local safezone_y = 1.0 / 20.0
    local aspect_ratio = GetAspectRatio(0)
    local res_x, res_y = GetActiveScreenResolution()
    local xscale = 1.0 / res_x
    local yscale = 1.0 / res_y
    local Minimap = {}
    Minimap.Width = xscale * (res_x / (4 * aspect_ratio))
    Minimap.height = yscale * (res_y / 5.674)
    Minimap.Left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.Bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.right_x = Minimap.Left_x + Minimap.Width
    Minimap.top_y = Minimap.Bottom_y - Minimap.height
    Minimap.x = Minimap.Left_x
    Minimap.y = Minimap.top_y
    Minimap.xunit = xscale
    Minimap.yunit = yscale
    return Minimap
end