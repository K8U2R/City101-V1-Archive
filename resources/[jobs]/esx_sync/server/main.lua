ESX = nil
TriggerEvent(Config.getSharedObject, function(obj) ESX = obj end)

RegisterNetEvent('esx_adminjob:getAllOnlinePlayers')
AddEventHandler('esx_adminjob:getAllOnlinePlayers', function(status)
	local Players = ESX.GetPlayers()
	for i = 1, #Players, 1 do
		local xPlayer = ESX.GetPlayerFromId(Players[i])
        if xPlayer.job.name == Config.adminjob then
            xPlayer.triggerEvent('esx:sendToPlayer', 'send_to_admin', status)
        else
			xPlayer.triggerEvent('esx:sendToPlayer', 'nothing', status)
        end
	end
end)

local sync = false
RegisterServerEvent('esx_adminjob:banHackerParmentserver')
AddEventHandler('esx_adminjob:banHackerParmentserver', function(state)
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == "admin" then
		TriggerClientEvent("esx_adminjob:banHackerParment",-1,state)
		sync = state
		if state then
			TriggerClientEvent('chatMessage', -1, " ⭐الرقابة و التفتيش   ",  {198, 40, 40} ,  "بداية ^3وقت مزامنة")
		else
			TriggerClientEvent('chatMessage', -1, " ⭐الرقابة و التفتيش   " ,  {198, 40, 40} ,  "إنتهاء ^3وقت مزامنة")
		end
	end
end)
ESX.RegisterServerCallback('esx_adminjob:syncgetvar', function(source, cb)
	cb(sync)
end)