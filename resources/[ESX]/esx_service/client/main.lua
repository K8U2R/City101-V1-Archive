ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_service:getOutService2')
AddEventHandler('esx_service:getOutService2', function(name)
	ESX.TriggerServerCallback('esx_service:getOutService', function(how_m)
		TriggerServerEvent('esx_status_jobs:setLocal', how_m.c, how_m.n)
	end, name)
end)

RegisterNetEvent('esx_service:getOutService3')
AddEventHandler('esx_service:getOutService3', function(job)
	TriggerServerEvent('esx_service:disableService', job)
end)



RegisterNetEvent('esx_service:getInService2')
AddEventHandler('esx_service:getInService2', function(name)
	ESX.TriggerServerCallback('esx_service:getInService', function(how_m)
		TriggerServerEvent('esx_status_jobs:setLocal2', how_m.c, how_m.n .. "_in")
	end, name)
end)

RegisterNetEvent('esx_service:notifyAllInService')
AddEventHandler('esx_service:notifyAllInService', function(notification, target)
	target = GetPlayerFromServerId(target)
	if target == PlayerId() then return end

	local targetPed = GetPlayerPed(target)
	local mugshot, mugshotStr = ESX.Game.GetPedMugshot(targetPed)

	ESX.ShowAdvancedNotification(notification.title, notification.subject, notification.msg, mugshotStr, notification.iconType)
	UnregisterPedheadshot(mugshot)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	TriggerServerEvent('esx_service:notifyAllInServiceLeave', job)
end)