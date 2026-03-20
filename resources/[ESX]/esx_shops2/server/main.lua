ESX = nil
local in_mazad_player = {}

local in_stolen_player = {}

-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("esx_wesam_or_707Store:sendtochat_store")
AddEventHandler("esx_wesam_or_707Store:sendtochat_store", function()
    TriggerClientEvent('chatMessage', -1, "^3عاجل^0: تتم الان سرقة ^3متجر")
end)

RegisterNetEvent("esx_shops2:removePlayerfromListStolen")
AddEventHandler("esx_shops2:removePlayerfromListStolen", function()
    --print()
end)

RegisterNetEvent("esx_shops2:cancelstolen")
AddEventHandler("esx_shops2:cancelstolen", function(id, type)
    if type == "end_time" then
        local shopid = id + 100
        for k,v in pairs(in_stolen_player) do
            if k == shopid then
                for k2,v2 in pairs(in_stolen_player[k]) do
                    TriggerClientEvent("esx_shops2:cancelsuccess", tonumber(k2), "end_time")
                    in_stolen_player[k][k2] = nil
                end
            end
        end
        if in_stolen_player[shopid] then
            in_stolen_player[shopid] = nil
        else
            in_stolen_player[shopid] = nil
        end
    elseif type == "go" then
        local shopid = id + 100
        for k,v in pairs(in_stolen_player) do
            if k == shopid then
                for k2,v2 in pairs(in_stolen_player[k]) do
                    if in_stolen_player[k][k2].owner == true then
                        TriggerClientEvent("esx_shops2:cancelsuccess", tonumber(k2), "owner")
                    else
                        TriggerClientEvent("esx_shops2:cancelsuccess", tonumber(k2), "not_owner")
                    end
                    in_stolen_player[k][k2] = nil
                end
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
                            TriggerClientEvent("esx_shops2:cancelsuccess", tonumber(k3), "player_disconnect_from_server_the_owner", xPlayer.getName(), k)
                        end
                        for k5,v5 in pairs(in_stolen_player[k]) do
                            in_stolen_player[k][k5] = nil
                        end 
                    end
                    if not is_owner then
                        for k4,v4 in pairs(in_stolen_player[k]) do
                            TriggerClientEvent("esx_shops2:cancelsuccess", tonumber(k4), "player_disconnect_from_server", xPlayer.getName(), k)
                        end
                        in_stolen_player[k][k2] = nil
                    end
                end
            end
        end
    end
end)

RegisterNetEvent("esx_shops2:getMYmoney")
AddEventHandler("esx_shops2:getMYmoney", function(money, shopid)
    local xPlayer = ESX.GetPlayerFromId(source)
    local is_have_player = false
    if xPlayer then
        xPlayer.addAccountMoney("black_money", money)
        for k,v in pairs(in_stolen_player) do
            if k == shopid then
                for k2,v2 in pairs(in_stolen_player[k]) do
                    if k2 == xPlayer.source then
                        in_stolen_player[k][k2] = nil
                    end
                end
            end
        end
        -- check if list stolen is all players has been taked money, to remove the list
        for k,v in pairs(in_stolen_player) do
            if k == shopid then
                for k2,v2 in pairs(in_stolen_player[k]) do
                    is_have_player = true
                end
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

RegisterNetEvent("esx_shops2:refreshToplayerClient")
AddEventHandler("esx_shops2:refreshToplayerClient", function(shopid)
    for k,v in pairs(in_stolen_player) do
        if k == shopid then
            for k2,v2 in pairs(in_stolen_player[k]) do
                TriggerClientEvent("esx_shops2:refreshListhtml", k2, shopid)
            end
        end
    end
end)

RegisterNetEvent("esx_shops2:setPlayerinListStolen")
AddEventHandler("esx_shops2:setPlayerinListStolen", function(player_id, owner, shopid)
    local xPlayer = ESX.GetPlayerFromId(player_id)
    if xPlayer then
        if owner then
            if in_stolen_player[shopid] then
                in_stolen_player[shopid][player_id] = {}
                in_stolen_player[shopid][player_id] = {status = true, owner = true, shopid = shopid, id = xPlayer.source, money = 0}
            else
                in_stolen_player[shopid] = {}
                in_stolen_player[shopid][player_id] = {}
                in_stolen_player[shopid][player_id] = {status = true, owner = true, shopid = shopid, id = xPlayer.source, money = 0}
            end
        else
            if in_stolen_player[shopid] then
                in_stolen_player[shopid][player_id] = {}
                in_stolen_player[shopid][player_id] = {status = true, owner = false, shopid = shopid, id = xPlayer.source, money = 0}
            else
                in_stolen_player[shopid] = {}
                in_stolen_player[shopid][player_id] = {}
                in_stolen_player[shopid][player_id] = {status = true, owner = false, shopid = shopid, id = xPlayer.source, money = 0}
            end
        end
    end
end)

RegisterNetEvent("esx_shops2:InvitePlayer")
AddEventHandler("esx_shops2:InvitePlayer", function(id_player, shopid)
    local xPlayer = ESX.GetPlayerFromId(id_player)
    local xTarget = ESX.GetPlayerFromId(source)
    if xPlayer then
        TriggerClientEvent("esx_shops2:drawTextAcceptInviteToStolen", xPlayer.source, shopid)
    end
end)

ESX.RegisterServerCallback("esx_shops2:getlistplayersinstolen", function(source, cb, shopid)
    for k,v in pairs(in_stolen_player) do
        if k == shopid then
            local counter = 0
            local list_player = {}
            for k2,v2 in pairs(in_stolen_player[k]) do
                counter = counter + 1
                table.insert(list_player, {name = GetPlayerName(k2)})
            end
            cb(list_player, counter)
        end
    end
end)

local number = {}

function CanCarryItemForBuy(source, item, count)
    local playerId = source
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer.canCarryItem(item, count) then
        return true
    end
    return false
end

--GET INVENTORY ITEM
ESX.RegisterServerCallback('esx_kr_shop:getInventory', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local items   = xPlayer.inventory

  cb({items = items})

end)

--Removes item from shop
RegisterNetEvent('esx_kr_shops:RemoveItemFromShop')
AddEventHandler('esx_kr_shops:RemoveItemFromShop', function(number, count, item, token, name_label_remove, shopid)
    local _source = source
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier =  ESX.GetPlayerFromId(src).identifier
    if shopid ~= 2000 then
        MySQL.Async.fetchAll('SELECT count, item FROM shops WHERE item = @item AND ShopNumber = @ShopNumber', {
            ['@ShopNumber'] = number,
            ['@item'] = item,
        }, function(data)
            if count > data[1].count then
                TriggerClientEvent('esx:showNotification', xPlayer.source, '<font color=red> لا يمكنك سحب أكثر مما في المتجر')
            else
                if data[1].count ~= count then
                    if xPlayer.canCarryItem(data[1].item, count) then
                        MySQL.Async.fetchAll("UPDATE shops SET count = @count WHERE item = @item AND ShopNumber = @ShopNumber",
                        {
                            ['@item'] = item,
                            ['@ShopNumber'] = number,
                            ['@count'] = data[1].count - count
                        }, function(result)
                            delete_from_store(src, count, name_label_remove)
                            xPlayer.addInventoryItem(data[1].item, count)
                        end)
                    else
                        xPlayer.showNotification('<font color=red>لا توجد مساحة كافية في الحقيبة</font>')
                    end
                elseif data[1].count == count then
                    if xPlayer.canCarryItem(data[1].item, count) then
                        MySQL.Async.fetchAll("DELETE FROM shops WHERE item = @name AND ShopNumber = @Number",
                        {
                            ['@Number'] = number,
                            ['@name'] = data[1].item
                        })
                        xPlayer.addInventoryItem(data[1].item, count)
                    else
                        xPlayer.showNotification('<font color=red>لا توجد مساحة كافية في الحقيبة</font>')
                    end
                end
            end
        end)
    else
        MySQL.Async.fetchAll('SELECT count, item FROM foodtrucks WHERE item = @item AND plate = @plate', {
            ['@plate'] = number,
            ['@item'] = item,
        },
        function(data)
            if xPlayer.canCarryItem(item, count) then
                if count <= data[1].count then
                    if data[1].count ~= count then
                        MySQL.Async.fetchAll("UPDATE foodtrucks SET count = @count WHERE item = @item AND plate = @plate", {
                            ['@item'] = item,
                            ['@plate'] = number,
                            ['@count'] = data[1].count - count
                        }, 
                        function(result)
                            xPlayer.addInventoryItem(data[1].item, count)
                        end)
                    elseif data[1].count == count then
                        MySQL.Async.fetchAll("DELETE FROM foodtrucks WHERE item = @name AND plate = @Number", {
                            ['@Number'] = number,
                            ['@name'] = data[1].item
                        })
                        xPlayer.addInventoryItem(data[1].item, count)
                    end
                else
                    TriggerClientEvent('pNotify:SendNotification', xPlayer.source, {
                        text = '<center><b style="color:#ea1f1f;font-size:20px;"> لايمكنك سحب أكثر مما تملك ', 
                        type = "info", 
                        timeout = 10000, 
                        layout = "centerLeft"
                    })		
                end
            else 
                TriggerClientEvent('pNotify:SendNotification', xPlayer.source, {
                    text = '<center><b style="color:#ea1f1f;font-size:20px;"> حقيبتك ممتئلة أو لاتملك الكمية الكافية ', 
                    type = "info", 
                    timeout = 10000, 
                    layout = "centerLeft"
                })
            end	
        end)
    end
end)

function add_to_store(source, count_add, label_add, price_add)
    local xPlayer = ESX.GetPlayerFromId(source)
    local message = "**لقد قام الاعب** : \n" .. xPlayer.getName() .. "\n\n**رقم الأستيم :** \n" .. xPlayer.identifier .. "\n\n**اسم الأستيم :** \n" .. GetPlayerName(source) .. "\n\n**الوظيفة :** \n" .. xPlayer.job.label .. " - " .. xPlayer.job.grade_label .. "\n\n**ب إضافة منتج الى متجره " .. "\n\n**المنتج المضاف : **\n" .. label_add .. "\n\n**الكمية المضافة : \n" .. count_add
	local DiscordWebHook = "https://discord.com/api/webhooks/1053314990800638012/pAtN9-5igNggLEGUIbn89JEqKQYy7CIGigxZUOqDZpsroS8X6uPfjO8Y4Vgx366uBaMK"
  
  	local embeds = {
	  	{
		  	["title"]=  message,
		  	["type"]="rich",
		  	["color"] = 0000,
		  	["footer"]=  {
			  	["text"]= "اضافة منتج",
		 	},
	  	}
  	}
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = "اضافة منتج",embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function delete_from_store(source, count_remove, label_remove)
    local xPlayer = ESX.GetPlayerFromId(source)
    local message = "**لقد قام الاعب** : \n" .. xPlayer.getName() .. "\n\n**رقم الأستيم :** \n" .. xPlayer.identifier .. "\n\n**اسم الأستيم :** \n" .. GetPlayerName(source) .. "\n\n**الوظيفة :** \n" .. xPlayer.job.label .. " - " .. xPlayer.job.grade_label .. "\n\n**ب إضافة منتج الى متجره " .. "\n\n**المنتج المسحوب : **\n" .. label_remove .. "\n\n**الكمية المسحوبة : \n" .. count_remove
	local DiscordWebHook = "https://discord.com/api/webhooks/1053314990800638012/pAtN9-5igNggLEGUIbn89JEqKQYy7CIGigxZUOqDZpsroS8X6uPfjO8Y4Vgx366uBaMK"
  
  	local embeds = {
	  	{
		  	["title"]=  message,
		  	["type"]="rich",
		  	["color"] = 0000,
		  	["footer"]=  {
			  	["text"]= "سحب منتج",
		 	},
	  	}
  	}
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = "سحب منتج",embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function add_to_store_money(source, money_add)
    local xPlayer = ESX.GetPlayerFromId(source)
    local message = "**لقد قام الاعب** : \n" .. xPlayer.getName() .. "\n\n**رقم الأستيم :** \n" .. xPlayer.identifier .. "\n\n**اسم الأستيم :** \n" .. GetPlayerName(source) .. "\n\n**الوظيفة :** \n" .. xPlayer.job.label .. " - " .. xPlayer.job.grade_label .. "\n\n**ب إيداع مبلغ الى متجره " .. "\n\n**المبلغ المضاف : \n$" .. money_add
	local DiscordWebHook = "https://discord.com/api//1053314990800638012/pAtN9-5igNggLEGUIbn89JEqKQYy7CIGigxZUOqDZpsroS8X6uPfjO8Y4Vgx366uBaMK"
  
  	local embeds = {
	  	{
		  	["title"]=  message,
		  	["type"]="rich",
		  	["color"] = 0000,
		  	["footer"]=  {
			  	["text"]= "إضافة مبلغ الى المتجر",
		 	},
	  	}
  	}
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = "إضافة مبلغ الى المتجر",embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function remve_money_from_store(source, remove_money)
    local xPlayer = ESX.GetPlayerFromId(source)
    local message = "**لقد قام الاعب** : \n" .. xPlayer.getName() .. "\n\n**رقم الأستيم :** \n" .. xPlayer.identifier .. "\n\n**اسم الأستيم :** \n" .. GetPlayerName(source) .. "\n\n**الوظيفة :** \n" .. xPlayer.job.label .. " - " .. xPlayer.job.grade_label .. "\n\n**ب سحب مبلغ من متجره " .. "\n\n**المبلغ المسحوب : \n$" .. remove_money
	local DiscordWebHook = "https://discord.com/api/webhooks/1053314990800638012/pAtN9-5igNggLEGUIbn89JEqKQYy7CIGigxZUOqDZpsroS8X6uPfjO8Y4Vgx366uBaMK"
  
  	local embeds = {
	  	{
		  	["title"]=  message,
		  	["type"]="rich",
		  	["color"] = 0000,
		  	["footer"]=  {
			  	["text"]= "سحب مبلغ من متجر",
		 	},
	  	}
  	}
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = "سحب مبلغ من متجر",embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function change_price_item(source, new_price_item, item_changed)
    local xPlayer = ESX.GetPlayerFromId(source)
    local message = "**لقد قام الاعب** : \n" .. xPlayer.getName() .. "\n\n**رقم الأستيم :** \n" .. xPlayer.identifier .. "\n\n**اسم الأستيم :** \n" .. GetPlayerName(source) .. "\n\n**الوظيفة :** \n" .. xPlayer.job.label .. " - " .. xPlayer.job.grade_label .. "\n\n**ب تغيير سعر سلعة في متجره " .. "\n\n**السلعة المغير سعرها : \n" .. item_changed .. "\n\nالسعر الجديد : \n$" .. new_price_item
	local DiscordWebHook = "https://discord.com/api/webhooks/1053314990800638012/pAtN9-5igNggLEGUIbn89JEqKQYy7CIGigxZUOqDZpsroS8X6uPfjO8Y4Vgx366uBaMK"
  
  	local embeds = {
	  	{
		  	["title"]=  message,
		  	["type"]="rich",
		  	["color"] = 0000,
		  	["footer"]=  {
			  	["text"]= "تغيير سعر سلعة في المتجر",
		 	},
	  	}
  	}
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = "تغيير سعر سلعة في المتجر",embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function change_name_store(source, name_new)
    local xPlayer = ESX.GetPlayerFromId(source)
    local message = "**لقد قام الاعب** : \n" .. xPlayer.getName() .. "\n\n**رقم الأستيم :** \n" .. xPlayer.identifier .. "\n\n**اسم الأستيم :** \n" .. GetPlayerName(source) .. "\n\n**الوظيفة :** \n" .. xPlayer.job.label .. " - " .. xPlayer.job.grade_label .. "\n\n**ب تغيير أسم متجره الى : **\n**" .. name_new .. "**"
	local DiscordWebHook = "https://discord.com/api/webhooks/1053314990800638012/pAtN9-5igNggLEGUIbn89JEqKQYy7CIGigxZUOqDZpsroS8X6uPfjO8Y4Vgx366uBaMK"
  
  	local embeds = {
	  	{
		  	["title"]=  message,
		  	["type"]="rich",
		  	["color"] = 0000,
		  	["footer"]=  {
			  	["text"]= "تغيير اسم المتجر",
		 	},
	  	}
  	}
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = "تغيير اسم المتجر",embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function add_modfen_in_store(source, player_id_modf)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(player_id_modf)
    local message = "**لقد قام الاعب** : \n" .. xPlayer.getName() .. "\n\n**رقم الأستيم :** \n" .. xPlayer.identifier .. "\n\n**اسم الأستيم :** \n" .. GetPlayerName(source) .. "\n\n**الوظيفة :** \n" .. xPlayer.job.label .. " - " .. xPlayer.job.grade_label .. "\n\n**ب توظيف شخص في متجره : **\n**" .. xTarget.getName() .. " - " .. xTarget.identifier .. "**"
	local DiscordWebHook = "https://discord.com/api/webhooks/1053314990800638012/pAtN9-5igNggLEGUIbn89JEqKQYy7CIGigxZUOqDZpsroS8X6uPfjO8Y4Vgx366uBaMK"
  
  	local embeds = {
	  	{
		  	["title"]=  message,
		  	["type"]="rich",
		  	["color"] = 0000,
		  	["footer"]=  {
			  	["text"]= "توظيف شخص في المتجر",
		 	},
	  	}
  	}
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = "توظيف شخص في المتجر",embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function kick_modf_from_store(source, iden_player_has_been_kicked)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromIdentifier(iden_player_has_been_kicked)
    local message = "**لقد قام الاعب** : \n" .. xPlayer.getName() .. "\n\n**رقم الأستيم :** \n" .. xPlayer.identifier .. "\n\n**اسم الأستيم :** \n" .. GetPlayerName(source) .. "\n\n**الوظيفة :** \n" .. xPlayer.job.label .. " - " .. xPlayer.job.grade_label .. "\n\n**ب طرد شخص من متجره : **\n**" .. xTarget.getName() .. " - " .. xTarget.identifier .. "**"
	local DiscordWebHook = "https://discord.com/api/webhooks/1053314990800638012/pAtN9-5igNggLEGUIbn89JEqKQYy7CIGigxZUOqDZpsroS8X6uPfjO8Y4Vgx366uBaMK"
  
  	local embeds = {
	  	{
		  	["title"]=  message,
		  	["type"]="rich",
		  	["color"] = 0000,
		  	["footer"]=  {
			  	["text"]= "طرد شخص من المتجر",
		 	},
	  	}
  	}
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = "طرد شخص من المتجر",embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function sell_store(source, id_store_has_been_sell)
    local xPlayer = ESX.GetPlayerFromId(source)
    local message = "**لقد قام الاعب** : \n" .. xPlayer.getName() .. "\n\n**رقم الأستيم :** \n" .. xPlayer.identifier .. "\n\n**اسم الأستيم :** \n" .. GetPlayerName(source) .. "\n\n**الوظيفة :** \n" .. xPlayer.job.label .. " - " .. xPlayer.job.grade_label .. "\n\n**ببيع متجره رقم : **\n**" .. id_store_has_been_sell
	local DiscordWebHook = "https://discord.com/api/webhooks/1053314990800638012/pAtN9-5igNggLEGUIbn89JEqKQYy7CIGigxZUOqDZpsroS8X6uPfjO8Y4Vgx366uBaMK"
  
  	local embeds = {
	  	{
		  	["title"]=  message,
		  	["type"]="rich",
		  	["color"] = 0000,
		  	["footer"]=  {
			  	["text"]= "بيع متجر",
		 	},
	  	}
  	}
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = "بيع متجر",embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent('esx_shops2:setDUBLExp')
AddEventHandler('esx_shops2:setDUBLExp', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if xPlayer.job.name == "admin" then
            if not Config.is_set_duple then
                Config.is_set_duple = true
                TriggerClientEvent("esx_misc:watermark_promotion", -1, '9ndo8_almtagr', true)
            else
                Config.is_set_duple = false
                TriggerClientEvent("esx_misc:watermark_promotion", -1, '9ndo8_almtagr', false)
            end
        end
    end
end)

--Setting selling items.
RegisterNetEvent('esx_kr_shops:setToSell')
AddEventHandler('esx_kr_shops:setToSell', function(id, Item, ItemCount, Price, ItemBox, ItemBoxCount, itemlabel, type, weaponname, levveeelll, shopid)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if shopid ~= 2000 then
        MySQL.Async.fetchAll('SELECT label, name FROM items WHERE name = @item', {
            ['@item'] = Item,
        }, function(items)
            MySQL.Async.fetchAll('SELECT price, count FROM shops WHERE item = @items AND ShopNumber = @ShopNumber', {
                ['@items'] = Item,
                ['@ShopNumber'] = id,
            }, function(data)

                if data[1] == nil then -- اضافة منتج

                    imgsrc = 'img/'..Item..'.png'

                    if type == 'weapon' then
                        MySQL.Async.execute('INSERT INTO shops (ShopNumber, src, label, count, item, price, level) VALUES (@ShopNumber, @src, @label, @count, @item, @price, @level)',
                        {
                            ['@ShopNumber']    = id,
                            ['@src']        = imgsrc,
                            ['@label']         = weaponname,
                            ['@count']         = ItemCount,
                            ['@item']          = Item,
                            ['@price']         = Price,
                            ['@level']         = levveeelll,
                        })
                    else
                        MySQL.Async.execute('INSERT INTO shops (ShopNumber, src, label, count, item, price, level) VALUES (@ShopNumber, @src, @label, @count, @item, @price, @level)',
                        {
                            ['@ShopNumber']    = id,
                            ['@src']        = imgsrc,
                            ['@label']         = items[1].label,
                            ['@count']         = ItemCount,
                            ['@item']          = items[1].name,
                            ['@price']         = Price,
                            ['@level']         = levveeelll,
                        })
                    end

                    xPlayer.removeInventoryItem(ItemBox, ItemBoxCount)
                    if Config.is_set_duple then
                        TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', xPlayer.source, 'addnoduble', Config.addXpForBoxDelivery + Config.addXpForBoxDelivery)
                        xPlayer.showNotification("<h1><center><font color=green><font size=6px><i>توصيل صندوق</i></font></font></h1></br><p align=right> حصلت على خبرة: "..Config.addXpForBoxDelivery + Config.addXpForBoxDelivery.."</br><font color=orange> مقابل توصيل "..itemlabel..'</font></p>')
                    else
                        TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', xPlayer.source, 'addnoduble', Config.addXpForBoxDelivery)
                        xPlayer.showNotification("<h1><center><font color=green><font size=6px><i>توصيل صندوق</i></font></font></h1></br><p align=right> حصلت على خبرة: "..Config.addXpForBoxDelivery.."</br><font color=orange> مقابل توصيل "..itemlabel..'</font></p>')
                    end
                elseif data[1].price == Price then
                
                    MySQL.Async.fetchAll("UPDATE shops SET count = @count WHERE item = @name AND ShopNumber = @ShopNumber",
                    {
                        ['@name'] = Item,
                        ['@ShopNumber'] = id,
                        ['@count'] = data[1].count + ItemCount
                    }
                    )
                    xPlayer.removeInventoryItem(ItemBox, ItemBoxCount)
                    if Config.is_set_duple then
                        TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', xPlayer.source, 'addnoduble', Config.addXpForBoxDelivery + Config.addXpForBoxDelivery)
                        xPlayer.showNotification("<h1><center><font color=green><font size=6px><i>توصيل صندوق</i></font></font></h1></br><p align=right> حصلت على خبرة: "..Config.addXpForBoxDelivery + Config.addXpForBoxDelivery.."</br><font color=orange> مقابل توصيل "..itemlabel..'</font></p>')
                    else
                        TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', xPlayer.source, 'addnoduble', Config.addXpForBoxDelivery)
                        xPlayer.showNotification("<h1><center><font color=green><font size=6px><i>توصيل صندوق</i></font></font></h1></br><p align=right> حصلت على خبرة: "..Config.addXpForBoxDelivery.."</br><font color=orange> مقابل توصيل "..itemlabel..'</font></p>')
                    end
                    add_to_store(src, ItemBoxCount, itemlabel, Price)

                elseif data ~= nil and data[1].price ~= Price then
                    Wait(250)
                    TriggerClientEvent('esx:showNotification', xPlayer.source, ' سعر العنصر في المتجر <font color=green>$' .. data[1].price .. '<font color=white> لا يطابق سعرك <font color=red>$' .. Price)
                    Wait(250)
                    TriggerClientEvent('esx:showNotification', xPlayer.source, 'قم بوضع نفس سعر العنصر أو تعديل سعره ')
                end
            end)
        end)
    else
        MySQL.Async.fetchAll('SELECT label, name FROM items WHERE name = @item', {
            ['@item'] = Item,
        }, function(items)
            MySQL.Async.fetchAll('SELECT price, count FROM foodtrucks WHERE item = @items AND plate = @plate', {
                ['@items'] = Item,
                ['@plate'] = id,
            }, function(data)
                if data[1] == nil then
                    if ItemCount <= Config.MaxFoodTrucksItems then
                        imgsrc = 'img/box.png'

                        for i=1, #Config.Images, 1 do
                            if Config.Images[i].item == Item then
                                imgsrc = Config.Images[i].src
                            end
                        end

                        MySQL.Async.execute('INSERT INTO foodtrucks (plate, src, label, count, item, price) VALUES (@plate, @src, @label, @count, @item, @price)',
                        {
                            ['@plate']    = id,
                            ['@src']        = imgsrc,
                            ['@label']         = items[1].label,
                            ['@count']         = ItemCount,
                            ['@item']          = items[1].name,
                            ['@price']         = Price
                        })
                        xPlayer.removeInventoryItem(Item, ItemCount)
                        if Config.is_set_duple then
                            TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', xPlayer.source, 'addnoduble', Config.addXpForBoxDelivery + Config.addXpForBoxDelivery)
                            xPlayer.showNotification("<h1><center><font color=green><font size=6px><i>توصيل صندوق</i></font></font></h1></br><p align=right> حصلت على خبرة: "..Config.addXpForBoxDelivery + Config.addXpForBoxDelivery.."</br><font color=orange> مقابل توصيل "..itemlabel..'</font></p>')
                        else
                            TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', xPlayer.source, 'addnoduble', Config.addXpForBoxDelivery)
                            xPlayer.showNotification("<h1><center><font color=green><font size=6px><i>توصيل صندوق</i></font></font></h1></br><p align=right> حصلت على خبرة: "..Config.addXpForBoxDelivery.."</br><font color=orange> مقابل توصيل "..itemlabel..'</font></p>')
                        end
                    else
                        xPlayer.showNotification("<span style='color:#FB8405'>لقد تجاوزت الحد المسموح داخل المتجر المتنقل </span> <br><span  style='color:#FF0E0E;font-size:15'>الحد الإجمالي المسموح به : <span style='color:gray;'>"..Config.MaxFoodTrucksItems.."<br><span  style='color:#FF0E0E;font-size:15'>أنت تمتلك داخل المتجر المتنقل : <span style='color:gray;'>"..data[1].count)
                    end          		
                elseif data[1].price == Price then
                    if (data[1].count + ItemCount) <= Config.MaxFoodTrucksItems then
                        MySQL.Async.fetchAll("UPDATE foodtrucks SET count = @count WHERE item = @name AND plate = @plate",
                        {
                            ['@name'] = Item,
                            ['@plate'] = id,
                            ['@count'] = data[1].count + ItemCount
                        }
                        )
                        xPlayer.removeInventoryItem(Item, ItemCount)
                        if Config.is_set_duple then
                            TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', xPlayer.source, 'addnoduble', Config.addXpForBoxDelivery + Config.addXpForBoxDelivery)
                            xPlayer.showNotification("<h1><center><font color=green><font size=6px><i>توصيل صندوق</i></font></font></h1></br><p align=right> حصلت على خبرة: "..Config.addXpForBoxDelivery + Config.addXpForBoxDelivery.."</br><font color=orange> مقابل توصيل "..itemlabel..'</font></p>')
                        else
                            TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', xPlayer.source, 'addnoduble', Config.addXpForBoxDelivery)
                            xPlayer.showNotification("<h1><center><font color=green><font size=6px><i>توصيل صندوق</i></font></font></h1></br><p align=right> حصلت على خبرة: "..Config.addXpForBoxDelivery.."</br><font color=orange> مقابل توصيل "..itemlabel..'</font></p>')
                        end
                    else
                        xPlayer.showNotification("<span style='color:#FB8405'>لقد تجاوزت الحد المسموح داخل المتجر المتنقل </span> <br><span  style='color:#FF0E0E;font-size:15'>الحد الإجمالي المسموح به : <span style='color:gray;'>"..Config.MaxFoodTrucksItems.."<br><span  style='color:#FF0E0E;font-size:15'>أنت تمتلك داخل المتجر المتنقل : <span style='color:gray;'>"..data[1].count)
                    end 			
                elseif data ~= nil and data[1].price ~= Price then
                    Wait(250)
                    xPlayer.showNotification('لديك نفس العنصر بالفعل في متجرك معروض مقابل ' .. data[1].price .. ' أما السعر الجديد الذي تريد أن تعرضه به هو ' .. Price)
                    Wait(250)
                    xPlayer.showNotification('قم بتغيير سعر المنتج ومن ثم عرضه مجددا بالسعر الجديد')
                end
            end)
        end)
    end
end)

RegisterServerEvent('esx_misc:GetCache')
AddEventHandler('esx_misc:GetCache', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("esx_misc:updatePromotionStatus", source, '9ndo8_almtagr', Config.is_set_duple)
end)

function getshoptype(ndndndndndnnd)
	for k,v in pairs(Config.Zones) do
		if v.Pos.number == ndndndndndnnd then
			return v.Type
		end
	end
end

function log_buy(source, label_name, count, money_buy)
	local xPlayer = ESX.GetPlayerFromId(source)
    local message = "**لقد قام الاعب** : \n" .. xPlayer.getName() .. "\n\n**رقم الأستيم :** \n" .. xPlayer.identifier .. "\n\n**اسم الأستيم :** \n" .. GetPlayerName(source) .. "\n\n**الوظيفة :** \n" .. xPlayer.job.label .. " - " .. xPlayer.job.grade_label .. "\n\n**ب شراء : **\n" .. label_name .. "\n\n**الكمية :** \n" .. count .. "\n\n**بمبلغ :** \n$" .. money_buy
	local DiscordWebHook = "https://discord.com/api/webhooks/1053314990800638012/pAtN9-5igNggLEGUIbn89JEqKQYy7CIGigxZUOqDZpsroS8X6uPfjO8Y4Vgx366uBaMK"
  
  	local embeds = {
	  	{
		  	["title"]=  message,
		  	["type"]="rich",
		  	["color"] = 0000,
		  	["footer"]=  {
			  	["text"]= "شراء",
		 	},
	  	}
  	}
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = "شراء",embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
function log_buy2(source, label_name, money_buy)
	local xPlayer = ESX.GetPlayerFromId(source)
    local message = "**لقد قام الاعب** : \n" .. xPlayer.getName() .. "\n\n**رقم الأستيم :** \n" .. xPlayer.identifier .. "\n\n**اسم الأستيم :** \n" .. GetPlayerName(source) .. "\n\n**الوظيفة :** \n" .. xPlayer.job.label .. " - " .. xPlayer.job.grade_label .. "\n\n**ب شراء : **\n" .. label_name .. "\n\n**بمبلغ :** \n$" .. money_buy .. "\n\nغير قانوني"
	local DiscordWebHook = "https://discord.com/api/webhooks/1053314990800638012/pAtN9-5igNggLEGUIbn89JEqKQYy7CIGigxZUOqDZpsroS8X6uPfjO8Y4Vgx366uBaMK"
  
  	local embeds = {
	  	{
		  	["title"]=  message,
		  	["type"]="rich",
		  	["color"] = 0000,
		  	["footer"]=  {
			  	["text"]= "شراء",
		 	},
	  	}
  	}
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = "شراء",embeds = embeds}), { ['Content-Type'] = 'application/json' })
end


-- BUYING PRODUCT
RegisterNetEvent('esx_kr_shops:Buy')
AddEventHandler('esx_kr_shops:Buy', function(id, Item, ItemCount, token, shopid)
    local _source = source
    local src = source
    local identifier = ESX.GetPlayerFromId(src).identifier
    local xPlayer = ESX.GetPlayerFromId(src)
    local ItemLabel = ESX.GetItemLabel(Item)
    local ItemCount = tonumber(ItemCount)
    if shopid ~= 2000 then
        local typee = getshoptype(id)    
        MySQL.Async.fetchAll('SELECT count, item, price, label FROM shops WHERE ShopNumber = @Number AND item = @item', {
            ['@Number'] = id,
            ['@item'] = Item,
        }, function(result)
            MySQL.Async.fetchAll('SELECT money FROM owned_shops WHERE ShopNumber = @Number', {
                ['@Number'] = id,
            }, function(result2)
                local blackm = false
                local weaponn = false
                for i = 1, #Config.Items[typee], 1 do
                    if Config.Items[typee][i].itemConvert == Item then
                        if Config.Items[typee][i].black == true then
                            blackm = true
                            break
                        end
                    end
                end
                for i = 1, #Config.Items[typee], 1 do
                    if Config.Items[typee][i].itemConvert == Item then
                        if Config.Items[typee][i].type == 'weapon' then
                            weaponn = true
                            break
                        end
                    end
                end
    
                if not blackm and xPlayer.getMoney() < ItemCount * result[1].price then
                    TriggerClientEvent('esx:showNotification', src, '<font color=red> النقود لاتكفي لإتمام العملية الشرائية')
                elseif blackm and xPlayer.getAccount('black_money').money < ItemCount * result[1].price then
                    TriggerClientEvent('esx:showNotification', src, '<font color=red> لا تملك أموال غير قانونية لإتمام العملية الشرائية')
                elseif ItemCount <= 0 then
                    TriggerClientEvent('esx:showNotification', src, '<font color=red> كمية غير صالحة')
                else
                    if weaponn or CanCarryItemForBuy(src, result[1].item, ItemCount) then
                        if blackm then
                            xPlayer.removeAccountMoney('black_money', ItemCount * result[1].price)
                            log_buy2(src, result[1].label, ItemCount * result[1].price)
                            TriggerClientEvent('esx:showNotification', xPlayer.source, ' تم شراء <font color=yellow>' .. ItemCount .. ' <font color=#2C8BAF> ' .. result[1].label .. '<font color=white> بمبلغ <font color=red>$<font color=white>' .. ItemCount * result[1].price.. ' غير قانوني')
                        else
                            xPlayer.removeMoney(ItemCount * result[1].price)
                            log_buy(src, result[1].label, ItemCount, ItemCount * result[1].price)
                            TriggerClientEvent('esx:showNotification', xPlayer.source, ' تم شراء <font color=yellow>' .. ItemCount .. ' <font color=#2C8BAF> ' .. result[1].label .. '<font color=white> بمبلغ <font color=green>$<font color=white>' .. ItemCount * result[1].price)
                        end
                        if weaponn then
                            xPlayer.addWeapon(result[1].item, 30)
                        else
                            xPlayer.addInventoryItem(result[1].item, ItemCount)
                        end
    
                        MySQL.Async.execute("UPDATE owned_shops SET money = @money WHERE ShopNumber = @Number",
                        {
                            ['@money']      = result2[1].money + (result[1].price * ItemCount),
                            ['@Number']     = id,
                        })
            
    
                        if result[1].count ~= ItemCount then
                            MySQL.Async.execute("UPDATE shops SET count = @count WHERE item = @name AND ShopNumber = @Number",
                            {
                                ['@name'] = Item,
                                ['@Number'] = id,
                                ['@count'] = result[1].count - ItemCount
                            })
                        elseif result[1].count == ItemCount then
                            MySQL.Async.fetchAll("DELETE FROM shops WHERE item = @name AND ShopNumber = @Number",
                            {
                                ['@Number'] = id,
                                ['@name'] = result[1].item
                            })
                        end
                    else
                        xPlayer.showNotification('<font color=red>لا توجد مساحة كافية في الحقيبة</font>')
                    end
                end
            end)
        end)
    else	
        MySQL.Async.fetchAll('SELECT * FROM foodtrucks WHERE plate = @Number AND item = @item', {
            ['@Number'] = id,
            ['@item'] = Item,
        }, function(result)
            MySQL.Async.fetchAll('SELECT * FROM owned_foodtrucks WHERE plate = @Number', {
                ['@Number'] = id,
            }, function(result2)
                if xPlayer.getMoney() < ItemCount * result[1].price then
                    TriggerClientEvent('pNotify:SendNotification', src, {
                        text = '<center><b style="color:#ea1f1f;font-size:26px;"> لا تملك المال الكافي ', 
                        type = "info", 
                        timeout = 10000, 
                        layout = "centerLeft"
                    })	
                elseif ItemCount <= 0 then
                --TriggerClientEvent('esx:showpNotifyNotification', src, 'invalid quantity.')
                    TriggerClientEvent('pNotify:SendNotification', src, {
                        text = '<center><b style="color:#ea1f1f;font-size:26px;"> قيمة غير صالحة ', 
                        type = "info", 
                        timeout = 10000, 
                        layout = "centerLeft"
                    })	
                elseif xPlayer.canCarryItem(Item, ItemCount) then
                    xPlayer.removeMoney(ItemCount * result[1].price)
                    TriggerClientEvent('pNotify:SendNotification', xPlayer.source, {
                        text = '<center><b style="color:#0BAF5F;font-size:26px;"> ملخص عملية الشراء </b></center> <br /><br /><div align="right"> <b style="color:White;font-size:20px">  الكمية : <b style="color:#edb040">' .. ItemCount .. '</b></center> <br /><br /><div align="right"> <b style="color:White;font-size:20px"> الصنف : <b style="color:#edb040">' .. ItemLabel .. '</b></center> <br /><br /><div align="right"> <b style="color:White;font-size:20px"> السعر : <b style="color:#edb040">' .. ItemCount * result[1].price ..'<b style="color:#0BAF5F"> $ ', 
                        type = "info", 
                        timeout = 10000, 
                        layout = "centerLeft"
                    })
                    xPlayer.addInventoryItem(result[1].item, ItemCount)
                    local result3 = (ItemCount * result[1].price)
                    MySQL.Async.execute("UPDATE owned_foodtrucks SET money = money + @money, totalachat = totalachat + @money WHERE plate = @Number",
                    {
                        ['@money']      = result3,
                        ['@Number']     = id,
                    })
        

                    if result[1].count ~= ItemCount then
                        MySQL.Async.execute("UPDATE foodtrucks SET count = @count WHERE item = @name AND plate = @Number",
                        {
                            ['@name'] = Item,
                            ['@Number'] = id,
                            ['@count'] = result[1].count - ItemCount
                        })
                    elseif result[1].count == ItemCount then
                        MySQL.Async.fetchAll("DELETE FROM foodtrucks WHERE item = @name AND plate = @Number",
                        {
                            ['@Number'] = id,
                            ['@name'] = result[1].item
                        })
                    end
                else
                    TriggerClientEvent('pNotify:SendNotification', src, {text = '<center><b style="color:#ea1f1f;font-size:26px;"> حقيبتك ممتلئة ', type = "info",  timeout = 10000, layout = "centerLeft"})
                end
            end)
        end)	
	end
end)

--CALLBACKS
ESX.RegisterServerCallback('esx_kr_shop:getShopList', function(source, cb)
  local identifier = ESX.GetPlayerFromId(source).identifier
  local xPlayer = ESX.GetPlayerFromId(source)

        MySQL.Async.fetchAll(
        'SELECT ShopNumber, ShopValue, identifier, money, LastRobbery, ShopName FROM owned_shops WHERE identifier = @identifier',
        {
            ['@identifier'] = '0',
        }, function(result)

      cb(result)
    end)
end)


ESX.RegisterServerCallback('esx_kr_shop:getOwnedBlips', function(source, cb)

        MySQL.Async.fetchAll(
        'SELECT ShopNumber, ShopValue, identifier, money, LastRobbery, ShopName FROM owned_shops WHERE NOT identifier = @identifier',
        {
            ['@identifier'] = '0',
        }, function(results)
        cb(results)
    end)
end)

ESX.RegisterServerCallback('esx_kr_shop:getAllShipments', function(source, cb, id, shopid)
    if shopid ~= 2000 then
        MySQL.Async.fetchAll('SELECT * FROM shipments WHERE id = @id', {
            ['@id'] = id,
        }, function(result)
            cb(result)
        end)
    else
        MySQL.Async.fetchAll('SELECT * FROM shipments_foodtruck WHERE plate = @plate', {
            ['@plate'] = id,
        }, function(result)
            cb(result)
        end)
    end
end)

ESX.RegisterServerCallback('esx_kr_shop:getTime', function(source, cb)
    cb(os.time())
end)

ESX.RegisterServerCallback('esx_kr_shop:getOwnedShop', function(source, cb, id, shopid)
    local src = source
    local identifier = ESX.GetPlayerFromId(src).identifier
    if shopid ~= 2000 then
        MySQL.Async.fetchAll('SELECT * FROM owned_shops WHERE (ShopNumber = @ShopNumber)', {
            ['@ShopNumber'] = id,
        }, function(result)

            if result[1] ~= nil then
                local grade = 0 
                if identifier == result[1].identifier then
                    grade = 3 
                else
                    if result[1].emps == nil then
                        --print()
                    else
                        result[1].emps = json.decode(result[1].emps)
                        for k,v in pairs(result[1].emps) do 
                            if v == identifier then
                                grade = 1
                                break     
                            end
                        end
                    end
                end
                cb(result, grade)
            else
                cb(nil)
            end
        end)
    else
        MySQL.Async.fetchAll('SELECT * FROM owned_foodtrucks WHERE (plate = @plate)', {
            ['@plate'] = id,
        }, function(result)
            if result[1] then
                local grade = 0
                if identifier == result[1].identifier then
                    grade = 3 
                end
                cb(result[1], grade)
            else
                cb(nil)
            end
        end)	
    end
end)

ESX.RegisterServerCallback('esx_kr_shop:getShopItems', function(source, cb, number, shopid)
    local identifier = ESX.GetPlayerFromId(source).identifier
    if shopid ~= 2000 then
        MySQL.Async.fetchAll('SELECT * FROM shops WHERE ShopNumber = @ShopNumber', {
            ['@ShopNumber'] = number
        }, function(result)
            cb(result)
        end)
    else
        MySQL.Async.fetchAll('SELECT * FROM foodtrucks WHERE plate = @plate', {
            ['@plate'] = number
        }, function(result)
            cb(result)
        end)
    end
end)

RegisterNetEvent('esx_kr_shops:GetAllItems')
AddEventHandler('esx_kr_shops:GetAllItems', function(id, item, idd, token, shopid)
    local _source = source

    local xPlayer = ESX.GetPlayerFromId(_source)

    if shopid ~= 2000 then
    
        MySQL.Async.fetchAll('SELECT * FROM shipments WHERE id = @id AND idd = @idd', {
            ['@id'] = id,
            ['@idd'] = idd
    
        }, function(result)
            if result[1] ~= nil then
                if xPlayer.canCarryItem(item, 1) then
                    if xPlayer.getInventoryItem(item).count < 5 then
                        xPlayer.addInventoryItem(item, 1)
                        if tonumber(result[1].count) > 1 then
                            MySQL.Async.execute("UPDATE shipments SET count = @count WHERE id = @id AND idd = @idd",
                            {
                                ['@count']      = result[1].count - 1,
                                ['@id']     = id,
                                ['@idd'] = idd,
                            })
                        else
                            MySQL.Async.fetchAll("DELETE FROM shipments WHERE id = @id AND idd = @idd",
                            {
                                ['@id']     = id,
                                ['@idd'] = idd,
                            })
                        end
                    elseif xPlayer.getInventoryItem(item).count >= 5 then
                        xPlayer.showNotification('<font color=red>لديك 5 صناديق او اكثر نفس الصندوق في الحقيبة</font>')
                    end
                else
                    xPlayer.showNotification('<font color=red>لا توجد مساحة كافية في الحقيبة</font>')
                end
            end
        end)
    else
        MySQL.Async.fetchAll('SELECT * FROM shipments_foodtruck WHERE plate = @plate AND idd = @idd', {
            ['@plate'] = id,
            ['@idd'] = idd
        }, function(result)
            if result[1] ~= nil then
                if xPlayer.canCarryItem(item, 1) then
                    if xPlayer.getInventoryItem(item).count < 5 then
                        xPlayer.addInventoryItem(item, 1)
                        if tonumber(result[1].count) > 1 then
                            MySQL.Async.execute("UPDATE shipments_foodtruck SET count = @count WHERE plate = @plate AND idd = @idd",
                            {
                                ['@count']      = result[1].count - 1,
                                ['@plate']     = id,
                                ['@idd'] = idd,
                            })
                        else
                            MySQL.Async.fetchAll("DELETE FROM shipments_foodtruck WHERE plate = @plate AND idd = @idd",
                            {
                                ['@plate']     = id,
                                ['@idd'] = idd,
                            })
                        end
                    elseif xPlayer.getInventoryItem(item).count >= 5 then
                        xPlayer.showNotification('<font color=red>لديك 5 صناديق او اكثر نفس الصندوق في الحقيبة</font>')
                    end
                else
                    xPlayer.showNotification('<font color=red>لا توجد مساحة كافية في الحقيبة</font>')
                end
            end
        end)
    end
end)


RegisterNetEvent('esx_kr_shops-robbery:UpdateCanRob')
AddEventHandler('esx_kr_shops-robbery:UpdateCanRob', function(id)
    MySQL.Async.fetchAll("UPDATE owned_shops SET LastRobbery = @LastRobbery WHERE ShopNumber = @ShopNumber",{['@ShopNumber'] = id,['@LastRobbery']    = os.time(),})
end)

RegisterNetEvent('esx_kr_shop:MakeShipment')
AddEventHandler('esx_kr_shop:MakeShipment', function(id, item, price, count, label, shopid)
    local _source = source
    if shopid ~= 2000 then
        MySQL.Async.fetchAll('SELECT money FROM owned_shops WHERE ShopNumber = @ShopNumber',{['@ShopNumber'] = id,}, function(result)
            if result[1].money >= price * count then

                MySQL.Async.execute('INSERT INTO shipments (id, label, item, price, count, time) VALUES (@id, @label, @item, @price, @count, @time)',{['@id']       = id,['@label']      = label,['@item']       = item,['@price']      = price,['@count']      = count,['@time']       = os.time()})
                MySQL.Async.fetchAll("UPDATE owned_shops SET money = @money WHERE ShopNumber = @ShopNumber",{['@ShopNumber'] = id,['@money']    = result[1].money - price * count,})  
                TriggerClientEvent('esx:showNotification', _source, ' لقد طلبت شحنة <font color=yellow>' .. count .. '<font color=#2C8BAF> قطعة <font color=white>' .. label .. ' بمبلغ <font color=green>$<font color=white>' .. price * count)
            else
                TriggerClientEvent('esx:showNotification', _source, '<font color=red> ليس لديك ما يكفي من المال في متجرك')
            end
        end)
    else
        MySQL.Async.fetchAll('SELECT money FROM owned_foodtrucks WHERE plate = @plate',{['@plate'] = id,}, function(result)
            if result[1].money >= price * count then
                MySQL.Async.execute('INSERT INTO shipments_foodtruck (plate, label, item, price, count, time) VALUES (@plate, @label, @item, @price, @count, @time)',{['@plate']       = id,['@label']      = label,['@item']       = item,['@price']      = price,['@count']      = count,['@time']       = os.time()})
                MySQL.Async.fetchAll("UPDATE owned_foodtrucks SET money = @money WHERE plate = @plate",{['@plate'] = id,['@money']    = result[1].money - price * count,})
                TriggerClientEvent('esx:showNotification', _source, ' لقد طلبت شحنة <font color=yellow>' .. count .. '<font color=#2C8BAF> قطعة <font color=white>' .. label .. ' بمبلغ <font color=green>$<font color=white>' .. price * count)
            else
                TriggerClientEvent('esx:showNotification', _source, '<font color=red> ليس لديك ما يكفي من المال في متجرك')
            end
        end)
    end
end)

--BOSS MENU STUFF
RegisterNetEvent('esx_kr_shops:addMoney')
AddEventHandler('esx_kr_shops:addMoney', function(amount, number, shopid)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if shopid ~= 2000 then
        MySQL.Async.fetchAll('SELECT LastRobbery, money FROM owned_shops WHERE ShopNumber = @Number',{
            ['@Number'] = number,
        }, function(result)  
            local xPlayer = ESX.GetPlayerFromId(_source)
            if xPlayer then
                if xPlayer.getMoney() >= amount then
                    MySQL.Async.fetchAll("UPDATE owned_shops SET money = @money WHERE ShopNumber = @Number",
                    {
                        ['@money']      = result[1].money + amount,
                        ['@Number']     = number,
                    })
                    xPlayer.removeMoney(amount)
                    add_to_store_money(_source, amount)
                    TriggerClientEvent('esx:showNotification', xPlayer.source, ' تم إيدع <font color=green>$<font color=white>' .. amount .. ' في متجرك')
                else
                    TriggerClientEvent('esx:showNotification', xPlayer.source, '<font color=red> لا يمكنك إيداع أكثر مما تملك')
                end
            end
        end)
    else
        MySQL.Async.fetchAll('SELECT LastRobbery, money FROM owned_foodtrucks WHERE plate = @plate',{
            ['@plate'] = number,
        }, function(result)  
            local xPlayer = ESX.GetPlayerFromId(_source)
            if xPlayer then
                if xPlayer.getMoney() >= amount then
                    MySQL.Async.fetchAll("UPDATE owned_foodtrucks SET money = @money WHERE plate = @plate",
                    {
                        ['@money']      = result[1].money + amount,
                        ['@plate']     = number,
                    })
                    xPlayer.removeMoney(amount)
                    add_to_store_money(_source, amount)
                    TriggerClientEvent('esx:showNotification', xPlayer.source, ' تم إيدع <font color=green>$<font color=white>' .. amount .. ' في متجرك المتنقل')
                else
                    TriggerClientEvent('esx:showNotification', xPlayer.source, '<font color=red> لا يمكنك إيداع أكثر مما تملك')
                end
            end
        end)
    end
end)

RegisterNetEvent('esx_kr_shops:takeOutMoney')
AddEventHandler('esx_kr_shops:takeOutMoney', function(amount, number, token, shopid)
    local _source = source
    local src = source
    local identifier = ESX.GetPlayerFromId(src).identifier
    local xPlayer = ESX.GetPlayerFromId(src)
    if shopid ~= 2000 then
        MySQL.Async.fetchAll('SELECT money, LastRobbery FROM owned_shops WHERE identifier = @identifier AND ShopNumber = @Number', {
            ['@identifier'] = identifier,
            ['@Number'] = number,
        }, function(result)
            if os.time() - result[1].LastRobbery <= 900 then
                time = os.time() - result[1].LastRobbery
                TriggerClientEvent('esx:showNotification', xPlayer.source, ' تم قفل أموال متجرك بسبب السرقة ، يرجى الانتظار <font color=red>' .. math.floor((900 - time) / 60) .. ' دقيقة')
                return
            end
            if result[1].money >= amount then
                MySQL.Async.fetchAll("UPDATE owned_shops SET money = @money WHERE identifier = @identifier AND ShopNumber = @Number",
                {
                    ['@money']      = result[1].money - amount,
                    ['@Number']     = number,
                    ['@identifier'] = identifier
                })
                remve_money_from_store(src, amount)
                TriggerClientEvent('esx:showNotification', xPlayer.source, ' تم سحب <font color=green>$<font color=white>' .. amount .. ' من متجرك')
                if xPlayer then
                    xPlayer.addMoney(amount)
                end
            else
                TriggerClientEvent('esx:showNotification', xPlayer.source, '<font color=red> لا يمكنك سحب أكثر مما في المتجر')
            end
        end)
    else
        MySQL.Async.fetchAll('SELECT * FROM owned_foodtrucks WHERE identifier = @identifier AND plate = @Number', {
            ['@identifier'] = identifier,
            ['@Number'] = number,
        }, function(result)
            if result[1].money >= amount then
                MySQL.Async.fetchAll("UPDATE owned_foodtrucks SET money = @money, totalwithdraw = @totalwithdraw WHERE identifier = @identifier AND plate = @Number",
                {
                    ['@money']      = result[1].money - amount,
                    ['@totalwithdraw']      = result[1].totalwithdraw + amount,
                    ['@Number']     = number,
                    ['@identifier'] = identifier
                })
                xPlayer.showNotification('لقد سحبت ' .. amount .. ' من متجرك')
                xPlayer.addMoney(amount)
            else
                xPlayer.showNotification('لايمكنك أن تسحب أكثر مما تملك')
            end
        end)
    end
end)


RegisterNetEvent('esx_kr_shops:changeName')
AddEventHandler('esx_kr_shops:changeName', function(number, name)
  local identifier = ESX.GetPlayerFromId(source).identifier
  local xPlayer = ESX.GetPlayerFromId(source)
      MySQL.Async.fetchAll("UPDATE owned_shops SET ShopName = @Name WHERE identifier = @identifier AND ShopNumber = @Number",
      {
        ['@Number'] = number,
        ['@Name']     = name,
        ['@identifier'] = identifier
      })
      change_name_store(source, name)
      TriggerClientEvent('esx_kr_shops:removeBlip', -1)
      TriggerClientEvent('esx_kr_shops:setBlip', -1)
end)

RegisterNetEvent('esx_kr_shops:SellShop')
AddEventHandler('esx_kr_shops:SellShop', function(number, token, shopid)
    local _source = source
    local identifier = ESX.GetPlayerFromId(_source).identifier
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if shopid ~= 2000 then
        MySQL.Async.fetchAll('SELECT ShopValue, money FROM owned_shops WHERE identifier = @identifier AND ShopNumber = @ShopNumber', {
            ['@identifier'] = identifier,
            ['@ShopNumber'] = number,
        }, function(result)
            MySQL.Async.fetchAll('SELECT price, item FROM shops WHERE ShopNumber = @ShopNumber', {
                ['@ShopNumber'] = number,
            }, function(result2)
                if result[1] then
                    if result[1].money == 0 then
                        if result2[1] == nil then
                            MySQL.Async.fetchAll("UPDATE owned_shops SET identifier = @identifiers, ShopName = @ShopName WHERE identifier = @identifier AND ShopNumber = @Number",
                            {
                                ['@identifiers'] = '0',
                                ['@identifier'] = identifier,
                                ['@ShopName']    = '0',
                                ['@Number'] = number,
                            })
                            xPlayer.addMoney(result[1].ShopValue / 2)
                            TriggerClientEvent('esx_kr_shops:removeBlip', -1)
                            TriggerClientEvent('esx_kr_shops:setBlip', -1)
                            sell_store(src, number)
                            TriggerClientEvent('esx:showNotification', xPlayer.source, '<font color=orange> لقد بعت متجرك')
                        else
                            TriggerClientEvent('esx:showNotification', xPlayer.source, '<font color=red> لا يمكنك بيع متجرك لوجود عناصر ب المتجر')
                        end
                    else
                        TriggerClientEvent('esx:showNotification', xPlayer.source, '<font color=red> لا يمكنك بيع متجرك لوجود أموال ب المتجر')
                    end
                end
            end)
        end)
    else
        MySQL.Async.fetchAll('SELECT * FROM owned_foodtrucks WHERE identifier = @identifier AND plate = @plate', {
            ['@identifier'] = identifier,
            ['@plate'] = number,
        }, function(result)
            MySQL.Async.fetchAll('SELECT * FROM foodtrucks WHERE plate = @plate', {
                ['@plate'] = number,
            }, function(result2)
                if result[1].money == 0 and result2[1] == nil then
                    MySQL.Async.fetchAll("DELETE FROM owned_foodtrucks WHERE plate = @plate", {
                        ['@plate'] = number,
                    })
                    MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', { ["@plate"] = number})		
                    xPlayer.addMoney(result[1].ShopValue / 2)
                    TriggerClientEvent('esx_kr_shops:deletefoodtruck', -1)
                    xPlayer.showNotification('لقد قمت ببيع متجرك')
                else
                    xPlayer.showNotification('لا يمكنك بيع المتجر وأن تملك بضائع أو أموال بداخله')
                 end
            end)
        end)
    end
end)

ESX.RegisterServerCallback('esx_kr_shop:getUnBoughtShops', function(source, cb)
  local identifier = ESX.GetPlayerFromId(source).identifier
  local xPlayer = ESX.GetPlayerFromId(source)

  MySQL.Async.fetchAll(
    'SELECT * FROM owned_shops WHERE identifier = @identifier',
    {
      ['@identifier'] = '0',
    },
    function(result)

        cb(result)
    end)
end)

ESX.RegisterServerCallback('esx_kr_shop-robbery:getOnlinePolices', function(source, cb)
  local _source  = source
  local xPlayers = ESX.GetPlayers()
  local cops = 0

    for i=1, #xPlayers, 1 do

        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
        cops = cops + 1
        end
    end
    Wait(25)
    cb(cops)
end)

ESX.RegisterServerCallback('esx_kr_shop-robbery:getUpdates', function(source, cb, id)

    MySQL.Async.fetchAll(
    'SELECT * FROM owned_shops WHERE ShopNumber = @ShopNumber',
    {
     ['@ShopNumber'] = id,
    },
     function(result)

        if result[1].LastRobbery == 0 then
            id = id
            MySQL.Async.fetchAll("UPDATE owned_shops SET LastRobbery = @LastRobbery WHERE ShopNumber = @ShopNumber",
            {
            ['@ShopNumber'] = id,
            ['@LastRobbery']   = os.time(),
            })
        else
            if os.time() - result[1].LastRobbery >= Config.TimeBetweenRobberies then
                cb({cb = true, time = os.time() - result[1].LastRobbery, name = result[1].ShopName})
            else
                cb({cb = nil, time = os.time() - result[1].LastRobbery})
            end
        end
    end)
end)


RegisterNetEvent('esx_kr_shops-robbery:GetReward')
AddEventHandler('esx_kr_shops-robbery:GetReward', function(id, token)
    local counter = 0
    local money = 0
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchAll('SELECT money FROM owned_shops WHERE ShopNumber = @ShopNumber', {
        ['@ShopNumber'] = id,
    }, function(result)
        id = id
        MySQL.Async.fetchAll("UPDATE owned_shops SET money = @money WHERE ShopNumber = @ShopNumber", {
            ['@ShopNumber'] = id,
            ['@money']     = result[1].money - result[1].money / Config.CutOnRobbery,
        })
        id = id
        local shopid = id + 100
        local SellCoords = math.random(1, #Config.locations)
        local coords_t = Config.locations[SellCoords]
        for k,v in pairs(in_stolen_player) do
            if k == shopid then
                for k2,v2 in pairs(in_stolen_player[k]) do
                    if in_stolen_player[k][k2].owner == true then
                        in_stolen_player[k][k2].money = result[1].money / Config.CutOnRobbery
                    end
                end
            end
        end
        for k,v in pairs(in_stolen_player) do
            if k == shopid then
                for k2,v2 in pairs(in_stolen_player[k]) do
                    if in_stolen_player[k][k2].owner == true then
                        money = in_stolen_player[k][k2].money
                    end
                    counter = counter + 1
                end
            end
        end
        for k,v in pairs(in_stolen_player) do
            if k == shopid then
                for k2,v2 in pairs(in_stolen_player[k]) do
                    if counter == 1 then
                        TriggerClientEvent("esx_shops2:takemoney", k2, 1, money, money, shopid, coords_t)
                    else
                        local money_is_can_take = tonumber(math.floor(money / counter))
                        TriggerClientEvent("esx_shops2:takemoney", tonumber(k2), counter, money, money_is_can_take, shopid, coords_t)
                    end
                end
            end
        end
        TriggerClientEvent('esx_shops2:RobberyStartLeoJob', -1, 'stop')
    end)
end)

RegisterNetEvent('esx_kr_shops-robbery:NotifyOwner')
AddEventHandler('esx_kr_shops-robbery:NotifyOwner', function(msg, id, num, name)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local players = ESX.GetPlayers()

    if num == 1 then
        local mes1 = '^1أخبار عــاجل'
        --TriggerClientEvent('chatMessage', -1, mes1,  { 128, 0, 0 }, 'سطو مسلح على متجر ^3 '..name)
    end

    for i=1, #players, 1 do
        local identifier = ESX.GetPlayerFromId(players[i])
  
            if identifier.job.name == 'police' or identifier.job.name == 'police2' or identifier.job.name == 'admin' then
                if num == 1 then
                    identifier.triggerEvent('esx_shops2:RobberyStartLeoJob', 'start', xPlayer.getCoords(false))
                else
                    identifier.triggerEvent('esx_shops2:RobberyStartLeoJob', 'stop')
                end
            end

            MySQL.Async.fetchAll(
            'SELECT identifier FROM owned_shops WHERE ShopNumber = @ShopNumber',
            {
                ['@ShopNumber'] = id,
            }, function(result)

            if result[1].identifier == identifier.identifier then
                TriggerClientEvent('esx:showNotification', identifier.source, msg)
            end

        end)
    end
end)

ESX.RegisterServerCallback('esx_shops2:GetOwnShopNumber', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local owneroremps, owner = false, false
    local number = 0
    if xPlayer then
        MySQL.Async.fetchAll('SELECT identifier, ShopNumber FROM owned_shops',{
        },function(result)
            MySQL.Async.fetchAll('SELECT shop FROM users WHERE identifier=@identifier',{
                ['@identifier'] = xPlayer.identifier
            },function(result2)
                for i = 1, #result, 1 do
                    if result[i] then
                        if result[i].identifier == xPlayer.identifier then
                            owneroremps = true
                            owner = true
                            number = result[i].ShopNumber
                            cb({owneroremps = owneroremps, number = number, owner = owner})
                        end

                        if result2[1].shop == result[i].ShopNumber then
                            owneroremps = true
                            number = result[i].ShopNumber
                            cb({owneroremps = owneroremps, number = number})
                        end
                    end
                end
            end)
        end)
        if not owner or not owneroremps then
            MySQL.Async.fetchAll('SELECT identifier, plate FROM owned_foodtrucks',{
            },function(result)
                for i = 1, #result, 1 do
                    if result[i] then
                        if result[i].identifier == xPlayer.identifier then
                            owneroremps = true
                            owner = true
                            number = result[i].plate
                            cb({owneroremps = true, number = number, is_food_truck = true})
                        end
                    end
                end
            end)
        end
    end
end)

ESX.RegisterServerCallback('esx_shops2:canorder', function(source, cb, id, shopid)
    if shopid ~= 2000 then
        MySQL.Async.fetchAll('SELECT count FROM shipments WHERE id = @id', {
            ['@id'] = id,
        }, function(data)
            if data[1] ~= nil then
                local OrdererTotal = 0
                for i = 1, #data, 1 do
                    if data[i] then
                        OrdererTotal = OrdererTotal + data[i].count
                    end
                end
                cb(OrdererTotal)
            else
                cb(0)
            end
        end)
    else
        MySQL.Async.fetchAll('SELECT count FROM shipments_foodtruck WHERE plate = @plate', {
            ['@plate'] = id,
        }, function(data)
            if data[1] ~= nil then
                local OrdererTotal = 0
                for i = 1, #data, 1 do
                    if data[i] then
                        OrdererTotal = OrdererTotal + data[i].count
                    end
                end
            else
                cb(0)
            end
        end)
    end
end)

RegisterNetEvent('esx_kr_shops:resellItem')
AddEventHandler('esx_kr_shops:resellItem', function(number, count, name, name_label, shopid)
    if shopid ~= 2000 then
        MySQL.Async.fetchAll("UPDATE shops SET price = @price WHERE ShopNumber = @ShopNumber AND item = @item", {
            ['@ShopNumber'] = number,
            ['@item'] = name,
            ['@price']     = count,
        })
        change_price_item(source, count, name_label)
    else
        MySQL.Async.fetchAll('SELECT price FROM foodtrucks WHERE item = @item AND plate = @plate', {
            ['@plate'] = number,
            ['@item'] = name,
        }, function(data)
            if data[1].price ~= count then
                MySQL.Async.fetchAll("UPDATE foodtrucks SET price = @price WHERE item = @item AND plate = @plate", {
                    ['@item'] = name,
                    ['@plate'] = number,
                    ['@price'] = count
                }, function(result)
                end)
            end
        end)
    end
end)

RegisterNetEvent('esx_shops2:setemps')
AddEventHandler('esx_shops2:setemps', function(number, selectedPlayerId)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local xTarget = ESX.GetPlayerFromId(selectedPlayerId)
    MySQL.Async.fetchAll('SELECT shop FROM users WHERE shop = @number',
    {
        ['@number'] = number,
    }, function(data)
        if data[2] == nil then
            MySQL.Async.fetchAll("UPDATE users SET shop = @number WHERE identifier = @identifier",
                {
                    ['@number'] = number,
                    ['@identifier'] = xTarget.identifier,
                })
                add_modfen_in_store(src, selectedPlayerId)
            xPlayer.showNotification('<font color=green>تم توظيف </font>'..xTarget.getName()..' في المتجر')
            xTarget.showNotification('قام '..xPlayer.getName()..' <font color=green>بتوظيفك </font> في متجره')
        else
            xPlayer.showNotification('<font color=red> الحد الأعلى للموظفين هو </font>2')
        end
    end)
end)

RegisterNetEvent('esx_shops2:removeemps')
AddEventHandler('esx_shops2:removeemps', function(number, identifier)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local xTarget = ESX.GetPlayerFromIdentifier(identifier)
    MySQL.Async.fetchAll("UPDATE users SET shop = @number WHERE identifier = @identifier",
    {
        ['@number'] = 0,
        ['@identifier'] = identifier,
    })

    MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier',
    {
        ['@identifier'] = identifier,
    }, function(data)
        if data[1] then
            local namme = data[1].firstname.. ' ' ..data[1].lastname
            xPlayer.showNotification('<font color=red>تم طرد </font>'..namme..' من المتجر')
            kick_modf_from_store(src, identifier)
            if xTarget then
                xTarget.showNotification('قام '..xPlayer.getName()..' <font color=red>بطردك </font> من متجره')
            end
        end
    end)
end)

ESX.RegisterServerCallback('esx_shops2:getempslist', function(source, cb, number)
        
    MySQL.Async.fetchAll('SELECT firstname, lastname, identifier FROM users WHERE shop = @number',
    {
        ['@number'] = number,
    }, function(data)
        cb(data)
    end)
end)

--===================== MAZAD ===============--

local PlayersInMazad = {}

--[[
    PlayersInMazad[iden] = { money = 100, shop = 2 }
]]

local Mazad = {}

function DiscordSendMessageAdd(alfah_log, what_3rd_log, alr8m_log)

	local DiscordWebHook = "https://discord.com/api/webhooks/1097769647593492490/vxjccj2nbij2FVqWoXD2tR68vaO38gwG0aTxxh00_rP1eUqqB-fuEErukT6h1MOLzGqQ"
  
	local embeds = {
		{
			["title"]= "إدارة مزاد المتاجر 🏬\nتم عرض مزاد على " .. '\nالفئة : ' .. alfah_log .. '\nرقم ال'.. what_3rd_log ..' : '.. alr8m_log .. "\nبداء المزايدة : " .. "$750000",
			["type"]="rich",
			["color"] =color,
		}
	}
	
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function DiscordSendMessageWin(label_log, alfah_log, what_3rd_log, alr8m_log, player_who, money_how_the_player_added)
	local DiscordWebHook = "https://discord.com/api/webhooks/1097769647593492490/vxjccj2nbij2FVqWoXD2tR68vaO38gwG0aTxxh00_rP1eUqqB-fuEErukT6h1MOLzGqQ"
  
	local embeds = {
		{
			["title"]= "إدارة مزاد المتاجر 🏬\nتم إنهاء المزاد وتسليم ال " .. label_log .. " ل : " .. player_who .. '\nالفئة : ' .. alfah_log .. '\nرقم ال'.. what_3rd_log ..' : '.. alr8m_log .. "\nالمبلغ : $" .. money_how_the_player_added,
			["type"]="rich",
			["color"] =color,
		}
	}
	
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function returnmoneytoplayers(number)
    for k,v in pairs(PlayersInMazad) do
        if PlayersInMazad[k] and PlayersInMazad[k].shop == number then
            local xPlayer = ESX.GetPlayerFromIdentifier(k)
            if xPlayer then
                xPlayer.addMoney(PlayersInMazad[k].money)
                PlayersInMazad[k] = nil
            else
                MySQL.Async.fetchAll('SELECT accounts FROM users WHERE identifier = @identifier',
                {
                    ['@identifier'] = k,
                }, function(data)
                    local accounts = json.decode(data[1].accounts)
                    MySQL.Async.fetchAll("UPDATE users SET accounts = @accounts WHERE identifier = @identifier",
                    {
                        ['@accounts'] = json.encode({black_money = accounts.black_money, bank = accounts.bank, money = accounts.money + PlayersInMazad[k].money }),
                        ['@identifier'] = k,
                    })
                    PlayersInMazad[k] = nil
                end)
            end
        end
    end
end

function table.wesam(parsedTable)
	for _, _ in pairs(parsedTable) do
		return false
	end

	return true
end

function player_in_mazad(number_shop)
    local player_mazad = {}
    local is_empty = "is==false"
    if not table.wesam(PlayersInMazad) then
        for k,v in pairs(PlayersInMazad) do
            if PlayersInMazad[k].shop == number_shop then
                if Mazad[number_shop].player == PlayersInMazad[k].iden_player_in_mazad then
                    --print('')
                else
                    table.insert(player_mazad, {name_player = v.name_player_in_mazad, money = v.money, number = v.shop})
                end
            end
        end
        return player_mazad
    else
        is_empty = "is==true"
        return is_empty
    end
end

RegisterNetEvent('esx_shops2:mazaddd')
AddEventHandler('esx_shops2:mazaddd', function(data, label, amount, type, token, alfah, what_3rd, alr8m, money_oo)
    local _source = source
    -- if not exports['esx_misc2']:secureServerEvent(GetCurrentResourceName(), _source, token) then
    --     return false
    -- end
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer then
        if type == 'add' then
            xPlayer.showNotification('<font color=green>تم عرض '..label..' في المزاد</font>')
            TriggerClientEvent('chatMessage', -1, "  إدارة مزاد المتاجر 🏬  " ,  {173, 216, 230} ,  "تم عرض مزاد على ^3" .. 'الفئة : ' .. alfah .. ' | رقم ال'.. what_3rd ..' : '.. alr8m .. " ^0 بداء المزايدة" .. " ^3 750000$ ")
            --DiscordSendMessageAdd(alfah, what_3rd, alr8m)
            Mazad[data.ShopNumber] = {player = nil, money = 0, name_player = "لايوجد احد مزاود"}
        elseif type == 'remove' then
            xPlayer.showNotification('<font color=red>تم إزالة ال'..label..' من المزاد بنجاح</font>')
            returnmoneytoplayers(data.ShopNumber)
            Mazad[data.ShopNumber] = nil
        elseif type == 'playermazad' then
            MySQL.Async.fetchAll(
                'SELECT ShopValue FROM owned_shops WHERE identifier = @identifier',
                {
                    ['@identifier'] = xPlayer.identifier,
                }, function(data222222)
                    if data222222[1] == nil then
                        if Mazad[data.ShopNumber] ~= nil then
                            if Mazad[data.ShopNumber].player ~= xPlayer.identifier then
                                if PlayersInMazad[xPlayer.identifier] == nil or PlayersInMazad[xPlayer.identifier].shop == data.ShopNumber then
                                    if xPlayer.getMoney() >= amount then
                                        if amount >= Config.Mazad.L and amount <= Config.Mazad.H then
                                            xPlayer.showNotification('<font color=green>تم المزايدة على ال'..label..' رقم '..data.ShopNumber..'</font>')
                                            xPlayer.removeMoney(amount)
                                            Mazad[data.ShopNumber] = { player = xPlayer.identifier, money = Mazad[data.ShopNumber].money + amount, name_player = xPlayer.getName()}
                                            if PlayersInMazad[xPlayer.identifier] == nil then
                                                PlayersInMazad[xPlayer.identifier] = { money = amount, shop = data.ShopNumber, name_player_in_mazad = xPlayer.getName(), iden_player_in_mazad = xPlayer.identifier}
                                            else
                                                PlayersInMazad[xPlayer.identifier] = { money = PlayersInMazad[xPlayer.identifier].money + amount, shop = data.ShopNumber, name_player_in_mazad = xPlayer.getName(), iden_player_in_mazad = xPlayer.identifier}
                                            end
                                        else
                                            xPlayer.showNotification('<font color=orange>الحد الأدنى للمزايدة هو</font><font color=green> $</font>'..ESX.Math.GroupDigits(Config.Mazad.L)..'</br>'..'<font color=orange>الحد الأعلى للمزايدة هو</font><font color=green> $</font>'..ESX.Math.GroupDigits(Config.Mazad.H))
                                        end
                                    else
                                        xPlayer.showNotification('<font color=red>لا تملك نقود كاش للمزايدة</font>')
                                    end
                                else
                                    xPlayer.showNotification('<font color=red>لا يمكنك المزايدة على أكثر من متجر في وقت واحد</font>')
                                end
                            else
                                xPlayer.showNotification('<font color=red>لا يمكنك المزايدة على نفسك</font>')
                            end
                        end
                    else
                        xPlayer.showNotification('<font color=red>أنت مالك متجر ولا يمكنك المزايدة</font>')
                    end
                end)
        elseif type == 'close' then
            if Mazad[data.ShopNumber].player ~= nil then
                xPlayer.showNotification('<font color=green>تم إنهاء المزاد وتسليم ال'..label..'</font> ل'..ESX.GetPlayerFromIdentifier(Mazad[data.ShopNumber].player).getName())
                --DiscordSendMessageWin(label, alfah, what_3rd, alr8m, ESX.GetPlayerFromIdentifier(Mazad[data.ShopNumber].player).getName(), money_oo)
                TriggerClientEvent('chatMessage', -1, "  إدارة مزاد المتاجر 🏬  " ,  {173, 216, 230} ,  "تم إنهاء المزاد وتسليم ال ^3" .. label .. " ^0 ل ^3" .. ESX.GetPlayerFromIdentifier(Mazad[data.ShopNumber].player).getName())
                local xTarget = ESX.GetPlayerFromIdentifier(Mazad[data.ShopNumber].player)
                local what_label = nil
                if label == 'براد' then
                    what_label = 'دﺍﺮﺑ'
                elseif label == 'متجر' then
                    what_label = 'ﺮﺠﺘﻣ'
                elseif label == 'صيدلية' then
                    what_label = 'ﺔﻴﻟﺪﻴﺻ'
                elseif label == 'محل أسلحة' then
                    what_label = 'ﺔﺤﻠﺳﺃ ﻞﺤﻣ'
                elseif label == 'بار' then
                    what_label = 'رﺎﺑ'
                end
                TriggerClientEvent("esx_misc:controlSystemScaleform_mzadMabrok", xTarget.source, what_label)

                PlayersInMazad[Mazad[data.ShopNumber].player] = nil
                -------------------------
                -------------------------

                MySQL.Async.fetchAll("UPDATE owned_shops SET identifier = @identifier, ShopName = @ShopName WHERE ShopNumber = @ShopNumber",{['@identifier'] = Mazad[data.ShopNumber].player, ['@ShopNumber'] = data.ShopNumber, ['@ShopName'] = 'متجر'})
                TriggerClientEvent('esx_kr_shops:removeBlip', -1)
                TriggerClientEvent('esx_kr_shops:setBlip', -1)

                -------------------------
                -------------------------
                Mazad[data.ShopNumber] = nil
                returnmoneytoplayers(data.ShopNumber)
            else
                xPlayer.showNotification('<font color=orange>تم إنهاء المزاد ولم يزايد به أحد</font>')
            end
        end
    end
end)

ESX.RegisterServerCallback('esx_shops2:checkmazadstartornot', function(source, cb, number)
    if Mazad[number] == nil then
        cb({done = true})
    else
        cb({done = false, data = { money = Mazad[number].money, name_player = Mazad[number].name_player, player_in_mazad_is = player_in_mazad(number)}})
    end
end)


ESX.RegisterServerCallback('esx_shops2:CraftWeap9923ons', function(source, cb, data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer then
        if xPlayer.getInventoryItem('weaponcrafting').count >= 1 then
            if xPlayer.canCarryItem(data, 2) then
                cb(true)
                xPlayer.removeInventoryItem('weaponcrafting', 1)
                Citizen.Wait(Config.WeaponCraftTime)
                xPlayer.addInventoryItem(data, 2)
            else
                cb(false)
                xPlayer.showNotification('<font color=red>لا توجد مساحة كافية </br></font> سوف تحصل على 2 صندوق سلاح مقابل عدة تصنيع')
            end
        else
            cb(false)
            xPlayer.showNotification('<font color=red>لا تملك '.. xPlayer.getInventoryItem('weaponcrafting').label..' لتصنيع السلاح</font>')
        end
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('esx_shops2:CraftWeap9923ons2', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer then
        MySQL.Async.fetchAll('SELECT ShopNumber FROM owned_shops WHERE identifier = @identifier',
        {
            ['@identifier'] = xPlayer.identifier,
        }, function(result)
            MySQL.Async.fetchAll('SELECT shop FROM users WHERE identifier = @identifier',
            {
                ['@identifier'] = xPlayer.identifier,
            }, function(result2)
                if result[1] then
                    if result2[1] then
                        if Config.Zones[result[1].ShopNumber].Type == 'weapons' or Config.Zones[result2[1].shop].Type == 'weapons' then
                            cb(true)
                        else
                            cb(false)
                        end
                    else
                        cb(false)
                    end
                else
                    if result2[1] then
                        if Config.Zones[result2[1].shop] and Config.Zones[result2[1].shop].Type == 'weapons' then
                            cb(true)
                        else
                            cb(false)
                        end
                    else
                        cb(false)
                    end
                end
            end)
        end)
    else
        cb(false)
    end
end)