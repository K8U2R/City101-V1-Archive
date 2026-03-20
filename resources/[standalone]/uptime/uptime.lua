Citizen.CreateThread(function()
	local uptimeMinute, uptimeHour, uptime = 0, 0, ''
	
    Citizen.Wait(1)
	uptime = string.format("%02dh %02dm", uptimeHour, uptimeMinute)
	SetConvarServerInfo('وقت أتصال السيرفر', uptime)
	
	while true do
		Citizen.Wait(1000 * 60) -- every minute
		uptimeMinute = uptimeMinute + 1

		if uptimeMinute == 60 then
			uptimeMinute = 0
			uptimeHour = uptimeHour + 1
		end

		uptime = string.format("%02dh %02dm", uptimeHour, uptimeMinute)
		--SetConvarServerInfo('Uptime', uptime)
		SetConvarServerInfo('وقت أتصال السيرفر', uptime)


		TriggerClientEvent('uptime:tick', -1, uptime)
		TriggerEvent('uptime:tick', uptime)
	end
end)

--[[ Old
Citizen.CreateThread(function()
	local uptimeMinute, uptimeHour, uptime = 0, 0, ''
    
	
	while true do
		Citizen.Wait(1000 * 60) -- every minute
		uptimeMinute = uptimeMinute + 1

		if uptimeMinute == 60 then
			uptimeMinute = 0
			uptimeHour = uptimeHour + 1
		end

		uptime = string.format("%02dh %02dm", uptimeHour, uptimeMinute)
		SetConvarServerInfo('Uptime', uptime)


		TriggerClientEvent('uptime:tick', -1, uptime)
		TriggerEvent('uptime:tick', uptime)
	end
end)
]]