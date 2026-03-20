ESX = nil
local favorite_list = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("esx_animations:ServerEmoteRequest")
AddEventHandler("esx_animations:ServerEmoteRequest", function(target, emotename, etype)
	TriggerClientEvent("esx_animations:ClientEmoteRequestReceive", target, emotename, etype)
end)


RegisterNetEvent("esx_animations:ServerValidEmote") 
AddEventHandler("esx_animations:ServerValidEmote", function(target, requestedemote, otheremote)
	TriggerClientEvent("esx_animations:SyncPlayEmote", source, otheremote, source)
	TriggerClientEvent("esx_animations:SyncPlayEmoteSource", target, requestedemote)
end)

ESX.RegisterServerCallback("esx_wesam:getfavorite", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		MySQL.Async.fetchAll('SELECT * FROM favorite_f3 WHERE owner = @owner', {
			['@owner'] = xPlayer.identifier
		}, function(data)
			if data[1] then
				cb(data)
			else
				cb(false)
			end
		end)
	end
end)

RegisterNetEvent("esx_wesam:remove_animations")
AddEventHandler("esx_wesam:remove_animations", function(id)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		MySQL.Async.fetchAll("DELETE FROM favorite_f3 WHERE id = @id", {
			['@id'] = id,
		})
		xPlayer.showNotification("تم <font color=red>الحذف</font>")
	end
end)

RegisterNetEvent("esx_wesam:addAniminDataBasefavorite")
AddEventHandler("esx_wesam:addAniminDataBasefavorite", function(label, data_type, lib, anim, name, type_in_data)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		MySQL.Async.execute('INSERT INTO favorite_f3 (owner, label, type, data_lib, data_anim, data_name, data_type) VALUES (@owner, @label, @type, @data_lib, @data_anim, @data_name, @type_in_data)',{
			['@owner'] = xPlayer.identifier,
			["label"] = label,
			["@type"] = data_type,
			["@data_lib"] = lib,
			["@data_anim"] = anim,
			["@data_name"] = name,
			['@type_in_data'] = type_in_data
		})
	end
end)