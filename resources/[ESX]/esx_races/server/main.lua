ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx-qalle-races:getMoney', function(source, cb, money)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer ~= nil then
        if xPlayer.getMoney() >= money then
            xPlayer.removeMoney(money)
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end

end)

ESX.RegisterServerCallback("esx_races:getPropsVehicles", function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local result = MySQL.Sync.fetchAll('SELECT vehicle FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
            ['@owner'] = xPlayer.identifier,
            ['@plate'] = plate,
        })
        if result[1] then
            print('[success getted this vehicles]')
            local vehicles_json = json.decode(result[1].vehicle)
            print(vehicles_json)
            cb({type = "success", status = true, veh = vehicles_json})
        else
            cb({type = "falied", status = false})
        end
    end
end)

RegisterNetEvent('race:sendToDiscordAddRace')
AddEventHandler('race:sendToDiscordAddRace', function(timerace, name_race)
    local xPlayer = ESX.GetPlayerFromId(source)
	local DiscordWebHook = "https://discord.com/api/webhooks/1219053887793795135/EOKbW2Psjw58BG3CchvO1iBMfRautimeMP-tj8Q7ooY7baNNTWtqlULCMkTOpwrKfg4G"
    TriggerClientEvent('chatMessage', -1, " 🚥 السباقات " ,  {198, 40, 40} ,  "لقد انتهاء من السباق ^3" .. xPlayer.getName() .. "^0 الوقت ^3 " .. timerace .. " ^0نوع السباق^3 " .. name_race)
	local embeds = {
		{
			["title"]= "السباقات 🚥\n\nلقد انتهاء من السباق : " .. xPlayer.getName() .. "\n\nالوقت الذي انتهاء فيه : " .. timerace .. "\n\nنوع السباق الذي شارك فية : " .. name_race,
			["type"]="rich",
			["color"] =color,
		}
	}
	
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
	
end)

RegisterNetEvent('p_cases:sendToDiscordBuyhouse')
AddEventHandler('p_cases:sendToDiscordBuyhouse', function(location, price)
    local xPlayer = ESX.GetPlayerFromId(source)
	local DiscordWebHook = ""
	local embeds = {
		{
			["title"]= "السباقات 🚥\n\nلقد قام الاعب : \n" .. xPlayer.getName() .. "\n\nرقم الأستيم : \n" .. xPlayer.identifier .. "\n\nاسم الأستيم : \n" .. GetPlayerName(source) .. "\n\nالوظيفة : \n" .. xPlayer.job.label .. " - " .. xPlayer.job.grade_label .. "\n\nبشراء البيت المعرف ب الايدي : " .. location .. "\n\nب سعر : $" .. price,
			["type"]="rich",
			["color"] =color,
		}
	}
	
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
	
end)

RegisterNetEvent('p_cases:sendToDiscordAddhouse')
AddEventHandler('p_cases:sendToDiscordAddhouse', function(location, price)
    local xPlayer = ESX.GetPlayerFromId(source)
	local DiscordWebHook = ""
	local embeds = {
		{
			["title"]= "السباقات 🚥\n\nلقد قام الاعب : \n" .. xPlayer.getName() .. "\n\nرقم الأستيم : \n" .. xPlayer.identifier .. "\n\nاسم الأستيم : \n" .. GetPlayerName(source) .. "\n\nالوظيفة : \n" .. xPlayer.job.label .. " - " .. xPlayer.job.grade_label .. "\n\nبأنشاء البيت المعرف ب الايدي : " .. location .. "\n\nب سعر : $" .. price,
			["type"]="rich",
			["color"] =color,
		}
	}
	
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
	
end)

RegisterServerEvent('esx-qalle-races:addTime')
AddEventHandler('esx-qalle-races:addTime', function(timerace, race)
    local xPlayer = ESX.GetPlayerFromId(source)
    print(xPlayer.identifier)

    local name = "none"

    time = timerace

    local sql = [[
        SELECT
            firstname, lastname
        FROM
            users
        WHERE
            identifier = @identifier
    ]]

    MySQL.Async.fetchAll(sql, { ["@identifier"] = xPlayer["identifier"] }, function(response)
        if response[1] ~= nil then
            name = response[1]["firstname"] .. " " .. response[1]["lastname"]
        end
    end)

    Citizen.Wait(1000)

    MySQL.Async.fetchAll(
        'SELECT username, racetime FROM user_races WHERE username = @identifier and race = @race', {['@identifier'] = name, ['@race'] = race},
    function(result)
        if result[1] ~= nil and tonumber(result[1].racetime) > tonumber(time) then
            MySQL.Async.execute(
                'UPDATE user_races SET racetime = @time WHERE username = @identifier and race = @race',
                {
                    ['@identifier'] = name,
                    ['@race'] = race,
                    ['@time'] = time
                }
            )
        elseif result[1] == nil then
           MySQL.Async.execute('INSERT INTO user_races (username, racetime, race) VALUES (@name, @time, @race)',
                {
                    ['@name'] = name,
                    ['@time'] = time,
                    ['@race'] = race
                }
            )
        end
    end)
end)

ESX.RegisterServerCallback('esx-qalle-races:getScoreboard', function(source, cb, race)
    local identifier = ESX.GetPlayerFromId(source).identifier

    MySQL.Async.fetchAll(
        'SELECT username, racetime FROM user_races WHERE race = @race ORDER BY racetime ASC LIMIT 10', {['@race'] = race},
    function(result)

        local Races = {}

        for i=1, #result, 1 do
            table.insert(Races, {
                name   = result[i].username,
                time = result[i].racetime,
            })
        end

        cb(Races)
    end)  
end)
