ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_accessories:pay')
AddEventHandler('esx_accessories:pay', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeMoney(Config.Price)
	TriggerClientEvent('esx:showNotification', source, _U('you_paid', ESX.Math.GroupDigits(Config.Price)))
end)

RegisterServerEvent('esx_accessories:save')
AddEventHandler('esx_accessories:save', function(skin, accessory)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_datastore:getDataStore', 'user_' .. string.lower(accessory), xPlayer.identifier, function(store)
		store.set('has' .. accessory, true)

		local itemSkin = {}
		local item1 = string.lower(accessory) .. '_1'
		local item2 = string.lower(accessory) .. '_2'
		itemSkin[item1] = skin[item1]
		itemSkin[item2] = skin[item2]

		store.set('skin', itemSkin)
	end)
end)

ESX.RegisterServerCallback('esx_accessories:get', function(source, cb, accessory)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'user_' .. string.lower(accessory), xPlayer.identifier, function(store)
		local hasAccessory = (store.get('has' .. accessory) and store.get('has' .. accessory) or false)
		local skin = (store.get('skin') and store.get('skin') or {})

		cb(hasAccessory, skin)
	end)

end)

ESX.RegisterServerCallback('esx_accessories:checkMoney', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(xPlayer.getMoney() >= Config.Price)
end)

ESX.RegisterServerCallback('esx_misc:getSponserRoles', function(source, cb)
	local disroles = {}
	local hasRole = false
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		local result2 = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {['@identifier'] = xPlayer.identifier})
		local firstname = result2[1].firstname
		local lastname  = result2[1].lastname
		local result = MySQL.Sync.fetchAll('SELECT * FROM roa3e WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		})
		if result[1] then
			for k,v in pairs(result) do
				if result[k].name == "bronze" then 
					table.insert(disroles, {name = 'bronze', label = "🥉 بطاقة داعم برونزي"})
					hasRole = true
				elseif result[k].name == "silver" then 
					table.insert(disroles, {name = 'silver', label = "🥈 بطاقة داعم فضية"})
					hasRole = true
				elseif result[k].name == "gold" then 
					table.insert(disroles, {name = 'gold', label = "🏅 بطاقة داعم ذهبية"})
					hasRole = true
				elseif result[k].name == "plat" then 
					table.insert(disroles, {name = 'plat', label = "⚡ بطاقة داعم بلاتيني"})
					hasRole = true
				elseif result[k].name == "diamond" then 
					table.insert(disroles, {name = 'diamond', label = "💎 بطاقة داعم الماسية"})
					hasRole = true
				elseif result[k].name == "official" then 
					table.insert(disroles, {name = 'official', label = "🏆 بطاقة داعم رسمية"})
					hasRole = true
				elseif result[k].name == "strategy" then 
					table.insert(disroles, {name = 'strategy', label = "💠 بطاقة داعم استراتيجية"})
					hasRole = true
				end
			end
			cb(hasRole, disroles, {firstname = firstname, lastname = lastname})
		end
	end

end)


ESX.RegisterServerCallback('wsh:esx_accessories:checkprize', function(source, cb)
	local callback = {}
	local xPlayer = ESX.GetPlayerFromId(source)
	local result = MySQL.Sync.fetchAll('SELECT type FROM tebex WHERE id = @identifier', {
		['@identifier'] = xPlayer.identifier
	})
	if result ~= nil then 
		for k, v in pairs(result) do  
			table.inesrt(callback, v)
		end
	end
	cb(callback)
end)