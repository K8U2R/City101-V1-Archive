ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local mincash = 1000 -- minimum amount of cash a pile holds
local maxcash = 3500 -- maximum amount of cash a pile can hold
local rewardxp = 12
local black = true -- enable this if you want blackmoney as a reward
local mincops = 7 -- minimum required cops to start mission
local enablesound = true -- enables bank alarm sound
local lastrobbed = 0 -- don't change this
local cooldown = 3600 -- amount of time to do the heist again in seconds (30min)
local info = {stage = 0, style = nil, locked = false}
local totalcash = 0
local PoliceDoors = {
    {loc = vector3(257.10, 220.30, 106.28), txtloc = vector3(257.10, 220.30, 106.28), model = "hei_v_ilev_bk_gate_pris", model2 = "hei_v_ilev_bk_gate_molten", obj = nil, obj2 = nil, locked = true},
    {loc = vector3(236.91, 227.50, 106.29), txtloc = vector3(236.91, 227.50, 106.29), model = "v_ilev_bk_door", model2 = "v_ilev_bk_door", obj = nil, obj2 = nil, locked = true},
    {loc = vector3(262.35, 223.00, 107.05), txtloc = vector3(262.35, 223.00, 107.05), model = "hei_v_ilev_bk_gate2_pris", model2 = "hei_v_ilev_bk_gate2_pris", obj = nil, obj2 = nil, locked = true},
    {loc = vector3(252.72, 220.95, 101.68), txtloc = vector3(252.72, 220.95, 101.68), model = "hei_v_ilev_bk_safegate_pris", model2 = "hei_v_ilev_bk_safegate_molten", obj = nil, obj2 = nil, locked = true},
    {loc = vector3(261.01, 215.01, 101.68), txtloc = vector3(261.01, 215.01, 101.68), model = "hei_v_ilev_bk_safegate_pris", model2 = "hei_v_ilev_bk_safegate_molten", obj = nil, obj2 = nil, locked = true},
    {loc = vector3(253.92, 224.56, 101.88), txtloc = vector3(253.92, 224.56, 101.88), model = "v_ilev_bk_vaultdoor", model2 = "v_ilev_bk_vaultdoor", obj = nil, obj2 = nil, locked = true}
}

ESX.RegisterServerCallback("utk_oh:GetData", function(source, cb)
    cb(info)
end)
ESX.RegisterServerCallback("utk_oh:GetDoors", function(source, cb)
    cb(PoliceDoors)
end)
ESX.RegisterServerCallback("utk_oh:startevent", function(source, cb, method)
    local xPlayers = ESX.GetPlayers()
    local copcount = 0
    local yPlayer = ESX.GetPlayerFromId(source)
    local xPlayers2 = ESX.GetPlayers()
	local data = exports.esx_misc:isNoCrimetime() --return table with 3 values {active(boolen),location,label}
	local data2 = exports.esx_misc:isNoCrimetime2() --return table with 3 values {active(boolen),name,label}
	if data.active and (data.location == 'peace_time' or data.location == 'restart_time') then
        cb("لايمكن السرقة. يوجد "..data.label)
	elseif data2.active and (data2.location == 'NoCrimetime' or data2.location == 'NewScenario' or data2.location == 'MainBank') then
        cb("لايمكن السرقة. يوجد "..data2.label)
	else
        if not info.locked then
            if (os.time() - cooldown) > lastrobbed then
                for i = 1, #xPlayers, 1 do
                    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

                    if xPlayer then
                        if xPlayer.job.name == "police" or xPlayer.job.name == "agent" then
                            copcount = copcount + 1
                        end
                    end
                end
                if copcount >= 7 then
                    if method == 1 then
                        local item = yPlayer.getInventoryItem("thermal_charge")["count"]

                        if item >= 1 then
                            yPlayer.removeInventoryItem("thermal_charge", 1)
                            cb(true)
                            info.stage = 1
                            info.style = 1
                            info.locked = true
                            
                            local ids = ExtractIdentifiers(source)
                            _discordID ="**Discord ID:  ** <@" ..ids.discord:gsub("discord:", "")..">"
                            _identifierID ="**identifier :  ** " ..yPlayer.identifier..""
                            DiscordLog ('سرقة البنك المركزي', 'بدأ سرقة البنك المركزي', 'من قبل: '..yPlayer.getName()..'\n'.._discordID..'\n'.._identifierID..'', '15158332', 'https://discord.com/api/webhooks/1219056158094921858/2-HrNaioqCsiJkkm8cAB4MLZQgjd7d5k54TZ8CUbyeVarr3Eul4NyXDKtpHeiEgP5ne3')
                        else
                            cb('<center><b style="color:#DF6805;font-size:26px;"> لاتمتلك متفجرات')
                        end
                    elseif method == 2 then
                        local item = yPlayer.getInventoryItem("laptop_h")["count"]

                        if item >= 1 then
                            yPlayer.removeInventoryItem("laptop_h", 1)
                            info.stage = 1
                            info.style = 2
                            info.locked = true
                            cb(true)
                        else
                            cb("انت لاتمتلك لابتوب.")
                        end
                    end
                else
                    cb("<font size=6 color=FFAE00><p align=center><b>لايوجد عدد كافي من الشرطة</font>" .. "</br><font size=5><p align=right><b>عدد الشرطة المطلوب لبدأ السرقة: ".."<font size=5 color=FF0E0E>"..mincops.."</font>")
                end
            else
                cb(math.floor((cooldown - (os.time() - lastrobbed)) / 60)..":"..math.fmod((cooldown - (os.time() - lastrobbed)), 60).." متبقية للسرقة القادمة")
            end
        else
            cb("هناك سرقة أخرى في البنك المركزي")
        end
    end
end)
ESX.RegisterServerCallback("utk_oh:checkItem", function(source, cb, itemname)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem(itemname)["count"]
    
	-------------
	local data = exports.esx_misc:isNoCrimetime() --return table with 3 values {active(boolen),location,label}
	local data2 = exports.esx_misc:isNoCrimetime2() --return table with 3 values {active(boolen),name,label}
	if data.active and (data.location == 'peace_time' or data.location == 'restart_time' or data.location == 'NoCrimetime' or data.location == 'NewScenario' or data.location == 'MainBank') then
	 cb("لايمكن السرقة. يوجد "..data.label)
	elseif data2.active and (data2.location == 'NoCrimetime' or data2.location == 'NewScenario' or data2.location == 'MainBank') then
	 cb("لايمكن السرقة. يوجد "..data2.label)
	else
    if item >= 1 then
        cb(true)
    else
        cb(false)
    end
    end
end)
ESX.RegisterServerCallback("utk_oh:gettotalcash", function(source, cb)
    cb(totalcash)
end)
RegisterServerEvent("utkRA6H2SK_oh:removeitem")
AddEventHandler("utkRA6H2SK_oh:removeitem", function(itemname)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem(itemname, 1)
end)
RegisterServerEvent("utk_oh:updatecheck")
AddEventHandler("utk_oh:updatecheck", function(var, status)
    TriggerClientEvent("utk_oh:updatecheck_c", -1, var, status)
end)

RegisterServerEvent("utR$DL2k_oh:chat")
AddEventHandler("utR$DL2k_oh:chat", function()
    TriggerClientEvent('chatMessage', -1, "^1أخبـار |^3 عــاجـل: ^3 عملية سطو مسلح على ^1 البنك المركزي")
end)

--[[RegisterServerEvent("utk_oh:toggleDoor")
AddEventHandler("utk_oh:toggleDoor", function(door, coords, status)
    TriggerClientEvent("utk_oh:toggleDoor_c", -1, door, coords, status)
end)]]
RegisterServerEvent("utk_oh:policeDoor")
AddEventHandler("utk_oh:policeDoor", function(doornum, status)
    PoliceDoors[doornum].locked = status
    TriggerClientEvent("utk_oh:policeDoor_c", -1, doornum, status)
end)
RegisterServerEvent("utk_oh:moltgate")
AddEventHandler("utk_oh:moltgate", function(x, y, z, oldmodel, newmodel, method)
    TriggerClientEvent("utk_oh:moltgate_c", -1, x, y, z, oldmodel, newmodel, method)
end)
RegisterServerEvent("utk_oh:fixdoor")
AddEventHandler("utk_oh:fixdoor", function(hash, coords, heading)
    TriggerClientEvent("utk_oh:fixdoor_c", -1, hash, coords, heading)
end)
RegisterServerEvent("utk_oh:openvault")
AddEventHandler("utk_oh:openvault", function(method)
    TriggerClientEvent("utk_oh:openvault_c", -1, method)
end)
RegisterServerEvent("utk_oh:startloot")
AddEventHandler("utk_oh:startloot", function()
    TriggerClientEvent("utk_oh:startloot_c", -1)
end)


RegisterServerEvent("utkK2HJD_oh:rewardCash") -- utk_oh:rewardCash
AddEventHandler("utkK2HJD_oh:rewardCash", function(q,token)
    local xPlayer = ESX.GetPlayerFromId(source)
    local reward = math.random(mincash, maxcash)
    if q == "adj28^hdkn@vni%%2qq98Dhnh@ebn" then
        if black then
            xPlayer.addAccountMoney("black_money", reward)
        else
            xPlayer.addMoney(reward)
        end
        totalcash = totalcash + reward
        TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', xPlayer.source, 'add', rewardxp, 'سرقة البنك المركزي utk_oh:rewardCash', 'AbdurhmanOnTop')
        DiscordLog ('سرقة البنك المركزي', 'جمع المال', 'من قبل: '..xPlayer.getName()..'\n'.._discordID..'\n'.._identifierID..'\nخبرة: '..rewardxp..'\n المبلغ: $'..reward..' أموال حمراء\nمجموع المبلغ الذي تم جمعه الى الأن في هذه السرقة: $'..totalcash..'', '16705372', 'https://discord.com/api/webhooks/1219056158094921858/2-HrNaioqCsiJkkm8cAB4MLZQgjd7d5k54TZ8CUbyeVarr3Eul4NyXDKtpHeiEgP5ne3')
    end
end)
RegisterServerEvent("utKD6522Gk_oh:rewardGold")
AddEventHandler("utKD6522Gk_oh:rewardGold", function(j, token)
    local xPlayer = ESX.GetPlayerFromId(source)
	if j == "adj28^hdkn@vni%%2qq98Dhnh@ebn" then
        xPlayer.addInventoryItem("gold", 1)
	    DiscordLog ('سرقة البنك المركزي', 'جمع سبائك الذهب', 'من قبل: '..xPlayer.getName()..'\n'.._discordID..'\n'.._identifierID..'\nخبرة: '..rewardxp..'\n عدد السبائك: 1', '16705372', 'https://discord.com/api/webhooks/1219056158094921858/2-HrNaioqCsiJkkm8cAB4MLZQgjd7d5k54TZ8CUbyeVarr3Eul4NyXDKtpHeiEgP5ne3')
	end
end)
RegisterServerEvent("uK2JH3Dtk_oh:rewardDia")
AddEventHandler("uK2JH3Dtk_oh:rewardDia", function(w, token)
    local xPlayer = ESX.GetPlayerFromId(source)
	if w == "adj28^hdkn@vni%%2qq98Dhnh@ebn" then
        xPlayer.addInventoryItem("dia_box", 1)
	    DiscordLog ('سرقة البنك المركزي', 'جمع سبائك الالماس', 'من قبل: '..xPlayer.getName()..'\n'.._discordID..'\n'.._identifierID..'\nخبرة: '..rewardxp..'\n عدد السبائك: 1', '16705372', 'https://discord.com/api/webhooks/1219056158094921858/2-HrNaioqCsiJkkm8cAB4MLZQgjd7d5k54TZ8CUbyeVarr3Eul4NyXDKtpHeiEgP5ne3')
	end
end)
RegisterServerEvent("utk_oh:giveidcard")
AddEventHandler("utk_oh:giveidcard", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    --xPlayer.addInventoryItem("id_card", 1)
end)
RegisterServerEvent("utk_oh:ostimer")
AddEventHandler("utk_oh:ostimer", function()
    lastrobbed = os.time()
    info.stage, info.style, info.locked = 0, nil, false
    Citizen.Wait(300000)
    for i = 1, #PoliceDoors, 1 do
        PoliceDoors[i].locked = true
        TriggerClientEvent("utk_oh:policeDoor_c", -1, i, true)
    end
    totalcash = 0
    TriggerClientEvent("utk_oh:reset", -1)
end)
RegisterServerEvent("utk_oh:gas")
AddEventHandler("utk_oh:gas", function()
    TriggerClientEvent("utk_oh:gas_c", -1)
end)
RegisterServerEvent("utk_oh:ptfx")
AddEventHandler("utk_oh:ptfx", function(method)
    TriggerClientEvent("utk_oh:ptfx_c", -1, method)
end)
RegisterServerEvent("utk_oh:alarm_s")
AddEventHandler("utk_oh:alarm_s", function(toggle)
    if enablesound then
        TriggerClientEvent("utk_oh:alarm", -1, toggle)
    end

end)

function DiscordLog (name, title, message, color, DiscordWebHook)
	
	local embeds = {
		{
			["title"]=title,
			["type"]="rich",
            ["description"] = message,
			["color"] =color,
			["footer"]=  { ["text"]= "سجل سرقة البنك المركزي", 
            ["icon_url"] = "https://probot.media/X3kaJPpSj7.png"},
		}
	}
	
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest("https://discord.com/api/webhooks/1219056158094921858/2-HrNaioqCsiJkkm8cAB4MLZQgjd7d5k54TZ8CUbyeVarr3Eul4NyXDKtpHeiEgP5ne3", function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
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