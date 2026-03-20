ESX = nil
local is_wash = false
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_moneywash:withdraw_dakh5gyu3876ati') 
AddEventHandler('esx_moneywash:withdraw_dakh5gyu3876ati', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer then
		amount = tonumber(amount)
		local accountMoney = 0
		accountMoney = xPlayer.getAccount('black_money').money
		if amount == nil or amount <= 0 or amount > accountMoney then
			TriggerClientEvent('esx:showNotification', _source, _U('invalid_amount'))
		else
			if not is_wash then
				is_wash = true
				TriggerClientEvent('esx_moneywash:animation', _source)
				Citizen.Wait(20000)
				TriggerClientEvent('esx:showNotification', _source, _U('wash_money') .. amount .. '')
				xPlayer.removeAccountMoney('black_money', amount)
				xPlayer.addMoney(amount)
				is_wash = false
			else
				xPlayer.showNotification("الرجاء الأنتظار جاري غسيل الأموال")
			end
		end
	end
end)
