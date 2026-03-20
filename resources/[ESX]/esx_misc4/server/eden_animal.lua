ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)




ESX.RegisterServerCallback('eden_animal:getPet', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT pet FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		if result[1].pet ~= nil then
			cb(result[1].pet)
		else
			cb('')
		end
	end)
end)

RegisterNetEvent('eden_animal:petDied')
AddEventHandler('eden_animal:petDied', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('UPDATE users SET pet = "(NULL)" WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	})
end)

RegisterNetEvent('eden_animal:consumePetFood')
AddEventHandler('eden_animal:consumePetFood', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('croquettes', 1)
end)

ESX.RegisterServerCallback('eden_animal:buyPet', function(source, cb, pet)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = GetPriceFromPet(pet)

	if price == 0 then
		print(('eden_animal: %s attempted to buy an invalid pet!'):format(xPlayer.identifier))
		cb(false)
	end

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)

		MySQL.Async.execute('UPDATE users SET pet = @pet WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier,
			['@pet'] = pet
		}, function(rowsChanged)
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'لقد اشتريت حيوان أليف ['..pet..'] بسعر <span style="color:green"> $'..ESX.Math.GroupDigits(price)..' </span>')
			cb(true)
		end)
	else
		TriggerClientEvent('esx:showNotification', source, '<span style="color:FF0E0E">لا تملك المال</span>')
		cb(false)
	end
end)

function GetPriceFromPet(pet)
	for i=1, #Config.PetShop, 1 do
		if Config.PetShop[i].pet == pet then
			return Config.PetShop[i].price
		end
	end

	return 0
end