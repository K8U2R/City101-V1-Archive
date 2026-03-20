ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--Send the message to your discord server
function sendToDiscord (name,message,color, webhook)
  local DiscordWebHook = webhook
  -- Modify here your discordWebHook username = name, content = message,embeds = embeds

local embeds = {
    {
        ["title"]=message,
        ["type"]="rich",
        ["color"] =color,
        ["footer"]=  {
            ["text"]= os.date("%x %X %p"),
       },
    }
}

  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function sendToDiscordMain (name,title,message,color, webhook)
  local DiscordWebHook = webhook
  -- Modify here your discordWebHook username = name, content = message,embeds = embeds

local embeds = {
    {
        ["title"]=title,
        ["type"]="rich",
		["description"] = message,
        ["color"] =color,
        ["footer"]=  {
            ["text"]= os.date("%x %X %p"),
       },
    }
}

  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end


-- Send the first notification
sendToDiscord(_U('server'),_U('server_start'),Config.green, Config.ServerStart)

-- Event when a player is writing
RegisterServerEvent("esx:chatMessagelog")
AddEventHandler('esx:chatMessagelog', function(rpname, message)
  if(settings.LogChatServer)then
     sendToDiscord(_U('server_chat'), rpname .." : "..message,Config.grey, Config.Chat)
  end
end)


-- Event when a player is connecting
RegisterServerEvent("esx:playerconnected")
AddEventHandler('esx:playerconnected', function()
  if(settings.LogLoginServer)then
    sendToDiscord(_U('server_connecting'), GetPlayerName(source) .." ".. _('user_connecting'),Config.grey , Config.Login)
  end
end)

-- Event when a player is disconnecting
AddEventHandler('playerDropped', function(reason)
  if(settings.LogLoginServer)then
    sendToDiscord(_U('server_disconnecting'), GetPlayerName(source) .." ".. _('user_disconnecting') .. "("..reason..")",Config.grey, Config.Logout)
  end
end)



-- Add event when a player give an item
--  TriggerEvent("esx:giveitembywesam",sourceXPlayer.name,targetXPlayer.name,ESX.Items[itemName].label,itemCount) -> ESX_extended
RegisterServerEvent("esx:giveitembywesam")
AddEventHandler("esx:giveitembywesam", function(name,nametarget,itemname,amount)
   if(settings.LogItemTransfer)then
    sendToDiscord(_U('server_item_transfer'),name.._('user_gives_to')..nametarget.." "..amount .." "..itemname,Config.orange, Config.GiveItem)
   end

end)

-- Add event when a player give money
-- TriggerEvent("esx:givemoneybywesam",sourceXPlayer.name,targetXPlayer.name,itemCount) -> ESX_extended
RegisterServerEvent("esx:givemoneyLog")
AddEventHandler("esx:givemoneyLog", function(pas,source,sourcetarget,ac,amount)
   if pas == "a2pd278hKKnds" then
   local xPlayer = ESX.GetPlayerFromId(source)
   local xTarget = ESX.GetPlayerFromId(sourcetarget)
   local ids = ExtractIdentifiers(source)
   local ids2 = ExtractIdentifiers(sourcetarget)
   local lavoro = xPlayer.job.label
   local grado = xPlayer.job.grade_label
   local lavoro2 = xTarget.job.label
   local grado2 = xTarget.job.grade_label
    _steamID ="**Steam ID:  ** " ..ids.steam..""
    _discordID ="**Discord:  ** <@" ..ids.discord:gsub("discord:", "")..">"
    _identifierID ="**identifier:  ** " ..xPlayer.identifier..""
	
	_steamID2 ="**Steam ID:  ** " ..ids2.steam..""
    _discordID2 ="**Discord:  ** <@" ..ids2.discord:gsub("discord:", "")..">"
	_identifierID2 ="**identifier:  ** " ..xTarget.identifier..""
    if ac == 'money' then 
	ac = 'كاش'
	elseif ac == 'black_money' then
	ac = 'اموال حمراء(قذرة)'
	end
  --if(settings.LogMoneyTransfer)then
    --sendToDiscord(_U('server_money_transfer'),name.." ".._('user_gives_to').." "..nametarget.." "..amount .." dollars",Config.orange, Config.GiveMoney)
	if amount > 5000 then
    sendToDiscordMain(('تبادل أموال كاش بين المواطنين'),"تبادل فلوس بين مواطن ومواطن اخر بأكثر من 5 الف","قام "..xPlayer.getName().." | `"..GetPlayerName(source).."`\n "..lavoro.." - " ..grado.."\n".._steamID.."\n".._identifierID.."\n".._discordID.."\nبإعطاء:"..xTarget.getName().." | `"..GetPlayerName(sourcetarget).."`\n"..lavoro2.." - " ..grado2.."\n".._steamID2.."\n".._identifierID2.."\n".._discordID2.."\n المبلغ: `"..amount.."`\nنوع المال: `"..ac.."`",Config.red, "https://discord.com/api/webhooks/1219050571366006914/KApSQ0XJ4ucJLFPdXmnwk2iP2oeHU6AmoDpyAsRrcredB4maLTusw4svkwibpqYLRzVR")
	PerformHttpRequest("https://discord.com/api/webhooks/1219050571366006914/KApSQ0XJ4ucJLFPdXmnwk2iP2oeHU6AmoDpyAsRrcredB4maLTusw4svkwibpqYLRzVR", function(err, text, headers) end, 'POST', json.encode({ username = 'تبادل مال بأكثر من 5 ألف', content = '@everyone تنبيه !'}), { ['Content-Type'] = 'application/json' })
	end
    sendToDiscordMain(('تبادل أموال كاش بين المواطنين'),"تبادل فلوس بين مواطن ومواطن اخر","قام "..xPlayer.getName().." | `"..GetPlayerName(source).."`\n "..lavoro.." - " ..grado.."\n".._steamID.."\n".._identifierID.."\n".._discordID.."\nبإعطاء:"..xTarget.getName().." | `"..GetPlayerName(sourcetarget).."`\n"..lavoro2.." - " ..grado2.."\n".._steamID2.."\n".._identifierID2.."\n".._discordID2.."\n المبلغ: `"..amount.."`\nنوع المال: `"..ac.."`",Config.orange, Config.GiveMoney)
  end

   --end
end)

RegisterServerEvent("esx:dropitemLog")
AddEventHandler("esx:dropitemLog", function(pas,id,type,itemName,itemCount,coords)
   if pas == "kn29ndKK2an290" then
   local xPlayer = ESX.GetPlayerFromId(id)
   local ids = ExtractIdentifiers(id)
   local lavoro = xPlayer.job.label
   local grado = xPlayer.job.grade_label
    _steamID ="**Steam ID:  ** " ..ids.steam..""
    _discordID ="**Discord:  ** <@" ..ids.discord:gsub("discord:", "")..">"
    _identifierID ="**identifier:  ** " ..xPlayer.identifier..""
    if(type=='item_account')then
    sendToDiscordMain(('التخلص من شيء'),"التخلص من شيء بالأرض",xPlayer.getName().." | `"..GetPlayerName(id).."`\n "..lavoro.." - " ..grado.."\n".._steamID.."\n".._identifierID.."\n".._discordID.."\nالتخلص من مال\nالنوع: `"..itemName.."`\nالعدد: $`"..itemCount.."`\nأحداثيات التخلص: `"..coords.."`",Config.orange, "https://discord.com/api/webhooks/1219051009108873246/L_0qVAYrEoPee2DxZTT8O_WIw7Q1y-7lsUw0kUNTtzRaQ1xxpSssOjmHpDsUv1_LL921")
	else
	sendToDiscordMain(('التخلص من شيء'),"التخلص من شيء بالأرض",xPlayer.getName().." | `"..GetPlayerName(id).."`\n "..lavoro.." - " ..grado.."\n".._steamID.."\n".._identifierID.."\n".._discordID.."\nالأيتم: `"..xPlayer.getInventoryItem(itemName).label.."`\nالكود: `"..itemName.."`\nالعدد: `"..itemCount.."`\nأحداثيات التخلص: `"..coords.."`",Config.orange, "https://discord.com/api/webhooks/1219051009108873246/L_0qVAYrEoPee2DxZTT8O_WIw7Q1y-7lsUw0kUNTtzRaQ1xxpSssOjmHpDsUv1_LL921")
  end
  end
end)

RegisterServerEvent("esx:onPickupLog")
AddEventHandler("esx:onPickupLog", function(pas,id,type,itemName,itemCount,coords)
   if pas == "Kj27bvKKuwp2" then
   local xPlayer = ESX.GetPlayerFromId(id)
   local ids = ExtractIdentifiers(id)
   local lavoro = xPlayer.job.label
   local grado = xPlayer.job.grade_label
    _steamID ="**Steam ID:  ** " ..ids.steam..""
    _discordID ="**Discord:  ** <@" ..ids.discord:gsub("discord:", "")..">"
    _identifierID ="**identifier :  ** " ..xPlayer.identifier..""
    if(type=='item_account')then
    sendToDiscordMain(('التقاط شيء من الأرض'),"ألتقاط مال من الأرض",xPlayer.getName().." | `"..GetPlayerName(id).."`\n "..lavoro.." - " ..grado.."\n".._steamID.."\n".._identifierID.."\n".._discordID.."\nالنوع: `"..itemName.."`\nالعدد: $`"..itemCount.."`\nأحداثيات الألتقاط: `"..coords.."`",Config.green, "https://discord.com/api/webhooks/1219051009108873246/L_0qVAYrEoPee2DxZTT8O_WIw7Q1y-7lsUw0kUNTtzRaQ1xxpSssOjmHpDsUv1_LL921")
	else
	sendToDiscordMain(('التقاط شيء من الأرض'),"ألتقاط شيء من الأرض",xPlayer.getName().." | `"..GetPlayerName(id).."`\n "..lavoro.." - " ..grado.."\n".._steamID.."\n".._identifierID.."\n".._discordID.."\nالأيتم: `"..xPlayer.getInventoryItem(itemName).label.."`\nالكود: `"..itemName.."`\nالعدد: `"..itemCount.."`\nأحداثيات الألتقاط: `"..coords.."`",Config.green, "https://discord.com/api/webhooks/1219051009108873246/L_0qVAYrEoPee2DxZTT8O_WIw7Q1y-7lsUw0kUNTtzRaQ1xxpSssOjmHpDsUv1_LL921")
  end
  end
end)

-- Add event when a player give money
-- TriggerEvent("esx:givebankbywesam",sourceXPlayer.name,targetXPlayer.name,itemCount) -> ESX_extended
RegisterServerEvent("esx:givebankbywesam")
AddEventHandler("esx:givebankbywesam", function(name,nametarget,amount)
  if(settings.LogMoneyBankTransfert)then
   sendToDiscord(_U('server_moneybank_transfer'),name.." ".. _('user_gives_to') .." "..nametarget.." "..amount .." dollars",Config.orange , Config.GiveBankMoney)
  end

end)


-- Add event when a player give weapon
--  TriggerEvent("esx:giveweaponbywesam",sourceXPlayer.name,targetXPlayer.name,weaponLabel) -> ESX_extended
RegisterServerEvent("esx:giveweaponbywesam")
AddEventHandler("esx:giveweaponbywesam", function(name,nametarget,weaponlabel)
  if(settings.LogWeaponTransfer)then
    sendToDiscord(_U('server_weapon_transfer'),name.." ".._('user_gives_to').." "..nametarget.." "..weaponlabel,Config.orange , Config.GiveWeapon)
  end

end)

-- Add event when a player is washing money
--  TriggerEvent("esx:washmoneybywesam",xPlayer.name,amount) -> ESX_society
RegisterServerEvent("esx:washmoneybywesam")
AddEventHandler("esx:washmoneybywesam", function(name,amount)
  sendToDiscord(_U('server_washingmoney'),name.." ".._('user_washingmoney').." ".. amount .." dollars",Config.orange , Config.WashMoney)

end)

-- Event when a player is in a blacklisted vehicle
RegisterServerEvent("esx:enterblacklistedcar")
AddEventHandler("esx:enterblacklistedcar", function(model)
   local xPlayer = ESX.GetPlayerFromId(source)
   sendToDiscord(_U('server_blacklistedvehicle'),xPlayer.name.." ".._('user_entered_in').." ".. model ,Config.red, Config.BlacklistedCar)

end)


-- Event when a player (not policeman) is in a police vehicle
RegisterServerEvent("esx:enterpolicecar")
AddEventHandler("esx:enterpolicecar", function(model)
 	 local xPlayer = ESX.GetPlayerFromId(source)
 	 sendToDiscord(_U('server_policecar'),xPlayer.name.." ".._('user_entered_in').." ".. model , Config.blue , Config.EnterPoliceCar)

end)

function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = "",
        fivem = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
		elseif string.find(id, "fivem") then
            identifiers.fivem = id
        end
    end

    return identifiers
end
