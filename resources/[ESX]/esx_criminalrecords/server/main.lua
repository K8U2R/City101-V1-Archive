ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_qalle_brottsregister:add')
AddEventHandler('esx_qalle_brottsregister:add', function(id, reason)
  local identifier = ESX.GetPlayerFromId(id).identifier
  --local date = os.date("%Y-%m-%d") -- old
  local date = os.date("%Y.%m.%d | %H:%M")
  MySQL.Async.fetchAll(
    'SELECT firstname, lastname FROM users WHERE identifier = @identifier',{['@identifier'] = identifier},
    function(result)
    if result[1] ~= nil then
      MySQL.Async.execute('INSERT INTO qalle_brottsregister (identifier, firstname, lastname, dateofcrime, crime) VALUES (@identifier, @firstname, @lastname, @dateofcrime, @crime)',
        {
          ['@identifier']   = identifier,
          ['@firstname']    = result[1].firstname,
          ['@lastname']     = result[1].lastname,
          ['@dateofcrime']  = date,
          ['@crime']        = reason,
        }
      )
    end
  end) 
end)

RegisterServerEvent('esx_qalle_brottsregister:add_agent') -- حرس الحدود
AddEventHandler('esx_qalle_brottsregister:add_agent', function(id, reason)
  local identifier = ESX.GetPlayerFromId(id).identifier
  --local date = os.date("%Y-%m-%d") -- old
  local date = os.date("%Y.%m.%d | %H:%M")
  MySQL.Async.fetchAll(
    'SELECT firstname, lastname FROM users WHERE identifier = @identifier',{['@identifier'] = identifier},
    function(result)
    if result[1] ~= nil then
      MySQL.Async.execute('INSERT INTO qalleagent_brottsregister (identifier, firstname, lastname, dateofcrime, crime) VALUES (@identifier, @firstname, @lastname, @dateofcrime, @crime)',
        {
          ['@identifier']   = identifier,
          ['@firstname']    = result[1].firstname,
          ['@lastname']     = result[1].lastname,
          ['@dateofcrime']  = date,
          ['@crime']        = reason,
        }
      )
    end
  end) 
end)

RegisterServerEvent('esx_qalle_brottsregister:addr9abh')
AddEventHandler('esx_qalle_brottsregister:addr9abh', function(id, reason)
  local identifier = ESX.GetPlayerFromId(id).identifier
  --local date = os.date("%Y-%m-%d") -- old
  local date = os.date("%Y.%m.%d | %H:%M")
  MySQL.Async.fetchAll(
    'SELECT firstname, lastname FROM users WHERE identifier = @identifier',{['@identifier'] = identifier},
    function(result)
    if result[1] ~= nil then
      MySQL.Async.execute('INSERT INTO qaller9abh_brottsregister (identifier, firstname, lastname, dateofcrime, crime) VALUES (@identifier, @firstname, @lastname, @dateofcrime, @crime)',
        {
          ['@identifier']   = identifier,
          ['@firstname']    = result[1].firstname,
          ['@lastname']     = result[1].lastname,
          ['@dateofcrime']  = date,
          ['@crime']        = reason,
        }
      )
    end
  end)
end)






RegisterServerEvent('esx_qalle_brottsregister:addtebexdoublexp')
AddEventHandler('esx_qalle_brottsregister:addtebexdoublexp', function(id, time, reason)
  local identifier = ESX.GetPlayerFromId(id).identifier
  MySQL.Async.fetchAll(
    'SELECT firstname, lastname FROM users WHERE identifier = @identifier',{['@identifier'] = identifier},
    function(result)
    if result[1] ~= nil then
      MySQL.Async.execute('INSERT INTO doublexpusers (identifier, firstname, lastname, remainingtime, packname) VALUES (@identifier, @firstname, @lastname, @remainingtime, @packname)',
        {
          ['@identifier']   = identifier,
          ['@firstname']    = result[1].firstname,
          ['@lastname']     = result[1].lastname,
          ['@remainingtime']  = time,
          ['@packname']        = reason,
        }
      )
    end
  end)
end)





RegisterServerEvent('esx_qalle_brottsregister:add_TebexStore')
AddEventHandler('esx_qalle_brottsregister:add_TebexStore', function(id, reason)
  local identifier = ESX.GetPlayerFromId(id).identifier
  --local date = os.date("%Y-%m-%d") -- old
  local date = os.date("%Y.%m.%d | %H:%M")
  MySQL.Async.fetchAll(
    'SELECT firstname, lastname FROM users WHERE identifier = @identifier',{['@identifier'] = identifier},
    function(result)
    if result[1] ~= nil then
      MySQL.Async.execute('INSERT INTO qalletebexstore_brottsregister (identifier, firstname, lastname, dateofcrime, crime) VALUES (@identifier, @firstname, @lastname, @dateofcrime, @crime)',
        {
          ['@identifier']   = identifier,
          ['@firstname']    = result[1].firstname,
          ['@lastname']     = result[1].lastname,
          ['@dateofcrime']  = date,
          ['@crime']        = reason,
        }
      )
    end
  end)
end)


function getIdentity(source)
  local identifier = GetPlayerIdentifiers(source)[1]
  local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
  if result[1] ~= nil then
    local identity = result[1]

    return {
      identifier = identity['identifier'],
      firstname = identity['firstname'],
      lastname = identity['lastname'],
      dateofbirth = identity['dateofbirth'],
      sex = identity['sex'],
      height = identity['height']
    }
  else
    return nil
  end
end


--gets brottsregister
ESX.RegisterServerCallback('esx_qalle_brottsregister:grab', function(source, cb, target)
  local identifier = ESX.GetPlayerFromId(target).identifier
  local name = getIdentity(target)
  MySQL.Async.fetchAll("SELECT identifier, firstname, lastname, dateofcrime, crime, id FROM `qalle_brottsregister` WHERE `identifier` = @identifier",
  {
    ['@identifier'] = identifier
  },
  function(result)
    if identifier ~= nil then
        local crime = {}

      for i=1, #result, 1 do
        table.insert(crime, {
          label = result[i].crime,
          crime = result[i].crime,
          name = result[i].firstname .. ' - ' .. result[i].lastname,
          date = result[i].dateofcrime,
          id = result[i].id
        })
      end
      cb(crime)
    end
  end)
end)

ESX.RegisterServerCallback('esx_qalle_brottsregister:grab_agent', function(source, cb, target) -- حرس الحدود
  local identifier = ESX.GetPlayerFromId(target).identifier
  local name = getIdentity(target)
  MySQL.Async.fetchAll("SELECT identifier, firstname, lastname, dateofcrime, crime, id FROM `qalleagent_brottsregister` WHERE `identifier` = @identifier",
  {
    ['@identifier'] = identifier
  },
  function(result)
    if identifier ~= nil then
        local crime = {}

      for i=1, #result, 1 do
        table.insert(crime, {
          label = result[i].crime,
          crime = result[i].crime,
          name = result[i].firstname .. ' - ' .. result[i].lastname,
          date = result[i].dateofcrime,
          id = result[i].id
        })
      end
      cb(crime)
    end
  end)
end)

--gets brottsregister
ESX.RegisterServerCallback('esx_qalle_brottsregister:grabr9abh', function(source, cb, target)
  local identifier = ESX.GetPlayerFromId(target).identifier
  local name = getIdentity(target)
  MySQL.Async.fetchAll("SELECT identifier, firstname, lastname, dateofcrime, crime FROM `qaller9abh_brottsregister` WHERE `identifier` = @identifier",
  {
    ['@identifier'] = identifier
  },
  function(result)
    if identifier ~= nil then
        local crime = {}

      for i=1, #result, 1 do
        table.insert(crime, {
          crime = result[i].crime,
          name = result[i].firstname .. ' - ' .. result[i].lastname,
          date = result[i].dateofcrime,
        })
      end
      cb(crime)
    end
  end)
end)

ESX.RegisterServerCallback('esx_qalle_brottsregister:grab_TebexStore', function(source, cb, target)
  local identifier = ESX.GetPlayerFromId(target).identifier
  local name = getIdentity(target)
  local ids = ExtractIdentifiers(source)
  _FivemID =ids.fivem
  _steamID =ids.steam
  _discordID ='Discord:'..ids.discord:gsub("discord:", "")
  MySQL.Async.fetchAll("SELECT identifier, firstname, lastname, dateofcrime, crime FROM `qalletebexstore_brottsregister` WHERE `identifier` = @identifier",
  {
    ['@identifier'] = identifier
  },
  function(result)
    if identifier ~= nil then
        local crime = {}

      for i=1, #result, 1 do
        table.insert(crime, {
          crime = result[i].crime,
          name = result[i].firstname .. ' - ' .. result[i].lastname,
          date = result[i].dateofcrime,
        })
      end
      --cb(crime, GetPlayerIdentifiers(target)[6], GetPlayerName(target), GetPlayerIdentifiers(target)[1], GetPlayerIdentifiers(target)[5])
      cb(crime, _FivemID, GetPlayerName(target), _steamID, _discordID)
    end
  end)
end)


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

RegisterServerEvent('esx_qalle_brottsregister:remove')
AddEventHandler('esx_qalle_brottsregister:remove', function(id, crime)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer then
    if xPlayer.getMoney() >= 10000 then
      xPlayer.removeAccountMoney("money", 10000)
      MySQL.Async.execute('DELETE FROM qalle_brottsregister WHERE id = @id', {['@id'] = id})
    else
      xPlayer.showNotification("ليس لديك اموال في الكاش كافيه")
    end
  end
end)

RegisterServerEvent('esx_qalle_brottsregister:remove_agent') -- حرس الحدود
AddEventHandler('esx_qalle_brottsregister:remove_agent', function(id)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer then
    if xPlayer.getMoney() >= 10000 then
      xPlayer.removeAccountMoney("money", 10000)
      MySQL.Async.execute('DELETE FROM qalleagent_brottsregister WHERE id = @id', {['@id'] = id})
    else
      xPlayer.showNotification("ليس لديك اموال في الكاش كافيه")
    end
  end
end)


RegisterServerEvent('esx_qalle_brottsregister:remover9abh')
AddEventHandler('esx_qalle_brottsregister:remover9abh', function(id, crime)
  local identifier = ESX.GetPlayerFromId(id).identifier
  MySQL.Async.fetchAll(
    'SELECT firstname FROM users WHERE identifier = @identifier',{['@identifier'] = identifier},
    function(result)
    if (result[1] ~= nil) then
      MySQL.Async.execute('DELETE FROM qaller9abh_brottsregister WHERE identifier = @identifier AND crime = @crime',
      {
        ['@identifier']    = identifier,
        ['@crime']     = crime
      }
    )
    end
  end)
end)

RegisterServerEvent('esx_qalle_brottsregister:remove_TebexStore')
AddEventHandler('esx_qalle_brottsregister:remove_TebexStore', function(id, crime)
  local identifier = ESX.GetPlayerFromId(id).identifier
  MySQL.Async.fetchAll(
    'SELECT firstname FROM users WHERE identifier = @identifier',{['@identifier'] = identifier},
    function(result)
    if (result[1] ~= nil) then
      MySQL.Async.execute('DELETE FROM qalletebexstore_brottsregister WHERE identifier = @identifier AND crime = @crime',
      {
        ['@identifier']    = identifier,
        ['@crime']     = crime
      }
    )
    end
  end)
end)

RegisterServerEvent('esx_qalle_brottsregister:remove_TebexStore_ra3i')
AddEventHandler('esx_qalle_brottsregister:remove_TebexStore_ra3i', function(number)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer then
    MySQL.Async.execute('DELETE FROM roa3e WHERE identifier = @identifier AND number = @number', {
      ['@identifier']    = xPlayer.identifier,
      ['@number']     = number
    })
  end
end)