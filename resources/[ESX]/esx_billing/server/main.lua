ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--[[
RegisterServerEvent('esx_billing:sendBill')
AddEventHandler('esx_billing:sendBill', function(playerId, sharedAccountName, label, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(playerId)
	amount = ESX.Math.Round(amount)

	if amount > 0 and xTarget then
		TriggerEvent('esx_addonaccount:getSharedAccount', sharedAccountName, function(account)
			if account then
				MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)', {
					['@identifier'] = xTarget.identifier,
					['@sender'] = xPlayer.identifier,
					['@target_type'] = 'society',
					['@target'] = sharedAccountName,
					['@label'] = label,
					['@amount'] = amount
				}, function(rowsChanged)
					xTarget.ShowNotification(_U('received_invoice'))
				end)
			else
				MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)', {
					['@identifier'] = xTarget.identifier,
					['@sender'] = xPlayer.identifier,
					['@target_type'] = 'player',
					['@target'] = xPlayer.identifier,
					['@label'] = label,
					['@amount'] = amount
				}, function(rowsChanged)
					xTarget.ShowNotification(_U('received_invoice'))
				end)
			end
		end)
	end
end)
--]]

function SendToDiscord (name, title, message, color)
	local DiscordWebHook = "https://discord.com/api/webhooks/1219051406556794940/nGJ7bbjdmWLaKwwTFT0XW8KlPpcA0yyLw4o0fcVhy8DOm5DCVw_dwrNKIfFk_y3q6Dhl"
	
	local embeds = {
		{
			["title"]=title,
			["type"]="rich",
            ["description"] = message,
			["color"] =color,
			["footer"]=  { ["text"]= "المخالفات", 
            ["icon_url"] = "https://probot.media/X3kaJPpSj7.png"},
		}
	}
	
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('esx_billing:sendKBill_28vn2')
AddEventHandler('esx_billing:sendKBill_28vn2', function(pas, playerId, sharedAccountName, label, amount)
	local counter_bil = 0
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(playerId)
	local ids = ExtractIdentifiers(source)
	local ids2 = ExtractIdentifiers(playerId)
	_steamID ="**Steam ID:  ** " ..ids.steam..""
	_discordID ="**Discord ID:  ** <@" ..ids.discord:gsub("discord:", "")..">"
	_steamID2 ="**Steam ID:  ** " ..ids2.steam..""
	_discordID2 ="**Discord ID:  ** <@" ..ids2.discord:gsub("discord:", "")..">"
	amount = ESX.Math.Round(amount)
    if pas == 'a82mKba0bma2' then
		if amount > 0 and xTarget then
			MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)', {
				['@identifier'] = xTarget.identifier,
				['@sender'] = xPlayer.identifier,
				['@target_type'] = 'society',
				['@target'] = sharedAccountName,
				['@label'] = label,
				['@amount'] = amount
			}, function(rowsChanged)
				--xTarget.ShowNotification(_U('received_invoice'))
			end)
			SendToDiscord(('إعطاء مخالفة'), 'أعطاء مخالفة', 'قام '..xPlayer.getName()..'\n'..xPlayer.identifier..'\n'.._steamID..'\n'.._discordID..'\nبإعطاء: '..xTarget.getName()..'\n'..xTarget.identifier..'\n'.._steamID2..'\n'.._discordID2..'\n مخالفة بقيمة: '..amount..'\nأسم المخالفة: '..label..'', '15105570')
			xTarget.showNotification('وصلك الآن <font color=red>فاتورة او مخالفة')
		end
	end
end)

RegisterNetEvent('esx_billing:sendBilllog')
AddEventHandler('esx_billing:sendBilllog', function(playerId, sharedAccountName, label, amount, ticket2)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(playerId)
	amount = ESX.Math.Round(amount)
	local ticket = 0

	if ticket2 then
		ticket = os.time()
	end

	if amount > 0 and xTarget then
		TriggerEvent('esx_addonaccount:getSharedAccount', sharedAccountName, function(account)
			if account then
				MySQL.Async.execute('INSERT INTO billinglog (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)', {
					['@identifier'] = xTarget.identifier,
					['@sender'] = xPlayer.identifier,
					['@target_type'] = 'society',
					['@target'] = sharedAccountName,
					['@label'] = label,
					['@amount'] = amount
				}, function(rowsChanged)
					--xTarget.showNotification(_U('received_invoice'))
				end)
			else
				MySQL.Async.execute('INSERT INTO billinglog (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)', {
					['@identifier'] = xTarget.identifier,
					['@sender'] = xPlayer.identifier,
					['@target_type'] = 'player',
					['@target'] = xPlayer.identifier,
					['@label'] = label,
					['@amount'] = amount
				}, function(rowsChanged)
					--xTarget.showNotification(_U('received_invoice'))
				end)
			end
			xTarget.showNotification(_U('received_invoice'))
		end)
	end
end)

RegisterNetEvent('esx_billing:sendAntharlog')
AddEventHandler('esx_billing:sendAntharlog', function(playerId, sharedAccountName, label)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(playerId)

	if xTarget then
		TriggerEvent('esx_addonaccount:getSharedAccount', sharedAccountName, function(account)
			if account then
				MySQL.Async.execute('INSERT INTO antharat_admin (identifier, sender, target_type, target, label) VALUES (@identifier, @sender, @target_type, @target, @label)', {
					['@identifier'] = xTarget.identifier,
					['@sender'] = xPlayer.identifier,
					['@target_type'] = 'society',
					['@target'] = sharedAccountName,
					['@label'] = label,
				}, function(rowsChanged)
					TriggerClientEvent("esx_misc:controlSystemScaleform_anthar", xTarget.source)
					TriggerClientEvent('chatMessage', -1, " ⭐ الرقابة و التفتيش   " ,  {198, 40, 40} ,  "إعطاء انذار الى الاعب ^3" .. xTarget.name .. " ^0السبب : ^3" .. label)
				end)
			else
				MySQL.Async.execute('INSERT INTO antharat_admin (identifier, sender, target_type, target, label) VALUES (@identifier, @sender, @target_type, @target, @label)', {
					['@identifier'] = xTarget.identifier,
					['@sender'] = xPlayer.identifier,
					['@target_type'] = 'player',
					['@target'] = xPlayer.identifier,
					['@label'] = label,
				}, function(rowsChanged)
					TriggerClientEvent("esx_misc:controlSystemScaleform_anthar", xTarget.source)
					TriggerClientEvent('chatMessage', -1, " ⭐ الرقابة و التفتيش   " ,  {198, 40, 40} ,  "إعطاء انذار الى الاعب ^3" .. xTarget.name .. " السبب : ^3" .. label)
				end)
			end
		end)
	end
end)

RegisterNetEvent('esx_billing:sendBillfromAdmin')
AddEventHandler('esx_billing:sendBillfromAdmin', function(playerId, sharedAccountName, label, almrh, amount, ticket2)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(playerId)
	amount = ESX.Math.Round(amount)
	local ticket = 0
	if ticket2 then
		ticket = os.time()
	end
	if almrh == 0 then
		label = label
	end
	if almrh == 10 or almrh == 20 or almrh == 30 then
		label = 'قيادة غير واقعية'
	end
	if almrh == 11 or almrh == 21 or almrh == 31 then
		label = 'عدم الألتزام ب طابور الميناء'
	end
	if almrh == 12 or almrh == 22 or almrh == 32 then
		label = 'حمل ادوات عمل في الحقيبة'
	end
	if almrh == 13 or almrh == 23 or almrh == 33 then
		label = 'الهروب بعد سرقة البقالة بدون تفاوض'
	end
	if almrh == 14 or almrh == 24 or almrh == 34 then
		label = 'الاعتداء على المسعف'
	end
	if almrh == 15 or almrh == 25 or almrh == 35 then
		label = 'الاعتداء على الميكانيكي'
	end
	if amount > 0 and xTarget then
		TriggerEvent('esx_addonaccount:getSharedAccount', sharedAccountName, function(account)
			if account then
				MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)', {
					['@identifier'] = xTarget.identifier,
					['@sender'] = xPlayer.identifier,
					['@target_type'] = 'society',
					['@target'] = sharedAccountName,
					['@label'] = label,
					['@amount'] = amount,
				}, function(rowsChanged)
					TriggerClientEvent("esx_misc:controlSystemScaleform_ghramh", xTarget.source, amount)
					TriggerClientEvent('chatMessage', -1, " ⭐ الرقابة و التفتيش   " ,  {198, 40, 40} ,  "إعطاء " .. amount.." غرامة مالية الى الاعب ^3" .. xTarget.name .. " ^0 السبب : " .. label)
				end)
			else
				MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)', {
					['@identifier'] = xTarget.identifier,
					['@sender'] = xPlayer.identifier,
					['@target_type'] = 'player',
					['@target'] = xPlayer.identifier,
					['@label'] = label,
					['@amount'] = amount,
				}, function(rowsChanged)
					TriggerClientEvent("esx_misc:controlSystemScaleform_ghramh", xTarget.source, amount)
					TriggerClientEvent('chatMessage', -1, " ⭐ الرقابة و التفتيش   " ,  {198, 40, 40} ,  "إعطاء " .. amount.." غرامة مالية الى الاعب ^3" .. xTarget.name .. " ^0 السبب / " .. label)
				end)
			end
		end)
	end
end)

function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = "",
        fivem = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
		elseif string.find(id, "fivem") then
            identifiers.fivem = id
        end
    end

    return identifiers
end

RegisterServerEvent('esx_billing:sendBillIdentifier')
AddEventHandler('esx_billing:sendBillIdentifier', function(playerIdentifier, sharedAccountName, label, amount, SenderIdentifier)
	local xPlayer = ESX.GetPlayerFromIdentifier(SenderIdentifier)
    local xTarget = ESX.GetPlayerFromIdentifier(playerIdentifier)
	amount = ESX.Math.Round(amount)

	if amount > 0 and xTarget then
		TriggerEvent('esx_addonaccount:getSharedAccount', sharedAccountName, function(account)
			if account then
				MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)', {
					['@identifier'] = playerIdentifier,
					['@sender'] = SenderIdentifier,
					['@target_type'] = 'society',
					['@target'] = sharedAccountName,
					['@label'] = label,
					['@amount'] = amount
				}, function(rowsChanged)
					--xTarget.ShowNotification(_U('received_invoice'))
				end)
			else
				MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)', {
					['@identifier'] = playerIdentifier,
					['@sender'] = SenderIdentifier,
					['@target_type'] = 'player',
					['@target'] = SenderIdentifier,
					['@label'] = label,
					['@amount'] = amount
				}, function(rowsChanged)
					--xTarget.ShowNotification(_U('received_invoice'))
				end)
			end
			TriggerClientEvent('esx:showNotification', xTarget.source, _U('received_invoice'))
		end)
	end
end)

RegisterServerEvent('esx_billing:sendBillFromIdentifier')
AddEventHandler('esx_billing:sendBillFromIdentifier', function(playerIdentifier, sharedAccountName, label, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	amount = ESX.Math.Round(amount)

	if amount > 0 and xTarget then
		TriggerEvent('esx_addonaccount:getSharedAccount', sharedAccountName, function(account)
			if account then
				MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)', {
					['@identifier'] = playerIdentifier,
					['@sender'] = xPlayer.identifier,
					['@target_type'] = 'society',
					['@target'] = sharedAccountName,
					['@label'] = label,
					['@amount'] = amount
				}, function(rowsChanged)
				end)
			else
				MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)', {
					['@identifier'] = xTarget.identifier,
					['@sender'] = xPlayer.identifier,
					['@target_type'] = 'player',
					['@target'] = xPlayer.identifier,
					['@label'] = label,
					['@amount'] = amount
				}, function(rowsChanged)
				end)
			end
		end)
	end
end)

ESX.RegisterServerCallback('esx_billing:getBills', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT target, label, id, amount FROM billing WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		cb(result)
	end)
end)

ESX.RegisterServerCallback('esx_billing:getTargetBills', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	if xPlayer then
		MySQL.Async.fetchAll('SELECT id, label, amount FROM billing WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(result)
			cb(result)
		end)
	else
		cb({})
	end
end)

ESX.RegisterServerCallback('esx_billing:getTargetBillsLog', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)
	if xPlayer then
		MySQL.Async.fetchAll('SELECT amount, id, label FROM billinglog WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(result)
			cb(result)
		end)
	else
		cb({})
	end
end)

ESX.RegisterServerCallback('esx_billing:getTargetBillsAntharLog', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)
	if xPlayer then
		MySQL.Async.fetchAll('SELECT id, label FROM antharat_admin WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(result)
			cb(result)
		end)
	else
		cb({})
	end
end)


ESX.RegisterServerCallback('esx_billing:payBill', function(source, cb, billId)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT sender, target_type, target, amount FROM billing WHERE id = @id', {
		['@id'] = billId
	}, function(result)
		if result[1] then
			local amount = result[1].amount
			local xTarget = ESX.GetPlayerFromIdentifier(result[1].sender)

			if xTarget then
				if xPlayer.getMoney() >= amount then
					MySQL.Async.execute('DELETE FROM billing WHERE id = @id', {
						['@id'] = billId
					}, function(rowsChanged)
						if rowsChanged == 1 then
							xPlayer.removeMoney(amount)
							xTarget.addMoney(amount)

							--xPlayer.ShowNotification(_U('paid_invoice', ESX.Math.GroupDigits(amount)))
							--xTarget.ShowNotification(_U('received_payment', ESX.Math.GroupDigits(amount)))
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('paid_invoice', ESX.Math.GroupDigits(amount)))
							TriggerClientEvent('esx:showNotification', xTarget.source, _U('received_payment', ESX.Math.GroupDigits(amount)))
						end

						cb()
					end)
				elseif xPlayer.getAccount('bank').money >= amount then
					MySQL.Async.execute('DELETE FROM billing WHERE id = @id', {
						['@id'] = billId
					}, function(rowsChanged)
						if rowsChanged == 1 then
							xPlayer.removeAccountMoney('bank', amount)
							xTarget.addAccountMoney('bank', amount)

							--xPlayer.ShowNotification(_U('paid_invoice', ESX.Math.GroupDigits(amount)))
							--xTarget.ShowNotification(_U('received_payment', ESX.Math.GroupDigits(amount)))
							
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('paid_invoice', ESX.Math.GroupDigits(amount)))
							TriggerClientEvent('esx:showNotification', xTarget.source, _U('received_payment', ESX.Math.GroupDigits(amount)))
						end

						cb()
					end)
				else
					--xTarget.ShowNotification(_U('target_no_money'))
					--xPlayer.ShowNotification(_U('no_money'))
					TriggerClientEvent('esx:showNotification', xPlayer.source, _U('target_no_money'))
					TriggerClientEvent('esx:showNotification', xTarget.source, _U('target_no_money'))
					cb()
				end
			else
				if xPlayer.getMoney() >= amount then
					MySQL.Async.execute('DELETE FROM billing WHERE id = @id', {
						['@id'] = billId
					}, function(rowsChanged)
						--print()
					end)
					MySQL.Async.fetchAll('SELECT accounts FROM users WHERE identifier = @identifier', {
						['@identifier'] = result[1].sender
					},
					function(result)
						if result[1] then
							local money_show = json.decode(result[1].accounts)
							money_show['bank'] = money_show['bank'] + amount
							money_show = json.encode(money_show)
							MySQL.Sync.execute('UPDATE users SET accounts = @accounts WHERE identifier = @identifier', {
								['@accounts'] = money_show,
								['@identifier'] = result[1].sender
							})
						end
					end)
					cb()
				elseif xPlayer.getAccount('bank').money >= amount then
					MySQL.Async.execute('DELETE FROM billing WHERE id = @id', {
						['@id'] = billId
					}, function(rowsChanged)
						--print()
					end)
					MySQL.Async.fetchAll('SELECT accounts FROM users WHERE identifier = @identifier', {
						['@identifier'] = result[1].sender
					},
					function(result)
						if result[1] then
							local money_show = json.decode(result[1].accounts)
							money_show['bank'] = money_show['bank'] + amount
							money_show = json.encode(money_show)
							MySQL.Sync.execute('UPDATE users SET accounts = @accounts WHERE identifier = @identifier', {
								['@accounts'] = money_show,
								['@identifier'] = result[1].sender
							})
						end
					end)
					cb()
				else
					--xTarget.ShowNotification(_U('target_no_money'))
					--xPlayer.ShowNotification(_U('no_money'))
					TriggerClientEvent('esx:showNotification', xPlayer.source, _U('target_no_money'))
					TriggerClientEvent('esx:showNotification', xTarget.source, _U('target_no_money'))
					cb()
				end
			end
		end
	end)
end)
