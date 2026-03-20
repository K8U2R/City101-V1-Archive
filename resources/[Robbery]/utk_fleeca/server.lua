ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local totalM = 0
local in_stolen_player = {}
Doors = {
    ["F1"] = {{loc = vector3(312.93, -284.45, 54.16), h = 160.91, txtloc = vector3(312.93, -284.45, 54.16), obj = nil, locked = true}, {loc = vector3(310.93, -284.44, 54.16), txtloc = vector3(310.93, -284.44, 54.16), state = nil, locked = true}},
    ["F2"] = {{loc = vector3(148.76, -1045.89, 29.37), h = 158.54, txtloc = vector3(148.76, -1045.89, 29.37), obj = nil, locked = true}, {loc = vector3(146.61, -1046.02, 29.37), txtloc = vector3(146.61, -1046.02, 29.37), state = nil, locked = true}},
    ["F3"] = {{loc = vector3(-1209.66, -335.15, 37.78), h = 213.67, txtloc = vector3(-1209.66, -335.15, 37.78), obj = nil, locked = true}, {loc = vector3(-1211.07, -336.68, 37.78), txtloc = vector3(-1211.07, -336.68, 37.78), state = nil, locked = true}},
    ["F4"] = {{loc = vector3(-2957.26, 483.53, 15.70), h = 267.73, txtloc = vector3(-2957.26, 483.53, 15.70), obj = nil, locked = true}, {loc = vector3(-2956.68, 481.34, 15.70), txtloc = vector3(-2956.68, 481.34, 15.7), state = nil, locked = true}},
    ["F5"] = {{loc = vector3(-351.97, -55.18, 49.04), h = 159.79, txtloc = vector3(-351.97, -55.18, 49.04), obj = nil, locked = true}, {loc = vector3(-354.15, -55.11, 49.04), txtloc = vector3(-354.15, -55.11, 49.04), state = nil, locked = true}},
    ["F6"] = {{loc = vector3(1174.24, 2712.47, 38.09), h = 160.91, txtloc = vector3(1174.24, 2712.47, 38.09), obj = nil, locked = true}, {loc = vector3(1176.40, 2712.75, 38.09), txtloc = vector3(1176.40, 2712.75, 38.09), state = nil, locked = true}},
}

function Robbery (name,title,message,color)
    local DiscordWebHook = "https://discord.com/api/webhooks/1219056158094921858/2-HrNaioqCsiJkkm8cAB4MLZQgjd7d5k54TZ8CUbyeVarr3Eul4NyXDKtpHeiEgP5ne3"
    
    local embeds = {
        {
            ["title"]=title,
			["description"] = message,
            ["type"]="rich",
            ["color"] =color,
            ["footer"]=  { ["text"]= "السرقات", },
        }
    }
    
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('utk_fleeca:msg')
AddEventHandler('utk_fleeca:msg', function(name,title,message,color)
	Robbery(name,title,message,color)
end)

RegisterNetEvent("esx_m3gon_or_defcon:moneytotalmmath")
AddEventHandler("esx_m3gon_or_defcon:moneytotalmmath", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		xPlayer.removeAccountMoney("black_money", totalM)
	end
	local counter = 0
    for k,v in pairs(in_stolen_player) do
        for k2,v2 in pairs(in_stolen_player[k]) do
            if in_stolen_player[k][k2].owner == true then
                in_stolen_player[k][k2].money = totalM
            end
        end
    end
    for k,v in pairs(in_stolen_player) do
        for k2,v2 in pairs(in_stolen_player[k]) do
            if in_stolen_player[k][k2].owner == true then
                money = in_stolen_player[k][k2].money
            end
            counter = counter + 1
        end
    end
    for k,v in pairs(in_stolen_player) do
        for k2,v2 in pairs(in_stolen_player[k]) do
            if counter == 1 then
                TriggerClientEvent("bnk_small:takemoney", k2, 1, money, money)
            else
                local money_is_can_take = tonumber(math.floor(money / counter))
                TriggerClientEvent("bnk_small:takemoney", tonumber(k2), counter, money, money_is_can_take)
            end
        end
    end
end)

RegisterNetEvent("bnk_small:removePlayerfromListStolen")
AddEventHandler("bnk_small:removePlayerfromListStolen", function()
    --print()
end)

RegisterNetEvent("bnk_small:cancelstolen")
AddEventHandler("bnk_small:cancelstolen", function(id, type)
    if type == "end_time" then
        local shopid = id
        for k,v in pairs(in_stolen_player) do
            for k2,v2 in pairs(in_stolen_player[k]) do
                TriggerClientEvent("bnk_small:cancelsuccess", tonumber(k2), "end_time")
                in_stolen_player[k][k2] = nil
            end
        end
        if in_stolen_player[shopid] then
            in_stolen_player[shopid] = nil
        else
            in_stolen_player[shopid] = nil
        end
    elseif type == "go" then
        local shopid = id
        for k,v in pairs(in_stolen_player) do
            for k2,v2 in pairs(in_stolen_player[k]) do
                if in_stolen_player[k][k2].owner == true then
                    TriggerClientEvent("bnk_small:cancelsuccess", tonumber(k2), "owner")
                else
                    TriggerClientEvent("bnk_small:cancelsuccess", tonumber(k2), "not_owner")
                end
                in_stolen_player[k][k2] = nil
            end
        end
        if in_stolen_player[shopid] then
            in_stolen_player[shopid] = nil
        else
            in_stolen_player[shopid] = nil
        end
    end
end)

AddEventHandler("playerDropped", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local is_owner = false
    if xPlayer then
        for k,v in pairs(in_stolen_player) do
            for k2,v2 in pairs(in_stolen_player[k]) do
                if k2 == xPlayer.source then
                    if in_stolen_player[k][k2].owner == true then
                        is_owner = true
                        for k3,v3 in pairs(in_stolen_player[k]) do
                            TriggerClientEvent("bnk_small:cancelsuccess", tonumber(k3), "player_disconnect_from_server_the_owner", xPlayer.getName(), k)
                        end
                        for k5,v5 in pairs(in_stolen_player[k]) do
                            in_stolen_player[k][k5] = nil
                        end 
                    end
                    if not is_owner then
                        for k4,v4 in pairs(in_stolen_player[k]) do
                            TriggerClientEvent("bnk_small:cancelsuccess", tonumber(k4), "player_disconnect_from_server", xPlayer.getName(), k)
                        end
                        in_stolen_player[k][k2] = nil
                    end
                end
            end
        end
    end
end)


RegisterNetEvent("bnk_small:getMYmoney")
AddEventHandler("bnk_small:getMYmoney", function(money, shopid)
    local xPlayer = ESX.GetPlayerFromId(source)
    local is_have_player = false
    if xPlayer then
        xPlayer.addAccountMoney("black_money", money)
        for k,v in pairs(in_stolen_player) do
            for k2,v2 in pairs(in_stolen_player[k]) do
                if k2 == xPlayer.source then
                    in_stolen_player[k][k2] = nil
                end
            end
        end
        -- check if list stolen is all players has been taked money, to remove the list
        for k,v in pairs(in_stolen_player) do
            for k2,v2 in pairs(in_stolen_player[k]) do
                is_have_player = true
            end
        end
        if not is_have_player then
            if in_stolen_player[shopid] then
                in_stolen_player[shopid] = nil
            else
                in_stolen_player[shopid] = nil
            end
        end
    end
end)

RegisterNetEvent("bnk_small:refreshToplayerClient")
AddEventHandler("bnk_small:refreshToplayerClient", function()
    for k,v in pairs(in_stolen_player) do
        for k2,v2 in pairs(in_stolen_player[k]) do
            TriggerClientEvent("bnk_small:refreshListhtml", k2)
        end
    end
end)

ESX.RegisterServerCallback("bnk_small:getlistplayersinstolen", function(source, cb)
    for k,v in pairs(in_stolen_player) do
        local counter = 0
        local list_player = {}
        for k2,v2 in pairs(in_stolen_player[k]) do
            counter = counter + 1
            table.insert(list_player, {name = GetPlayerName(k2)})
        end
        cb(list_player, counter)
    end
end)

RegisterNetEvent("bnk_small:setPlayerinListStolen")
AddEventHandler("bnk_small:setPlayerinListStolen", function(owner, shopid)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if owner then
            if in_stolen_player[shopid] then
                in_stolen_player[shopid][xPlayer.source] = {}
                in_stolen_player[shopid][xPlayer.source] = {status = true, owner = true, shopid = shopid, id = xPlayer.source, money = 0}
            else
                in_stolen_player[shopid] = {}
                in_stolen_player[shopid][xPlayer.source] = {}
                in_stolen_player[shopid][xPlayer.source] = {status = true, owner = true, shopid = shopid, id = xPlayer.source, money = 0}
            end
        else
            if in_stolen_player[shopid] then
                in_stolen_player[shopid][xPlayer.source] = {}
                in_stolen_player[shopid][xPlayer.source] = {status = true, owner = false, shopid = shopid, id = xPlayer.source, money = 0}
            else
                in_stolen_player[shopid] = {}
                in_stolen_player[shopid][xPlayer.source] = {}
                in_stolen_player[shopid][xPlayer.source] = {status = true, owner = false, shopid = shopid, id = xPlayer.source, money = 0}
            end
        end
    end
end)

RegisterNetEvent("bnk_small:InvitePlayer")
AddEventHandler("bnk_small:InvitePlayer", function(id_player, shopid)
    local xPlayer = ESX.GetPlayerFromId(id_player)
    local xTarget = ESX.GetPlayerFromId(source)
    if xPlayer then
        TriggerClientEvent("bnk_small:drawTextAcceptInviteToStolen", xPlayer.source)
    end
end)

function DiscordLog (name, title, message, color, DiscordWebHook)
	
	local embeds = {
		{
			["title"]=title,
			["type"]="rich",
            ["description"] = message,
			["color"] =color,
			["footer"]=  { ["text"]= "سجل سرقة البنوك الصغيرة", 
            ["icon_url"] = ""},
		}
	}
	
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

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


RegisterServerEvent("utK3E38H34k_fh:startcheck") -- utk_fh:startcheck
AddEventHandler("utK3E38H34k_fh:startcheck", function(bank, l)
    local _source = source
    local copcount = 0
    local Players = ESX.GetPlayers()
    if l == "a;olj@dh2%98%20h92" then
		for i = 1, #Players, 1 do
			local xPlayer = ESX.GetPlayerFromId(Players[i])

			if xPlayer.job.name == "police" or xPlayer.job.name == "agent" then
				copcount = copcount + 1
			end
		end
		local xPlayer = ESX.GetPlayerFromId(_source)
		local xPlayers = ESX.GetPlayers()
		local item = xPlayer.getInventoryItem("id_card_f")["count"]
		if copcount >= UTK.mincops then
			if item >= 1 then
				if not UTK.Banks[bank].onaction == true then
					if (os.time() - UTK.cooldown) > UTK.Banks[bank].lastrobbed then
						totalM = 0
						
						UTK.Banks[bank].onaction = true
						xPlayer.removeInventoryItem("id_card_f", 1)
						TriggerClientEvent("utk_fh:outcome", _source, true, bank)
							bankInfo = ""
							if bank == 'F1' then
							bankInfo = "لوس مربع 7193"
							elseif bank == 'F2' then
							bankInfo = "لوس الحديقة العامة"
							elseif bank == 'F3' then
							bankInfo = "لوس مربع 7175"
							elseif bank == 'F4' then
							bankInfo = "الساحل مربع 5070"
							elseif bank == 'F5' then
							bankInfo = "لوس مربع 7185"
							elseif bank == 'F6' then
							bankInfo = "ساندي مربع 4024"
							end
							TriggerClientEvent('chatMessage', -1, "^1عاجل^2: الأن تتم عملية سطو بنك صغير ")
							local ids = ExtractIdentifiers(source)
							_discordID ="**Discord ID:  ** <@" ..ids.discord:gsub("discord:", "")..">"
							_identifierID ="**identifier :  ** " ..xPlayer.identifier..""
							DiscordLog ('سرقة البنك الصغير', 'بدأ سرقة بنك '..bankInfo, 'من قبل: '..xPlayer.getName()..'\n'.._discordID..'\n'.._identifierID..'', '15158332', 'https://discord.com/api/webhooks/1219056158094921858/2-HrNaioqCsiJkkm8cAB4MLZQgjd7d5k54TZ8CUbyeVarr3Eul4NyXDKtpHeiEgP5ne3')
					else
						TriggerClientEvent("utk_fh:outcome", _source, false, "لازم تنتظر الى 30 دقيقة من اخر سرقة  "..math.floor((UTK.cooldown - (os.time() - UTK.Banks[bank].lastrobbed)) / 60)..":"..math.fmod((UTK.cooldown - (os.time() - UTK.Banks[bank].lastrobbed)), 60))
					end
				else
					TriggerClientEvent("utk_fh:outcome", _source, false, "!جاري سرقة البنك الصغير")
				end
			else
				TriggerClientEvent("utk_fh:outcome", _source, false, "لا تملك بطاقة تهكير بنك صغير")
			end
		else
			TriggerClientEvent("utk_fh:outcome", _source, false, 'لايوجد عدد شرطة كافي يجب وجود '..UTK.mincops)
		end
    end
end)

RegisterServerEvent("utk_fh:lootup")
AddEventHandler("utk_fh:lootup", function(var, var2)
    TriggerClientEvent("utk_fh:lootup_c", source, var, var2)
end)

RegisterServerEvent("utk_fh:openDoor")
AddEventHandler("utk_fh:openDoor", function(coords, method)
    TriggerClientEvent("utk_fh:openDoor_c", source, coords, method)
end)

RegisterServerEvent("utk_fh:toggleDoor")
AddEventHandler("utk_fh:toggleDoor", function(key, state)
    Doors[key][1].locked = state
    TriggerClientEvent("utk_fh:toggleDoor", source, key, state)
end)

RegisterServerEvent("utk_fh:toggleVault")
AddEventHandler("utk_fh:toggleVault", function(key, state)
    Doors[key][2].locked = state
    TriggerClientEvent("utk_fh:toggleVault", source, key, state)
end)

RegisterServerEvent("utk_fh:updateVaultState")
AddEventHandler("utk_fh:updateVaultState", function(key, state)
    Doors[key][2].state = state
end)

RegisterServerEvent("utKD32Dk_fh:startLoot")
AddEventHandler("utKD32Dk_fh:startLoot", function(data, name, players)
    local _source = source

    --[[for i = 1, #players, 1 do
        TriggerClientEvent("utk_fh:startLoot_c", players[i], data, name)
    end--]]
    TriggerClientEvent("utk_fh:startLoot_c", _source, data, name)
end)

RegisterServerEvent("utk_fh:stopHeist")
AddEventHandler("utk_fh:stopHeist", function(name)
    TriggerClientEvent("utk_fh:stopHeist_c", source, name)
end)

RegisterServerEvent("utkGGjG23K_fh:rewardCash") -- utk_fh:rewardCash
AddEventHandler("utkGGjG23K_fh:rewardCash", function(z, token)
    local xPlayer = ESX.GetPlayerFromId(source)
    local reward = math.random(UTK.mincash, UTK.maxcash)
	local number = math.random(1,185)
	local GiveXP = false
	local src = source
	XtraD = ''
	XtraD2 = ''
	if z == "kal;jdh289b^hrtrtryjjj" then
	
		if UTK.black then
			if number == 1 then
			xPlayer.addAccountMoney('black_money', reward)	
			elseif number == 2 then
			xPlayer.addAccountMoney('black_money', reward)	
			GiveXP = true
			elseif number == 3 then
			xPlayer.addAccountMoney('black_money', reward)	
			elseif number == 4 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 5 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 6 then
			xPlayer.addAccountMoney('black_money', reward)
			GiveXP = true
			elseif number == 7 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 8 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 9 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 10 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 11 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 12 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 13 then
			xPlayer.addAccountMoney('black_money', reward)		
			elseif number == 14 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 15 then
			xPlayer.addAccountMoney('black_money', reward)
			GiveXP = true	
			elseif number == 17 then
			xPlayer.addAccountMoney('black_money', reward)
			elseif number == 18 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 19 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 20 then
			xPlayer.addAccountMoney('black_money', reward)
			GiveXP = true	
			elseif number == 21 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 22 then
			xPlayer.addAccountMoney('black_money', reward)
			elseif number == 23 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 24 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 25 then
			xPlayer.addAccountMoney('black_money', reward)																			
			elseif number == 26 then
			xPlayer.addAccountMoney('black_money', reward)
			elseif number == 27 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 28 then
			xPlayer.addAccountMoney('black_money', reward)
			GiveXP = true	
			elseif number == 29 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 30 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 31 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 32 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 33 then
			xPlayer.addAccountMoney('black_money', reward)	
			GiveXP = true		
			elseif number == 34 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 35 then
			xPlayer.addAccountMoney('black_money', reward)	
			GiveXP = true	
			elseif number == 36 then
			xPlayer.addAccountMoney('black_money', reward)	
			elseif number == 37 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 38 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 39 then
			xPlayer.addAccountMoney('black_money', reward)
			GiveXP = true	
			elseif number == 40 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 41 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 42 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 43 then
			xPlayer.addAccountMoney('black_money', reward)	
	GiveXP = true		
			elseif number == 44 then
			xPlayer.addAccountMoney('black_money', reward)
			elseif number == 45 then
			xPlayer.addAccountMoney('black_money', reward)	
	GiveXP = true		
			elseif number == 46 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 47 then
			xPlayer.addAccountMoney('black_money', reward)	
	GiveXP = true		
			elseif number == 48 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 49 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 50 then
			xPlayer.addAccountMoney('black_money', reward)
			elseif number == 51 then
			xPlayer.addAccountMoney('black_money', reward)	
	GiveXP = true		
			elseif number == 52 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 53 then
			xPlayer.addAccountMoney('black_money', reward)	
	GiveXP = true		
			elseif number == 54 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 55 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 56 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 57 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 58 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 59 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 60 then
			xPlayer.addAccountMoney('black_money', reward)
			elseif number == 61 then
			xPlayer.addAccountMoney('black_money', reward)	
	GiveXP = true		
			elseif number == 62 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 63 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 64 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 65 then
			xPlayer.addAccountMoney('black_money', reward)
			elseif number == 66 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 67 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 68 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 69 then
			xPlayer.addAccountMoney('black_money', reward)
			elseif number == 70 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 71 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 72 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 73 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 74 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 75 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 76 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 77 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 78 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 79 then
			xPlayer.addAccountMoney('black_money', reward)
			elseif number == 80 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 81 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 82 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 83 then
			xPlayer.addAccountMoney('black_money', reward)	
	GiveXP = true		
			elseif number == 84 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 85 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 86 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 87 then
			xPlayer.addAccountMoney('black_money', reward)
			elseif number == 88 then
			xPlayer.addAccountMoney('black_money', reward)
			GiveXP = true
			elseif number == 89 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 90 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 91 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 92 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 93 then
			xPlayer.addAccountMoney('black_money', reward)
			elseif number == 94 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 95 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 96 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 97 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 98 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 99 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 100 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 101 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 102 then
			xPlayer.addAccountMoney('black_money', reward)	
	GiveXP = true		
			elseif number == 103 then
			xPlayer.addAccountMoney('black_money', reward)
			elseif number == 104 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 105 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 106 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 107 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 108 then
			xPlayer.addAccountMoney('black_money', reward)
			GiveXP = true
			elseif number == 109 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 110 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 111 then
			xPlayer.addAccountMoney('black_money', reward)																			
			elseif number == 112 then
			xPlayer.addAccountMoney('black_money', reward)
			GiveXP = true
			elseif number == 113 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 114 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 115 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 116 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 117 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 118 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 119 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 120 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 121 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 122 then
			xPlayer.addAccountMoney('black_money', reward)
			elseif number == 123 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 124 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 125 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 126 then
			xPlayer.addAccountMoney('black_money', reward)	
	GiveXP = true		
			elseif number == 127 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 128 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 129 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 130 then
			xPlayer.addAccountMoney('black_money', reward)
			elseif number == 131 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 132 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 133 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 134 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 135 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 136 then
			xPlayer.addAccountMoney('black_money', reward)
			elseif number == 137 then
			xPlayer.addAccountMoney('black_money', reward)	
	GiveXP = true		
			elseif number == 138 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 139 then
			xPlayer.addAccountMoney('black_money', reward)	
	GiveXP = true		
			elseif number == 140 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 141 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 142 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 143 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 144 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 145 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 146 then
			xPlayer.addAccountMoney('black_money', reward)
			GiveXP = true
			elseif number == 147 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 148 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 149 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 150 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 151 then
			xPlayer.addAccountMoney('black_money', reward)
			elseif number == 152 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 153 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 154 then
			xPlayer.addAccountMoney('black_money', reward)																			
			elseif number == 155 then
			xPlayer.addAccountMoney('black_money', reward)
			GiveXP = true
			elseif number == 156 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 157 then
			xPlayer.addAccountMoney('black_money', reward)	
	GiveXP = true		
			elseif number == 158 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 159 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 160 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 161 then
			xPlayer.addAccountMoney('black_money', reward)
	GiveXP = true		
			elseif number == 162 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 163 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 164 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 165 then
			xPlayer.addAccountMoney('black_money', reward)
			elseif number == 166 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 167 then
			xPlayer.addAccountMoney('black_money', reward)
			GiveXP = true		
			elseif number == 168 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 169 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 170 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 171 then
			xPlayer.addAccountMoney('black_money', reward)										
			elseif number == 172 then
			xPlayer.addAccountMoney('black_money', reward)									
			elseif number == 173 then
			xPlayer.addAccountMoney('black_money', reward)
			elseif number == 174 then
			xPlayer.addAccountMoney('black_money', reward)
			elseif number > 174 and number < 186 then
			xPlayer.addAccountMoney('black_money', reward)	
			xPlayer.addInventoryItem("laptop_h", 1)
			TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', source, 'add', 300, 'سرقة بنك الساحل (محظرظ حصلت على جهاز لاب توب)')
				TriggerClientEvent('pNotify:SendNotification', xPlayer.source, {
					text = '<center><b style="color:#0BAF5F;font-size:26px;"> أنت محظوظ على قد تحصلت على جهاز لاب توب ', 
					type = "info", 
					timeout = 10000, 
					layout = "centerLeft"
				})		
				XtraD2 = 'محظوظ حصل على جهاز لاب توب و 300 خبرة إضافية'
			else
			xPlayer.addAccountMoney('black_money', reward)
			end
			totalM = totalM + reward
			if GiveXP then
			TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', source, 'add', 20, 'سرقة بنك المملكة')
			XtraD = '\nخبرة: 20'
			end
			local ids = ExtractIdentifiers(source)
			_discordID ="**Discord ID:  ** <@" ..ids.discord:gsub("discord:", "")..">"
			_identifierID ="**identifier :  ** " ..xPlayer.identifier..""
			DiscordLog ('سرقة البنك الصغير', 'جمع جوائز البنك الصغير', 'من قبل: '..xPlayer.getName()..'\n'.._discordID..'\n'.._identifierID..'\nمبلغ: $'..reward..' أموال حمراء\nمجموع الأموال المجموعة بهاذه السرقة: $'..totalM..''..XtraD..''..XtraD2, '15158332', 'https://discord.com/api/webhooks/1219056158094921858/2-HrNaioqCsiJkkm8cAB4MLZQgjd7d5k54TZ8CUbyeVarr3Eul4NyXDKtpHeiEgP5ne3')
			
		end
	end
end)

RegisterServerEvent("utk_fh:setCooldown")
AddEventHandler("utk_fh:setCooldown", function(name)
    UTK.Banks[name].lastrobbed = os.time()
    UTK.Banks[name].onaction = false
    TriggerClientEvent("utk_fh:resetDoorState", source, name)
end)

ESX.RegisterServerCallback("utk_fh:getBanks", function(source, cb)
    cb(UTK.Banks, Doors)
end)

ESX.RegisterServerCallback("utk_fh:checkSecond", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem("id_card_f")["count"]
    
	-------------
	local data = exports.esx_misc:isNoCrimetime() --return table with 3 values {active(boolen),location,label}
	local data2 = exports.esx_misc:isNoCrimetime2() --return table with 3 values {active(boolen),name,label}
	if data.active and (data.location == 'peace_time' or data.location == 'restart_time' or data.location == 'NoCrimetime' or data.location == 'NewScenario' or data.location == 'SmallBanks') then
	 cb("لايمكن السرقة. يوجد "..data.label)
	elseif data2.active and (data2.location == 'NoCrimetime' or data2.location == 'NewScenario' or data2.location == 'SmallBanks') then
	 cb("لايمكن السرقة. يوجد "..data2.label)
	else
	
    if item >= 1 then
        xPlayer.removeInventoryItem("id_card_f", 1)
        cb(true)
    else
        cb(false)
    end
    end
end)