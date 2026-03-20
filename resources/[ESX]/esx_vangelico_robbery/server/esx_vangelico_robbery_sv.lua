local rob = false
local robbers = {}
PlayersCrafting    = {}
local CopsConnected  = 0
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

CountCops()

RegisterServerEvent('esx_vangelico_robbery:toofar')
AddEventHandler('esx_vangelico_robbery:toofar', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
			--TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_cancelled_at') .. Stores[robb].nameofstore)
											TriggerClientEvent("pNotify:SendNotification", xPlayers[i],{
 				                text = "<b style='color:#F6F6F6'><font size=5><center>".._U('robbery_cancelled_at') .. Stores[robb].nameofstore,
					            type = "info",
					            timeout = (6000),
					            layout = "centerLeft",
					            killer = false,
					            queue = "distress_sent"
				            })
			TriggerClientEvent('esx_vangelico_robbery:killblip', xPlayers[i])
		end
	end
	if(robbers[source])then
		TriggerClientEvent('esx_vangelico_robbery:toofarlocal', source)
		robbers[source] = nil
		--TriggerClientEvent('esx:showNotification', source, _U('robbery_has_cancelled') .. Stores[robb].nameofstore)
								TriggerClientEvent("pNotify:SendNotification", source,{
 				                text = "<b style='color:#F6F6F6'><font size=5><center>".._U('robbery_has_cancelled') .. Stores[robb].nameofstore,
					            type = "info",
					            timeout = (6000),
					            layout = "centerLeft",
					            killer = false,
					            queue = "distress_sent"
				            })
	end
end)

RegisterServerEvent('esx_vangelico_robbery:endrob')
AddEventHandler('esx_vangelico_robbery:endrob', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
			--TriggerClientEvent('esx:showNotification', xPlayers[i], _U('end'))
			TriggerClientEvent("pNotify:SendNotification", xPlayers[i],{
 				                text = "<b style='color:#F6F6F6'><font size=5><center ".._U('end'),
					            type = "info",
					            timeout = (6000),
					            layout = "centerLeft",
					            killer = false,
					            queue = "distress_sent"
			})
			TriggerClientEvent('esx_vangelico_robbery:killblip', xPlayers[i])
		end
	end
	if(robbers[source])then
		TriggerClientEvent('esx_vangelico_robbery:robberycomplete', source)
		robbers[source] = nil
		--TriggerClientEvent('esx:showNotification', source, _U('robbery_has_ended') .. Stores[robb].nameofstore)
					TriggerClientEvent("pNotify:SendNotification", source,{
 				                text = "<b style='color:#F6F6F6'><font size=5><center ".._U('robbery_has_ended') .. Stores[robb].nameofstore,
					            type = "info",
					            timeout = (6000),
					            layout = "centerLeft",
					            killer = false,
					            queue = "distress_sent"
			})
	end
end)

RegisterServerEvent('esx_vangelico_robbery:rob')
AddEventHandler('esx_vangelico_robbery:rob', function(robb)

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	if Stores[robb] then

		local store = Stores[robb]

		if (os.time() - store.lastrobbed) < Config.SecBetwNextRob and store.lastrobbed ~= 0 then

            TriggerClientEvent('esx_vangelico_robbery:togliblip', source)
		--	TriggerClientEvent('esx:showNotification', source, _U('already_robbed') .. (Config.SecBetwNextRob - (os.time() - store.lastrobbed)) .. _U('seconds'))
									TriggerClientEvent("pNotify:SendNotification", source, {
							text = "<h1><center><font color=FFAE00><i>تم سرقة محل المجوهرات</i></font></h1>"..
								"</br><font size=5><p align=right><b>الوقت المتبقي حتى يمكن بدأ سرقة اخرى: ".."<font color=00A1FF>"..  (Config.SecBetwNextRob - (os.time() - store.lastrobbed)) .."<font color=white> ثانية",
							type = "alert",
							queue = "left",
							timeout = 7000,
							killer = true,
							theme = "gta",
							layout = "centerLeft"
						})
			return
		end

		if rob == false then

			rob = true
			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				if xPlayer.job.name == 'police' then
					--TriggerClientEvent('esx:showNotification', xPlayers[i], _U('rob_in_prog') .. store.nameofstore)
						TriggerClientEvent("pNotify:SendNotification", xPlayers[i],{
 				                text = "<b style='color:#F6F6F6'><font size=5><center>".._U('rob_in_prog') .. store.nameofstore,
					            type = "info",
					            timeout = (6000),
					            layout = "centerLeft",
					            killer = false,
					            queue = "distress_sent"
				            })
					TriggerClientEvent('esx_vangelico_robbery:setblip', xPlayers[i], Stores[robb].position)
				end
			end
    TriggerClientEvent("pNotify:SetQueueMax", source, "distress_sent", 1)
	
	TriggerClientEvent("pNotify:SendNotification", source,{
 				                text = "<b style='color:#FFAE00'><font size=5><center>".._U('started_to_rob') .. store.nameofstore .. _U('do_not_move').."</center></b>",
					            type = "alert",
					            timeout = (6000),
					            layout = "centerLeft",
					            killer = true,
					            queue = "distress_sent",
								--sounds = {
							 --   sources = {"Radio.wav"}, -- For sounds to work, you place your sound in the html folder and then add it to the files array in the __resource.lua file.
							  --  volume = 0.1,
							  --  conditions = {"docVisible"}
					           -- }
				            })
	
	TriggerClientEvent("pNotify:SendNotification", source,{
 				                text = "<b style='color:#F6F6F6'><font size=5><center>".._U('alarm_triggered'),
					            type = "info",
					            timeout = (6000),
					            layout = "centerLeft",
					            killer = false,
					            queue = "distress_sent"
				            })
	
	TriggerClientEvent("pNotify:SendNotification", source,{
 				                text = "<b style='color:#F6F6F6'><font size=5><center>".._U('hold_pos'),
					            type = "info",
					            timeout = (8000),
					            layout = "centerLeft",
					            killer = false,
					            queue = "distress_sent"
				            })	


			TriggerClientEvent('esx_vangelico_robbery:currentlyrobbing', source, robb)
            CancelEvent()
			Stores[robb].lastrobbed = os.time()
		else
			--TriggerClientEvent('esx:showNotification', source, _U('robbery_already'))
				TriggerClientEvent("pNotify:SendNotification", source,{
 				                text = "<b style='color:#F6F6F6'><font size=5><center>".._U('robbery_already'),
					            type = "info",
					            timeout = (8000),
					            layout = "centerLeft",
					            killer = false,
					            queue = "distress_sent"
				            })	
		end
	end
end)

RegisterServerEvent('esx_vangelico_robbery:gioielli')
AddEventHandler('esx_vangelico_robbery:gioielli', function()

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addInventoryItem('jewels', math.random(Config.MinJewels, Config.MaxJewels))
end)

RegisterServerEvent('lester:vendita')
AddEventHandler('lester:vendita', function()

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local reward = math.floor(Config.PriceForOneJewel * Config.MaxJewelsSell)
	local rewardxp = math.floor(Config.XpForOneJewel * Config.MaxJewelsSell)

	xPlayer.removeInventoryItem('jewels', Config.MaxJewelsSell)
	xPlayer.addAccountMoney('black_money', reward)
	TriggerEvent('Roma_xplevel:updateCurrentPlayerXP', source, 'add', rewardxp, 'lester:vendita')
end)

ESX.RegisterServerCallback('esx_vangelico_robbery:conteggio', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(CopsConnected)
end)

