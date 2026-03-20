local open = false
local jobHaveCards = {
	'admin',
	'police',
	'ambulance',
	'taxi',
	'mechanic',
	'taxi',
	'miner',
	'fisherman',
	'slaughterer',
	'reporter',
	'lumberjack',
	'fueler',
	'tailor',
	'unemployed',
	'bread'
}

-- Open ID card
RegisterNetEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function(data, type)
	if not isJobHaveCards(data.jobname) then
		data.jobname = 'idcard'
	else
		data.job = data.grade
	end
	open = true
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type
	})
end)

-- Key events
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(0, 322) and open or IsControlJustReleased(0, 177) and open then
			SendNUIMessage({
				action = "close"
			})
			open = false
		end
	end
end)

function isJobHaveCards(job)
	for k,v in pairs(jobHaveCards) do
		if v == job then
			return true
		end	
	end
end