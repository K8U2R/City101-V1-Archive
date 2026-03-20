ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("esx-qalle-jail:jailPlayer")
AddEventHandler("esx-qalle-jail:jailPlayer", function(targetSrc, jailTime, jailReason, token)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.job.name == 'police' or xPlayer.job.name == 'agent' or xPlayer.job.name == 'admin' then
		local src = source
		local targetSrc = tonumber(targetSrc)
		local xTarget = ESX.GetPlayerFromId(targetSrc)

		JailPlayer(targetSrc, jailTime)
		local name  = xPlayer.getName()
		local namee = xPlayer.getName()
		local getjobstring = exports.chat:getjobcolor(xPlayer.job.name)
		local message = " تم إحالة المدعو/^3 "..xTarget.getName().."^0 إلى السجن بتهمة ^3"..jailReason.."^0 لمدة ^3"..jailTime.."^0 شهر "
		if xPlayer.job.name == 'admin' then
			TriggerClientEvent('chatMessage', -1, ""..getjobstring,  { 255, 255, 255 }, message)
		else
			TriggerClientEvent('chatMessage', -1, ""..getjobstring..""..namee.."",  { 255, 255, 255 }, message)
		end

		TriggerClientEvent("esx:showNotification", src, GetPlayerName(targetSrc) .. " تم سجنك " .. jailTime .. " دقيقة")
	else
		local Resooonnn = "لقد تم حظرك من المدينة لمحاولة إستخدام ثغرات برمجية .. أحفظ آخر 10 دقائق وتوجه الدعم الفني"
		TriggerEvent('EasyAdmin:banPlayer', _source, Resooonnn, 10444633200)
	end
end)

-- RegisterNetEvent("esx-qalle-jail:jailPlayer2")
-- AddEventHandler("esx-qalle-jail:jailPlayer2", function(token)
-- 	local _source = source
-- 	-- if not exports['esx_misc3']:secureServerEvent(GetCurrentResourceName(), _source, token) then
--     --     return false
--     -- end
-- 	local src = source
-- 	JailPlayer(src, 5)
-- end)

RegisterNetEvent("esx-qalle-jail:unJailPlayer")
AddEventHandler("esx-qalle-jail:unJailPlayer", function(targetIdentifier, token)
	local src = source
	local xPlayer = ESX.GetPlayerFromIdentifier(targetIdentifier)
	local xPlayer2 = ESX.GetPlayerFromId(src)

	if xPlayer2.job.name == 'police' or xPlayer2.job.name == 'agent' or xPlayer2.job.name == 'admin' then
		if xPlayer ~= nil then
			UnJail(xPlayer.source)
		else
			MySQL.Async.execute(
				"UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
				{
					['@identifier'] = targetIdentifier,
					['@newJailTime'] = 0
				}
			)
		end

		MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier',
			{
				['@identifier'] = targetIdentifier,
			},
			function(data)
				if data[1] then
					TriggerClientEvent("esx:showNotification", src, " تم الإفراج عن " .. data[1].firstname ..' '.. data[1].lastname)
				end
			end)
	else
		local Resooonnn = "لقد تم حظرك من المدينة لمحاولة إستخدام ثغرات برمجية .. أحفظ آخر 10 دقائق وتوجه الدعم الفني"
		TriggerEvent('EasyAdmin:banPlayer', src, Resooonnn, 10444633200)
	end
end)

RegisterNetEvent("esx-qalle-jail:updateJailTime")
AddEventHandler("esx-qalle-jail:updateJailTime", function(newJailTime, token)
	local _source = source
	-- if not exports['esx_misc3']:secureServerEvent(GetCurrentResourceName(), _source, token) then
    --     return false
    -- end
	local src = source

	EditJailTime(src, newJailTime)
end)

function JailPlayer(jailPlayer, jailTime)
	TriggerClientEvent("esx-qalle-jail:jailPlayer", jailPlayer, jailTime)

	EditJailTime(jailPlayer, jailTime)
end

function UnJail(jailPlayer)
	TriggerClientEvent("esx-qalle-jail:unJailPlayer", jailPlayer)

	EditJailTime(jailPlayer, 0)
end

function EditJailTime(source, jailTime)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier

	MySQL.Async.execute(
       "UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
        {
			['@identifier'] = Identifier,
			['@newJailTime'] = tonumber(jailTime)
		}
	)
end

function GetRPName(playerId, data)
	local Identifier = ESX.GetPlayerFromId(playerId).identifier

	MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		data(result[1].firstname, result[1].lastname)

	end)
end

ESX.RegisterServerCallback("esx-qalle-jail:retrieveJailedPlayers", function(source, cb)
	
	local jailedPersons = {}

	MySQL.Async.fetchAll("SELECT firstname, lastname, jail, identifier FROM users WHERE jail > @jail", { ["@jail"] = 0 }, function(result)

		for i = 1, #result, 1 do
			table.insert(jailedPersons, { name = result[i].firstname .. " " .. result[i].lastname, jailTime = result[i].jail, identifier = result[i].identifier })
		end

		cb(jailedPersons)
	end)
end)

ESX.RegisterServerCallback("esx-qalle-jail:retrieveJailTime", function(source, cb)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier


	MySQL.Async.fetchAll("SELECT jail FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		local JailTime = tonumber(result[1].jail)

		if JailTime > 0 then

			cb(true, JailTime)
		else
			cb(false, 0)
		end

	end)
end)