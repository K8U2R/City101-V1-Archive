local GUI = {}
GUI.Time = 0

hidehud = false
switchstate = true

--Hide/Show HUD
local interface = true
local isPaused = false

local cam = false

function openInterface()
  interface = not interface
  if not interface then -- hidden
	DisplayRadar(false)
	ESX.UI.HUD.SetDisplay(0.0)
	TriggerEvent('es:setMoneyDisplay', 0.0)
	TriggerEvent('hidehudStatus', true)
	TriggerEvent('esx_status:setDisplay', 0.0)
	hidehud = true
  elseif interface and not cam then -- shown
	--DisplayRadar(true)
	ESX.UI.HUD.SetDisplay(1.0)
	TriggerEvent('es:setMoneyDisplay', 1.0)
	TriggerEvent('hidehudStatus', false)
	--TriggerEvent('esx_status:setDisplay', 1.0)
	hidehud = false
  end
end

function forceopenInterface(force)
  interface = not interface
  if force then -- hidden
	DisplayRadar(false)
	ESX.UI.HUD.SetDisplay(0.0)
	TriggerEvent('es:setMoneyDisplay', 0.0)
	TriggerEvent('hidehudStatus', true)
	--TriggerEvent('esx_status:setDisplay', 0.0)
	hidehud = true
  elseif not force then -- shown
	--DisplayRadar(true)
	ESX.UI.HUD.SetDisplay(1.0)
	TriggerEvent('es:setMoneyDisplay', 1.0)
	TriggerEvent('hidehudStatus', false)
	--TriggerEvent('esx_status:setDisplay', 1.0)
	hidehud = false
  end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		
		--if IsPauseMenuActive() and not IsPaused or GetPlayerSwitchState() ~= 12 then
		if IsPauseMenuActive() and not IsPaused then
			IsPaused = true
			TriggerEvent('es:setMoneyDisplay', 0.0)
			ESX.UI.HUD.SetDisplay(0.0)
			switchstate = true
		elseif not IsPauseMenuActive() and IsPaused and not hidehud then
			IsPaused = false
			TriggerEvent('es:setMoneyDisplay', 1.0)
			ESX.UI.HUD.SetDisplay(1.0)
			switchstate = false
		end
	end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1)
	if hidehud then
	ESX.UI.HUD.SetDisplay(0.0)
   end
   end
end)

-- Key controls
Citizen.CreateThread(function()
	local timeHeld
	
	while true do
		Wait(1)
		if IsControlJustPressed(0,  Keys['PAGEDOWN']) and (GetGameTimer() - GUI.Time) > 300 and GetLastInputMethod(2) then
			if not cam then
				openInterface()	
			end
		end
		
		if	IsControlPressed(0, 27) and not GetLastInputMethod(2) and timeHeld > 60 then
			if not cam then
				openInterface()	
				timeHeld = 0
				
				while IsControlPressed(0, 27) do
					Wait(100)
				end
			end
		end
		
		if IsControlPressed(0, 27) then
			timeHeld = timeHeld + 1
		else
			timeHeld = 0
		end
	end
end)

RegisterNetEvent("esx_misc:hidehud")
AddEventHandler("esx_misc:hidehud", function(status)
	cam = status
	forceopenInterface(status)
end)
