ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_misc:getpickupLabel', function(source, cb, name)
    MySQL.Async.fetchAll("SELECT pickup FROM items WHERE name=@name", {
        ['@name'] = name
    }, function(result)
        if result[1] ~= nil then
            cb(result[1].pickup)
        end
    end)
end)