local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

PlayerData = {}

local jailTime = 0

jailTimeSec = 0
local T = ''

local BLOCKINPUTCONTROL = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData() == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(newData)
	
	PlayerData = newData

	Citizen.Wait(25000)

	ESX.TriggerServerCallback("esx_jail:retrieveJailTime", function(inJail, newJailTime)
		if inJail then

			jailTime = newJailTime

			JailLogin()
		end
	end)
end)

function isPlayerJailed()
	if jailTime > 0 or jailTimeSec > 0 then
		return true
	else
		return false
	end
end

exports('isPlayerJailed',isPlayerJailed)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(response)
	PlayerData["job"] = response
end)

RegisterNetEvent("esx_jail:openJailMenu")
AddEventHandler("esx_jail:openJailMenu", function()
	OpenJailMenu()
end)

RegisterNetEvent("esx_jail:jailPlayer")
AddEventHandler("esx_jail:jailPlayer", function(newJailTime)
	jailTime = newJailTime
	TriggerServerEvent("esx_wesam:setPlayerJailed", newJailTime)
	Cutscene()
end)

RegisterNetEvent("esx_jail:unJailPlayer")
AddEventHandler("esx_jail:unJailPlayer", function()
	jailTime = 0
	UnJail()
end)

function JailLogin()
	Cutscene()

	ESX.ShowNotification("لقد تمت إعادتك لمركز إعادة التأهيل")

	InJail()
end

function UnJail()
	InJail()

	TriggerServerEvent("esx_wesam:setPlayerUnJailed")
	
	ESX.Game.Teleport(PlayerPedId(), Config.Teleports["Boiling Broke"])

	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)

	ESX.ShowNotification("لقد تم إطلاق سراحك - حظ أوفر")
	TriggerServerEvent("esx_misc:GiveTeleportMenu", GetPlayerServerId(PlayerId()))
end

RegisterNetEvent("esx_jail:updateTimerJail")
AddEventHandler("esx_jail:updateTimerJail", function()
	jailTime = 0
	jailTimeSec = 0
end)

function InJail()

	jailTimeSec = 0

	Citizen.CreateThread(function()

        while jailTime > 0 or jailTimeSec > 0 do

           	if jailTimeSec == 0 then

				jailTime = jailTime - 1

				jailTimeSec = 59

				TriggerServerEvent("esx_jail:updateJailTime", jailTime)
            end
        
            jailTimeSec = jailTimeSec - 1

            if jailTime == 0 and jailTimeSec == 0 then

                UnJail()

                TriggerServerEvent("esx_jail:updateJailTime", 0)

            end
            
            m,s,m2,s2 = '','',''
    
			if jailTime <= 9 then
				m2 = '0'..jailTime
			else
				m2 = jailTime
			end
			
			if jailTimeSec <= 9 then
				s2 = '0'..jailTimeSec
			else
				s2 = jailTimeSec
			end
			-------------
			if jailTime > 0 then
				m = m2..':'
			end
			s = s2
			
			T = m..s
            
        	Citizen.Wait(1000)
        end

    end)
    
	Citizen.CreateThread(function()

		while jailTime > 0 or jailTimeSec > 0 do
			Citizen.Wait(0)

			DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
			DisablePlayerFiring(PlayerPedId(),true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
			DisableControlAction(0, 106, true) -- Disable in-game mouse controls
			DisableControlAction(0, 140, true) -- Disable Reload and melle
			DisableControlAction(0, 141, true) -- Disable melle
			
			--other control
			DisableControlAction(0, Keys["F3"], true)
			DisableControlAction(0, Keys["F1"], true)
			DisableControlAction(0, Keys["F5"], true)
			DisableControlAction(0, Keys["F6"], true)
			DisableControlAction(0, Keys["T"], true)
			DisableControlAction(0, Keys["F2"], true)
			DisableControlAction(0, Keys["G"], true)
			DisableControlAction(0, Keys["F7"], true)
			DisableControlAction(0, Keys["F9"], true)
			DisableControlAction(0, Keys["F10"], true)
			DisableControlAction(0, Keys["SPACE"], true)
			DisableControlAction(0, Keys["Z"], true)
			DisableControlAction(0, Keys["LEFTALT"], true)
			DisableControlAction(0, Keys["DELETE"], true)
			DisableControlAction(0, Keys["LEFTSHIFT"], true)
			DisableControlAction(0, Keys["M"], true)
			DisableControlAction(0, Keys["B"], true)			

			--DELETE LEFTSHIFT m B HOME
			DisableControlAction(0, 243, true)
		end
	end)

	ShowWatermark()
end

function ShowWatermark()
	while jailTime > 0 or jailTimeSec > 0 do
		Citizen.Wait(3)
		SetTextColour(255, 0, 0, 255)
		SetTextFont(fontId)
		SetTextScale(0.31, 0.31)
		SetTextWrap(0.0, 1.0)
		SetTextCentre(false)
		SetTextDropshadow(2, 2, 0, 0, 0)
		SetTextEdge(1, 0, 0, 0, 205)
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString(("<FONT FACE = 'A9eelsh'>%s ﻦﺠﺴﻟﺍ ﺖﻗﻭ"):format(T)) -- "<FONT FACE = 'A9eelsh'>%s ﻦﺠﺴﻟﺍ ﺖﻗﻭ"
		DrawText(0.916, 0.553)
	end
end

function PackPackage(packageId)
	local Package = Config.PrisonWork["Packages"][packageId]

	LoadModel("prop_cs_cardbox_01")

	local PackageObject = CreateObject(GetHashKey("prop_cs_cardbox_01"), Package["x"], Package["y"], Package["z"], true)

	PlaceObjectOnGroundProperly(PackageObject)

	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, false)

	local Packaging = true
	local StartTime = GetGameTimer()

	while Packaging do
		
		Citizen.Wait(1)

		local TimeToTake = 60000 * 1.20 -- Minutes
		local PackPercent = (GetGameTimer() - StartTime) / TimeToTake * 100

		if not IsPedUsingScenario(PlayerPedId(), "PROP_HUMAN_BUM_BIN") then
			DeleteEntity(PackageObject)

			ESX.ShowNotification("ﺔﻴﻠﻤﻌﻟﺍ ﺖﻴﻐﻟﺃ")

			Packaging = false
		end

		if PackPercent >= 100 then

			Packaging = false

			DeliverPackage(PackageObject)

			Package["state"] = false
		else
			ESX.Game.Utils.DrawText3D(Package, "ﺔﺒﺴﻨﻟﺍ... " .. math.ceil(tonumber(PackPercent)) .. "%", 0.4)
		end
		
	end
end

function DeliverPackage(packageId)
	if DoesEntityExist(packageId) then
		AttachEntityToEntity(packageId, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)

		ClearPedTasks(PlayerPedId())
	else
		return
	end

	local Packaging = true

	LoadAnim("anim@heists@box_carry@")

	while Packaging do

		Citizen.Wait(5)

		if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) then
			TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
		end

		if not IsEntityAttachedToEntity(packageId, PlayerPedId()) then
			Packaging = false
			DeleteEntity(packageId)
		else
			local DeliverPosition = Config.PrisonWork["DeliverPackage"]
			local PedPosition = GetEntityCoords(PlayerPedId())
			local DistanceCheck = GetDistanceBetweenCoords(PedPosition, DeliverPosition["x"], DeliverPosition["y"], DeliverPosition["z"], true)

			ESX.Game.Utils.DrawText3D(DeliverPosition, "[E] ﺐﻠﻄﻟﺍ ﻞﻴﺻﻮﺗ", 0.4)

			if DistanceCheck <= 2.0 then
				if IsControlJustPressed(0, 38) then
					DeleteEntity(packageId)
					ClearPedTasksImmediately(PlayerPedId())
					Packaging = false

					TriggerServerEvent("esx_jail:prisonWorkReward")
				end
			end
		end

	end

end

function OpenJailMenu()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'jail_prison_menu',
		{
			title    = "إدارة السجن",
			align    = 'bottom-right',
			elements = {
				{ label = "سجن أقرب لاعب", value = "jail_closest_player" },
				{ label = "إعفاء الاعب من عقوبة السجن", value = "unjail_player" }
			}
		}, 
	function(data, menu)

		local action = data.current.value

		if action == "jail_closest_player" then

			menu.close()

			ESX.UI.Menu.Open(
          		'dialog', GetCurrentResourceName(), 'jail_choose_time_menu',
          		{
            		title = "مدة السجن"
          		},
          	function(data2, menu2)

            	local jailTime = tonumber(data2.value)

            	if jailTime == nil then
              		ESX.ShowNotification("ﻖﺋﺎﻗﺪﻟﺎﺑ ﺖﻗﻮﻟﺍ ﻥﻮﻜﻳ ﻥﺍ ﺐﺠﻳ")
            	else
              		menu2.close()

              		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

              		if closestPlayer == -1 or closestDistance > 3.0 then
                		ESX.ShowNotification("No players nearby!")
					else
						ESX.UI.Menu.Open(
							'dialog', GetCurrentResourceName(), 'jail_choose_reason_menu',
							{
							  title = "سبب السجن"
							},
						function(data3, menu3)
		  
						  	local reason = data3.value
		  
						  	if reason == nil then
								ESX.ShowNotification("ﻦﺠﺴﻟﺍ ﺐﺒﺳ ﺊﻠﻣ ﺐﺠﻳ")
						  	else
								menu3.close()
		  
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		  
								if closestPlayer == -1 or closestDistance > 3.0 then
								  	ESX.ShowNotification("ﺐﻳﺮﻗ ﺐﻋﻻ ﺪﺟﻮﻳﻻ")
								else
								  	TriggerServerEvent("esx_jail:jailPlayer", GetPlayerServerId(closestPlayer), jailTime, reason)
								end
		  
						  	end
		  
						end, function(data3, menu3)
							menu3.close()
						end)
              		end

				end

          	end, function(data2, menu2)
				menu2.close()
			end)
		elseif action == "unjail_player" then

			local elements = {}

			ESX.TriggerServerCallback("esx_jail:retrieveJailedPlayers", function(playerArray)

				if #playerArray == 0 then
					ESX.ShowNotification("ﻦﺠﺴﻟﺍ ﻲﻓ ﺐﻋﻻ ﺪﺟﻮﻳﻻ")
					return
				end

				for i = 1, #playerArray, 1 do
					table.insert(elements, {label = "إسم السجين: " .. playerArray[i].name .. " | مدة السجن: " .. playerArray[i].jailTime .. " دقيقة", value = playerArray[i].identifier })
				end

				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'jail_unjail_menu',
					{
						title = "إعفاء من عقوبة السجن",
						align = "bottom-right",
						elements = elements
					},
				function(data2, menu2)

					local action = data2.current.value

					TriggerServerEvent("esx_jail:unJailPlayer", action)

					menu2.close()

				end, function(data2, menu2)
					menu2.close()
				end)
			end)

		end

	end, function(data, menu)
		menu.close()
	end)	
end

