ESX = nil
local playersHealing, deadPlayers = {}, {}
local list_kill_player = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'ambulance', _U('alert_ambulance'), true, true)

TriggerEvent('esx_society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})

if Config.EnableESXService then
    TriggerEvent('esx_service:activateService', 'ambulance', Config.MaxInService)
end


RegisterNetEvent('esx_ambulancejob:setGodModeServer')
AddEventHandler('esx_ambulancejob:setGodModeServer', function(do_what)
	TriggerClientEvent('esx_ambulancejob:setGodMode', -1, "set_true")
end)

RegisterServerEvent('esx_mechanicjob:checkIsSetXpLevelJobsWhiteList')
AddEventHandler('esx_mechanicjob:checkIsSetXpLevelJobsWhiteList', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		if Config.is_set_police_level then
			TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', xPlayer.source, 'addnoduble', 100, 'إضافة خبرة للشخص لميكانيكي بسبب تصليحة للمركبة', 'AbdurhmanOnTop')
			xPlayer.showNotification('<font color=yellow>لقد قمت بتصليح المركبة <font color=white>وحصلت على <font color=white>100 <font color=yellow>' .. "خبرة")
		else
			TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', xPlayer.source, 'addnoduble', 50, 'إضافة خبرة للشخص لميكانيكي بسبب تصليحة للمركبة', 'AbdurhmanOnTop')
			xPlayer.showNotification('<font color=yellow>لقد قمت بتصليح المركبة <font color=white>وحصلت على <font color=white>50 <font color=yellow>' .. "خبرة")
		end
	end
end)

RegisterServerEvent('esx_mechanicjob:checkIsSetXpLevelJobsWhiteList2')
AddEventHandler('esx_mechanicjob:checkIsSetXpLevelJobsWhiteList2', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		if Config.is_set_police_level then
			TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', xPlayer.source, 'addnoduble', 10, 'إضافة خبرة للشخص لميكانيكي بسبب تصليحة للمركبة', 'AbdurhmanOnTop')
			xPlayer.showNotification('<font color=yellow>لقد قمت بتنظيف المركبة <font color=white>وحصلت على <font color=white>10 <font color=yellow>' .. "خبرة")
		else
			TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', xPlayer.source, 'addnoduble', 5, 'إضافة خبرة للشخص لميكانيكي بسبب تصليحة للمركبة', 'AbdurhmanOnTop')
			xPlayer.showNotification('<font color=yellow>لقد قمت بتنظيف المركبة <font color=white>وحصلت على <font color=white>5 <font color=yellow>' .. "خبرة")
		end
	end
end)

RegisterServerEvent('esx_mechanicjob:checkIsSetXpLevelJobsWhiteList3')
AddEventHandler('esx_mechanicjob:checkIsSetXpLevelJobsWhiteList3', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		if Config.is_set_police_level then
			TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', xPlayer.source, 'addnoduble', 100, 'إضافة خبرة للشخص لميكانيكي بسبب تصليحة للمركبة', 'AbdurhmanOnTop')
			xPlayer.showNotification('<font color=yellow>لقد قمت بسمكرة المركبة <font color=white>وحصلت على <font color=white>100 <font color=yellow>' .. "خبرة")
		else
			TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', xPlayer.source, 'addnoduble', 50, 'إضافة خبرة للشخص لميكانيكي بسبب تصليحة للمركبة', 'AbdurhmanOnTop')
			xPlayer.showNotification('<font color=yellow>لقد قمت بسمكرة المركبة <font color=white>وحصلت على <font color=white>50 <font color=yellow>' .. "خبرة")
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:setAnimationDead')
AddEventHandler('esx_ambulancejob:setAnimationDead', function()
	TriggerClientEvent('esx_animations:do_ani_dead', source, "shot")
end)

RegisterNetEvent('esx_ambulancejob:m3gon:removeBlipAfterDead:server')
AddEventHandler('esx_ambulancejob:m3gon:removeBlipAfterDead:server', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		TriggerClientEvent("esx_misc:addPlayerToMiscDead", -1, xPlayer.identifier, "remove")
		local xPlayers = ESX.GetPlayers()
		for x=1, #xPlayers, 1 do
			local xPlayerA = ESX.GetPlayerFromId(xPlayers[x])
			if xPlayerA then
				if xPlayerA.job.name == "ambulance" then
					TriggerClientEvent('esx_ambulancejob:m3gon:removeBlipAfterDead', xPlayerA.source, xPlayer.source)
				end
			end
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function(playerId, is_ambulance)
	local xPlayer = ESX.GetPlayerFromId(source)
	local money_count = 0
	local xplevel = 0
	if xPlayer and xPlayer.job.name == 'ambulance' then
		money_count = Config.PriceRevivePlayer[xPlayer.job.grade].price
		xplevel = 500
	end
	if xPlayer and xPlayer.job.name == 'ambulance' or xPlayer.job.name == 'police' or xPlayer.job.name == 'agent' or xPlayer.job.name == 'admin' then
		local xTarget = ESX.GetPlayerFromId(playerId)
		if xTarget then
			if Config.is_set_police_level then
				xplevel = 500
				if is_ambulance then
					--print()
				else
					TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
						account.addMoney(money_count)
					end)
					xPlayer.showNotification("<font size=5 color=white><center><b>تقرير <font color=FF0000>الأنعاش</font><font size=5 color=white><center><b><font color=00FF00>لقد انعشت</font> " .. xTarget.getName() .. "<p align=center><b>: لقد كسبت مكافاة<font size=5 color=white><center><b><font color=00FF00>$</font><font color=00FF00>مبلغ</font> : " .. money_count .. "<p align=center><b><font color=0080FF>خبرة</font> : <font color=0080FF>" .. xplevel .. "</font>")
					TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', xPlayer.source, 'addnoduble', xplevel, 'مكافأة الأنعاش للمسعف')
					xPlayer.addMoney(money_count)
				end
				xTarget.triggerEvent('esx_ambulancejob:revive')
			else
				if is_ambulance then
					--print()
				else
					TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
						account.addMoney(money_count)
					end)
					xplevel = 500
					xPlayer.showNotification("<font size=5 color=white><center><b>تقرير <font color=FF0000>الأنعاش</font><font size=5 color=white><center><b><font color=00FF00>لقد انعشت</font> " .. xTarget.getName() .. "<p align=center><b>: لقد كسبت مكافاة<font size=5 color=white><center><b><font color=00FF00>$</font><font color=00FF00>مبلغ</font> : " .. money_count .. "<p align=center><b><font color=0080FF>خبرة</font> : <font color=0080FF>" .. xplevel .. "</font>")
					TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', xPlayer.source, 'addnoduble', xplevel, 'مكافأة الأنعاش للمسعف')
					xPlayer.addMoney(money_count)
				end
				xTarget.triggerEvent('esx_ambulancejob:revive')
			end
		else
			xPlayer.showNotification(_U('revive_fail_offline'))
		end
	end
end)

RegisterNetEvent('esx:swapPlayerTovehicle')
AddEventHandler('esx:swapPlayerTovehicle', function(type, hospital, part, partNum)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.triggerEvent('esx:OpenVehicleSpawnerMenu', type, hospital, part, partNum)
end)
RegisterNetEvent('esx_ambulancejob:sendToAllPlayersNotficiton')
AddEventHandler('esx_ambulancejob:sendToAllPlayersNotficiton', function(jobsGradePlayer)
	local Player = ESX.GetPlayerFromId(source)
	local name_player = Player.getName()
	local Players = ESX.GetPlayers()
	for i = 1, #Players, 1 do
		local xPlayer = ESX.GetPlayerFromId(Players[i])
		if xPlayer.job.name == 'ambulance' then
			xPlayer.showNotification('<font color=yellow>اعلان خدمة موظف</font>' .. '<font size=5 color=white><center><b><font color=FF0000> ' .. jobsGradePlayer .. '<font size=5 color=white><center><b><font color=00CC00>تسجيل دخول <font color=FFFFFF>' .. name_player)
		end
	end
end)

RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	deadPlayers[source] = 'dead'
end)

RegisterNetEvent('esx:emitMessagetoems')
AddEventHandler('esx:emitMessagetoems', function(id)
	local xPlayer  = ESX.GetPlayerFromId(id)
	local numbersofems = {}
	MySQL.Async.fetchAll('SELECT phone_number FROM users WHERE job = @job',{["@job"] = "admin"}, function(result)
		numbersofems = result
		for k,v in pairs(numbersofems) do
			for x,y in pairs(v) do
				local msg = {
					"104-073-9078",
					y,
					"يوجد شخص مسقط"
				}
				exports.npwd:emitMessage(msg)
			end
		end
	end)

end)

RegisterNetEvent('esx_ambulancejob:chat')
AddEventHandler('esx_ambulancejob:chat', function(deathType, hospitalLabel)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    local user = xPlayer.getName()
    local rpname = user
		--TriggerClientEvent('chat:addMessage', -1, { args = { ""..hospitalLabel.."^7 : ^3"..rpname.." ^4"..Config.deathTypeMsg[deathType]   }, color = { 0, 0, 0 } })
		TriggerClientEvent('chatMessage', -1, hospitalLabel.."^7 " ,  {198, 40, 40} ,  "^3" .. rpname .. " ^4"..Config.deathTypeMsg[deathType])

end)

function GetRPName(playerId, data)
	local Identifier = ESX.GetPlayerFromId(playerId).identifier

	MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		data(result[1].firstname, result[1].lastname)

	end)
end

RegisterServerEvent('esx_ambulancejob:svsearch')
AddEventHandler('esx_ambulancejob:svsearch', function()
  TriggerClientEvent('esx_ambulancejob:clsearch', -1, source)
end)

RegisterNetEvent('esx_ambulancejob:onPlayerDistress')
AddEventHandler('esx_ambulancejob:onPlayerDistress', function()
end)

RegisterNetEvent('esx:onPlayerSpawn')
AddEventHandler('esx:onPlayerSpawn', function()
	if deadPlayers[source] then
		deadPlayers[source] = nil
	end
end)

RegisterNetEvent("esx_admin_or_defcon:checkJobs")
AddEventHandler("esx_admin_or_defcon:checkJobs", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		TriggerClientEvent('esx_misc:updatePromotionStatus', xPlayer.source, 'police_level', Config.is_set_police_level)
	end
end)

RegisterServerEvent('esx_adminjob:is_set_police_level')
AddEventHandler('esx_adminjob:is_set_police_level', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		if xPlayer.job.name == "admin" then
			if not Config.is_set_police_level then
				Config.is_set_police_level = true
				TriggerClientEvent("esx_misc:watermark_promotion", -1, 'police_level', true)
			else
				Config.is_set_police_level = false
				TriggerClientEvent("esx_misc:watermark_promotion", -1, 'police_level', false)
			end
		end
	end
end)

RegisterServerEvent('esx_adminjob:fine')
AddEventHandler('esx_adminjob:fine', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if Config.is_set_police_level then
		TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', source, 'addnoduble', 100, 'إضافة خبرة لشخص لانه رجل أمن وحرر مخالفة لشخص', 'AbdurhmanOnTop')
		xPlayer.showNotification('<font color=yellow>تحرير مخالفة' .. '<font color=white> لقد كسبت <font color=green>100 <font color=white>خبرة بسبب تحريرك للمخالفة لشخص')
	else
		TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', source, 'addnoduble', 50, 'إضافة خبرة لشخص لانه رجل أمن وحرر مخالفة لشخص', 'AbdurhmanOnTop')
		xPlayer.showNotification('<font color=yellow>تحرير مخالفة' .. '<font color=white> لقد كسبت <font color=green>50 <font color=white>خبرة بسبب تحريرك للمخالفة لشخص')
	end
end)

RegisterNetEvent('esx_close:en')
AddEventHandler('esx_close:en', function(idplayer)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(idplayer)
	xTarget.setCoords(xPlayer.getCoords())
end)

RegisterServerEvent('esx_adminjob:jailPolice')
AddEventHandler('esx_adminjob:jailPolice', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if Config.is_set_police_level then
		TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', source, 'addnoduble', 100, 'إضافة خبرة لشخص لانه رجل أمن وسجن شخص', 'AbdurhmanOnTop')
		xPlayer.showNotification('<font color=yellow>سجن شخص' .. '<font color=white> لقد كسبت <font color=green>100 <font color=white>خبرة بسبب سجنك لشخص')
	else
		TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', source, 'addnoduble', 50, 'إضافة خبرة لشخص لانه رجل أمن وسجن شخص', 'AbdurhmanOnTop')
		xPlayer.showNotification('<font color=yellow>سجن شخص' .. '<font color=white> لقد كسبت <font color=green>50 <font color=white>خبرة بسبب سجنك لشخص')
	end
end)

ESX.RegisterServerCallback('esx_adminjob:getNameplayer', function(source, cb, id_player)
	local xPlayer = ESX.GetPlayerFromId(id_player)
	if xPlayer then
		cb({name = xPlayer.getName(), id = xPlayer.source, coords_player = xPlayer.getCoords(true)})
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(list_kill_player) do
			if list_kill_player[k].time <= 0 then
				list_kill_player[k] = nil
			else
				list_kill_player[k].time = list_kill_player[k].time - 1
			end
		end
	end
end)

function SendDiscordLogDeadPlayer(info_player_is_dead, info)
	local message = "**لقد قام الاعب** : \n" .. info.name .. "\n\n**رقم الأستيم :** \n" .. info.identifier .. "\n\n**اسم الأستيم :** \n" .. info.steam .. "\n\n**الوظيفة :** \n" .. info.job_label .. " - " .. info.grade_label .. "\n\n**ب قتل الاعب : **\n" .. info_player_is_dead.name .. " " .. info_player_is_dead.identifier .. " | " .. info_player_is_dead.steam
	local DiscordWebHook = "https://discord.com/api/webhooks/1219044887609999421/aA0Ope2SjBWnI1gFxftKz6Yqlhl-gDouwKXsuPHPY9cOa-oxfX4pPpyV_497liWOnp1E"

  	local embeds = {
	  	{
		  	["title"]=  message,
		  	["type"]="rich",
		  	["color"] = 0000,
		  	["footer"]=  {
			  	["text"]= "قتل لاعب",
		 	},
	  	}
  	}
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = "قتل لاعب",embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
RegisterNetEvent('esx:SendMessageCodeDeath')
AddEventHandler('esx:SendMessageCodeDeath', function(PlayerIdServer)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(PlayerIdServer)
	if xTarget then
		SendDiscordLogDeadPlayer({name = xPlayer.getName(), identifier = xPlayer.identifier, steam = GetPlayerName(xPlayer.source), job_label = xPlayer.getJob().label, grade_label = xPlayer.getJob().grade_label}, {name = xTarget.getName(), identifier = xTarget.identifier, steam = GetPlayerName(xTarget.source), job_label = xTarget.getJob().label, grade_label = xTarget.getJob().grade_label})
	end
	if PlayerIdServer == source then
		--print()
	else
		if xTarget and xPlayer then
			if xTarget.job.name == 'police' or xTarget.job.name == "agent" then
				if xPlayer.job.name == 'admin' then
					TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', PlayerIdServer, 'remove', 1000, 'خصم خبرة من شخص لانه قتل المراقب خبرة للشخص', 'AbdurhmanOnTop')
					TriggerClientEvent("pNotify:SendNotification", xTarget.source, {
						text = "<font size=5 color=orange><center><b><font color=yellow>محاولة قتل مراقب</font>"..
						"<font size=5 color=white><center><b><font color=white>لقد خصم منك : <font color=red>1000</font><font size=5 color=white><center><b><font color=#1E90FF> خبرة</font>",
						type = 'alert',
						queue = left,
						timeout = 10000,
						killer = false,
						theme = "gta",
						layout = "CenterLeft",
						sounds = {
						sources = {"Reward.wav"},
						volume = 0.2,
						conditions = {"docVisible"}
						},
					})
					TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
						text = 		"</br><font size=3><p align=right><b><font color=yellow>بيانات القاتل</font>"..
						"</br><font size=3><p align=right><b>الهوية: <font color=gold>"..xTarget.getName().."</font>"..
						"</br><font size=3><p align=right><b>ستيم: <font color=gray>"..GetPlayerName(xTarget.source).."</font>"..
						"</br><font size=3><p align=right><b><font color=red>في حال لديك شكوى احفظ تصوير وارفع تكت</font>",
						type = "info",
						queue = "right",
						timeout = 60000,
						layout = "centerright"
					})
				elseif xPlayer.job.name == 'mechanic' then
					TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', PlayerIdServer, 'remove', 500, 'خصم خبرة من شخص لانه قتل ميكانيكي خبرة للشخص', 'AbdurhmanOnTop')
					TriggerClientEvent("pNotify:SendNotification", xTarget.source, {
						text = "<font size=5 color=orange><center><b><font color=yellow>محاولة قتل ميكانيكي</font>"..
						"<font size=5 color=white><center><b><font color=white>لقد خصم منك : <font color=red>350</font><font size=5 color=white><center><b><font color=#1E90FF> خبرة</font>",
						type = 'alert',
						queue = left,
						timeout = 10000,
						killer = false,
						theme = "gta",
						layout = "CenterLeft",
						sounds = {
						sources = {"Reward.wav"},
						volume = 0.2,
						conditions = {"docVisible"}
						},
					})
					TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
						text = 		"</br><font size=3><p align=right><b><font color=yellow>بيانات القاتل</font>"..
						"</br><font size=3><p align=right><b>الهوية: <font color=gold>"..xTarget.getName().."</font>"..
						"</br><font size=3><p align=right><b>ستيم: <font color=gray>"..GetPlayerName(xTarget.source).."</font>"..
						"</br><font size=3><p align=right><b><font color=red>في حال لديك شكوى احفظ تصوير وارفع تكت</font>",
						type = "info",
						queue = "right",
						timeout = 60000,
						layout = "centerright"
					})
				elseif xPlayer.job.name == 'ambulance' then
					TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', PlayerIdServer, 'remove', 500, 'خصم خبرة من شخص لانه قتل مسعف خبرة للشخص', 'AbdurhmanOnTop')
					TriggerClientEvent("pNotify:SendNotification", xTarget.source, {
						text = "<font size=5 color=orange><center><b><font color=yellow>محاولة قتل مسعف</font>"..
						"<font size=5 color=white><center><b><font color=white>لقد خصم منك : <font color=red>500</font><font size=5 color=white><center><b><font color=#1E90FF> خبرة</font>",
						type = 'alert',
						queue = left,
						timeout = 10000,
						killer = false,
						theme = "gta",
						layout = "CenterLeft",
						sounds = {
						sources = {"Reward.wav"},
						volume = 0.2,
						conditions = {"docVisible"}
						},
					})
					TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
						text = 		"</br><font size=3><p align=right><b><font color=yellow>بيانات القاتل</font>"..
						"</br><font size=3><p align=right><b>الهوية: <font color=gold>"..xTarget.getName().."</font>"..
						"</br><font size=3><p align=right><b>ستيم: <font color=gray>"..GetPlayerName(xTarget.source).."</font>"..
						"</br><font size=3><p align=right><b><font color=red>في حال لديك شكوى احفظ تصوير وارفع تكت</font>",
						type = "info",
						queue = "right",
						timeout = 60000,
						layout = "centerright"
					})
				elseif xPlayer.job.name == "police" then
					--print()
				elseif xPlayer.job.name == "agent" then
					--print()
				else
					if Config.is_set_police_level then
						TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', PlayerIdServer, 'addnoduble', 100, 'إضافة خبرة لشخص لانه رجل أمن وقتل مجرم', 'AbdurhmanOnTop')
						TriggerClientEvent("pNotify:SendNotification", xTarget.source, {
							text = "<font size=5 color=orange><center><b><font color=yellow>محاولة قتل مجرم</font>"..
							"<font size=5 color=white><center><b><font color=white>لقد كسبت : <font color=green>100</font><font size=5 color=white><center><b><font color=#1E90FF> خبرة</font>",
							type = 'alert',
							queue = left,
							timeout = 10000,
							killer = false,
							theme = "gta",
							layout = "CenterLeft",
							sounds = {
							sources = {"Reward.wav"},
							volume = 0.2,
							conditions = {"docVisible"}
							},
						})
						TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
							text = "</br><font size=3><p align=right><b><font color=yellow>بيانات القاتل</font>"..
							"</br><font size=3><p align=right><b>الهوية: <font color=gold>"..xTarget.getName().."</font>"..
							"</br><font size=3><p align=right><b>ستيم: <font color=gray>"..GetPlayerName(xTarget.source).."</font>"..
							"</br><font size=3><p align=right><b><font color=red>في حال لديك شكوى احفظ تصوير وارفع تكت</font>",
							type = "info",
							queue = "right",
							timeout = 60000,
							layout = "centerright"
						})
					else
						TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', PlayerIdServer, 'addnoduble', 50, 'إضافة خبرة لشخص لانه رجل أمن وقتل مجرم', 'AbdurhmanOnTop')
						TriggerClientEvent("pNotify:SendNotification", xTarget.source, {
							text = "<font size=5 color=orange><center><b><font color=yellow>محاولة قتل مجرم</font>"..
							"<font size=5 color=white><center><b><font color=white>لقد كسبت : <font color=green>50</font><font size=5 color=white><center><b><font color=#1E90FF> خبرة</font>",
							type = 'alert',
							queue = left,
							timeout = 10000,
							killer = false,
							theme = "gta",
							layout = "CenterLeft",
							sounds = {
							sources = {"Reward.wav"},
							volume = 0.2,
							conditions = {"docVisible"}
							},
						})
						TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
							text = 		"</br><font size=3><p align=right><b><font color=yellow>بيانات القاتل</font>"..
							"</br><font size=3><p align=right><b>الهوية: <font color=gold>"..xTarget.getName().."</font>"..
							"</br><font size=3><p align=right><b>ستيم: <font color=gray>"..GetPlayerName(xTarget.source).."</font>"..
							"</br><font size=3><p align=right><b><font color=red>في حال لديك شكوى احفظ تصوير وارفع تكت</font>",
							type = "info",
							queue = "right",
							timeout = 60000,
							layout = "centerright"
						})
					end
				end
			elseif xPlayer.job.name == 'police' or xPlayer.job.name == 'agent' then
				if list_kill_player[xTarget.source] then
					list_kill_player[xTarget.source].amount = list_kill_player[xTarget.source].amount + 100
					TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', PlayerIdServer, 'remove', list_kill_player[xTarget.source].amount, 'خصم خبرة لشخص لانه قتل رجل أمن', 'AbdurhmanOnTop')
					TriggerClientEvent("pNotify:SendNotification", xTarget.source, {
						text = "<font size=5 color=orange><center><b><font color=yellow>محاولة قتل رجل أمن</font>"..
						"<font size=5 color=white><center><b><font color=white>لقد خصم منك : <font color=red>" .. list_kill_player[xTarget.source].amount .. "</font><font size=5 color=white><center><b><font color=#1E90FF> خبرة</font><font size=5 color=white><center><b><font color=orange> خلال اخر 15 دقيقة</font>",
						type = 'alert',
						queue = left,
						timeout = 10000,
						killer = false,
						theme = "gta",
						layout = "CenterLeft",
						sounds = {
						sources = {"Reward.wav"},
						volume = 0.2,
						conditions = {"docVisible"}
						},
					})
					TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
						text = 		"</br><font size=3><p align=right><b><font color=yellow>بيانات القاتل</font>"..
						"</br><font size=3><p align=right><b>الهوية: <font color=gold>"..xTarget.getName().."</font>"..
						"</br><font size=3><p align=right><b>ستيم: <font color=gray>"..GetPlayerName(xTarget.source).."</font>"..
						"</br><font size=3><p align=right><b><font color=red>في حال لديك شكوى احفظ تصوير وارفع تكت</font>",
						type = "info",
						queue = "right",
						timeout = 60000,
						layout = "centerright"
					})
				else
					list_kill_player[xTarget.source] = {time = 900, amount = 100}
					TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', PlayerIdServer, 'remove', list_kill_player[xTarget.source].amount, 'خصم خبرة لشخص لانه قتل رجل أمن', 'AbdurhmanOnTop')
					TriggerClientEvent("pNotify:SendNotification", xTarget.source, {
						text = "<font size=5 color=orange><center><b><font color=yellow>محاولة قتل رجل أمن</font>"..
						"<font size=5 color=white><center><b><font color=white>لقد خصم منك : <font color=red>" .. list_kill_player[xTarget.source].amount .. "</font><font size=5 color=white><center><b><font color=#1E90FF> خبرة</font><font size=5 color=white><center><b><font color=orange> خلال اخر 15 دقيقة</font>",
						type = 'alert',
						queue = left,
						timeout = 10000,
						killer = false,
						theme = "gta",
						layout = "CenterLeft",
						sounds = {
						sources = {"Reward.wav"},
						volume = 0.2,
						conditions = {"docVisible"}
						},
					})
					TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
						text = 		"</br><font size=3><p align=right><b><font color=yellow>بيانات القاتل</font>"..
						"</br><font size=3><p align=right><b>الهوية: <font color=gold>"..xTarget.getName().."</font>"..
						"</br><font size=3><p align=right><b>ستيم: <font color=gray>"..GetPlayerName(xTarget.source).."</font>"..
						"</br><font size=3><p align=right><b><font color=red>في حال لديك شكوى احفظ تصوير وارفع تكت</font>",
						type = "info",
						queue = "right",
						timeout = 60000,
						layout = "centerright"
					})
				end
			elseif xPlayer.job.name == 'mechanic' then
				TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', PlayerIdServer, 'remove', 500, 'خصم خبرة من شخص لانه قتل ميكانيكي خبرة للشخص', 'AbdurhmanOnTop')
				TriggerClientEvent("pNotify:SendNotification", xTarget.source, {
					text = "<font size=5 color=orange><center><b><font color=yellow>محاولة قتل ميكانيكي</font>"..
					"<font size=5 color=white><center><b><font color=white>لقد خصم منك : <font color=red>350</font><font size=5 color=white><center><b><font color=#1E90FF> خبرة</font>",
					type = 'alert',
					queue = left,
					timeout = 10000,
					killer = false,
					theme = "gta",
					layout = "CenterLeft",
					sounds = {
					sources = {"Reward.wav"},
					volume = 0.2,
					conditions = {"docVisible"}
					},
				})
			elseif xPlayer.job.name == 'ambulance' then
				TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', PlayerIdServer, 'remove', 500, 'خصم خبرة من شخص لانه قتل مسعف خبرة للشخص', 'AbdurhmanOnTop')
				TriggerClientEvent("pNotify:SendNotification", xTarget.source, {
					text = "<font size=5 color=orange><center><b><font color=yellow>محاولة قتل مسعف</font>"..
					"<font size=5 color=white><center><b><font color=white>لقد خصم منك : <font color=red>500</font><font size=5 color=white><center><b><font color=#1E90FF> خبرة</font>",
					type = 'alert',
					queue = left,
					timeout = 10000,
					killer = false,
					theme = "gta",
					layout = "CenterLeft",
					sounds = {
					sources = {"Reward.wav"},
					volume = 0.2,
					conditions = {"docVisible"}
					},
				})
			elseif xPlayer.job.name == 'admin' then
				TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', PlayerIdServer, 'remove', 1000, 'خصم خبرة من شخص لانه قتل المراقب خبرة للشخص', 'AbdurhmanOnTop')
				TriggerClientEvent("pNotify:SendNotification", xTarget.source, {
					text = "<font size=5 color=orange><center><b><font color=yellow>محاولة قتل مراقب</font>"..
					"<font size=5 color=white><center><b><font color=white>لقد خصم منك : <font color=red>1000</font><font size=5 color=white><center><b><font color=#1E90FF> خبرة</font>",
					type = 'alert',
					queue = left,
					timeout = 10000,
					killer = false,
					theme = "gta",
					layout = "CenterLeft",
					sounds = {
					sources = {"Reward.wav"},
					volume = 0.2,
					conditions = {"docVisible"}
					},
				})
				TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
					text = 		"</br><font size=3><p align=right><b><font color=yellow>بيانات القاتل</font>"..
					"</br><font size=3><p align=right><b>الهوية: <font color=gold>"..xTarget.getName().."</font>"..
					"</br><font size=3><p align=right><b>ستيم: <font color=gray>"..GetPlayerName(xTarget.source).."</font>"..
					"</br><font size=3><p align=right><b><font color=red>في حال لديك شكوى احفظ تصوير وارفع تكت</font>",
					type = "info",
					queue = "right",
					timeout = 60000,
					layout = "centerright"
				})
			else
				TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
					text = 		"</br><font size=3><p align=right><b><font color=yellow>بيانات القاتل</font>"..
					"</br><font size=3><p align=right><b>الهوية: <font color=gold>"..xTarget.getName().."</font>"..
					"</br><font size=3><p align=right><b>ستيم: <font color=gray>"..GetPlayerName(xTarget.source).."</font>"..
					"</br><font size=3><p align=right><b><font color=red>في حال لديك شكوى احفظ تصوير وارفع تكت</font>",
					type = "info",
					queue = "right",
					timeout = 60000,
					layout = "centerright"
				})
			end
		end
	end
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
	if deadPlayers[playerId] then
		deadPlayers[playerId] = nil
	end
	local xPlayers = ESX.GetPlayers()
	for x=1, #xPlayers, 1 do
		local xPlayerA = ESX.GetPlayerFromId(xPlayers[x])
		if xPlayerA then
			if xPlayerA.job.name == "ambulance" then
				TriggerClientEvent('esx_ambulancejob:m3gon:removeBlipAfterDead', xPlayerA.source, coords, source)
			end
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(target, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:heal', target, type)
	end
end)

RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:putInVehicle', target)
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function(source, cb, deathType)
	local xPlayer = ESX.GetPlayerFromId(source)
	if deathType == 1 then
		if Config.RemoveCashAfterRPDeath then
			if xPlayer.getMoney() > 0 then
				xPlayer.removeMoney(xPlayer.getMoney())
			end

			if xPlayer.getAccount('black_money').money > 0 then
				xPlayer.setAccountMoney('black_money', 0)
			end
		end

		if Config.RemoveItemsAfterRPDeath then
			for i=1, #xPlayer.inventory, 1 do
				if xPlayer.inventory[i].count > 0 then
					xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
				end
			end
		end

		local playerLoadout = {}
		if Config.RemoveWeaponsAfterRPDeath then
			for i=1, #xPlayer.loadout, 1 do
				if xPlayer.job.name == "admin" or xPlayer.job.name == "police" or xPlayer.job.name == "agent" then
					--print('')
				else
					xPlayer.removeWeapon(xPlayer.loadout[i].name)
				end
			end
		else -- save weapons & restore em' since spawnmanager removes them
			for i=1, #xPlayer.loadout, 1 do
				table.insert(playerLoadout, xPlayer.loadout[i])
			end

			-- give back wepaons after a couple of seconds
			Citizen.CreateThread(function()
				Citizen.Wait(5000)
				for i=1, #playerLoadout, 1 do
					if playerLoadout[i].label ~= nil then
						xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
					end
				end
			end)
		end

		cb()
	elseif deathType == 0 then

		TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', xPlayer.source, 'addnoduble', 100, 'إضافة خبرة لشخص لانه تحلل ومااختار الانتقال للمستشفى', 'AbdurhmanOnTop')

		if Config.RemoveCashAfterRPDeath then
			if xPlayer.getMoney() > 0 then
				local math_money = math.floor(xPlayer.getMoney() / 2)
				TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
					text = "<font size=5 color=white><center><b>تقرير <font color=FF0000>المستشفى</font><font size=5 color=white><center><b><font color=orange>شكراّ لألتزامك ب الأنظمة و القوانين</font><font size=5 color=white><center><b><font color=orange>:</font> وعدم اختيارك للأنتقال اثناء وجود<font size=5 color=white><center><b><font color=FF0000>المسعف</font><font size=5 color=white><center><b>او<font size=5 color=white><center><b><font color=0080FF>رجال الأمن</font><p align=center><b>: تقرير خصم الأموال لديك<font size=5 color=white><center><b><font color=00FF00>$</font><font color=00FF00>إجمالي أموالك</font> : " .. xPlayer.getMoney() .. "<font size=5 color=white><center><b><font color=orange>تم خصم نصف المبلغ</font> من <font color=00FF00>الكاش</font><font size=5 color=white><center><b><font color=00FF00>$</font><font color=00FF00>نصف المبلغ المخصوم</font> : " .. math_money .. "<p align=center><b>لقد كسبت <font color=0080FF>خبرة</font> مكافأة<p align=center><b><font color=0080FF>خبرة</font> : <font color=0080FF>100</font>",
					type = 'alert',
					queue = left,
					timeout = 50000,
					killer = false,
					theme = "gta",
					layout = "CenterLeft",
					sounds = {
					sources = {"Reward.wav"},
					volume = 0.2,
					conditions = {"docVisible"}
					},
				})
				xPlayer.removeMoney(math_money)
			end

			if xPlayer.getAccount('black_money').money > 0 then
				xPlayer.setAccountMoney('black_money', 0)
			end
		end

		if Config.RemoveItemsAfterRPDeath then
			for i=1, #xPlayer.inventory, 1 do
				if xPlayer.inventory[i].count > 0 then
					xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
				end
			end
		end

		local playerLoadout = {}
		if Config.RemoveWeaponsAfterRPDeath then
			for i=1, #xPlayer.loadout, 1 do
				if xPlayer.job.name == "admin" or xPlayer.job.name == "police" or xPlayer.job.name == "agent" then
					--print('')
				else
					xPlayer.removeWeapon(xPlayer.loadout[i].name)
				end
			end
		else -- save weapons & restore em' since spawnmanager removes them
			for i=1, #xPlayer.loadout, 1 do
				table.insert(playerLoadout, xPlayer.loadout[i])
			end

			-- give back wepaons after a couple of seconds
			Citizen.CreateThread(function()
				Citizen.Wait(5000)
				for i=1, #playerLoadout, 1 do
					if playerLoadout[i].label ~= nil then
						xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
					end
				end
			end)
		end

		cb()
	end
end)

if Config.EarlyRespawnFine then
	ESX.RegisterServerCallback('esx_ambulancejob:checkBalance', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local bankBalance = xPlayer.getAccount('bank').money

		cb(bankBalance >= Config.EarlyRespawnFineAmount)
	end)

	RegisterNetEvent('esx_ambulancejob:payFine')
	AddEventHandler('esx_ambulancejob:payFine', function()
		local xPlayer = ESX.GetPlayerFromId(source)
		local fineAmount = Config.EarlyRespawnFineAmount

		xPlayer.showNotification(_U('respawn_bleedout_fine_msg', ESX.Math.GroupDigits(fineAmount)))
		xPlayer.removeAccountMoney('bank', fineAmount)
	end)
end

ESX.RegisterServerCallback('esx_ambulancejob:checpoliceandas3af', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

ESX.RegisterServerCallback('esx_ambulancejob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

ESX.RegisterServerCallback('esx_ambulancejob:buyJobVehicle', function(source, cb, vehicleProps, type, name)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
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

ESX.RegisterServerCallback('esx_ambulancejob:checkPlayerIsDead', function(source, cb, PlayerIdServer)
	local xTarget = ESX.GetPlayerFromId(PlayerIdServer)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		if xTarget then
			MySQL.Async.fetchAll('SELECT is_dead FROM users WHERE identifier = @identifier',
			{
				['@identifier'] = xTarget.identifier,
			}, function(data)
				if data[1] then
					local dead_number = data[1].is_dead
					if dead_number == true then
						cb(true)
					else
						cb(false)
					end
				end
			end)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:checkDeadPlayer', function(source, cb, PlayerIdServer)
	local xTarget = ESX.GetPlayerFromId(PlayerIdServer)
	local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT is_dead FROM users WHERE identifier = @identifier',
    {
        ['@identifier'] = xTarget.identifier,
    }, function(data)
        if data[1] then
			local dead_number = data[1].is_dead
			if dead_number == true then
				cb({status = true, job_me = xPlayer.job.name})
			else
				cb({status = false, job_me = xPlayer.job.name})
			end
		end
	end)
end)

ESX.RegisterServerCallback('esx_ambulancejob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
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

RegisterNetEvent('esx_ambulancejob:removeItem')
AddEventHandler('esx_ambulancejob:removeItem', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item, 1)

	if item == 'bandage' then
		xPlayer.showNotification(_U('used_bandage'))
	elseif item == 'medikit' then
		xPlayer.showNotification(_U('used_medikit'))
	end
end)

RegisterNetEvent('esx_ambulancejob:giveItem')
AddEventHandler('esx_ambulancejob:giveItem', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'ambulance' then
		--print(('[esx_ambulancejob] [^2INFO^7] "%s" attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	elseif (itemName ~= 'medikit' and itemName ~= 'bandage') then
		--print(('[esx_ambulancejob] [^2INFO^7] "%s" attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	end

	if xPlayer.canCarryItem(itemName, amount) then
		xPlayer.addInventoryItem(itemName, amount)
	else
		xPlayer.showNotification(_U('max_item'))
	end
end)

ESX.RegisterCommand('revive', 'admin', function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx_ambulancejob:revive')
end, true, {help = _U('revive_help'), validate = true, arguments = {
	{name = 'playerId', help = 'The player id', type = 'player'}
}})

ESX.RegisterUsableItem('medikit', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('medikit', 1)

		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'medikit')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('bandage', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('bandage', 1)

		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'bandage')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:getDeathStatus', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchScalar('SELECT is_dead FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(isDead)
		if isDead then
			print(('[esx_ambulancejob] [^2INFO^7] "%s" attempted combat logging'):format(xPlayer.identifier))
		end

		cb(isDead)
	end)
end)

RegisterNetEvent('esx_ambulancejob:setPlayerDeadAnim')
AddEventHandler('esx_ambulancejob:setPlayerDeadAnim', function(id_player, data, type)
	if type == "srer" then
		TriggerClientEvent('is_want_set_in_srer', id_player, data)
	else
		TriggerClientEvent('is_want_revive', id_player, data)
		Citizen.Wait(1000)
		if not data then
			--print()
		else
			TriggerClientEvent('esx_ambulancejob:setPlayerDeadAnim:client', id_player)
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:playerdeadblip')
AddEventHandler('esx_ambulancejob:playerdeadblip', function(coords)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		TriggerClientEvent("esx_misc:addPlayerToMiscDead", -1, xPlayer.identifier, "add")
		local xPlayers = ESX.GetPlayers()
		for x=1, #xPlayers, 1 do
			local xPlayerA = ESX.GetPlayerFromId(xPlayers[x])
			if xPlayerA then
				if xPlayerA.job.name == "ambulance" then
					TriggerClientEvent('esx_ambulancejob:playerdeadblip:client', xPlayerA.source, coords, xPlayer.source)
				end
			end
		end
	end
end)


RegisterNetEvent('esx_ambulancejob:setDeathStatus')
AddEventHandler('esx_ambulancejob:setDeathStatus', function(isDead)
	local xPlayer = ESX.GetPlayerFromId(source)
	if type(isDead) == 'boolean' then
		MySQL.Sync.execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier,
			['@isDead'] = isDead
		})
	end
end)

RegisterCommand("movesrer", function(source, args, raw)
	local player = source
	if (player > 0) then
		TriggerClientEvent("ARPF-EMS:pushstreacherss", source)
		CancelEvent()
	end
end, false)

RegisterCommand("setplayerinsrer", function(source, args, raw)
	local player = source
	if (player > 0) then
		TriggerClientEvent("ARPF-EMS:togglestrincar", source)
		CancelEvent()
	end
end, false)
