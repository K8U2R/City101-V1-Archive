

local CurrentlyTowedVehicle    = nil
local CurrentlyTowedVehicle2   = nil
local CurrentlyTowedVehicle3   = nil
local CurrentlyTowedVehicle4   = nil
local CurrentlyTowedVehicle5   = nil
local CurrentlyTowedVehicle6   = nil
local CurrentlyTowedVehicle7   = nil
local CurrentlyTowedVehicle8   = nil
local CurrentlyTowedVehicle9   = nil
local CurrentlyTowedVehicle10  = nil
local CurrentlyTowedVehicle11  = nil
local GotTrailer = 0
local TrailerHandle = 0
local oldtrailer = 0
local oldtrailermodel = 0
-- local currentfrozenvehicle = 0
local IsFrozenEntity1 = false
ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	
	ESX.PlayerData = ESX.GetPlayerData()
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

Citizen.CreateThread(function(); while not ConfigReady do; Citizen.Wait(1000); end
	while true do

		Wait(0)
		local myPed = PlayerPedId()
		local myCoord = GetEntityCoords(myPed)
		local currentVehicle = GetVehiclePedIsIn(myPed, 0)
		
		local GotTrailer, TrailerHandle = GetVehicleTrailerVehicle(GetVehiclePedIsIn(myPed, 1))
		if TrailerHandle ~= 0 then
			oldtrailer = TrailerHandle
			oldtrailermodel = GetEntityModel(oldtrailer)
		end

		local trailercoords = GetEntityCoords(oldtrailer)
		if oldtrailermodel == 2078290630 then -- bigtrailer
			if currentVehicle == 0 then -- a pied
				if oldtrailer ~= 0 then
					local coords = GetOffsetFromEntityInWorldCoords(oldtrailer, -2.0, -6.0, -1.1)
					local coords2 = GetOffsetFromEntityInWorldCoords(oldtrailer, 0.0, -12.0, -1.0)
					local dist = GetDistanceBetweenCoords(myCoord.x, myCoord.y, myCoord.z, coords.x, coords.y, coords.z, true)
					if dist < 5 then
						DrawMarker(27, coords.x, coords.y, coords.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 200, 0, 0, 0, 0)
						DrawMarker(1, coords2.x, coords2.y, coords2.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 200, 0, 0, 0, 0)
						-- FreezeEntityPosition
						if dist < 2 then
							SetTextComponentFormat("STRING")
							AddTextComponentString(_U("open_tow_menu"))
							DisplayHelpTextFromStringLabel(0, 0, 1, -1)
							if IsControlJustPressed(0, Config.Key) then
								OpenVehiculeMenu(oldtrailer, coords2)
							end
						else
							ESX.UI.Menu.CloseAll()
						end
					end
				end
			end	
		elseif oldtrailermodel == 712162987 then -- small trailer
			if currentVehicle == 0 then -- a pied
				if oldtrailer ~= 0 then
					local coords = GetOffsetFromEntityInWorldCoords(oldtrailer, -1.5, -3.2, 0)
					local coords2 = GetOffsetFromEntityInWorldCoords(oldtrailer, 0.0, -5.0, -1.0)
					local dist = GetDistanceBetweenCoords(myCoord.x, myCoord.y, myCoord.z, coords.x, coords.y, coords.z, true)
					if dist < 5 then
						DrawMarker(27, coords.x, coords.y, coords.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 200, 0, 0, 0, 0)
						DrawMarker(1, coords2.x, coords2.y, coords2.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 200, 0, 0, 0, 0)
						if dist < 1 then
							SetTextComponentFormat("STRING")
							AddTextComponentString(_U("attach_vehicle"))
							DisplayHelpTextFromStringLabel(0, 0, 1, -1)
							if IsControlJustPressed(0, Config.Key) then
								if Cooldown_count == 0 then
									Cooldown(5)
									local clostestvehicle = GetClosestVehicle(coords2.x, coords2.y, coords2.z, 2.0, 0, 127)
									local modelhash = GetEntityModel(clostestvehicle)
									if Config.Cartrailer[modelhash] ~= nil then
										if (Config.SmallTrailerTowListOnly == true) then
											AttachEntityToEntity(clostestvehicle, oldtrailer, 20, 0.0, Config.Cartrailer[modelhash].ypos, Config.Cartrailer[modelhash].zpos, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
											CurrentlyTowedVehicle7 = clostestvehicle
										elseif (Config.SmallTrailerTowListOnly == false) then
											AttachEntityToEntity(clostestvehicle, oldtrailer, 20, 0.0, Config.Cartrailer[modelhash].ypos, Config.Cartrailer[modelhash].zpos, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
										end
									else
										if (Config.SmallTrailerTowListOnly == false) then
											AttachEntityToEntity(clostestvehicle, oldtrailer, 20, 0.0, -1.1, 0.6, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
											CurrentlyTowedVehicle7 = clostestvehicle
										elseif (Config.SmallTrailerTowListOnly == true) then 
											ESX.ShowNotification('Sorry you cannot tow this vehicle.')
										end
									end
									if (Config.SmallTrailerTowListOnly == false) then 
										CurrentlyTowedVehicle7 = clostestvehicle
									end
								else
									ESX.ShowNotification('<font color=red>يجب الأنتظار</font>. <font color=orange>'..Cooldown_count..' ثانية')
								end
							end
						else
							ESX.ShowHelpNotification("ﺔﺒﻛﺮﻤﻟﺍ لﺍﺰﻧﻷ E ﻂﻐﺿﺍ")
							if IsControlJustPressed(0, 46) then
								if Cooldown_count == 0 then
									Cooldown(5)
									AttachEntityToEntity(CurrentlyTowedVehicle7, oldtrailer, 20, 0.0, -6.0, 0.3, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
									DetachEntity(CurrentlyTowedVehicle7, true, true)
								else
									ESX.ShowNotification('<font color=red>يجب الأنتظار</font>. <font color=orange>'..Cooldown_count..' ثانية')
								end
							end
						end
					end
				end
			end	
		elseif oldtrailermodel == 524108981 then -- boat trailer
			if currentVehicle == 0 then -- a pied
				if oldtrailer ~= 0 then
					local coords = GetOffsetFromEntityInWorldCoords(oldtrailer, -2.0, -3.0, 0)
					local coords2 = GetOffsetFromEntityInWorldCoords(oldtrailer, 0.0, -6.0, -1.0)
					local dist = GetDistanceBetweenCoords(myCoord.x, myCoord.y, myCoord.z, coords.x, coords.y, coords.z, true)
					if dist < 5 then
						DrawMarker(27, coords.x, coords.y, coords.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 200, 0, 0, 0, 0)
						DrawMarker(1, coords2.x, coords2.y, coords2.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 200, 0, 0, 0, 0)
						if dist < 1 then
							SetTextComponentFormat("STRING")
							if CurrentlyTowedVehicle8 == nil then
								AddTextComponentString(_U("attach_vehicle"))
							else
								AddTextComponentString(_U("detach_vehicle"))
							end
							DisplayHelpTextFromStringLabel(0, 0, 1, -1)
							if IsControlJustPressed(0, Config.Key) then
								local clostestvehicle = GetClosestVehicle(coords2.x, coords2.y, coords2.z, 2.0, 0, 12294)
								local modelhash = GetEntityModel(clostestvehicle)
								local isboat = false
								if IsThisModelABoat(modelhash) then
									isboat = true
								else
									isboat = false
								end
								if CurrentlyTowedVehicle8 == nil and isboat then
									if Config.Boattrailer[modelhash] ~= nil then
									    if (Config.BoatTrailerTowListOnly == true) then
										AttachEntityToEntity(clostestvehicle, oldtrailer, 20, 0.0, Config.Boattrailer[modelhash].ypos, Config.Boattrailer[modelhash].zpos, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
									    CurrentlyTowedVehicle8 = clostestvehicle
										elseif (Config.BoatTrailerTowListOnly == false) then
										AttachEntityToEntity(clostestvehicle, oldtrailer, 20, 0.0, Config.Boattrailer[modelhash].ypos, Config.Boattrailer[modelhash].zpos, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
										end
									else
									    if (Config.BoatTrailerTowListOnly == false) then
										AttachEntityToEntity(clostestvehicle, oldtrailer, 20, 0.0, -0.6, 0.3, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
										elseif (Config.BoatTrailerTowListOnly == true) then 
						                ESX.ShowNotification('Sorry you cannot tow this vehicle.')
									end
								end	
									if (Config.BoatTrailerTowListOnly == false) then 
									CurrentlyTowedVehicle8 = clostestvehicle
									end
								else
									AttachEntityToEntity(CurrentlyTowedVehicle8, oldtrailer, 20, 0.0, -7.0, 0.3, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
									DetachEntity(CurrentlyTowedVehicle8, true, true)
									CurrentlyTowedVehicle8 = nil
								end
							end
						end
					end
				end
			end	
		end
		if (Config.Controller == false) then 
		if IsControlJustPressed(1, Config.DetachTrailerKey) then
			local playerVeh = GetVehiclePedIsIn(myPed, true)
			GotTrailer, TrailerHandle = GetVehicleTrailerVehicle(playerVeh)
			DetachVehicleFromTrailer(playerVeh)
			end
		end
	end
end)




function OpenVehiculeMenu(oldtrailer, coords2)

	ESX.UI.Menu.CloseAll()
	local elements = {}
	
	
	if porteCapotOuvert then
		table.insert(elements, {label = _U("close_plateau"),	value = 'FermeturePlateau'})
	else
		table.insert(elements, {label = _U("open_plateau"),		value = 'OuverturePlateau'})
	end
	
	if porteCoffreOuvert then
		table.insert(elements, {label = _U("open_rampe"),	value = 'FermetureRampe'})
	else
		table.insert(elements, {label = _U("close_rampe"),		value = 'OuvertureRampe'})
	end	
	
	table.insert(elements, {label = _U("up_front_car"),	value = 'VoitureAvantBas'})
	table.insert(elements, {label = _U("up_middle_car"),	value = 'VoitureMilieuBas'})
	table.insert(elements, {label = _U("up_back_car"),	value = 'VoitureArriereBas'})
	table.insert(elements, {label = _U("down_front_car"),	value = 'VoitureAvantHaut'})
	table.insert(elements, {label = _U("down_middle_car"),	value = 'VoitureMilieuHaut'})
	table.insert(elements, {label = _U("down_back_car"),	value = 'VoitureArriereHaut'})
	

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'menuperso_vehicule',
		{
			img    = 'menu_vehicule',
			-- title    = 'VĂ©hicule',
			align    = 'bottom-right',
			elements = elements
		},
		function(data, menu)


-------------------------------------------------------------
--------------------- OUVRIR LES PORTES ---------------------
-------------------------------------------------------------
			if data.current.value == 'OuverturePlateau' then
				porteCapotOuvert = true
				SetVehicleDoorOpen(oldtrailer, 4, false, false)
				OpenVehiculeMenu(oldtrailer, coords2)
			elseif data.current.value == 'OuvertureRampe' then
				porteCoffreOuvert = true
				SetVehicleDoorOpen(oldtrailer, 5, false, false)
				OpenVehiculeMenu(oldtrailer, coords2)

-------------------------------------------------------------
--------------------- FERMER LES PORTES ---------------------
-------------------------------------------------------------
			elseif data.current.value == 'FermeturePlateau' then
				porteCapotOuvert = false
				SetVehicleDoorShut(oldtrailer, 4, false, false)
				OpenVehiculeMenu(oldtrailer, coords2)
			elseif data.current.value == 'FermetureRampe' then
				porteCoffreOuvert = false
				SetVehicleDoorShut(oldtrailer, 5, false, false)
				OpenVehiculeMenu(oldtrailer, coords2)


			elseif data.current.value == 'VoitureAvantBas' then
				local clostestvehicle = GetClosestVehicle(coords2.x, coords2.y, coords2.z, 2.0, 0, 127)
				local modelhash = GetEntityModel(clostestvehicle)
				if CurrentlyTowedVehicle == nil then
					if Config.Trucktrailer.VoitureAvantBas[modelhash] ~= nil then
					if (Config.BigTrailerTowListOnly == true) then
						AttachEntityToEntity(clostestvehicle, oldtrailer, 1, Config.Trucktrailer.VoitureAvantBas[modelhash].xpos, Config.Trucktrailer.VoitureAvantBas[modelhash].ypos, Config.Trucktrailer.VoitureAvantBas[modelhash].zpos, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
					    CurrentlyTowedVehicle = clostestvehicle
						elseif (Config.BigTrailerTowListOnly == false) then
						AttachEntityToEntity(clostestvehicle, oldtrailer, 1, Config.Trucktrailer.VoitureAvantBas[modelhash].xpos, Config.Trucktrailer.VoitureAvantBas[modelhash].ypos, Config.Trucktrailer.VoitureAvantBas[modelhash].zpos, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
						end
					else
					    if (Config.BigTrailerTowListOnly == false) then 
						AttachEntityToEntity(clostestvehicle, oldtrailer, 1, -0.6, 13.0, 1.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
						elseif (Config.BigTrailerTowListOnly == true) then 
						ESX.ShowNotification('Sorry you cannot tow this vehicle.')
					end
				end	
					if (Config.BigTrailerTowListOnly == false) then 
					CurrentlyTowedVehicle = clostestvehicle
					end
				else
					AttachEntityToEntity(CurrentlyTowedVehicle, oldtrailer, 1, -0.5, -6.0, 0.3, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
					DetachEntity(CurrentlyTowedVehicle, true, true)
					CurrentlyTowedVehicle = nil
				end
				
			elseif data.current.value == 'VoitureMilieuBas' then
				local clostestvehicle = GetClosestVehicle(coords2.x, coords2.y, coords2.z, 2.0, 0, 127)
				local modelhash = GetEntityModel(clostestvehicle)
				if CurrentlyTowedVehicle2 == nil then
					if Config.Trucktrailer.VoitureMilieuBas[modelhash] ~= nil then
					    if (Config.BigTrailerTowListOnly == true) then
						AttachEntityToEntity(clostestvehicle, oldtrailer, 1, Config.Trucktrailer.VoitureMilieuBas[modelhash].xpos, Config.Trucktrailer.VoitureMilieuBas[modelhash].ypos, Config.Trucktrailer.VoitureMilieuBas[modelhash].zpos, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
					    CurrentlyTowedVehicle2 = clostestvehicle
						elseif (Config.BigTrailerTowListOnly == false) then
						AttachEntityToEntity(clostestvehicle, oldtrailer, 1, Config.Trucktrailer.VoitureMilieuBas[modelhash].xpos, Config.Trucktrailer.VoitureMilieuBas[modelhash].ypos, Config.Trucktrailer.VoitureMilieuBas[modelhash].zpos, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
						end
					else
					    if (Config.BigTrailerTowListOnly == false) then 
						AttachEntityToEntity(clostestvehicle, oldtrailer, 1, -0.6, 7.5, 1.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
						elseif (Config.BigTrailerTowListOnly == true) then 
						ESX.ShowNotification('Sorry you cannot tow this vehicle.')
					end
				end	
				    if (Config.BigTrailerTowListOnly == false) then 
					CurrentlyTowedVehicle2 = clostestvehicle
					end
				else
					AttachEntityToEntity(CurrentlyTowedVehicle2, oldtrailer, 1, -0.5, -6.0, 0.3, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
					DetachEntity(CurrentlyTowedVehicle2, true, true)
					CurrentlyTowedVehicle2 = nil
				end

			elseif data.current.value == 'VoitureArriereBas' then
				local clostestvehicle = GetClosestVehicle(coords2.x, coords2.y, coords2.z, 2.0, 0, 127)
				local modelhash = GetEntityModel(clostestvehicle)
				if CurrentlyTowedVehicle3 == nil then
					if Config.Trucktrailer.VoitureArriereBas[modelhash] ~= nil then
					    if (Config.BigTrailerTowListOnly == true) then
						AttachEntityToEntity(clostestvehicle, oldtrailer, 1, Config.Trucktrailer.VoitureArriereBas[modelhash].xpos, Config.Trucktrailer.VoitureArriereBas[modelhash].ypos, Config.Trucktrailer.VoitureArriereBas[modelhash].zpos, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
					    CurrentlyTowedVehicle3 = clostestvehicle
						elseif (Config.BigTrailerTowListOnly == false) then
						AttachEntityToEntity(clostestvehicle, oldtrailer, 1, Config.Trucktrailer.VoitureArriereBas[modelhash].xpos, Config.Trucktrailer.VoitureArriereBas[modelhash].ypos, Config.Trucktrailer.VoitureArriereBas[modelhash].zpos, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
						end
					else
					    if (Config.BigTrailerTowListOnly == false) then 
						AttachEntityToEntity(clostestvehicle, oldtrailer, 1, -0.6, 2.5, 1.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
						elseif (Config.BigTrailerTowListOnly == true) then 
						ESX.ShowNotification('Sorry you cannot tow this vehicle.')
					end
				end	
				    if (Config.BigTrailerTowListOnly == false) then
					CurrentlyTowedVehicle3 = clostestvehicle
					end
				else
					AttachEntityToEntity(CurrentlyTowedVehicle2, oldtrailer, 1, -0.5, -6.0, 0.3, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
					DetachEntity(CurrentlyTowedVehicle3, true, true)
					CurrentlyTowedVehicle3 = nil
				end

			elseif data.current.value == 'VoitureAvantHaut' then
				local clostestvehicle = GetClosestVehicle(coords2.x, coords2.y, coords2.z, 2.0, 0, 127)
				local modelhash = GetEntityModel(clostestvehicle)
				if CurrentlyTowedVehicle4 == nil then
					if Config.Trucktrailer.VoitureAvantHaut[modelhash] ~= nil then
					if (Config.BigTrailerTowListOnly == true) then
						AttachEntityToEntity(clostestvehicle, oldtrailer, 1, Config.Trucktrailer.VoitureAvantHaut[modelhash].xpos, Config.Trucktrailer.VoitureAvantHaut[modelhash].ypos, Config.Trucktrailer.VoitureAvantHaut[modelhash].zpos, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
					    CurrentlyTowedVehicle4 = clostestvehicle
						elseif (Config.BigTrailerTowListOnly == false) then
						AttachEntityToEntity(clostestvehicle, oldtrailer, 1, Config.Trucktrailer.VoitureAvantHaut[modelhash].xpos, Config.Trucktrailer.VoitureAvantHaut[modelhash].ypos, Config.Trucktrailer.VoitureAvantHaut[modelhash].zpos, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
						end
					else
					    if (Config.BigTrailerTowListOnly == false) then 
						AttachEntityToEntity(clostestvehicle, oldtrailer, 1, -0.6, 13.0, 3.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
						elseif (Config.BigTrailerTowListOnly == true) then 
						ESX.ShowNotification('Sorry you cannot tow this vehicle.')
					end
				end	
					if (Config.BigTrailerTowListOnly == false) then
					CurrentlyTowedVehicle4 = clostestvehicle
					end
				else
					AttachEntityToEntity(CurrentlyTowedVehicle4, oldtrailer, 1, -0.5, -6.0, 0.3, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
					DetachEntity(CurrentlyTowedVehicle4, true, true)
					CurrentlyTowedVehicle4 = nil
				end

			elseif data.current.value == 'VoitureMilieuHaut' then
				local clostestvehicle = GetClosestVehicle(coords2.x, coords2.y, coords2.z, 2.0, 0, 127)
				local modelhash = GetEntityModel(clostestvehicle)
				if CurrentlyTowedVehicle5 == nil then
					if Config.Trucktrailer.VoitureMilieuHaut[modelhash] ~= nil then
					if (Config.BigTrailerTowListOnly == true) then
						AttachEntityToEntity(clostestvehicle, oldtrailer, 1, Config.Trucktrailer.VoitureMilieuHaut[modelhash].xpos, Config.Trucktrailer.VoitureMilieuHaut[modelhash].ypos, Config.Trucktrailer.VoitureMilieuHaut[modelhash].zpos, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
					    CurrentlyTowedVehicle5 = clostestvehicle
						elseif (Config.BigTrailerTowListOnly == false) then
						AttachEntityToEntity(clostestvehicle, oldtrailer, 1, Config.Trucktrailer.VoitureMilieuHaut[modelhash].xpos, Config.Trucktrailer.VoitureMilieuHaut[modelhash].ypos, Config.Trucktrailer.VoitureMilieuHaut[modelhash].zpos, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
						end
					else
					    if (Config.BigTrailerTowListOnly == false) then 
						AttachEntityToEntity(clostestvehicle, oldtrailer, 1, -0.6, 7.5, 3.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
						elseif (Config.BigTrailerTowListOnly == true) then 
						ESX.ShowNotification('Sorry you cannot tow this vehicle.')
					end
				end	
					if (Config.BigTrailerTowListOnly == false) then
					CurrentlyTowedVehicle5 = clostestvehicle
					end
				else
					AttachEntityToEntity(CurrentlyTowedVehicle5, oldtrailer, 1, -0.5, -6.0, 0.3, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
					DetachEntity(CurrentlyTowedVehicle5, true, true)
					CurrentlyTowedVehicle5 = nil
				end
				
			elseif data.current.value == 'VoitureArriereHaut' then
				local clostestvehicle = GetClosestVehicle(coords2.x, coords2.y, coords2.z, 2.0, 0, 127)
				local modelhash = GetEntityModel(clostestvehicle)
				if CurrentlyTowedVehicle6 == nil then
					if Config.Trucktrailer.VoitureArriereHaut[modelhash] ~= nil then
					    if (Config.BigTrailerTowListOnly == true) then
						AttachEntityToEntity(clostestvehicle, oldtrailer, 1, Config.Trucktrailer.VoitureArriereHaut[modelhash].xpos, Config.Trucktrailer.VoitureArriereHaut[modelhash].ypos, Config.Trucktrailer.VoitureArriereHaut[modelhash].zpos, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
					    CurrentlyTowedVehicle6 = clostestvehicle
						elseif (Config.BigTrailerTowListOnly == false) then
						AttachEntityToEntity(clostestvehicle, oldtrailer, 1, Config.Trucktrailer.VoitureArriereHaut[modelhash].xpos, Config.Trucktrailer.VoitureArriereHaut[modelhash].ypos, Config.Trucktrailer.VoitureArriereHaut[modelhash].zpos, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
						end
					else
					    if (Config.BigTrailerTowListOnly == false) then 
						AttachEntityToEntity(clostestvehicle, oldtrailer, 1, -0.6, 2.5, 3.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
						elseif (Config.BigTrailerTowListOnly == true) then 
						ESX.ShowNotification('Sorry you cannot tow this vehicle.')
					end
				end	
					if (Config.BigTrailerTowListOnly == false) then
					CurrentlyTowedVehicle6 = clostestvehicle
					end
				else
					AttachEntityToEntity(CurrentlyTowedVehicle6, oldtrailer, 1, -0.5, -6.0, 0.3, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
					DetachEntity(CurrentlyTowedVehicle6, true, true)
					CurrentlyTowedVehicle6 = nil
				end
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end