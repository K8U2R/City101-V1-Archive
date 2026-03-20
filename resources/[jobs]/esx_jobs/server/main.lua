local PlayersWorking = {}
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--Send the message to your discord server
function sendToDiscord (name,message,color)
  local DiscordWebHook = "https://discord.com/api/webhooks/1219067649875644448/yG28DO_QOckQ96fa930L5A-7JHFDmqQUK0z3zaoCUn-UwDcycdFYrmg3dyFQ7FMDV9Fb"
  -- Modify here your discordWebHook username = name, content = message,embeds = embeds

local embeds = {
    {
        ["title"]=message,
        ["type"]="rich",
        ["color"] =color,
        ["footer"]=  { ["text"]= "الوظايف العامة", },
    }
}

  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

local function Work(source, item)

	SetTimeout(item[1].time, function()

		if PlayersWorking[source] == true then

			local xPlayer = ESX.GetPlayerFromId(source)
			if xPlayer == nil then
				return
			end

			for i=1, #item, 1 do
				local itemQtty, requiredItemQtty = 0, 0
				if item[i].name ~= _U('delivery') then
					itemQtty = xPlayer.getInventoryItem(item[i].db_name).count
				end
				if item[1].requires ~= "nothing" then
					requiredItemQtty = xPlayer.getInventoryItem(item[1].requires).count
				end
				if item[i].name ~= _U('delivery') and itemQtty >= item[i].max then	
				TriggerClientEvent('esx:showNotification', source, _U('max_limit', item[i].name))
                PlayersWorking[source] = "no"	
				elseif item[i].requires ~= "nothing" and requiredItemQtty <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough', item[1].requires_name))
				PlayersWorking[source] = false
				else
					if item[i].name ~= _U('delivery') then
						-- Chances to drop the item
						if item[i].drop == 100 and PlayersWorking[source] ~= "no" then
							xPlayer.addInventoryItem(item[i].db_name, item[i].add)
						else
							local chanceToDrop = math.random(100)
							if chanceToDrop <= item[i].drop and PlayersWorking[source] ~= "no" then
								xPlayer.addInventoryItem(item[i].db_name, item[i].add)
							end
						end
					else
					if Config.miner and xPlayer.job.name == 'miner' then 
                        xPlayer.addMoney(item[i].price*2)
					elseif Config.lumberjack and xPlayer.job.name == 'lumberjack' then 
                        xPlayer.addMoney(item[i].price*2)	
					elseif Config.slaughterer and xPlayer.job.name == 'slaughterer' then 
                        xPlayer.addMoney(item[i].price*2)
					elseif Config.tailor and xPlayer.job.name == 'tailor' then 
                        xPlayer.addMoney(item[i].price*2)
					elseif Config.fueler and xPlayer.job.name == 'fueler' then 
                        xPlayer.addMoney(item[i].price*2)
					elseif Config.vegetables and xPlayer.job.name == 'vegetables' then 
                        xPlayer.addMoney(item[i].price*2)
					elseif Config.farmer and xPlayer.job.name == 'farmer' then 
                        xPlayer.addMoney(item[i].price*1.8)
                TriggerClientEvent('pNotify:SendNotification',source, {
					text = "<font size=5><center><b>انت كسبت: <font size=5 color=00EE4F>$<font color=white>" .. item[i].price*1.8,
					type = "alert",
					queue = left,
					timeout = 1000,
					killer = false,
					theme = "gta",
					layout = "centerLeft" 
				})
                Citizen.Wait(500)
                TriggerClientEvent('pNotify:SendNotification',source, {
					text = "<font size=5 color=gray><center><b>نسبة الشركة: <font size=5 color=FFAE00>$<font color=white>" .. item[i].price*0.2,
					type = "alert",
					queue = left,
					timeout = 1000,
					killer = false,
					theme = "gta",
					layout = "centerLeft" 
				})						
					elseif xPlayer.job.name == 'farmer' and Config.double ~= 6 or Config.farmer == 1 then 
                 xPlayer.addMoney(item[i].price*0.9)	
                TriggerClientEvent('pNotify:SendNotification',source, {
					text = "<font size=5><center><b>انت كسبت: <font size=5 color=00EE4F>$<font color=white>" .. item[i].price*0.9,
					type = "alert",
					queue = left,
					timeout = 1000,
					killer = false,
					theme = "gta",
					layout = "centerLeft" 
				})
                Citizen.Wait(500)
                TriggerClientEvent('pNotify:SendNotification',source, {
					text = "<font size=5 color=gray><center><b>نسبة الشركة: <font size=5 color=FFAE00>$<font color=white>" .. item[i].price*0.1,
					type = "alert",
					queue = left,
					timeout = 1000,
					killer = false,
					theme = "gta",
					layout = "centerLeft" 
				})				
					elseif Config.fisherman and xPlayer.job.name == 'fisherman' then 
                        xPlayer.addMoney(item[i].price*2)						
					else
                        xPlayer.addMoney(item[i].price)						
                    end
						--TriggerEvent('esx_xp:addXP', source , item[i].xp)	
						local mejob = xPlayer.job.label
						TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', source, 'add', item[i].xp, ' بيع منتج في وظيفة '..mejob)
						sendToDiscord((' الوظايف '), GetPlayerName(source) .. " باع  ".. item[1].requires .. " مقابل ".. item[i].price.."دولار",56108)
					end
				end
			end

			if item[1].requires ~= "nothing" then
				iTemToRemove = xPlayer.getInventoryItem(item[1].requires).count
			 if PlayersWorking[source] == true then
				if iTemToRemove > 0 then
					  xPlayer.removeInventoryItem(item[1].requires, item[1].remove)	
				end					  
			 end
			end

			Work(source, item)

		end
	end)
end

RegisterServerEvent('esx_jobs:A_start_2KNK2_Work') -- startWork
AddEventHandler('esx_jobs:A_start_2KNK2_Work', function(item, pas)
    if pas == Config.pas then
	if not PlayersWorking[source] then
		PlayersWorking[source] = true
		Work(source, item)
	else
		print(('esx_jobs: %s attempted to exploit the marker!'):format(GetPlayerIdentifiers(source)[1]))
	end
	end
end)

RegisterServerEvent('esx_jobs:stopWork')
AddEventHandler('esx_jobs:stopWork', function()
	PlayersWorking[source] = false
end)

function RemoveOwnedVehicle(plate)
	MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	})
end

local IsHave = false

RegisterNetEvent('esx_jobs:addToData')
AddEventHandler('esx_jobs:addToData', function(plate_car)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.execute("INSERT INTO owned_veh_job (plate, identifier) VALUES (@plate, @identifier)",
	{
		["@plate"] = plate_car,
		['@identifier'] = xPlayer.identifier
	})
end)

RegisterNetEvent('esx_jobs:addToDataBoat')
AddEventHandler('esx_jobs:addToDataBoat', function(plate_car)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.execute("INSERT INTO owned_veh_job (plate, identifier, name_car) VALUES (@plate, @identifier, @name_car)",
	{
		["@plate"] = plate_car,
		['@identifier'] = xPlayer.identifier,
		['@name_car'] = "قارب"
	})
end)

RegisterNetEvent('esx_jobs:delete_plate')
AddEventHandler('esx_jobs:delete_plate', function(plate_car)
	xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.execute('DELETE FROM owned_veh_job WHERE plate = @plate AND identifier = @identifier', {
		['@plate'] = plate_car,
		['@identifier'] = xPlayer.identifier
	})
end)

RegisterServerEvent('esx_jobs:A_K2dRcaution_v63j') -- esx_jobs:caution
AddEventHandler('esx_jobs:A_K2dRcaution_v63j', function(pas, cautionType, cautionAmount, spawnPoint, vehicle, plate)
    if pas == Config.pas then
	local xPlayer = ESX.GetPlayerFromId(source)
	if cautionType == "take" then
		TriggerEvent('esx_addonaccount:getAccount', 'caution', xPlayer.identifier, function(account)
			local dsvdsvsdbvjdsh = nil
		end)

	--	TriggerClientEvent('esx:showNotification', source, _U('bank_deposit_taken', ESX.Math.GroupDigits(cautionAmount)))
                TriggerClientEvent('pNotify:SendNotification',source, {
                    text = _U('bank_deposit_taken'), 
                    type = "info", 
                    timeout = 10000, 
                    layout = "centerLeft"
                })		
		TriggerClientEvent('esx_jobs:spawnJobVehicle', source, spawnPoint, vehicle)
		xPlayer.removeAccountMoney('bank', 2000)
		IsHave = true
	elseif cautionType == "give_back" then

		if cautionAmount > 1 then
			print(('esx_jobs: %s is using cheat engine!'):format(xPlayer.identifier))
			return
		end

		TriggerEvent('esx_addonaccount:getAccount', 'caution', xPlayer.identifier, function(account)
			local caution = account.money
			local toGive = ESX.Math.Round(caution * cautionAmount)
			IsHave = false
			xPlayer.addAccountMoney('bank', 2000)
			RemoveOwnedVehicle(plate)
			account.removeMoney(toGive)
                TriggerClientEvent('pNotify:SendNotification',source, {
                    text = _U('bank_deposit_returned'), 
                    type = "info", 
                    timeout = 10000, 
                    layout = "centerLeft"
                })					
			--TriggerClientEvent('esx:showNotification', source, _U('bank_deposit_returned', ESX.Math.GroupDigits(toGive)))
		end)
	end
	end
end)

function GetCharacterName(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if xPlayer then
		if true then
			return xPlayer.getName()
		end
	else
		return GetPlayerName(source)
	end
end

function doublemoney_miner(name, steamIdentifiers, discordIdentifiers, ingamename, data, source, type)
	if type == "cmd" then
		if data then
			TriggerClientEvent('esx_jobs:setData', source, "miner", true)
			Config.miner  = true
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'miner', true)
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"بدأ ضعف أجر المعادن", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",16705372)
		else
			Config.miner = false
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"إنتهاء ضعف أجر المعادن", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",15158332)
		end
	elseif type == "from_admin" then
		if not Config.miner then
			TriggerClientEvent('esx_jobs:setData', source, "miner", true)
			Config.miner = true
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'miner', true)
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"بدأ ضعف أجر المعادن", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",16705372)
		else
			TriggerClientEvent('esx_jobs:setData', source, "miner", true)
			Config.miner = false
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'miner', false)
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"إنتهاء ضعف أجر المعادن", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",15158332)
		end
	end
end

function doublemoney_slaughterer(name, steamIdentifiers, discordIdentifiers, ingamename, data, source, type)
	if type == "cmd" then
		if data then
			TriggerClientEvent('esx_jobs:setData', source, "slaughterer", true)
			Config.slaughterer = true
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'slaughterer', true)
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"بدأ ضعف أجر الدواجن", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",16705372)
		else
			Config.slaughterer = false
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"إنتهاء ضعف أجر الدواجن", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",15158332)
		end
	elseif type == "from_admin" then
		if not Config.slaughterer then
			TriggerClientEvent('esx_jobs:setData', source, "slaughterer", true)
			Config.slaughterer = true
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'slaughterer', true)
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"بدأ ضعف أجر الدواجن", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",16705372)
		else
			TriggerClientEvent('esx_jobs:setData', source, "slaughterer", true)
			Config.slaughterer = false
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'slaughterer', false)
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"إنتهاء ضعف أجر الدواجن", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",15158332)
		end
	end
end

function doublemoney_lumberjack(name, steamIdentifiers, discordIdentifiers, ingamename, data, source, type)
	if type == "cmd" then
		if data then
			TriggerClientEvent('esx_jobs:setData', source, "lumberjack", true)
			Config.lumberjack = true
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'lumberjack', true)
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"بدأ ضعف أجر الأخشاب", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",16705372)
		else
			Config.lumberjack = false
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"إنتهاء ضعف أجر الأخشاب", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",15158332)
		end
	elseif type == "from_admin" then
		if not Config.lumberjack then
			TriggerClientEvent('esx_jobs:setData', source, "lumberjack", true)
			Config.lumberjack = true
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'lumberjack', true)
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"بدأ ضعف أجر الأخشاب", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",16705372)
		else
			TriggerClientEvent('esx_jobs:setData', source, "lumberjack", true)
			Config.lumberjack = false
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'lumberjack', false)
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"إنتهاء ضعف أجر الأخشاب", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",15158332)
		end
	end
end

function doublemoney_tailor(name, steamIdentifiers, discordIdentifiers, ingamename, data, source, type)
	if type == "cmd" then
		if data then
			TriggerClientEvent('esx_jobs:setData', source, "tailor", true)
			Config.tailor = true
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'tailor', true)
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"بدأ ضعف أجر الأقمشة", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",16705372)
		else
			Config.tailor = false
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"إنتهاء ضعف أجر الأقمشة", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",15158332)
		end
	elseif type == "from_admin" then
		if not Config.tailor then
			TriggerClientEvent('esx_jobs:setData', source, "tailor", true)
			Config.tailor = true
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'tailor', true)
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"بدأ ضعف أجر الأقمشة", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",16705372)
		else
			TriggerClientEvent('esx_jobs:setData', source, "tailor", true)
			Config.tailor = false
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'tailor', false)
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"إنتهاء ضعف أجر الأقمشة", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",15158332)
		end
	end
end

function doublemoney_fueler(name, steamIdentifiers, discordIdentifiers, ingamename, data, source, type)
	if type == "cmd" then
		if data then
			TriggerClientEvent('esx_jobs:setData', source, "fueler", true)
			Config.fueler = true
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'fueler', true)
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"بدأ ضعف أجر النفط و الغاز", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",16705372)
		else
			Config.fueler = false
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"إنتهاء ضعف أجر النفط و الغاز", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",15158332)
		end
	elseif type == "from_admin" then
		if not Config.fueler then
			TriggerClientEvent('esx_jobs:setData', source, "fueler", true)
			Config.fueler = true
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'fueler', true)
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"بدأ ضعف أجر النفط و الغاز", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",16705372)
		else
			TriggerClientEvent('esx_jobs:setData', source, "fueler", true)
			Config.fueler = false
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'fueler', false)
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"إنتهاء ضعف أجر النفط و الغاز", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",15158332)
		end
	end
end

function doublemoney_farmer(name, steamIdentifiers, discordIdentifiers, ingamename, data, source, type)
	if type == "cmd" then
		if data then
			TriggerClientEvent('esx_jobs:setData', source, "farmer", true)
			Config.farmer = true
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'farmer', true)
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"بدأ ضعف أجر المزارع", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",16705372)
		else
			Config.farmer = false
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"إنتهاء ضعف أجر المزارع", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",15158332)
		end
	elseif type == "from_admin" then
		if not Config.farmer then
			TriggerClientEvent('esx_jobs:setData', source, "farmer", true)
			Config.farmer = true
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'farmer', true)
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"بدأ ضعف أجر المزارع", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",16705372)
		else
			TriggerClientEvent('esx_jobs:setData', source, "farmer", true)
			Config.farmer = false
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'farmer', false)
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"إنتهاء ضعف أجر النفط و الغاز", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",15158332)
		end
	end
end

function doublemoney_fisherman(name, steamIdentifiers, discordIdentifiers, ingamename, data, source, type)
	if type == "cmd" then
		if data then
			TriggerClientEvent('esx_jobs:setData', source, "fisherman", true)
			Config.fisherman = true
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'fisherman', true)
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"بدأ ضعف أجر الأسماك", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",16705372)
		else
			Config.fisherman = false
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"إنتهاء ضعف أجر الاسماك", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",15158332)
		end
	elseif type == "from_admin" then
		if not Config.fisherman then
			TriggerClientEvent('esx_jobs:setData', source, "fisherman", true)
			Config.fisherman = true
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'fisherman', true)
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"بدأ ضعف أجر الأسماك", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",16705372)
		else
			TriggerClientEvent('esx_jobs:setData', source, "fisherman", true)
			Config.fisherman = false
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'fisherman', false)
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"إنتهاء ضعف أجر الاسماك", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",15158332)
		end
	end
end
function doublemoney_all(name, steamIdentifiers, discordIdentifiers, ingamename, data, source, type)
	if type == "cmd" then
		if data then
			TriggerClientEvent('esx_jobs:setData', source, "all", true)
			Config.all = true
			Config.vegetables = true
			Config.fueler = true
			Config.fisherman = true
			Config.tailor = true
			Config.lumberjack = true
			Config.slaughterer = true
			Config.farmer = true
			Config.miner  = true
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'all', true)
		else
			Config.all = false
			Config.fisherman = false
			Config.vegetables = false
			Config.fueler = false
			Config.farmer = false
			Config.slaughterer = false
			Config.lumberjack = false
			Config.tailor = false
			Config.miner = false
		end
	elseif type == "from_admin" then
		if not Config.all then
			TriggerClientEvent('esx_jobs:setData', source, "all", true)
			Config.all = true
			Config.fueler = true
			Config.vegetables = true
			Config.tailor = true
			Config.lumberjack = true
			Config.slaughterer = true
			Config.fisherman = true
			Config.miner  = true
			Config.farmer = true
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'all', true)
		else
			TriggerClientEvent('esx_jobs:setData', source, "all", true)
			Config.all = false
			Config.vegetables = false
			Config.fisherman = false
			Config.fueler = false
			Config.slaughterer = false
			Config.lumberjack = false
			Config.farmer = false
			Config.miner = false
			Config.tailor = false
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'all', false)
		end
	end
end
function doublemoney_vegetables(name, steamIdentifiers, discordIdentifiers, ingamename, data, source, type)
	if type == "cmd" then
		if data then
			TriggerClientEvent('esx_jobs:setData', source, "vegetables", true)
			Config.vegetables = true
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'vegetables', true)
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"بدأ ضعف أجر شركة الخضروات", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",16705372)
		else
			Config.vegetables = false
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"إنتهاء ضعف أجر شركة الخضروات", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",15158332)
		end
	elseif type == "from_admin" then
		if not Config.vegetables then
			TriggerClientEvent('esx_jobs:setData', source, "vegetables", true)
			Config.vegetables = true
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'vegetables', true)
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"بدأ ضعف أجر شركة الخضروات", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",16705372)
		else
			TriggerClientEvent('esx_jobs:setData', source, "vegetables", true)
			Config.vegetables = false
			TriggerClientEvent("esx_misc:watermark_promotion", -1, 'vegetables', false)
			TriggerEvent('Mina:dlpayLogadj38', (' ضعف الأجر '),"إنتهاء ضعف أجر شركة الخضروات", "*من قبل المراقب* \n\nSteam: `".. name.."` \n "..steamIdentifiers.." \n "..discordIdentifiers.." \nInGame name: `"..ingamename.."`",15158332)
		end
	end
end

RegisterServerEvent("esx_jobs:togglePromotion_duble") -- ضعف الأجر
AddEventHandler("esx_jobs:togglePromotion_duble", function(job, data, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = GetPlayerName(source)
    local steamIdentifiers = GetPlayerIdentifiers(source)[1]
    local discordIdentifiers = GetPlayerIdentifiers(source)[5]
    local ingamename = xPlayer.getName()
	if xPlayer.job.name == 'admin' and xPlayer.getGroup() == "superadmin" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "aplus" or xPlayer.getGroup() == "a" or xPlayer.getGroup() == "modplus" then
	if job == 'miner' then
		doublemoney_miner(name, steamIdentifiers, discordIdentifiers, ingamename, data, source, type)
	elseif job == 'slaughterer' then
		doublemoney_slaughterer(name, steamIdentifiers, discordIdentifiers, ingamename, data, source, type)
	elseif job == 'lumberjack' then
		doublemoney_lumberjack(name, steamIdentifiers, discordIdentifiers, ingamename, data, source, type)
	elseif job == 'tailor' then
		doublemoney_tailor(name, steamIdentifiers, discordIdentifiers, ingamename, data, source, type)
	elseif job == 'fueler' then
		doublemoney_fueler(name, steamIdentifiers, discordIdentifiers, ingamename, data, source, type)
	elseif job == 'farmer' then
		doublemoney_farmer(name, steamIdentifiers, discordIdentifiers, ingamename, data, source, type)
	elseif job == 'fisherman' then
		doublemoney_fisherman(name, steamIdentifiers, discordIdentifiers, ingamename, data, source, type)
	elseif job == 'all' then
		doublemoney_all(name, steamIdentifiers, discordIdentifiers, ingamename, data, source, type)
	elseif job == 'vegetables' then
		doublemoney_vegetables(name, steamIdentifiers, discordIdentifiers, ingamename, data, source, type)
	end
	else
	print(('esx_jobs: %s attempted to toggle Promotion (not admin!)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_misc:GetCacheJobsW')
AddEventHandler('esx_misc:GetCacheJobsW', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("esx_misc:updatePromotionStatus", source, 'miner', Config.miner)
    TriggerClientEvent("esx_misc:updatePromotionStatus", source, 'slaughterer', Config.slaughterer)
    TriggerClientEvent("esx_misc:updatePromotionStatus", source, 'lumberjack', Config.slaughterer)
    TriggerClientEvent("esx_misc:updatePromotionStatus", source, 'tailor', Config.tailor)
    TriggerClientEvent("esx_misc:updatePromotionStatus", source, 'fueler', Config.fueler)
	TriggerClientEvent("esx_misc:updatePromotionStatus", source, 'all', Config.all)
    TriggerClientEvent("esx_misc:updatePromotionStatus", source, 'farmer', Config.farmer)
    TriggerClientEvent("esx_misc:updatePromotionStatus", source, 'fisherman', Config.fisherman)
    TriggerClientEvent("esx_misc:updatePromotionStatus", source, 'vegetables', Config.vegetables)
end)