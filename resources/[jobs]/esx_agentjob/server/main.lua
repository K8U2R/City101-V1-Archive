ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.EnableESXService then
	if Config.MaxInService ~= -1 then
		TriggerEvent('esx_service:activateService', 'agent', Config.MaxInService)
	end
end

TriggerEvent('esx_phone:registerNumber', 'agent', _U('alert_agent'), true, true)

TriggerEvent('esx_society:registerSociety', 'agent', 'agent', 'society_agent', 'society_agent', 'society_agent', {type = 'public'})

RegisterNetEvent('esx_agentjob:removedeleteRecordMoney')
AddEventHandler('esx_agentjob:removedeleteRecordMoney', function(type, money, id, joobb)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	if type == 'show' then
		if xPlayer.getMoney() >= money then
			TriggerClientEvent('esx_agentjob:showRecordsss', xPlayer.source, joobb)
			xPlayer.showNotification('<font color=green>تم عرض السجل</font>')
			xPlayer.removeMoney(money)
		else
			xPlayer.showNotification('<font color=red>لا تملك نقود كاش كافية</font>')
		end
	elseif type == 'delete' then
		if xPlayer.getMoney() >= money then
			MySQL.Async.fetchAll("DELETE FROM criminal_record WHERE id = @id",
			{
				['@id'] = id,
			})
			xPlayer.showNotification('<font color=green>تم حذف القيد بنجاح</font>')
			xPlayer.removeMoney(money)
		else
			xPlayer.showNotification('<font color=red>لا تملك نقود كاش كافية</font>')
		end
	end
end)

function checkPlayerdead(identifier, getName, number, id_player, cb)
	local text = nil
	MySQL.Async.fetchAll('SELECT is_dead FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result[1] then
			if result[1].is_dead then
				cb('<span style="color:3399FF">' .. getName .. '</span><br><span  style="color:#white;font-size:15">حالة العسكري<span style="color:red">: </span><span style="color:FF0000">مسقط</span>')
			else
				cb('<span style="color:3399FF">' ..getName .. '</span><br><span  style="color:#white;font-size:15">حالة العسكري<span style="color:red">: </span><span style="color:7CFC00">ليس مسقط</span>')
			end
		end
	end)
end


ESX.RegisterServerCallback("esx_agentjob:getStatusAgent", function(source, cb)
	local text = nil
	local number = 0
	local last_list = {}
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer1 = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer1 then
			if xPlayer1.job.name == "agent" then
				number = i
			end
		end
	end
	if xPlayer then
		for o,v in pairs(xPlayers) do
			local xPlayerZero = ESX.GetPlayerFromId(xPlayers[o])
			local yes = false
			if xPlayerZero then
				if xPlayerZero.job.name == "agent" then
					checkPlayerdead(xPlayerZero.identifier, xPlayerZero.getName(), number, o, function(label)
						if number == o then
							table.insert(last_list, {label = label})
							cb(last_list)
						else
							table.insert(last_list, {label = label})
						end
					end)
				end
			end
		end
	end
end)

RegisterNetEvent('esx_agentjob:Tasleem')
AddEventHandler('esx_agentjob:Tasleem', function()
	local _source = source

	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local items = xPlayer.inventory
	local weapons = xPlayer.getLoadout()
	local xp = 0
	local money = 0
	local notify = nil
	local inMarker = false

	if xPlayer then
		if xPlayer.job.name == 'agent' or xPlayer.job.name == 'admin' then

			for i = 1, #items, 1 do
				if items[i].count > 0 then
					if Config.mmno3at.items[items[i].name] then
						money = money + (Config.mmno3at.items[items[i].name].money * items[i].count)
						xp = xp + (Config.mmno3at.items[items[i].name].xp * items[i].count)
						if notify == nil then
							notify = '</br>' .. items[i].count .. ' ' .. items[i].label
						else
							notify = notify .. '</br>' .. items[i].count .. ' ' .. items[i].label
						end
						xPlayer.removeInventoryItem(items[i].name, items[i].count)
					end
				end
			end

			if xPlayer.getAccount('black_money').money > 0 then
				local PoliceStation = xPlayer.getAccount('black_money').money * 0.2
				local PlayerMoney = xPlayer.getAccount('black_money').money * 0.8
				money = money + PlayerMoney
				xp = xp + 5
				if notify == nil then
					notify = '</br>أموال غير قانونية: <font color=red>$</font>'.. tostring(ESX.Math.GroupDigits(PlayerMoney)) .. '</br> حرس الحدود: <font color=green>$</font>'..tostring(ESX.Math.GroupDigits(PoliceStation))
				else
					notify = notify .. '</br>أموال غير قانونية: <font color=red>$</font>'.. tostring(ESX.Math.GroupDigits(PlayerMoney)) .. '</br> حرس الحدود: <font color=green>$</font>'..tostring(ESX.Math.GroupDigits(PoliceStation))
				end
				xPlayer.removeAccountMoney('black_money', xPlayer.getAccount('black_money').money)
			end

			if money ~= 0 then
				xPlayer.addMoney(money)
			end
			if xp ~= 0 then
				xPlayer.triggerEvent('SystemXpLevel:updateCurrentPlayerXP_clientSide', 'addnoduble', xp)
			end

			if notify ~= nil then
				xPlayer.triggerEvent('pNotify:SendNotification', {
					text = "<h1><center><font color=green><i><font size=5>تسليم ممنوعات</font></i></font></h1>"..
					"<font size=4><p align=right><b>:الممنوعات".."<font size=4><font color=orange>"..notify.."</font></font>"..
					"<font size=4><p align=right><b>المجموع: ".."<font color=green> $</font>"..tostring(ESX.Math.GroupDigits(money))..
					"<font size=4><p align=right><b>الخبرة: ".."<font color=2B80CF>"..tostring(xp)..'</font>',
					type = "success",
					timeout = 10000,
					layout = "centerLeft",
				})
			else
				xPlayer.showNotification('<font color=red>لا يوجد ممنوعات لتسليمها</font>')
			end
		else
			local Resooonnn = "لقد تم حظرك من المدينة لمحاولة إستخدام ثغرات برمجية .. أحفظ آخر 10 دقائق وتوجه الدعم الفني"
			TriggerEvent('EasyAdmin:banPlayer', src, Resooonnn, 10444633200)
			return false
		end
	end
end)

ESX.RegisterServerCallback('esx_blips_get', function(source, cb, player_id)
	local xPlayer = ESX.GetPlayerFromId(player_id)
	if xPlayer then
		MySQL.Async.fetchAll('SELECT position, accounts FROM users WHERE identifier = @identifier',
		{
			['@identifier'] = xPlayer.identifier,
		},
		function(data)
			local coords_player = json.decode(data[1].position)
			cb({x = coords_player['x'], y = coords_player['y'], z = coords_player['z']})
		end)
	end
end)

ESX.RegisterServerCallback('esx_wesam:checkPlayerIsDead', function(source, cb, id_player)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(id_player)
	MySQL.Async.fetchAll('SELECT is_dead FROM users WHERE identifier = @identifier', {
		['@identifier'] = xTarget.identifier
	}, function(is_dead_or_no)
		if is_dead_or_no[1].is_dead == true then
			xPlayer.showNotification("<font color=orange>لايمكنك تفتيش شخص وهو مسقط</font>")
			cb({status = true, id_player = id_player})
		else
			cb({status = false, id_player = id_player})
		end
	end)
end)

RegisterNetEvent('esx_agentjob:confiscatePlayerItem')
AddEventHandler('esx_agentjob:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	if sourceXPlayer.job.name ~= 'agent' then
		print(('esx_policejob: %s attempted to confiscate!'):format(sourceXPlayer.identifier))
		return
	end
	MySQL.Async.fetchAll('SELECT is_dead FROM users WHERE identifier = @identifier', {
		['@identifier'] = targetXPlayer.identifier
	}, function(is_dead_or_no)
		if is_dead_or_no[1] then
			if is_dead_or_no[1].is_dead then
				sourceXPlayer.showNotification("<font color=orange>لايمكنك تفتيش شخص وهو مسقط</font>")
			else
				targetXPlayer.showNotification("<font color=orange>'يتم الآن تفتيشك .. من حقك التزام الصمت وعدم عرقلة سير العدالة'</font>")
				if itemType == 'item_standard' then
					local targetItem = targetXPlayer.getInventoryItem(itemName)
					local sourceItem = sourceXPlayer.getInventoryItem(itemName)

					-- does the target player have enough in their inventory?
					if targetItem.count > 0 and targetItem.count <= amount then

						-- can the player carry the said amount of x item?
						if sourceXPlayer.canCarryItem(itemName, sourceItem.count) then
							targetXPlayer.removeInventoryItem(itemName, amount)
							sourceXPlayer.addInventoryItem   (itemName, amount)
							TriggerClientEvent("pNotify:SendNotification", sourceXPlayer.source, {
								text = "</br><font size=3><p align=right><b><font color=yellow>مصادرة</font>"..
								"</br><font size=3><p align=right><b>هوية الشخص: <font color=gold>"..targetXPlayer.name.."</font>"..
								"</br><font size=3><p align=right><b>الغرض المصادر: <font color=gold>"..sourceItem.label.."</font>"..
								"</br><font size=3><p align=right><b>الكمية المصادرة: <font color=orange>"..amount.."</font>",
								type = "info",
								queue = "right",
								timeout = 20000,
								layout = "centerright"
							})
							TriggerClientEvent("pNotify:SendNotification", targetXPlayer.source, {
								text = "</br><font size=3><p align=right><b><font color=yellow>مصادرة</font>"..
								"</br><font size=3><p align=right><b>هوية الشخص: <font color=gold>"..sourceXPlayer.name.."</font>"..
								"</br><font size=3><p align=right><b>الغرض المصادر: <font color=gold>"..sourceItem.label.."</font>"..
								"</br><font size=3><p align=right><b>الكمية المصادرة: <font color=orange>"..amount.."</font>",
								type = "info",
								queue = "right",
								timeout = 20000,
								layout = "centerright"
							})
							--[[sourceXPlayer.showNotification(_U('you_confiscated', amount, sourceItem.label, targetXPlayer.name))
							targetXPlayer.showNotification(_U('got_confiscated', amount, sourceItem.label, sourceXPlayer.name))--]]
						else
							sourceXPlayer.showNotification(_U('quantity_invalid'))
						end
					else
						sourceXPlayer.showNotification(_U('quantity_invalid'))
					end

				elseif itemType == 'item_account' then
					local targetAccount = targetXPlayer.getAccount(itemName)

					-- does the target player have enough money?
					if targetAccount.money >= amount then
						targetXPlayer.removeAccountMoney(itemName, amount)
						sourceXPlayer.addAccountMoney   (itemName, amount)
						TriggerClientEvent("pNotify:SendNotification", sourceXPlayer.source, {
							text = "</br><font size=3><p align=right><b><font color=yellow>مصادرة</font>"..
							"</br><font size=3><p align=right><b>هوية الشخص: <font color=gold>"..targetXPlayer.name.."</font>"..
							"</br><font size=3><p align=right><b>المصادر: <font color=red>مبلغ غير قانوني</font>"..
							"</br><font size=3><p align=right><b>المبلغ المصادر: <font color=orange>$"..amount.."</font>",
							type = "info",
							queue = "right",
							timeout = 20000,
							layout = "centerright"
						})
						TriggerClientEvent("pNotify:SendNotification", targetXPlayer.source, {
							text = "</br><font size=3><p align=right><b><font color=yellow>مصادرة</font>"..
							"</br><font size=3><p align=right><b>هوية الشخص: <font color=gold>"..targetXPlayer.name.."</font>"..
							"</br><font size=3><p align=right><b>المصادر: <font color=red>مبلغ غير قانوني</font>"..
							"</br><font size=3><p align=right><b>المبلغ المصادر: <font color=orange>$"..amount.."</font>",
							type = "info",
							queue = "right",
							timeout = 20000,
							layout = "centerright"
						})
						--[[sourceXPlayer.showNotification(_U('you_confiscated_account', amount, itemName, targetXPlayer.name))
						targetXPlayer.showNotification(_U('got_confiscated_account', amount, itemName, sourceXPlayer.name))--]]
					else
						sourceXPlayer.showNotification(_U('quantity_invalid'))
					end

				elseif itemType == 'item_weapon' then
					if amount == nil then amount = 0 end

					-- does the target player have weapon?
					if targetXPlayer.hasWeapon(itemName) then
						targetXPlayer.removeWeapon(itemName, amount)
						sourceXPlayer.addWeapon   (itemName, amount)
						TriggerClientEvent("pNotify:SendNotification", sourceXPlayer.source, {
							text = "</br><font size=3><p align=right><b><font color=yellow>مصادرة</font>"..
							"</br><font size=3><p align=right><b>هوية الشخص: <font color=gold>"..targetXPlayer.name.."</font>"..
							"</br><font size=3><p align=right><b>السلاح المصادر: <font color=gold>"..ESX.GetWeaponLabel(itemName).."</font>",
							type = "info",
							queue = "right",
							timeout = 60000,
							layout = "centerright"
						})
						TriggerClientEvent("pNotify:SendNotification", targetXPlayer.source, {
							text = "</br><font size=3><p align=right><b><font color=yellow>مصادرة</font>"..
							"</br><font size=3><p align=right><b>هوية الشخص: <font color=gold>"..sourceXPlayer.name.."</font>"..
							"</br><font size=3><p align=right><b>السلاح المصادر: <font color=gold>"..ESX.GetWeaponLabel(itemName).."</font>",
							type = "info",
							queue = "right",
							timeout = 60000,
							layout = "centerright"
						})
						--[[sourceXPlayer.showNotification(_U('you_confiscated_weapon', ESX.GetWeaponLabel(itemName), targetXPlayer.name, amount))
						targetXPlayer.showNotification(_U('got_confiscated_weapon', ESX.GetWeaponLabel(itemName), amount, sourceXPlayer.name))--]]
					else
						sourceXPlayer.showNotification(_U('quantity_invalid'))
					end
				end
			end
		end
	end)
end)

RegisterNetEvent('esx_agentjob:handcuff')
AddEventHandler('esx_agentjob:handcuff', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'agent' or xPlayer.job.name == 'agent' or xPlayer.job.name == 'admin' then
		TriggerClientEvent('esx_agentjob:handcuff', target)
	else
		print(('esx_agentjob: %s attempted to handcuff a player (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('esx_agentjob:drag')
AddEventHandler('esx_agentjob:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'agent' then
		TriggerClientEvent('esx_agentjob:drag', target, source)
	else
		print(('esx_agentjob: %s attempted to drag (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('esx_agentjob:putInVehicle')
AddEventHandler('esx_agentjob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'agent' then
		TriggerClientEvent('esx_agentjob:putInVehicle', target)
	else
		print(('esx_agentjob: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('esx_agentjob:sendToAllPlayersNotficiton')
AddEventHandler('esx_agentjob:sendToAllPlayersNotficiton', function(jobsGradePlayer)
	local Player = ESX.GetPlayerFromId(source)
	local name_player = Player.getName()
	local Players = ESX.GetPlayers()
	for i = 1, #Players, 1 do
		local xPlayer = ESX.GetPlayerFromId(Players[i])
		if xPlayer.job.name == 'agent' then
			xPlayer.showNotification('<font color=yellow>اعلان خدمة موظف</font>' .. '<font size=5 color=white><center><b><font color=0080FF> ' .. jobsGradePlayer .. '<font size=5 color=white><center><b><font color=00CC00>تسجيل دخول <font color=FFFFFF>' .. name_player)
		end
	end
end)

RegisterNetEvent('esx_agentjob:OutVehicle')
AddEventHandler('esx_agentjob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'agent' then
		TriggerClientEvent('esx_agentjob:OutVehicle', target)
	else
		print(('esx_agentjob: %s attempted to drag out from vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('esx_agentjob:getStockItem')
AddEventHandler('esx_agentjob:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_agent', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then

			-- can the player carry the said amount of x item?
			if xPlayer.canCarryItem(itemName, count) then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				xPlayer.showNotification(_U('have_withdrawn', count, inventoryItem.name))
			else
				xPlayer.showNotification(_U('quantity_invalid'))
			end
		else
			xPlayer.showNotification(_U('quantity_invalid'))
		end
	end)
end)

RegisterNetEvent('esx_agentjob:putStockItems')
AddEventHandler('esx_agentjob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_agent', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			xPlayer.showNotification(_U('have_deposited', count, inventoryItem.name))
		else
			xPlayer.showNotification(_U('quantity_invalid'))
		end
	end)
end)

ESX.RegisterServerCallback('esx_agentjob:getOtherPlayerData', function(source, cb, target, notify)
	local xPlayer = ESX.GetPlayerFromId(target)

	if notify then
		xPlayer.showNotification(_U('being_searched'))
	end

	if xPlayer then
		local data = {
			name = xPlayer.getName(),
			job = xPlayer.job.label,
			grade = xPlayer.job.grade_label,
			inventory = xPlayer.getInventory(),
			accounts = xPlayer.getAccounts(),
			weapons = xPlayer.getLoadout()
		}

		if Config.EnableESXIdentity then
			data.dob = xPlayer.get('dateofbirth')
			data.height = xPlayer.get('height')

			if xPlayer.get('sex') == 'm' then data.sex = 'male' else data.sex = 'female' end
		end

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status then
				data.drunk = ESX.Math.Round(status.percent)
			end
		end)

		if Config.EnableLicenses then
			TriggerEvent('esx_license:getLicenses', target, function(licenses)
				data.licenses = licenses
				cb(data)
			end)
		else
			cb(data)
		end
	end
end)

ESX.RegisterServerCallback('esx_agentjob:getFineList', function(source, cb, category)
	MySQL.Async.fetchAll('SELECT id, label, amount, category FROM fine_types WHERE category = @category', {
		['@category'] = category
	}, function(fines)
		cb(fines)
	end)
end)

ESX.RegisterServerCallback('esx_agentjob:getVehicleInfos', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		local retrivedInfo = {plate = plate}

		if result[1] then
			local xPlayer = ESX.GetPlayerFromIdentifier(result[1].owner)

			-- is the owner online?
			if xPlayer then
				retrivedInfo.owner = xPlayer.getName()
				cb(retrivedInfo)
			elseif Config.EnableESXIdentity then
				MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier',  {
					['@identifier'] = result[1].owner
				}, function(result2)
					if result2[1] then
						retrivedInfo.owner = ('%s %s'):format(result2[1].firstname, result2[1].lastname)
						cb(retrivedInfo)
					else
						cb(retrivedInfo)
					end
				end)
			else
				cb(retrivedInfo)
			end
		else
			cb(retrivedInfo)
		end
	end)
end)

ESX.RegisterServerCallback('esx_agentjob:getArmoryWeapons', function(source, cb)
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_agent', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)
	end)
end)

ESX.RegisterServerCallback('esx_agentjob:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)
	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_agent', function(store)
		local weapons = store.get('weapons') or {}
		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = weapons[i].count + 1
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 1
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

ESX.RegisterServerCallback('esx_agentjob:removeArmoryWeapon', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_agent', function(store)
		local weapons = store.get('weapons') or {}

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name = weaponName,
				count = 0
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

ESX.RegisterServerCallback('esx_agentjob:buyWeapon', function(source, cb, weaponName, type, componentNum)
	local xPlayer = ESX.GetPlayerFromId(source)
	local authorizedWeapons, selectedWeapon = Config.AuthorizedWeapons[xPlayer.job.grade_name]

	for k,v in ipairs(authorizedWeapons) do
		if v.weapon == weaponName then
			selectedWeapon = v
			break
		end
	end

	if not selectedWeapon then
		print(('esx_agentjob: %s attempted to buy an invalid weapon.'):format(xPlayer.identifier))
		cb(false)
	else
		-- Weapon
		if type == 1 then
			if xPlayer.getMoney() >= selectedWeapon.price then
				xPlayer.removeMoney(selectedWeapon.price)
				xPlayer.addWeapon(weaponName, 100)

				cb(true)
			else
				cb(false)
			end

		-- Weapon Component
		elseif type == 2 then
			local price = selectedWeapon.components[componentNum]
			local weaponNum, weapon = ESX.GetWeapon(weaponName)
			local component = weapon.components[componentNum]

			if component then
				if xPlayer.getMoney() >= price then
					xPlayer.removeMoney(price)
					xPlayer.addWeaponComponent(weaponName, component.name)

					cb(true)
				else
					cb(false)
				end
			else
				print(('esx_agentjob: %s attempted to buy an invalid weapon component.'):format(xPlayer.identifier))
				cb(false)
			end
		end
	end
end)

ESX.RegisterServerCallback('esx_agentjob:canMechanicImpound', function(source, cb, location)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'agent' then
		cb(true)
		Citizen.Wait(10000)
		TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', source, 'add', Config.impoundxp, 'حجز مركبة')
		xPlayer.addMoney(Config.impoundmoney)
		
		TriggerClientEvent("pNotify:SendNotification", source, {
		text = "<h1><center><font color=orange><i> 🚧 حجز مركبة</i></font></h1></b></center> <br /><br /><div align='right'> <b style='color:White;font-size:50px'><font size=5 color=White><font color=green>$"..Config.impoundmoney.."</font> : حصلت على <b style='color:green;font-size:26px'></font><b style='color:#3498DB;font-size:20px'><font size=5><p align=right><b> خبرة <font color=Blue>"..Config.impoundxp.." </font>",
		type = "warning",
		timeout = 15000,
		layout = "centerLeft"
		})
		
	else
		cb(false)
	end
end)


ESX.RegisterServerCallback('esx_agentjob:buyJobVehicle', function(source, cb, vehicleProps, type, name)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		print(('esx_agentjob: %s attempted to exploit the shop! (invalid vehicle model)'):format(xPlayer.identifier))
		cb(false)
	else
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price)

			MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`, name) VALUES (@owner, @vehicle, @plate, @type, @job, @stored, @name)', {
				['@owner'] = xPlayer.identifier,
				['@vehicle'] = json.encode(vehicleProps),
				['@plate'] = vehicleProps.plate,
				['@type'] = type,
				['@job'] = xPlayer.job.name,
				['@stored'] = true,
				['@name'] = name
			}, function (rowsChanged)
				cb(true)
			end)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('esx_agentjob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundPlate, foundNum

	for k,v in ipairs(nearbyVehicles) do
		local result = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = v.plate,
			['@job'] = xPlayer.job.name
		})

		if result[1] then
			foundPlate, foundNum = result[1].plate, k
			break
		end
	end

	if not foundPlate then
		cb(false)
	else
		MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = foundPlate,
			['@job'] = xPlayer.job.name
		}, function (rowsChanged)
			if rowsChanged == 0 then
				print(('esx_agentjob: %s has exploited the garage!'):format(xPlayer.identifier))
				cb(false)
			else
				cb(true, foundNum)
			end
		end)
	end
end)

function getPriceFromHash(vehicleHash, jobGrade, type)
	local vehicles = Config.AuthorizedVehicles[type][jobGrade]

	for k,v in ipairs(vehicles) do
		if GetHashKey(v.model) == vehicleHash then
			return v.price
		end
	end

	return 0
end

ESX.RegisterServerCallback('esx_agentjob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_agent', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('esx_agentjob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
	local playerId = source

	-- Did the player ever join?
	if playerId then
		local xPlayer = ESX.GetPlayerFromId(playerId)

		-- Is it worth telling all clients to refresh?
		if xPlayer and xPlayer.job.name == 'agent' then
			Citizen.Wait(5000)
			TriggerClientEvent('esx_agentjob:updateBlip', -1)
		end
	end
end)

RegisterNetEvent('esx_agentjob:spawned')
AddEventHandler('esx_agentjob:spawned', function()
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer and xPlayer.job.name == 'agent' then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_agentjob:updateBlip', -1)
	end
end)

RegisterNetEvent('esx_agentjob:forceBlip')
AddEventHandler('esx_agentjob:forceBlip', function()
	TriggerClientEvent('esx_agentjob:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_agentjob:updateBlip', -1)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'agent')
	end
end)
