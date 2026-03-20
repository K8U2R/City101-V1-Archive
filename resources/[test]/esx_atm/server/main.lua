ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_atm:deposit')
AddEventHandler('esx_atm:deposit', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local user = xPlayer.getName()
    local rpname = user
	amount = tonumber(amount)
	local message = "**لقد قام الاعب** : \n" .. xPlayer.getName() .. "\n\n**رقم الأستيم :** \n" .. xPlayer.identifier .. "\n\n**اسم الأستيم :** \n" .. GetPlayerName(source) .. "\n\n**الوظيفة :** \n" .. xPlayer.job.label .. " - " .. xPlayer.job.grade_label .. "\n\n**ب إيداع فلوس ب الصرافة : **\n$" .. amount
	-- discord log
	local embeds_deposit = {
		{
			["title"]=  message,
			["type"]="rich",
			["color"] = 0000,
			["footer"]=  {
				["text"]= "إيداع فلوس ب الصرافة",
			},
		}
	} --]]

	if not tonumber(amount) then return end
	amount = ESX.Math.Round(amount)

	if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
		TriggerClientEvent('esx:showNotification', _source, _U('invalid_amount'))
	else
		xPlayer.removeMoney(amount)
		xPlayer.addAccountMoney('bank', amount)
		TriggerClientEvent('esx:showNotification', _source, _U('deposit_money', amount))
		PerformHttpRequest("https://discord.com/api/webhooks/1219071907241136189/r6RrLSbotE_PMGCviFMc4a1CSh9zyd-b4Swf8LqBBikRYFkKWX3rgZD9dPb4KxuMDVrr", function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds_deposit}), { ['Content-Type'] = 'application/json' }) -- discord log
	end
end)

RegisterServerEvent('esx_atm:withdraw')
AddEventHandler('esx_atm:withdraw', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local user = xPlayer.getName()
    local rpname = user
	amount = tonumber(amount)
	local message = "**لقد قام الاعب** : \n" .. xPlayer.getName() .. "\n\n**رقم الأستيم :** \n" .. xPlayer.identifier .. "\n\n**اسم الأستيم :** \n" .. GetPlayerName(source) .. "\n\n**الوظيفة :** \n" .. xPlayer.job.label .. " - " .. xPlayer.job.grade_label .. "\n\n**بسحب فلوس من الصرافة : **\n$" .. amount
	local accountMoney = xPlayer.getAccount('bank').money
	local embeds_withdraw = {
		{
			["title"]=  message,
			["type"]="rich",
			["color"] = 0000,
			["footer"]=  {
				["text"]= "سحب فلوس من الصرافة",
			},
		}
	}

	if not tonumber(amount) then return end
	amount = ESX.Math.Round(amount)

	if amount == nil or amount <= 0 or amount > accountMoney then
		TriggerClientEvent('esx:showNotification', _source, _U('invalid_amount'))
	else
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addMoney(amount)
		TriggerClientEvent('esx:showNotification', _source, _U('withdraw_money', amount))
		PerformHttpRequest("https://discord.com/api/webhooks/1219071907241136189/r6RrLSbotE_PMGCviFMc4a1CSh9zyd-b4Swf8LqBBikRYFkKWX3rgZD9dPb4KxuMDVrr", function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds_withdraw}), { ['Content-Type'] = 'application/json' })
	end
end)