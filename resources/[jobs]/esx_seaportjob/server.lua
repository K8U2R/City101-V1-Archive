ESX = nil
local Promotion = false

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("esx_seaportjob:getPaid")
AddEventHandler("esx_seaportjob:getPaid", function(packetsDelivered, t)
    local xPlayer = ESX.GetPlayerFromId(source)
    local pay = 0
    local xp = 0
	if t == 'K2md%2adk2GHG90jJ' then
	
	if packetsDelivered >= 1 then
	pay = pay + Config.pay * packetsDelivered
	xp = xp + Config.xp * packetsDelivered
	end
	
	if Promotion then
	pay = pay*2
	end
	
	if pay >= 1 then
	xPlayer.addAccountMoney('bank', pay)
	end
	if xp >= 1 then
    TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', source, 'add', xp, 'شركة خدمات الموانئ esx_seaportjob:getPaid', 'AbdurhmanOnTop')
	end
	
	TriggerClientEvent("pNotify:SendNotification", source, {
		text = "<font size=5 color=#FFA54C><center><b>شركة خدمات الموانئ ⚓</font>"..
		"<font size=5 color=white><center><b>"..
		"<font size=5 color=white><center><b> عدد الشحنات: <font color=gold>"..packetsDelivered.."</font>"..
		"<font size=5 color=white><center><b> المبلغ: <font color=green>$"..pay.."</font>"..
		"<font size=5 color=white><center><b> خبرة: <font color=#5DADE2>"..xp.."</font>",
		type = 'alert',
		queue = left,
		timeout = 10000,
		killer = false,
		theme = "gta",
		layout = "CenterLeft",
	})
    else
	print(('esx_seaportjob: %s attempted to get Paid !'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_misc:GetCache')
AddEventHandler('esx_misc:GetCache', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("esx_misc:updatePromotionStatus", source, 'fork', Promotion)
end)

RegisterServerEvent("esx_seaportjob:togglePromotion_duble") -- ضعف الأجر
AddEventHandler("esx_seaportjob:togglePromotion_duble", function(job)
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = GetPlayerName(source)
    local steamIdentifiers = GetPlayerIdentifiers(source)[1]
    local discordIdentifiers = GetPlayerIdentifiers(source)[5]
    local ingamename = xPlayer.getName()
	if xPlayer.job.name == 'admin' and xPlayer.getGroup() == "superadmin" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "aplus" or xPlayer.getGroup() == "a" or xPlayer.getGroup() == "modplus" then
    if not Promotion then
    Promotion = true
	TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"بدأ ضعف أجر شركة خدمات الموانئ", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",16705372)
	else
	Promotion = false
	TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"إنتهاء ضعف أجر شركة خدمات الموانئ", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",15158332)
    end
	TriggerClientEvent("esx_misc:watermark_promotion", -1, 'fork', Promotion)
  else
  print(('esx_seaportjob: %s attempted to toggle Promotion (not admin!)!'):format(xPlayer.identifier))
  end
end)