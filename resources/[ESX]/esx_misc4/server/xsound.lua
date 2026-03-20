RegisterNetEvent('esx_misc:xsound:playe3dsound')
AddEventHandler('esx_misc:xsound:playe3dsound', function(type, musicId, data)
    TriggerClientEvent('esx_misc:xsound:playe3dsound', -1, type, musicId, data)
end)