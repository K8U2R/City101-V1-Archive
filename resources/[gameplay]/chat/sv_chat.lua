ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

function ChatLog (name, title, message, color)
	local DiscordWebHook = "https://discord.com/api/webhooks/1219042054080954458/dWSxtUwu67ekKPddmy5ONs_5jpi1TCvdOT8GYIfTc_x_lZj3HLB7ShKoi3Bx-9cepxrM" -- الديسكورد الرئيسي
	
	local embeds = {
		{
			["title"]=title,
			["type"]="rich",
            ["description"] = message,
			["color"] =color,
			["footer"]=  { ["text"]= "شات مدينة 101 "}
		}
	}
	
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function ChatLogToLogsDisocrd (name, title, message, color)
	local DiscordWebHook = "https://discord.com/api/webhooks/1219042054080954458/dWSxtUwu67ekKPddmy5ONs_5jpi1TCvdOT8GYIfTc_x_lZj3HLB7ShKoi3Bx-9cepxrM" -- سيرفر الوقات
	
	local embeds = {
		{
			["title"]=title,
			["type"]="rich",
            ["description"] = message,
			["color"] =color,
			["footer"]=  { ["text"]= "شات مدينة 101  "}
		}
	}
	
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

-- this is a built-in event, but somehow needs to be registered
RegisterNetEvent('playerJoining')

exports('addMessage', function(target, message)
    if not message then
        message = target
        target = -1
    end

    if not target or not message then return end

    TriggerClientEvent('chat:addMessage', target, message)
end)

AddEventHandler('_chat:messageEntered', function(author, color, message)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local user = xPlayer.getName()
    local rpname = user

    if not message or not author then
        return
    end

  --  TriggerEvent('chatMessage', source, author, message)
	  	
    if not WasEventCanceled() then
        if xPlayer["job"]["name"] == "police" then
            TriggerClientEvent('chatMessage', -1, "إدارة الشرطة 👮 | " .. rpname .." " ,  { 30,144,255 }, message, xPlayer.source)
            ChatLog((' سجل رسائل مدينة 101   '),"  👮 إدارة الشرطة [`"..rpname.."`] (id: `"..source.."`)" , "`"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[6].."` | \n``"..GetPlayerIdentifiers(source)[5].."`` \n msg :\n`"..message.."`",مدينة 10181046)
            ChatLogToLogsDisocrd((' سجل رسائل مدينة 101   '),"  👮 إدارة الشرطة [`"..rpname.."`] (id: `"..source.."`)" , "`"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[6].."` | \n``"..GetPlayerIdentifiers(source)[5].."`` \n msg :\n`"..message.."`",مدينة 10181046)
        elseif xPlayer["job"]["name"] == "admin" then
            TriggerClientEvent('chatMessage', -1, " ⭐ الرقابة و التفتيش  " ,  {198, 40, 40} , message, xPlayer.source)
            --ChatLog((' وقت راحة ')," اعلان وقت راحة | المدة "..time.."دقيقة ", "*من قبل المراقب* \n\nSteam: `".. GetPlayerName(source).."` \n "..GetPlayerIdentifiers(source)[1].." \nInGame name: `"..xPlayer.getName().."`",مدينة 10181046)
            ChatLog((' سجل رسائل مدينة 101   '),"  الرقابة و التفتيش [`"..rpname.."`] (id: `"..source.."`)" , "`"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[6].."` | \n``"..GetPlayerIdentifiers(source)[5].."`` \n msg :\n`"..message.."`",مدينة 10181046)
            ChatLogToLogsDisocrd((' سجل رسائل مدينة 101   '),"  الرقابة و التفتيش [`"..rpname.."`] (id: `"..source.."`)" , "`"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[6].."` | \n``"..GetPlayerIdentifiers(source)[5].."`` \n msg :\n`"..message.."`",مدينة 10181046)
        elseif xPlayer["job"]["name"] == "ary" then
            TriggerClientEvent('chatMessage', -1, " ⭐ متجر مدينة مدينة 101    " ,  {198, 40, 40} , message, xPlayer.source)
            --ChatLog((' وقت راحة ')," اعلان وقت راحة | المدة "..time.."دقيقة ", "*من قبل المراقب* \n\nSteam: `".. GetPlayerName(source).."` \n "..GetPlayerIdentifiers(source)[1].." \nInGame name: `"..xPlayer.getName().."`",مدينة 10181046)
            ChatLog((' سجل رسائل مدينة 101   '),"  ⭐ متجر    [`"..rpname.."`] (id: `"..source.."`)" , "`"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[6].."` | \n``"..GetPlayerIdentifiers(source)[5].."`` \n msg :\n`"..message.."`",مدينة 10181046)
            ChatLogToLogsDisocrd((' سجل رسائل مدينة 101   '),"  ⭐ متجر مدينة 101    [`"..rpname.."`] (id: `"..source.."`)" , "`"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[6].."` | \n``"..GetPlayerIdentifiers(source)[5].."`` \n msg :\n`"..message.."`",مدينة 10181046)
        elseif xPlayer["job"]["name"] == "cardealer" then
            TriggerClientEvent('chatMessage', -1, " 🚗 معرض مدينة 101   | " .. rpname .. " " ,  { 156, 0, 78 } , message, xPlayer.source)
            ChatLog((' سجل رسائل معرض مدينة 101   '),"  🚗 معرض مدينة 101   [`"..rpname.."`] (id: `"..source.."`)" , "`"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[6].."` | \n``"..GetPlayerIdentifiers(source)[5].."`` \n msg :\n`"..message.."`",مدينة 10181046)
            ChatLogToLogsDisocrd((' سجل رسائل معرض مدينة 101   '),"  🚗 معرض مدينة 101   [`"..rpname.."`] (id: `"..source.."`)" , "`"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[6].."` | \n``"..GetPlayerIdentifiers(source)[5].."`` \n msg :\n`"..message.."`",مدينة 10181046)
        elseif xPlayer["job"]["name"] == "agent" then
            TriggerClientEvent('chatMessage', -1, "💂‍ امن المنشات  | " .. rpname .." " ,  { 78, 198, 78 }, message, xPlayer.source)	
            ChatLog((' سجل رسائل مدينة 101   '),"  💂‍ امن المنشات [`"..rpname.."`] (id: `"..source.."`)" , "`"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[6].."` | \n``"..GetPlayerIdentifiers(source)[5].."`` \n msg :\n`"..message.."`",مدينة 10181046)
            ChatLogToLogsDisocrd((' سجل رسائل مدينة 101   '),"  💂‍ امن المنشات [`"..rpname.."`] (id: `"..source.."`)" , "`"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[6].."` | \n``"..GetPlayerIdentifiers(source)[5].."`` \n msg :\n`"..message.."`",مدينة 10181046)
        elseif xPlayer["job"]["name"] == "ambulance" then
            TriggerClientEvent('chatMessage', -1, " 🚨 الدفاع المدني | " .. rpname .." " ,  { 196, 20, 20 }, message, xPlayer.source)		
            ChatLog((' سجل رسائل مدينة 101   '),"  🚨 الدفاع المدني [`"..rpname.."`] (id: `"..source.."`)" , "`"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[6].."` | \n``"..GetPlayerIdentifiers(source)[5].."`` \n msg :\n`"..message.."`",مدينة 10181046)
            ChatLogToLogsDisocrd((' سجل رسائل مدينة 101   '),"  🚨 الدفاع المدني [`"..rpname.."`] (id: `"..source.."`)" , "`"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[6].."` | \n``"..GetPlayerIdentifiers(source)[5].."`` \n msg :\n`"..message.."`",مدينة 10181046)
        elseif xPlayer["job"]["name"] == "mechanic" then
            TriggerClientEvent('chatMessage', -1, "🔧 كراج الميكانيك | " .. rpname .." " ,  {220,220,220}, message, xPlayer.source)	
            ChatLog((' سجل رسائل مدينة 101   '),"  🔧 كراج الميكانيك [`"..rpname.."`] (id: `"..source.."`)" , "`"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[6].."` | \n``"..GetPlayerIdentifiers(source)[5].."``\n msg :\n`"..message.."`",مدينة 10181046)
            ChatLogToLogsDisocrd((' سجل رسائل مدينة 101   '),"  🔧 كراج الميكانيك [`"..rpname.."`] (id: `"..source.."`)" , "`"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[6].."` | \n``"..GetPlayerIdentifiers(source)[5].."``\n msg :\n`"..message.."`",مدينة 10181046)
        elseif xPlayer["job"]["name"] == "dynasty" then
            TriggerClientEvent('chatMessage', -1, "عقاري مدينة 101   | " .. rpname .." " ,  { 0,255,0 }, message, xPlayer.source)	
            ChatLog((' سجل رسائل مدينة 101   '),"عقاري مدينة 101   [`"..rpname.."`] (id: `"..source.."`)" , "`"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[6].."` | \n``"..GetPlayerIdentifiers(source)[5].."`` \n msg :\n`"..message.."`",مدينة 10181046)		
            ChatLogToLogsDisocrd((' سجل رسائل مدينة 101   '),"عقاري مدينة 101   [`"..rpname.."`] (id: `"..source.."`)" , "`"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[6].."` | \n``"..GetPlayerIdentifiers(source)[5].."`` \n msg :\n`"..message.."`",مدينة 10181046)		
        end
    end
end)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end



AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    TriggerEvent('chatMessage', source, name, '/' .. command)

    CancelEvent()
end)

-- command suggestions for clients
local function refreshCommands(player)
    if GetRegisteredCommands then
        local registeredCommands = GetRegisteredCommands()

        local suggestions = {}

        for _, command in ipairs(registeredCommands) do
            if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
                table.insert(suggestions, {
                    name = '/' .. command.name,
                    help = ''
                })
            end
        end

        TriggerClientEvent('chat:addSuggestions', player, suggestions)
    end
end

AddEventHandler('chat:init', function()
    refreshCommands(source)
end)

AddEventHandler('onServerResourceStart', function(resName)
    Wait(500)

    for _, player in ipairs(GetPlayers()) do
        refreshCommands(player)
    end
end)


function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT identifier, firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
		}
	else
		return nil
	end
end

-- player join messages
AddEventHandler('playerJoining', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    -- local playerName = GetRealPlayerName(playerId)
    
    if GetConvarInt('chat_showJoins', 1) == 0 then
        return
    end

    -- TriggerClientEvent('chatMessage', -1, '', { 41, 168, 45 }, '' .. ' تسجيل دخول ' ..GetPlayerName(source) )

end)