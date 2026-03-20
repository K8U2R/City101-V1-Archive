
disconnect = {}
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent("esx_disconnect:connect")
AddEventHandler("esx_disconnect:connect", function()
TriggerClientEvent('esx_blipsjobs:connect', source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local nome = xPlayer.getName()
        local gruppo = xPlayer.getGroup()
        local lavoro = xPlayer.job.label
        local grado = xPlayer.job.grade_label
        local permessi = xPlayer.get("rank")
        local soldi = xPlayer.getMoney()
        local soldi2 = xPlayer.getAccount('bank').money
        --local ip = GetPlayerEndpoint(source)
        local ping = GetPlayerPing(source)
        local ids = ExtractIdentifiers(source)
        xblID ="\n```Xbox ID:  ``` " ..ids.xbl..""
        _steamID ="\n```Steam ID:  ``` " ..ids.steam..""
        _liveID ="\n```Live ID:  ``` " ..ids.live..""
        _playerID ="\n```Player ID:  ``` " ..source..""
        _discordID ="\n```Discord ID:  ``` <@" ..ids.discord:gsub("discord:", "")..">"
        _licenseID ="\n```License ID:  ``` " ..xPlayer.identifier..""
        JoinLog('```دخل السيرفر:```' ..nome.. '' .._playerID.. ' ' .._steamID.. '' .._discordID.. ''.._licenseID.. '' ..xblID.. '' .._liveID.. '\n**البنق:** ' ..ping.. '\n**جروب:**' ..gruppo..'\n\n**اللفل:**' ..permessi..'\n\n**كاش: **' ..soldi..'\n\n**البنك: **' ..soldi2..'\n\n**الوظيفة: **' ..lavoro..' - ' ..grado..'')
    end
end)
-------------------------------------------------------------------
function JoinLog(message)
	local content = {
        {
        	["color"] = '3863105',  --verde
            ["title"] = "دخول +",
            ["description"] = message,
            ["footer"] = {
                ["text"] = os.date("%x %X %p")
            }, 
        }
    }
        
  	PerformHttpRequest("https://discord.com/api/webhooks/1219041005358153819/o1eCfma73zmCNsDARikSuPB8godCa2CBmZ6Ywmg2D_dcJFlWtMIe0QYJUYV5EHFyFYXR" , function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end
-------------------------------------------------------------------
AddEventHandler("playerDropped", function(reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        TriggerClientEvent('esx_threb:swapToserverDisconnectedCheck', xPlayer.source)
        TriggerClientEvent('esx_misc:UpdateTimerAfterExit', xPlayer.source, xPlayer.identifier)
        local Code = math.random(1, 9)..RandomLetters(1)..math.random(111, 999)
        local nome = xPlayer.getName()
        local gruppo = xPlayer.getGroup()
        --local lavoro = xPlayer.job.name
        local lavoro = xPlayer.job.label
        --local grado = xPlayer.job.grade
        local grado = xPlayer.job.grade_label
        local permessi = xPlayer.get("rank")
        local soldi = xPlayer.getMoney()
        local soldi2 = xPlayer.getAccount('bank').money
        local ip = GetPlayerEndpoint(source)
        local ping = GetPlayerPing(source)
        local ids = ExtractIdentifiers(source)
        xblID ="\n```Xbox ID:  ``` " ..ids.xbl..""
        _steamID ="\n```Steam ID:  ``` " ..ids.steam..""
        _liveID ="\n```Live ID:  ``` " ..ids.live..""
        _playerID ="\n```Player ID:  ``` " ..source..""
        _discordID ="\n```Discord ID:  ``` <@" ..ids.discord:gsub("discord:", "")..">"
        _licenseID ="\n```License ID:  ``` " ..xPlayer.identifier..""
        DisconnectLog('```خرج من السيرفر:  ```' ..nome.. '' .._playerID.. '\n*كود الفصل:* '..Code..'' .._steamID.. '' .._discordID.. ''.._licenseID.. '' ..xblID.. '' .._liveID.. '\n**الايبي:  **' ..ip.. '\n**البنق:  ** ' ..ping.. '\n**جروب:  **' ..gruppo..'\n**اللفل:  **' ..permessi..'\n**كاش:  **' ..soldi..'\n**البنك: **' ..soldi2..'\n\n**الوظيفة: **' ..lavoro..' - ' ..grado.. '\n**سبب الفصل: **' .. reason, xPlayer)
        local Name_ = GetPlayerName(source)
        local Coords_ = xPlayer.getCoords(true)
        TriggerEvent('esx_disconnect:PlayerDisconnect', Code,Name_,Coords_)
    end
end)
-------------------------------------------------------------------
function DisconnectLog(message, player_t)
	local content = {
        {
        	["color"] = '15874618',
            ["title"] = "وخروج +",
            ["description"] = message,
            ["footer"] = {
                ["text"] = os.date("%x %X %p")
                
            }, 
        }
    }
        
  	PerformHttpRequest("https://discord.com/api/webhooks/1219041005358153819/o1eCfma73zmCNsDARikSuPB8godCa2CBmZ6Ywmg2D_dcJFlWtMIe0QYJUYV5EHFyFYXR" , function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end
-------------------------------------------------------------------
function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
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
        end
    end

    return identifiers
end

AddEventHandler('esx_disconnect:PlayerDisconnect', function(Code_,name_,Coords_)
	
	table.insert(disconnect, {name=name_, coords=Coords_, code=Code_, active=true, min=Config.ShowTimeLength})
	
	TriggerClientEvent('esx_disconnect:Update', -1, disconnect)
end)

Citizen.CreateThread(function()
    Wait(1)
    while true do
        Wait(1000 *  60)
        if #disconnect > 0 then
            for i=1, #disconnect, 1 do
                if disconnect[i].min > 0 and disconnect[i].active then
                    disconnect[i].min = disconnect[i].min - 1
                elseif disconnect[i].min == 0 and disconnect[i].active then
                    disconnect[i].active = false
                end
            end
        end
        TriggerClientEvent('esx_disconnect:Update', -1, disconnect)
    end
end)

RegisterServerEvent('esx_disconnect:GetUpdate')
AddEventHandler('esx_disconnect:GetUpdate', function()
    TriggerClientEvent('esx_disconnect:Update', source, disconnect)
end)

function RandomLetters(length)
	local res = ""
	for i = 1, length do
		res = res .. string.char(math.random(97, 122))
	end
	return res
end
