ESX = nil
local data = LoadResourceFile(GetCurrentResourceName(), 'html/questions.js')

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
	
	TriggerClientEvent("interview:get:question", source, data)

	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_visa:loadLicenses', source, licenses)
	end)
end)

RegisterNetEvent('esx_visa:addLicense')
AddEventHandler('esx_visa:addLicense', function(type, pas)
	local _source = source
     if pas==Config.Pas then
	TriggerEvent('esx_license:addLicense', _source, type, function()
		TriggerEvent('esx_license:getLicenses', _source, function(licenses)
			TriggerClientEvent('esx_license:loadLicenses', _source, licenses)
		end)
	end)
end
end)

RegisterNetEvent('esx_visa:pay')
AddEventHandler('esx_visa:pay', function(price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeMoney(price)
	TriggerClientEvent('esx:showNotification', _source, _U('you_paid', ESX.Math.GroupDigits(price)))
end)

RegisterServerEvent('esx_visa:kickplayer')
AddEventHandler('esx_visa:kickplayer', function(pas)
    if pas==Config.Pas then
	DropPlayer(source, "لقد فشلت في إختبار الحصول على التاْشيرة بإمكانك الدخول وإعادة المحاولة \n  https://discord.gg/en1")
	end
end)

RegisterNetEvent('interview:get:question')
AddEventHandler('interview:get:question', function()
    local source = source

    TriggerClientEvent("interview:get:question", source, data)
end)