ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


-- FiveM Heli Cam by mraes
-- Version 1.3 2017-06-12

RegisterNetEvent('heli:spotlight')
AddEventHandler('heli:spotlight', function(state)
	local serverID = source
	TriggerClientEvent('heli:spotlight', -1, serverID, state)
end)