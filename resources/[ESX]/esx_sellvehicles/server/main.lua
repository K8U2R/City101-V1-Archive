ESX = nil
local categories, vehicles = {}, {}
local Categories2 = {}
local Vehicles2   = {}
local VehiclesJobs = {}

TriggerEvent('esx:getSharedObject', function(obj) 
	ESX = obj 
end)

function sendToDiscord (name,message,color)
	local DiscordWebHook = "https://discord.com/api/webhooks/1219053887793795135/EOKbW2Psjw58BG3CchvO1iBMfRautimeMP-tj8Q7ooY7baNNTWtqlULCMkTOpwrKfg4G"
	-- Modify here your discordWebHook username = name, content = message,embeds = embeds
  
  local embeds = {
	  {
		  ["title"]=message,
		  ["type"]="rich",
		  ["color"] =color,
		  ["footer"]=  {
			  ["text"]= "المعارض المستعملة",
		 },
	  }
  }
  
if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

ESX.RegisterServerCallback("esx-qalle-sellvehicles:retrieveVehicles", function(source, cb)
	local src = source
	local identifier = ESX.GetPlayerFromId(src)["identifier"]

    MySQL.Async.fetchAll("SELECT seller, vehicleProps, price FROM vehicles_for_sale", {}, function(result)
        local vehicleTable = {}
	
        VehiclesForSale = 0

        if result[1] ~= nil then
            for i = 1, #result, 1 do
                VehiclesForSale = VehiclesForSale + 1

				local seller = false

				if result[i]["seller"] == identifier then
					seller = true
				end

                table.insert(vehicleTable, { ["price"] = result[i]["price"], ["vehProps"] = json.decode(result[i]["vehicleProps"]), ["owner"] = seller })
				
            end
    end
        cb(vehicleTable)
    end)
end)

RegisterServerEvent('esx_sellvehicles:getPlate')
AddEventHandler('esx_sellvehicles:getPlate', function(source, cb, vehicleProps)
	local plate = vehicleProps["plate"]
	cb(plate)
end)

ESX.RegisterServerCallback('esx_sellvehicles:getInfoCar', function(source, cb, vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(source)
	local plate = vehicleProps["plate"]
	local last_name_car = nil
	MySQL.Async.fetchAll('SELECT plate, name FROM owned_vehicles WHERE owner = @owner',
	{
		['@owner'] = xPlayer.identifier
	}, function(result)
		if result ~= nil and #result > 0 then
			for _,v in pairs(result) do
				if v.plate == plate then
					last_name_car = v.name
				end
			end
			cb(last_name_car)
		end
	end)
end)

ESX.RegisterServerCallback("esx-qalle-sellvehicles:isVehicleValid", function(source, cb, vehicleProps, price)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    local plate = vehicleProps["plate"]

	local isFound = false

	if xPlayer then

		RetrievePlayerVehicles(xPlayer.identifier, function(ownedVehicles)

			for id, v in pairs(ownedVehicles) do

				if Trim(plate) == Trim(v.plate) and #Config.VehiclePositions ~= VehiclesForSale then
					
					local resultTwo = MySQL.Sync.fetchAll('SELECT name, modelname FROM owned_vehicles WHERE plate = @plate', {

						['@plate'] = plate

					})

					MySQL.Async.execute("INSERT INTO vehicles_for_sale (seller, vehicleProps, price) VALUES (@sellerIdentifier, @vehProps, @vehPrice)",
						{
							["@sellerIdentifier"] = xPlayer["identifier"],
							["@vehProps"] = json.encode(vehicleProps),
							["@vehPrice"] = price
						}
					)

					MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', { ["@plate"] = plate})

					TriggerClientEvent("esx-qalle-sellvehicles:refreshVehicles", -1)

					isFound = true

					sendToDiscord((' المعارض السيارات المستعملة '), 'وضع مركبة للبيع في معرض المستعمل', 'الهوية: `'..xPlayer.getName()..'`\n identifier: `'..xPlayer["identifier"]..'`\nالسعر: `'..price..'`\nالوحة واسم المركبة: `'..plate..'` `'..resultTwo[1].name..'`\nكود المركبة: `'..resultTwo[1].modelname..'`',56108)

					TriggerClientEvent('chatMessage', -1, " إدارة المعارض المستعملة 🏪 " ,  { 178, 102, 255 } ,  " عرض مركبة ^3 " ..xPlayer.getName().." ^0|" .." المركبة: ^3"..plate.."^0 معرض مستعمل سيارات".." ^0| بسعر: ^2"..price.."$")
					
					break

				end		

			end

			cb(isFound, plate)

		end)

	end
end)

ESX.RegisterServerCallback("esx-qalle-sellvehicles:buyVehicle", function(source, cb, vehProps, price)
	local src = source
	local iden_player = nil
	local xPlayer = ESX.GetPlayerFromId(src)
	local price = price
	local plate = vehProps["plate"]
	if xPlayer then
		if xPlayer.getAccount("bank")["money"] >= price or price == 0 then
			xPlayer.removeAccountMoney('bank', price)
			MySQL.Async.execute("INSERT INTO owned_vehicles (plate, owner, vehicle, stored) VALUES (@plate, @identifier, @vehProps, @stored)",
				{
					["@plate"] = plate,
					["@identifier"] = xPlayer["identifier"],
					["@vehProps"] = json.encode(vehProps),
					["@stored"] = 1
				}
			)

			TriggerClientEvent("esx-qalle-sellvehicles:refreshVehicles", -1)

			MySQL.Async.fetchAll('SELECT seller FROM vehicles_for_sale WHERE vehicleProps LIKE "%' .. plate .. '%"', {}, function(result)
				if result[1] ~= nil and result[1]["seller"] ~= nil then
					iden_player = result[1]["seller"]
					UpdateCash(result[1]["seller"], price, plate)
					MySQL.Async.execute('DELETE FROM vehicles_for_sale WHERE vehicleProps LIKE "%' .. plate .. '%"', {})
					cb({status = true, iden_player_is = result[1]["seller"]})
					sendToDiscord((' المعارض المستعملة '), GetPlayerName(source) .. " Bought The Vehicle ".. plate .. " For ".. price.."$",56108)	
				else
					--print("Something went wrong, there was no car.")
				end
			end)
		else
			cb({status = false, money = xPlayer.getAccount("bank")["money"]})
		end
	end
end)

function RetrievePlayerVehicles(newIdentifier, cb)
	local identifier = newIdentifier

	local yourVehicles = {}

	MySQL.Async.fetchAll("SELECT vehicle, plate FROM owned_vehicles WHERE owner = @identifier", {['@identifier'] = identifier}, function(result) 

		for id, values in pairs(result) do

			local vehicle = json.decode(values.vehicle)
			local plate = values.plate
		

			table.insert(yourVehicles, { vehicle = vehicle, plate = plate })
		end

		cb(yourVehicles)

	end)
end

function UpdateCash(identifier, cash, plate)
	local xPlayer = ESX.GetPlayerFromIdentifier(identifier)

	if xPlayer ~= nil then
		xPlayer.addAccountMoney("bank", cash)
		TriggerClientEvent('chatMessage', -1, " إدارة المعارض المستعملة 🏪 " ,  { 178, 102, 255 } ,  " إيداع مبلغ في رصيد ^3" ..xPlayer.getName().." ^0| السبب : ^3" .." بيع مركبة "..plate.." معرض مستعمل عام".." ^0| المبلغ : ^2"..cash.."$")
		TriggerClientEvent("esx:showNotification", xPlayer.source, "تم شراء مركبتك الموجودة في المعرض المستعمل بسعر :" .. cash)
	else
		MySQL.Async.fetchAll('SELECT firstname, lastname, accounts FROM users WHERE identifier = @identifier', { ["@identifier"] = identifier }, function(result)
			local rpname = result[1].firstname.." "..result[1].lastname
			local accounts = json.decode(result[1].accounts)
			accounts.bank = accounts.bank + cash		
			if accounts["bank"] ~= nil then
			    TriggerClientEvent('chatMessage', -1, " إدارة المعارض المستعملة 🏪 " ,  { 178, 102, 255 } ,  " إيداع مبلغ في رصيد ^3" ..rpname.." ^0| السبب : ^3" .." بيع مركبة "..plate.." معرض مستعمل عام".." ^0| المبلغ : ^2"..cash.."$")
				MySQL.Async.execute("UPDATE users SET accounts = @newBank WHERE identifier = @identifier",
					{
						["@identifier"] = identifier,
						["@newBank"] = json.encode(accounts)
					}
				)
			end
		end)
	end
end

Trim = function(word)
	if word ~= nil then
		return word:match("^%s*(.-)%s*$")
	else
		return nil
	end
end