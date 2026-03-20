ESX = nil
local discord_webhook = "https://discord.com/api/webhooks/1219036530631507978/vYZ5xw0jk6ttwx_Dhwf7m5PDJYB9sxDDWdvApxwlsf7Yw_vOmvgAvuChBv9noD7zXpF9"
local discord_webhook_unban = "https://discord.com/api/webhooks/1219036530631507978/vYZ5xw0jk6ttwx_Dhwf7m5PDJYB9sxDDWdvApxwlsf7Yw_vOmvgAvuChBv9noD7zXpF9"
local bancache,namecache = {},{}
local open_assists,active_assists = {},{}

function split(s, delimiter)result = {};for match in (s..delimiter):gmatch("(.-)"..delimiter) do table.insert(result, match) end return result end

Citizen.CreateThread(function() -- startup
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    while ESX==nil do Wait(0) end
    
    MySQL.ready(function()
        refreshNameCache()
        refreshBanCache()
    end)

    ESX.RegisterServerCallback("el_bwh:ban", function(source,cb,target,reason,length,offline)
        if not target or not reason then
            return
        end
        local xPlayer = ESX.GetPlayerFromId(source)
        local xTarget = ESX.GetPlayerFromId(target)
        if not xPlayer or (not xTarget and not offline) then
            cb(nil)
            return
        end
        if isAdmin(xPlayer) then
            local success = banPlayer(xPlayer,offline and target or xTarget,reason,length,offline)
            cb(success)
        else
            logUnfairUse(xPlayer)
            cb(false)
        end
    end)

    ESX.RegisterServerCallback("el_bwh:warn",function(source,cb,target,message,anon)
        if not target or not message then return end
        local xPlayer = ESX.GetPlayerFromId(source)
        local xTarget = ESX.GetPlayerFromId(target)
        if not xPlayer or not xTarget then cb(nil); return end
        if isAdmin(xPlayer) then
            warnPlayer(xPlayer,xTarget,message,anon)
            cb(true)
        else logUnfairUse(xPlayer); cb(false) end
    end)

    ESX.RegisterServerCallback("el_bwh:getWarnList",function(source,cb)
        local xPlayer = ESX.GetPlayerFromId(source)
        if isAdmin(xPlayer) then
            local warnlist = {}
            for k,v in ipairs(MySQL.Sync.fetchAll("SELECT * FROM bwh_warnings LIMIT @limit",{["@limit"]=Config.page_element_limit})) do
                v.receiver_name=namecache[v.receiver]
                v.sender_name=namecache[v.sender]
                table.insert(warnlist,v)
            end
            cb(json.encode(warnlist),MySQL.Sync.fetchScalar("SELECT CEIL(COUNT(id)/@limit) FROM bwh_warnings",{["@limit"]=Config.page_element_limit}))
        else logUnfairUse(xPlayer); cb(false) end
    end)

    ESX.RegisterServerCallback("el_bwh:getBanList",function(source,cb)
        local xPlayer = ESX.GetPlayerFromId(source)
        if isAdmin(xPlayer) then
            local data = MySQL.Sync.fetchAll("SELECT * FROM bwh_bans LIMIT @limit",{["@limit"]=Config.page_element_limit})
            local banlist = {}
            for k,v in ipairs(data) do
                v.receiver_name = namecache[json.decode(v.receiver)[1]]
                v.sender_name = namecache[v.sender]
                table.insert(banlist,v)
            end
            cb(json.encode(banlist),MySQL.Sync.fetchScalar("SELECT CEIL(COUNT(id)/@limit) FROM bwh_bans",{["@limit"]=Config.page_element_limit}))
        else logUnfairUse(xPlayer); cb(false) end
    end)

    ESX.RegisterServerCallback("el_bwh:getListData",function(source,cb,list,page)
        local xPlayer = ESX.GetPlayerFromId(source)
        if isAdmin(xPlayer) then
            if list=="banlist" then
                local banlist = {}
                for k,v in ipairs(MySQL.Sync.fetchAll("SELECT * FROM bwh_bans LIMIT @limit OFFSET @offset",{["@limit"]=Config.page_element_limit,["@offset"]=Config.page_element_limit*(page-1)})) do
                    v.receiver_name = namecache[json.decode(v.receiver)[1]]
                    v.sender_name = namecache[v.sender]
                    table.insert(banlist,v)
                end
                cb(json.encode(banlist))
            else
                local warnlist = {}
                for k,v in ipairs(MySQL.Sync.fetchAll("SELECT * FROM bwh_warnings LIMIT @limit OFFSET @offset",{["@limit"]=Config.page_element_limit,["@offset"]=Config.page_element_limit*(page-1)})) do
                    v.sender_name=namecache[v.sender]
                    v.receiver_name=namecache[v.receiver]
                    table.insert(warnlist,v)
                end
                cb(json.encode(warnlist))
            end
        else logUnfairUse(xPlayer); cb(nil) end
    end)

    ESX.RegisterServerCallback("el_bwh:unban",function(source,cb,id)
        local xPlayer = ESX.GetPlayerFromId(source)
        if issuperadmin(xPlayer) then
            MySQL.Async.execute("UPDATE bwh_bans SET unbanned=1 WHERE id=@id",{["@id"]=id},function(rc)
                local bannedidentifier = "N/A"
                for k,v in ipairs(bancache) do
                    if v.id==id then
                        bannedidentifier = v.receiver[1]
                        bancache[k].unbanned = true
                        break
                    end
                end
                sendToDiscordunban(("Admin ^1%s^7 unbanned ^1%s^7 (%s)"):format(xPlayer.getName(),(bannedidentifier~="N/A" and namecache[bannedidentifier]) and namecache[bannedidentifier] or "N/A",bannedidentifier))
                cb(rc>0)
            end)
        else logUnfairUse(xPlayer); cb(false) end
    end)
    ESX.RegisterServerCallback("el_bwh:getIndexedPlayerList",function(source,cb)
        local xPlayer = ESX.GetPlayerFromId(source)
        if isAdmin(xPlayer) then
        	local players = {}
        	for k,v in ipairs(ESX.GetPlayers()) do
        		players[tostring(v)]=GetPlayerName(v)..(v==source and " (self)" or "")
        	end
        	cb(json.encode(players))
        else logUnfairUse(xPlayer); cb(false) end
    end)
end)

RegisterServerEvent('el_bwh:backupcheck')
AddEventHandler('el_bwh:backupcheck', function()
    local identifiers = GetPlayerIdentifiers(source)
    local banned = isBanned(identifiers)
    if banned then
        --DropPlayer(source, "Ban bypass detected, don’t join back!")
        DropPlayer(source, "أنت محظور من دخول السيرفر \n https://discord.gg/n4HuthHCYu")
    end
end)

AddEventHandler("playerConnecting",function(name, setKick, def)
    local identifiers = GetPlayerIdentifiers(source)
    if #identifiers > 0 and identifiers[1] ~= nil then
        local banned, data = isBanned(identifiers)
        namecache[identifiers[1]] = GetPlayerName(source)
        if banned then
            print(("[^1"..GetCurrentResourceName().."^7] Banned player %s (%s) tried to join, their ban expires on %s (Ban ID: #%s)"):format(GetPlayerName(source),data.receiver[1],data.length and os.date("%Y-%m-%d %H:%M",data.length) or "PERMANENT",data.id))
            local kickmsg = Config.banformat:format(data.reason,data.length and os.date("%Y-%m-%d %H:%M",data.length) or "PERMANENT",data.sender_name,data.id)
            if Config.backup_kick_method then
                DropPlayer(source,kickmsg)
            else
                def.done(kickmsg)
            end
        else
            local playername = GetPlayerName(source)
            local saneplayername = "Adjusted Playername"
            if string.gsub(playername, "[^a-zA-Z0-9]", "") ~= "" then
                saneplayername = string.gsub(playername, "[^a-zA-Z0-9 ]", "")
            end
            local data = {["@name"]=saneplayername}
            for k,v in ipairs(identifiers) do
                if split(v,":")[1] == "license" then
                    data["@"..split(v,":")[1]] = split(v,":")[2]
                else
                    data["@"..split(v,":")[1]] = v
                end
            end
            if not data["@steam"] then
	            if Config.kick_without_steam then
		            print("[^1"..GetCurrentResourceName().."^7] Player connecting without steamid, removing player from server.")
		            def.done("يجب تشغيل ستيم \n https://discord.gg/dhsPHxDDvQ")
		        else
                    print("[^1"..GetCurrentResourceName().."^7] Player connecting without steamid, skipping identifier storage.")
		        end
            else
                MySQL.Async.execute("INSERT INTO `bwh_identifiers` (`steam`, `license`, `ip`, `name`, `xbl`, `live`, `discord`, `fivem`) VALUES (@steam, @license, @ip, @name, @xbl, @live, @discord, @fivem) ON DUPLICATE KEY UPDATE `license`=@license, `ip`=@ip, `name`=@name, `xbl`=@xbl, `live`=@live, `discord`=@discord, `fivem`=@fivem",data)
            end
        end
    else
        if Config.backup_kick_method then
            DropPlayer(source,"[BWH] No identifiers were found when connecting, please reconnect")
        else
            def.done("[BWH] No identifiers were found when connecting, please reconnect")
        end
    end
end)

AddEventHandler("playerDropped",function(reason)
    if open_assists[source] then open_assists[source]=nil end
    for k,v in ipairs(active_assists) do
        if v==source then
            active_assists[k]=nil
            TriggerClientEvent("chat:addMessage",k,{color={255,0,0},multiline=false,args={"BWH","The admin that was helping you dropped from the server"}})
            return
        elseif k==source then
            TriggerClientEvent("el_bwh:assistDone",v)
            TriggerClientEvent("chat:addMessage",v,{color={255,0,0},multiline=false,args={"BWH","The player you were helping dropped from the server, teleporting back..."}})
            active_assists[k]=nil
            return
        end
    end
end)

function refreshNameCache()
    namecache={}
    for k,v in ipairs(MySQL.Sync.fetchAll("SELECT steam,name FROM bwh_identifiers")) do
        namecache[v.steam]=v.name
    end
end

function refreshBanCache()
    bancache={}
    for k,v in ipairs(MySQL.Sync.fetchAll("SELECT id,receiver,sender,reason,UNIX_TIMESTAMP(length) AS length,unbanned FROM bwh_bans")) do
        table.insert(bancache,{id=v.id,sender=v.sender,sender_name=namecache[v.sender]~=nil and namecache[v.sender] or "N/A",receiver=json.decode(v.receiver),reason=v.reason,length=v.length,unbanned=v.unbanned==1})
    end
end

function sendToDiscord(msg)
    if discord_webhook ~= "" then
        PerformHttpRequest(discord_webhook, function(a,b,c)end, "POST", json.encode({embeds={{title="تم حظر اللاعب:",description=msg:gsub("%^%d",""),color=65280,}}}), {["Content-Type"]="application/json"})
    end
end

function logAdmin(msg)
    for k,v in ipairs(ESX.GetPlayers()) do
        if isAdmin(ESX.GetPlayerFromId(v)) then
            sendToDiscord(msg)
        end
    end
end

function sendToDiscordunban(msg)
    if discord_webhook_unban ~= "" then
        PerformHttpRequest(discord_webhook_unban, function(a,b,c)end, "POST", json.encode({embeds={{title="تم فك الحظر عن ",description=msg:gsub("%^%d",""),color=65280,}}}), {["Content-Type"]="application/json"})
    end
end

function logAdminunban(msg)
    for k,v in ipairs(ESX.GetPlayers()) do
        if isAdmin(ESX.GetPlayerFromId(v)) then
            sendToDiscordunban(msg)
        end
    end
end

function isBanned(identifiers)
    for _,ban in ipairs(bancache) do
        if not ban.unbanned and (ban.length==nil or ban.length > os.time()) then
            for _,bid in ipairs(ban.receiver) do
                if bid:find("ip:") and Config.ip_ban then
                    for _,pid in ipairs(identifiers) do
                        if bid==pid then
                            return true, ban
                        end
                    end
                end
            end
        end
    end
    return false, nil
end

function isAdmin(xPlayer)
    if xPlayer.job.name == "admin" then
        return true
    else
        return false
    end
end

function issuperadmin(xPlayer)
    if xPlayer.job.name == "admin" then
        return true
    else
        return false
    end
end

function execOnAdmins(func)
    local ac = 0
    for k,v in ipairs(ESX.GetPlayers()) do
        if isAdmin(ESX.GetPlayerFromId(v)) then
            ac = ac + 1
            func(v)
        end
    end
    return ac
end

function logUnfairUse(xPlayer)
    if not xPlayer then
        return
    end
    print(("[^1"..GetCurrentResourceName().."^7] Player %s (%s) tried to use an admin feature"):format(xPlayer.getName(),xPlayer.identifier))
end

function TimerConvert(time)

	local TimerS = time

	local remainingseconds = TimerS/ 60

	local seconds = math.floor(TimerS) % 60 

	local remainingminutes = remainingseconds / 60

	local minutes = math.floor(remainingseconds) % 60

	local remaininghours = remainingminutes / 24

	local hours = math.floor(remainingminutes) % 24

	local remainingdays = remaininghours / 365

	local days = math.floor(remaininghours) % 365

	return '^0يوم : ^3' .. days .. '^0 | ' .. 'ساعة : ^3' .. hours .. '^0 | ' .. 'دقيقة : ^3' .. minutes .. '^0 | ' .. 'ثانية : ^3' .. seconds

end

function TimerConvertWaterMark(time)

	local TimerS = time

	local remainingseconds = TimerS/ 60

	local seconds = string.format("%02.f", math.floor(TimerS) % 60 )

	local remainingminutes = remainingseconds / 60

	local minutes = string.format("%02.f", math.floor(remainingseconds) % 60 )

	local remaininghours = remainingminutes / 24

	local hours = string.format("%02.f", math.floor(remainingminutes) % 24 )

	local remainingdays = remaininghours / 365

	local days = string.format("%02.f", math.floor(remaininghours) % 365 )

	if days == "00" then

		if hours == "00" then

			if minutes == "00" then

				if seconds == "00" then

					--print()

				else

					return seconds

				end
			
			else

				return "^0دقيقة:^3" .. minutes .. ' ^0| ثانية:^3' .. seconds

			end

		else

			return "^0ساعة:^3" .. hours .. ' ^0| ' .. "^0دقيقة:^3" .. minutes .. ' ^0| ثانية:^3' .. seconds

		end

	else

		return "^0يوم:^3" .. days .. " ^0| " .. "^0ساعة:^3" .. hours .. ' ^0| ' .. "^0دقيقة:^3" .. minutes .. ' ^0| ثانية:^3' .. seconds

	end

end

function banPlayer(xPlayer,xTarget,reason,length,offline)
    local lentgh2 = nil
    local targetidentifiers,offlinename,timestring,data = {},nil,nil,nil
    if offline then
        data = MySQL.Sync.fetchAll("SELECT * FROM bwh_identifiers WHERE license = @identifier",{
            ["@identifier"] = xTarget
        })
        if #data < 1 then
            return false, "لايوجد لاعب مسجل بهاذه الستيم ايدي"
        end
        offlinename = data[1].name
        for k,v in pairs(data[1]) do
            if k ~= "name" then
                table.insert(targetidentifiers,v)
            end
        end
    else
        targetidentifiers = GetPlayerIdentifiers(xTarget.source)
    end
    if length == "" then
        length = nil
    end
    local xTargetCheck = nil
    MySQL.Async.execute("INSERT INTO bwh_bans(id,receiver,sender,length,reason) VALUES(NULL,@receiver,@sender,@length,@reason)",{["@receiver"]=json.encode(targetidentifiers),["@sender"]=xPlayer.identifier,["@length"]=length,["@reason"]=reason},function(_)
        local banid = MySQL.Sync.fetchScalar("SELECT MAX(id) FROM bwh_bans")
        sendToDiscord(("^1%s^7 (%s) \n تم حظره من قبل: %s `%s` `%s` `%s`\n مدة الباند: %s\n بسبب: `%s`\n"..(offline and " (هاذه الباند اوفلاين)" or "")):format(offline and offlinename or xTarget.getName(),offline and data[1].steam or xTarget.identifier,xPlayer.getName(),GetPlayerName(xPlayer.source),xPlayer.identifier,GetPlayerIdentifiers(xPlayer.source)[5],length~=nil and length or "باند نهائي",reason))
		if length ~= nil then
            timestring=length
            local year,month,day,hour,minute = string.match(length,"(%d+)/(%d+)/(%d+) (%d+):(%d+)")
            length = os.time({year=year,month=month,day=day,hour=hour,min=minute})
        end
        table.insert(bancache,{id=banid==nil and "1" or banid,sender=xPlayer.identifier,reason=reason,sender_name=xPlayer.getName(),receiver=targetidentifiers,length=length})
        if offline then
            xTargetCheck = ESX.GetPlayerFromIdentifier(xTarget)
        else
            xTargetCheck = ESX.GetPlayerFromId(xTarget.source)
        end
        if offline and xTargetCheck then
            TriggerClientEvent("el_bwh:gotBanned",xTargetCheck.source, reason)
            TriggerClientEvent('chatMessage', -1, " ⭐ الرقابة و التفتيش  " ,  {198, 40, 40} ,  "حظر ^3" .. GetPlayerName(xTargetCheck.source) .. " ^0من دخول السيرفر بسبب ^3" .. reason .. " ^0المدة ^3" .. timestring)
            Citizen.SetTimeout(3000, function()
                DropPlayer(xTargetCheck.source,Config.banformat:format(reason,length~=nil and timestring or "PERMANENT",xPlayer.getName(),banid==nil and "1" or banid))
            end)
            return true
        elseif offline and not xTargetCheck then
            MySQL.Async.fetchAll('SELECT firstname , lastname FROM users WHERE identifier = @identifier', {
			    ['@identifier'] = xTarget,
            }, function(data)
			    if data[1] then
                    TriggerClientEvent('chatMessage', -1, " ⭐ الرقابة و التفتيش  " ,  {198, 40, 40} ,  "حظر ^3" .. data[1].firstname .. " " .. data[1].lastname .. " ^0من دخول السيرفر بسبب ^3" .. reason .. " ^0المدة ^3" .. timestring)
			    else
				    cb(false)
			    end
		    end)
            return true
        elseif not offline and xTargetCheck then
            TriggerClientEvent("el_bwh:gotBanned",xTargetCheck.source, reason)
            TriggerClientEvent('chatMessage', -1, " ⭐ الرقابة و التفتيش  " ,  {198, 40, 40} ,  "حظر ^3" .. GetPlayerName(xTargetCheck.source) .. " ^0من دخول السيرفر بسبب ^3" .. reason .. " ^0المدة ^3" .. timestring)
            Citizen.SetTimeout(3000, function()
                DropPlayer(xTargetCheck.source,Config.banformat:format(reason,length~=nil and timestring or "PERMANENT",xPlayer.getName(),banid==nil and "1" or banid))
            end)
            return true
        else
            return false, "~r~Unknown error (MySQL?)"
        end
    end)
end

function warnPlayer(xPlayer,xTarget,message,anon)
    MySQL.Async.execute("INSERT INTO bwh_warnings(id,receiver,sender,message) VALUES(NULL,@receiver,@sender,@message)",{["@receiver"]=xTarget.identifier,["@sender"]=xPlayer.identifier,["@message"]=message})
    TriggerClientEvent("el_bwh:receiveWarn",xTarget.source,anon and "" or xPlayer.getName(),message)
    logAdmin(("Admin ^1%s^7 warned ^1%s^7 (%s), Message: '%s'"):format(xPlayer.getName(),xTarget.getName(),xTarget.identifier,message))
end

AddEventHandler("el_bwh:ban",function(sender,target,reason,length,offline)
    if source=="" then -- if it's from server only
        banPlayer(sender,target,reason,length,offline)
    end
end)

AddEventHandler("el_bwh:warn",function(sender,target,message,anon)
    if source=="" then -- if it's from server only
        warnPlayer(sender,target,message,anon)
    end
end)

--[[
RegisterCommand("assist", function(source, args, rawCommand)
    local reason = table.concat(args," ")
    if reason=="" or not reason then TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"BWH","Please specify a reason"}}); return end
    if not open_assists[source] and not active_assists[source] then
        local ac = execOnAdmins(function(admin) TriggerClientEvent("el_bwh:requestedAssist",admin,GetPlayerName(source),source); TriggerClientEvent("chat:addMessage",admin,{color={0,255,255},multiline=Config.chatassistformat:find("\n")~=nil,args={"BWH",Config.chatassistformat:format(GetPlayerName(source),source,reason)}}) end)
        if ac>0 then
            open_assists[source]=reason
            Citizen.SetTimeout(120000,function()
                if open_assists[source] then open_assists[source]=nil end
                if GetPlayerName(source)~=nil then
                    TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"BWH","Your assist request has expired"}})
                end
            end)
            TriggerClientEvent("chat:addMessage",source,{color={0,255,0},multiline=false,args={"BWH","Assist request sent (expires in 120s), write ^1/cassist^7 to cancel your request"}})
        else
            TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"BWH","There's no admins on the server"}})
        end
    else
        TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"BWH","Someone is already helping your or you already have a pending assist request"}})
    end
end)

RegisterCommand("cassist", function(source, args, rawCommand)
    if open_assists[source] then
        open_assists[source]=nil
        TriggerClientEvent("chat:addMessage",source,{color={0,255,0},multiline=false,args={"BWH","Your request was successfuly cancelled"}})
        execOnAdmins(function(admin) TriggerClientEvent("el_bwh:hideAssistPopup",admin) end)
    else
        TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"BWH","You don't have any pending help requests"}})
    end
end)

RegisterCommand("finassist", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if isAdmin(xPlayer) then
        local found = false
        for k,v in pairs(active_assists) do
            if v==source then
                found = true
                active_assists[k]=nil
                TriggerClientEvent("chat:addMessage",source,{color={0,255,0},multiline=false,args={"BWH","Assist closed, teleporting back"}})
                TriggerClientEvent("el_bwh:assistDone",source)
            end
        end
        if not found then TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"BWH","You're not helping anyone"}}) end
    else
        TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"BWH","You don't have permissions to use this command!"}})
    end
end)
--]]

RegisterCommand("bwh", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if isAdmin(xPlayer) then
        if args[1]=="ban" or args[1]=="warn" or args[1]=="warnlist" then
            TriggerClientEvent("el_bwh:showWindow",source,args[1])
		elseif args[1]=="banlist" then
		--if issuperadmin(xPlayer) then
		if isAdmin(xPlayer) then
		TriggerClientEvent("el_bwh:showWindow",source,args[1])
		else
		--TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"BWH","ليس لديك صلاحيات كافية لقائمة فك الباند"}})
		TriggerClientEvent('chatMessage', source, " النظام  " ,  {198, 40, 40} ,  "ليس لديك صلاحيات كافية لقائمة فك الباند")
		end
        elseif args[1]=="refresh" then
            TriggerClientEvent("chat:addMessage",source,{color={0,255,0},multiline=false,args={"BWH","Refreshing ban & name cache..."}})
            refreshNameCache()
            refreshBanCache()
        elseif args[1]=="assists" then
            local openassistsmsg,activeassistsmsg = "",""
            for k,v in pairs(open_assists) do
                openassistsmsg=openassistsmsg.."^5ID "..k.." ("..GetPlayerName(k)..")^7 - "..v.."\n"
            end
            for k,v in pairs(active_assists) do
                activeassistsmsg=activeassistsmsg.."^5ID "..k.." ("..GetPlayerName(k)..")^7 - "..v.." ("..GetPlayerName(v)..")\n"
            end
            TriggerClientEvent("chat:addMessage",source,{color={0,255,0},multiline=true,args={"BWH","Pending assists:\n"..(openassistsmsg~="" and openassistsmsg or "^1No pending assists")}})
            TriggerClientEvent("chat:addMessage",source,{color={0,255,0},multiline=true,args={"BWH","Active assists:\n"..(activeassistsmsg~="" and activeassistsmsg or "^1No active assists")}})
        else
            --TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"BWH","Invalid sub-command! (^4ban^7,^4warn^7,^4banlist^7,^4warnlist^7,^4refresh^7)"}})
			TriggerClientEvent('chatMessage', source, "Nigeria" ,  { 255, 0, 0 } ,  "أكتب بعد الكوماند أحدى الخيارات (^4ban^7,^4banlist^7,^4refresh^7)")
        end
    else
        --TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"BWH","You don't have permissions to use this command!"}})
		TriggerClientEvent('chatMessage', source, "Nigeria" ,  {198, 40, 40} ,  "ليس لديك صلاحيات كافية")
    end
end)

function acceptAssist(xPlayer,target)
    if isAdmin(xPlayer) then
        local source = xPlayer.source
        for k,v in pairs(active_assists) do
            if v==source then
                TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"BWH","You're already helping someone"}})
                return
            end
        end
        if open_assists[target] and not active_assists[target] then
            open_assists[target]=nil
            active_assists[target]=source
            local coords = (GetConvar("onesync",false) or GetConvar("onesync_enableInfinity",false)) and GetEntityCoords(GetPlayerPed(target)) or nil
            TriggerClientEvent("el_bwh:acceptedAssist",source,target,coords)
            TriggerClientEvent("el_bwh:hideAssistPopup",source)
            TriggerClientEvent("chat:addMessage",source,{color={0,255,0},multiline=false,args={"BWH","Teleporting to player..."}})
        elseif not open_assists[target] and active_assists[target] and active_assists[target]~=source then
            TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"BWH","Someone is already helping this player"}})
        else
            TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"BWH","Player with that id did not request help"}})
        end
    else
        TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"BWH","You don't have permissions to use this command!"}})
    end
end

--[[
RegisterCommand("accassist", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local target = tonumber(args[1])
    acceptAssist(xPlayer,target)
end)
--]]

RegisterServerEvent("el_bwh:acceptAssistKey")
AddEventHandler("el_bwh:acceptAssistKey",function(target)
    if not target then return end
    local _source = source
    acceptAssist(ESX.GetPlayerFromId(_source),target)
end)
