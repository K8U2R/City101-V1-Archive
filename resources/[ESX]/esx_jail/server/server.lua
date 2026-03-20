ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("jail", function(src, args, raw)

	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer["job"]["name"] == "admin" then

		local jailPlayer = args[1]
		local jailTime = tonumber(args[2])
		local jailReason = args[3]

		if GetPlayerName(jailPlayer) ~= nil then

			if jailTime ~= nil then
				JailPlayer(jailPlayer, jailTime)

				TriggerClientEvent("esx:showNotification", src, " دقيقة" .. jailTime .. " تم سجنه"..GetPlayerName(jailPlayer))
				
				if args[3] ~= nil then
					GetRPName(jailPlayer, function(Firstname, Lastname)
					    TriggerClientEvent('chatMessage', -1, " ⭐ الرقابة والتفتيش " ,  {198, 40, 40} ,  " تمت احالة المدعو/ ^3" ..Firstname .. " " .. Lastname .. " ^0الى السجن بعد إدانته بتهمة ^3مخالفة النظام العام^0 لمدة ^3"..jailTime.." ^0شهر ^3")
					end)
				end
			else
				TriggerClientEvent("esx:showNotification", src, "ﺊﻃﺎﺧ ﻦﺠﺴﻟﺍ ﺓﺪﻣ")
			end
		else
			TriggerClientEvent("esx:showNotification", src, "ﺩﻮﺟﻮﻣ ﺮﻴﻏ ﻑﺮﻌﻤﻟﺍ ﺐﺣﺎﺻ")
		end
	else
		TriggerClientEvent("esx:showNotification", src, "صلاحيتك لاتسمح")
	end
end)

RegisterCommand("unjail", function(src, args, raw)
	
	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer then

		if xPlayer["job"]["name"] == "admin" then

			local src = source

			local targetid = args[1]

			local xTarget = ESX.GetPlayerFromId(targetid)
		
			if xTarget ~= nil then

				UnJail(xTarget.source)

			else

				MySQL.Async.execute("UPDATE users SET jail = @newJailTime WHERE identifier = @identifier", {
					['@identifier'] = targetid,
					['@newJailTime'] = 0
				})

			end
		
			TriggerClientEvent("esx:showNotification", src, xPlayer.name .. " تم فك السجن")

		else

			TriggerClientEvent("esx:showNotification", src, "صلاحيتك لاتسمح")

		end

	end

end)


RegisterCommand("removevisa", function(src, args, raw)

	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer["job"]["name"] == "admin" then

		local jailPlayer = args[1]
		local jailTime = tonumber(args[2])
		local jailledPlayer = ESX.GetPlayerFromId(jailPlayer)

		if GetPlayerName(jailPlayer) ~= nil then

			if jailTime ~= nil then
				JailPlayer(jailPlayer, jailTime)

				TriggerClientEvent("esx:showNotification", src, " ﺔﻘﻴﻗﺩ" .. jailTime .. " ﻪﻨﺠﺳ ﻢﺗ"..GetPlayerName(jailPlayer))
				--TriggerClientEvent("esx:showpNotifyNotification", jailledPlayer.source, "لقد تم سحب التأشيرة الخاصة بك يرجى تسجيل الخروج والدخول مجددا لإجتياز الإختبار مرة أخرى - سيتم الإفراج عنك بعد حصولك على التأشيرة مجددا")
				for k, v in pairs(Config.Msg["other"]["citizen"]["notification"]) do 
					Config.Options.text = v
					TriggerClientEvent("pNotify:SendNotification", jailledPlayer.source, Config.Options)
					--Citizen.Wait(5000)
				end
				
			else
				TriggerClientEvent("esx:showNotification", src, "ﺊﻃﺎﺧ ﻦﺠﺴﻟﺍ ﺓﺪﻣ")
			end
		else
			TriggerClientEvent("esx:showNotification", src, "ﺩﻮﺟﻮﻣ ﺮﻴﻏ ﻑﺮﻌﻤﻟﺍ ﺐﺣﺎﺻ")
		end
	else
		TriggerClientEvent("esx:showNotification", src, "ﺕﺎﻴﺣﻼﺼﻟﺍ ﻚﻠﻤﺗﻻ")
	end
end)

--Remove Visa
RegisterNetEvent('esx_visa:KickAndRemoveVisa')
AddEventHandler('esx_visa:KickAndRemoveVisa', function(player, reason)
    local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(player)
    if xPlayer.job.name == 'admin' and xPlayer.getGroup()=='superadmin' then
	TriggerEvent('esx_license:removeLicense', player, 'visa')
	JailPlayer(player, 15)
	DropPlayer(player, 'تم سحب تأشيرتك و طردك من المقاطعة')
	local chat1 = "⭐ الرقابة و التفتيش "
	local chat2 = " تم سحب تأشيرة ^3 ".. ESX.GetPlayerFromId(player).name .. "^0 السبب : ^3 " .. reason
	TriggerClientEvent('chatMessage', -1, chat1, {198, 40, 40}, chat2)
	print(('esx_adminjob: %s attempted to remove visa to Player %s'):format(xPlayer.identifier,xTarget.identifier))
	else
	print(('esx_adminjob: %s attempted to remove visa to Player (not adminjob!)!'):format(xPlayer.identifier))
	end
end)

--Remove Visa
RegisterNetEvent('esx_visa:KickAndRemoveVisaPlayer')
AddEventHandler('esx_visa:KickAndRemoveVisaPlayer', function(player, reason)
    local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(player)
	TriggerEvent('esx_license:removeLicense', player, 'visa')
	JailPlayer(player, 30)
	DropPlayer(player, 'تم سحب تأشيرتك و طردك من مدينة 101 / بسبب قتل رقابي')
	local chat1 = "⭐ الرقابة و التفتيش "
	local chat2 = " تم سحب تأشيرة ^3 ".. ESX.GetPlayerFromId(player).name .. "^0 السبب : ^3 " .. reason
	TriggerClientEvent('chatMessage', -1, chat1, {198, 40, 40}, chat2)
	print(('esx_adminjob: remove visa to Player %s'):format(xTarget.identifier))
end)

RegisterServerEvent("esx_jail:jailPlayer")
AddEventHandler("esx_jail:jailPlayer", function(targetSrc, jailTime, jailReason)
	local src = source
	local targetSrc = tonumber(targetSrc)
	local xTarget = ESX.GetPlayerFromId(targetSrc)
	local xPlayer = ESX.GetPlayerFromId(src)
    local user = xPlayer.getName()
    local rpname = user	
	if xPlayer.job.name == "police" or xPlayer.job.name == "admin" or xPlayer.job.name == "agent" then
		JailPlayer(targetSrc, jailTime)
		TriggerClientEvent('esx_threb:swapToserverJailedCheck', xTarget.source)
		if xPlayer["job"]["name"] == "police" then
			TriggerClientEvent('chatMessage', -1, " إدارة الشرطة 👮 | " .. rpname .." " ,  { 17, 69, 191 } ,  " تمت احالة المدعو/ ^3" .. xTarget.getName() .. " ^0الى السجن بعد إدانته بتهمة ^3" .. jailReason.."^0 لمدة ^3"..jailTime.." ^0شهر ^3")
		elseif xPlayer["job"]["name"] == "agent" then
			TriggerClientEvent('chatMessage', -1, " حرس الحدود  💂 | " .. rpname .." " ,  { 78, 198, 78 } ,  " تمت احالة المدعو/ ^3" .. xTarget.getName() .. " ^0الى السجن بعد إدانته بتهمة ^3" .. jailReason.."^0 لمدة ^3"..jailTime.." ^0شهر ^3")		
		else
			TriggerClientEvent('chatMessage', -1, " ⭐ الرقابة والتفتيش " ,  { 198, 40, 40 } ,  " تمت احالة المدعو/ ^3" .. xTarget.getName() .. " ^0الى السجن بعد إدانته بتهمة ^3" .. jailReason.."^0 لمدة ^3"..jailTime.." ^0شهر ^3")
		end
	
		TriggerClientEvent("esx:showNotification", src, GetPlayerName(targetSrc) .. " سجن لمدة " .. jailTime .. " دقيقة!")
	else
		print("this id player " .. xPlayer.source .. " and this iden player" .. xPlayer.identifier .. " is attempt to jail player")
	end
end)



RegisterServerEvent("esx_jail:unJailPlayer")
AddEventHandler("esx_jail:unJailPlayer", function(targetIdentifier)
	local src = source
	local xPlayer = ESX.GetPlayerFromIdentifier(targetIdentifier)

	if xPlayer ~= nil then
		TriggerClientEvent("esx_jail:updateTimerJail", xPlayer.source)
		Citizen.Wait(5000)
		UnJail(xPlayer.source)
		TriggerClientEvent("esx:showNotification", src, xPlayer.name .. " تم اعفائك")
	else
		MySQL.Async.execute(
			"UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
			{
				['@identifier'] = targetIdentifier,
				['@newJailTime'] = 0
			}
		)
	end
end)

RegisterServerEvent("esx_jail:updateJailTime")
AddEventHandler("esx_jail:updateJailTime", function(newJailTime)
	local src = source

	EditJailTime(src, newJailTime)
end)

RegisterServerEvent("esx_jail:prisonWorkReward")
AddEventHandler("esx_jail:prisonWorkReward", function()
	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)

	xPlayer.addMoney(math.random(13, 21))

	TriggerClientEvent("esx:showNotification", src, "Thanks, here you have som cash for food!")
end)

function JailPlayer(jailPlayer, jailTime)
	TriggerClientEvent("esx_jail:jailPlayer", jailPlayer, jailTime)

	EditJailTime(jailPlayer, jailTime)
end

function UnJail(jailPlayer)
	TriggerClientEvent("esx_jail:unJailPlayer", jailPlayer)

	EditJailTime(jailPlayer, 0)
end

function EditJailTime(source, jailTime)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier

	MySQL.Async.execute(
       "UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
        {
			['@identifier'] = Identifier,
			['@newJailTime'] = tonumber(jailTime)
		}
	)
end

function GetRPName(playerId, data)
	local Identifier = ESX.GetPlayerFromId(playerId).identifier

	MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		data(result[1].firstname, result[1].lastname)

	end)
end

ESX.RegisterServerCallback("esx_jail:retrieveJailedPlayers", function(source, cb)
	
	local jailedPersons = {}

	MySQL.Async.fetchAll("SELECT firstname, lastname, jail, identifier FROM users WHERE jail > @jail", { ["@jail"] = 0 }, function(result)

		for i = 1, #result, 1 do
			table.insert(jailedPersons, { name = result[i].firstname .. " " .. result[i].lastname, jailTime = result[i].jail, identifier = result[i].identifier })
		end

		cb(jailedPersons)
	end)
end)