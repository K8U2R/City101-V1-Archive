ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('bread', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bread', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 500000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	--xPlayer.showpNotifyNotification(_U('used_bread'))
	TriggerClientEvent('esx:showNotification', source, _U('used_bread'))
end)

ESX.RegisterUsableItem('chocolate', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('chocolate', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 70000)
	TriggerClientEvent('esx_basicneeds:onEat', source,"prop_choc_ego")
	--xPlayer.showpNotifyNotification(_U('used_chocolate'))
	TriggerClientEvent('esx:showNotification', source, _U('used_chocolate'))
end)

ESX.RegisterUsableItem('cupcake', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('cupcake', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 90000)
	TriggerClientEvent('esx_basicneeds:onEat', source,"prop_candy_pqs")
	--xPlayer.showpNotifyNotification(_U('used_cupcake'))
	TriggerClientEvent('esx:showNotification', source, _U('used_cupcake'))
end)

ESX.RegisterUsableItem('bergrkb', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bergrkb', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 400000)
	TriggerClientEvent('esx_basicneeds:onEat', source, "prop_food_cb_tray_03")
	--xPlayer.showpNotifyNotification(_U('used_bergrkb'))
	TriggerClientEvent('esx:showNotification', source, _U('used_bergrkb'))
end)

ESX.RegisterUsableItem('batato', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('batato', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 70000)
	TriggerClientEvent('esx_basicneeds:onEat', source, "prop_food_cb_chips")
	--xPlayer.showpNotifyNotification(_U('used_batato'))
	TriggerClientEvent('esx:showNotification', source, _U('used_batato'))
end)

ESX.RegisterUsableItem('grape', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('grape', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 75000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	--xPlayer.showpNotifyNotification(_U('used_grape'))
	TriggerClientEvent('esx:showNotification', source, _U('used_grape'))
end)

ESX.RegisterUsableItem('cheps', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('cheps', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_basicneeds:onEat', source,"v_ret_ml_chips1")
	--xPlayer.showpNotifyNotification(_U('used_cheps'))
	TriggerClientEvent('esx:showNotification', source, _U('used_cheps'))
end)

ESX.RegisterUsableItem('coshe', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('coshe', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 230000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	--xPlayer.showpNotifyNotification(_U('used_coshe'))
	TriggerClientEvent('esx:showNotification', source, _U('used_coshe'))
end)

ESX.RegisterUsableItem('bergrul', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bergrul', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 250000)
	TriggerClientEvent('esx_basicneeds:onEat', source, "prop_food_cb_tray_02")
	--xPlayer.showpNotifyNotification(_U('used_bergrul'))
	TriggerClientEvent('esx:showNotification', source, _U('used_bergrul'))
end)

ESX.RegisterUsableItem('cocacola', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('cocacola', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('consumables:client:Drink', source, "prop_ecola_can")
	--xPlayer.showpNotifyNotification(_U('used_cocacola'))
	TriggerClientEvent('esx:showNotification', source, _U('used_cocacola'))
end)

ESX.RegisterUsableItem('water', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('water', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 500000)
	TriggerClientEvent('consumables:client:Drink', source)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	--xPlayer.showpNotifyNotification(_U('used_water'))
	TriggerClientEvent('esx:showNotification', source, _U('used_water'))
end)

ESX.RegisterUsableItem('grape_juice', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('grape_juice', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 70000)
	TriggerClientEvent('consumables:client:Drink', source)
	--xPlayer.showpNotifyNotification(_U('used_grape_juice''))
	TriggerClientEvent('esx:showNotification', source, _U('used_grape_juice'))
end)

ESX.RegisterUsableItem('pepsi', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('pepsi', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 80000)
	TriggerClientEvent('consumables:client:Drink', source, "prop_food_cb_juice01")
	--xPlayer.showpNotifyNotification(_U('used_pepsi'))
	TriggerClientEvent('esx:showNotification', source, _U('used_pepsi'))
end)

ESX.RegisterCommand('heal', 'admin', function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx_basicneeds:healPlayer')
	args.playerId.triggerEvent('chat:addMessage', {args = {'^5HEAL', 'You have been healed.'}})
end, true, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', validate = true, arguments = {
	{name = 'playerId', help = 'the player id', type = 'player'}
}})