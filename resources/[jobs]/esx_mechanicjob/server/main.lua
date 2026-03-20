ESX                = nil
PlayersHarvesting  = {}
PlayersHarvesting2 = {}
PlayersHarvesting3 = {}
PlayersCrafting    = {}
PlayersCrafting2   = {}
PlayersCrafting3   = {}
local list_car_owner = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
  TriggerEvent('esx_service:activateService', 'mecano', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'mecano', _U('mechanic_customer'), true, true)
TriggerEvent('esx_society:registerSociety', 'mechanic', 'Mechanic', 'society_mechanic', 'society_mechanic', 'society_mechanic', {type = 'private'})




local function Harvest(source)

  SetTimeout(4000, function()

    if PlayersHarvesting[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local GazBottleQuantity = xPlayer.getInventoryItem('gazbottle').count
      local lockpickcounter = xPlayer.getInventoryItem('lockpick').count
      if GazBottleQuantity <= 0 then
        TriggerClientEvent('esx:showNotification', source, 'ليس لديك اسطوانة غاز كافية لتصنيع')
      elseif GazBottleQuantity >= 1 then
        if lockpickcounter > 5 then
          TriggerClientEvent('esx:showNotification', source, _U('you_do_not_room'))
        else
          TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', source, 'add', 10, 'تصنيع')
          xPlayer.removeInventoryItem('gazbottle', 1)
          xPlayer.addInventoryItem('lockpick', 1)
          Harvest(source)
        end
      end
    end
  end)
end

RegisterServerEvent('esx_mecanojob:startHarvest')
AddEventHandler('esx_mecanojob:startHarvest', function()
  local _source = source
  PlayersHarvesting[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('recovery_gas_can'))
  Harvest(source)
end)

RegisterServerEvent('esx_mecanojob:stopHarvest')
AddEventHandler('esx_mecanojob:stopHarvest', function()
  local _source = source
  PlayersHarvesting[_source] = false
end)

ESX.RegisterServerCallback('esx_mechanicjob:getVehicleInfos', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		local retrivedInfo = {plate = plate}

		if result[1] then
			local xPlayer = ESX.GetPlayerFromIdentifier(result[1].owner)

			-- is the owner online?
			if xPlayer then
				retrivedInfo.owner = xPlayer.getName()
				cb(retrivedInfo)
			elseif Config.EnableESXIdentity then
				MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier',  {
					['@identifier'] = result[1].owner
				}, function(result2)
					if result2[1] then
						retrivedInfo.owner = ('%s %s'):format(result2[1].firstname, result2[1].lastname)
						cb(retrivedInfo)
					else
						cb(retrivedInfo)
					end
				end)
			else
				cb(retrivedInfo)
			end
		else
			cb(retrivedInfo)
		end
	end)
end)

------------ Récupération Outils Réparation --------------
local function Harvest2(source)

  SetTimeout(4000, function()

    if PlayersHarvesting2[source] == true then
      local xPlayer  = ESX.GetPlayerFromId(source)
      local ironQuantity = xPlayer.getInventoryItem('iron').count
      local fixkitcounter = xPlayer.getInventoryItem('fixkit').count
      if ironQuantity <= 0 then
        TriggerClientEvent('esx:showNotification', source, 'ليس لديك حديد كافي لتصنيع')
      elseif ironQuantity >= 1 then
        if fixkitcounter > 5 then
          TriggerClientEvent('esx:showNotification', source, _U('you_do_not_room'))
        else
          TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', source, 'add', 10, 'تصنيع')
          xPlayer.removeInventoryItem('iron', 1)
          xPlayer.addInventoryItem('fixkit', 1)
          Harvest2(source)
        end
      end
    end
  end)
end

RegisterServerEvent('esx_mecanojob:startHarvest2')
AddEventHandler('esx_mecanojob:startHarvest2', function()
  local _source = source
  PlayersHarvesting2[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('recovery_repair_tools'))
  Harvest2(_source)
end)

RegisterServerEvent('esx_mecanojob:stopHarvest2')
AddEventHandler('esx_mecanojob:stopHarvest2', function()
  local _source = source
  PlayersHarvesting2[_source] = false
end)
----------------- Récupération Outils Carosserie ----------------
--[[local function Harvest3(source)

  SetTimeout(4000, function()

    if PlayersHarvesting3[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CaroToolQuantity  = xPlayer.getInventoryItem('carotool').count
      if CaroToolQuantity >= 5 then
        TriggerClientEvent('esx:showNotification', source, _U('you_do_not_room'))
      else
        xPlayer.addInventoryItem('carotool', 1)
        Harvest3(source)
      end
    end
  end)
end

RegisterServerEvent('esx_mecanojob:startHarvest3')
AddEventHandler('esx_mecanojob:startHarvest3', function()
  local _source = source
  PlayersHarvesting3[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('recovery_body_tools'))
  Harvest3(_source)
end)--]]

Citizen.CreateThread(function()
  local data = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles')
  for i=1, #data, 1 do
    local vehicle = json.decode(data[i].vehicle)
    local plate = vehicle["plate"]
    if vehicle["model"] == 32663974 or vehicle["model"] == -1872656223 then
      if list_car_owner[data[i].owner] then
        if list_car_owner[data[i].owner][data[i].vehicle] then
          --print()
        else
          list_car_owner[data[i].owner][data[i].vehicle] = plate
        end
      else
        list_car_owner[data[i].owner] = {}
        if list_car_owner[data[i].owner][data[i].vehicle] then
          --print()
        else
          list_car_owner[data[i].owner][data[i].vehicle] = plate
        end
      end
    end
  end
end)

RegisterNetEvent("esx_wesam:getcacheafterjoin")
AddEventHandler("esx_wesam:getcacheafterjoin", function()
  TriggerClientEvent("esx_wesam:setListCarsS", source, list_car_owner)
end)

RegisterServerEvent('esx_mecanojob:stopHarvest3')
AddEventHandler('esx_mecanojob:stopHarvest3', function()
  local _source = source
  PlayersHarvesting3[_source] = false
end)
------------ Craft Chalumeau -------------------
local function Craft(source)

  SetTimeout(4000, function()

    if PlayersCrafting[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local GazBottleQuantity = xPlayer.getInventoryItem('gazbottle').count

      if GazBottleQuantity <= 0 then
        TriggerClientEvent('esx:showNotification', source, _U('not_enough_gas_can'))
      else
                xPlayer.removeInventoryItem('gazbottle', 1)
                xPlayer.addInventoryItem('blowpipe', 1)

        Craft(source)
      end
    end
  end)
end

RegisterNetEvent('esx_mechanic:sendToAllPlayersNotficiton')
AddEventHandler('esx_mechanic:sendToAllPlayersNotficiton', function(jobsGradePlayer)
	local Player = ESX.GetPlayerFromId(source)
	local name_player = Player.getName()
	local Players = ESX.GetPlayers()
	for i = 1, #Players, 1 do
		local xPlayer = ESX.GetPlayerFromId(Players[i])
		if xPlayer.job.name == 'mechanic' then
			xPlayer.showNotification('<font color=yellow>اعلان خدمة موظف</font>' .. '<p align=center><b><font color=808080> كراج الميكانيك<p align=center><b><font color=00CC00>تسجيل دخول <font color=FFFFFF>' .. name_player)
		end
	end
end)

RegisterServerEvent('esx_mecanojob:startCraft')
AddEventHandler('esx_mecanojob:startCraft', function()
  local _source = source
  PlayersCrafting[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('assembling_blowtorch'))
  Craft(_source)
end)

RegisterServerEvent('esx_mecanojob:stopCraft')
AddEventHandler('esx_mecanojob:stopCraft', function()
  local _source = source
  PlayersCrafting[_source] = false
end)
------------ Craft kit Réparation --------------
local function Craft2(source)

  SetTimeout(4000, function()

    if PlayersCrafting2[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local FixToolQuantity  = xPlayer.getInventoryItem('fixtool').count
      if FixToolQuantity <= 0 then
        TriggerClientEvent('esx:showNotification', source, _U('not_enough_repair_tools'))
      else
                xPlayer.removeInventoryItem('fixtool', 1)
                xPlayer.addInventoryItem('fixkit', 1)

        Craft2(source)
      end
    end
  end)
end

RegisterServerEvent('esx_mecanojob:startCraft2')
AddEventHandler('esx_mecanojob:startCraft2', function()
  local _source = source
  PlayersCrafting2[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('assembling_blowtorch'))
  Craft2(_source)
end)

RegisterServerEvent('esx_mecanojob:stopCraft2')
AddEventHandler('esx_mecanojob:stopCraft2', function()
  local _source = source
  PlayersCrafting2[_source] = false
end)
----------------- Craft kit Carosserie ----------------
local function Craft3(source)

  SetTimeout(4000, function()

    if PlayersCrafting3[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CaroToolQuantity  = xPlayer.getInventoryItem('carotool').count
            if CaroToolQuantity <= 0 then
        TriggerClientEvent('esx:showNotification', source, _U('not_enough_body_tools'))
      else
                xPlayer.removeInventoryItem('carotool', 1)
                xPlayer.addInventoryItem('carokit', 1)

        Craft3(source)
      end
    end
  end)
end

RegisterServerEvent('esx_mecanojob:startCraft3')
AddEventHandler('esx_mecanojob:startCraft3', function()
  local _source = source
  PlayersCrafting3[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('assembling_body_kit'))
  Craft3(_source)
end)

RegisterServerEvent('esx_mecanojob:stopCraft3')
AddEventHandler('esx_mecanojob:stopCraft3', function()
  local _source = source
  PlayersCrafting3[_source] = false
end)

---------------------------- NPC Job Earnings ------------------------------------------------------

RegisterServerEvent('esx_mecanojob:onNPCJobMissionCompleted')
AddEventHandler('esx_mecanojob:onNPCJobMissionCompleted', function()

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local total   = math.random(Config.NPCJobEarnings.min, Config.NPCJobEarnings.max);

  if xPlayer.job.grade >= 3 then
    total = total * 2
  end

  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mecano', function(account)
    account.addMoney(total)
  end)

  TriggerClientEvent("esx:showNotification", _source, _U('your_comp_earned').. total)

end)

---------------------------- register usable item --------------------------------------------------
ESX.RegisterUsableItem('blowpipe', function(source)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

  xPlayer.removeInventoryItem('blowpipe', 1)

  TriggerClientEvent('esx_mecanojob:onHijack', _source)
    TriggerClientEvent('esx:showNotification', _source, _U('you_used_blowtorch'))

end)

RegisterServerEvent('esx_mechanicjob:RemoveItem_repair')
AddEventHandler('esx_mechanicjob:RemoveItem_repair', function(ped, coords, veh)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('fixkit', 1)
	TriggerClientEvent('esx_mechanicjob:Start_repair', _source, ped, coords, veh)
end)

ESX.RegisterUsableItem('fixkit', function(source) -- repair veh START
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local fixkitItem = xPlayer.getInventoryItem('fixkit')
	if fixkitItem.count < 1 then
		TriggerClientEvent('esx:showNotification', source, 'لا تمتلك عدة تصليح')
	else
		TriggerClientEvent('esx_mechanicjob:repairveh', source)
	end
end)

ESX.RegisterUsableItem('carokit', function(source)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

  xPlayer.removeInventoryItem('carokit', 1)

  TriggerClientEvent('esx_mecanojob:onCarokit', _source)
    TriggerClientEvent('esx:showNotification', _source, _U('you_used_body_kit'))

end)

----------------------------------
---- Ajout Gestion Stock Boss ----
----------------------------------

RegisterServerEvent('esx_mechanicjob:getStockItem')
AddEventHandler('esx_mechanicjob:getStockItem', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mecano', function(inventory)

    local item = inventory.getItem(itemName)

    if item.count >= count then
      inventory.removeItem(itemName, count)
      xPlayer.addInventoryItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_removed') .. count .. ' ' .. item.label)

  end)

end)

--ESX.RegisterServerCallback('esx_mecanojob:getStockItems', function(source, cb)
ESX.RegisterServerCallback('esx_mechanicjob:getStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mecano', function(inventory)
    cb(inventory.items)
  end)

end)

-------------
-- AJOUT 2 --
-------------

ESX.RegisterServerCallback('esx_mechanicjob:canMechanicImpound', function(source, cb, location, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'mechanic' or xPlayer.job.name == 'police' then
		cb(true)
		Citizen.Wait(10000)
    MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate',  {
      ['@plate'] = plate
    }, function(result2)
      if result2[1] then
        local xPlayer2 = ESX.GetPlayerFromIdentifier(result2[1].owner)
        if xPlayer2 then
          xPlayer2.showNotification("تم حجز مركبتك المعرفة بلوحة <font color=orange>" .. plate .. "</font> الان متواجده في حجز المركبات")
        end
      end
    end)
    --TriggerClientEvent('chatMessage', -1, "🔧 كراج الميكانيك | " ,  {220,220,220} ,  "تم حجز المركبة المعرفة بلوحة ^3" .. plate .. " ^0متواجدة الان في حجز المركبات")
		TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', source, 'add', Config.impoundxp, 'حجز مركبة')
		xPlayer.addMoney(Config.impoundmoney)
		
		TriggerClientEvent("pNotify:SendNotification", source, {
		text = "<h1><center><font color=orange><i> 🚧 حجز مركبة</i></font></h1></b></center> <br /><br /><div align='right'> <b style='color:White;font-size:50px'><font size=5 color=White><font color=green>$"..Config.impoundmoney.."</font> : حصلت على <b style='color:green;font-size:26px'></font><b style='color:#3498DB;font-size:20px'><font size=5><p align=right><b> خبرة <font color=Blue>"..Config.impoundxp.." </font>",
		type = "warning",
		timeout = 15000,
		layout = "centerLeft"
		})
		
	else
		cb(false)
	end
end)

RegisterServerEvent('esx_mechanicjob:putStockItems')
AddEventHandler('esx_mechanicjob:putStockItems', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mecano', function(inventory)

    local item = inventory.getItem(itemName)

    if item.count >= 0 then
      xPlayer.removeInventoryItem(itemName, count)
      inventory.addItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_added') .. count .. ' ' .. item.label)

  end)

end)

--ESX.RegisterServerCallback('esx_mecanojob:putStockItems', function(source, cb)

--  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_policestock', function(inventory)
--    cb(inventory.items)
--  end)

--end)

ESX.RegisterServerCallback('esx_mechanicjob:getPlayerInventory', function(source, cb)

  local xPlayer    = ESX.GetPlayerFromId(source)
  local items      = xPlayer.inventory

  cb({
    items      = items
  })

end)
