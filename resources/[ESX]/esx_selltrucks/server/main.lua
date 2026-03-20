ESX = nil

TriggerEvent("esx:getSharedObject", function(response)
    ESX = response
end)

local TrucksForSale = 0

--Send the message to your discord server
function sendToDiscord (name,message,color)
  local DiscordWebHook = Config.WebhookTrucks
  -- Modify here your discordWebHook username = name, content = message,embeds = embeds

local embeds = {
    {
        ["title"]=message,
        ["type"]="rich",
        ["color"] =color,
        ["footer"]=  {
            ["text"]= "معارض الشاحنات",
       },
    }
}

  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

ESX.RegisterServerCallback("esx-qalle-selltrucks:retrieveVehicles", function(source, cb)
	local src = source
	local identifier = ESX.GetPlayerFromId(src)["identifier"]

    MySQL.Async.fetchAll("SELECT seller, vehicleProps, price, info, name, priceold, levelold, category, modelname FROM trucks_for_sale", {}, function(result)
        local vehicleTable = {}

        TrucksForSale = 0

        if result[1] ~= nil then
            for i = 1, #result, 1 do
                TrucksForSale = TrucksForSale + 1

				local seller = false

				if result[i]["seller"] == identifier then
					seller = true
				end

                table.insert(vehicleTable, { ["price"] = result[i]["price"], ["info"] = result[i]["info"], ["vehProps"] = json.decode(result[i]["vehicleProps"]), ["owner"] = seller, ["priceold"] = result[i]["priceold"], ["levelold"] = result[i]["levelold"] , ["name"] = result[i]["name"] })
            end
        end

        cb(vehicleTable)
    end)
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

ESX.RegisterServerCallback("esx-qalle-selltrucks:isVehicleValid", function(source, cb, vehicleProps, price, info)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    
    local plate = vehicleProps["plate"]

	local isFound = false

	RetrievePlayerVehicles(xPlayer.identifier, function(ownedVehicles)

		for id, v in pairs(ownedVehicles) do

			if Trim(plate) == Trim(v.plate) and #Config.VehiclePositions ~= TrucksForSale then
  
                local resultTwo = MySQL.Sync.fetchAll('SELECT name, category, modelname FROM owned_vehicles WHERE plate = @plate', {
					['@plate'] = plate
		        })

                MySQL.Async.execute("INSERT INTO trucks_for_sale (seller, vehicleProps, price, info, name, category, modelname) VALUES (@sellerIdentifier, @vehProps, @vehPrice, @vehInfo, @vehName, @vehCategory , @vehModelname)",
                    {
						["@sellerIdentifier"] = xPlayer["identifier"],
                        ["@vehProps"] = json.encode(vehicleProps),
                        ["@vehPrice"] = price,
						["@vehInfo"] = info,
						["@vehName"] = resultTwo[1].name,
						["@vehCategory"] = resultTwo[1].category,
						["@vehModelname"] = resultTwo[1].modelname
                    }
                )

				MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', { ["@plate"] = plate})
				
                TriggerClientEvent("esx-qalle-selltrucks:refreshVehicles", -1)	

				isFound = true

				sendToDiscord((' معارض الشاحنات '), GetPlayerName(source) .. " Put The Vehicle  ".. plate .. " For Sale For ".. price.."$",56108)					

				TriggerClientEvent('chatMessage', -1, " إدارة المعارض المستعملة 🏪 " ,  { 178, 102, 255 } ,  " عرض شاحنة ^3 " ..xPlayer.getName().." ^0|" .." الشاحنة: ^3"..plate.."^0 معرض مستعمل شاحنات".." ^0| بسعر: ^2"..price.."$")

			end		

		end

		cb(isFound)

	end)
end)

ESX.RegisterServerCallback("esx-qalle-selltrucks:buyVehicle", function(source, cb, vehProps, price)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src) 
	local price = price
	local plate = vehProps["plate"]
	local money = xPlayer.getAccount()

	MySQL.Async.fetchAll('SELECT * FROM trucks_for_sale WHERE vehicleProps LIKE "%' .. plate .. '%"', {}, function(result)
		if result[1] ~= nil then
			if price == result[1].price or result[1].seller == xPlayer.identifier then
				if xPlayer.getAccount("bank")["money"] >= price or price == 0 then
					xPlayer.removeAccountMoney("bank", price)

					MySQL.Async.execute("INSERT INTO owned_vehicles (plate, owner, vehicle, Type, name, category, modelname, stored) VALUES (@plate, @identifier, @vehProps, @Type, @vehName, @vehCategory , @vehModelname, @stored)",
					{
						["@plate"] = plate,
						["@identifier"] = xPlayer.identifier,
						["@vehProps"] = result[1].vehicleProps,
						["@Type"] = "truck",
						["@vehName"] = result[1].name,
						["@vehCategory"] = result[1].category,
						["@vehModelname"] = result[1].modelname,
						['@stored'] = 1
					})

					TriggerClientEvent("esx-qalle-sellvehicles:refreshVehicles", -1)
					UpdateCash(result[1].seller, price, plate)
					MySQL.Async.execute('DELETE FROM trucks_for_sale WHERE vehicleProps LIKE "%' .. plate .. '%"', {})

					cb(true)
					sendToDiscord((' معارض الشاحنات '), GetPlayerName(source) .. " Bought The Vehicle ".. plate .. " For ".. price.."$",56108)	
				else
					cb(false, money)
				end
			else
				DropPlayer(src, "Cheat engine detected") -- Add your anti cheat detection here.
			end
		else
			print("Car not found in sql, possible cheat from : " .. GetPlayerName(src))
		end
	end)
end)

function RetrievePlayerVehicles(newIdentifier, cb)
	local identifier = newIdentifier

	local yourVehicles = {}

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @identifier AND Type = @Type", {['@identifier'] = identifier, ['@Type'] = 'truck'}, function(result) 

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
    	local user = xPlayer.getName()
	    local rpname = user		
		xPlayer.addAccountMoney("bank", cash)
		TriggerClientEvent('chatMessage', -1, " إدارة المعارض المستعملة 🏪 " ,  { 178, 102, 255 } ,  " إيداع مبلغ في رصيد ^3" ..rpname.." ^0| السبب : ^3" .." بيع شاحنة "..plate.." معرض الشاحنات المستعملة".." ^0| المبلغ : ^2"..cash.."$")
	else	 
		MySQL.Async.fetchAll('SELECT firstname, lastname, accounts FROM users WHERE identifier = @identifier', { ["@identifier"] = identifier }, function(result)
		local rpname = result[1].firstname.." "..result[1].lastname
        local accounts = json.decode(result[1].accounts)
		accounts.bank = accounts.bank + cash	
			if accounts["bank"] ~= nil then
			    TriggerClientEvent('chatMessage', -1, " إدارة المعارض المستعملة 🏪 " ,  { 178, 102, 255 } ,  " إيداع مبلغ في رصيد ^3" ..rpname.." ^0| السبب : ^3" .." بيع شاحنة "..plate.." معرض الشاحنات المستعملة".." ^0| المبلغ : ^2"..cash.."$")
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