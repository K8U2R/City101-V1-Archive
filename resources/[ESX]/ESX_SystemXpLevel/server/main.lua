



function checkRequiredXPlevel(required, msg)
	local xp = exports.ESX_SystemXpLevel.ESXP_GetXP()
	local level = exports.ESX_SystemXpLevel.ESXP_GetRank()
	
	if level >= required then
		return true
	else
		ESX.ShowNotification(msg)
		
		return false
	end
end

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local dubleXP = false

function dlxpmainlogsserver (name, title, message, color)
	local DiscordWebHook = "https://discord.com/api/webhooks/1219053660894531674/uqwEU7wP055U1SzgORV905Pp7eC0FJq48jWXZlADOVpYTEnBuha_iKjHExxmwjR9SPz-" -- سيرفر الوقات
	
	local embeds = {
		{
			["title"]=title,
			["type"]="rich",
            ["description"] = message,
			["color"] =color,
			["footer"]=  { ["text"]= "سجل ضعف الخبرة"}
		}
	}
	
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end 



function GetPlayerLicense(id)
    local xPlayer = ESX.GetPlayerFromId(id)

    if xPlayer and xPlayer ~= nil then
        return xPlayer.identifier
    end

    return false
end

------
-- GetOnlinePlayers
--
-- @param playerId          - The player's id
-- @param players           - The list of players pulled from the DB
--
-- Fetches the online players from the list pulled form the DB
------
function GetOnlinePlayers(playerId, players)
    local Active = {}

    for _, playerId in ipairs(GetPlayers()) do
        local name = GetPlayerName(playerId)
        local license = GetPlayerLicense(playerId)

        for k, v in pairs(players) do
            if license == v.license or license == v.identifier then
                local Player = {
                    name = name,
                    id = playerId,
                    xp = v.rp_xp,
                    rank = v.rp_rank
                }

                -- Current player
                if GetPlayerLicense(playerId) == license then
                    Player.current = true
                end
                            
                if Config.Leaderboard.ShowPing then
                    Player.ping = GetPlayerPing(playerId)
                end
    
                table.insert(Active, Player)
                break
            end
        end
    end

    return Active 
end

------
-- UpdatePlayer
--
-- @param playerId          - The player's id
-- @param xp                - The player's current XP
-- @param rank              - The player's current rank
--
-- Fetches active players and initialises for current player
------

function FetchActivePlayers(playerId, xp, rank)
    MySQL.Async.fetchAll('SELECT license, identifier, rp_xp, rp_rank FROM users', {}, function(players)
        if #players > 0 then
            TriggerClientEvent("SystemXpLevel:InitialPlayerClientSide", playerId, xp, rank, GetOnlinePlayers(playerId, players))
        end
    end)
end

------
-- UpdatePlayer
--
-- @param playerId          - The player's id
-- @param xp                - The XP value to set
--
-- Updates the given user's XP
------
function UpdatePlayer(playerId, xp)
    local xPlayer = ESX.GetPlayerFromId(playerId)

    if xp == nil or not IsInt(xp) then
        TriggerClientEvent("esx_xp:print", playerId, _("err_type_check", "XP", "integer"))

        return
    end

    if xPlayer ~= nil then
        local goalXP = LimitXP(tonumber(xp))
        local goalRank = GetRankFromXP(goalXP)
        MySQL.Async.execute('UPDATE users SET rp_xp = @xp, rp_rank = @rank WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier,
            ['@xp'] = goalXP,
            ['@rank'] = goalRank
        }, function(result)
            xPlayer.set("xp", goalXP)
            xPlayer.set("rank", goalRank)

            -- Update the player's XP bar
            xPlayer.triggerEvent("esx_xp:update", goalXP, goalRank)
        end)
    end
end


------------------------------------------------------------
--                        EVENTS                          --
------------------------------------------------------------

RegisterNetEvent("SystemXpLevel:InitialPlayerServerSide")
AddEventHandler("SystemXpLevel:InitialPlayerServerSide", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil then
        MySQL.Async.fetchAll('SELECT rp_rank, rp_xp FROM users WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        }, function(result)
            if #result > 0 then

                if result[1]["rp_xp"] == nil or result[1]["rp_rank"] == nil then
                    TriggerClientEvent("esx_xp:print", _source, _("err_db_columns"))
                else
                    local CurrentXP = tonumber(result[1]["rp_xp"])
                    local CurrentRank = tonumber(result[1]["rp_rank"])  

                    xPlayer.set("xp", CurrentXP)
                    xPlayer.set("rank", CurrentRank)       
                    
                    if Config.Leaderboard.Enabled then
                        FetchActivePlayers(_source, CurrentXP, CurrentRank)
                    else
                        TriggerClientEvent("SystemXpLevel:InitialPlayerClientSide", _source, CurrentXP, CurrentRank, false)
                    end
                end
            else
                TriggerClientEvent("esx_xp:print", _source, _("err_db_user"))
            end
        end)
	end
end)

-- Set the current player XP
RegisterNetEvent("SystemXpLevel:setXP")
AddEventHandler("SystemXpLevel:setXP", function(xp, none, pas)
    if(pas==Config.pas)then
    UpdatePlayer(source, xp)
	end
end)

-- Fetch Players Data
RegisterNetEvent("SystemXpLevel:getPlayerData")
AddEventHandler("SystemXpLevel:getPlayerData", function(pas)
    if(pas==Config.pas)then
    local _source = source
    MySQL.Async.fetchAll('SELECT license, identifier, rp_xp, rp_rank FROM users', {}, function(players)
        if #players > 0 then     
            TriggerClientEvent("esx_xp:setPlayerData", _source, GetOnlinePlayers(_source, players))
        end
    end) 
	end
end)

function SendLog (name, title, message, color, WebHook)
	local DiscordWebHook = WebHook
	
	local embeds = {
		{
			["title"]=title,
			["type"]="rich",
            ["description"] = message,
			["color"] =color,
			["footer"]=  { ["text"]= "نظام الفل"}
		}
	}
	
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end


AddEventHandler("SystemXpLevel:updateCurrentPlayerXP", function(playerId, Action, amount, x, z)
    local xTarget = ESX.GetPlayerFromId(playerId)
    local Reason = x
    local pas = z
	local ids = ExtractIdentifiers(playerId)
	_steamID ="\n**Steam ID:  ** " ..ids.steam..""
	_discordID ="\n**Discord ID:  ** <@" ..ids.discord:gsub("discord:", "")..">"
    -- discord Log
	if not Reason then
	    Reason = 'لايوجد سبب محدد'
	end
	if not z then
	    z = 'none'
	end

    if xTarget ~= nil then
        if(Action=='add' or Action=='addnoduble' or Action=='addNoduble' or Action=='noduble' or Action=='Noduble')then
            local duble = ''
            if Config.DoubleXpLevelStore and Action == 'add' then
                amount = amount * 2
                duble = '\nتم تطبيق ضعف الخبرة متجر مدينة 101 اونلاين'
            end	
            if dubleXP and Action == 'add' then
                amount = amount * 2
                duble = '\nتم تطبيق ضعف الخبرة '
            end	
            if IsInt(amount) then
                local NewXP = tonumber(xTarget.get("xp")) + amount
                UpdatePlayer(playerId, NewXP)
                SendLog ('زيادة خبرة', '🌐 زيادة خبرة ', 'اللاعب: '..xTarget.getName()..' | '..GetPlayerName(xTarget.source)..' '.._steamID..' '.._discordID..'\n العدد: '..amount..'\nالسبب المرفوق: `'..Reason..'`'..duble, '3447003', 'https://discord.com/api/webhooks/1054493899403567204/YvdWhX5WkNTaVd-5tG26RETV-DIl0E3AzzgOXPMIHF02tEsr3km0hh6q_x_ZFXj12N6Q')
            end
        elseif Action=='remove' then
            if IsInt(amount) then
                local NewXP = tonumber(xTarget.get("xp")) - amount
                UpdatePlayer(playerId, NewXP)
                SendLog ('نقص خبرة', '🌐 نقص خبرة ', 'اللاعب: '..xTarget.getName()..' | '..GetPlayerName(xTarget.source)..' '.._steamID..' '.._discordID..'\n العدد: '..amount..'\nالسبب المرفوق: `'..Reason..'`', '15158332', 'https://discord.com/api/webhooks/1054493987643347014/2s4q2aj6UdV3A7cI0FB_ugfX6UQ74FJmZh1bcMBQDcTy52QMOiLCf1WxEaOSPKw_kwYq')
            end
        end
    end
end)

RegisterServerEvent("SystemXpLevel:updateCurrentPlayerXP_clientSide")
AddEventHandler("SystemXpLevel:updateCurrentPlayerXP_clientSide", function(Action, amount, x, z, why_you_add)
    local playerId = source
    local xTarget = ESX.GetPlayerFromId(playerId)
    local Reason = x
    local pas = z
	local ids = ExtractIdentifiers(playerId)
	_steamID ="\n**Steam ID:  ** " ..ids.steam..""
	_discordID ="\n**Discord ID:  ** <@" ..ids.discord:gsub("discord:", "")..">"
    -- discord Log
	if not Reason then
	Reason = 'لايوجد سبب محدد'
	end
	
	if amount > 50 then
	return
	end
	
	
    if xTarget ~= nil then
	if(Action=='add' or Action=='addnoduble' or Action=='addNoduble' or Action=='noduble' or Action=='Noduble')then
    local duble = ''
    if dubleXP and Action=='add' then
        amount = amount * 2
		duble = '\nتم تطبيق ضعف الخبرة '
    end	
        if IsInt(amount) then
            local NewXP = tonumber(xTarget.get("xp")) + amount
            UpdatePlayer(playerId, NewXP)
			SendLog ('زيادة خبرة', '🌐 زيادة خبرة clientSide', 'اللاعب: '..xTarget.getName()..' | '..GetPlayerName(xTarget.source)..' '.._steamID..' '.._discordID..'\n العدد: '..amount..'\nالسبب المرفوق: `'..Reason..'`'..duble, '3447003', 'https://discord.com/api/webhooks/1054493899403567204/YvdWhX5WkNTaVd-5tG26RETV-DIl0E3AzzgOXPMIHF02tEsr3km0hh6q_x_ZFXj12N6Q')
       end
	elseif Action=='remove' then
	if IsInt(amount) then
            local NewXP = tonumber(xTarget.get("xp")) - amount
            UpdatePlayer(playerId, NewXP)
			SendLog ('نقص خبرة', '🌐 نقص خبرة clientSide', 'اللاعب: '..xTarget.getName()..' | '..GetPlayerName(xTarget.source)..' '.._steamID..' '.._discordID..'\n العدد: '..amount..'\nالسبب المرفوق: `'..Reason..'`', '15158332', 'https://discord.com/api/webhooks/1054493987643347014/2s4q2aj6UdV3A7cI0FB_ugfX6UQ74FJmZh1bcMBQDcTy52QMOiLCf1WxEaOSPKw_kwYq')
        end
    end
    end
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

--[[
RegisterNetEvent("esx_xp:setRank")
AddEventHandler("esx_xp:setRank", function(playerId, Rank)
    local GoalRank = tonumber(Rank)

    if not GoalRank then
        --
    else
        if Config.Ranks[GoalRank] ~= nil then
            UpdatePlayer(playerId, tonumber(Config.Ranks[GoalRank].XP))
        end
    end
end)]]

AddEventHandler('SystemXpLevel:DoubleXpLevelStore', function(Player, type)
	if type == "start" then
		Config.DoubleXpLevelStore = true
        TriggerClientEvent("SystemXpLevel:StoreDoubleXpLevel", Player, true)
	elseif type == "stop" then
		Config.DoubleXpLevelStore = false
        TriggerClientEvent("SystemXpLevel:StoreDoubleXpLevel", Player, false)
	end
end)

RegisterServerEvent("SystemXpLevel:togglePromotion")
AddEventHandler("SystemXpLevel:togglePromotion", function(type, type2)
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'admin' or type2 == "cmd" then
        if type == "start" then
            if not dubleXP then
                dubleXP = true
            end
        elseif type == "end" then
            if dubleXP then
                dubleXP = false
            end
        end
    else
        print(('SystemXpLevel: %s attempted to toggle Promotion (not admin!)!'):format(xPlayer.identifier))
    end
end)

local xp = 0 
local done = false 

RegisterServerEvent("SystemXpLevel:SendRank")
AddEventHandler("SystemXpLevel:SendRank", function(xpp)
	xp = xpp
	done = true 
end)

ESX.RegisterServerCallback('SystemXpLevel:getRank', function(source, cb, id)
	done = false
	TriggerClientEvent("SystemXpLevel:getRank_cl", id)
	while not done do Wait(0) end 
	cb(xp)
end)


------------------------------------------------------------
--                    ADMIN COMMANDS                      --
------------------------------------------------------------

function DisplayError(playerId, message)
    TriggerClientEvent('chat:addMessage', playerId, {
        color = { 255, 0, 0 },
        args = { "SystemXpLevel", message }
    })    
end
 

RegisterCommand("esxp_give", function(source, args, rawCommand)
    local playerId = tonumber(args[1])
    local xPlayer = ESX.GetPlayerFromId(playerId)
	
	local xp = tonumber(args[2])
	
	local DiscordWebHook1 = "https://discord.com/api/webhooks/1219048510461186120/Z0OS6hUvnlQyLY39ToGRTR2LkfDS1vQq9DDxL_gnuX5jXjijwu3PhfIWUx-D9AY3x2e6"
	
	local embeds1 = {
		{
			["title"]= "give xp",
			["type"]= "rich",
            ["description"] = "xp : `"..xp.."` \n by the admin `"..GetPlayerName(source).."` \n`"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[5].."` \n الاعب الذي تم إعطائه `"..GetPlayerName(playerId).."` \n`"..GetPlayerIdentifiers(playerId)[1].."` | `"..GetPlayerIdentifiers(playerId)[5].."`",
			["color"] = "10181046",
			["footer"]=  { ["text"]= "/esxp_give by the admin "..GetPlayerName(source)}
		}
	}
    
    if xPlayer == nil then
        return DisplayError(source, _('err_invalid_player'))
    end

    if not xp then
        return DisplayError(source, _('err_invalid_type', "XP", 'integer'))
    end

    UpdatePlayer(playerId, tonumber(xPlayer.get("xp")) + xp)
	
	
	--if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook1, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds1}), { ['Content-Type'] = 'application/json' })
	
end, true)

RegisterCommand("esxp_take", function(source, args, rawCommand)
    local playerId = tonumber(args[1])
    local xPlayer = ESX.GetPlayerFromId(playerId)
	
	local xp = tonumber(args[2])
	
	local DiscordWebHook2 = "https://discord.com/api/webhooks/1219048510461186120/Z0OS6hUvnlQyLY39ToGRTR2LkfDS1vQq9DDxL_gnuX5jXjijwu3PhfIWUx-D9AY3x2e6"
	
	local embeds2 = {
		{
			["title"]= "remove xp | خصم خبرة",
			["type"]= "rich",
            ["description"] = "xp : `"..xp.."` \n by the admin `"..GetPlayerName(source).."` \n`"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[5].."` \n الاعب الذي تم الخصم منه `"..GetPlayerName(playerId).."` \n`"..GetPlayerIdentifiers(playerId)[1].."` | `"..GetPlayerIdentifiers(playerId)[5].."`",
			["color"] = "10181046",
			["footer"]=  { ["text"]= "/esxp_take by the admin "..GetPlayerName(source)}
		}
	}
    
    if xPlayer == nil then
        return DisplayError(source, _('err_invalid_player'))
    end

    if not xp then
        return DisplayError(source, _('err_invalid_type', "XP", 'integer'))
    end    
    
    UpdatePlayer(playerId, tonumber(xPlayer.get("xp")) - xp)
	
	PerformHttpRequest(DiscordWebHook2, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds2}), { ['Content-Type'] = 'application/json' })
	
end, true) 

RegisterCommand("esxp_set", function(source, args, rawCommand)
    local playerId = tonumber(args[1])
    local xPlayer = ESX.GetPlayerFromId(playerId)
	
	local xp = tonumber(args[2])
	
	local DiscordWebHook3 = "https://discord.com/api/webhooks/1219048510461186120/Z0OS6hUvnlQyLY39ToGRTR2LkfDS1vQq9DDxL_gnuX5jXjijwu3PhfIWUx-D9AY3x2e6"
	
	local embeds3 = {
		{
			["title"]= "set xp | إعادة ضبط خبرة",
			["type"]= "rich",
            ["description"] = "الخبرة التي تم إعادة الضبط لها : `"..xp.."` \n by the admin `"..GetPlayerName(source).."` \n`"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[5].."` \n الاعب `"..GetPlayerName(playerId).."` \n`"..GetPlayerIdentifiers(playerId)[1].."` | `"..GetPlayerIdentifiers(playerId)[5].."`",
			["color"] = "10181046",
			["footer"]=  { ["text"]= "/esxp_set by the admin "..GetPlayerName(source)}
		}
	}
    
    if xPlayer == nil then
        return DisplayError(source, _('err_invalid_player'))
    end

    if not xp then
        return DisplayError(source, _('err_invalid_type', "XP", 'integer'))
    end  

    UpdatePlayer(playerId, xp)
	PerformHttpRequest(DiscordWebHook3, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds3}), { ['Content-Type'] = 'application/json' })
end, true)

RegisterCommand("esxp_rank", function(source, args, rawCommand)
    local playerId = tonumber(args[1])
    local xPlayer = ESX.GetPlayerFromId(playerId)
	
	local goalRank = tonumber(args[2])
	
	local DiscordWebHook4 = "https://discord.com/api/webhooks/1219048510461186120/Z0OS6hUvnlQyLY39ToGRTR2LkfDS1vQq9DDxL_gnuX5jXjijwu3PhfIWUx-D9AY3x2e6"
	
	local embeds4 = {
		{
			["title"]= "set rank | إعادة ضبط لفل",
			["type"]= "rich",
            ["description"] = "الفل الي تم إعادة الضبط له : `"..goalRank.."` \n by the admin `"..GetPlayerName(source).."` \n`"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[5].."` \n الاعب `"..GetPlayerName(playerId).."` \n`"..GetPlayerIdentifiers(playerId)[1].."` | `"..GetPlayerIdentifiers(playerId)[5].."`",
			["color"] = "10181046",
			["footer"]=  { ["text"]= "/esxp_rank by the admin "..GetPlayerName(source)}
		}
	}
    
    if xPlayer == nil then
        return DisplayError(source, _('err_invalid_player'))
    end

    if not goalRank then
        return DisplayError(source, _('err_invalid_type', "Rank", 'integer'))
    end

    if goalRank < 1 or goalRank > #Config.Ranks then
        return DisplayError(source, _('err_invalid_rank', #Config.Ranks))
    end

    local xp = Config.Ranks[goalRank].XP

    UpdatePlayer(playerId, xp)
	PerformHttpRequest(DiscordWebHook4, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds4}), { ['Content-Type'] = 'application/json' })
	
end, true)
