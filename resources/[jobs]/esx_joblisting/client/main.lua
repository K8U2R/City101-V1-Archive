local menuIsShowed, hasAlreadyEnteredMarker, isInMarker = false, false, false
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local Cooldown_count = 0
local function Cooldown(sec)
	CreateThread(function()
		Cooldown_count = sec 
		while Cooldown_count ~= 0 do
			Cooldown_count = Cooldown_count - 1
			Wait(1000)
		end	
		Cooldown_count = 0
	end)	
end

function ShowJobListingMenu()
	ESX.TriggerServerCallback('esx_joblisting:getJobsList', function(jobs)
		local elements = {}

		for i=1, #jobs, 1 do
			if jobs[i].job == "fisherman" then
				if exports.ESX_SystemXpLevel.ESXP_GetRank() >= 10 then
					table.insert(elements, {
						label = jobs[i].label,
						job   = jobs[i].job,
						grade   = jobs[i].grade
					})
				else
					table.insert(elements, {
						label = "الأسماك <font color=orange>10</font> <font color=#00FFFF>مستوي</font>",
						job = "fisherman",
						level = 10
					})
				end
			elseif jobs[i].job == "fueler" then
				if exports.ESX_SystemXpLevel.ESXP_GetRank() >= 30 then
					table.insert(elements, {
						label = jobs[i].label,
						job   = jobs[i].job,
						grade   = jobs[i].grade
					})
				else
					table.insert(elements, {
						label = "النفط و الغاز <font color=orange>30</font> <font color=#FF0000>مستوي</font>",
						job = "fueler",
						level = 30
					})
				end
			elseif jobs[i].job == "lumberjack" then
				if exports.ESX_SystemXpLevel.ESXP_GetRank() >= 20 then
					table.insert(elements, {
						label = jobs[i].label,
						job   = jobs[i].job,
						grade   = jobs[i].grade
					})
				else
					table.insert(elements, {
						label = "الأخشاب <font color=orange>20</font> <font color=#994C00>مستوي</font>",
						job = "lumberjack",
						level = 20
					})
				end
			elseif jobs[i].job == "miner" then
				if exports.ESX_SystemXpLevel.ESXP_GetRank() >= 55 then
					table.insert(elements, {
						label = jobs[i].label,
						job   = jobs[i].job,
						grade   = jobs[i].grade
					})
				else
					table.insert(elements, {
						label = "المعادن <font color=orange>55</font> <font color=#FFDE00>مستوي</font>",
						job = "miner",
						level = 55
					})
				end
			elseif jobs[i].job == "tailor" then
				if exports.ESX_SystemXpLevel.ESXP_GetRank() >= 40 then
					table.insert(elements, {
						label = jobs[i].label,
						job   = jobs[i].job,
						grade   = jobs[i].grade
					})
				else
					table.insert(elements, {
						label = "الأقمشة <font color=orange>40</font> <font color=#FFCCE5>مستوي</font>",
						job = "tailor",
						level = 40
					})
				end
			else
				table.insert(elements, {
					label = jobs[i].label,
					job   = jobs[i].job,
					grade   = jobs[i].grade
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'joblisting', {
			title    = 'مركز التوظيف',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
		    if data.current.job == 'admin' then
				Cooldown(10)
				TriggerServerEvent('esx_joblisting:setJob_admin_73alhdba762_dkab62dvbeme', data.current.job, data.current.grade)
				ESX.ShowNotification(_U('new_job_admin'))
				menu.close()
			elseif data.current.job == 'police' then
				Cooldown(10)
				TriggerServerEvent('esx_joblisting:setJob_police_da3oid63', data.current.job, data.current.grade)
				ESX.ShowNotification(_U('new_job_police'))
				menu.close()
			elseif data.current.job == 'agent' then -- ambulance
				Cooldown(10)
				TriggerServerEvent('esx_joblisting:setJob_agent_kaug362', data.current.job, data.current.grade)
				ESX.ShowNotification(_U('new_job_agent'))
				menu.close()
			elseif data.current.job == 'ambulance' then -- ambulance
				Cooldown(10)
				TriggerServerEvent('esx_joblisting:setJob_ambulance_d8labd3', data.current.job, data.current.grade)
				ESX.ShowNotification(_U('new_job_ambulance'))
				menu.close()
			elseif data.current.job == 'mechanic' then
				Cooldown(10)
				TriggerServerEvent('esx_joblisting:setJob_mechanic_a73kvgad3', data.current.job, data.current.grade)
				ESX.ShowNotification(_U('new_job_mechanic'))
				menu.close()
			else
				if data.current.job ~= nil then
					menu.close()
					if data.current.level then
						ESX.ShowNotification("يجب ان تكون خبرتك " .. data.current.level .. " لأخذ الوظيفة")
					else
						Cooldown(5)
						TriggerServerEvent('esx_joblisting:setJob_kaugy36', data.current.job, data.current.grade)
						ESX.ShowNotification(_U('new_job'))
					end
				end
			end
		end, function(data, menu)
			menu.close()
		end)

	end)
end

AddEventHandler('esx_joblisting:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
end)

-- Activate menu when player is inside marker, and draw markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		local coords = GetEntityCoords(PlayerPedId())
		isInMarker = false

		for i=1, #Config.Zones, 1 do
			local distance = GetDistanceBetweenCoords(coords, Config.Zones[i], true)

			if distance < Config.DrawDistance then
				DrawMarker(Config.MarkerType, Config.Zones[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end

			if distance < (Config.ZoneSize.x / 2) then
				isInMarker = true
				ESX.ShowHelpNotification(_U('access_job_center'))
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_joblisting:hasExitedMarker')
		end
	end
end)

-- Create blips
Citizen.CreateThread(function()
	for i=1, #Config.Zones, 1 do
		local blip = AddBlipForCoord(Config.Zones[i])

		SetBlipSprite (blip, 407)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.2)
		SetBlipColour (blip, 27)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName(_U('job_center'))
		EndTextCommandSetBlipName(blip)
	end
end)

-- Menu Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlJustReleased(0, 38) and isInMarker and not menuIsShowed then
		    if Cooldown_count == 0 then
		    Cooldown(5)
			ESX.UI.Menu.CloseAll()
			ShowJobListingMenu()
			else
			ESX.ShowNotification('<font color=red>يجب الأنتظار</font>. <font color=orange>'..Cooldown_count..' ثانية</font>')
		end
	  end
	end
end)