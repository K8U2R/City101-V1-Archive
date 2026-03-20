
ESX  = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('cigarette', function(source)
    xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('cigarette').count > 0 then
        if xPlayer.getInventoryItem('lighter').count > 0 then
            TriggerClientEvent('esx_misc4:usecigarette', xPlayer.source)
            xPlayer.removeInventoryItem('cigarette', 1)
        else
            xPlayer.showNotification('<font color=red>تحتاج لولاعة لإشعال السيجارة</font>')
        end
    end
end)