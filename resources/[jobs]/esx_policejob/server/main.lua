ESX = nil
local doGetgpsplayer = false
local whilegetGPS = false
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.EnableESXService then
	if Config.MaxInService ~= -1 then
		TriggerEvent('esx_service:activateService', 'police', Config.MaxInService)
	end
end

RegisterNetEvent('esx_polcejob:setDoWithCoords')
AddEventHandler('esx_polcejob:setDoWithCoords', function(data)
	doGetgpsplayer = data
	whilegetGPS = data
end)

RegisterNetEvent('esx_policejob:Tasleem')
AddEventHandler('esx_policejob:Tasleem', function()
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
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'admin' then

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
					notify = '</br>أموال غير قانونية: <font color=red>$</font>'.. tostring(ESX.Math.GroupDigits(PlayerMoney)) .. '</br> خزنة الشرطة: <font color=green>$</font>'..tostring(ESX.Math.GroupDigits(PoliceStation))
				else
					notify = notify .. '</br>أموال غير قانونية: <font color=red>$</font>'.. tostring(ESX.Math.GroupDigits(PlayerMoney)) .. '</br> خزنة الشرطة: <font color=green>$</font>'..tostring(ESX.Math.GroupDigits(PoliceStation))
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

ESX.RegisterServerCallback("esx_policejob:getStatusPolice", function(source, cb)
	local text = nil
	local number = 0
	local last_list = {}
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer1 = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer1 then
			if xPlayer1.job.name == "police" then
				number = i
			end
		end
	end
	if xPlayer then
		for o,v in pairs(xPlayers) do
			local xPlayerZero = ESX.GetPlayerFromId(xPlayers[o])
			local yes = false
			if xPlayerZero then
				if xPlayerZero.job.name == "police" then
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

ESX.RegisterServerCallback('esx_policejob:getRentedVehicleInfos', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT owner FROM rented_cars WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		local retrivedInfo = {plate = plate}

		if result[1] then
			local xPlayer = ESX.GetPlayerFromIdentifier(result[1].owner)
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

RegisterNetEvent('esx_policejob:removedeleteRecordMoney')
AddEventHandler('esx_policejob:removedeleteRecordMoney', function(type, money, id, joobb)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	if type == 'show' then
		if xPlayer.getMoney() >= money then
			TriggerClientEvent('esx_policejob:showRecordsss', xPlayer.source, joobb)
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

RegisterNetEvent('esx_polcejob:getGPSplayer')
AddEventHandler('esx_polcejob:getGPSplayer', function(choice_what, phone_number_or_plate_car)
	whilegetGPS = true
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		if xPlayer.job.name == "police" or xPlayer.job.name == "agent" then
			if choice_what == "from_phone_number" then
				MySQL.Async.fetchAll("SELECT identifier FROM users WHERE phone_number = @phone_number", {
					["@phone_number"] = phone_number_or_plate_car
				}, function(result2)
					if result2[1] then
						local xTarget = ESX.GetPlayerFromIdentifier(result2[1].identifier)
						if xTarget then
							TriggerClientEvent('esx_policejob:setCOOLDOWNOnSYSTEM', -1)
							TriggerClientEvent('esx_policejob:getGPSplayerClient', -1, xTarget.source, xTarget.job.name, GetPlayerName(xTarget.source), GetEntityCoords(GetPlayerPed(xTarget.source)))
							while whilegetGPS do
								if doGetgpsplayer then
									TriggerClientEvent('esx_policejob:getGPSplayerClient', -1, xTarget.source, xTarget.job.name, GetPlayerName(xTarget.source), GetEntityCoords(GetPlayerPed(xTarget.source)))
								end
								Citizen.Wait(1000)
							end
						else
							xPlayer.showNotification('من الممكن الشخص ( فصل ) من السيرفر')
						end
					else
						xPlayer.showNotification("لم يتم العثور على بيانات الشخص من الممكن ( رقم الجوال غير صحيح )")
					end
				end)
			elseif choice_what == "plate_car" then
				MySQL.Async.fetchAll("SELECT owner FROM owned_vehicles WHERE plate = @plate", {
					["@plate"] = phone_number_or_plate_car
				}, function(result2)
					if result2[1] then
						local xTarget = ESX.GetPlayerFromIdentifier(result2[1].owner)
						if xTarget then
							TriggerClientEvent('esx_policejob:setCOOLDOWNOnSYSTEM', -1)
							TriggerClientEvent('esx_policejob:getGPSplayerClient', -1, xTarget.source, xTarget.job.name, GetPlayerName(xTarget.source), GetEntityCoords(GetPlayerPed(xTarget.source)))
							while whilegetGPS do
								if doGetgpsplayer then
									TriggerClientEvent('esx_policejob:getGPSplayerClient', -1, xTarget.source, xTarget.job.name, GetPlayerName(xTarget.source), GetEntityCoords(GetPlayerPed(xTarget.source)))
								end
								Citizen.Wait(1000)
							end
						else
							xPlayer.showNotification('من الممكن الشخص ( فصل ) من السيرفر')
						end
					else
						xPlayer.showNotification("لم يتم العثور على بيانات الشخص من الممكن ( ارقام و احرف  اللوحة غير صحيحة )")
					end
				end)
			end
		end
	end
end)

TriggerEvent('esx_phone:registerNumber', 'police', _U('alert_police'), true, true)

TriggerEvent('esx_society:registerSociety', 'police', 'Police', 'society_police', 'society_police', 'society_police', {type = 'public'})

ESX.RegisterServerCallback('esx_policejob:getPlayerInfo', function(source, cb, type, label, label2)
	local have_car = 0
	local car_counter = 0
	local name_car_info = nil
	local phone_by = nil
	local xPlayer = ESX.GetPlayerFromId(source)
	if type == 'first_name_and_last_name' then
		MySQL.Async.fetchAll("SELECT firstname, lastname, job, identifier FROM users ", {
		}, function(result)
			for k,v in pairs(result) do
				if v.firstname == label and v.lastname == label2 then
					MySQL.Async.fetchAll("SELECT plate FROM owned_vehicles WHERE owner = @owner", {
						["@owner"] = v.identifier
					}, function(result2)
						for kk,vv in pairs(result2) do
							have_car = have_car + 1
						end
						local result = MySQL.Sync.fetchAll("SELECT phone_number FROM gksphone_settings WHERE identifier = @identifier", {
							['@identifier'] = v.identifier
						})
						local xTarget = ESX.GetPlayerFromIdentifier(v.identifier)
						if v.job == 'admin' then
							xPlayer.showNotification('<font color=yellow>لايمكنك الأستعلام عن المراقب')
						else
							TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
								text = 		"</br><font size=3><p align=right><b><font color=yellow>بيانات الشخص</font>"..
								"</br><font size=3><p align=right><b>الهوية: <font color=gold>"..xTarget.getName().."</font>"..
								"</br><font size=3><p align=right><b>وظيفة: <font color=orange>"..xTarget.getJob().label.." - "..xTarget.getJob().grade_label.."</font>"..
								"</br><font size=3><p align=right><b>رقم جوالة: <font color=gold>"..result[1].phone_number.."</font>"..
								"</br><font size=3><p align=right><b>عدد المركبات الذي يمتلكها: <font color=gold>"..have_car.."</font>",
								type = "info",
								queue = "right",
								timeout = 60000,
								layout = "centerright"
							})
							MySQL.Async.fetchAll('SELECT name,plate FROM owned_vehicles WHERE owner = @owner',
							{
								['@owner'] = xTarget.identifier,
							},
							function(data)
								cb(data)
							end)
						end
					end)
					break
				end
			end
		end)
	elseif type == 'search_by_phone_number' then
		MySQL.Async.fetchAll("SELECT phone_number, identifier FROM gksphone_settings", {
		}, function(result)
			for k,v in pairs(result) do
				if v.phone_number == label then
					MySQL.Async.fetchAll("SELECT plate FROM owned_vehicles WHERE owner = @owner", {
						["@owner"] = v.identifier
					}, function(result2)
						for kk,vv in pairs(result2) do
							have_car = have_car + 1
						end
						local xTarget = ESX.GetPlayerFromIdentifier(v.identifier)
						if xTarget.job.name == 'admin' then
							xPlayer.showNotification('<font color=yellow>لايمكنك الأستعلام عن المراقب')
						else
							TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
								text = 		"</br><font size=3><p align=right><b><font color=yellow>بيانات الشخص</font>"..
								"</br><font size=3><p align=right><b>الهوية: <font color=gold>"..xTarget.getName().."</font>"..
								"</br><font size=3><p align=right><b>وظيفة: <font color=orange>"..xTarget.getJob().label.." - "..xTarget.getJob().grade_label.."</font>"..
								"</br><font size=3><p align=right><b>رقم جوالة: <font color=gold>"..v.phone_number.."</font>"..
								"</br><font size=3><p align=right><b>عدد المركبات الذي يمتلكها: <font color=gold>"..have_car.."</font>",
								type = "info",
								queue = "right",
								timeout = 60000,
								layout = "centerright"
							})
							MySQL.Async.fetchAll('SELECT name,plate FROM owned_vehicles WHERE owner = @owner',
							{
								['@owner'] = xTarget.identifier,
							},
							function(data)
								cb(data)
							end)
						end
					end)
					break
				end
			end
		end)
	elseif type == 'search_by_plate' then
		MySQL.Async.fetchAll("SELECT plate, owner FROM owned_vehicles ", {
		}, function(result)
			for k,v in pairs(result) do
				if v.plate == label then
					MySQL.Async.fetchAll("SELECT plate FROM owned_vehicles WHERE owner = @owner", {
						["@owner"] = v.owner
					}, function(result2)
						for kk,vv in pairs(result2) do
							have_car = have_car + 1
						end
						local result2 = MySQL.Sync.fetchAll("SELECT phone_number FROM gksphone_settings WHERE identifier = @identifier", {
							['@identifier'] = v.owner
						})
						local xTarget = ESX.GetPlayerFromIdentifier(v.owner)
						if xTarget.job.name == 'admin' then
							xPlayer.showNotification('<font color=yellow>لايمكنك الأستعلام عن المراقب')
						else
							TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
								text = 		"</br><font size=3><p align=right><b><font color=yellow>بيانات الشخص</font>"..
								"</br><font size=3><p align=right><b>الهوية: <font color=gold>"..xTarget.getName().."</font>"..
								"</br><font size=3><p align=right><b>وظيفة: <font color=orange>"..xTarget.getJob().label.." - "..xTarget.getJob().grade_label.."</font>"..
								"</br><font size=3><p align=right><b>رقم جوالة: <font color=gold>"..result2[1].phone_number.."</font>"..
								"</br><font size=3><p align=right><b>عدد المركبات الذي يمتلكها: <font color=gold>"..have_car.."</font>",
								type = "info",
								queue = "right",
								timeout = 60000,
								layout = "centerright"
							})
							MySQL.Async.fetchAll('SELECT name,plate FROM owned_vehicles WHERE owner = @owner',
							{
								['@owner'] = xTarget.identifier,
							},
							function(data)
								cb(data)
							end)
						end
					end)
					break
				end
			end
		end)
	end
end)

ESX.RegisterServerCallback('esx_policejob:checkJail', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll("SELECT jail FROM users WHERE identifier = @identifier", {
		['@identifier'] = xPlayer.identifier
	}, function(result_jail)
		if result_jail[1].jail > 0 then
			cb(true)
		else
			cb(false)
		end
	end)
end)

RegisterNetEvent('esx_policejob:confiscatePlayerItem')
AddEventHandler('esx_policejob:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	MySQL.Async.fetchAll('SELECT is_dead FROM users WHERE identifier = @identifier', {
		['@identifier'] = targetXPlayer.identifier
	}, function(is_dead_or_no)
		if is_dead_or_no[1] then
			if is_dead_or_no[1].is_dead then
				sourceXPlayer.showNotification("<font color=orange>لايمكنك تفتيش شخص وهو مسقط</font>")
			else
				if sourceXPlayer.job.name ~= 'police' then
					print(('esx_policejob: %s attempted to confiscate!'):format(sourceXPlayer.identifier))
					return
				end
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
							timeout = 20000,
							layout = "centerright"
						})
						TriggerClientEvent("pNotify:SendNotification", targetXPlayer.source, {
							text = "</br><font size=3><p align=right><b><font color=yellow>مصادرة</font>"..
							"</br><font size=3><p align=right><b>هوية الشخص: <font color=gold>"..sourceXPlayer.name.."</font>"..
							"</br><font size=3><p align=right><b>السلاح المصادر: <font color=gold>"..ESX.GetWeaponLabel(itemName).."</font>",
							type = "info",
							queue = "right",
							timeout = 20000,
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

RegisterNetEvent('esx_policejob:handcuff')
AddEventHandler('esx_policejob:handcuff', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' or xPlayer.job.name == 'agent' or xPlayer.job.name == 'admin' then
		TriggerClientEvent('esx_policejob:handcuff', target)
	else
		print(('esx_policejob: %s attempted to handcuff a player (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' or xPlayer.job.name == 'agent' or xPlayer.job.name == 'admin' then
		TriggerClientEvent('esx_policejob:drag', target, source)
	else
		print(('esx_policejob: %s attempted to drag (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' or xPlayer.job.name == 'agent' or xPlayer.job.name == 'admin' then
		TriggerClientEvent('esx_policejob:putInVehicle', target)
	else
		print(('esx_policejob: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' or xPlayer.job.name == 'agent' or xPlayer.job.name == 'admin' then
		TriggerClientEvent('esx_policejob:OutVehicle', target)
	else
		print(('esx_policejob: %s attempted to drag out from vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('esx_policejob:getStockItem')
AddEventHandler('esx_policejob:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
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

RegisterNetEvent('esx_policejob:putStockItems')
AddEventHandler('esx_policejob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
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

RegisterNetEvent('esx_policejob:sendToAllPlayersNotficiton')
AddEventHandler('esx_policejob:sendToAllPlayersNotficiton', function(jobsGradePlayer)
	local Player = ESX.GetPlayerFromId(source)
	local name_player = Player.getName()
	local Players = ESX.GetPlayers()
	for i = 1, #Players, 1 do
		local xPlayer = ESX.GetPlayerFromId(Players[i])
		if xPlayer.job.name == 'police' then
			xPlayer.showNotification('<font color=yellow>اعلان خدمة موظف</font>' .. '<font size=5 color=white><center><b><font color=0080FF> ' .. jobsGradePlayer .. '<font size=5 color=white><center><b><font color=00CC00>تسجيل دخول <font color=FFFFFF>' .. name_player)
		end
	end
end)


ESX.RegisterServerCallback('getPlayerCheckOnlineBywesam:check', function(source, cb, type)
	local Players = ESX.GetPlayers()
	local hhh = false
	local counter = 0
	for i = 1, #Players, 1 do
		local xPlayer = ESX.GetPlayerFromId(Players[i])
		if type == 'police' and xPlayer.job.name == 'police' or xPlayer.job.name == 'agent' then
			counter = counter + 1
		elseif type == 'ambulance' and xPlayer.job.name == 'ambulance' then
			hhh = true
			cb(true)
		end
	end
	if type == 'police' then
		cb(counter)
	elseif type == 'ambulance' then
		if hhh == true then
			cb(true)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('esx_policejob:getOtherPlayerData', function(source, cb, target, notify)
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

ESX.RegisterServerCallback('esx_policejob:getFineList', function(source, cb, category)
	MySQL.Async.fetchAll('SELECT id, label, amount, category FROM fine_types WHERE category = @category', {
		['@category'] = category
	}, function(fines)
		cb(fines)
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getVehicleInfos', function(source, cb, plate)
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

ESX.RegisterServerCallback('esx_policejob:getArmoryWeapons', function(source, cb)
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)
	end)
end)

ESX.RegisterServerCallback('esx_policejob:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)
	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)
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

ESX.RegisterServerCallback('esx_policejob:removeArmoryWeapon', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)
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

ESX.RegisterServerCallback('esx_policejob:buyWeapon', function(source, cb, weaponName, type, componentNum)
	local xPlayer = ESX.GetPlayerFromId(source)
	local authorizedWeapons, selectedWeapon = Config.AuthorizedWeapons[xPlayer.job.grade_name]

	for k,v in ipairs(authorizedWeapons) do
		if v.weapon == weaponName then
			selectedWeapon = v
			break
		end
	end

	if not selectedWeapon then
		print(('esx_policejob: %s attempted to buy an invalid weapon.'):format(xPlayer.identifier))
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
				print(('esx_policejob: %s attempted to buy an invalid weapon component.'):format(xPlayer.identifier))
				cb(false)
			end
		end
	end
end)

ESX.RegisterServerCallback('esx_policejob:canMechanicImpound', function(source, cb, location)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
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


ESX.RegisterServerCallback('esx_policejob:buyJobVehicle', function(source, cb, vehicleProps, type, name)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		print(('esx_policejob: %s attempted to exploit the shop! (invalid vehicle model)'):format(xPlayer.identifier))
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

ESX.RegisterServerCallback('esx_policejob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
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
				print(('esx_policejob: %s has exploited the garage!'):format(xPlayer.identifier))
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

ESX.RegisterServerCallback('esx_policejob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getPlayerInventory', function(source, cb)
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
		if xPlayer and xPlayer.job.name == 'police' then
			Citizen.Wait(5000)
			TriggerClientEvent('esx_policejob:updateBlip', -1)
		end
	end
end)

RegisterNetEvent('esx_policejob:spawned')
AddEventHandler('esx_policejob:spawned', function()
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer and xPlayer.job.name == 'police' then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_policejob:updateBlip', -1)
	end
end)

RegisterNetEvent('esx_policejob:forceBlip')
AddEventHandler('esx_policejob:forceBlip', function()
	TriggerClientEvent('esx_policejob:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_policejob:updateBlip', -1)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'police')
	end
end)
