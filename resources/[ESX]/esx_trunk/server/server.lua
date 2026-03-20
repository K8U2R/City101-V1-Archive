ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('onResourceStart', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end

  --delete random vehicles and work vehicles from database
  MySQL.Async.fetchAll("DELETE FROM trunk WHERE owner = @owner",
  {
      ['@owner'] = false,
  })
end)

function databaseTrunk(plate, vehinventory)
  MySQL.Async.fetchAll("SELECT * FROM trunk WHERE plate = @plate", {
    ['@plate'] = plate,
  }, function(result1)
    if result1[1] ~= nil then
      MySQL.Async.fetchAll("UPDATE trunk SET data = @data WHERE plate = @plate",
      {
          ['@plate'] = plate,
          ['@data'] = json.encode(vehinventory),
      }
      )
    else
      --if vehicle database dose not exist
      MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE plate = @plate", {
        ['@plate'] = plate
      }, function(result2)
        if result2[1] ~= nil then
          MySQL.Async.execute('INSERT INTO trunk (plate, data, owner) VALUES (@plate, @data, @owner)',{
            ['@plate'] = plate,
            ['@data'] = json.encode(vehinventory),
            ['@owner'] = true,
          })
        else
          --if random vehicle or work vehicle
          MySQL.Async.execute('INSERT INTO trunk (plate, data, owner) VALUES (@plate, @data, @owner)',{
            ['@plate'] = plate,
            ['@data'] = json.encode(vehinventory),
            ['@owner'] = false,
          })
        end
      end)
    end
  end)
end

--put
RegisterNetEvent('esx_trunk:put')
AddEventHandler('esx_trunk:put', function(value, type, count, plate)
    local xPlayer      = ESX.GetPlayerFromId(source)
 MySQL.Async.fetchAll("SELECT * FROM trunk WHERE plate = @plate", {
    ['@plate'] = plate,
  }, function(result)
      if result[1] ~= nil then
        vehinventory = json.decode(result[1].data)
      else
        vehinventory = {}
      end
    if count > 0 then
      if type == 'item' then
        if xPlayer.getInventoryItem(value).count >= count then
          xPlayer.removeInventoryItem(value, count)
          if vehinventory[value] ~= nil then
            vehinventory[value] = count + vehinventory[value]
          else
            vehinventory[value] = count
          end
          databaseTrunk(plate, vehinventory)
        else
          xPlayer.showNotification('<font color=red>خطأ بالكمية</font>')
        end
      elseif type == 'weapon' then
        xPlayer.removeWeapon(value)
        if vehinventory[value] ~= nil then
          vehinventory[value] = count + vehinventory[value]
        else
          vehinventory[value] = count
        end
        databaseTrunk(plate, vehinventory)
      elseif type == 'black_money' then
        if xPlayer.getAccount('black_money').money >= count then
          xPlayer.removeAccountMoney('black_money', count)
          if vehinventory['black_money'] ~= nil then
            vehinventory['black_money'] = count + vehinventory['black_money']
          else
            vehinventory['black_money'] = count
          end
          databaseTrunk(plate, vehinventory)
        else
          xPlayer.showNotification('<font color=red>خطأ بالكمية</font>')
        end
      end
    end
  end)
end)

ESX.RegisterServerCallback('esx_trunk:showItemsPlayeyHave', function(source, cb, plate)
  local xPlayer    = ESX.GetPlayerFromId(source)
  local blackMoney = xPlayer.getAccount('black_money').money
  local items      = xPlayer.inventory

  if 0 >= blackMoney then
    blackMoney = false
  end

  MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE plate = @plate", {
    ['@plate'] = plate,
  }, function(result)
    if result[1] ~= nil then
        if result[1].owner == xPlayer.identifier then
          cb({
            blackMoney = blackMoney,
            items      = items,
            CanOpen    = true,
          })
        else
          cb({
            blackMoney = blackMoney,
            items      = items,
            CanOpen    = false,
          })
        end
    else
      cb({
        blackMoney = blackMoney,
        items      = items,
        CanOpen    = true,
      })
    end
  end)
end)

ESX.RegisterServerCallback('esx_trunk:canCLoseDoORs', function(source, cb, plate)
  local xPlayer = ESX.GetPlayerFromId(source)
  MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE plate = @plate", {
    ['@plate'] = plate,
  }, function(result)
    if result[1] then
        if result[1].owner == xPlayer.identifier then
          cb(true)
        else
          cb(false)
        end
    else
      cb(false)
    end
  end)
end)

--take
RegisterNetEvent('esx_trunk:take')
AddEventHandler('esx_trunk:take', function(value, type, count, plate)
    local xPlayer      = ESX.GetPlayerFromId(source)
 MySQL.Async.fetchAll("SELECT * FROM trunk WHERE plate = @plate", {
    ['@plate'] = plate,
  }, function(result)
      if result[1] ~= nil then
        vehinventory = json.decode(result[1].data)
      else
        vehinventory = {}
      end
    if count > 0 then
      if type == 'item' then
        if xPlayer.canCarryItem(value, count) then
          if vehinventory[value] ~= nil then  
            if vehinventory[value] > 0 and vehinventory[value] >= count then
              xPlayer.addInventoryItem(value, count)
              vehinventory[value] = vehinventory[value] - count
              databaseTrunk(plate, vehinventory)
            else
              xPlayer.showNotification('<font color=red>خطأ في الكمية</font>')
              vehinventory[value] = 0
            end
          end
        else
          xPlayer.showNotification('<font color=red>لاتوجد مساحة كافية في حقيبتك</font>')
        end
      elseif type == 'weapon' then
        if vehinventory[value] ~= nil then
          if vehinventory[value] > 0 and vehinventory[value] >= count then
            xPlayer.addWeapon(value, count)
            vehinventory[value] = vehinventory[value] - count
            databaseTrunk(plate, vehinventory)
          else
            xPlayer.showNotification('<font color=red>خطأ في الكمية</font>')
            vehinventory[value] = 0
          end
        end
      elseif type == 'black_money' then
          if vehinventory['black_money'] ~= nil then
              if vehinventory['black_money'] > 0 and vehinventory['black_money'] >= count then
                xPlayer.addAccountMoney('black_money', count)
                vehinventory['black_money'] = vehinventory['black_money'] - count
                databaseTrunk(plate, vehinventory)
              else
                xPlayer.showNotification('<font color=red>مبلغ غير صحيح</font>')
                vehinventory['black_money'] = 0
              end
          end
      end
    end
  end)
end)

ESX.RegisterServerCallback('esx_trunk:showItemsPlayeyHaveV', function(source, cb, plate)
  local xPlayer             = ESX.GetPlayerFromId(source)
  local blackMoney          = 0
  local items               = {}
  local weapons             = {}
  local databaseinventory   = xPlayer.inventory

  MySQL.Async.fetchAll("SELECT * FROM trunk WHERE plate = @plate", {
    ['@plate'] = plate,
  }, function(result2)
      if result2[1] ~= nil then
        vehinventory = json.decode(result2[1].data)
        
        if vehinventory['black_money'] > 0 then
          blackMoney = vehinventory['black_money']
        else
          blackMoney = false
        end
        
        for item,count in pairs(vehinventory) do
          for i=1, #databaseinventory, 1 do
            local itemdatabase = databaseinventory[i]
            if item ~= 'black_money' then
              if item == itemdatabase.name then
                local hi = xPlayer.getInventoryItem(item)
                if count > 0 then
                  table.insert(items, { label = hi.label, count = count, VehWeghit = hi.VehWeghit, name = item})
                end
              end
            end
          end

          if item ~= 'black_money' then
            if count > 0 then
              table.insert(weapons, { name = item , ammo = count })
              --print(item..' | '..count)
            end
          end
        end

        MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE plate = @plate", {
          ['@plate'] = plate,
        }, function(result)
          if result[1] ~= nil then
              if result[1].owner == xPlayer.identifier or xPlayer.getJob().name == 'police' or xPlayer.getJob().name == 'police2' or xPlayer.getJob().name == 'admin' then
                cb({
                  blackMoney = blackMoney,
                  items      = items,
                  weapons    = weapons,
                  CanOpen    = true,
                })
              else
                cb({
                  blackMoney = blackMoney,
                  items      = items,
                  weapons    = weapons,
                  CanOpen    = false,
                })
              end
          else
            cb({
              blackMoney = blackMoney,
              items      = items,
              weapons    = weapons,
              CanOpen    = true,
            })
          end
        end)
      else
        local vehinventoryNew = {
          ['black_money'] = 0
        }
      
        databaseTrunk(plate, vehinventoryNew)
      end
  end)
end)
