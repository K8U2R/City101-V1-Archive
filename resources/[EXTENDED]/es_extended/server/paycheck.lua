ESX.StartPayCheck = function() -- new
	function payCheck()
		local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			local job     = xPlayer.job.grade_name
			local salary  = xPlayer.job.grade_salary
			if salary > 0 then
			TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', xPlayer.source, 'add', Config.PaycheckXP, 'نزول الراتب')
				if job == 'unemployed' then -- unemployed
					xPlayer.addAccountMoney('bank', salary)
					--TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_help', salary), 'CHAR_BANK_MAZE', 9)
				TriggerClientEvent("pNotify:SendNotification",xPlayer.source, {
						text = "<h1><center><font color=yellow><i> 💲 إيداع الراتب</i></font></h1></b></center> <br /><br /><div align='right'> <b style='color:White;font-size:50px'><font size=5 color=White>المبلغ: <b style='color:green;font-size:26px'>$"..salary.."<br /><br /><div align='right'> <b style='color:White;font-size:50px'><font size=5 color=White>الخبرة: <b style='color:green;font-size:26px'>"..Config.PaycheckXP.."<b style='color:#3498DB;font-size:20px'><font size=5><p align=right><b> حوالة واردة من ت الإجتماعية </font>",
						type = "info",
						timeout = 15000,
						layout = "centerLeft",
						sounds = {
						sources = {"msg.wav"}, -- For sounds to work, you place your sound in the html folder and then add it to the files array in the __resource.lua file.
						volume = 0.2,
						conditions = {"docVisible"}
						}
						})
				elseif Config.EnableSocietyPayouts then -- possibly a society
					TriggerEvent('esx_society:getSociety', xPlayer.job.name, function (society)
						if society ~= nil then -- verified society
							TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function (account)
								if account.money >= salary then -- does the society money to pay its employees?
									xPlayer.addAccountMoney('bank', salary)
									account.removeMoney(salary)

									TriggerClientEvent("pNotify:SendNotification",xPlayer.source, {
						text = "<h1><center><font color=yellow><i> 💲 إيداع الراتب</i></font></h1></b></center> <br /><br /><div align='right'> <b style='color:White;font-size:50px'><font size=5 color=White>المبلغ: <b style='color:green;font-size:26px'>$"..salary.."<br /><br /><div align='right'> <b style='color:White;font-size:50px'><font size=5 color=White>الخبرة: <b style='color:green;font-size:26px'>"..Config.PaycheckXP.."<b style='color:#3498DB;font-size:20px'><font size=5><p align=right><b> حوالة واردة من الخدمات الإجتماعية </font>",
						type = "info",
						timeout = 15000,
						layout = "centerLeft",
						sounds = {
						sources = {"msg.wav"}, -- For sounds to work, you place your sound in the html folder and then add it to the files array in the __resource.lua file.
						volume = 0.2,
						conditions = {"docVisible"}
						}
						})
								else
									TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), '', _U('company_nomoney'), 'CHAR_BANK_MAZE', 1)
								end
							end)
						else -- not a society
							xPlayer.addAccountMoney('bank', salary)
							TriggerClientEvent("pNotify:SendNotification",xPlayer.source, {
						text = "<h1><center><font color=yellow><i> 💲 إيداع الراتب</i></font></h1></b></center> <br /><br /><div align='right'> <b style='color:White;font-size:50px'><font size=5 color=White>المبلغ: <b style='color:green;font-size:26px'>$"..salary.."<br /><br /><div align='right'> <b style='color:White;font-size:50px'><font size=5 color=White>الخبرة: <b style='color:green;font-size:26px'>"..Config.PaycheckXP.."<b style='color:#3498DB;font-size:20px'><font size=5><p align=right><b> حوالة واردة من الخدمات الإجتماعية </font>",
						type = "info",
						timeout = 15000,
						layout = "centerLeft",
						sounds = {
						sources = {"msg.wav"}, -- For sounds to work, you place your sound in the html folder and then add it to the files array in the __resource.lua file.
						volume = 0.2,
						conditions = {"docVisible"}
						}
						})
						end
					end)
				else -- generic job
					xPlayer.addAccountMoney('bank', salary)
					TriggerClientEvent("pNotify:SendNotification",xPlayer.source, {
						text = "<h1><center><font color=yellow><i> 💲 إيداع الراتب</i></font></h1></b></center> <br /><br /><div align='right'> <b style='color:White;font-size:50px'><font size=5 color=White>المبلغ: <b style='color:green;font-size:26px'>$"..salary.."<br /><br /><div align='right'> <b style='color:White;font-size:50px'><font size=5 color=White>الخبرة: <b style='color:green;font-size:26px'>"..Config.PaycheckXP.."<b style='color:#3498DB;font-size:20px'><font size=5><p align=right><b> حوالة واردة من الخدمات الإجتماعية </font>",
						type = "info",
						timeout = 15000,
						layout = "centerLeft",
						sounds = {
						sources = {"msg.wav"}, -- For sounds to work, you place your sound in the html folder and then add it to the files array in the __resource.lua file.
						volume = 0.2,
						conditions = {"docVisible"}
						}
						})
				end
			end

		end

		SetTimeout(Config.PaycheckInterval, payCheck)
	end

	SetTimeout(Config.PaycheckInterval, payCheck)
end
