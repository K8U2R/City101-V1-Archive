
-----------------------------------------------------------------------------------------------------
-- Shared Emotes Syncing  ---------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

RegisterNetEvent("esx_animations:ServerEmoteRequest")
AddEventHandler("esx_animations:ServerEmoteRequest", function(target, emotename, etype)
	TriggerClientEvent("esx_animations:ClientEmoteRequestReceive", target, emotename, etype)
end)

RegisterNetEvent("esx_animations:ServerValidEmote") 
AddEventHandler("esx_animations:ServerValidEmote", function(target, requestedemote, otheremote)
	TriggerClientEvent("esx_animations:SyncPlayEmote", source, otheremote, source)
	TriggerClientEvent("esx_animations:SyncPlayEmoteSource", target, requestedemote)
end)

--[[RegisterNetEvent("esx_misc3:AddWalkToDataBase") 
AddEventHandler("esx_misc3:AddWalkToDataBase", function(type, WalkName)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer then
		if type == 'reset' then
			MySQL.Async.fetchAll("UPDATE users SET walk = @walk WHERE identifier = @identifier",
			{
				['@identifier'] = xPlayer.identifier,
				['@walk'] = NULL,
			}, function()
				xPlayer.showNotification('<font color=green>تم الحفظ على المشي العادي</font>')
			end)
		elseif type  == 'add' then
			MySQL.Async.fetchAll("UPDATE users SET walk = @walk WHERE identifier = @identifier",
			{
				['@identifier'] = xPlayer.identifier,
				['@walk'] = WalkName,
			}, function()
				xPlayer.showNotification('<font color=green>تم حفظ طريقة المشي بنجاح</font>')
			end)
		end
	end
end)]]


--[[RegisterNetEvent("esx_misc3:AddWalkToDataBase_server") 
AddEventHandler("esx_misc3:AddWalkToDataBase_server", function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer then
		MySQL.Async.fetchAll("SELECT Walk FROM users WHERE identifier = @identifier",
		{
			['@identifier'] = xPlayer.identifier,
		}, function(result)
			if result[1] then
				if result[1].Walk then
					xPlayer.triggerEvent('esx_misc3:addWalkPlayerJoin', 'add', result[1].Walk)
				else
					xPlayer.triggerEvent('esx_misc3:addWalkPlayerJoin', 'Reset')
				end
			end
		end)
	end
end)]]