local afkTimeout = 1800 -- AFK kick time limit in seconds
local timer = 0

local currentPosition  = nil
local previousPosition = nil
local currentHeading   = nil
local previousHeading  = nil

--[[]]
Citizen.CreateThread(function()
	local sleep = 1000
	while true do
	Citizen.Wait(1)
	if DoneESX then
		Citizen.Wait(sleep)

		playerPed = PlayerPedId()
		if playerPed and PlayerData.job.name ~= 'admin' then
			currentPosition = GetEntityCoords(playerPed, true)
			currentHeading  = GetEntityHeading(playerPed)
			sleep = 1000
			
			if currentPosition == previousPosition and currentHeading == previousHeading then
				if timer > 0 then
					if timer == math.ceil(afkTimeout / 4) then
						TriggerEvent('chatMessage', _U('afk'), {149, 0, 0},  _U('afk_warning', timer))
					end

					timer = timer - 1
				else
					TriggerServerEvent('esx_misc:afkkick:kickplayer', '9283ytheo8fgWGH2abykd2')
				end
			else
				timer = afkTimeout
			end

			-- (always) update variables
			previousPosition = currentPosition
			previousHeading  = currentHeading
		else
			sleep = 30000
		end
	end
	end
end)