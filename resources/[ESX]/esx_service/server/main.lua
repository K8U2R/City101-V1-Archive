ESX                = nil
local InService    = {}
local MaxInService = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GetInServiceCount(name)
	local count = 0

	for k,v in pairs(InService[name]) do
		if v.is_in_service == true then
			count = count + 1
		end
	end

	return count
end

exports("GetInServiceCount",GetInServiceCount)

function activateService(name, max)
	InService[name] = {}
	MaxInService[name] = max
end

activateService('police', 15)
activateService('agent', 15)
activateService('mechanic', 15)
activateService('ambulance', 15)
activateService('admin', 10)
activateService('tailor', 10)
activateService('cement', 10)
activateService('farmer', 10)
activateService('fisherman', 10)
activateService('fueler', 10)
activateService('lumberjack', 10)
activateService('miner', 10)
activateService('slaughterer', 10)
activateService('bread', 10)


RegisterNetEvent('esx_service:disableService')
AddEventHandler('esx_service:disableService', function(name)
	local _source = source
	InService[name][source] = {is_in_service = false, time = 0, id = source, nameplayer = ESX.GetPlayerFromId(_source).getName(), grade = ESX.GetPlayerFromId(_source).job.grade_label, is_leave = false, job = ESX.GetPlayerFromId(_source).job.name}
end)

ESX.RegisterServerCallback('esx_service:enableService', function(source, cb, name)

	local inServiceCount = GetInServiceCount(name)

	if inServiceCount >= MaxInService[name] then
		cb(false, MaxInService[name], inServiceCount)
	else
		InService[name][source] = {is_in_service = true, time = 0, id = source, nameplayer = ESX.GetPlayerFromId(source).getName(), grade = ESX.GetPlayerFromId(source).job.grade_label, is_leave = false, job = ESX.GetPlayerFromId(source).job.name}
		cb(true, MaxInService[name], inServiceCount)
	end
end)

ESX.RegisterServerCallback('esx_service:isInService', function(source, cb, name)
	local isInService = false

	if InService[name] ~= nil then
		if InService[name][source].is_in_service then
			isInService = true
		end
	else
		print(('[esx_service] [^3WARNING^7] A service "%s" is not activated'):format(name))
	end

	cb(isInService)
end)

AddEventHandler("esx_service:police", function(cb)
	local xPlayers = ESX.GetPlayers()
	local list = {}
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer then
			if xPlayer.job.name == "police" then
				if InService["police"] then
					if InService["police"][xPlayer.source] then
						table.insert(list, {in_service = true, source = xPlayer.source})
					else
						table.insert(list, {in_service = false, source = xPlayer.source})
					end
				else
					cb(0)
				end
			end
		end
	end
	cb(list)
end)

AddEventHandler("esx_service:agent", function(cb)
	local xPlayers = ESX.GetPlayers()
	local list = {}
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer then
			if xPlayer.job.name == "agent" then
				if InService["agent"] then
					if InService["agent"][xPlayer.source] then
						table.insert(list, {in_service = true, source = xPlayer.source})
					else
						table.insert(list, {in_service = false, source = xPlayer.source})
					end
				else
					cb(0)
				end
			end
		end
	end
	cb(list)
end)

AddEventHandler("esx_service:mechanic", function(cb)
	local xPlayers = ESX.GetPlayers()
	local list = {}
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer then
			if xPlayer.job.name == "mechanic" then
				if InService["mechanic"] then
					if InService["mechanic"][xPlayer.source] then
						table.insert(list, {in_service = true, source = xPlayer.source})
					else
						table.insert(list, {in_service = false, source = xPlayer.source})
					end
				else
					cb(0)
				end
			end
		end
	end
	cb(list)
end)

AddEventHandler("esx_service:ambulance", function(cb)
	local xPlayers = ESX.GetPlayers()
	local list = {}
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer then
			if xPlayer.job.name == "ambulance" then
				if InService["ambulance"] then
					if InService["ambulance"][xPlayer.source] then
						table.insert(list, {in_service = true, source = xPlayer.source})
					else
						table.insert(list, {in_service = false, source = xPlayer.source})
					end
				else
					cb(0)
				end
			end
		end
	end
	cb(list)
end)

AddEventHandler("esx_service:farmer", function(cb)
	local xPlayers = ESX.GetPlayers()
	local list = {}
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer then
			if xPlayer.job.name == "farmer" then
				if InService["farmer"] then
					if InService["farmer"][xPlayer.source] then
						table.insert(list, {in_service = true, source = xPlayer.source})
					else
						table.insert(list, {in_service = false, source = xPlayer.source})
					end
				else
					cb(0)
				end
			end
		end
	end
	cb(list)
end)

AddEventHandler("esx_service:fisherman", function(cb)
	local xPlayers = ESX.GetPlayers()
	local list = {}
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer then
			if xPlayer.job.name == "fisherman" then
				if InService["fisherman"] then
					if InService["fisherman"][xPlayer.source] then
						table.insert(list, {in_service = true, source = xPlayer.source})
					else
						table.insert(list, {in_service = false, source = xPlayer.source})
					end
				else
					cb(0)
				end
			end
		end
	end
	cb(list)
end)

AddEventHandler("esx_service:fueler", function(cb)
	local xPlayers = ESX.GetPlayers()
	local list = {}
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer then
			if xPlayer.job.name == "fueler" then
				if InService["fueler"] then
					if InService["fueler"][xPlayer.source] then
						table.insert(list, {in_service = true, source = xPlayer.source})
					else
						table.insert(list, {in_service = false, source = xPlayer.source})
					end
				else
					cb(0)
				end
			end
		end
	end
	cb(list)
end)

AddEventHandler("esx_service:lumberjack", function(cb)
	local xPlayers = ESX.GetPlayers()
	local list = {}
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer then
			if xPlayer.job.name == "lumberjack" then
				if InService["lumberjack"] then
					if InService["lumberjack"][xPlayer.source] then
						table.insert(list, {in_service = true, source = xPlayer.source})
					else
						table.insert(list, {in_service = false, source = xPlayer.source})
					end
				else
					cb(0)
				end
			end
		end
	end
	cb(list)
end)

AddEventHandler("esx_service:miner", function(cb)
	local xPlayers = ESX.GetPlayers()
	local list = {}
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer then
			if xPlayer.job.name == "miner" then
				if InService["miner"] then
					if InService["miner"][xPlayer.source] then
						table.insert(list, {in_service = true, source = xPlayer.source})
					else
						table.insert(list, {in_service = false, source = xPlayer.source})
					end
				else
					cb(0)
				end
			end
		end
	end
	cb(list)
end)

AddEventHandler("esx_service:reporter", function(cb)
	local xPlayers = ESX.GetPlayers()
	local list = {}
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer then
			if xPlayer.job.name == "reporter" then
				if InService["reporter"] then
					if InService["reporter"][xPlayer.source] then
						table.insert(list, {in_service = true, source = xPlayer.source})
					else
						table.insert(list, {in_service = false, source = xPlayer.source})
					end
				else
					cb(0)
				end
			end
		end
	end
	cb(list)
end)

AddEventHandler("esx_service:slaughterer", function(cb)
	local xPlayers = ESX.GetPlayers()
	local list = {}
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer then
			if xPlayer.job.name == "slaughterer" then
				if InService["slaughterer"] then
					if InService["slaughterer"][xPlayer.source] then
						table.insert(list, {in_service = true, source = xPlayer.source})
					else
						table.insert(list, {in_service = false, source = xPlayer.source})
					end
				else
					cb(0)
				end
			end
		end
	end
	cb(list)
end)

AddEventHandler("esx_service:tailor", function(cb)
	local xPlayers = ESX.GetPlayers()
	local list = {}
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer then
			if xPlayer.job.name == "tailor" then
				if InService["tailor"] then
					if InService["tailor"][xPlayer.source] then
						table.insert(list, {in_service = true, source = xPlayer.source})
					else
						table.insert(list, {in_service = false, source = xPlayer.source})
					end
				else
					cb(0)
				end
			end
		end
	end
	cb(list)
end)

AddEventHandler("esx_service:taxi", function(cb)
	local xPlayers = ESX.GetPlayers()
	local list = {}
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer then
			if xPlayer.job.name == "taxi" then
				if InService["taxi"] then
					if InService["taxi"][xPlayer.source] then
						table.insert(list, {in_service = true, source = xPlayer.source})
					else
						table.insert(list, {in_service = false, source = xPlayer.source})
					end
				else
					cb(0)
				end
			end
		end
	end
	cb(list)
end)

ESX.RegisterServerCallback('esx_service:isPlayerInService', function(source, cb, name, target)
	local isPlayerInService = false
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if InService[name][targetXPlayer.source].is_in_service then
		isPlayerInService = true
	end

	cb(isPlayerInService)
end)

ESX.RegisterServerCallback('esx_service:getInServiceList', function(source, cb, name)
	cb(InService[name])
end)

ESX.RegisterServerCallback('esx_service:getInServiceListFromID', function(source, cb, name, ID)
	cb(InService[name])
end)


AddEventHandler('playerDropped', function()
	local _source = source
		
	for k,v in pairs(InService) do
		if v[_source] then
			if v[_source].is_in_service == true then
				v[_source] = {is_in_service = false, time = 0, id = source, nameplayer = ESX.GetPlayerFromId(_source).getName(), grade = ESX.GetPlayerFromId(_source).job.grade_label, is_leave = true, job = ESX.GetPlayerFromId(_source).job.name}
			end
		end
	end
end)

RegisterNetEvent('esx_service:notifyAllInServiceLeave')
AddEventHandler('esx_service:notifyAllInServiceLeave', function(job)
	local _source = source
		
	for k,v in pairs(InService) do
		if v[_source] then
			v[_source] = {is_in_service = false, time = 0, id = source, nameplayer = ESX.GetPlayerFromId(_source).getName(), grade = ESX.GetPlayerFromId(_source).job.grade_label, is_leave = false, job = ESX.GetPlayerFromId(_source).job.name}
		end
	end

	if InService[job.name] then

		if InService[job.name][_source] then

			InService[job.name][_source] = {is_in_service = false, time = 0, id = source, nameplayer = ESX.GetPlayerFromId(_source).getName(), grade = ESX.GetPlayerFromId(_source).job.grade_label, is_leave = false, job = ESX.GetPlayerFromId(_source).job.name}

		elseif not InService[job.name][_source] then

			InService[job.name][_source] = {}

			InService[job.name][_source] = {is_in_service = false, time = 0, id = source, nameplayer = ESX.GetPlayerFromId(_source).getName(), grade = ESX.GetPlayerFromId(_source).job.grade_label, is_leave = false, job = ESX.GetPlayerFromId(_source).job.name}

		end

	end

end)

RegisterNetEvent("esx_service:UpdateTimer")
AddEventHandler("esx_service:UpdateTimer", function(job, time_new)

	if InService[job][source] then

		InService[job][source].time = time_new

	end

end)