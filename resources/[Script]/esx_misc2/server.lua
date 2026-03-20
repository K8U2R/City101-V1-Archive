local seatsTaken = {} -- esx_sit

ESX = nil

TriggerEvent("esx:getSharedObject", function(library) 
	ESX = library 
end)

ESX.RegisterServerCallback('esx_misc2:carwash:canAfford', function(source, cb) -- car wash
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.EnablePrice then
		if xPlayer.getMoney() >= Config.Price then
			xPlayer.removeMoney(Config.Price)
			cb(true)
		else
			cb(false)
		end
	else
		cb(true)
	end
end)

RegisterNetEvent('esx_sit:takePlace') -- esx_sit
AddEventHandler('esx_sit:takePlace', function(objectCoords)
	seatsTaken[objectCoords] = true
end)

RegisterNetEvent('esx_sit:leavePlace')
AddEventHandler('esx_sit:leavePlace', function(objectCoords)
	if seatsTaken[objectCoords] then
		seatsTaken[objectCoords] = nil
	end
end)

ESX.RegisterServerCallback('esx_sit:getPlace', function(source, cb, objectCoords)
	cb(seatsTaken[objectCoords])
end) -- esx_sit end

ESX.RegisterUsableItem('fixkit', function(source) -- repair veh START
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local fixkitItem = xPlayer.getInventoryItem('fixkit')
	if fixkitItem.count < 1 then
		TriggerClientEvent('esx:showNotification', source, 'لا تمتلك عدة تصليح')
	else
		TriggerClientEvent('esx_misc2:repairveh', source)
	end
end)

RegisterServerEvent('esx_misc2:RemoveItem_repair')
AddEventHandler('esx_misc2:RemoveItem_repair', function(ped, coords, veh)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('fixkit', 1)
	TriggerClientEvent('esx_misc2:Start_repair', _source, ped, coords, veh)
end)
-- repair veh END

local Cops = {
	"steam:100000000000",
}

RegisterServerEvent("misc2:PoliceVehicleWeaponDeleter:askDropWeapon")
AddEventHandler("misc2:PoliceVehicleWeaponDeleter:askDropWeapon", function(wea, pas)
    if pas == Config.pas then
	local isCop = false

	for _,k in pairs(Cops) do
		if(k == getPlayerID(source)) then
			isCop = true
			break;
		end
	end

	if(not isCop) then
		--print(1)
		TriggerClientEvent("PoliceVehicleWeaponDeleter:drop", source, wea)
	end

   end
end)


function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end

-- gets the actual player id unique to the player,
-- independent of whether the player changes their screen name
function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end