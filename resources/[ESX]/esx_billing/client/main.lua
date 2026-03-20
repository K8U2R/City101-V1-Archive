ESX = nil
local isDead = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function ShowBillsMenu()

	ESX.TriggerServerCallback('esx_billing:getBills', function(bills)
		ESX.UI.Menu.CloseAll()
		
		local elements_main_menu = {}
		
		local society = {
			['society_police'] = {},
			['society_agent'] = {},
			['society_mechanic'] = {},
			['society_admin'] = {},
			['society_other'] = {}
		}
		
		for i=1, #bills, 1 do
			--print('# bills[i].target ['..bills[i].target..'] : target ['..target..']')
			if society[bills[i].target] ~= nil then
					table.insert(society[bills[i].target], {
						label  = ('%s - <span style="color:red;">%s</span>'):format(bills[i].label, _U('invoices_item', ESX.Math.GroupDigits(bills[i].amount))),
						billID = bills[i].id,
						amount = bills[i].amount
					})
			else
				table.insert(society['society_other'], {
					label  = ('%s - <span style="color:red;">%s</span>'):format(bills[i].label, _U('invoices_item', ESX.Math.GroupDigits(bills[i].amount))),
					billID = bills[i].id,
					amount = bills[i].amount
				})
			end
		end
		
		if #bills ~= 0 then
			--[[
			table.insert(elements_main_menu, {
				label  = 'اضغط هنا لتسديد جميع الفواتير والمخالفات',
				target = 'all',
				billsCount = 0,
				billsTotal = 0
			})
			]]
			
			for target,elements in pairs(society) do
				local billsCount = #elements
				if billsCount ~= 0 then
					local societyLabel = getSocietyLabel(target)
					local billsTotal = getBillsTotal(society[target])
					table.insert(elements_main_menu, {
						label  = societyLabel..'  [<font color=orange>'..billsCount..'</font>]  <font color=green>$</font>'..billsTotal,
						target = target,
						billsCount = billsCount,
						billsTotal = billsTotal
					})
				end	
			end
		else
			table.insert(elements_main_menu, {
				label  = '<font color=gray>لايوجد فواتير او مخالفات</font>',
				target = 'none',
				billsCount = 0,
				billsTotal = 0
			})
		end
		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing_main',
		{
			title    = _U('invoices'),
			align    = 'bottom-right',
			elements = elements_main_menu
		}, function(data, menu)
			if data.current.target == 'all' then
				----------------------
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_menu', {
                   title    = 'تأكيد تسديد جميع الفواتير والمخالفات',
                   align    = 'bottom-right',
                   elements = {
						{label = '<span style="color:red">رجوع</span>',  value = 'no'},
						{label = '<span style="color:green">نعم</span>', value = 'yes'},
					}
				}, function(data2, menu2)
					if data2.current.value == 'yes' then
						menu.close()
						TriggerServerEvent('esx_billing:payBillAll')
					end
					menu2.close()
				end, function(data2, menu2) menu2.close() end)
				----------------------
			elseif data.current.target ~= 'none' then
				------------
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing_submenu',
				{
					title    = _U('invoices')..' '..data.current.label,
					align    = 'bottom-right',
					elements = society[data.current.target]
				}, function(data2, menu2)
					menu2.close()
					menu.close()
					--print('# data2.current.billID ['..data2.current.billID..']')
					ESX.TriggerServerCallback('esx_billing:payBill', function()
						ShowBillsMenu()
					end, data2.current.billID)
				end, function(data2, menu2)
					menu2.close()
				end)
				------------
			end	
		end, function(data, menu)
			menu.close()
		end)
	end)

end

function getBillsTotal(target)
	local total = 0
	for k,v in pairs(target) do
		total = total + v.amount
	end
	
	return ESX.Math.GroupDigits(total)
end

function  getSocietyLabel(target)
	local society = {
		['society_police'] = '<font color=#0094FF>الشرطة</font>',
		['society_agent'] = '<font color=green>حرس الحدود</font>',
		['society_mechanic'] = '<font color=gray>كراج الميكانيك</font>',
		['society_admin'] = '<font color=orange>الرقابة و التفتيش</font>',
		['society_other'] = 'آخر'
	}
	
	if society[target] ~= nil then
		return society[target]
	else
		return society['society_other']
	end
end

RegisterCommand('showbills', function()
	if not isDead and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'billing') then
		ShowBillsMenu()
	end
end, false)

RegisterKeyMapping('showbills', _U('keymap_showbills'), 'keyboard', 'F7')

AddEventHandler('esx:onPlayerDeath', function() isDead = true end)
AddEventHandler('esx:onPlayerSpawn', function(spawn) isDead = false end)
