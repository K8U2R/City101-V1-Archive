ConfigReady = false
Config = {}
Config.Locale = 'en'

RegisterNetEvent('esx_misc3:updateconfig')
AddEventHandler('esx_misc3:updateconfig', function(opjeecctt)
    Config = opjeecctt
    ConfigReady = true
end)

AddEventHandler('playerSpawned', function()
	Citizen.Wait(5000)
	TriggerServerEvent('esx_misc3:spawned')
end)

-----------------
ESX = nil
govjob = false
leojob = false
leojob2 = false
adminjob = false
ESXDATA = {}


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

function checkRequiredXPlevel(level)
  local plyLevel = exports.ESX_SystemXpLevel.ESXP_GetRank()

  if plyLevel >= level then
    return true
  else
    return false
  end
end