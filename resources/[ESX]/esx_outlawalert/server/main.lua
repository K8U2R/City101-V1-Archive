ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_wesam:goTolistShotFire')
AddEventHandler('esx_wesam:goTolistShotFire', function()
	TriggerClientEvent('esx_wesam:goTolistShotFireClient', source)
end)

RegisterServerEvent('esx_outlawalert:carJackInProgress')
AddEventHandler('esx_outlawalert:carJackInProgress', function(targetCoords, streetName, vehicleLabel, playerGender)
	if playerGender == 0 then
		playerGender = 'ذكر'
	else
		playerGender = 'أنثى'
	end

	TriggerClientEvent('esx_outlawalert:outlawNotify12', -1, _U('carjack', playerGender, vehicleLabel, streetName))
	TriggerClientEvent('esx_outlawalert:carJackInProgress', -1, targetCoords)
end)

RegisterServerEvent('esx_outlawalert:combatInProgress')
AddEventHandler('esx_outlawalert:combatInProgress', function(targetCoords, streetName, playerGender)
	if playerGender == 0 then
		playerGender = 'ذكر'
	else
		playerGender = 'أنثى'
	end

	TriggerClientEvent('esx_outlawalert:outlawNotify12', -1, _U('combat', playerGender, streetName))
	TriggerClientEvent('esx_outlawalert:combatInProgress', -1, targetCoords)
end)

RegisterServerEvent('esx_outlawalert:gunshotInProgress2')
AddEventHandler('esx_outlawalert:gunshotInProgress2', function(targetCoords, streetName, playerGender, id_player)
	local xPlayer = ESX.GetPlayerFromId(id_player)
	local info_player = {name_player = xPlayer.getName(), iden_player = xPlayer.identifier, playerid = xPlayer.source, job = xPlayer.job.name, grade_job = xPlayer.job.grade_label, steam = GetPlayerName(xPlayer.source)}
	if playerGender == 0 then
		playerGender = 'ذكر'
	else
		playerGender = 'أنثى'
	end

	TriggerClientEvent('esx_outlawalert:outlawNotify12', -1, 'بلاغ اطلاق نار',playerGender,streetName,'خطر',info_player, targetCoords)
	TriggerClientEvent('esx_outlawalert:gunshotInProgress2', -1, targetCoords)
end)

ESX.RegisterServerCallback('esx_outlawalert:isVehicleOwner', function(source, cb, plate)
	local identifier = GetPlayerIdentifier(source, 0)

	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
		['@owner'] = identifier,
		['@plate'] = plate
	}, function(result)
		if result[1] then
			cb(result[1].owner == identifier)
		else
			cb(false)
		end
	end)
end)
