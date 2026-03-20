ESX = nil
local timecache,collecting = {},{}

Citizen.CreateThread(function()
	TriggerEvent('esx:getSharedObjectp23Njd23byabd', function(obj) ESX = obj end)
    while ESX==nil do Wait(0) end
end)

Citizen.CreateThread(function()
	MySQL.ready(function()
		MySQL.Async.fetchAll("SELECT identifier,next_collect FROM `daily_free`",{},function(data)
			for k,v in ipairs(data) do
				timecache[v.identifier]=v.next_collect
			end
		end)
	end)
end)

function getSteamIdentifier(identifiers)
	for k,v in ipairs(identifiers) do
		if v:find("steam") then return v end
	end
	return nil
end

RegisterServerEvent("daily_reward:updateTimeout")
AddEventHandler("daily_reward:updateTimeout", function()
	local _source = source
	local identifier = getSteamIdentifier(GetPlayerIdentifiers(_source))
	if not identifier then return end
	local now = os.time()
	if timecache[identifier] then
		TriggerClientEvent("daily_reward:setTimeout", _source, timecache[identifier])
	else
		MySQL.Async.fetchAll('SELECT `next_collect` FROM `daily_free` WHERE `identifier`=@identifier;', {['@identifier'] = identifier}, function(collect)
			if collect[1] then
				TriggerClientEvent("daily_reward:setTimeout", _source, collect[1].next_collect)
				timecache[identifier] = collect[1].next_collect
			else
				TriggerClientEvent("daily_reward:setTimeout", _source, 0)
				timecache[identifier] = 0
			end
		end)
	end
end)

function giveItem(it,xPlayer)
	if not it or not xPlayer then return end
	if it.type==1 and it.value then
		xPlayer.addMoney(it.value)
	elseif it.type==2 and it.item and it.count then
		xPlayer.addInventoryItem(it.item,it.count)
	elseif it.type==3 and it.weapon and it.ammo then
		TriggerClientEvent("daily_reward:giveWpn",xPlayer.source,it.weapon,it.ammo)
	end
end

function claimRewards(xPlayer)
	if Config.random_rewards_enabled then
		local weighedlist = {}
		for k,v in ipairs(Config.random_rewards) do
			local chance = v.chance; v.chance = nil
			for i=1,chance do
				table.insert(weighedlist,v)
			end
		end
		for k,v in ipairs(weighedlist[math.random(0,#weighedlist)]) do
			giveItem(v,xPlayer)
		end
	else
		for k,v in ipairs(Config.rewards) do
			giveItem(v,xPlayer)
		end
	end
end

RegisterServerEvent("daily_reward:collect")
AddEventHandler("daily_reward:collect", function(t)
	local _source = source
	if collecting[_source] then return end
	collecting[_source]=true -- small cache, this fixes dupe bug
	local xPlayer = ESX.GetPlayerFromId(_source)
	local identifier = xPlayer.identifier
	local now = os.time()
	local nextcollect = os.time() + 86399
	if timecache[identifier] then -- if the time is cached just check that first to make things faster
		if timecache[identifier] > now then
			TriggerClientEvent("daily_reward:setTimeout", _source, timecache[identifier])
			TriggerClientEvent("chat:addMessage", _source, {color={255,0,0}, multiline=false, args={"Daily daily_reward", "It's still not time..."}})
			collecting[_source]=nil
			return
		end
	end
	MySQL.Async.fetchAll('SELECT * FROM `daily_free` WHERE `identifier`=@identifier;', {['@identifier'] = identifier}, function(collect)
		if collect[1] then
			if collect[1].next_collect < now then
				claimRewards(xPlayer)
				TriggerClientEvent("esx:showNotification",_source,Config.claimed)
				TriggerClientEvent("daily_reward:toggleFreeMenu", _source, false)
				MySQL.Async.execute('UPDATE `daily_free` SET `next_collect`=@nextcollect,`times_collected`=@timescollected WHERE `identifier`=@identifier', {["@identifier"] = identifier, ["@nextcollect"] = nextcollect, ["@timescollected"] = collect[1].times_collected+1}, nil)
				TriggerClientEvent("daily_reward:setTimeout", _source, nextcollect)
			else
				TriggerClientEvent("daily_reward:setTimeout", _source, collect[1].next_collect)
				--TriggerClientEvent("chat:addMessage", _source, {color={255,0,0}, multiline=false, args={"Daily daily_reward", "It's still not time..."}})
				TriggerClientEvent("esx:showNotification",_source, 'لم يمر يوم منذ أخر أستلام للمكافأة اليومية')
			end
		else
			claimRewards(xPlayer)
			TriggerClientEvent("esx:showNotification",_source,Config.claimed)
			TriggerClientEvent("daily_reward:setTimeout", _source, nextcollect)
			TriggerClientEvent("daily_reward:toggleFreeMenu", _source, false)
			MySQL.Async.execute('INSERT INTO `daily_free` (`identifier`, `next_collect`, `times_collected`) VALUES (@identifier, @nextcollect, 1);', {['@identifier'] = identifier, ['@nextcollect'] = nextcollect}, nil)
		end
	end)
	collecting[_source]=nil
end)