--get shared config
RegisterNetEvent('esx_misc3:spawned')
AddEventHandler('esx_misc3:spawned', function()
	TriggerClientEvent('esx_misc3:updateconfig', -1, Config)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_misc3:updateconfig', -1, Config)
	end
end)

exports('GetDrugsConfig', function()
	return Config.ZonesDrugs
end)