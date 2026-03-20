ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--Send the message to your discord server
function sendToDiscord (name,message,color)
  local DiscordWebHook = "https://discord.com/api/webhooks/1219044599574691940/34bNl47kQ-uoSKAc4vAg1KZE73WeHowzbnoBOWv0dqgRWNRaF11gkkl3_Ri7UDubiYAF"
  -- Modify here your discordWebHook username = name, content = message,embeds = embeds

local embeds = {
    {
        ["title"]=message,
        ["type"]="rich",
        ["color"] =color,
        ["footer"]=  {
            ["text"]= "السمك",
       },
    }
}

  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

ESX.RegisterUsableItem('turtlebait', function(source)

	local _source = source
	xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('fishingrod').count > 0 then
		TriggerClientEvent('fishing:setbait', _source, "turtle")
		
		xPlayer.removeInventoryItem('turtlebait', 1)
		TriggerClientEvent('fishing:message', _source, "لقد قمت بإستخدام طعم سلاحف في صنارتك")
	else
		TriggerClientEvent('fishing:message', _source, "لاتملك صنارة صيد أو يجب إستعمالها أولا")
	end
	
end)

ESX.RegisterUsableItem('fishbait', function(source)

	local _source = source
	xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('fishingrod').count > 0 then
		TriggerClientEvent('fishing:setbait', _source, "fish")
		
		xPlayer.removeInventoryItem('fishbait', 1)
		TriggerClientEvent('fishing:message', _source, "لقد قمت بإستخدام طعم سمك في صنارتك")
		
	else
		TriggerClientEvent('fishing:message', _source, "لاتملك صنارة صيد أو يجب إستعمالها أولا")
	end
	
end)

ESX.RegisterUsableItem('turtle', function(source)

	local _source = source
	xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('fishingrod').count > 0 then
		TriggerClientEvent('fishing:setbait', _source, "shark")
		
		xPlayer.removeInventoryItem('turtle', 1)
		TriggerClientEvent('fishing:message', _source, "لقد بإستخدام سلحفاة كطعم لجذب القروش")
	else
		TriggerClientEvent('fishing:message', _source, "لاتملك صنارة صيد أو يجب إستعمالها أولا")
	end
	
end)

ESX.RegisterUsableItem('fishingrod', function(source)

	local _source = source
	TriggerClientEvent('fishing:fishstart', _source)
	
	

end)


				
RegisterNetEvent('fishing:catch')
AddEventHandler('fishing:catch', function(bait)
	
	_source = source
	local weight = 2
	local rnd = math.random(1,100)
	xPlayer = ESX.GetPlayerFromId(_source)
	if bait == "turtle" then
		if rnd >= 78 then
			if rnd >= 98 then
				TriggerClientEvent('fishing:setbait', _source, "none")
				TriggerClientEvent('fishing:message', _source, "السمكة ضخمة قامت بكسر صنارتك")
				TriggerClientEvent('fishing:break', _source)
				xPlayer.removeInventoryItem('fishingrod', 1)
			else
				TriggerClientEvent('fishing:setbait', _source, "none")
				if xPlayer.getInventoryItem('turtle').count > 4 then
					TriggerClientEvent('fishing:message', _source, "لايمكنك حمل أكثر من عدد السلاحف الحالي")
				else
					TriggerClientEvent('fishing:message', _source, "لقد إصطدت سلحفاة")
					xPlayer.addInventoryItem('turtle', 1)
				end
			end
		else
			if rnd >= 75 then
				if xPlayer.getInventoryItem('fish').count > 100 then
					TriggerClientEvent('fishing:message', _source, "لايمكنك حمل أكثر من هذا العدد من السمك")
				else
					weight = math.random(1,4)
					TriggerClientEvent('fishing:message', _source, " إصطدت سمكة وزنها "..weight.." كيلوجرام ")
					xPlayer.addInventoryItem('fish', weight)
				end
				
			else
				if xPlayer.getInventoryItem('fish').count > 100 then
					TriggerClientEvent('fishing:message', _source, "لايمكنك حمل أكثر من هذا العدد من السمك")
				else
					weight = math.random(1,4)
					TriggerClientEvent('fishing:message', _source, " إصطدت سمكة وزنها "..weight.." كيلوجرام ")
					xPlayer.addInventoryItem('fish', weight)
				end
			end
		end
	else
		if bait == "fish" then
			if rnd >= 75 then
				TriggerClientEvent('fishing:setbait', _source, "none")
				if xPlayer.getInventoryItem('fish').count > 100 then
					TriggerClientEvent('fishing:message', _source, "لايمكنك حمل أكثر من هذا العدد من السمك")
				else
					weight = math.random(4,8)
					TriggerClientEvent('fishing:message', _source, " إصطدت سمكة وزنها "..weight.." كيلوجرام ")
					xPlayer.addInventoryItem('fish', weight)
				end
				
			else
				if xPlayer.getInventoryItem('fish').count > 100 then
					TriggerClientEvent('fishing:message', _source, "لايمكنك حمل أكثر من هذا العدد من السمك")
				else
					weight = math.random(3,6)
					TriggerClientEvent('fishing:message', _source, " إصطدت سمكة وزنها "..weight.." كيلوجرام ")
					xPlayer.addInventoryItem('fish', weight)
				end
			end
		end
		if bait == "none" then
			
			if rnd >= 70 then
			TriggerClientEvent('fishing:message', _source, "~y~You are currently fishing without any equipped bait")
				if  xPlayer.getInventoryItem('fish').count > 100 then
						TriggerClientEvent('fishing:message', _source, "لايمكنك حمل أكثر من هذا العدد من السمك")
					else
						weight = math.random(0,1)
						TriggerClientEvent('fishing:message', _source, " إصطدت سمكة وزنها "..weight.." كيلوجرام ")
						xPlayer.addInventoryItem('fish', weight)
					end
					
				else
				TriggerClientEvent('fishing:message', _source, "~y~You are currently fishing without any equipped bait")
					if xPlayer.getInventoryItem('fish').count > 100 then
						TriggerClientEvent('fishing:message', _source, "لايمكنك حمل أكثر من هذا العدد من السمك")
					else
						weight = math.random(0,1)
						TriggerClientEvent('fishing:message', _source, " إصطدت سمكة وزنها "..weight.." كيلوجرام ")
						xPlayer.addInventoryItem('fish', weight)
					end
				end
		end
		if bait == "shark" then
			if rnd >= 82 then
			
						if rnd >= 97 then
							TriggerClientEvent('fishing:setbait', _source, "none")
							TriggerClientEvent('fishing:message', _source, "السمكة ضخمة قامت بكسر صنارتك")
							TriggerClientEvent('fishing:break', _source)
							xPlayer.removeInventoryItem('fishingrod', 1)
						else
							if xPlayer.getInventoryItem('shark').count > 1  then
									TriggerClientEvent('fishing:setbait', _source, "none")
									TriggerClientEvent('fishing:message', _source, "لا يمكنك حمل أكثر من قرش")
							else
									TriggerClientEvent('fishing:message', _source, "رائع لقد قمت بإصطياد قرش")
									TriggerClientEvent('fishing:spawnPed', _source)
									xPlayer.addInventoryItem('shark', 1)
							end
						end	
							else
									if xPlayer.getInventoryItem('fish').count > 100 then
										TriggerClientEvent('fishing:message', _source, "لايمكنك حمل أكثر من هذا العدد من السمك")
									else
										weight = math.random(1,4)
										TriggerClientEvent('fishing:message', _source, " إصطدت سمكة وزنها "..weight.." كيلوجرام ")
										xPlayer.addInventoryItem('fish', weight)
									end
								
							end
			end
			
		end
	
	
end)

RegisterServerEvent("fishing:lowmoney")
AddEventHandler("fishing:lowmoney", function(money)
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeMoney(money)
end)

RegisterServerEvent("fishing:returnDeposit")
AddEventHandler("fishing:returnDeposit", function(model)
	local _source = source
	local myModel = model
	local xPlayer = ESX.GetPlayerFromId(_source)
	for k, v in ipairs(Config.RentalBoats) do
		if GetHashKey(v.model) == myModel then
			xPlayer.addMoney(v.price)
		end
	end
end)

RegisterServerEvent('fishing:startSelling')
AddEventHandler('fishing:startSelling', function(item)

	local _source = source
	
	local xPlayer  = ESX.GetPlayerFromId(_source)
			if item == "fish" then
					local FishQuantity = xPlayer.getInventoryItem('fish').count
						if FishQuantity <= 4 then
						TriggerClientEvent('esx:showNotification', source, '~r~You dont have enough~s~ fish')			
					else   
						xPlayer.removeInventoryItem('fish', 5)
						local payment = Config.FishPrice.a
						payment = math.random(Config.FishPrice.a, Config.FishPrice.b) 
                        sendToDiscord((' السمك '), GetPlayerName(source) .. " باع  ".. " 5 سمك" .. " مقابل ".. payment.."دولار",56108)
						xPlayer.addMoney(payment)
						
						
			end
				

				

				
			end
			if item == "turtle" then
				local FishQuantity = xPlayer.getInventoryItem('turtle').count

				if FishQuantity <= 0 then
					TriggerClientEvent('esx:showNotification', source, '~r~You dont have enough~s~ turtles')			
				else   
					xPlayer.removeInventoryItem('turtle', 1)
					local payment = Config.TurtlePrice.a
					payment = math.random(Config.TurtlePrice.a, Config.TurtlePrice.b) 
                    sendToDiscord((' السمك '), GetPlayerName(source) .. " باع  ".. " 1 سلحفاة" .. " مقابل ".. payment.."فلوس وسخة",56108)					
					xPlayer.addAccountMoney('black_money', payment)
					
					
				end
			end
			if item == "shark" then
				local FishQuantity = xPlayer.getInventoryItem('shark').count

				if FishQuantity <= 0 then
					TriggerClientEvent('esx:showNotification', source, '~r~You dont have enough~s~ sharks')			
				else   
					xPlayer.removeInventoryItem('shark', 1)
					local payment = Config.SharkPrice.a
					payment = math.random(Config.SharkPrice.a, Config.SharkPrice.b)
                    sendToDiscord((' السمك '), GetPlayerName(source) .. " باع  ".. " 1 قرش" .. " مقابل ".. payment.."فلوس وسخة",56108)							
					xPlayer.addAccountMoney('black_money', payment)
					
					
				end
			end
			
	
end)

