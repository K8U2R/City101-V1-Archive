-- Skrypt od strony Serwera

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx_misc:startAreszt')
AddEventHandler('esx_misc:startAreszt', function(target)
	local targetPlayer = ESX.GetPlayerFromId(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('esx_misc:aresztowany', targetPlayer.source, source, xPlayer.job.name)
	TriggerClientEvent('esx_misc:aresztuj', source, xPlayer.job.name)
end)

RegisterNetEvent('esx_misc:unhandcuff')
AddEventHandler('esx_misc:unhandcuff', function(target)
	local targetPlayer = ESX.GetPlayerFromId(target)
	
	TriggerClientEvent('esx_misc:unrestrain', targetPlayer.source, source)
	--TriggerClientEvent('esx_misc:aresztuj', source)
end)