ESX = nil
local lastMessageId = "1234694868241088564"
local webhookUrl = Config.TopMoneyIrl

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getPlayerTop()
    local result = MySQL.Sync.fetchAll("SELECT firstname, lastname, JSON_UNQUOTE(JSON_EXTRACT(accounts, '$.money')) AS money, JSON_UNQUOTE(JSON_EXTRACT(accounts, '$.bank')) AS bank, identifier FROM users ORDER BY (money + bank) DESC LIMIT 20")

    local embed = {
        title = "Top 20 Players",
        color = 808080,
        fields = {}
    }

    for i, player in ipairs(result) do
        local playerName = player.firstname .. ' ' .. player.lastname
        local playerMoney = player.money + player.bank

        table.insert(embed.fields, {
            name = i .. ". " .. playerName,
            value = "Money: $" .. playerMoney,
            inline = false
        })
    end


    local payload = {embeds = {embed}}

    if lastMessageId then
        PerformHttpRequest(webhookUrl .. "/messages/" .. lastMessageId, function(err, text, headers)
            if err ~= 200 then
                print("Failed to send webhook. Error Code: " .. err)
            end
        end, 'PATCH', json.encode(payload), {['Content-Type'] = 'application/json'})
    else
        PerformHttpRequest(webhookUrl, function(err, text, headers)
            if err ~= 200 then
                print("Failed to send webhook. Error Code: " .. err)
            end
        end, 'POST', json.encode(payload), {['Content-Type'] = 'application/json'})
    end
end

Citizen.CreateThread(function()
    while true do
        getPlayerTop()
        Citizen.Wait(1000 * 60 * Config.UpdateTopMoney)
    end
end)
