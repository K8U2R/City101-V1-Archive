
--Remove Visa
RegisterNetEvent('esx_visa:KickAndRemoveVisa')
AddEventHandler('esx_visa:KickAndRemoveVisa', function(player, res)
	TriggerEvent('esx_license:removeLicense', player, 'visa')
	DropPlayer(player, 'تم سحب تأشيرتك و طردك من المقاطعة')
	local chat1 = "^1 الرقابة و التفتيش "
	local chat2 = " تم سحب تأشيرة ^3 ".. ESX.GetPlayerFromId(player).name .. "^0 السبب : ^3 " .. res
	TriggerClientEvent('chatMessage', -1, chat1, {255, 255, 255}, chat2)
end)