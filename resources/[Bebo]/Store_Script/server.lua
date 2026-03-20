local DiscordWebhook = 'https://discord.com/api/webhooks/1219052979424985189/51pvfibISgVYulwjOM-1abZ-mubEtvubIVKp4lB3y9wNrv1EvUkGFdRbxVhBc_9cl3-1'
local redeemedCars = {}
local inProgress = false
local ESX = nil
local QBCore = nil
local NumberCharset = {}
local Charset = {}
local plateQuery = ''


for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

local function GetRandomNumber(length)
	return length > 0 and GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)] or ''
end

local function GetRandomLetter(length)
	return length > 0 and GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)] or ''
end

local function GeneratePlate()
	local plate = Config.SpaceInLicensePlate and GetRandomLetter(Config.LicensePlateLetters)..' '..GetRandomNumber(Config.LicensePlateNumbers) or GetRandomLetter(Config.LicensePlateLetters) .. GetRandomNumber(Config.LicensePlateNumbers)
	local result = MySQL.Async.fetchAll(plateQuery, {plate})
	return result and GeneratePlate() or plate:upper()
end

local DISCORD_NAME = "101 City Store"
local DISCORD_IMAGE = "https://probot.media/X3kaJPpSj7.png"

local function SendToDiscord(name, message, color)
	-- if not Config.DiscordLogs then return end

		print("discord log", name, message)
		local connect = {
			{
				["color"] = color,
				["title"] = "**".. name .."**",
				["description"] = message,
				["footer"] = {
					["text"] = "101 City Store",
				},
			}
		}
		PerformHttpRequest(DiscordWebhook, function() end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatarrl = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })

end

if Config.Framework == "ESX" then
	ESX = exports.es_extended:getSharedObject()

	plateQuery = 'SELECT 1 FROM owned_vehicles WHERE plate = ?'

	ESX.RegisterServerCallback('nass_tebexstore:redeemCheck', function(source, cb, model)
		local xPlayer = ESX.GetPlayerFromId(source)
		if redeemedCars[xPlayer.identifier] ~= nil then
			local redeemed = redeemedCars[xPlayer.identifier] == model
			cb(redeemed, redeemed and GeneratePlate() or nil)
		else
			cb(false)
			print('[nass_tebexstore]: A player tried to exploit the vehicle spawn trigger! Identifier: '..xPlayer.identifier)
			SendToDiscord('Attempted Exploit Detected!', '**Identifier: **'..xPlayer.identifier..'\n**Comments:** Player has attempted to trigger the spawn vehicle event without a redemption code.', 3066993)
			xPlayer.kick('Nice try')
		end
	end)
elseif Config.Framework == "QB" then
	QBCore = exports['qb-core']:GetCoreObject()

	plateQuery = 'SELECT 1 FROM player_vehicles WHERE plate = ?'

	QBCore.Functions.CreateCallback('nass_tebexstore:redeemCheck', function(source, cb, model)
		local player = QBCore.Functions.GetPlayer(source)
		if not player then return end
		if redeemedCars[player.PlayerData.citizenid] ~= nil then
			local redeemed = redeemedCars[player.PlayerData.citizenid] == model
			cb(redeemed, redeemed and GeneratePlate() or nil)
		else
			cb(false)
			print('[nass_tebexstore]: A player tried to exploit the vehicle spawn trigger! Identifier: '..player.PlayerData.citizenid)
			SendToDiscord('Attempted Exploit Detected!', '**Identifier: **'..player.PlayerData.citizenid..'\n**Comments:** Player has attempted to trigger the spawn vehicle event without a redemption code.', 3066993)
			QBCore.Functions.Kick(source, 'Nice try')
		end
	end)
else
	TriggerEvent("nass_tebexstore:notify", "nass_tebexstore: Framework in config is not set correctly. ")
end

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		local tebexConvar = GetConvar('sv_tebexSecret', '')
		if tebexConvar == '' then
			error('Tebex Secret Missing please set in server.cfg and try again. The script will not work without it.')
			StopResource(GetCurrentResourceName())
		end
		if not Config.DiscordLogs then
			print('^3Webhooks Disabled^0') -- ^3 is the yellow color code for the console, ^0 is white to reset the color for everything after this message
		end
	end
end)

RegisterCommand('lag2', function(source)
	TriggerClientEvent('lag2', source)
end)

RegisterCommand('redeem', function(source, _, rawCommand)
	if Config.Framework == "ESX" then
		local encode = rawCommand:sub(8)
		local xPlayer = ESX.GetPlayerFromId(source)
		local xName = xPlayer.getName()
		local user = getname(source)
    	local rpname = user
		MySQL.Async.fetchAll('SELECT * FROM codes WHERE code = @playerCode', {['@playerCode'] = encode}, function(result)
			if result[1] then
				local packs = json.decode(result[1].packagename)
				for _, i in pairs (packs) do
					local packagename = i
					local showMsg = true
					for _, v in pairs (Config.Packages) do
						if v.PackageName == i then
							for j = 1, #v.Items, 1 do
								local counter = v.Items[j]
								print(counter.type, counter.name)
								if counter.type == 'item' then
									xPlayer.addInventoryItem(counter.name, counter.amount)
								elseif counter.type == 'weapon' then
									xPlayer.addWeapon(counter.name, counter.amount)
								elseif counter.type == 'moneybag' then
									xPlayer.addAccountMoney('bank', counter.amount)
									TriggerClientEvent('chatMessage', -1, "📦 متجر مدينة 101 أونلاين " ,  { 202, 202, 202 } ,  " تم تسليم المواطن ^3" ..rpname.." ^0| الباقة : ^3" ..' ' .. counter.des)
									TriggerClientEvent("esx_misc:controlSystemScaleform_store12", xPlayer.source, xp)
								elseif counter.type == 'account' then
									xPlayer.addAccountMoney(counter.name, counter.amount)
									if counter.xp then
										TriggerEvent('SvStore_xplevel:updateCurrentPlayerXP', source, 'add', counter.xp, counter.des)
									end
									TriggerClientEvent('chatMessage', -1, "📦 متجر مدينة 101 أونلاين " ,  { 202, 202, 202 } ,  " تم تسليم المواطن ^3" ..xName.." ^0| الباقة : ^3" .. ' ' .. counter.des)
									TriggerClientEvent("esx_misc:controlSystemScaleform_store12", xPlayer.source, xp)
								elseif counter.type == 'car' or counter.type == "truck" then
									xPlayer.addAccountMoney('bank', counter.money)
									redeemedCars[xPlayer.identifier] = counter.model
									TriggerClientEvent('nass_tebexstore:spawnveh', source, counter.model, counter.type, counter.job, counter.name, counter.priceold)
								elseif counter.type == 'gas_station' then
									TriggerClientEvent('chatMessage', -1, "📦 متجر مدينة 101 أونلاين " ,  { 202, 202, 202 } ,  " تم تسليم المواطن ^3" ..xName.." ^0| الباقة : ^3" .. counter.name)
									TriggerClientEvent("esx_misc:controlSystemScaleform_store12", xPlayer.source, xp)
									TriggerClientEvent('buyMarket:client', source, counter.stationname)
								end

								Wait(100)
							end

							TriggerClientEvent('nass_tebexstore:notify', source, "لقد نجحت في استرداد رمز لـ:" .. encode)
							SendToDiscord('Code Redeemed : ' ..encode, '**Package Name: **'..packagename..'\n**Character Name: **'..xName..'\n**Identifier: **'..xPlayer.identifier, 3066993)
							showMsg = false
						end
					end
					if showMsg then
						TriggerClientEvent('nass_tebexstore:notify', source, "The "..packagename.." package is not configured by the server owner. Please contact the admin team.")
					end
				end
				MySQL.Async.execute('DELETE FROM codes WHERE code = @playerCode', {['@playerCode'] = encode})
			else
				TriggerClientEvent('nass_tebexstore:notify', source, "الرمز غير صالح حاليًا ، إذا كنت قد اشتريت للتو ، فيرجى تجربة هذا الرمز مرة أخرى في غضون بضع دقائق")
			end
		end)
	elseif Config.Framework == "QB" then
		local encode = rawCommand:sub(8)
		local player = QBCore.Functions.GetPlayer(source)
		if player then
			MySQL.query('SELECT * FROM codes WHERE code = @playerCode', {['@playerCode'] = encode}, function(result)
				if result[1] then
					local packs = json.decode(result[1].packagename)
					for _, i in pairs (packs) do
						local packagename = i
						local showMsg = true
						for _, v in pairs (Config.Packages) do
							if v.PackageName == i then
								for j=1, #v.Items, 1 do
									local counter = v.Items[j]
									if counter.type == 'item' or counter.type == 'weapon' then
										player.Functions.AddItem(counter.name, counter.amount)
									elseif counter.type == 'account' then
										player.Functions.AddMoney(counter.name, counter.amount, "server-donation")
									elseif counter.type == 'car' then
										redeemedCars[player.PlayerData.citizenid] = counter.model
										TriggerClientEvent('nass_tebexstore:spawnveh', source, counter.model)
									end

									Wait(100)
								end

								TriggerClientEvent('nass_tebexstore:notify', source, "You have successfully redeemed a code for: " .. encode)
								SendToDiscord('Code Redeemed', '**Package Name: **'..packagename..'\n**Character Name: **'..player.PlayerData.firstname..' '..player.PlayerData.lastname..'\n**Identifier: **'..player.PlayerData.citizenid, 3066993)
								showMsg = false
							end
						end
						if showMsg then
							TriggerClientEvent('nass_tebexstore:notify', source, "The "..packagename.." package is not configured by the server owner. Please contact the admin team to fix this.")
						end
					end
					MySQL.query.await('DELETE FROM codes WHERE code = @playerCode', {['@playerCode'] = encode})
				else
					TriggerClientEvent('nass_tebexstore:notify', source, "Code is currently invalid, if you have just purchased please try this code again in a few minutes")
				end
			end)
		end
	end
end, false)

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

RegisterCommand('+2', function()
	-- for _, playerId in ipairs(GetPlayers()) do
	-- 	local ids = ExtractIdentifiers(playerId)
	-- 	local _FivemID = ids.fivem
	-- 	if _FivemID then
	-- 		print(_FivemID)
	-- 		local encode = '123'
	-- 		local xPlayer = ESX.GetPlayerFromId(playerId)
	-- 		local xName = xPlayer.getName()
	-- 		print(xName)
	-- 		local user = getname(playerId)
	-- 		local rpname = user
	-- 		print(rpname)
	-- 		MySQL.Async.fetchAll('SELECT * FROM codes WHERE code = @playerCode', {['@playerCode'] = encode}, function(result)
	-- 			if result[1] then
	-- 				local packs = json.decode(result[1].packagename)
	-- 				for _, i in pairs (packs) do
	-- 					local packagename = i
	-- 					local showMsg = true
	-- 					for _, v in pairs (Config.Packages) do
	-- 						if v.PackageName == i then
	-- 							for j = 1, #v.Items, 1 do
	-- 								local counter = v.Items[j]
	-- 								print(counter.type, counter.name)
	-- 								if counter.type == 'item' then
	-- 									xPlayer.addInventoryItem(counter.name, counter.amount)
	-- 								elseif counter.type == 'weapon' then
	-- 									xPlayer.addWeapon(counter.name, counter.amount)
	-- 								elseif counter.type == 'account' then
	-- 									xPlayer.addAccountMoney(counter.name, counter.amount)
	-- 									if counter.xp then
	-- 										TriggerEvent('SvStore_xplevel:updateCurrentPlayerXP', playerId, 'add', counter.xp, counter.des)
	-- 									end
	-- 									TriggerClientEvent('chatMessage', -1, "📦 متجر مدينة 101 أونلاين " ,  { 202, 202, 202 } ,  " تم تسليم المواطن ^3" ..rpname.." ^0| الباقة : ^3" .. counter.amount .. '$ + ' .. counter.xp .. ' 🌐 +' .. counter.des)
	-- 								elseif counter.type == 'car' or counter.type == "truck" then
	-- 									redeemedCars[xPlayer.identifier] = counter.model
	-- 									TriggerClientEvent('nass_tebexstore:spawnveh', playerId, counter.model, counter.type, counter.job, counter.name, counter.priceold)
	-- 								elseif counter.type == 'gas_station' then
	-- 									TriggerClientEvent('chatMessage', -1, "📦 متجر مدينة 101 أونلاين " ,  { 202, 202, 202 } ,  " تم تسليم المواطن ^3" ..rpname.." ^0| الباقة : ^3" .. counter.name)
	-- 									TriggerClientEvent('buyMarket:client', playerId, counter.stationname)
	-- 								end

	-- 								Wait(100)
	-- 							end

	-- 							TriggerClientEvent('nass_tebexstore:notify', playerId, "لقد نجحت في استرداد رمز لـ:" .. encode)
	-- 							SendToDiscord('Code Redeemed : ' ..encode, '**Package Name: **'..packagename..'\n**Character Name: **'..rpname..'\n**Identifier: **'..xPlayer.identifier, 3066993)
	-- 							showMsg = false
	-- 						end
	-- 					end
	-- 					if showMsg then
	-- 						TriggerClientEvent('nass_tebexstore:notify', playerId, "The "..packagename.." package is not configured by the server owner. Please contact the admin team.")
	-- 					end
	-- 				end
	-- 				-- MySQL.Async.execute('DELETE FROM codes WHERE code = @playerCode', {['@playerCode'] = encode})
	-- 			else
	-- 				TriggerClientEvent('nass_tebexstore:notify', playerId, "الرمز غير صالح حاليًا ، إذا كنت قد اشتريت للتو ، فيرجى تجربة هذا الرمز مرة أخرى في غضون بضع دقائق")
	-- 			end
	-- 		end)
	-- 	else
	-- 		print('no fivem id')
	-- 	end
	-- end
end)

RegisterCommand('purchase_package_tebex', function(source, args)
	-- if source == 0 then
		local dec = json.decode(args[1])
		local tbxid = dec.transid
		local fivemid = dec.fivemid
		local packTab = {}
		print('fivem id ', fivemid)
		while inProgress do
			Wait(1000)
		end
		inProgress = true
		-- MySQL.query('SELECT * FROM codes WHERE code = @playerCode', {['@playerCode'] = tbxid}, function(result)
		MySQL.Async.fetchAll('SELECT * FROM codes WHERE code = @playerCode', {
				["@playerCode"] = tbxid
			}, function (result)
			if result[1] then
				local packagetable = json.decode(result[1].packagename)
				packagetable[#packagetable+1] = dec.packagename
				MySQL.update('UPDATE codes SET packagename = ? WHERE code = ?', {json.encode(packagetable), tbxid}, function(rowsChanged)
					if rowsChanged > 0 then
						SendToDiscord('Purchase', '`'..dec.packagename..'` was just purchased and inserted into the database under redeem code: `'..tbxid..'`.', 1752220)
					else
						SendToDiscord('Error', '`'..tbxid..'` was not inserted into database. Please check for errors!', 15158332)
					end
				end)
			else
				packTab[#packTab+1] = dec.packagename
				-- MySQL.Async.execute("INSERT INTO codes (code, packagename) VALUES (?, ?)", {tbxid, json.encode(packTab)}, function(rowsChanged)
				-- 	SendToDiscord('Purchase', '`'..dec.packagename..'` was just purchased and inserted into the database under redeem code: `'..tbxid..'`.', 1752220)
				-- 	print('^2Purchase '..tbxid..' was succesfully inserted into the database.^0')
				-- end)
				MySQL.Async.execute("INSERT INTO codes (code, packagename) VALUES (?, ?)", {tbxid, json.encode(packTab)}, function(rowsChanged)
					SendToDiscord('Purchase', '`'..dec.packagename..'` was just purchased and inserted into the database under redeem code: `'..tbxid..'`.', 1752220)
					print('^2Purchase '..tbxid..' was succesfully inserted into the database.^0')
						Wait(2000)
						print(fivemid)
						if fivemid then
							for _, playerId in ipairs(GetPlayers()) do
								local ids = ExtractIdentifiers(playerId)
								local _FivemID = ids.fivem
								if playerId == fivemid then
									local encode = tbxid
									local xPlayer = ESX.GetPlayerFromId(playerId)
									local xName = xPlayer.getName()
									local user = getname(playerId)
									local rpname = user
									MySQL.Async.fetchAll('SELECT * FROM codes WHERE code = @playerCode', {['@playerCode'] = encode}, function(result)
										if result[1] then
											local packs = json.decode(result[1].packagename)
											for _, i in pairs (packs) do
												local packagename = i
												local showMsg = true
												for _, v in pairs (Config.Packages) do
													if v.PackageName == i then
														for j = 1, #v.Items, 1 do
															local counter = v.Items[j]
															print(counter.type, counter.name)
															if counter.type == 'item' then
																xPlayer.addInventoryItem(counter.name, counter.amount)
															elseif counter.type == 'weapon' then
																xPlayer.addWeapon(counter.name, counter.amount)
															elseif counter.type == 'moneybag' then
																xPlayer.addAccountMoney('bank', counter.amount)
																TriggerClientEvent('chatMessage', -1, "📦 متجر مدينة 101 أونلاين " ,  { 202, 202, 202 } ,  " تم تسليم المواطن ^3" ..rpname.." ^0| الباقة : ^3" ..' ' .. counter.des)
															elseif counter.type == 'account' then
																xPlayer.addAccountMoney(counter.name, counter.amount)
																if counter.xp then
																	TriggerEvent('SvStore_xplevel:updateCurrentPlayerXP', playerId, 'add', counter.xp, counter.des)
																end
																TriggerClientEvent('chatMessage', -1, "📦 متجر مدينة 101 أونلاين " ,  { 202, 202, 202 } ,  " تم تسليم المواطن ^3" ..rpname.." ^0| الباقة : ^3" ..' ' .. counter.des)
															elseif counter.type == 'car' or counter.type == "truck" then
																xPlayer.addAccountMoney('bank', counter.money)
																redeemedCars[xPlayer.identifier] = counter.model
																TriggerClientEvent('nass_tebexstore:spawnveh', playerId, counter.model, counter.type, counter.job, counter.name, counter.priceold)
															elseif counter.type == 'gas_station' then
																TriggerClientEvent('chatMessage', -1, "📦 متجر مدينة 101 أونلاين " ,  { 202, 202, 202 } ,  " تم تسليم المواطن ^3" ..rpname.." ^0| الباقة : ^3" .. counter.name)
																TriggerClientEvent('buyMarket:client', playerId, counter.stationname)
															end
						
															Wait(100)
														end
						
														TriggerClientEvent('nass_tebexstore:notify', playerId, "لقد نجحت في استرداد رمز لـ:" .. encode)
														SendToDiscord('Code Redeemed : ' ..encode, '**Package Name: **'..packagename..'\n**Character Name: **'..rpname..'\n**Identifier: **'..xPlayer.identifier, 3066993)
														showMsg = false
													end
												end
												if showMsg then
													TriggerClientEvent('nass_tebexstore:notify', playerId, "The "..packagename.." package is not configured by the server owner. Please contact the admin team.")
												end
											end
											MySQL.Async.execute('DELETE FROM codes WHERE code = @playerCode', {['@playerCode'] = encode})
										else
											TriggerClientEvent('nass_tebexstore:notify', playerId, "الرمز غير صالح حاليًا ، إذا كنت قد اشتريت للتو ، فيرجى تجربة هذا الرمز مرة أخرى في غضون بضع دقائق")
										end
									end)
								-- else
								-- 	print('no fivem id')
								end
							end						  
						end
				end)
			end
			inProgress = false
		end)
	-- else
		-- print(GetPlayerName(source)..' tried to give themself a donation code.')
		-- SendToDiscord('Attempted Exploit', GetPlayerName(source)..' tried to give themself a donation code!', 15158332)
	-- end
end, false)

function getname(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	  local result  = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
		  ['@identifier'] = GetPlayerIdentifiers(source)[1]
	  })
  
	  if result[1] and result[1].firstname and result[1].lastname then
		  return ('%s %s'):format(result[1].firstname, result[1].lastname)
	  else
		  return GetPlayerName(source)
	  end
  end

Citizen.CreateThread(function()
	while true do
		Wait(5)
		command = "^1 store/"
		TriggerClientEvent('chatMessage', -1, "📦 متجر مدينة 101 أونلاين " ,  { 202, 202, 202 } ,  "لاتتردد في القاء نظرة على متجرنا متجر مدينة 101 عبر كتابة" .. command)
		Wait(30 * 60 * 1000)
	end
end)

RegisterCommand('store', function(source)
	TriggerClientEvent('openstore', source)
end)

RegisterNetEvent('nass_tebexstore:setVehicle', function (vehicleProps, type, job, name, priceold, category)
	local src = source
	local user = getname(source)
    local rpname = user
	if Config.Framework == "ESX" then
		local xPlayer = ESX.GetPlayerFromId(src)
		local xName = xPlayer.getName()
		TriggerClientEvent('chatMessage', -1, "📦 متجر مدينة 101 أونلاين " ,  { 202, 202, 202 } ,  " تم تسليم المواطن ^3" ..xName.." ^0| الباقة : ^3" .. name)
		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, job, stored, name, priceold) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
		{
			xPlayer.identifier,
			vehicleProps.plate,
			json.encode(vehicleProps),
			type,
			job,
			true,
			name,
			priceold,
		}, function()
			SendToDiscord('Vehicle Redeemed', GetPlayerName(src)..' redeemed their car!', 15158332)
		end)
	elseif Config.Framework == "QB" then
		local player = QBCore.Functions.GetPlayer(src)
		MySQL.Async.execute('INSERT INTO player_vehicles (citizenid, plate, vehicle, state) VALUES (?, ?, ?, ?)',
		{
			player.PlayerData.citizenid,
			vehicleProps.plate,
			json.encode(vehicleProps),
			1,
		}, function()
			SendToDiscord('Vehicle Redeemed', GetPlayerName(src)..' redeemed their car!', 15158332)
		end)
	end
end)

RegisterNetEvent('nass_tebexstore:carNotExist', function()
	SendToDiscord('Vehicle Error', GetPlayerName(source)..' couldn\'t redeemed their car!', 15158332)
end)
