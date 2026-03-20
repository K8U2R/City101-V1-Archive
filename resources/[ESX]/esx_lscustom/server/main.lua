ESX = nil

local Vehicles

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_lscustom:getVehicleInfos', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT owner, vehicle FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		local retrivedInfo = {plate = plate}
		if result[1] then
			local tryxPlayerIdentifier = result[1].owner
			local vehiclemodelformatted = json.decode(result[1].vehicle)
			local vehicleplate = vehiclemodelformatted.plate

			MySQL.Async.fetchAll('SELECT lastname, firstname, job FROM users WHERE identifier = @id', { ['@id'] = result[1].owner }, function(results)
			    local nameserverprint = ('%s %s'):format(results[1].firstname, results[1].lastname) 
			    retrivedInfo.owner = nameserverprint
			    retrivedInfo.identifier = tryxPlayerIdentifier
				retrivedInfo.plate = vehicleplate
			    cb(retrivedInfo)
			end)
		else
			cb(retrivedInfo)
		end
	end)
end)

RegisterServerEvent('esx_K0lscusDDDtom:buyMod') -- esx_lscustom:buyMod
AddEventHandler('esx_K0lscusDDDtom:buyMod', function(price, ownerIdentifier, modName, plate , xp, mechanicprofit)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xTarget = ESX.GetPlayerFromIdentifier(ownerIdentifier)
	price = tonumber(price)
	TotalPrice = price+(mechanicprofit)
	if xTarget then
		if TotalPrice < xTarget.getAccount("bank").money then
		   local embeds = {
		{
			["title"]= ":تعديل مركبة من قبل الميكانيكي",
			["type"]="rich",
            ["description"] = "الهوية: `"..xPlayer.getName().."`\nsteam: `"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[5].."`\n :صاحب المركبة\n الهوية: `"..xTarget.getName().."`\nsteam: `"..GetPlayerName(xTarget.source).."` | `"..GetPlayerIdentifiers(xTarget.source)[1].."` | `"..GetPlayerIdentifiers(xTarget.source)[5].."`\n لوحة المركبة: `"..plate.."`\n التعديل الذي تم تركيبه `"..modName.."`\n سعر التعديل: $`"..price.."`\n مكسب الميكانيكي: $`"..mechanicprofit.."`\n السعر كامل مجموع: $`"..TotalPrice.."` \n كسبو الاثنين: `"..xp.."` خبرة",
			["color"] = "1752220",
			["footer"]=  { ["text"]= "تعديل مركبة من قبل ميكانيكي", 
            ["icon_url"] = "https://probot.media/X3kaJPpSj7.png"},
		}
	}
			TriggerClientEvent('esx_lscustom:installMod', _source)
			TriggerClientEvent('esx:showNotification', _source, _U('purchased'))
			xTarget.removeAccountMoney('bank', TotalPrice)
			xPlayer.addAccountMoney("bank", mechanicprofit)
			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mechanic', function(account)
				account.addMoney(TotalPrice)
			end)
			TriggerEvent('SystemXplevel:updateCurrentPlayerXP', _source, 'addnoduble', xp, 'تعديل ميكانيكي')
			TriggerEvent('SystemXplevel:updateCurrentPlayerXP', xTarget.source, 'addnoduble', xp, 'تعديل ميكانيكي')
			TriggerClientEvent('pNotify:SendNotification', _source, {
				text = '<center><b style="color:orange;font-size:20px;"> ملخص تعديل : <br /><br /><b style="color:white;font-size:20px;"> رقم اللوحة : ' ..plate..'<br /><br /><b style="color:#fff;font-size:20px;"> أجور التركيب : ' ..'<b style="color:orange;font-size:18px;">$<b style="color:white;font-size:20px;">'..mechanicprofit..'<br /><br /><b style="color:white;font-size:20px;"> لقد كسبت : ' ..xp..'<b style="color:#2ACAEA;font-size:20px;"> خبرة', 
				type = "info", 
				timeout = 15000, 
				layout = "centerLeft"})	
			TriggerClientEvent('pNotify:SendNotification', xTarget.source, {
				text = '<center><b style="color:#fff;font-size:20px;"> إسم الميكانيكي : <br /><br />'..'<center><b style="color:#818181;font-size:18px;">'..xPlayer.getName() ..'<br /><br /><b style="color:#fff;font-size:20px;"> فاتورة : ' ..' تعديل '..modName..'<br /><br /><b style="color:#fff;font-size:20px;"> أجور التركيب : <br /><br />' ..'<b style="color:orange;font-size:18px;">$<b style="color:white;font-size:20px;">'..mechanicprofit ..'<br /><br /><b style="color:white;font-size:20px;"> رقم اللوحة :<br /><br />' ..plate..'<br /><br /><b style="color:white;font-size:20px;"> لقد كسبت : ' ..xp..'<b style="color:#2ACAEA;font-size:20px;"> خبرة', 
				type = "info", 
				timeout = 15000, 
				layout = "centerLeft"})	
		PerformHttpRequest("https://discord.com/api/webhooks/1219051852172099725/baoYZpesT-wTXNHD3ckJ9qpux7MkGTuZtq2JwLZwNUdrZaRQSzJiukQ3G0DeqInCBPrE", function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
		else
			TriggerClientEvent('esx_lscustom:cancelInstallMod', _source)
			TriggerClientEvent('esx:showNotification', xTarget.source, _U('not_enough_money'))
			TriggerClientEvent('esx:showNotification', _source, _U('not_enough_moneyclient'))
		end
	else
	TriggerClientEvent('esx_lscustom:cancelInstallMod', _source)
	TriggerClientEvent('esx:showNotification', _source, 'ملك المركبة غير موجود')
	end
end)

RegisterServerEvent('esx_K0lscusDDDtom:refreshOwnedVehicle') -- esx_lscustom:refreshOwnedVehicle
AddEventHandler('esx_K0lscusDDDtom:refreshOwnedVehicle', function(vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT vehicle FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = vehicleProps.plate
	}, function(result)
		if result[1] then
			local vehicle = json.decode(result[1].vehicle)

			if vehicleProps.model == vehicle.model then
				MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE plate = @plate', {
					['@plate'] = vehicleProps.plate,
					['@vehicle'] = json.encode(vehicleProps)
				})
			else
				print(('esx_lscustom: %s attempted to upgrade vehicle with mismatching vehicle model!'):format(xPlayer.identifier))
			end
		end
	end)
end)

ESX.RegisterServerCallback('esx_lscustom:getVehiclesPrices', function(source, cb, plate)

		MySQL.Async.fetchAll('SELECT priceold FROM owned_vehicles WHERE plate = @plate', {
			['@plate'] = plate
		}, function(result)
			if result[1] then
			  cb(result[1].priceold)
			  
			else
				cb(50000)
			end
		end)
	
end)