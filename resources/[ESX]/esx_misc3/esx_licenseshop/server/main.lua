ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_licenseshop:loadLicenses', source, licenses)
	end)
end)

function LoadLicenses(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_licenseshop:loadLicenses', source, licenses)
	end)
end

RegisterNetEvent('esx_licenseshop:ServerLoadLicenses')
AddEventHandler('esx_licenseshop:ServerLoadLicenses', function()
	local _source = source
	LoadLicenses(_source)
end)

-- Buy Aircraft License
RegisterNetEvent('esx_licenseshop:buyLicenseAircraft')
AddEventHandler('esx_licenseshop:buyLicenseAircraft', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local price = Config.Prices_esx_licenseshop.Aircraft

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)

		TriggerEvent('esx_license:addLicense', _source, 'drive_aircraft', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy Boating License
RegisterNetEvent('esx_licenseshop:buyLicenseBoating')
AddEventHandler('esx_licenseshop:buyLicenseBoating', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local price = Config.Prices_esx_licenseshop.Boating

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)

		TriggerEvent('esx_license:addLicense', _source, 'drive_boat', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy Melee License
RegisterNetEvent('esx_licenseshop:buyLicenseMelee')
AddEventHandler('esx_licenseshop:buyLicenseMelee', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local price = Config.Prices_esx_licenseshop.Melee

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)

		TriggerEvent('esx_license:addLicense', _source, 'weapon_melee', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy Handgun License
RegisterNetEvent('esx_licenseshop:buyLicenseHandgun')
AddEventHandler('esx_licenseshop:buyLicenseHandgun', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local price = Config.Prices_esx_licenseshop.Handgun

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)

		TriggerEvent('esx_license:addLicense', _source, 'weapon_handgun', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy SMG License
RegisterNetEvent('esx_licenseshop:buyLicenseSMG')
AddEventHandler('esx_licenseshop:buyLicenseSMG', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local price = Config.Prices_esx_licenseshop.SMG

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)

		TriggerEvent('esx_license:addLicense', _source, 'weapon_smg', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy Shotgun License
RegisterNetEvent('esx_licenseshop:buyLicenseShotgun')
AddEventHandler('esx_licenseshop:buyLicenseShotgun', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local price = Config.Prices_esx_licenseshop.Shotgun

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)

		TriggerEvent('esx_license:addLicense', _source, 'weapon_shotgun', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy Assault License
RegisterNetEvent('esx_licenseshop:buyLicenseAssault')
AddEventHandler('esx_licenseshop:buyLicenseAssault', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local price = Config.Prices_esx_licenseshop.Assault

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)

		TriggerEvent('esx_license:addLicense', _source, 'weapon_assault', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy LMG License
RegisterNetEvent('esx_licenseshop:buyLicenseLMG')
AddEventHandler('esx_licenseshop:buyLicenseLMG', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local price = Config.Prices_esx_licenseshop.LMG

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)

		TriggerEvent('esx_license:addLicense', _source, 'weapon_lmg', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy Sniper License
RegisterNetEvent('esx_licenseshop:buyLicenseSniper')
AddEventHandler('esx_licenseshop:buyLicenseSniper', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local price = Config.Prices_esx_licenseshop.Sniper

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)

		TriggerEvent('esx_license:addLicense', _source, 'weapon_sniper', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy Commercial License
RegisterNetEvent('esx_licenseshop:buyLicenseCommercial')
AddEventHandler('esx_licenseshop:buyLicenseCommercial', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local price = Config.Prices_esx_licenseshop.Commercial

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)

		TriggerEvent('esx_license:addLicense', _source, 'drive_truck', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy Drivers License
RegisterNetEvent('esx_licenseshop:buyLicenseDrivers')
AddEventHandler('esx_licenseshop:buyLicenseDrivers', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local price = Config.Prices_esx_licenseshop.Drivers

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)

		TriggerEvent('esx_license:addLicense', _source, 'drive', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy Drivers Permit
RegisterNetEvent('esx_licenseshop:buyLicenseDriversP')
AddEventHandler('esx_licenseshop:buyLicenseDriversP', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local price = Config.Prices_esx_licenseshop.DriversP

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)

		TriggerEvent('esx_license:addLicense', _source, 'dmv', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy Motorcyle License
RegisterNetEvent('esx_licenseshop:buyLicenseMotorcyle')
AddEventHandler('esx_licenseshop:buyLicenseMotorcyle', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local price = Config.Prices_esx_licenseshop.Motorcycle

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)

		TriggerEvent('esx_license:addLicense', _source, 'drive_bike', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy Weed License
RegisterNetEvent('esx_licenseshop:buyLicenseWeed')
AddEventHandler('esx_licenseshop:buyLicenseWeed', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local price = Config.Prices_esx_licenseshop.Weed

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)

		TriggerEvent('esx_license:addLicense', _source, 'weed_processing', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy Weapon License
RegisterNetEvent('esx_licenseshop:buyLicenseWeapon')
AddEventHandler('esx_licenseshop:buyLicenseWeapon', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local price = Config.Prices_esx_licenseshop.Weapon

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)

		TriggerEvent('esx_license:addLicense', _source, 'weapon', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)
