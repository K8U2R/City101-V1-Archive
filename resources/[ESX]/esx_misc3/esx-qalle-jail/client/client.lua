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


local jailTime = 0


RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(newData)

	Citizen.Wait(25000)

	ESX.TriggerServerCallback("esx-qalle-jail:retrieveJailTime", function(inJail, newJailTime)
		if inJail then

			jailTime = newJailTime

			JailLogin()
		end
	end)
end)


RegisterNetEvent("esx-qalle-jail:openJailMenu")
AddEventHandler("esx-qalle-jail:openJailMenu", function()
	OpenJailMenu()
end)

RegisterNetEvent("esx-qalle-jail:jailPlayer")
AddEventHandler("esx-qalle-jail:jailPlayer", function(newJailTime)
	jailTime = newJailTime

	Cutscene()
end)

RegisterNetEvent("esx-qalle-jail:unJailPlayer")
AddEventHandler("esx-qalle-jail:unJailPlayer", function()
	jailTime = 0

	UnJail()
end)

function getRandomLocation(variable)
    return variable[math.random(1, #variable)]
end

function JailLogin()
	local JailPosition = getRandomLocation(Config.JailPositions)
	--SetEntityCoords(PlayerPedId(), JailPosition['x'], JailPosition['y'], JailPosition['z'] - 1)
	ESX.Game.Teleport(PlayerPed, {x = JailPosition.x, y = JailPosition.y, z = JailPosition.z, heading = JailPosition.h})

	ESX.ShowNotification("آخر مره فصلت كنت مسجون لذلك أنت بالسجن")

	InJail()
end

function UnJail()
	InJail()

	ESX.Game.Teleport(PlayerPedId(), Config.Teleports["Boiling Broke"])

	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)

	ESX.ShowNotification("تم إطلاق سراحك")
end

function InJail()

	--Jail Timer--

	Citizen.CreateThread(function()

		while jailTime > 0 do

			jailTime = jailTime - 1

			ESX.ShowNotification("متبقي في السجن " .. jailTime .. " دقيقة")

			TriggerServerEvent("esx-qalle-jail:updateJailTime", jailTime, securityToken)

			if jailTime == 0 then
				UnJail()

				TriggerServerEvent("esx-qalle-jail:updateJailTime", 0, securityToken)
			end

			Citizen.Wait(60000)
		end

	end)

	--Jail Timer--

	--disable fire--
	Citizen.CreateThread(function()
		while jailTime > 0 do
			Citizen.Wait(0)
			DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
			DisablePlayerFiring(player,true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
			DisableControlAction(0, 106, true) -- Disable in-game mouse controls
			DisableControlAction(0, 140, true) -- Disable Reload and melle
			DisableControlAction(0, 141, true) -- Disable melle
			
			--other control
			DisableControlAction(0, Keys["F3"], true)
			DisableControlAction(0, Keys["F1"], true)
			DisableControlAction(0, Keys["F5"], true)
			DisableControlAction(0, Keys["F6"], true)
			DisableControlAction(0, Keys["T"], true)
			DisableControlAction(0, Keys["SPACE"], true)
			DisableControlAction(0, 243, true)
		end
	end)
	--disable fire--

	--Jail Timer--

	--Prison Work--

	--[[Citizen.CreateThread(function()
		while jailTime > 0 do
			
			local sleepThread = 500

			local Packages = Config.PrisonWork["Packages"]

			local Ped = PlayerPedId()
			local PedCoords = GetEntityCoords(Ped)

			for posId, v in pairs(Packages) do

				local DistanceCheck = GetDistanceBetweenCoords(PedCoords, v["x"], v["y"], v["z"], true)

				if DistanceCheck <= 10.0 then

					sleepThread = 5

					local PackageText = "Pack"

					if not v["state"] then
						PackageText = "Already Taken"
					end

					ESX.Game.Utils.DrawText3D(v, "[E] " .. PackageText, 0.4)

					if DistanceCheck <= 1.5 then

						if IsControlJustPressed(0, 38) then

							if v["state"] then
								PackPackage(posId)
							else
								ESX.ShowNotification("<font color=red>لقد أستلمت الطرد بالفعل </font>")
							end

						end

					end

				end

			end

			Citizen.Wait(sleepThread)

		end
	end)]]

	--Prison Work--

end


function OpenJailMenu()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'jail_prison_menu',
		{
			title    = "Prison Menu",
			align    = 'bottom-right',
			elements = {
				{ label = "سجن أقرب شخص", value = "jail_closest_player" },
				{ label = "الإفراج عن الشخص", value = "unjail_player" }
			}
		}, 
	function(data, menu)

		local action = data.current.value

		if action == "jail_closest_player" then

			menu.close()

			ESX.UI.Menu.Open(
          		'dialog', GetCurrentResourceName(), 'jail_choose_time_menu',
          		{
            		title = "مدة السجن ( شهر )"
          		},
          	function(data2, menu2)

            	local jailTime = tonumber(data2.value)

            	if jailTime == nil then
              		ESX.ShowNotification("<font color=red>يجب كتابة المدة بشكل صحيح</font>")
            	else
              		menu2.close()

              		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

              		if closestPlayer == -1 or closestDistance > 3.0 then
                		ESX.ShowNotification("<font color=red>لا يوجد لاعب بالقرب منك</font>")
					else
						ESX.UI.Menu.Open(
							'dialog', GetCurrentResourceName(), 'jail_choose_reason_menu',
							{
							  title = "سبب السجن"
							},
						function(data3, menu3)
		  
						  	local reason = data3.value
		  
						  	if reason == nil then
								ESX.ShowNotification("<font color=red>يجب عليك إدخال سبب</font>")
						  	else
								menu3.close()
		  
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		  
								if closestPlayer == -1 or closestDistance > 3.0 then
								  	ESX.ShowNotification("<font color=red>لا يوجد لاعب بالقرب منك</font>")
								else
								  	TriggerServerEvent("esx-qalle-jail:jailPlayer", GetPlayerServerId(closestPlayer), jailTime, reason, securityToken)
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

			ESX.TriggerServerCallback("esx-qalle-jail:retrieveJailedPlayers", function(playerArray)

				if #playerArray == 0 then
					ESX.ShowNotification("<font color=red>لا يوجد شخص بالزنزانة</font>")
					return
				end

				for i = 1, #playerArray, 1 do
					table.insert(elements, {label = "السجين: " .. playerArray[i].name .. " | مدة السجن : " .. playerArray[i].jailTime .. " شهر", value = playerArray[i].identifier })
				end

				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'jail_unjail_menu',
					{
						title = "إفراج عن مواطن",
						align = "bottom-right",
						elements = elements
					},
				function(data2, menu2)

					local action = data2.current.value

					TriggerServerEvent("esx-qalle-jail:unJailPlayer", action, securityToken)

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

--احداثيات الكاميرات

-- function RotationToDirection(rotation)
-- 	local adjustedRotation = 
-- 	{ 
-- 		x = (math.pi / 180) * rotation.x, 
-- 		y = (math.pi / 180) * rotation.y, 
-- 		z = (math.pi / 180) * rotation.z 
-- 	}
-- 	local direction = 
-- 	{
-- 		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
-- 		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
-- 		z = math.sin(adjustedRotation.x)
-- 	}
-- 	return direction
-- end

-- function RayCastGamePlayCamera(distance)
-- 	local cameraRotation = GetGameplayCamRot()
-- 	local cameraCoord = GetGameplayCamCoord()
-- 	local direction = RotationToDirection(cameraRotation)
-- 	local destination = 
-- 	{ 
-- 		x = cameraCoord.x + direction.x * distance, 
-- 		y = cameraCoord.y + direction.y * distance, 
-- 		z = cameraCoord.z + direction.z * distance 
-- 	}
-- 	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, -1, 1))
-- 	return b, c, e
-- end

-- Citizen.CreateThread(function()
-- 	while not NetworkIsPlayerActive do
-- 		Citizen.Wait(0)
-- 	end
	
-- 	while true do
-- 		Citizen.Wait(0)

-- 		local hit, coords, entity = RayCastGamePlayCamera(1000.0)

-- 		if hit and (IsEntityAVehicle(entity) or IsEntityAPed(entity)) then
-- 			local position = GetEntityCoords(PlayerPedId())
-- 			DrawLine(position.x, position.y, position.z, coords.x, coords.y, coords.z, 255, 0, 0, 255)
-- 			print('p x = '..position.x..'p y'..position.y..'p z'..position.z..'c x'..coords.x..'c y'..coords.z..'c z'..coords.y)
-- 		end
-- 	end
-- end)