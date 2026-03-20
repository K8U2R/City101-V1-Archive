ESX = nil
govjob = false
leojob = false
leojob2 = false
adminjob = false
ESXDATA = {}

local admin_blips = true
exports('GetAdminBlipsState', function()
  return admin_blips
end)

RegisterNetEvent('esx_misc:adminblips')
AddEventHandler('esx_misc:adminblips', function(state)
  admin_blips = state
end)


Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end

  while ESXDATA.job == nil do
		Citizen.Wait(10)
	end
  
  ESXDATA = ESX.GetPlayerData()
  Citizen.Wait(500)
  isLeooradminorgovJob()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESXDATA = xPlayer
  Citizen.Wait(500)
  isLeooradminorgovJob()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESXDATA.job = job
  Citizen.Wait(500)
  isLeooradminorgovJob()
end)

RegisterCommand('car', function(source, args)
  if exports["esx_adminjob"]:GetAdminIsOnline() then
    local vehicleName = args[1]
    local model = (type(vehicleName) == 'number' and vehicleName or GetHashKey(vehicleName))

    if IsModelInCdimage(model) then
      local playerPed = PlayerPedId()
      local playerCoords, playerHeading = GetEntityCoords(playerPed), GetEntityHeading(playerPed)
      ESX.Game.SpawnVehicle(model, playerCoords, playerHeading, function(vehicle)
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
      end)
    else
      TriggerEvent('chat:addMessage', {args = {'^1SYSTEM', 'Invalid vehicle model.'}})
    end
  end
end, false)

RegisterCommand('dv', function(source, args)

  if exports.esx_adminjob:GetAdminIsOnline() then

    local radius = args[1]
    local playerPed = PlayerPedId()

      if radius and tonumber(radius) then
        radius = tonumber(radius) + 0.01
        local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(playerPed), radius)

        for k,entity in ipairs(vehicles) do
          local attempt = 0

          while not NetworkHasControlOfEntity(entity) and attempt < 100 and DoesEntityExist(entity) do
            Citizen.Wait(100)
            NetworkRequestControlOfEntity(entity)
            attempt = attempt + 1
          end

          if DoesEntityExist(entity) and NetworkHasControlOfEntity(entity) then
            ESX.Game.DeleteVehicle(entity)
          end
        end
      else
        local vehicle, attempt = ESX.Game.GetVehicleInDirection(), 0

        if IsPedInAnyVehicle(playerPed, true) then
          vehicle = GetVehiclePedIsIn(playerPed, false)
        end

        while not NetworkHasControlOfEntity(vehicle) and attempt < 100 and DoesEntityExist(vehicle) do
          Citizen.Wait(100)
          NetworkRequestControlOfEntity(vehicle)
          attempt = attempt + 1
        end

        if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
          ESX.Game.DeleteVehicle(vehicle)
        end
      end
end

end, false)

AddEventHandler('playerSpawned', function()
  TriggerEvent('esx_misc:unrestrain')
	
	--START PVP Enabled--
	Citizen.CreateThread(function()
		local player 	= PlayerId()
		local playerPed = PlayerPedId()
		-- Enable pvp
		NetworkSetFriendlyFireOption(true)
		SetCanAttackFriendly(playerPed, true, true)
	end)
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_misc:unrestrain')

		if HandcuffTimer.Active then
			ESX.ClearTimeout(HandcuffTimer.Task)
		end
	end
end)

function isLeooradminorgovJob()
  while ESXDATA.job == nil do
		Citizen.Wait(10)
	end

  if ESXDATA.job.name == 'admin' then
    adminjob = true
  else
    adminjob = false
  end

  if ESXDATA.job.name == 'police' or ESXDATA.job.name == 'ambulance' or ESXDATA.job.name == 'agent' or ESXDATA.job.name == 'admin' then
    govjob = true
  else
    govjob = false
  end

  if ESXDATA.job.name == 'police' or ESXDATA.job.name == 'agent' or ESXDATA.job.name == 'admin' then
    leojob = true
  else
    leojob = false
  end

  if ESXDATA.job.name == 'police' or ESXDATA.job.name == 'agent' then
    leojob2 = true
  else
    leojob2 = false
  end
  
end


-------------------
--- Players Blip --
-------------------
local playerblips = {}

function ShowJobBlip(job)
    if job == 'ambulance' or job == 'mechanic' then
        return true
    elseif job == 'police' or job == 'agent' then
      if leojob2 then
        return true
      end
    elseif exports.esx_adminjob:GetAdminIsOnline() and admin_blips then
      return true
    end

    return false
end

--[[Citizen.CreateThread( function()
  while true do
		Citizen.Wait(7000)
    ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
            for k, existingBlip in pairs(playerblips) do
                RemoveBlip(existingBlip)
            end
            playerblips = {}
            for k,v in pairs(players) do
              if exports.leojob:GetAdminIsOnline() and v.source ~= GetPlayerServerId(PlayerId()) and admin_blips or ShowJobBlip(v.job.name) and v.source ~= GetPlayerServerId(PlayerId()) then
                  local color = 0
                  
                  if Config.jobsBlip[v.job.name] ~= nil then
                      color = Config.jobsBlip[v.job.name]
                  end
   
                    local blip = AddBlipForCoord(v.Coords.x, v.Coords.y, v.Coords.z)
                    SetBlipAlpha(blip, 180)
                    SetBlipSprite(blip, 1)
                    SetBlipColour(blip, color)
                    SetBlipScale(blip, 0.8)
                    SetBlipShrink(blip, 1)
                    SetBlipDisplay(blip, 6)

                    SetBlipNameToPlayerName(blip, v.source)
      
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(v.SteamName)
                    EndTextCommandSetBlipName(blip)
                      
                    table.insert(playerblips, blip) -- add blip to array so we can remove it later
                end
              end
            
    end)
  end
end)--]]

