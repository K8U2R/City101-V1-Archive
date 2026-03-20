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

local isDead = false
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('esx:onPlayerDeath', function()
	isDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)

function startAttitude(lib, anim)
	Citizen.CreateThread(function()
	
		local playerPed = GetPlayerPed(-1)
		RequestAnimSet(anim)
		
		while not HasAnimSetLoaded(anim) do
			Citizen.Wait(1)
		end
		SetPedMovementClipset(playerPed, anim, true)
	end)
end

function startAnim(lib, anim)
	Citizen.CreateThread(function()
		RequestAnimDict(lib)
		while not HasAnimDictLoaded(lib) do
			Citizen.Wait(1)
		end

		TaskPlayAnim(GetPlayerPed(-1), lib ,anim ,8.0, -8.0, -1, 0, 0, false, false, false)
	end)
end

function startScenario(anim)
	TaskStartScenarioInPlace(GetPlayerPed(-1), anim, 0, false)
end

AddEventHandler("OpenAnimationsMenu", function()
	local elements = {}
	table.insert(elements, {label = "<font color=#B200FF>❤️ المفضلة</font>", value = "favorite"})
	for i=1, #Config.Animations, 1 do
		table.insert(elements, {label = Config.Animations[i].label, value = Config.Animations[i].name})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'animations', {
		title    = ':::: الحركات ::::',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == "favorite" then
			ESX.TriggerServerCallback("esx_wesam:getfavorite", function(data)
				local title    = nil
				local elements = {}
				table.insert(elements, {label = "<font color=orange>تحية</font> | <font color=#7CFC00> جديد</font> <font color=yellow>مدينة 101</font>", type = "dpemotes", value = {lib = nil, anim = nil, name = "airforce04", type = "Emotes", is_with_move = false, cant_remove = true}})
				table.insert(elements, {label = "<font color=orange>تحية بدون ثبات</font> | <font color=#7CFC00> جديد</font> <font color=yellow>مدينة 101</font>", type = "dpemotes", value = {lib = nil, anim = nil, name = "airforce04", type = "Emotes", is_with_move = true, cant_remove = true}})
				table.insert(elements, {label = "<font color=orange>ضم اليدين</font> | <font color=#7CFC00> جديد</font> <font color=yellow>مدينة 101</font>", type = "dpemotes", value = {lib = nil, anim = nil, name = "airforce03", type = "Emotes", is_with_move = false, cant_remove = true}})
				table.insert(elements, {label = "<font color=orange>ضم اليدين بدون ثبات</font> | <font color=#7CFC00> جديد</font> <font color=yellow>مدينة 101</font>", type = "dpemotes", value = {lib = nil, anim = nil, name = "airforce03", type = "Emotes", is_with_move = true, cant_remove = true}})
				table.insert(elements, {label = "<font color=orange>استعداد</font> | <font color=#7CFC00> جديد</font> <font color=yellow>مدينة 101</font>", type = "dpemotes", value = {lib = nil, anim = nil, name = "airforce01", type = "Emotes", is_with_move = false, cant_remove = true}})
				table.insert(elements, {label = "<font color=orange>ثابت تماماّ</font> | <font color=#7CFC00> جديد</font> <font color=yellow>مدينة 101</font>", type = "dpemotes", value = {lib = nil, anim = nil, name = "airforce02", type = "Emotes", is_with_move = false, cant_remove = true}})
				if data == false then
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'favorite_f3_menu', {
						title    = "<font color=#B200FF>❤️ المفضلة</font>",
						align    = 'top-left',
						elements = elements
					}, function(data, menu)
						ClearPedTasks(GetPlayerPed(-1))
						
						local type = data.current.type
						local lib  = data.current.value.lib
						local anim = data.current.value.anim
						if type == 'scenario' then
							startScenario(anim)
						elseif type == 'dpemotes' then
							local emotesType = data.current.value.type
							local emotesName = data.current.value.name
							
							if emotesType == 'Shared' then
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
								if closestPlayer ~= -1 and closestDistance <= 1.5 then
									TriggerServerEvent('esx_animations:ServerEmoteRequest', GetPlayerServerId(closestPlayer),emotesName,'Shared')
								else
									ESX.ShowNotification('<font color=red>لايوجد لاعب قريب منك')
								end
							elseif emotesType == 'Expressions' then
								OnEmotePlay(DP.Expressions[emotesName])
							elseif emotesType == 'Emotes' then
								if emotesName == "airforce01" or emotesName == "airforce02" or emotesName == "airforce03" or emotesName == "airforce04" then
									if data.current.value.is_with_move then
										OnEmotePlay(DP.Emotes[emotesName], true)
									else
										OnEmotePlay(DP.Emotes[emotesName])
									end
								else
									OnEmotePlay(DP.Emotes[emotesName])
								end
							elseif emotesType == 'Dances' then
								OnEmotePlay(DP.Dances[emotesName])
							elseif emotesType == 'Walks' then
								WalkMenuStart(emotesName)
							elseif emotesType == 'PropEmotes' then
								OnEmotePlay(DP.PropEmotes[emotesName])
							end
						else
							if type == 'attitude' then
								startAttitude(lib, anim)
							else
								startAnim(lib, anim)
							end
						end
					end, function(data, menu)
						menu.close()
					end)
				else
					for i=1, #data, 1 do
					
						table.insert(elements, {label = data[i].label, type = data[i].type, value = {lib = data[i].data_lib, anim = data[i].data_anim, name = data[i].data_name, type = data[i].data_type}, id = data[i].id})

					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'favorite_f3_menu', {
						title    = "<font color=#B200FF>❤️ المفضلة</font>",
						align    = 'top-left',
						elements = elements
					}, function(data, menu)
						if data.current.value.label == nil and data.current.value.anim == nil then
							ClearPedTasks(GetPlayerPed(-1))
							local type = data.current.type
							local lib  = data.current.value.lib
							local anim = data.current.value.anim
							if type == 'scenario' then
								startScenario(anim)
							elseif type == 'dpemotes' then
								local emotesType = data.current.value.type
								local emotesName = data.current.value.name
								
								if emotesType == 'Shared' then
									local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
									if closestPlayer ~= -1 and closestDistance <= 1.5 then
										TriggerServerEvent('esx_animations:ServerEmoteRequest', GetPlayerServerId(closestPlayer),emotesName,'Shared')
									else
										ESX.ShowNotification('<font color=red>لايوجد لاعب قريب منك')
									end
								elseif emotesType == 'Expressions' then
									OnEmotePlay(DP.Expressions[emotesName])
								elseif emotesType == 'Emotes' then
									if emotesName == "airforce01" or emotesName == "airforce02" or emotesName == "airforce03" or emotesName == "airforce04" then
										if data.current.value.is_with_move then
											OnEmotePlay(DP.Emotes[emotesName], true)
										else
											OnEmotePlay(DP.Emotes[emotesName])
										end
									else
										OnEmotePlay(DP.Emotes[emotesName])
									end
								elseif emotesType == 'Dances' then
									OnEmotePlay(DP.Dances[emotesName])
								elseif emotesType == 'Walks' then
									WalkMenuStart(emotesName)
								elseif emotesType == 'PropEmotes' then
									OnEmotePlay(DP.PropEmotes[emotesName])
								end
							else
								if type == 'attitude' then
									startAttitude(lib, anim)
								else
									startAnim(lib, anim)
								end
							end
						else
							ESX.UI.Menu.Open("default", GetCurrentResourceName(), "check_what_is_want_2", {
								title = "<font color=#B200FF>❤️ المفضلة</font>",
								align = "top-left",
								elements = {
									{label = "<font color=#00FF00>افعل الحركة</font>", value = "do_anim"},
									{label = "إزالة من <font color=#B200FF>❤️ المفضلة</font>", value = "remove_from_favorite"}
								}
							}, function(data_check, menu_check)
								if data_check.current.value == "do_anim" then
									menu_check.close()
									ClearPedTasks(GetPlayerPed(-1))
									local type = data.current.type
									local lib  = data.current.value.lib
									local anim = data.current.value.anim
									if type == 'scenario' then
										startScenario(anim)
									elseif type == 'dpemotes' then
										local emotesType = data.current.value.type
										local emotesName = data.current.value.name
										
										if emotesType == 'Shared' then
											local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
											if closestPlayer ~= -1 and closestDistance <= 1.5 then
												TriggerServerEvent('esx_animations:ServerEmoteRequest', GetPlayerServerId(closestPlayer),emotesName,'Shared')
											else
												ESX.ShowNotification('<font color=red>لايوجد لاعب قريب منك')
											end
										elseif emotesType == 'Expressions' then
											OnEmotePlay(DP.Expressions[emotesName])
										elseif emotesType == 'Emotes' then
											if emotesName == "airforce01" or emotesName == "airforce02" or emotesName == "airforce03" or emotesName == "airforce04" then
												if data.current.value.is_with_move then
													OnEmotePlay(DP.Emotes[emotesName], true)
												else
													OnEmotePlay(DP.Emotes[emotesName])
												end
											else
												OnEmotePlay(DP.Emotes[emotesName])
											end
										elseif emotesType == 'Dances' then
											OnEmotePlay(DP.Dances[emotesName])
										elseif emotesType == 'Walks' then
											WalkMenuStart(emotesName)
										elseif emotesType == 'PropEmotes' then
											OnEmotePlay(DP.PropEmotes[emotesName])
										end
									else
										if type == 'attitude' then
											startAttitude(lib, anim)
										else
											startAnim(lib, anim)
										end
									end
								elseif data_check.current.value == "remove_from_favorite" then
									ESX.UI.Menu.CloseAll()
									TriggerServerEvent("esx_wesam:remove_animations", data.current.id)
									TriggerEvent("OpenAnimationsMenu")
								end
							end, function(data_check, menu_check)
								menu_check.close()
							end)
						end
					end, function(data, menu)
						menu.close()
					end)
				end
			end)
		else
			OpenAnimationsSubMenu(data.current.value)
		end
	end, function(data, menu)
		menu.close()
	end)
end)

local is_dead_player = false
local set_animation = false

AddEventHandler('playerSpawned', function()
	is_dead_player = false
  set_animation = false
end)

AddEventHandler('esx:onPlayerDeath', function()
	is_dead_player = true
end)

function OpenAnimationsSubMenu(menu)
	local title    = nil
	local elements = {}

	for i=1, #Config.Animations, 1 do
	
		if Config.Animations[i].name == menu then
			title = Config.Animations[i].label

			for j=1, # Config.Animations[i].items, 1 do
				table.insert(elements, {label = Config.Animations[i].items[j].label, type = Config.Animations[i].items[j].type, value = Config.Animations[i].items[j].data})
			end

			break

		end

	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'animations_sub', {
		title    = title,
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		ESX.UI.Menu.Open("default", GetCurrentResourceName(), "check_what_is_want", {
			title = title,
			align = "top-left",
			elements = {
				{label = "<font color=#00FF00>افعل الحركة</font>", value = "do_anim"},
				{label = "اضافة في <font color=#B200FF>❤️ المفضلة</font>", value = "add_in_favorite"}
			}
		}, function(data_check, menu_check)
			if data_check.current.value == "do_anim" then
				ClearPedTasks(GetPlayerPed(-1))
				local type = data.current.type
				local lib  = data.current.value.lib
				local anim = data.current.value.anim
				if type == 'scenario' then
					startScenario(anim)
				elseif type == 'dpemotes' then
					local emotesType = data.current.value.type
					local emotesName = data.current.value.name
					
					if emotesType == 'Shared' then
						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestPlayer ~= -1 and closestDistance <= 1.5 then
							TriggerServerEvent('esx_animations:ServerEmoteRequest', GetPlayerServerId(closestPlayer),emotesName,'Shared')
						else
							ESX.ShowNotification('<font color=red>لايوجد لاعب قريب منك')
						end
					elseif emotesType == 'Expressions' then
						OnEmotePlay(DP.Expressions[emotesName])
					elseif emotesType == 'Emotes' then
						OnEmotePlay(DP.Emotes[emotesName])
					elseif emotesType == 'Dances' then
						OnEmotePlay(DP.Dances[emotesName])
					elseif emotesType == 'Walks' then
						WalkMenuStart(emotesName)
					elseif emotesType == 'PropEmotes' then
						OnEmotePlay(DP.PropEmotes[emotesName])
					end
				else
					if type == 'attitude' then
						startAttitude(lib, anim)
					else
						startAnim(lib, anim)
					end
				end
			elseif data_check.current.value == "add_in_favorite" then
				menu_check.close()
				if data.current.type == 'scenario' then
					TriggerServerEvent("esx_wesam:addAniminDataBasefavorite", data.current.label, data.current.type, "", data.current.value.anim, "", "")
				elseif data.current.type == 'dpemotes' then
					TriggerServerEvent("esx_wesam:addAniminDataBasefavorite", data.current.label, data.current.type, "", "", data.current.value.name, data.current.value.type)
				else
					if type == 'attitude' then
						TriggerServerEvent("esx_wesam:addAniminDataBasefavorite", data.current.label, data.current.type, data.current.value.lib, data.current.value.anim, "", "")
					else
						TriggerServerEvent("esx_wesam:addAniminDataBasefavorite", data.current.label, data.current.type, data.current.value.lib, data.current.value.anim, "", "")
					end
				end
			end
		end, function(data_check, menu_check)
			menu_check.close()
		end)
	end, function(data, menu)
		menu.close()
	end)
end

-- Key Controls
-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlJustReleased(0, 170) and IsInputDisabled(0) and not isDead then
			local playerPed = PlayerPedId()
			if IsPedInAnyVehicle(playerPed, false) then
				ESX.ShowNotification('<font color=red>لايمكن استعمال الحركات داخل المركبة')
			else
				TriggerEvent("OpenAnimationsMenu")
			end			
		end

		if IsControlJustReleased(0, 73) and IsInputDisabled(0) and not isDead then
			ClearPedTasks(PlayerPedId())
		end

	end
end)



