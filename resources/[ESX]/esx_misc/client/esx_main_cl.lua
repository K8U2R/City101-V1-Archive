MycurrentJobLeo = false
MycurrentJobHaveBlip = false
PlayerData = {}
ESX = nil

local DoneESX = false

Citizen.CreateThread(function()
		
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	
	PlayerData = ESX.GetPlayerData()
	isLoeJob()
	
	Citizen.Wait(5)
	TriggerServerEvent('esx_misc:GetCache')
	Citizen.Wait(1)
	TriggerServerEvent('esx_misc:GetCacheJobsW')
	Citizen.Wait(1)
	TriggerServerEvent("esx_wesam:getcacheafterjoin")
	Citizen.Wait(1)
	TriggerServerEvent('esx_misc:StartAutoGift')
	Citizen.Wait(1)
	TriggerServerEvent("esx_wesam:getcacheafterjoin")
	Citizen.Wait(1)
	TriggerServerEvent("esx_wesam_or_707Store:checkJobs")
	DoneESX = true
end)

--[[RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	
	isLoeJob()
	
	if Config.OnesyncInfinty then
		createPlayerJobBlip()
	end
end)]]

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	
	isLoeJob()
	
	TriggerServerEvent('esx_misc:updateCache', 'job', job)
	
end)

AddEventHandler('playerSpawned', function(spawn)
	TriggerEvent('esx_misc:unrestrain')
end)

RegisterNetEvent('esx_misc:print')
AddEventHandler('esx_misc:print', function(printMsg)
   --print(printMsg)
end)

--[[
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_misc:unrestrain')

		if Config.EnableHandcuffTimer and HandcuffTimer.Active then
			ESX.ClearTimeout(HandcuffTimer.Task)
		end
	end
end) --]]

--check if player job is leo
--[[
#shared with:
holsterweapon.lua
PanicButtonClient.lua
PoliceReadyWeapon.lua
SafeZones.lua
handcuff.lua
ktackle.lua
]]

function isLoeJob()
	while PlayerData.job == nil do
		Citizen.Wait(500)
	end
	
	local check = false
	
	for i=1, #LeoJobs, 1 do
		if PlayerData.job.name == LeoJobs[i] then
			check = true
			break
		end
	end

	if check then
		MycurrentJobLeo = true
		--Config.cooldownCurrent = Config.cooldownPolice
	else
		MycurrentJobLeo = false
		--Config.cooldownCurrent = Config.cooldownCitizen
	end
end	

--[[ Main
MycurrentJobLeo = false
MycurrentJobHaveBlip = false
PlayerData = {}
ESX = nil

Citizen.CreateThread(function()
		
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	
	PlayerData = ESX.GetPlayerData()
	
	isLoeJob()
	isJobHaveBlip()
	
	if Config.OnesyncInfinty then
		createPlayerJobBlip()
	end
end)

--[[RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	
	isLoeJob()
	
	if Config.OnesyncInfinty then
		createPlayerJobBlip()
	end
end)]]

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	
	isLoeJob()
	isJobHaveBlip()
	
	TriggerServerEvent('esx_misc:updateCache', 'job', job)
end)

AddEventHandler('playerSpawned', function(spawn)
	TriggerEvent('esx_misc:unrestrain')
end)

--[[
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_misc:unrestrain')

		if Config.EnableHandcuffTimer and HandcuffTimer.Active then
			ESX.ClearTimeout(HandcuffTimer.Task)
		end
	end
end) --]]

--check if player job is leo
--[[
#shared with:
holsterweapon.lua
PanicButtonClient.lua
PoliceReadyWeapon.lua
SafeZones.lua
handcuff.lua
]]

function isLoeJob()
	while PlayerData.job == nil do
		Citizen.Wait(500)
	end
	
	local check = false
	
	for i=1, #LeoJobs, 1 do
		if PlayerData.job.name == LeoJobs[i] then
			check = true
			break
		end
	end

	if check then
		MycurrentJobLeo = true
		--Config.cooldownCurrent = Config.cooldownPolice
	else
		MycurrentJobLeo = false
		--Config.cooldownCurrent = Config.cooldownCitizen
	end
end	


function isJobHaveBlip()
	while PlayerData.job == nil do
		Citizen.Wait(500)
	end
	
	local check = false
	
	for job,data in pairs(Config.jobsBlip) do
		if PlayerData.job.name == job then
			check = true
			break
		end
	end

	if check then
		MycurrentJobHaveBlip = true
	else
		MycurrentJobHaveBlip = false
	end
end	


--]]