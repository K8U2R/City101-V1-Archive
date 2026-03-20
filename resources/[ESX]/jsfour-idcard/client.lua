local open = false
local jobHaveCards = {
	'admin',
	'agent',
	'police',
	'army',
	'ambulance',
	'taxi',
	'mechanic',
	'vigne',
	'taxi',
	'miner',
	'fisherman',
	'slaughterer',
	'reporter',
	'lumberjack',
	'fueler',
	'fork',
	'meat',
	'cardealer',
	'casino',
	'avocat',
	'tailor',
	'banker',
	'unemployed',
}

-- Open ID card
RegisterNetEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function(data, type)
	print(type)
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