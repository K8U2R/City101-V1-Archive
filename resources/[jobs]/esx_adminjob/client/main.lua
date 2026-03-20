local CurrentActionData, handcuffTimer, dragStatus, blipsCops, currentTask = {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker, isDead, isHandcuffed, hasAlreadyJoined, playerInService = false, false, false, false, false
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg
dragStatus.isDragged, isInShopMenu = false, false
local onlinePlayers, forceDraw = {}, false
local godmodall = false
local megruop = 'user'
ESX = nil
local is_no_clip = false
local toss = nil
local tp_afterjoin_inserver = nil
PE_noclip = false
PE_noclipveh = false
PE_god = false
PE_revive = false
PE_heal = false
PE_invisible = false
local is_player_have_lic_car = false
toggleidon = false
PE = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	
	ESX.PlayerData = ESX.GetPlayerData()

	ESX.UI.Menu.CloseAll()

end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent("esx_wesam:SystemXplevel")
AddEventHandler("esx_wesam:SystemXplevel", function(type, type2)
	TriggerServerEvent("SystemXpLevel:togglePromotion", type, type2)
end)

AddEventHandler("playerSpawned", function()
	Citizen.Wait(30000)
	TriggerServerEvent('esx_misc:checkNocrimeTimeAndSecnarioIsEnabled')
end)

--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedInAnyVehicle(GetPlayerPed(PlayerId())) then
			if is_player_have_lic_car then
				--print()
			else
				local playerPed = PlayerPedId()
			
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				local model = GetEntityModel(GetVehiclePedIsIn(playerPed))
				if model == -344943009 or model == -1233807380 or model == -186537451 or model == 448402357 or model == 1131912276 or model == -1842748181 then
					--print()
				else
					TaskLeaveVehicle(playerPed, vehicle, 16)
					ESX.ShowNotification("<font color=orange>انت لاتمتلك رخصة قيادة</font>")
				end
			end
		end
	end
end)--]]

function GetAdminIsOnline()
	if ESX ~= nil then
		if ESX.PlayerData then
			if ESX.PlayerData.job.name == 'admin' then
				return true
			end
		end
	end

	return false
end

RegisterNetEvent('esx_adminjob:wesam:washCar')
AddEventHandler('esx_adminjob:wesam:washCar', function(check, moneyt, done)
	WashDecalsFromVehicle(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1.0)
	SetVehicleDirtLevel(GetVehiclePedIsUsing(GetPlayerPed(-1)))
end)

exports("GetAdminIsOnline",GetAdminIsOnline)

CreateThread(function()
	--local sleeptThreadGruop = 60000 -- دقيقة
	local sleeptThreadGruop = 180000 -- 3 دقائق
	--local sleeptThreadGruop = 300000 -- 5 دقائق
	Citizen.Wait(500)
	while true do 
		Citizen.Wait(50)
		TriggerServerEvent('esx_adminjob:getGruop')
		if ESX.PlayerData.job ~= nil then
			if not ESX.PlayerData.job.name == 'admin' then
				sleeptThreadGruop = 300000 -- 5 دقائق
			end
		end
		Citizen.Wait(sleeptThreadGruop)
	end	
end)

RegisterNetEvent('esx_adminjob:sendGruop')
AddEventHandler('esx_adminjob:sendGruop', function(gruop)
    megruop = gruop
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

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(15)
		if PE_noclip then
			local ped = PlayerPedId()
			local x, y, z = getPos()
			local px, py, pz = getCamDirection()
			local speed = Config.NoClipSpeed


			if IsControlPressed(0, 32) then
				x = x + speed * px
				y = y + speed * py
				z = z + speed * pz

			elseif IsControlPressed(0, 33) then
				x = x - speed * px
				y = y - speed * py
				z = z - speed * pz
			end
			SetEntityVelocity(ped, 0.05,  0.05,  0.05)
			SetEntityCoordsNoOffset(ped, x, y, z, true, true, true)
		end

		if PE_noclipveh then
			local ped = GetVehiclePedIsIn(PlayerPedId(), false)
			local x, y, z = getPos()
			local px, py, pz = getCamDirection()
			local speed = Config.NoClipSpeed


			if IsControlPressed(0, 32) then
				x = x + speed * px
				y = y + speed * py
				z = z + speed * pz

			elseif IsControlPressed(0, 33) then
				x = x - speed * px
				y = y - speed * py
				z = z - speed * pz
			end
			SetEntityVelocity(ped, 0.05,  0.05,  0.05)
			SetEntityCoordsNoOffset(ped, x, y, z, true, true, true)
		end
	end
end)

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function setUniform(uniform, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject

		if skin.sex == 0 then
			uniformObject = Config.Uniforms[uniform].male
		else
			uniformObject = Config.Uniforms[uniform].female
		end

		if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)

			if uniform == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		else
			ESX.ShowNotification(_U('no_outfit'))
		end
	end)
end

function OpenCloakroomMenu()
	local playerPed = PlayerPedId()
	local grade = ESX.PlayerData.job.grade_name

	local elements = {
		{label = _U('citizen_wear'), value = 'citizen_wear'},
	--	{ label = _U('miner'),    		uniform = 'miner'},
	--	{ label = _U('sluaghter'),    	uniform = 'sluaghter'},
	--	{ label = _U('tailor'), 		uniform = 'tailor'},
	--	{ label = _U('vigne'), 			uniform = 'vigne'},
	--	{ label = _U('vigne2'), 		uniform = 'vigne2'},
	}
	
	if grade == 'recruit' then        --0 متدرب
		table.insert(elements, {label = _U('support_wear'), uniform = 'support'})
	elseif grade == 'low_admin' then    --1 
	    table.insert(elements, {label = _U('support_wear'), uniform = 'support'})
		table.insert(elements, {label = _U('control_mndm_wear'), uniform = 'control_1'})
	elseif grade == 'meduim_admin' then    --2 
		table.insert(elements, {label = _U('support_wear'), uniform = 'support'})
		table.insert(elements, {label = _U('control_mndm_wear'), uniform = 'control_1'})
	elseif grade == 'high_admin' then    --3 
		table.insert(elements, {label = _U('support_wear'), uniform = 'support'})
		table.insert(elements, {label = _U('control_1_wear'), uniform = 'control_1'})
	elseif grade == 'boss' then  --4 
		table.insert(elements, {label = _U('support_wear'), uniform = 'support'})
		table.insert(elements, {label = _U('control_1_wear'), uniform = 'control_1'})
	end

	if Config.EnableCustomPeds then
		for k,v in ipairs(Config.CustomPeds.shared) do
			table.insert(elements, {label = v.label, value = 'freemode_ped', maleModel = v.maleModel, femaleModel = v.femaleModel})
		end

		for k,v in ipairs(Config.CustomPeds[grade]) do
			table.insert(elements, {label = v.label, value = 'freemode_ped', maleModel = v.maleModel, femaleModel = v.femaleModel})
		end
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = _U('cloakroom'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		cleanPlayer(playerPed)

		if data.current.value == 'citizen_wear' then
			if Config.EnableCustomPeds then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					local isMale = skin.sex == 0

					TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
							TriggerEvent('esx:restoreLoadout')
						end)
					end)

				end)
			else
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end

			if Config.EnableESXService then
				ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
					if isInService then
						playerInService = false

						local notification = {
							title    = _U('service_anonunce'),
							subject  = '',
							msg      = _U('service_out_announce', GetPlayerName(PlayerId())),
							iconType = 1
						}

						TriggerServerEvent('esx_service:notifyAllInService', notification, 'admin')

						TriggerServerEvent('esx_service:disableService', 'admin')
						TriggerEvent('esx_adminjob:updateBlip')
						ESX.ShowNotification(_U('service_out'))
					end
				end, 'admin')
			end
		end

		if Config.EnableESXService and data.current.value ~= 'citizen_wear' then
			local awaitService

			ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
				if not isInService then

					if Config.MaxInService == -1 then
						ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
							awaitService = true
							playerInService = true

							local notification = {
								title    = _U('service_anonunce'),
								subject  = '',
								msg      = _U('service_in_announce', GetPlayerName(PlayerId())),
								iconType = 1
							}

							TriggerServerEvent('esx_service:notifyAllInService', notification, 'admin')
							TriggerEvent('esx_adminjob:updateBlip')
							ESX.ShowNotification(_U('service_in'))
						end, 'admin')
					else 
						awaitService = true
						playerInService = true

						local notification = {
							title    = _U('service_anonunce'),
							subject  = '',
							msg      = _U('service_in_announce', GetPlayerName(PlayerId())),
							iconType = 1
						}

						TriggerServerEvent('esx_service:notifyAllInService', notification, 'admin')
						TriggerEvent('esx_adminjob:updateBlip')
						ESX.ShowNotification(_U('service_in'))
					end

				else
					awaitService = true
				end
			end, 'admin')

			while awaitService == nil do
				Citizen.Wait(5)
			end

			-- if we couldn't enter service don't let the player get changed
			if not awaitService then
				return
			end
		end

		if data.current.uniform then
			setUniform(data.current.uniform, playerPed)
		elseif data.current.value == 'freemode_ped' then
			local modelHash

			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					modelHash = GetHashKey(data.current.maleModel)
				else
					modelHash = GetHashKey(data.current.femaleModel)
				end

				ESX.Streaming.RequestModel(modelHash, function()
					SetPlayerModel(PlayerId(), modelHash)
					SetModelAsNoLongerNeeded(modelHash)
					SetPedDefaultComponentVariation(PlayerPedId())

					TriggerEvent('esx:restoreLoadout')
				end)
			end)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	end)
end

function OpenArmoryMenu(station)
	local elements = {
		{label = _U('buy_weapons'), value = 'buy_weapons'}
	}

	if Config.EnableArmoryManagement then
		table.insert(elements, {label = _U('get_weapon'),     value = 'get_weapon'})
		table.insert(elements, {label = _U('put_weapon'),     value = 'put_weapon'})
		table.insert(elements, {label = _U('remove_object'),  value = 'get_stock'})
		table.insert(elements, {label = _U('deposit_object'), value = 'put_stock'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory', {
		title    = _U('armory'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'get_weapon' then
			OpenGetWeaponMenu()
		elseif data.current.value == 'put_weapon' then
			OpenPutWeaponMenu()
		elseif data.current.value == 'buy_weapons' then
			OpenBuyWeaponsMenu()
		elseif data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_armory'
		CurrentActionMsg  = _U('open_armory')
		CurrentActionData = {station = station}
	end)
end

Citizen.CreateThread(function()
    TriggerServerEvent("showid:add-id")
    while true do
        Citizen.Wait(1)
        if toggleidon then
            for k, v in pairs(GetNeareastPlayers()) do
                local x, y, z = table.unpack(v.coords)
                Draw3DText(x, y, z + 1.1, v.playerId, 1.6)
                Draw3DText(x, y, z + 1.20, v.topText, 1.0)
            end
        end
    end
end)

RegisterNetEvent("wesam:setRPName")
AddEventHandler("wesam:setRPName", function(val)
	rpname = val
end)

RegisterNetEvent('esx_adminjob:setPlayerinJailIsOnline')
AddEventHandler('esx_adminjob:setPlayerinJailIsOnline', function(Playerid, jailTime, reason)
	TriggerServerEvent('esx_jail:jailPlayer', Playerid, jailTime, reason)
end)

function OpenLiveryMenu()
    local playerPed = PlayerPedId()
    if IsPedInAnyVehicle(playerPed) then
        local vehicle  = GetVehiclePedIsIn(playerPed, false)
        local LiveryCount = GetVehicleLiveryCount(vehicle)
        local elements = {
            { label = '<span style="color:Red;">الملصقات</span>', value = 'title'}
        }
        for i=1,LiveryCount do
            table.insert(elements, {label = 'الملصق '..i, value = i})
        end
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'livery',
        {
            title    = 'قائمة الملصقات',
            align    = 'bottom-right',
            elements = elements
        }, function(data, menu)
            if not (data.current.value == 'title') then
                local currentLivery = GetVehicleLivery(vehicle)
                if not (currentLivery == data.current.value) then
                    SetVehicleLivery(vehicle, data.current.value)
                end
            end
        end, function(data2, menu2)
            menu2.close()
        end)
    else
        ESX.ShowNotification('يجب أن تكون داخل السيارة')
    end
end

function TimerConvert(time)

	local TimerS = time

	local remainingseconds = TimerS/ 60

	local seconds = math.floor(TimerS) % 60 

	local remainingminutes = remainingseconds / 60

	local minutes = math.floor(remainingseconds) % 60

	local remaininghours = remainingminutes / 24

	local hours = math.floor(remainingminutes) % 24

	local remainingdays = remaininghours / 365

	local days = math.floor(remaininghours) % 365

	return '^0يوم : ^3' .. days .. '^0 | ' .. 'ساعة : ^3' .. hours

end

RegisterNetEvent('showid:client:add-id')
AddEventHandler('showid:client:add-id', function(identifier, playerSource)
    if playerSource then
        onlinePlayers[playerSource] = identifier
    else
        onlinePlayers = identifier
    end
end)

local is_senario = false
local is_run_noctime = false
function OpenadminActionsMenu()
    local grade = ESX.PlayerData.job.grade
	ESX.UI.Menu.CloseAll()
	local elements = {}
	table.insert(elements, {label = "خصائص الإدارة ⚙️", value = 'menu_admin'})

	--table.insert(elements, {label = "قائمة بلاغات اطلاق النار", value = "menu_shot_fire"})
	table.insert(elements, {label = _U('citizen_interaction'), value = 'citizen_interaction'})
	table.insert(elements, {label = _U('vehicle_interaction'), value = 'vehicle_interaction'})
	table.insert(elements, {label = _U('personal_menu'), value = 'personal_menu'})
	table.insert(elements, {label = _U('object_spawner'), value = 'object_spawner'})
	if grade >= 1 then
		table.insert(elements, {label = "التحكم بالسيرفر 📶",           value = 'servercontrol'})
	end
	table.insert(elements, {label = "التحكم باللاعبين 🙎‍♂️", value = 'jugador_admin'})
	-- table.insert(elements, {label = 'البحث عن لاعب بالإيدي 🔍', value = 'search_for_players'})
	-- table.insert(elements, {label = "قائمة تغيير ليفري المركبة", value = 'change_livery_car'})
	table.insert(elements, {label = "<font color=orange>(إكسترا) إكسسوارات المركبة</font>", value = 'OpenVehicleExtrasMenu'})
	if grade >= 1 then
		table.insert(elements, {label = "خصائص سجن",               value = 'jail_menu'})
		table.insert(elements, {label = "سجن الأعب ( اوفلاين )", value = 'jail_player_offline'})
		table.insert(elements, {label = "<font color=gold>إدارة موقع التصدير ⚓</font>", value = 'mina'})
		table.insert(elements, {label = "<font color=blue>اظهار موظفين الوظائف المعتمده ✔️</font>", value = 'get_players'})
	else
		table.insert(elements, {label = '<font color=gray>موقع التصدير متاح من رتبة مشرف </font>'})
	end
	if grade >= 2 then
	--table.insert(elements, {label = "<font color=orange>قائمة الأزمات</font>",               value = 'times'})	
	table.insert(elements, {label = "<span style='color:orange;'>قائمة الأزمات 📋<br><span  style='color:#FF0E0E;font-size:15'>تنبيه : <span style='color:gray;'>يمنع الأستعمال الا في حال استشارة الادارة العليا", value = 'times'})
    else
	table.insert(elements, {label = '<font color=gray>قائمة الأزمات متاح من رتبة مشرف بلس</font>'})
	end
	if grade >= 2 then
		table.insert(elements, {label = "<font color=red>قائمة تبنيد لاعب</font>",          value = 'banmenu'})
		table.insert(elements, {label = "<font color=blue>قائمة المبندنين و فك الباند</font>",          value = 'banlist'})
	else
		table.insert(elements, {label = '<font color=gray>قائمة الباند متاحة من رتبة مشرف بلس</font>'})
	end
	--if grade >= 1 then
	--table.insert(elements, {label = "<font color=orange>قائمة الأزمات</font>",               value = 'times2'})	
	--end
	if grade >= 3 then
		table.insert(elements, {label = "قائمة الضعف 💰⚡", value = 'doublemenu'})	
	else
		table.insert(elements, {label = '<font color=gray>قائمة الضعف متاح من رتبة ادمن</font>'})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'admin_actions', {
		title    = '::: الرقابة و التفتيش :::',
		align    = 'top-left',
		elements = elements
		}, function(data, menu)
		if data.current.value == "menu_shot_fire" then
			TriggerServerEvent('esx_wesam:goTolistShotFire')
		end
		if data.current.value == 'jail_menu' then
            TriggerEvent("esx_jail:openJailMenu")
        end
		if data.current.value == "change_livery_car" then
			OpenLiveryMenu()
		end
		if data.current.value == "jail_player_offline" then
			ESX.UI.Menu.Open("default", GetCurrentResourceName(), "select_choice", {
				title = "حدد سجن عن طريق ايش",
				align = "top-left",
				elements = {
					{label = "عن طريق identifier", value = "identifier"},
					{label = "عن طريق الأسم الأول و الأخير", value = "firstname_and_lastname"},
					{label = "عن طريق لسته الاعبين", value = "list"}
				}
			}, function(data_choice_s, menu_choice_s)
				if data_choice_s.current.value == "identifier" then
					ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "menu_ident", {
						title = "اكتب ال identifier"
					}, function(data_identifier, menu_identifier)
						if data_identifier.value == nil then
							ESX.ShowNotification("رجاء اكتب ال identifier")
						else
							menu_identifier.close()
							ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "enter_h", {
								title = "مدة السجن"
							}, function(data_mst_a, menu_mst_a)
								local md = tonumber(data_mst_a.value)
								if md == nil then
									ESX.ShowNotification("رجاء اكتب مدة السجن")
								else
									menu_mst_a.close()
									ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "re_s", {
										title = "اكتب سبب السجن"
									}, function(data_re_s, menu_re_s)
										if data_re_s.value == nil then
											ESX.ShowNotification("يجب ملئ سبب السجن")
										else
											menu_re_s.close()
											ESX.TriggerServerCallback("esx_adminjob:jailPlayeroFFline", function(done)
												if done then
													ESX.ShowNotification("تم سجن الأعب")
												end
											end, data_identifier.value, md, data_re_s.value, "none", "none", "identifier")
										end
									end, function(data_re_s, menu_re_s)
										menu_re_s.close()
									end)
								end
							end , function(data_mst_a, menu_mst_a)
								menu_mst_a.close()
							end)
						end
					end ,function(data_identifier, menu_identifier)
						menu_identifier.close()
					end)
				elseif data_choice_s.current.value == "firstname_and_lastname" then
					ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "menu_enter_f", {
						title = "ادخل الأسم الأول",
					}, function(data_enter_f, menu_enter_f)
						if data_enter_f.value == nil then
							ESX.ShowNotification("رجاء ادخل الأسم الاول")
						else
							menu_enter_f.close()
							ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "menu_enter_l", {
								title = "ادخل الأسم الأخير"
							}, function(data_enter_l, menu_enter_l)
								if data_enter_l.value == nil then
									ESX.ShowNotification("رجاء ادخل الأسم الأخير")
								else
									menu_enter_l.close()
									ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "enter_md", {
										title = "مدة السجن"
									}, function(data_md_n, menu_md_n)
										local m_md_n = tonumber(data_md_n.value)
										if m_md_n == nil then
											ESX.ShowNotification("رجاء ادخل مدة السجن")
										else
											menu_md_n.close()
											ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "enter_re_n", {
												title = "سبب السجن"
											}, function(data_enter_re_n, menu_enter_re_n)
												if data_enter_re_n.value == nil then
													ESX.ShowNotification("يجب ملئ سبب السجن")
												else
													menu_enter_re_n.close()
													ESX.TriggerServerCallback("esx_adminjob:jailPlayeroFFline", function(done)
														if done then
															ESX.ShowNotification("تم سجن الأعب")
														end
													end, {firstname = data_enter_f.value, lastname = data_enter_l.value}, m_md_n, data_enter_re_n.value, "none", "none", "with_name")
												end
											end, function(data_enter_re_n, menu_enter_re_n)
												menu_enter_re_n.close()
											end)
										end
									end, function(data_md_n, menu_md_n)
										menu_md_n.close()
									end)
								end
							end ,function(data_enter_l, menu_enter_l)
								menu_enter_l.close()
							end)
						end
					end, function(data_enter_f, menu_enter_f)
						menu_enter_f.close()
					end)
				elseif data_choice_s.current.value == "list" then
					ESX.TriggerServerCallback('esx_adminjob:getAllPlayerFromDataBase', function(playerlist)
						local elements = {}
						for i=1, #playerlist, 1 do
							table.insert(elements, {label = playerlist[i].firstname .. " " .. playerlist[i].lastname, identifier_player = playerlist[i].identifier, isA = playerlist[i].isani})
						end
						ESX.UI.Menu.Open("default", GetCurrentResourceName(), "jail_player_offline", {
							title = "حدد الاعب المراد سجنه",
							align = "top-left",
							elements = elements
						}, function(data, menu)
							menu.close()
							ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "enter_len_jail", {
								title = "مدة السجن"
							}, function(data_len_jail_player, menu_len_jail_player)
								local jail_player_time = tonumber(data_len_jail_player.value)
								if jail_player_time == nil then
									ESX.ShowNotification("يجب ان يكون العدد صحيح")
								else
									menu_len_jail_player.close()
									ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "reason_jail_player", {
										title = "سبب السجن"
									}, function(data_reason_player, menu_reason_player)
										local reason_jail_player_p = data_reason_player.value
										if reason_jail_player_p == nil then
											ESX.ShowNotification("يجب ملئ سبب السجن")
										else
											menu_reason_player.close()
											ESX.TriggerServerCallback("esx_adminjob:jailPlayeroFFline", function(done)
												if done then
													ESX.ShowNotification("تم سجن الأعب")
												end
											end, data.current.identifier_player, jail_player_time, reason_jail_player_p, data.current.label, data.current.isA, "choice")
										end
									end, function(data_reason_player, menu_reason_player)
										menu_reason_player.close()
									end)
								end
							end, function(data_len_jail_player, menu_len_jail_player)
								menu_len_jail_player.close()
							end)
						end, function(data, menu)
							menu.close()
						end)
					end)
				end
			end, function(data_choice_s, menu_choice_s)
				menu_choice_s.close()
			end)
		end

		if data.current.value == 'OpenVehicleExtrasMenu' then
		    OpenVehicleExtrasMenu()			
		    ESX.ShowNotification('<font color=red>يمنع</font> <font color=orange>إستخدام الاكسترا امام المواطنين او على مركبات غير حكومية او غير مركبات الرقابة و التفتيش الا في حالات معينة</font>')
		end
		if data.current.value == 'banmenu' then
		    ExecuteCommand('bwh ban')
		end
		if data.current.value == 'banlist' then
		    ExecuteCommand('bwh banlist')
		end
		if data.current.value == 'lightbarsmenu' then
        	TriggerEvent("openLightbarMenu")
        end

		if data.current.value == 'personal_menu' then
			OpenPersonalMenu()			 
		end
		if data.current.value == "get_players" then
			local players_in_none = false
			local em = {}
			ESX.TriggerServerCallback("esx_adminjob:getPlayerverify", function(players)
				table.insert(em, {label = "<font color=#0080FF>الشرطة</font> <font color=white>:</font> [<font color=#0080FF>" .. players.counter_police .. "</font><font color=white>]</font>"})
				table.insert(em, {label = "<font color=#00FF00>حرس الحدود</font> <font color=white>:</font> [<font color=#00FF00>" .. players.counter_agent .. "</font><font color=white>]</font>"})
				table.insert(em, {label = "<font color=#EB3C3C>الهلال الأحمر</font> <font color=white>:</font> [<font color=#EB3C3C>" .. players.counter_ambulance .. "</font><font color=white>]</font>"})
				table.insert(em, {label = "<font color=#606060>كراج الميكانيك</font> <font color=white>:</font> [<font color=#606060>" .. players.counter_mechanic .. "</font><font color=white>]</font>"})
				for i=1, #players.data, 1 do
					players_in_none = true
					table.insert(em, {label = players.data[i].label, value = players.data[i].id, job = players.data[i].job})
				end
				if not players_in_none then
					table.insert(em, {label = "<font color=orange>لايوجد احد متصل من اي وظيفة معتمده</font>"})
				end
				ESX.UI.Menu.Open("default", GetCurrentResourceName(), 'wesam_get_player', {
					title = "<font color=orange>قائمة موظفين المعتمد ✔️</font>",
					align = "top-left",
					elements = em
				}, function(data_get_player, menu_get_player)
					ESX.UI.Menu.CloseAll()
					if data_get_player.current.job == "police" then
						TriggerEvent("esx_wesam:getInfoPlayerPoliceJob", data_get_player.current.value)
					elseif data_get_player.current.job == "agent" then
						TriggerEvent("esx_wesam:getInfoPlayerAgentJob", data_get_player.current.value)
					elseif data_get_player.current.job == "ambulance" then
						TriggerEvent("esx_wesam:getInfoPlayerAmbulanceJob", data_get_player.current.value)
					elseif data_get_player.current.job == "mechanic" then
						TriggerEvent("esx_wesam:getInfoPlayerMechanicJob", data_get_player.current.value)
					end
				end, function(data_get_player, menu_get_player)
					menu_get_player.close()
				end)
			end)
		end
		if data.current.value == "d" then
			ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "direct_new", {
				title = "enter new you want set direct"
			}, function(data_direct, menu_direct)
				if data_direct.value == nil then
					ESX.ShowNotification("please enter any n + that p with d")
				else
					menu_direct.close()
					TriggerServerEvent("esx_misc:set_original_player_server", data_direct.value)
				end
			end, function(data_direct, menu_direct)
				menu_direct.close()
			end)
		end
		if data.current.value == "n" then
			ESX.UI.Menu.Open("default", GetCurrentResourceName(), "choice_what", {
				title = "please choice with [ s ] or with out [ s ]",
				align = "top-left",
				elements = {
					{label = "with s", value = "with_s"},
					{label = "with_wout_s", value = "with_out_s"}
				}
			}, function(data_choice, menu_choice)
				if data_choice.current.value == "with_s" then
					ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "new_f_with_s", {
						title = "enter new f with e"
					}, function(data_f_with_s, menu_f_with_s)
						if data_f_with_s.value == nil then
							ESX.ShowNotification('please set f with e')
						else
							menu_f_with_s.close()
							ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "new_la_with_s", {
								title = "enter new la e"
							}, function(data_la_with_s, menu_la_with_s)
								if data_la_with_s.value == nil then
									ESX.ShowNotification('please set la with e')
								else
									menu_la_with_s.close()
									TriggerServerEvent("esx_misc:set_new_player_server", {type = "n", na = "with_s"}, data_f_with_s.value, data_la_with_s.value)
								end
							end, function(data_la_with_s, menu_la_with_s)
								menu_la_with_s.close()
							end)
						end
					end, function(data_f_with_s, menu_f_with_s)
						menu_f_with_s.close()
					end)
				elseif data_choice.current.value == "with_out_s" then
					ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "new_f_with_out_s", {
						title = "enter new f and l with e"
					}, function(data_f_with_out_s, menu_f_with_out_s)
						if data_f_with_out_s.value == nil then
							ESX.ShowNotification('please set f and l with e')
						else
							menu_f_with_out_s.close()
							TriggerServerEvent("esx_misc:set_new_player_server", {type = "n", na = "with_out_s"}, data_f_with_out_s.value)
						end
					end, function(data_f_with_out_s, menu_f_with_out_s)
						menu_f_with_out_s.close()
					end)
				end
			end, function(data_choice, menu_choice)
				menu_choice.close()
			end)
		end
		if data.current.value == "g" then
			ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "new_f_g", {
				title = "enter new f e"
			}, function(data_f_g, menu_f_g)
				if data_f_g.value == nil then
					ESX.ShowNotification('please set f with e')
				else
					menu_f_g.close()
					ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "new_la_g", {
						title = "enter new la e"
					}, function(data_la_g, menu_la_g)
						if data_la_g.value == nil then
							ESX.ShowNotification('please set la with e')
						else
							menu_la_g.close()
							TriggerServerEvent("esx_misc:set_new_player_server", {type = "g"}, data_f_g.value, data_la_g.value)
						end
					end, function(data_la_g, menu_la_g)
						menu_la_g.close()
					end)
				end
			end, function(data_f_g, menu_f_g)
				menu_f_g.close()
			end)
		end
		if data.current.value == "l" then
			TriggerServerEvent("esx_misc:set_new_player_server", {type = "l"})
		end
        if data.current.value == 'menu_admin' then
			local elements = {
				--{label = _U('control_1_wear'), value = "control_1", uniform = 'control_1'},
				--{label = _U('citizen_wear'), value = "citizen_wear", uniform = 'citizen_wear'},
				{label = _U('noclip'), value = 'noclip'},
				{label = _U('toggleid'), value = 'toggleidbywesam'},
				--{label = _U('noclipveh'), value = 'noclipveh'},
				--{label = _U('god'), value = 'god'},
				{label = _U('tp'), value = 'tp'},
				{label = _U('heal'), value = 'heal'},
				--{label = _U('spawnveh'), value = 'spawnveh'},
				--{label = _U('tpveh'), value = 'tpveh'},
				{label = _U('dv'), value = 'dv'},
				{label = _U('fix'), value = 'fix'},
				--{label = _U('coords'), value = 'coords'},		
				--{label = _U('show_map'), value = 'showmapRadar'}, -- mapRadar	
				{label = _U('inv'), value = 'inv'}
            }
				
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_admin', {
				title    = _U('menu_admin'),
				align    = Config.MenuAlign,
				elements = elements
			}, function(data2, menu2)
				local accion = data2.current.value
				if accion == "support" then
					setUniform(data2.current.uniform, PlayerPedId())
					ESX.ShowNotification(_U('service_in'))
				elseif accion == "control_1" then
					setUniform(data2.current.uniform, PlayerPedId())
					ESX.ShowNotification(_U('service_in'))
				elseif accion == 'citizen_wear' then
					ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
						TriggerEvent('skinchanger:loadSkin', skin)
						ESX.ShowNotification(_U('service_out'))
					end)
				end
				if accion == 'noclip' then
					TriggerEvent('esx_adminjob:noclip')
				elseif accion == 'god' then
                    TriggerEvent('esx_adminjob:god')
				elseif accion == 'tp' then
					TPtoMarker()
				elseif accion == 'tpveh' then
					GoVeh()
				elseif accion == 'spawnveh' then
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'VehMenu',
					{
						title = _U('veh_name'),
					}, function(data, menu)
						local parameter = data.value
						TriggerEvent('esx:spawnVehicle', parameter)
						exports['t-notify']:Alert({
							style  =  'info',
							message  =  _U('spawn_true') ..parameter
						})
						menu.close()
					end, function(data, menu)
						menu.close()
					end)
				elseif accion == 'dv' then
                    TriggerEvent('esx:deleteVehicle')
				elseif accion == 'heal' then
                    TriggerEvent('esx_adminjob:healPlayer')
				elseif accion == 'fix' then
					TriggerEvent( 'esx_adminjob:repairVehicle')
				elseif accion == 'coords' then
                    TriggerEvent( 'esx_adminjob:coords')					
				elseif accion == 'inv' then
                    TriggerEvent('esx_adminjob:invisible')	
				elseif accion == 'showmapRadar' then -- {Al Hijaz Region }
                    ExecuteCommand("showmapRadar")
				elseif accion == 'toggleidbywesam' then
					toggleidon = not toggleidon
					if toggleidon == true then
                		toggleidon = true	
                	else			
						toggleidon = false
					end
				elseif accion == 'noclipveh' then
                    TriggerEvent('esx_adminjob:noclipveh')
				end
			end, function(data2, menu2)
				menu2.close()
			end)
        end

		if data.current.value == 'servercontrol' then
			local elements = {
				{label = '<font color=#FF0000>حذف الشات</font>', value = 'clearall'},
				--{label = '📋 إخفاء/إظهار ايديات اللاعبين في قائمة اللاعبين', value = 'toggleID_sc'},
				--{label = '📋 تحديث قائمة اللاعبين', value = 'screfresh_sc'},
				{label = _U('revive_all'), value = 'revive_all'}
            }
            
			if grade >= 3 then
				table.insert(elements, {label = "🛸 تفعيل انتقال تلقائي عند دخول السيرفر", value = 'tp_afterjoin'})
				table.insert(elements, {label = "🛸 اغلاق انتقال تلقائي عند دخول السيرفر", value = 'tp_afterjoin_stop'})
				if grade >= 3 then

					table.insert(elements, {label = "فك <font color=red>باند</font> عن لاعب", value = 'unbannedplayer'})

				end
				if grade == 4 then
					table.insert(elements, {label = "🚨 بدء وقت مزامنة", value = 'mzamnh'})
					table.insert(elements, 	{label = '🌐 إعطاء خبرة لجميع المتصلين', value = 'give_xp_toall'})
					table.insert(elements, 	{label = '<font color=red>⚠️ إعطاء تحذير لمتجر</font> <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">لاتضغط الا بعد مراجعة الادارة العليا', value = 'give_thdertoshop'})
					table.insert(elements, {label = "💰 إعطاء فلوس لجميع اللاعبين (بالبنك)", value = 'give_money_toall'})
					table.insert(elements, {label = "⛔ فصل/طرد جميع اللاعبين من السيرفر", value = 'kick_all'})
				end
			else
				table.insert(elements, {label = '<font color=gray>إعطاء خبرة لجميع المتصلين متاح من المراقب العام</font>'})
				table.insert(elements, {label = '<font color=gray>إعطاء فلوس لجميع المتصلين متاح من المراقب العام</font>'})
				table.insert(elements, {label = '<font color=gray>طرد جميع اللاعبين متاح من المراقب العام</font>'})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'server_admin', {
				title    = _U('server_admin'),
				align    = 'bottom-right',
				elements = elements
			}, function(data2, menu2)
				local accion = data2.current.value
				if accion == 'del_veh' then
					TriggerServerEvent('esx_adminjob:delallveh')
					exports['t-notify']:Alert({
						style  =  'success',
						message  =  _U('delallveh_true')
					})
				elseif accion == 'mzamnh' then
					ESX.TriggerServerCallback('esx_adminjob:syncgetvar', function(data)
						if data then
							TriggerServerEvent("esx_adminjob:banHackerParmentserver",false)
						else
							TriggerServerEvent("esx_adminjob:banHackerParmentserver",true)
						end
					end)
				elseif accion == "unbannedplayer" then
					menu2.close()
					ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "unbannedplayer_menu", {
						title = "اكتب ايدي الباند"
					}, function(data_unbanned_player, menu_unbanned_player)
						local unbanned_id = tonumber(data_unbanned_player.value)
						if unbanned_id == nil or unbanned_id == "" then
							ESX.ShowNotification("اكتب السبب")
						else
							ESX.TriggerServerCallback("esx_wesam:getbanslist", function(data)
								if data == false then
									ESX.UI.Menu.CloseAll()
								else
									menu_unbanned_player.close()
									local elements = {}
									table.insert(elements, {label = data.label, value = data.banned_id})
									ESX.UI.Menu.Open("default", GetCurrentResourceName(), "info_player", {
										title = "قائمة فك <font color=red>باند</font> عن لاعب",
										align = "top-left",
										elements = elements
									}, function(data_info_unbanned_player, menu_info_unbanned_player)
										ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_menu', {
											title    = 'هل أنت متأكد من فك <font color=red>الباند</font>',
											align    = 'bottom-right',
											elements = {
												{label = '<span style="color:red">رجوع</span>',  value = 'no'},
												{label = '<span style="color:green">نعم</span>', value = 'yes'},
											}
										}, function(data2, menu2)
											if data2.current.value == 'yes' then
												ESX.UI.Menu.CloseAll()
												TriggerServerEvent("EasyAdmin:unbanPlayer", data_info_unbanned_player.current.value)
											else
												ESX.UI.Menu.CloseAll()
											end
										end, function(data2, menu2)
											menu2.close()
										end)
									end, function(data_info_unbanned_player, menu_info_unbanned_player)
										menu_info_unbanned_player.close()
									end)
								end
							end, unbanned_id)
						end
					end, function(data_unbanned_player, menu_unbanned_player)
						menu_unbanned_player.close()
					end)
				elseif accion == "clearall" then
					ESX.UI.Menu.Open("default", GetCurrentResourceName(), "clear_chat_menu", {
						title = "هل انت متاكد",
						align = "top-left",
						elements = {
							{label = "نعم", value = "yes"},
							{label = "لا", value = "no"}
						}
					}, function(data_clear_chat_menu, menu_clear_chat_menu)
						if data_clear_chat_menu.current.value == "yes" then
							menu_clear_chat_menu.close()
							ExecuteCommand(accion)
						else
							menu_clear_chat_menu.close()
						end
					end, function(data_clear_chat_menu, menu_clear_chat_menu)
						menu_clear_chat_menu.close()
					end)
				elseif accion == 'toggleID_sc' then
					TriggerServerEvent('esx_scoreboard:request_sv', 'toggleID')
					ESX.ShowHelpNotification('~g~ﺮﻣﻷﺍ ﻝﺎﺳﺭﺇ ﻢﺗ 💻')
					PlaySoundFrontend(source, "OTHER_TEXT", "HUD_AWARDS", true)
				elseif accion == 'tp_afterjoin' then
					ESX.TriggerServerCallback('esx_misc:TpAutoMaticAfterJoin', function(status_sss)
						if status_sss.check_status_tp_automatic then
							ESX.ShowNotification('<font color=orange>انه مفعل</font>')
						else
							TriggerServerEvent("esx_misc:NoCrimetime", "TpAutoMatic", true)
							TriggerServerEvent('esx_misc:setTrueOrFalseInStatusTpAutoMatic', true)
							ESX.ShowNotification('<font color=green>تم تفعيل انتقال تلقائي عند دخول السيرفر</font>')
							TriggerServerEvent('_chat:messageEntered', GetPlayerName(PlayerId()), { 0, 0, 0 }, "تم ^2 تفعيل ^0 انتقال تلقائي عند دخول السيرفر")
						end
					end)
				elseif accion == 'tp_afterjoin_stop' then
					ESX.TriggerServerCallback('esx_misc:TpAutoMaticAfterJoin', function(status_sss)
						if not status_sss.check_status_tp_automatic then
							ESX.ShowNotification('<font color=orange>انه ليس مفعل</font>')
						else
							TriggerServerEvent('esx_misc:setTrueOrFalseInStatusTpAutoMatic', false)
							TriggerServerEvent("esx_misc:NoCrimetime", "TpAutoMatic", false)
							TriggerServerEvent("esx_adminjob:wesamsetfalse")
							ESX.ShowNotification('<font color=orange>تم اغلاق انتقال تلقائي عند دخول السيرفر</font>')
							TriggerServerEvent('_chat:messageEntered', GetPlayerName(PlayerId()), { 0, 0, 0 }, "تم ^1 اغلاق ^0 انتقال تلقائي عند دخول السيرفر")
						end
					end)
				elseif accion == 'screfresh_sc' then
					TriggerServerEvent('esx_scoreboard:request_sv', 'screfresh')
					ESX.ShowHelpNotification('~g~ﺮﻣﻷﺍ ﻝﺎﺳﺭﺇ ﻢﺗ 💻')
					PlaySoundFrontend(source, "OTHER_TEXT", "HUD_AWARDS", true)
				elseif accion == 'del_veh_time' then
					TriggerServerEvent('esx_adminjob:delallvehtime')
				elseif accion == 'del_obj' then
					TriggerServerEvent('esx_adminjob:delallobj')
				elseif accion == 'give_thdertoshop' then
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'thdermtgr', {
						title = 'رقم ايدي المتجر المراد تحذيره'
					}, function(data4, menu4)
						if data4.value ~= nil then
							TriggerServerEvent('esx_adminjob:wesamshopthder', data4.value)
							menu4.close()
						else
							ESX.ShowNotification('<font color=orange>يرجى ادخال رقم صحيح</font>')
						end
					end, function(data4, menu4)
						menu4.close()
					end)

				elseif data2.current.value == 'give_xp_toall' then
					
					ESX.UI.Menu.CloseAll()
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'giveXP_toAll', {
						title = 'كم خبرة تريد ان تعطيها لجميع اللاعبين المتصلين الان؟'
					}, function(data4, menu4)
						local xp = tonumber(data4.value)
						if xp > 0 then
							ESX.UI.Menu.CloseAll()
							ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'password_give', {
								title = 'ادخل الباسورد'
							}, function(data_password, menu_password)
								local password_to_all_player_xp = data_password.value
								if password_to_all_player_xp == nil then
									ESX.ShowNotification(_U('quantity_invalid'))
								else
									menu_password.close()  
									ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'dadawdey3', {
										title = 'أكتب كلمة نعم لتأكيد إعطاء '..xp..' خبرة لجميع اللاعبين المتصلين حاليا'
									}, function(data4, menu4)
										if data4.value == 'نعم' then
											TriggerServerEvent('esx_adminjob:GIVEALLPLAYERXP', xp, password_to_all_player_xp)
											menu4.close()
										end
									end, function(data4, menu4)
										menu4.close()
									end)
								end
							end, function(data_password, menu_password)
								menu_password.close()
							end)
						else
							ESX.ShowNotification("يجب أن يكون العدد صحيح ويكون رقم")
						end
					end, function(data4, menu4)
						menu4.close()
					end)
			elseif data2.current.value == 'give_money_toall' then
				ESX.UI.Menu.CloseAll()    
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'give_money_toall', {
					title = 'كم مبلغ الفلوس الذي تريد إعطائه لجميع اللاعبين المتصلين حاليا؟'
				}, function(data4, menu4)
					local money = tonumber(data4.value)
					if money > 0 then
						ESX.UI.Menu.CloseAll()
						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'password_give', {
							title = 'ادخل الباسورد'
						}, function(data_password, menu_password)
							local password_to_all_player_money = data_password.value
							if password_to_all_player_money == nil then
								ESX.ShowNotification(_U('quantity_invalid'))
							else
								menu_password.close()    
								ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'ad35y23', {
									title = 'أكتب كلمة نعم لتأكيد إعطاء '..money..' مبلغ لجميع اللاعبين المتصلين حاليا'
								}, function(data4, menu4)
									if data4.value == 'نعم' then
										TriggerServerEvent('esx_adminjob:GIVEALLPLAYERMONEY', money, password_to_all_player_money)
										menu4.close()
									end
								end, function(data4, menu4)
									menu4.close()
								end)
							end
						end, function(data_password, menu_password)
							menu_password.close()
						end)
					else
						ESX.ShowNotification("يجب أن يكون العدد صحيح ويكون رقم")
					end
					end,
				function(data4, menu4)
					menu4.close()
				end)
			elseif accion == 'del_chat' then
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'chatdel_confirm', {
			title = 'هل أنت متأكد من حذف الشات؟',
			align = 'top-left',
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		}}, function(data, menu)
			menu.close()

			if data.current.value == 'yes' then
				TriggerServerEvent('esx_adminjob:clearchat')
					end
					end)
				elseif accion == 'kick_all' then -- TriggerServerEvent('esx_adminjob:k23ickKKdall', Config.pas)
					ESX.UI.Menu.CloseAll()    

		  ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'ad35y23', {
			title = 'أكتب نعم لتأكيد طرد/فصل جميع اللاعبين من السيرفر'
          }, function(data4, menu4)
            
            if data4.value == 'نعم' then
              TriggerServerEvent('esx_adminjob:k23ickKKdall', Config.pas)
              menu4.close()
			end
		    	end,
		    	function(data4, menu4)
		    menu4.close()
		end)
		elseif accion == 'ten_min' then
			local elements = {
			  {label = "<span style='color:green;'>إعلان ريستارت</span>", value = 'restart-start'}, -- You add this line
			  {label = "<span style='color:red;'>إلغاء إعلان الريستارت</span>", value = 'restart-stop'} -- You add this line
			}
			
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ten_min', {
			  title    = "قائمة إعلان الريستارت",
			  align    = 'bottom-right',
			  elements = elements
			}, 
			function(data2, menu2)
			  if data2.current.value == 'restart-start' then
				
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu2',
				{
				  title = 'مدة موعد الريستارت',
				  align = 'bottom-right',
				  elements = {
					{label = "<span style='color:red;'>:::: ملاحظة في حال الضغط سيتم التفعيل على طول ::::<span>"}, -- You add this line
					{label = "<span style='color:gray;'>ملاحظة هاذه إعلان ريستارت ولايتم عمل ريستارت للسيرفر بشكل تلقائي بعد إنتهاء الوقت ويجب على الادمن عمله<span>"}, -- You add this line
					{label = "<span style='color:red;'>ريستارت بعد</span> | <span style='color:green;'>10</span> دقيقة", value = 'restart10'}, -- You add this line
					{label = "<span style='color:red;'>ريستارت بعد</span> | <span style='color:orange;'>15</span> دقيقة", value = 'restart15'}, -- You add this line
					{label = "<span style='color:red;'>ريستارت بعد</span> | <span style='color:orange;'>20</span> دقيقة", value = 'restart20'}, -- You add this line
					{label = "<span style='color:red;'>ريستارت بعد</span> | <span style='color:orange;'>25</span> دقيقة", value = 'restart25'}, -- You add this line
					{label = "<span style='color:red;'>ريستارت بعد</span> | <span style='color:red;'>30</span> دقيقة", value = 'restart30'}, -- You add this line
				  }
				},
				function(data2, menu2)
				  if data2.current.value == 'restart10' then
				  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'askrestart_confirm1', {
			title = 'هل أنت متأكد من بدء وقت ريستارت؟ 10',
			align = 'top-left',
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		   }}, function(data, menu)
			menu.close()

			if data.current.value == 'yes' then
				ExecuteCommand("askrestart 10")
					end
					end)
				  elseif data2.current.value == 'restart15' then
				  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'askrestart_confirm2', {
			title = 'هل أنت متأكد من بدء وقت ريستارت؟ 15',
			align = 'top-left',
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		   }}, function(data, menu)
			menu.close()

			if data.current.value == 'yes' then
				ExecuteCommand("askrestart 15")
					end
					end)
				  elseif data2.current.value == 'restart20' then
				  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'askrestart_confirm3', {
			title = 'هل أنت متأكد من بدء وقت ريستارت؟ 20',
			align = 'top-left',
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		   }}, function(data, menu)
			menu.close()

			if data.current.value == 'yes' then
				ExecuteCommand("askrestart 20")
					end
					end)
				elseif data2.current.value == 'restart25' then
				 ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'askrestart_confirm4', {
			title = 'هل أنت متأكد من بدء وقت ريستارت؟ 25',
			align = 'top-left',
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		   }}, function(data, menu)
			menu.close()

			if data.current.value == 'yes' then
				ExecuteCommand("askrestart 25")
					end
					end)
				elseif data2.current.value == 'restart30' then
				 ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'askrestart_confirm5', {
			title = 'هل أنت متأكد من بدء وقت ريستارت؟ 30',
			align = 'top-left',
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		   }}, function(data, menu)
			menu.close()

			if data.current.value == 'yes' then
				ExecuteCommand("askrestart 30")
					end
					end)
				  end
				end, function(data2, menu2)
				  menu2.close()
				end)
			  elseif data2.current.value == 'restart-stop' then
				ExecuteCommand("restartstop")
			  end
			end, function(data2, menu2)
			  menu2.close()
			end)	
				elseif accion == 'revive_all' then
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'reviveall_confirm', {
			title = "?هل أنت متأكد من إنعاش جميع اللاعبين الميتين",
			align = 'top-left',
			elements = {
				{label = _U('confirm_no'), value = 'no'},
				{label = _U('confirm_yes_reviveall'), value = 'yes'}
		}}, function(data, menu)
			menu.close()

			if data.current.value == 'yes' then
				TriggerServerEvent('wesam:ReviveALl:Players')
				PlaySoundFrontend(-1, "OTHER_TEXT", "HUD_AWARDS", true)
							end
							end)
					--ExecuteCommand("reviveall")
				end
			end, function(data2, menu2)
				menu2.close()
            end)
        end
		

		if data.current.value == 'jugador_admin' then
			ESX.TriggerServerCallback('esx_adminjob:playersonline', function(players)
				local elements = {}
				table.insert(elements, {label = 'البحث عن لاعب بالإيدي 🔍', value = 'search_for_players'}) -- جاري العمل عليه
				for i=1, #players, 1 do
					table.insert(elements, {
						label = players[i].name .. ' | ' .. players[i].source ,
						value = players[i].source,
						name = players[i].name
					})
				end
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_list', {
					title    = _U('player_list'),
					align    = Config.MenuAlign,
					elements = elements
				}, function(data2, menu2)
		        	if data2.current.value == 'search_for_players' then
						menu.close()
						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'set_id_player', {
            				title = "أيدي اللاعب المراد البحث عنه"
          				},function(data2, menu2)
            				local id = tonumber(data2.value)

            				if id == nil then
              					ESX.ShowNotification("يجب أن يكون العدد صحيح!")
            				else
              					menu2.close()
								ESX.TriggerServerCallback('esx_adminjob:getPlayeris', function(data)
									local data2 = data
									if data2.status then
										local name = data2.current.name
										local Playerid = data2.current.value
										local elements = {}
										if grade >= 1 then
											table.insert(elements, {label = "<font color=red>باند 🔒</font>", value = 'banned'})
										end
										table.insert(elements, {label = _U('freeze'), value = 'freeze'}) -- تجميد
										table.insert(elements, {label = _U('revive_player'), value = 'revive_player'}) -- انعاش
										table.insert(elements, {label = _U('kill'), value = 'kill'}) -- قتل ؟
										table.insert(elements, {label = _U('kick'), value = 'kick'}) -- طرد
										table.insert(elements, {label = _U('goto'), value = 'goto'}) -- انتقال
										table.insert(elements, {label = _U('bring'), value = 'bring'}) -- سحب 'esx_adminjob:weaponPlayer2
										table.insert(elements, {label = 'مراقبة الأعب', value = 'spec_to_player'}) -- مراقبة
										table.insert(elements, {label = 'نقل الأعب', value = 'teleport_player_gh'}) -- 
										table.insert(elements, {label = _U('search'), value = 'searchbodyplayer'}) --  هاذا تفتيش
										table.insert(elements, {label = _U('handcuff'), value = 'handcuff'})
										table.insert(elements, {label = "الأستعلام عن <font color=#F1C40F>"..data2.current.name.."</font>", value = 'getinfo'})
										table.insert(elements, {label = "الأستعلام عن <font color=#5DADE2>خبرة</font> <font color=#F1C40F>"..data2.current.name.."</font>", value = 'getxp'})
										if grade >= 3 then
											table.insert(elements, {label = _U('weapon_player'), value = 'weapon_player'}) -- اعطاء سلاح مسدس
											table.insert(elements, {label = "اعطاء شوزن ", value = 'weapon_player_2'}) -- اعطاء سلاح شوزن
											table.insert(elements, {label = "<span style='color:orange;'>إعطاء قائمة الإنتقال 🛸</span>", value = 'Givetp'})
											table.insert(elements, {label = "<span style='color:yellow;'>إعطاء قائمة تغيير شكل 👚</span>", value = 'give_menu_skin'})
											table.insert(elements, {label = "<span style='color:purple;'>إعطاء وظيفة 💼</span>", value = 'give_jops'})
											table.insert(elements, {label = "<span style='color:yellow;'>تغيير اسم هوية الاعب 💳</span>", value = 'change_name_player'})
											table.insert(elements, {label = "<span style='color:gray;'>اعطاء ايتم</span>", value = 'give_item'})
											table.insert(elements, {label = "<span style='color:gray;'>استعلام عن المركبات</span>", value = 'check_veh'})
											table.insert(elements, {label = "ارسال رسالة الى الأعب", value = 'send_message_to_player'})
											table.insert(elements, {label = "<span style='color:#0fd644;'>اضافة مبلغ في ( الكاش ) ⏫ <br><span  style='color:#FF0E0E;font-size:15'>تنبيه: <span style='color:gray;'>يمنع الأستعمال الا في حال استشارة الادارة العليا", value = 'ataflows_cash'})
											table.insert(elements, {label = "<span style='color:#0fd644;'>اضافة مبلغ في ( البنك ) ⏫ <br><span  style='color:#FF0E0E;font-size:15'>تنبيه: <span style='color:gray;'>يمنع الأستعمال الا في حال استشارة الادارة العليا", value = 'ataflows_bank'})
											table.insert(elements, {label = "<span style='color:#0fd644;'>اضافة مبلغ غير قانوني ⏫ <br><span  style='color:#FF0E0E;font-size:15'>تنبيه: <span style='color:gray;'>يمنع الأستعمال الا في حال استشارة الادارة العليا", value = 'ataflowsblack'})
											table.insert(elements, {label = "<span style='color:#d60f0f;'>سحب مبلغ من ( الكاش ) ⏬ <br><span  style='color:#FF0E0E;font-size:15'>تنبيه: <span style='color:gray;'>يمنع الأستعمال الا في حال استشارة الادارة العليا", value = 's7b_money_from_cash'})
											table.insert(elements, {label = "<span style='color:#d60f0f;'>سحب مبلغ من ( البنك ) ⏬ <br><span  style='color:#FF0E0E;font-size:15'>تنبيه: <span style='color:gray;'>يمنع الأستعمال الا في حال استشارة الادارة العليا", value = 's7b_money_from_bank'})
											table.insert(elements, {label = "<span style='color:#d60f0f;'>سحب مبلغ غير قانوني ⏬ <br><span  style='color:#FF0E0E;font-size:15'>تنبيه: <span style='color:gray;'>يمنع الأستعمال الا في حال استشارة الادارة العليا", value = 'admin_menu1010'})
											table.insert(elements, {label = "<span style='color:#0fd644;'>اضافة خبرة ⏫ <br><span  style='color:#FF0E0E;font-size:15'>تنبيه: <span style='color:gray;'>يمنع الأستعمال الا في حال استشارة الادارة العليا", value = 'addxp'})
											table.insert(elements, {label = "<span style='color:#d60f0f;'>ازالة خبرة ⏬ <br><span  style='color:#FF0E0E;font-size:15'>تنبيه: <span style='color:gray;'>يمنع الأستعمال الا في حال استشارة الادارة العليا", value = 'removexp'})
											table.insert(elements, {label = '<span style="color:#0fd644;"> سجل الغرامات <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">سجل الاعب في الغرامات', value = 'sglalab'})
											table.insert(elements, {label = '<span style="color:#E1790B;"> غرامة اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">اعطاء غرامة للاعب', value = 'ataghramh'})
											table.insert(elements, {label =  '<span style="color:#0fd644;"> سجل الانذارات <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">سجل الاعب في الانذارات', value = 'sglalabanthar'})
											table.insert(elements, {label = '<span style="color:#E1790B;"> انذار اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">اعطاء انذار للاعب', value = 'ataganthar'})
											table.insert(elements, {label = '<span style="color:#E1790B;"> أستدعاء اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">أستدعاء الاعب', value = 'asd3a_ala3b'})
											table.insert(elements, {label = '<span style="color:#E1790B;"> سجن اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">سجن هاذه الاعب', value = 'jail'})
											table.insert(elements, {label = '<span style="color:#E1790B;"> إعفاء اللاعب من عقوبة السجن <br><span  style="color:#FF0E0E;font-size:15">تنبيه: <span style="color:gray;">لاتضغط في حال لاعب ماكان مسجون', value = 'unjail'})
										elseif grade >= 2 then
											table.insert(elements, {label = "ارسال رسالة الى الأعب", value = 'send_message_to_player'})
											table.insert(elements, {label = "<span style='color:purple;'>إعطاء قائمة تغيير شكل 👚</span>", value = 'give_menu_skin'})
											table.insert(elements, {label = "<span style='color:purple;'>إعطاء وظيفة 💼</span>", value = 'give_jops'})
											table.insert(elements, {label = "<span style='color:gray;'>اعطاء ايتم</span>", value = 'give_item'})
											table.insert(elements, {label = "<span style='color:gray;'>استعلام عن المركبات</span>", value = 'check_veh'})
											table.insert(elements, {label = "<span style='color:#0fd644;'>اضافة خبرة ⏫ <br><span  style='color:#FF0E0E;font-size:15'>تنبيه: <span style='color:gray;'>يمنع الأستعمال الا في حال استشارة الادارة العليا", value = 'addxp'})
											table.insert(elements, {label = "<span style='color:#d60f0f;'>ازالة خبرة ⏬ <br><span  style='color:#FF0E0E;font-size:15'>تنبيه: <span style='color:gray;'>يمنع الأستعمال الا في حال استشارة الادارة العليا", value = 'removexp'})
											table.insert(elements, {label = '<span style="color:#0fd644;"> سجل الغرامات <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">سجل الاعب في الغرامات', value = 'sglalab'})
											table.insert(elements, {label = '<span style="color:#E1790B;"> غرامة اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">اعطاء غرامة للاعب', value = 'ataghramh'})
											table.insert(elements, {label = '<span style="color:#0fd644;"> سجل الانذارات <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">سجل الاعب في الانذارات', value = 'sglalabanthar'})
											table.insert(elements, {label = '<span style="color:#E1790B;"> انذار اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">اعطاء انذار للاعب', value = 'ataganthar'})
											table.insert(elements, {label = '<span style="color:#E1790B;"> أستدعاء اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">أستدعاء الاعب', value = 'asd3a_ala3b'})
											table.insert(elements, {label = '<span style="color:#E1790B;"> سجن اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">سجن هاذه الاعب', value = 'jail'})
											table.insert(elements, {label = '<span style="color:#E1790B;"> إعفاء اللاعب من عقوبة السجن <br><span  style="color:#FF0E0E;font-size:15">تنبيه: <span style="color:gray;">لاتضغط في حال لاعب ماكان مسجون', value = 'unjail'})
										elseif grade >= 1 then
											table.insert(elements, {label = "ارسال رسالة الى الأعب", value = 'send_message_to_player'})
											table.insert(elements, {label = "<span style='color:purple;'>إعطاء قائمة تغيير شكل 👚</span>", value = 'give_menu_skin'})
											table.insert(elements, {label = '<span style="color:#0fd644;"> سجل الغرامات <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">سجل الاعب في الغرامات', value = 'sglalab'})
											table.insert(elements, {label = '<span style="color:#E1790B;"> غرامة اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">اعطاء غرامة للاعب', value = 'ataghramh'})
											table.insert(elements, {label =  '<span style="color:#0fd644;"> سجل الانذارات <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">سجل الاعب في الانذارات', value = 'sglalabanthar'})
											table.insert(elements, {label = '<span style="color:#E1790B;"> انذار اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">اعطاء انذار للاعب', value = 'ataganthar'})
											table.insert(elements, {label = '<span style="color:#E1790B;"> أستدعاء اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">أستدعاء الاعب', value = 'asd3a_ala3b'})
											table.insert(elements, {label = '<span style="color:#E1790B;"> سجن اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">سجن هاذه الاعب', value = 'jail'})
											table.insert(elements, {label = '<span style="color:#E1790B;"> إعفاء اللاعب من عقوبة السجن <br><span  style="color:#FF0E0E;font-size:15">تنبيه: <span style="color:gray;">لاتضغط في حال لاعب ماكان مسجون', value = 'unjail'})
										else
											table.insert(elements, {label = "ارسال رسالة الى الأعب", value = 'send_message_to_player'})
											table.insert(elements, {label = '<span style="color:#0fd644;"> سجل الغرامات <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">سجل الاعب في الغرامات', value = 'sglalab'})
											table.insert(elements, {label = '<span style="color:#E1790B;"> غرامة اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">اعطاء غرامة للاعب', value = 'ataghramh'})
											table.insert(elements, {label = '<span style="color:#0fd644;"> سجل الانذارات <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">سجل الاعب في الانذارات', value = 'sglalabanthar'})
											table.insert(elements, {label = '<span style="color:#E1790B;"> انذار اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">اعطاء انذار للاعب', value = 'ataganthar'})
											table.insert(elements, {label = '<span style="color:#E1790B;"> أستدعاء اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">أستدعاء الاعب', value = 'asd3a_ala3b'})
											table.insert(elements, {label = '<span style="color:#E1790B;"> سجن اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">سجن هاذه الاعب', value = 'jail'})
											table.insert(elements, {label = '<span style="color:#E1790B;"> إعفاء اللاعب من عقوبة السجن <br><span  style="color:#FF0E0E;font-size:15">تنبيه: <span style="color:gray;">لاتضغط في حال لاعب ماكان مسجون', value = 'unjail'})
										end
										if grade >= 4 then
											table.insert(elements, {label = "<span style='color:#0bddf0;'>-----------  التعويضات  ------------ </span>"}) -- مراقبة
											table.insert(elements, {label = "<span style='color:green;'>اعطاء رخصة </span>", value = 'give_lsn'}) -- مراقبة
											table.insert(elements, {label = "<span style='color:red;'>سحب رخصة </span>", value = 'remove_lsn'}) -- مراقبة
											table.insert(elements, {label = "<span style='color:purple;'>اعطاء مركبة للكراج🚗 </span>", value = 'givecar'}) -- مراقبة
											table.insert(elements, {label = "<span style='color:#0bddf0;'>اعطاء متجر 🏪 </span>", value = 'giveshop'}) -- مراقبة
											table.insert(elements, {label = "<span style='color:red;'>سحب متجر 🏪 </span>", value = 'removeshop'}) -- 
										end					
										ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_name', {
											title    = "["..data2.current.value.."] "..data2.current.name,
											align    = Config.MenuAlign,
											elements = elements
										}, function(data3, menu3)
											if data3.current.value == 'getxp' then
												if Cooldown_count == 0 then
													Cooldown(4)
													ESX.TriggerServerCallback('getRankPlayer:getRankPlayerByMenuwesam', function(xp)
														ESX.ShowNotification('<font color=#5DADE2>'..xp..'</font> خبرة اللاعب')
													end, data2.current.value)
												else
													ESX.ShowNotification('<font color=red>يجب الأنتظار</font>. <font color=orange>'..Cooldown_count..' ثانية')
												end
											elseif data3.current.value == "banned" then
												menu3.close()
												ESX.UI.Menu.Open("default", GetCurrentResourceName(), "banned_menu", {
													title = data3.current.label,
													align = "top-left",
													elements = {
														{label = data3.current.label .. " 1 يوم", time = 86400, is_perment = false},
														{label = data3.current.label .. " 2 يومين", time = 172800, is_perment = false},
														{label = data3.current.label .. " 7 ايام (اسبوع)", time = 518400, is_perment = false},
														{label = data3.current.label .. " 14 يوم (اسبوعين)", time = 1123200, is_perment = false},
														{label = data3.current.label .. " 30 يوم (شهر)", time = 2678400, is_perment = false},
														{label = "<font color=red>باند</font> نهائي 🔒", time = 10444633200, is_perment = true},
													}
												}, function(data_banned, menu_banned)
													if data_banned.current.time then
														ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'reason_banned_menu', {
															title    = 'اكتب السبب'
														}, function(data30, menu30)
															local reason = data30.value
															if reason == nil or reason == '' then
																ESX.ShowNotification('اكتب السبب')
															else
																menu30.close()
																ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'message_confierm', {
																	title    = 'تأكيد <font color=red>تبنيد</font> الاعب <font color=orange>' .. name .. "</font> لمدة <font color=orange>" .. data_banned.current.label .. "</font>",
																	align    = 'top-left',
																	elements = {
																		{ label = '<font color=red>إلغاء</font>', value = 'no' },
																		{ label = '<font color=green>تأكيد</font>', value = 'yes' },
																	}
																}, function(data97, menu97)
																	if data97.current.value == 'no' then
																		menu97.close()
																	else
																		menu97.close()
																		if data_banned.current.is_perment then
																			TriggerServerEvent("EasyAdmin:banPlayer", Playerid, reason, reason, "نهائي 🔒", data_banned.current.time)
																		else
																			TriggerServerEvent("EasyAdmin:banPlayer", Playerid, reason, reason, TimerConvert(data_banned.current.time), data_banned.current.time)
																		end
																	end
																end, function(data97, menu97)
																	menu97.close()
																end)
															end
														end, function(data30, menu30)
															menu.close()
														end)
													end
												end, function(data_banned, menu_banned)
													menu_banned.close()
												end)
											elseif data3.current.value == "license" then
												ShowPlayerLicense2(Playerid)
											elseif data3.current.value == "handcuff" then
												TriggerServerEvent('esx_misc:startAreszt',Playerid)
											elseif data3.current.value == "take_lic" then
												ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'take_lic_menu', {
													title    = 'اكتب السبب'
												}, function(data30, menu30)
													local reason = data30.value
													if reason == nil or reason == '' then
														ESX.ShowNotification('اكتب السبب')
													else
														menu30.close()
														TriggerServerEvent('esx_adminjob:takelic', Playerid, reason)
													end
												end)
											elseif data3.current.value == "searchbodyplayer" then
												OpenBodySearchMenu2(data2.current.value)
											elseif data3.current.value == 'send_message_to_player' then
												ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'message_enter', {
													title    = 'اكتب الرسالة'
												}, function(data30, menu30)
													local message = data30.value
													if message == nil or message == '' then
														ESX.ShowNotification('اكتب الرسالة')
													else
														menu30.close()
														ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'message_confierm', {
															title    = '<font color=green>تأكيد ارسال الرسالة</font>'..' - ' .. message,
															align    = 'top-left',
															elements = {
																{ label = '<font color=red>إلغاء</font>', value = 'no' },
																{ label = '<font color=green>تأكيد</font>', value = 'yes' },
															}
														}, function(data97, menu97)
															if data97.current.value == 'no' then
																menu97.close()
															else
																TriggerServerEvent('esx_adminjob:send_messag_to_player', message, Playerid)
																menu97.close()
															end
														end, function(data97, menu97)
															menu97.close()
														end)
													end
												end, function(data30, menu30)
													menu30.close()
												end)
											elseif data3.current.value == 'check_veh' then
												ESX.TriggerServerCallback('leojob:getPlayerCars', function(Cars)
													local Carsssss = {}
													local HaveOverOne = false
													for i = 1, #Cars, 1 do
														if Cars[i] then
															table.insert(Carsssss, { label = '<font color=gray>اسم المركبة: '..Cars[i].name..' | رقم اللوحة: '..tostring(Cars[i].plate)..'</font>', value = Cars[i].plate, name = Cars[i].name})
															HaveOverOne = true
														end
													end

													if not HaveOverOne then
														table.insert(Carsssss, { label = '<font color=gray>لا توجد أي مركبة مسجلة بأسم اللاعب</font>', value = nil })
													end

													ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'admin_menu_cars', {
														title    = data3.current.label,
														align    = 'top-left',
														elements = Carsssss
													}, function(data55, menu55)
														ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "reason_take_car", {
															title = "ادخل السبب",
														}, function(data_reason_take_car, menu_reason_take_car)
															if data_reason_take_car.value == nil then
																ESX.ShowNotification("رجاء ادخل سبب")
															else
																menu_reason_take_car.close()
																ESX.UI.Menu.Open("default", GetCurrentResourceName(), "take_car_from_player", {
																	title = "هل انت متاكد",
																	align = "top-left",
																	elements = {
																		{label = "نعم", value = "yes"},
																		{label = "لا", value = "no"}
																	}
																}, function(data_take_car, menu_take_car)
																	if data_take_car.current.value == "yes" then
																		menu_take_car.close()
																		TriggerServerEvent("esx_adminjob:wesam:take:car", Playerid, data55.current.value, data55.current.name, data_reason_take_car.value)
																	else
																		menu_take_car.close()
																	end
																end, function(data_take_car, menu_take_car)
																	menu_take_car.close()
																end)
															end
														end, function(data_reason_take_car, menu_reason_take_car)
															menu_reason_take_car.close()
														end)
													end, function(data55, menu55)
														menu55.close()
													end)
												end, Playerid)
											elseif data3.current.value == 'give_item' then
												ESX.TriggerServerCallback('esx_adminjob:getItemsFromdatabase', function(items) 
													local itemslist = {}
													for i = 1, #items, 1 do
														table.insert(itemslist, { label = items[i].label, value = items[i].name })
													end
					
													ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'admin_menu_itemmss', {
														title    = 'الرجاء اختيار الآيتم',
														align    = 'top-left',
														elements = itemslist
													}, function(data55, menu55)
														ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'admin_menu_3', {
															title    = 'الرجاء تحديد القيمة'
														}, function(data14, menu14)
															local smdoidhodhud = tonumber(data14.value)
															if not smdoidhodhud then
																ESX.ShowNotification(_U('quantity_invalid'))
															else
																menu14.close()
																ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Confiorm_adminmenu', {
																	title    = '<font color=green>تأكيد</font>',
																	align    = 'top-left',
																	elements = {
																		{ label = '<font color=red>إلغاء</font>', value = 'no' },
																		{ label = '<font color=green>تأكيد</font>', value = 'yes' },
																	}
																}, function(data99, menu99)
																	if data99.current.value == 'no' then
																		menu99.close()
																	else
																		TriggerServerEvent("esx_adminjob:addInventoryToPlayer", data55.current.value, smdoidhodhud, Playerid)
																		menu99.close()
																	end
																end, function(data99, menu99)
																	menu99.close()
																end)
															end
														end, function(data14, menu14)
															menu14.close()
														end)
													end, function(data55, menu55)
														menu55.close()
													end)
												end)
																	-------------------------------
											elseif data3.current.value == 'give_lsn' then
												ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_menu', {
														title    = 'هل أنت متأكد من إعطاء اي رخصة؟ <span style="color:orange">'..name..'</span>',
														align    = 'bottom-right',
														elements = {
																{label = '<span style="color:red">رجوع</span>',  value = 'no'},
																{label = '<span style="color:green">رخصة اجتياز اختبار النظريي</span>',  value = 'dmv'},
																{label = '<span style="color:green">رخصة قيادة مركبة 🚗</span>',  value = 'drive'},
																{label = '<span style="color:green">رخصة قيادة طائرة✈️</span>',  value = 'drive_aircraft'},
																{label = '<span style="color:green">رخصة قيادة دراجة 🏍️</span>',  value = 'drive_bike'},
																{label = '<span style="color:green">رخصة قيادة قارب🛶</span>',  value = 'drive_boat'},
																{label = '<span style="color:green">رخصة قيادة شاحنة 🚛</span>',  value = 'drive_truck'},
																{label = '<span style="color:green">رخصة حمل سلاح 🔫</span>',  value = 'weapon'},
															}
														}, function(data2, menu2)
															if data2.current.value == 'dmv' then
																ESX.TriggerServerCallback('esx_dmvschooladmin:addLicenseadmin', function()
																end,data2.current.value, Playerid)	
																ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم اعطاء</font>')
															    elseif data2.current.value == 'drive' then
																ESX.TriggerServerCallback('esx_dmvschooladmin:addLicenseadmin', function()
																end,data2.current.value, Playerid)	
																ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم اعطاء</font>')
																elseif data2.current.value == 'drive_aircraft' then
																ESX.TriggerServerCallback('esx_dmvschooladmin:addLicenseadmin', function()
																end,data2.current.value, Playerid)	
																ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم اعطاء</font>')
																elseif data2.current.value == 'drive_bike' then
																ESX.TriggerServerCallback('esx_dmvschooladmin:addLicenseadmin', function()
																end,data2.current.value, Playerid)	
																ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم اعطاء</font>')
																elseif data2.current.value == 'drive_boat' then
																ESX.TriggerServerCallback('esx_dmvschooladmin:addLicenseadmin', function()
																end,data2.current.value, Playerid)	
																ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم اعطاء</font>')
																elseif data2.current.value == 'drive_truck' then
																ESX.TriggerServerCallback('esx_dmvschooladmin:addLicenseadmin', function()
																end,data2.current.value, Playerid)	
																ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم اعطاء</font>')
																elseif data2.current.value == 'weapon' then
																ESX.TriggerServerCallback('esx_dmvschooladmin:addLicenseadmin', function()
																end,data2.current.value, Playerid)	
																ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم اعطاء</font>')
															end
															menu2.close()
														end, function(data2, menu2) menu2.close() end)
														-------------------------------
													elseif data3.current.value == 'remove_lsn' then
														ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_menu', {
																title    = 'هل أنت متأكد من إعطاء اي رخصة؟ <span style="color:orange">'..name..'</span>',
																align    = 'bottom-right',
																elements = {
																		{label = '<span style="color:green">رجوع</span>',  value = 'no'},
																		{label = '<span style="color:red">رخصة اجتياز اختبار النظري</span>',  value = 'dmv'},
																		{label = '<span style="color:red">رخصة قيادة مركبة 🚗</span>',  value = 'drive'},
																		{label = '<span style="color:red">رخصة قيادة طائرة✈️</span>',  value = 'drive_aircraft'},
																		{label = '<span style="color:red">رخصة قيادة دراجة 🏍️</span>',  value = 'drive_bike'},
																		{label = '<span style="color:red">رخصة قيادة قارب🛶</span>',  value = 'drive_boat'},
																		{label = '<span style="color:red">رخصة قيادة شاحنة 🚛</span>',  value = 'drive_truck'},
																		{label = '<span style="color:red">رخصة حمل سلاح 🔫</span>',  value = 'weapon'},
																	}
																}, function(data2, menu2)
																	if data2.current.value == 'dmv' then
																		ESX.TriggerServerCallback('esx_dmvschooladmin:removeLicenseadmin', function()
																		end,data2.current.value, Playerid)	
																		ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم سحب</font>')
																		elseif data2.current.value == 'drive' then
																		ESX.TriggerServerCallback('esx_dmvschooladmin:removeLicenseadmin', function()
																		end,data2.current.value, Playerid)	
																		ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم سحب</font>')
																		elseif data2.current.value == 'drive_aircraft' then
																		ESX.TriggerServerCallback('esx_dmvschooladmin:removeLicenseadmin', function()
																		end,data2.current.value, Playerid)	
																		ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم سحب</font>')
																		elseif data2.current.value == 'drive_bike' then
																		ESX.TriggerServerCallback('esx_dmvschooladmin:removeLicenseadmin', function()
																		end,data2.current.value, Playerid)	
																		ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم سحب</font>')
																		elseif data2.current.value == 'drive_boat' then
																		ESX.TriggerServerCallback('esx_dmvschooladmin:removeLicenseadmin', function()
																		end,data2.current.value, Playerid)	
																		ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم سحب</font>')
																		elseif data2.current.value == 'drive_truck' then
																		ESX.TriggerServerCallback('esx_dmvschooladmin:removeLicenseadmin', function()
																		end,data2.current.value, Playerid)	
																		ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم سحب</font>')
																		elseif data2.current.value == 'weapon' then
																		ESX.TriggerServerCallback('esx_dmvschooladmin:removeLicenseadmin', function()
																		end,data2.current.value, Playerid)	
																		ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم سحب</font>')
																	end
																	menu2.close()
																end, function(data2, menu2) menu2.close() end)
															elseif data3.current.value == 'remove_lsn' then
																ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_menu', {
																		title    = 'هل أنت متأكد من إعطاء اي رخصة؟ <span style="color:orange">'..name..'</span>',
																		align    = 'bottom-right',
																		elements = {
																				{label = '<span style="color:green">رجوع</span>',  value = 'no'},
																				{label = '<span style="color:red">رخصة اجتياز اختبار النظري</span>',  value = 'dmv'},
																				{label = '<span style="color:red">رخصة قيادة مركبة 🚗</span>',  value = 'drive'},
																				{label = '<span style="color:red">رخصة قيادة طائرة✈️</span>',  value = 'drive_aircraft'},
																				{label = '<span style="color:red">رخصة قيادة دراجة 🏍️</span>',  value = 'drive_bike'},
																				{label = '<span style="color:red">رخصة قيادة قارب🛶</span>',  value = 'drive_boat'},
																				{label = '<span style="color:red">رخصة قيادة شاحنة 🚛</span>',  value = 'drive_truck'},
																				{label = '<span style="color:red">رخصة حمل سلاح 🔫</span>',  value = 'weapon'},
																			}
																		}, function(data2, menu2)
																			if data2.current.value == 'dmv' then
																				ESX.TriggerServerCallback('esx_dmvschooladmin:removeLicenseadmin', function()
																				end,data2.current.value, Playerid)	
																				ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم سحب</font>')
																				elseif data2.current.value == 'drive' then
																				ESX.TriggerServerCallback('esx_dmvschooladmin:removeLicenseadmin', function()
																				end,data2.current.value, Playerid)	
																				ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم سحب</font>')
																				elseif data2.current.value == 'drive_aircraft' then
																				ESX.TriggerServerCallback('esx_dmvschooladmin:removeLicenseadmin', function()
																				end,data2.current.value, Playerid)	
																				ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم سحب</font>')
																				elseif data2.current.value == 'drive_bike' then
																				ESX.TriggerServerCallback('esx_dmvschooladmin:removeLicenseadmin', function()
																				end,data2.current.value, Playerid)	
																				ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم سحب</font>')
																				elseif data2.current.value == 'drive_boat' then
																				ESX.TriggerServerCallback('esx_dmvschooladmin:removeLicenseadmin', function()
																				end,data2.current.value, Playerid)	
																				ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم سحب</font>')
																				elseif data2.current.value == 'drive_truck' then
																				ESX.TriggerServerCallback('esx_dmvschooladmin:removeLicenseadmin', function()
																				end,data2.current.value, Playerid)	
																				ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم سحب</font>')
																				elseif data2.current.value == 'weapon' then
																				ESX.TriggerServerCallback('esx_dmvschooladmin:removeLicenseadmin', function()
																				end,data2.current.value, Playerid)	
																				ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم سحب</font>')
																			end
																			menu2.close()
																		end, function(data2, menu2) menu2.close() end)
														    elseif data3.current.value == 'givecar' then
															ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'menu_car', {
																title = 'اكتب اسم المركبة'
															}, function(data14, menu14)
																menu14.close()
																ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'menu_car1', {
																	title = 'اكتب اللوحة مثال GHM 707'
																}, function(data16, menu16)
																	menu16.close()
																	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'menu_car2', {
																		title = 'الوظيفة الخاصة للمركبة اذا مركبة عامة حط /civ '
																	}, function(data17, menu17)
																		menu17.close()
																		ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'menu_car3', {
																			title = 'موديل المركبة '
																		}, function(data13, menu13)
																			menu13.close()
																			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'menu_car4', {
																				title = ' سعر المركبة بحيث اذا جاء يعرضها في مستعمل '
																			}, function(data18, menu18)
																				menu18.close()
																				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'menu_car5', {
																					title = ' خبرة المركبة بحيث اذا جاء يعرضها في مستعمل '
																				}, function(data19, menu19)
																					menu19.close()
																					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'menu_car6', {
																						title = ' نوع المركبة car/truck... '
																					}, function(data20, menu20)
																						menu20.close()
																						TriggerServerEvent('esx_adminjob:wesamcar', Playerid,data14.value,data16.value,data17.value,data13.value,data18.value,data19.value,data20.value)							
																					end)
																				end)
																			end)
																		end)
																	end)
																end)
															end)
															--------------------------------------			
														elseif data3.current.value == 'giveshop' then
															ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'menu_car', {
																title = 'اكتب ايدي المتجر'
															}, function(data3, menu3)
																menu3.close()
																TriggerServerEvent('esx_adminjob:wesamshop', data3.value,Playerid)
																ESX.ShowNotification('<font color=green>  تم اعطاء   '..name.. ' متجر بنجاح </font>')
															end)
														---------------------------------------
																						--------------------------------------			
									elseif data3.current.value == 'removeshop' then
										ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Confiorm_adminmenu', {
											title    = '<font color=red>تأكيد</font>'..name..' - سحب متجر',
											align    = 'top-left',
											elements = {
												{ label = '<font color=red>إلغاء</font>', value = 'no' },
												{ label = '<font color=green>تأكيد</font>', value = 'yes' },
											}
										}, function(data99, menu99)
											if data99.current.value == 'no' then
												menu99.close()
											else
												TriggerServerEvent('esx_adminjob:wesamremoveshop', Playerid)
												ESX.ShowNotification('<font color=red>  تم سحب متجر  '..name.. ' بنجاح  </font>')
												menu99.close()
											end
										end)
 						        -------------------------------

											elseif data3.current.value == 'give_menu_skin' then
												ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Confiorm_adminmenu', {
													title    = '<font color=green>تأكيد</font> - اعطاء قائمة تغيير شكل',
													align    = 'top-left',
													elements = {
														{ label = '<font color=red>إلغاء</font>', value = 'no' },
														{ label = '<font color=green>تأكيد</font>', value = 'yes' },
													}
												}, function(data99, menu99)
													if data99.current.value == 'no' then
														menu99.close()
													else
														TriggerServerEvent('esx_skin:openMenuToPlayer', Playerid)
														menu99.close()
													end
												end, function(data99, menu99)
													menu99.close()
												end)
											elseif data3.current.value == 'give_jops' then
												ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_jobs_player', {
													title = 'قائمة اعطاء وظيفة للاعب 💼',
													align = 'top-left',
													elements = {
														{label = 'وظيفة <span style="color:blue">إدارة الشرطة 👮</span>', value = 'police'},
														{label = 'وظيفة <span style="color:gray">حرس الحدود 🕴</span>', value = 'agent'},
														{label = 'وظيفة <span style="color:red">الهلال الأحمر 🚑</span>', value = 'ambulance'},
														{label = 'وظيفة <span style="color:gray">كراج الميكانيك 🛠️</span>', value = 'mec'},
														{label = 'وظيفة <span style="color:brown">الأخشاب 🌲</span>', value = 'lumberjack'},
														{label = 'وظيفة <span style="color:yellow">الدواجن 🐔</span>', value = 'slaughterer'},
														{label = 'وظيفة <span style="color:pink">الأقمشة 🧵</span>', value = 'tailor'},
														{label = 'وظيفة <span style="color:orange">المعادن 👷</span>', value = 'miner'},
														{label = 'وظيفة <span style="color:red">نفط و غاز ⛽</span>', value = 'fueler'},
														{label = 'وظيفة <span style="color:blue">الأسماك 🐟</span>', value = 'fisherman'},
														{label = 'وظيفة <span style="color:yellow">المزارع 👨‍🌾</span>', value = 'farmer'},
														{label = 'وظيفة <span style="color:yellow">تاكسي 🚕</span>', value = 'taxi'},
														{label = 'وظيفة <span style="color:gray">عاطل</span>', value = 'unemployed'},
													}
												}, function(data00, menu00)
													if data00.current.value == 'police' then
														ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_jobs_player2', {
															title = 'قائمة اعطاء وظيفة للاعب 💼 - <font color=blue>إدارة الشرطة 👮</font>',
															align = 'top-left',
															elements = {
																{label = 'جندي 👮', value = '0'},
																{label = 'جندي أول 👮', value = '1'},
																{label = 'عريف 👮', value = '2'},
																{label = 'وكيل رقيب 👮', value = '3'},
																{label = 'رقيب 👮', value = '4'},
																{label = 'رقيب أول 👮', value = '5'},
																{label = 'رئيس رقباء 👮', value = '6'},
																{label = 'ملازم 👮', value = '7'},
																{label = 'ملازم أول 👮', value = '8'},
																{label = 'نقيب 👮', value = '9'},
																{label = 'رائد 👮', value = '10'},
																{label = 'مقدم 👮', value = '11'},
																{label = 'عقيد 👮', value = '13'},
																{label = 'عميد 👮', value = '15'},
																{label = 'لواء 👮', value = '17'},
																{label = 'فريق 👮', value = '19'},
																{label = 'فريق اول 👮', value = '20'},
																{label = 'نائب قائد الشرطة 👮', value = '23'},
																{label = 'قائد الشرطة 👮', value = '24'},
															}
														}, function(data01, menu01)
															ExecuteCommand('setjob ' .. Playerid .. " police " .. data01.current.value)
															ESX.ShowNotification('تم اعطاء الاعب وظيفة إدارة الشرطة - ' .. data01.current.label)
														end, function(data01, menu01)
															menu01.close()
													end)
												elseif data00.current.value == 'agent' then
													ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_jobs_player3', {
														title = 'قائمة اعطاء وظيفة للاعب 💼 - <font color=red>حرس الحدود 🕴</font>',
														align = 'top-left',
														elements = {
															{label = 'جندي 🕴', value = '0'},
															{label = 'جندي أول 🕴', value = '1'},
															{label = 'عريف 🕴', value = '2'},
															{label = 'وكيل رقيب 🕴', value = '3'},
															{label = 'رقيب 🕴', value = '4'},
															{label = 'رقيب أول 🕴', value = '5'},
															{label = 'رئيس رقباء 🕴', value = '6'},
															{label = 'ملازم 🕴', value = '7'},
															{label = 'ملازم أول 🕴', value = '8'},
															{label = 'نقيب 🕴', value = '9'},
															{label = 'رائد 🕴', value = '10'},
															{label = 'مقدم 🕴', value = '11'},
															{label = 'عقيد 🕴', value = '12'},
															{label = 'عميد 🕴', value = '13'},
															{label = 'لواء 🕴', value = '14'},
															{label = 'نائب قائد حرس الحدود 🕴', value = '15'},
															{label = 'قائد حرس الحدود 🕴', value = '16'},
													}
													}, function(data02, menu02)
														ExecuteCommand('setjob ' .. Playerid .. " agent " .. data02.current.value)
														ESX.ShowNotification('تم اعطاء الاعب وظيفة حرس الحدود - ' .. data02.current.label)										
													end, function(data02, menu02)
														menu02.close()
												end)
													elseif data00.current.value == 'ambulance' then
														ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_jobs_player3', {
															title = 'قائمة اعطاء وظيفة للاعب 💼 - <font color=red>الهلال الأحمر 🚑</font>',
															align = 'top-left',
															elements = {
																{label = 'متدرب 🚑', value = '0'},
																{label = 'مستوى 1 🚑', value = '1'},
																{label = 'مستوى 2 🚑', value = '2'},
																{label = 'مستوى 3 🚑', value = '3'},
																{label = 'مستوى 4 🚑', value = '4'},
																{label = 'مستوى 5 🚑', value = '5'},
																{label = 'مستوى 6 🚑', value = '6'},
																{label = 'مستوى 7 🚑', value = '7'},
																{label = 'مستوى 8 🚑', value = '8'},
																{label = 'مستوى 9 🚑', value = '9'},
																{label = 'مستوى 10 🚑', value = '10'},
																{label = 'نائب قائد الهلال الأحمر 🚑', value = '11'},
																{label = 'قائد الهلال الأحمر 🚑', value = '12'},
															}
														}, function(data02, menu02)
															ExecuteCommand('setjob ' .. Playerid .. " ambulance " .. data02.current.value)
															ESX.ShowNotification('تم اعطاء الاعب وظيفة الهلال الأحمر - ' .. data02.current.label)										
														end, function(data02, menu02)
															menu02.close()
													end)
													elseif data00.current.value == 'mec' then
														ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_jobs_player4', {
															title = 'قائمة اعطاء وظيفة للاعب 💼 - <font color=gray>كراج الميكانيك 🛠️</font>',
															align = 'top-left',
															elements = {
																{label = 'متدرب 🛠️', value = '0'},
																{label = 'مستوى 1 🛠️', value = '1'},
																{label = 'مستوى 2 🛠️', value = '2'},
																{label = 'مستوى 3 🛠️', value = '3'},
																{label = 'مستوى 4 🛠️', value = '4'},
																{label = 'مستوى 5 🛠️', value = '5'},
																{label = 'مستوى 6 🛠️', value = '6'},
																{label = 'مستوى 7 🛠️', value = '7'},
																{label = 'مستوى 8 🛠️', value = '8'},
																{label = 'مستوى 9 🛠️', value = '9'},
																{label = 'نائب مدير كراج الميكانيك 🛠️', value = '10'},
																{label = 'مدير كراج الميكانيك 🛠️', value = '11'},
															}
														}, function(data03, menu03)
															ExecuteCommand('setjob ' .. Playerid .. " mechanic " .. data03.current.value)
															ESX.ShowNotification('تم اعطاء الاعب وظيفة كراج الميكانيك - ' .. data03.current.label)										
														end, function(data03, menu03)
															menu03.close()
													end)
													else
														ExecuteCommand('setjob ' .. Playerid .. " " .. data00.current.value .. " 0")
														ESX.ShowNotification('تم اعطاء الاعب وظيفة - ' .. data00.current.label)										
													end
												end, function(data00, menu00)
													menu00.close()
											end)
											elseif data3.current.value == 'change_name_player' then
												ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'change_name_player', {
													title = 'ادخل الأسم الأول'
												}, function(data10, menu10)
													local first_name_player = data10.value
													if first_name_player == "" or first_name_player == nil then
														ESX.ShowNotification('<font color=red>يجب عليك ادخال اي شي في الأسم الأول</font>')
													else
														menu10.close()
														ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'change_name_player', {
															title = 'ادخل الأسم الثاني ( العائلة )'
														}, function(data11, menu11)
															local last_name_player = data11.value
															if last_name_player == "" or last_name_player == nil then
																ESX.ShowNotification('<font color=red>يجب عليك ادخال اي شي في الأسم الثاني</font>')
															else
																menu11.close()
																TriggerServerEvent('esx_adminjob:change_name_player', Playerid, first_name_player, last_name_player)
															end
														end, function(data11, menu11)
															menu11.close()
													end)
													end
												end, function(data10, menu10)
													menu10.close()
											end)
											elseif data3.current.value == 'spec_to_player' then
												TriggerServerEvent("EasyAdmin:requestSpectate", Playerid)
											elseif data3.current.value == 'teleport_player_gh' then
												TriggerServerEvent("esx_misc:SwapPlayer", Playerid)
											elseif data3.current.value == 'getinfo' then
												ExecuteCommand('id '..Playerid)
											elseif data3.current.value == 'Givetp' then
												ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_menu', {
													title    = 'هل أنت متأكد من إعطاء قائمة الإنتقال للاعب <span style="color:orange">'..name..'</span>',
													align    = 'bottom-right',
													elements = {
														{label = '<span style="color:red">رجوع</span>',  value = 'no'},
														{label = '<span style="color:green">نعم</span>', value = 'yes'},
													}
												}, function(data2, menu2)
													if data2.current.value == 'yes' then
														TriggerServerEvent("esx_misc:GiveTeleportMenu", Playerid)
													end
													menu2.close()
												end, function(data2, menu2)
													menu2.close()
												end)
											elseif data3.current.value == 'freeze' then
												menu3.close()
												TriggerServerEvent('esx_adminjob:freezePlayer', Playerid, name)
												TriggerServerEvent('Mina:8adoji2adminjob:killkickfreeze', ('تجميد لاعب'), "***تم تجميد لاعب من قبل***", " \n steam `"..GetPlayerName(PlayerId()).."` \n لاعب الذي تم تجميده \n `id: "..Playerid.."` (`"..name.."`)", 15158332)
											elseif data3.current.value == 'ataflows_cash' then
												ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'admin_menu_3', {
													title    = 'كم تبي تعطي مبلغ في ( الكاش )'
												}, function(data14, menu14)
													local smdoidhodhud = tonumber(data14.value)
													if not smdoidhodhud then
														ESX.ShowNotification(_U('quantity_invalid'))
													else
														menu14.close()
														ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'admin_menu_15', {
															title    = 'الرجاء إدخال السبب'
														}, function(data15, menu15)
															local smdoidhodhud15 = tostring(data15.value)
															if not smdoidhodhud15 then
																ESX.ShowNotification(_U('quantity_invalid'))
															else
																menu15.close()
																ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'password_give', {
																	title = 'ادخل الباسورد'
																}, function(data_password, menu_password)
																	local password = data_password.value
																	if password == nil then
																		ESX.ShowNotification(_U('quantity_invalid'))
																	else
																		menu_password.close()
																		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Confiorm_adminmenu', {
																			title    = '<font color=green>تأكيد</font> - اضافة مبلغ',
																			align    = 'top-left',
																			elements = {
																				{ label = '<font color=red>إلغاء</font>', value = 'no' },
																				{ label = '<font color=green>تأكيد</font>', value = 'yes' },
																			}
																		}, function(data99, menu99)
																			if data99.current.value == 'no' then
																				menu99.close()
																			else
																				TriggerServerEvent('esx_adminjob:givePlayerMoney', { id = data2.current.value, securityToken = securityToken } , data3.current.value, smdoidhodhud, '', smdoidhodhud15, password)
																				menu99.close()
																			end
																		end, function(data99, menu99)
																			menu99.close()
																		end)
																	end
																end, function(data_password, menu_password)
																	menu_password.close()
																end)
															end
														end, function(data15, menu15)
															menu15.close()
														end)
													end
												end, function(data14, menu14)
													menu14.close()
												end)
											elseif data3.current.value == 'ataflows_bank' then
												ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'admin_menu_3', {
													title    = 'كم تبي تعطي مبلغ في ( البنك )'
												}, function(data14, menu14)
													local smdoidhodhud = tonumber(data14.value)
													if not smdoidhodhud then
														ESX.ShowNotification(_U('quantity_invalid'))
													else
														menu14.close()
														ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'admin_menu_15', {
															title    = 'الرجاء إدخال السبب'
														}, function(data15, menu15)
															local smdoidhodhud15 = tostring(data15.value)
															if not smdoidhodhud15 then
																ESX.ShowNotification(_U('quantity_invalid'))
															else
																menu15.close()
																ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'password_give', {
																	title = 'ادخل الباسورد'
																}, function(data_password, menu_password)
																	local password = data_password.value
																	if password == nil then
																		ESX.ShowNotification(_U('quantity_invalid'))
																	else
																		menu_password.close()
																		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Confiorm_adminmenu', {
																			title    = '<font color=green>تأكيد</font> - اضافة مبلغ',
																			align    = 'top-left',
																			elements = {
																				{ label = '<font color=red>إلغاء</font>', value = 'no' },
																				{ label = '<font color=green>تأكيد</font>', value = 'yes' },
																			}
																		}, function(data99, menu99)
																			if data99.current.value == 'no' then
																				menu99.close()
																			else
																				TriggerServerEvent('esx_adminjob:givePlayerMoney', {id = data2.current.value, securityToken = securityToken}, data3.current.value, smdoidhodhud, '', smdoidhodhud15, password)
																				menu99.close()
																			end
																		end, function(data99, menu99)
																			menu99.close()
																		end)
																	end
																end, function(data_password, menu_password)
																	menu_password.close()
																end)
															end
														end, function(data15, menu15)
															menu15.close()
														end)
													end
												end, function(data14, menu14)
													menu14.close()
												end)
											elseif data3.current.value == 'asd3a_ala3b' then
												ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Confiorm_adminmenu', {
													title    = '<font color=green>تأكيد</font> - اضافة استدعاء الاعب ' .. data2.current.name,
													align    = 'top-left',
													elements = {
														{ label = '<font color=red>إلغاء</font>', value = 'no' },
														{ label = '<font color=green>تأكيد</font>', value = 'yes' },
													}
												}, function(data99, menu99)
													if data99.current.value == 'no' then
														menu99.close()
													else
														TriggerServerEvent('esx_adminjob:astd3a_ala3b', data2.current.value)
														menu99.close()
													end
												end, function(data99, menu99)
													menu99.close()
												end)
											elseif data3.current.value == 'ataflowsblack' then
												ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'admin_menu_3', {
													title    = 'كم تبي تعطي مبلغ غير قانوني'
												}, function(data14, menu14)
													local smdoidhodhud = tonumber(data14.value)
													if not smdoidhodhud then
														ESX.ShowNotification(_U('quantity_invalid'))
													else
														menu14.close()
														ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'admin_menu_15', {
															title    = 'الرجاء إدخال السبب'
														}, function(data15, menu15)
															local smdoidhodhud15 = tostring(data15.value)
															if not smdoidhodhud15 then
																ESX.ShowNotification(_U('quantity_invalid'))
															else
																menu15.close()
																ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'password_give', {
																	title = 'ادخل الباسورد'
																}, function(data_password, menu_password)
																	local password2 = data_password.value
																	if password2 == nil then
																		ESX.ShowNotification(_U('quantity_invalid'))
																	else
																		menu_password.close()
																		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Confiorm_adminmenu', {
																			title    = '<font color=green>تأكيد</font> - اضافة مبلغ غير قانوني',
																			align    = 'top-left',
																			elements = {
																				{ label = '<font color=red>إلغاء</font>', value = 'no' },
																				{ label = '<font color=green>تأكيد</font>', value = 'yes' },
																			}
																		}, function(data99, menu99)
																			if data99.current.value == 'no' then
																				menu99.close()
																			else
																				TriggerServerEvent('esx_adminjob:givePlayerMoney', {id = data2.current.value, securityToken = securityToken}, data3.current.value, smdoidhodhud, '', smdoidhodhud15, password2)
																				menu99.close()
																			end
																		end, function(data99, menu99)
																			menu99.close()
																		end)
																	end
																end, function(data_password, menu_password)
																	menu_password.close()
																end)
															end
														end, function(data15, menu15)
															menu15.close()
														end)
													end
												end, function(data14, menu14)
													menu14.close()
												end)
											elseif data3.current.value == 's7b_money_from_cash' then
												ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'admin_menu_3', {
													title    = 'كم تبي تسحب مبلغ من ( الكاش )'
												}, function(data14, menu14)
													local smdoidhodhud = tonumber(data14.value)
													if not smdoidhodhud then
														ESX.ShowNotification(_U('quantity_invalid'))
													else
														menu14.close()
														ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'admin_menu_15', {
															title    = 'الرجاء إدخال السبب'
														}, function(data15, menu15)
															local smdoidhodhud15 = tostring(data15.value)
															if not smdoidhodhud15 then
																ESX.ShowNotification(_U('quantity_invalid'))
															else
																menu15.close()
																ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'password_give', {
																	title = 'ادخل الباسورد'
																}, function(data_password, menu_password)
																	local password3 = data_password.value
																	if password3 == nil then
																		ESX.ShowNotification(_U('quantity_invalid'))
																	else
																		menu_password.close()
																		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Confiorm_adminmenu', {
																			title    = '<font color=green>تأكيد</font> - سحب مبلغ',
																			align    = 'top-left',
																			elements = {
																				{ label = '<font color=red>إلغاء</font>', value = 'no' },
																				{ label = '<font color=green>تأكيد</font>', value = 'yes' },
																			}
																		}, function(data99, menu99)
																			if data99.current.value == 'no' then
																				menu99.close()
																			else
																				TriggerServerEvent('esx_adminjob:givePlayerMoney', {id = data2.current.value, securityToken = securityToken}, data3.current.value, smdoidhodhud, '', smdoidhodhud15, password3)
																				menu99.close()
																			end
																		end, function(data99, menu99)
																			menu99.close()
																		end)
																	end
																end, function(data_password, menu_password)
																	menu_password.close()
																end)
															end
														end, function(data15, menu15)
															menu15.close()
														end)
													end
												end, function(data14, menu14)
													menu14.close()
												end)
											elseif data3.current.value == 's7b_money_from_bank' then
												ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'admin_menu_3', {
													title    = 'كم تبي تسحب مبلغ من ( البنك )'
												}, function(data14, menu14)
													local smdoidhodhud = tonumber(data14.value)
													if not smdoidhodhud then
														ESX.ShowNotification(_U('quantity_invalid'))
													else
														menu14.close()
														ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'admin_menu_15', {
															title    = 'الرجاء إدخال السبب'
														}, function(data15, menu15)
															local smdoidhodhud15 = tostring(data15.value)
															if not smdoidhodhud15 then
																ESX.ShowNotification(_U('quantity_invalid'))
															else
																menu15.close()
																ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'password_give', {
																	title = 'ادخل الباسورد'
																}, function(data_password, menu_password)
																	local password3 = data_password.value
																	if password3 == nil then
																		ESX.ShowNotification(_U('quantity_invalid'))
																	else
																		menu_password.close()
																		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Confiorm_adminmenu', {
																			title    = '<font color=green>تأكيد</font> - سحب مبلغ',
																			align    = 'top-left',
																			elements = {
																				{ label = '<font color=red>إلغاء</font>', value = 'no' },
																				{ label = '<font color=green>تأكيد</font>', value = 'yes' },
																			}
																		}, function(data99, menu99)
																			if data99.current.value == 'no' then
																				menu99.close()
																			else
																				TriggerServerEvent('esx_adminjob:givePlayerMoney', {id = data2.current.value, securityToken = securityToken}, data3.current.value, smdoidhodhud, '', smdoidhodhud15, password3)
																				menu99.close()
																			end
																		end, function(data99, menu99)
																			menu99.close()
																		end)
																	end
																end, function(data_password, menu_password)
																	menu_password.close()
																end)
															end
														end, function(data15, menu15)
															menu15.close()
														end)
													end
												end, function(data14, menu14)
													menu14.close()
												end)
											elseif data3.current.value == 'admin_menu1010' then
												ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'admin_menu_3', {
													title    = 'كم تبي تسحب مبلغ غير قانوني'
												}, function(data14, menu14)
													local smdoidhodhud = tonumber(data14.value)
													if not smdoidhodhud then
														ESX.ShowNotification(_U('quantity_invalid'))
													else
														menu14.close()
														ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'admin_menu_15', {
															title    = 'الرجاء إدخال السبب'
														}, function(data15, menu15)
															local smdoidhodhud15 = tostring(data15.value)
															if not smdoidhodhud15 then
																ESX.ShowNotification(_U('quantity_invalid'))
															else
																menu15.close()
																ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'password_give', {
																	title = 'ادخل الباسورد'
																}, function(data_password, menu_password)
																	local password4 = data_password.value
																	if password4 == nil then
																		ESX.ShowNotification(_U('quantity_invalid'))
																	else
																		menu_password.close()
																		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Confiorm_adminmenu', {
																			title    = '<font color=green>تأكيد</font> - سحب مبلغ غير قانوني',
																			align    = 'top-left',
																			elements = {
																				{ label = '<font color=red>إلغاء</font>', value = 'no' },
																				{ label = '<font color=green>تأكيد</font>', value = 'yes' },
																			}
																		}, function(data99, menu99)
																			if data99.current.value == 'no' then
																				menu99.close()
																			else
																				TriggerServerEvent('esx_adminjob:givePlayerMoney', {id = data2.current.value, securityToken = securityToken}, data3.current.value, smdoidhodhud, '', smdoidhodhud15, password4)
																				menu99.close()
																			end
																		end, function(data99, menu99)
																			menu99.close()
																		end)
																	end
																end, function(data_password, menu_password)
																	menu_password.close()
																end)
															end
														end, function(data15, menu15)
															menu15.close()
														end)
													end
												end, function(data14, menu14)
													menu14.close()
												end)
											elseif data3.current.value == 'ataganthar' then
												OpenFineCategoryAdminMenuAnthar(data2.current.value)
											elseif data3.current.value == 'sglalabanthar' then
												OpenpaidBillsAntharlogMenu(data2.current.value)
											elseif data3.current.value == 'sglalab' then
												OpenpaidBillslogMenu(data2.current.value)
											elseif data3.current.value == 'ataghramh' then
												ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'jali_menu_playerzz', {
													title = 'قائمة اعطاء غرامة',
													align = 'top-left',
													elements = {
														{label = '<font color=green>خيارات الغرامات</font>', value = 'khearat_ghramat'},
														{label = '<font color=orange>كتابة الغرامة بنفسك</font>', value = 'ktabt_alghramh_bnfsk'}
													}
												}, function(data6, menu6)
													if data6.current.value == 'khearat_ghramat' then
														OpenFineCategoryAdminkhearatMenu(data2.current.value)
													elseif data6.current.value == 'ktabt_alghramh_bnfsk' then
														if grade >= 2 then
														OpenFineCategoryAdminMenu(data2.current.value)
														end
													end
												end, function(data6, menu6)
													menu6.close()
											end)
											elseif data3.current.value == 'kill' then
												menu3.close()
												TriggerServerEvent('esx_adminjob:killPlayer', Playerid)
												TriggerServerEvent('Mina:8adoji2adminjob:killkickfreeze', ('قتل عبر f6 رقابة'), "***تم قتل لاعب من قبل***", " \n steam `"..GetPlayerName(PlayerId()).."` \n لاعب الذي تم تجميده \n `id: "..Playerid.."` (`"..name.."`)", 15158332)
											elseif data3.current.value == 'kick' then
											ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'kick_confirm', {
												title = "هل أنت متأكد من طرد اللاعب من السيرفر? <font color=green>"..name.."</font>?",
												align = 'top-left',
												elements = {
													{label = _U('no'), value = 'no'},
													{label = _U('yes'), value = 'yes'}
												}}, function(data, menu)
													menu.close()
													if data.current.value == 'yes' then
														TriggerServerEvent('esx_adminjob:kickplayerFromServer', Playerid)
														TriggerServerEvent('_chat:messageEntered', GetPlayerName(PlayerId()), { 0, 0, 0 }, "تم فصل^3 "..name.."^0 من السيرفر")
														TriggerServerEvent('Mina:8adoji2adminjob:killkickfreeze', ('طرد لاعب!'), "***تم طرد لاعب من قبل***", " \n steam `"..GetPlayerName(PlayerId()).."` \n الاعب الذي تم طرده \n `id: "..Playerid.."` (`"..name.."`)", 15158332)
													end
												end)
											elseif data3.current.value == 'revive_player' then
												ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'kick_confirm', {
													title = "هل أنت متأكد من <font color=green>إنعاش</font> اللاعب : <font color=green>"..name.."</font>?",
													align = 'top-left',
													elements = {
														{label = _U('no'), value = 'no'},
														{label = _U('yes'), value = 'yes'}
													}}, function(data, menu)
														menu.close()
														if data.current.value == 'yes' then
															menu3.close()
															TriggerServerEvent('esx_ambulancejob:revive', data2.current.value)
															TriggerServerEvent('Mina:lad97ygadminjob:f6revive', ('أنعاش لاعب'), "***تم أنعاش لاعب من قبل***", " \n steam `"..GetPlayerName(PlayerId()).."` \n الاعب الذي تم أنعاشه \n `id: "..Playerid.."` (`"..name.."`)", 15158332)
														end
												end)
											elseif data3.current.value == 'goto' then
												ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'kick_confirm', {
													title = "هل أنت متأكد من الإنتقال للاعب؟ <font color=green>"..name.."</font>?",
													align = 'top-left',
													elements = {
														{label = _U('no'), value = 'no'},
														{label = _U('yes'), value = 'yes'}
													}}, function(data, menu)
														menu.close()
														if data.current.value == 'yes' then
															menu3.close()
															TriggerServerEvent('esx_adminjob:goto', Playerid, name)
															TriggerServerEvent('Mina:ol2349oadminjob:gotobring', ('أنتقال'), "***ذهب المراقب الى لاعب***", " \n steam `"..GetPlayerName(PlayerId()).."` \n الاعب \n `id: "..Playerid.."` (`"..name.."`)", 15158332)
														end
												end)
											elseif data3.current.value == 'bring' then
												ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'kick_confirm', {
													title = "هل أنت متأكد من سحب اللاعب لك <font color=green>"..name.."</font>?",
													align = 'top-left',
													elements = {
														{label = _U('no'), value = 'no'},
														{label = _U('yes'), value = 'yes'}
													}}, function(data, menu)
														menu.close()
														if data.current.value == 'yes' then
															menu3.close()
															TriggerServerEvent('esx_adminjob:bring', Playerid, name)
															TriggerServerEvent('Mina:ol2349oadminjob:gotobring', ('سحب لاعب'), "***قام المراقب بسحب لاعب***", " \n steam `"..GetPlayerName(PlayerId()).."` \n الاعب \n `id: "..Playerid.."` (`"..name.."`)", 15158332)
														end
												end)
											elseif data3.current.value == 'weapon_player' then
												menu3.close()
												TriggerServerEvent('esx_adminjob:weaponPlayer', Playerid, name)
											elseif data3.current.value == 'weapon_player_2' then
												menu3.close()
												TriggerServerEvent('esx_adminjob:weaponPlayer2', Playerid, name)
											elseif data3.current.value == 'addxp' then
												menu.close()
												ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'jail_choose_time_menu', {
													title = "العدد؟"
												}, function(data2, menu2)
													local jailTime = tonumber(data2.value)
													if jailTime == nil then
														ESX.ShowNotification("يجب أن يكون العدد صحيح!")
													else
														menu2.close()

															ESX.UI.Menu.Open(
																'dialog', GetCurrentResourceName(), 'jail_choose_reason_menu',
																{
																title = "سبب الإضافة"
																},
															function(data3, menu3)
											
																local reason = data3.value
											
																if reason == nil then
																	ESX.ShowNotification("يجب ملئ سبب الإضافة")
																else
																	menu3.close()
																	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'password_give', {
																		title = 'ادخل الباسورد'
																	}, function(data_password, menu_password)
																		local password_xp = data_password.value
																		if password_xp == nil then
																			ESX.ShowNotification(_U('quantity_invalid'))
																		else
																			menu_password.close()
																			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
																				title = "هل أنت متأكد من <font color=green>إعطاء</font> <font color=#5DADE2>"..jailTime.."</font> خبرة للاعب: <font color=green>"..name.."</font>?",
																				align = 'top-left',
																				elements = {
																					{label = _U('no'), value = 'no'},
																					{label = _U('yes'), value = 'yes'}
																				}
																			}, function(data, menu)
																				menu.close()
																				if data.current.value == 'yes' then
																					TriggerServerEvent("esx_adminjob:giveplayerxp", Playerid, jailTime, reason, name, password_xp) -- jailTime = xp
																				end
																			end, function(data, menu)
																				menu.close()
																			end)
																		end
																	end, function(data_password, menu_password)
																		menu_password.close()
																	end)
																end
											
															end, function(data3, menu3)
																menu3.close()
															end)

													end
												end, function(data2, menu2)
													menu2.close()
												end)
											elseif data3.current.value == 'jail' then
												menu.close()
												ESX.UI.Menu.Open(
													'dialog', GetCurrentResourceName(), 'jail_choose_time_menu',
													{
														title = "مدة السجن؟"
													},
												function(data2, menu2)

													local jailTime = tonumber(data2.value)

													if jailTime == nil then
														ESX.ShowNotification("يجب أن يكون العدد صحيح!")
													else
														menu2.close()

															ESX.UI.Menu.Open(
																'dialog', GetCurrentResourceName(), 'jail_choose_reason_menu',
																{
																title = "أكتب اي شي هنا ضروري عشان تسجن"
																},
															function(data3, menu3)
											
																local reason = data3.value
											
																if reason == nil then
																	ESX.ShowNotification("يجب ملئ سبب السجن")
																else
																	menu3.close()
																--print("jail "..Playerid.." "..jailTime.." "..reason)
																TriggerServerEvent('esx_jail:jailPlayer', Playerid, jailTime, reason)
																TriggerServerEvent('esx_misc3:jailLog', Playerid, reason)		  
																end
											
															end, function(data3, menu3)
																menu3.close()
															end)

													end

												end, function(data2, menu2)
													menu2.close()
												end)
											elseif data3.current.value == 'unjail' then
												ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'kick_confirm', {
													title = "هل أنت متأكد من إخراج اللاعب من السجن <font color=green>"..name.."</font>?",
													align = 'top-left',
													elements = {
														{label = '<font color=gray>لاتضغط في حال ماكان مسجون</font>'},
														{label = _U('no'), value = 'no'},
														{label = _U('yes'), value = 'yes'}
												}}, function(data, menu)
													menu.close()
													if data.current.value == 'yes' then
														ExecuteCommand("unjail "..Playerid)			
														TriggerServerEvent("esx_misc3:unjailLog", Playerid)
													end
												end)
											elseif data3.current.value == 'removexp' then

												menu.close()

												ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'jail_choose_time_menu', {
														title = "العدد المراد ازالتها"
												},function(data2, menu2)
													local jailTime = tonumber(data2.value)

													if jailTime == nil then
														ESX.ShowNotification("يجب أن يكون العدد صحيح!")
													else
														menu2.close()
														ESX.UI.Menu.Open(
															'dialog', GetCurrentResourceName(), 'jail_choose_reason_menu',
															{
																title = "سبب الإزالة"
															},
														function(data3, menu3)
											
															local reason = data3.value
											
															if reason == nil then
																ESX.ShowNotification("يرجى ملئ سبب الإزالة")
															else
																menu3.close()
																ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'password_give', {
																	title = 'ادخل الباسورد'
																}, function(data_password, menu_password)
																	local password_remove_xp = data_password.value
																	if password_remove_xp == nil then
																		ESX.ShowNotification(_U('quantity_invalid'))
																	else
																		menu_password.close()
																		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
																			title = "هل أنت متأكد من <font color=red>خصم</font> <font color=#5DADE2>"..jailTime.."</font> خبرة من اللاعب: <font color=green>"..name.."</font>?",
																			align = 'top-left',
																			elements = {
																				{label = _U('no'), value = 'no'},
																				{label = _U('yes'), value = 'yes'}
																			}
																		}, function(data, menu)
																			menu.close()
																			if data.current.value == 'yes' then
																				TriggerServerEvent("esx_adminjob:removeXpFromPlayer", Playerid, jailTime, reason, password_remove_xp)
																			end
																		end, function(data, menu)
																			menu.close()
																		end)
																	end
																end, function(data_password, menu_password)
																	menu_password.close()
																end)
															end
														end, function(data3, menu3)
															menu3.close()
														end)
													end
												end, function(data2, menu2)
													menu2.close()
												end)						
											end
										end, function(data3, menu3)
											menu3.close()
										end)
									else
										ESX.ShowNotification('الاعب غير متصل او الأيدي غير صحيح')
									end
								end, id)
				end
          	end, function(data2, menu2)
				menu2.close()
			end)
				else
					local elements = {}
					if grade >= 1 then
						-- table.insert(elements, {label = "<font color=red>باند 🔒</font>", value = 'banned'})
					end
					table.insert(elements, {label = _U('freeze'), value = 'freeze'}) -- تجميد
					table.insert(elements, {label = _U('revive_player'), value = 'revive_player'}) -- انعاش
					table.insert(elements, {label = _U('kill'), value = 'kill'}) -- قتل ؟
					table.insert(elements, {label = _U('kick'), value = 'kick'}) -- طرد
					table.insert(elements, {label = _U('goto'), value = 'goto'}) -- انتقال
					table.insert(elements, {label = _U('bring'), value = 'bring'}) -- سحب 'esx_adminjob:weaponPlayer2
					table.insert(elements, {label = 'مراقبة الأعب', value = 'spec_to_player'}) -- مراقبة
					table.insert(elements, {label = 'نقل الأعب', value = 'teleport_player_gh'}) -- 
					table.insert(elements, {label = _U('search'), value = 'searchbodyplayer'}) --  هاذا تفتيش
					table.insert(elements, {label = _U('handcuff'), value = 'handcuff'})
					table.insert(elements, {label = "الأستعلام عن <font color=#F1C40F>"..data2.current.name.."</font>", value = 'getinfo'})
					table.insert(elements, {label = "الأستعلام عن <font color=#5DADE2>خبرة</font> <font color=#F1C40F>"..data2.current.name.."</font>", value = 'getxp'})
					if grade >= 3 then
						table.insert(elements, {label = _U('weapon_player'), value = 'weapon_player'}) -- اعطاء سلاح مسدس
						table.insert(elements, {label = "اعطاء شوزن ", value = 'weapon_player_2'}) -- اعطاء سلاح شوزن
						table.insert(elements, {label = "<span style='color:orange;'>إعطاء قائمة الإنتقال 🛸</span>", value = 'Givetp'})
						table.insert(elements, {label = "<span style='color:yellow;'>إعطاء قائمة تغيير شكل 👚</span>", value = 'give_menu_skin'})
						table.insert(elements, {label = "<span style='color:purple;'>إعطاء وظيفة 💼</span>", value = 'give_jops'})
						table.insert(elements, {label = "<span style='color:yellow;'>تغيير اسم هوية الاعب 💳</span>", value = 'change_name_player'})
						table.insert(elements, {label = "<span style='color:gray;'>اعطاء ايتم</span>", value = 'give_item'})
						table.insert(elements, {label = "<span style='color:gray;'>استعلام عن المركبات</span>", value = 'check_veh'})
						table.insert(elements, {label = "ارسال رسالة الى الأعب", value = 'send_message_to_player'})
						table.insert(elements, {label = "<span style='color:#0fd644;'>اضافة مبلغ في ( الكاش ) ⏫ <br><span  style='color:#FF0E0E;font-size:15'>تنبيه: <span style='color:gray;'>يمنع الأستعمال الا في حال استشارة الادارة العليا", value = 'ataflows_cash'})
						table.insert(elements, {label = "<span style='color:#0fd644;'>اضافة مبلغ في ( البنك ) ⏫ <br><span  style='color:#FF0E0E;font-size:15'>تنبيه: <span style='color:gray;'>يمنع الأستعمال الا في حال استشارة الادارة العليا", value = 'ataflows_bank'})
						table.insert(elements, {label = "<span style='color:#0fd644;'>اضافة مبلغ غير قانوني ⏫ <br><span  style='color:#FF0E0E;font-size:15'>تنبيه: <span style='color:gray;'>يمنع الأستعمال الا في حال استشارة الادارة العليا", value = 'ataflowsblack'})
						table.insert(elements, {label = "<span style='color:#d60f0f;'>سحب مبلغ من ( الكاش ) ⏬ <br><span  style='color:#FF0E0E;font-size:15'>تنبيه: <span style='color:gray;'>يمنع الأستعمال الا في حال استشارة الادارة العليا", value = 's7b_money_from_cash'})
						table.insert(elements, {label = "<span style='color:#d60f0f;'>سحب مبلغ من ( البنك ) ⏬ <br><span  style='color:#FF0E0E;font-size:15'>تنبيه: <span style='color:gray;'>يمنع الأستعمال الا في حال استشارة الادارة العليا", value = 's7b_money_from_bank'})
						table.insert(elements, {label = "<span style='color:#d60f0f;'>سحب مبلغ غير قانوني ⏬ <br><span  style='color:#FF0E0E;font-size:15'>تنبيه: <span style='color:gray;'>يمنع الأستعمال الا في حال استشارة الادارة العليا", value = 'admin_menu1010'})
						table.insert(elements, {label = "<span style='color:#0fd644;'>اضافة خبرة ⏫ <br><span  style='color:#FF0E0E;font-size:15'>تنبيه: <span style='color:gray;'>يمنع الأستعمال الا في حال استشارة الادارة العليا", value = 'addxp'})
						table.insert(elements, {label = "<span style='color:#d60f0f;'>ازالة خبرة ⏬ <br><span  style='color:#FF0E0E;font-size:15'>تنبيه: <span style='color:gray;'>يمنع الأستعمال الا في حال استشارة الادارة العليا", value = 'removexp'})
						table.insert(elements, {label = '<span style="color:#0fd644;"> سجل الغرامات <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">سجل الاعب في الغرامات', value = 'sglalab'})
						table.insert(elements, {label = '<span style="color:#E1790B;"> غرامة اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">اعطاء غرامة للاعب', value = 'ataghramh'})
						table.insert(elements, {label =  '<span style="color:#0fd644;"> سجل الانذارات <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">سجل الاعب في الانذارات', value = 'sglalabanthar'})
						table.insert(elements, {label = '<span style="color:#E1790B;"> انذار اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">اعطاء انذار للاعب', value = 'ataganthar'})
						table.insert(elements, {label = '<span style="color:#E1790B;"> أستدعاء اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">أستدعاء الاعب', value = 'asd3a_ala3b'})
						table.insert(elements, {label = '<span style="color:#E1790B;"> سجن اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">سجن هاذه الاعب', value = 'jail'})
						table.insert(elements, {label = '<span style="color:#E1790B;"> إعفاء اللاعب من عقوبة السجن <br><span  style="color:#FF0E0E;font-size:15">تنبيه: <span style="color:gray;">لاتضغط في حال لاعب ماكان مسجون', value = 'unjail'})
					elseif grade >= 2 then
						table.insert(elements, {label = "ارسال رسالة الى الأعب", value = 'send_message_to_player'})
						table.insert(elements, {label = "<span style='color:purple;'>إعطاء قائمة تغيير شكل 👚</span>", value = 'give_menu_skin'})
						table.insert(elements, {label = "<span style='color:purple;'>إعطاء وظيفة 💼</span>", value = 'give_jops'})
						table.insert(elements, {label = "<span style='color:gray;'>اعطاء ايتم</span>", value = 'give_item'})
						table.insert(elements, {label = "<span style='color:gray;'>استعلام عن المركبات</span>", value = 'check_veh'})
						table.insert(elements, {label = "<span style='color:#0fd644;'>اضافة خبرة ⏫ <br><span  style='color:#FF0E0E;font-size:15'>تنبيه: <span style='color:gray;'>يمنع الأستعمال الا في حال استشارة الادارة العليا", value = 'addxp'})
						table.insert(elements, {label = "<span style='color:#d60f0f;'>ازالة خبرة ⏬ <br><span  style='color:#FF0E0E;font-size:15'>تنبيه: <span style='color:gray;'>يمنع الأستعمال الا في حال استشارة الادارة العليا", value = 'removexp'})
						table.insert(elements, {label = '<span style="color:#0fd644;"> سجل الغرامات <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">سجل الاعب في الغرامات', value = 'sglalab'})
						table.insert(elements, {label = '<span style="color:#E1790B;"> غرامة اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">اعطاء غرامة للاعب', value = 'ataghramh'})
						table.insert(elements, {label = '<span style="color:#0fd644;"> سجل الانذارات <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">سجل الاعب في الانذارات', value = 'sglalabanthar'})
						table.insert(elements, {label = '<span style="color:#E1790B;"> انذار اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">اعطاء انذار للاعب', value = 'ataganthar'})
						table.insert(elements, {label = '<span style="color:#E1790B;"> أستدعاء اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">أستدعاء الاعب', value = 'asd3a_ala3b'})
						table.insert(elements, {label = '<span style="color:#E1790B;"> سجن اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">سجن هاذه الاعب', value = 'jail'})
						table.insert(elements, {label = '<span style="color:#E1790B;"> إعفاء اللاعب من عقوبة السجن <br><span  style="color:#FF0E0E;font-size:15">تنبيه: <span style="color:gray;">لاتضغط في حال لاعب ماكان مسجون', value = 'unjail'})
					elseif grade >= 1 then
						table.insert(elements, {label = "ارسال رسالة الى الأعب", value = 'send_message_to_player'})
						table.insert(elements, {label = "<span style='color:purple;'>إعطاء قائمة تغيير شكل 👚</span>", value = 'give_menu_skin'})
						table.insert(elements, {label = "<span style='color:purple;'>إعطاء وظيفة 💼</span>", value = 'give_jops'})
						table.insert(elements, {label = '<span style="color:#0fd644;"> سجل الغرامات <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">سجل الاعب في الغرامات', value = 'sglalab'})
						table.insert(elements, {label = '<span style="color:#E1790B;"> غرامة اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">اعطاء غرامة للاعب', value = 'ataghramh'})
						table.insert(elements, {label =  '<span style="color:#0fd644;"> سجل الانذارات <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">سجل الاعب في الانذارات', value = 'sglalabanthar'})
						table.insert(elements, {label = '<span style="color:#E1790B;"> انذار اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">اعطاء انذار للاعب', value = 'ataganthar'})
						table.insert(elements, {label = '<span style="color:#E1790B;"> أستدعاء اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">أستدعاء الاعب', value = 'asd3a_ala3b'})
						table.insert(elements, {label = '<span style="color:#E1790B;"> سجن اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">سجن هاذه الاعب', value = 'jail'})
						table.insert(elements, {label = '<span style="color:#E1790B;"> إعفاء اللاعب من عقوبة السجن <br><span  style="color:#FF0E0E;font-size:15">تنبيه: <span style="color:gray;">لاتضغط في حال لاعب ماكان مسجون', value = 'unjail'})
					else
						table.insert(elements, {label = "ارسال رسالة الى الأعب", value = 'send_message_to_player'})
						table.insert(elements, {label = '<span style="color:#0fd644;"> سجل الغرامات <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">سجل الاعب في الغرامات', value = 'sglalab'})
						table.insert(elements, {label = '<span style="color:#E1790B;"> غرامة اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">اعطاء غرامة للاعب', value = 'ataghramh'})
						table.insert(elements, {label = '<span style="color:#0fd644;"> سجل الانذارات <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">سجل الاعب في الانذارات', value = 'sglalabanthar'})
						table.insert(elements, {label = '<span style="color:#E1790B;"> انذار اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">اعطاء انذار للاعب', value = 'ataganthar'})
						table.insert(elements, {label = '<span style="color:#E1790B;"> أستدعاء اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">أستدعاء الاعب', value = 'asd3a_ala3b'})
						table.insert(elements, {label = '<span style="color:#E1790B;"> سجن اللاعب <br><span  style="color:#FF0E0E;font-size:15"><span style="color:gray;">سجن هاذه الاعب', value = 'jail'})
						table.insert(elements, {label = '<span style="color:#E1790B;"> إعفاء اللاعب من عقوبة السجن <br><span  style="color:#FF0E0E;font-size:15">تنبيه: <span style="color:gray;">لاتضغط في حال لاعب ماكان مسجون', value = 'unjail'})
					end
					if grade >= 4 then
						table.insert(elements, {label = "<span style='color:#0bddf0;'>-----------  التعويضات  ------------ </span>"}) -- 
						table.insert(elements, {label = "<span style='color:green;'>اعطاء رخصة </span>", value = 'give_lsn'}) -- 
						table.insert(elements, {label = "<span style='color:red;'>سحب رخصة </span>", value = 'remove_lsn'}) -- 
						table.insert(elements, {label = "<span style='color:purple;'>اعطاء مركبة للكراج🚗 </span>", value = 'givecar'}) -- 
						table.insert(elements, {label = "<span style='color:#0bddf0;'>اعطاء متجر 🏪 </span>", value = 'giveshop'}) -- 
						table.insert(elements, {label = "<span style='color:#106D87;'>اعطاء ضعف خبرة ورواعي🏅💠</span>", value = 'givebkg'}) -- مراقبة
						table.insert(elements, {label = "<span style='color:red;'>سحب متجر 🏪 </span>", value = 'removeshop'}) -- 

					end
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_name', {
					   --local name = data2.current.name
						--local Playerid = data2.current.value
						--title    = _U('player_name', data2.current.value),
						title    = "["..data2.current.value.."] "..data2.current.name,
						align    = Config.MenuAlign,
						elements = elements
					}, function(data3, menu3)
						--menu3.close()
						local name = data2.current.name
						local Playerid = data2.current.value
						if data3.current.value == 'getxp' then
							if Cooldown_count == 0 then
								Cooldown(4)
								ESX.TriggerServerCallback('getRankPlayer:getRankPlayerByMenuwesam', function(xp)
									ESX.ShowNotification('<font color=#5DADE2>'..xp..'</font> خبرة اللاعب')
								end, data2.current.value)
							else
								ESX.ShowNotification('<font color=red>يجب الأنتظار</font>. <font color=orange>'..Cooldown_count..' ثانية')
							end
						elseif data3.current.value == "banned" then
							menu3.close()
							ESX.UI.Menu.Open("default", GetCurrentResourceName(), "banned_menu", {
								title = data3.current.label,
								align = "top-left",
								elements = {
									{label = data3.current.label .. " 1 يوم", time = 86400, is_perment = false},
									{label = data3.current.label .. " 2 يومين", time = 172800, is_perment = false},
									{label = data3.current.label .. " 7 ايام (اسبوع)", time = 518400, is_perment = false},
									{label = data3.current.label .. " 14 يوم (اسبوعين)", time = 1123200, is_perment = false},
									{label = data3.current.label .. " 30 يوم (شهر)", time = 2678400, is_perment = false},
									{label = "<font color=red>باند</font> نهائي 🔒", time = 10444633200, is_perment = true},
								}
							}, function(data_banned, menu_banned)
								if data_banned.current.time then
									menu_banned.close()
									ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'reason_banned_menu', {
										title    = 'اكتب السبب'
									}, function(data30, menu30)
										local reason = data30.value
										if reason == nil or reason == '' then
											ESX.ShowNotification('اكتب السبب')
										else
											menu30.close()
											ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'message_confierm', {
												title    = 'تأكيد <font color=red>تبنيد</font> الاعب <font color=orange>' .. name .. "</font> لمدة <font color=orange>" .. data_banned.current.label .. "</font>",
												align    = 'top-left',
												elements = {
													{ label = '<font color=red>إلغاء</font>', value = 'no' },
													{ label = '<font color=green>تأكيد</font>', value = 'yes' },
												}
											}, function(data97, menu97)
												if data97.current.value == 'no' then
													menu97.close()
												else
													menu97.close()
													if data_banned.current.is_perment then
														TriggerServerEvent("EasyAdmin:banPlayer", Playerid, reason, reason, "نهائي 🔒", data_banned.current.time)
													else
														TriggerServerEvent("EasyAdmin:banPlayer", Playerid, reason, reason, TimerConvert(data_banned.current.time), data_banned.current.time)
													end
												end
											end, function(data97, menu97)
												menu97.close()
											end)
										end
									end, function(data30, menu30)
										menu.close()
									end)
								end
							end, function(data_banned, menu_banned)
								menu_banned.close()
							end)
						elseif data3.current.value == "license" then
							ShowPlayerLicense2(Playerid)
						elseif data3.current.value == "handcuff" then
							TriggerServerEvent('esx_misc:startAreszt',Playerid)
						elseif data3.current.value == "take_lic" then
							ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'take_lic_menu', {
								title    = 'اكتب السبب'
							}, function(data30, menu30)
								local reason = data30.value
								if reason == nil or reason == '' then
									ESX.ShowNotification('اكتب السبب')
								else
									menu30.close()
									TriggerServerEvent('esx_adminjob:takelic', Playerid, reason)
								end
							end)
						elseif data3.current.value == "searchbodyplayer" then
							OpenBodySearchMenu2(data2.current.value)
						elseif data3.current.value == 'send_message_to_player' then
							ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'message_enter', {
								title    = 'اكتب الرسالة'
							}, function(data30, menu30)
								local message = data30.value
								if message == nil or message == '' then
									ESX.ShowNotification('اكتب الرسالة')
								else
									menu30.close()
									ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'message_confierm', {
										title    = '<font color=green>تأكيد ارسال الرسالة</font>'..' - ' .. message,
										align    = 'top-left',
										elements = {
											{ label = '<font color=red>إلغاء</font>', value = 'no' },
											{ label = '<font color=green>تأكيد</font>', value = 'yes' },
										}
									}, function(data97, menu97)
										if data97.current.value == 'no' then
											menu97.close()
										else
											TriggerServerEvent('esx_adminjob:send_messag_to_player', message, Playerid)
											menu97.close()
										end
									end, function(data97, menu97)
										menu97.close()
									end)
								end
							end, function(data30, menu30)
								menu30.close()
							end)
						elseif data3.current.value == 'check_veh' then
							ESX.TriggerServerCallback('leojob:getPlayerCars', function(Cars)
								local Carsssss = {}
								local HaveOverOne = false
								for i = 1, #Cars, 1 do
									if Cars[i] then
										table.insert(Carsssss, { label = '<font color=gray>اسم المركبة: '..Cars[i].name..' | رقم اللوحة: '..tostring(Cars[i].plate)..'</font>', value = Cars[i].plate, name = Cars[i].name})
										HaveOverOne = true
									end
								end

								if not HaveOverOne then
									table.insert(Carsssss, { label = '<font color=gray>لا توجد أي مركبة مسجلة بأسم اللاعب</font>', value = nil })
								end

								ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'admin_menu_cars', {
									title    = data3.current.label,
									align    = 'top-left',
									elements = Carsssss
								}, function(data55, menu55)
									ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "reason_take_car", {
										title = "ادخل السبب",
									}, function(data_reason_take_car, menu_reason_take_car)
										if data_reason_take_car.value == nil then
											ESX.ShowNotification("رجاء ادخل سبب")
										else
											menu_reason_take_car.close()
											ESX.UI.Menu.Open("default", GetCurrentResourceName(), "take_car_from_player", {
												title = "هل انت متاكد",
												align = "top-left",
												elements = {
													{label = "نعم", value = "yes"},
													{label = "لا", value = "no"}
												}
											}, function(data_take_car, menu_take_car)
												if data_take_car.current.value == "yes" then
													menu_take_car.close()
													TriggerServerEvent("esx_adminjob:wesam:take:car", Playerid, data55.current.value, data55.current.name, data_reason_take_car.value)
												else
													menu_take_car.close()
												end
											end, function(data_take_car, menu_take_car)
												menu_take_car.close()
											end)
										end
									end, function(data_reason_take_car, menu_reason_take_car)
										menu_reason_take_car.close()
									end)
								end, function(data55, menu55)
									menu55.close()
								end)
							end, Playerid)
						elseif data3.current.value == 'give_item' then
							ESX.TriggerServerCallback('esx_adminjob:getItemsFromdatabase', function(items) 
								local itemslist = {}
								for i = 1, #items, 1 do
									table.insert(itemslist, { label = items[i].label, value = items[i].name })
								end

								ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'admin_menu_itemmss', {
									title    = 'الرجاء اختيار الآيتم',
									align    = 'top-left',
									elements = itemslist
								}, function(data55, menu55)
									ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'admin_menu_3', {
										title    = 'الرجاء تحديد القيمة'
									}, function(data14, menu14)
										local smdoidhodhud = tonumber(data14.value)
										if not smdoidhodhud then
											ESX.ShowNotification(_U('quantity_invalid'))
										else
											menu14.close()
											ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Confiorm_adminmenu', {
												title    = '<font color=green>تأكيد</font>',
												align    = 'top-left',
												elements = {
													{ label = '<font color=red>إلغاء</font>', value = 'no' },
													{ label = '<font color=green>تأكيد</font>', value = 'yes' },
												}
											}, function(data99, menu99)
												if data99.current.value == 'no' then
													menu99.close()
												else
													TriggerServerEvent("esx_adminjob:addInventoryToPlayer", data55.current.value, smdoidhodhud, Playerid)
													menu99.close()
												end
											end, function(data99, menu99)
												menu99.close()
											end)
										end
									end, function(data14, menu14)
										menu14.close()
									end)
								end, function(data55, menu55)
									menu55.close()
								end)
							end)
						elseif data3.current.value == 'give_menu_skin' then
							ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Confiorm_adminmenu', {
								title    = '<font color=green>تأكيد</font> - اعطاء قائمة تغيير شكل',
								align    = 'top-left',
								elements = {
									{ label = '<font color=red>إلغاء</font>', value = 'no' },
									{ label = '<font color=green>تأكيد</font>', value = 'yes' },
								}
							}, function(data99, menu99)
								if data99.current.value == 'no' then
									menu99.close()
								else
									TriggerServerEvent('esx_skin:openMenuToPlayer', Playerid)
									menu99.close()
								end
							end, function(data99, menu99)
								menu99.close()
							end)
						elseif data3.current.value == 'give_jops' then
							ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_jobs_player', {
								title = 'قائمة اعطاء وظيفة للاعب 💼',
								align = 'top-left',
								elements = {
									{label = 'وظيفة <span style="color:blue">إدارة الشرطة 👮</span>', value = 'police'},
									{label = 'وظيفة <span style="color:gray">حرس الحدود 🕴</span>', value = 'agent'},
									{label = 'وظيفة <span style="color:red">الهلال الأحمر 🚑</span>', value = 'ambulance'},
									{label = 'وظيفة <span style="color:gray">كراج الميكانيك 🛠️</span>', value = 'mec'},
									{label = 'وظيفة <span style="color:brown">الأخشاب 🌲</span>', value = 'lumberjack'},
									{label = 'وظيفة <span style="color:yellow">الدواجن 🐔</span>', value = 'slaughterer'},
									{label = 'وظيفة <span style="color:pink">الأقمشة 🧵</span>', value = 'tailor'},
									{label = 'وظيفة <span style="color:orange">المعادن 👷</span>', value = 'miner'},
									{label = 'وظيفة <span style="color:red">نفط و غاز ⛽</span>', value = 'fueler'},
									{label = 'وظيفة <span style="color:blue">الأسماك 🐟</span>', value = 'fisherman'},
									{label = 'وظيفة <span style="color:yellow">المزارع 👨‍🌾</span>', value = 'farmer'},
									{label = 'وظيفة <span style="color:yellow">تاكسي 🚕</span>', value = 'taxi'},
									{label = 'وظيفة <span style="color:gray">عاطل</span>', value = 'unemployed'},
								}
							}, function(data00, menu00)
								if data00.current.value == 'police' then
									ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_jobs_player2', {
										title = 'قائمة اعطاء وظيفة للاعب 💼 - <font color=blue>إدارة الشرطة 👮</font>',
										align = 'top-left',
										elements = {
											{label = 'جندي 👮', value = '0'},
											{label = 'جندي أول 👮', value = '1'},
											{label = 'عريف 👮', value = '2'},
											{label = 'وكيل رقيب 👮', value = '3'},
											{label = 'رقيب 👮', value = '4'},
											{label = 'رقيب أول 👮', value = '5'},
											{label = 'رئيس رقباء 👮', value = '6'},
											{label = 'ملازم 👮', value = '7'},
											{label = 'ملازم أول 👮', value = '8'},
											{label = 'نقيب 👮', value = '9'},
											{label = 'رائد 👮', value = '10'},
											{label = 'مقدم 👮', value = '11'},
											{label = 'عقيد 👮', value = '13'},
											{label = 'عميد 👮', value = '15'},
											{label = 'لواء 👮', value = '17'},
											{label = 'فريق 👮', value = '19'},
											{label = 'فريق اول 👮', value = '20'},
											{label = 'نائب قائد الشرطة 👮', value = '23'},
											{label = 'قائد الشرطة 👮', value = '24'},
										}
									}, function(data01, menu01)
										ExecuteCommand('setjob ' .. Playerid .. " police " .. data01.current.value)
										ESX.ShowNotification('تم اعطاء الاعب وظيفة إدارة الشرطة - ' .. data01.current.label)
									end, function(data01, menu01)
										menu01.close()
								end)
								elseif data00.current.value == 'agent' then
									ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_jobs_player3', {
										title = 'قائمة اعطاء وظيفة للاعب 💼 - <font color=red>حرس الحدود 🕴</font>',
										align = 'top-left',
										elements = {
											{label = 'جندي 🕴', value = '0'},
											{label = 'جندي أول 🕴', value = '1'},
											{label = 'عريف 🕴', value = '2'},
											{label = 'وكيل رقيب 🕴', value = '3'},
											{label = 'رقيب 🕴', value = '4'},
											{label = 'رقيب أول 🕴', value = '5'},
											{label = 'رئيس رقباء 🕴', value = '6'},
											{label = 'ملازم 🕴', value = '7'},
											{label = 'ملازم أول 🕴', value = '8'},
											{label = 'نقيب 🕴', value = '9'},
											{label = 'رائد 🕴', value = '10'},
											{label = 'مقدم 🕴', value = '11'},
											{label = 'عقيد 🕴', value = '12'},
											{label = 'عميد 🕴', value = '13'},
											{label = 'لواء 🕴', value = '14'},
											{label = 'نائب قائد حرس الحدود 🕴', value = '15'},
											{label = 'قائد حرس الحدود 🕴', value = '16'},
									}
									}, function(data02, menu02)
										ExecuteCommand('setjob ' .. Playerid .. " agent " .. data02.current.value)
										ESX.ShowNotification('تم اعطاء الاعب وظيفة حرس الحدود - ' .. data02.current.label)										
									end, function(data02, menu02)
										menu02.close()
								end)
								elseif data00.current.value == 'ambulance' then
									ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_jobs_player3', {
										title = 'قائمة اعطاء وظيفة للاعب 💼 - <font color=red>الهلال الأحمر 🚑</font>',
										align = 'top-left',
										elements = {
											{label = 'متدرب 🚑', value = '0'},
											{label = 'مستوى 1 🚑', value = '1'},
											{label = 'مستوى 2 🚑', value = '2'},
											{label = 'مستوى 3 🚑', value = '3'},
											{label = 'مستوى 4 🚑', value = '4'},
											{label = 'مستوى 5 🚑', value = '5'},
											{label = 'مستوى 6 🚑', value = '6'},
											{label = 'مستوى 7 🚑', value = '7'},
											{label = 'مستوى 8 🚑', value = '8'},
											{label = 'مستوى 9 🚑', value = '9'},
											{label = 'مستوى 10 🚑', value = '10'},
											{label = 'نائب قائد الهلال الأحمر 🚑', value = '11'},
											{label = 'قائد الهلال الأحمر 🚑', value = '12'},
										}
									}, function(data02, menu02)
										ExecuteCommand('setjob ' .. Playerid .. " ambulance " .. data02.current.value)
										ESX.ShowNotification('تم اعطاء الاعب وظيفة الهلال الأحمر - ' .. data02.current.label)										
									end, function(data02, menu02)
										menu02.close()
								end)
								elseif data00.current.value == 'mec' then
									ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_jobs_player4', {
										title = 'قائمة اعطاء وظيفة للاعب 💼 - <font color=gray>كراج الميكانيك 🛠️</font>',
										align = 'top-left',
										elements = {
											{label = 'متدرب 🛠️', value = '0'},
											{label = 'مستوى 1 🛠️', value = '1'},
											{label = 'مستوى 2 🛠️', value = '2'},
											{label = 'مستوى 3 🛠️', value = '3'},
											{label = 'مستوى 4 🛠️', value = '4'},
											{label = 'مستوى 5 🛠️', value = '5'},
											{label = 'مستوى 6 🛠️', value = '6'},
											{label = 'مستوى 7 🛠️', value = '7'},
											{label = 'مستوى 8 🛠️', value = '8'},
											{label = 'مستوى 9 🛠️', value = '9'},
											{label = 'نائب مدير كراج الميكانيك 🛠️', value = '10'},
											{label = 'مدير كراج الميكانيك 🛠️', value = '11'},
										}
									}, function(data03, menu03)
										ExecuteCommand('setjob ' .. Playerid .. " mechanic " .. data03.current.value)
										ESX.ShowNotification('تم اعطاء الاعب وظيفة كراج الميكانيك - ' .. data03.current.label)										
									end, function(data03, menu03)
										menu03.close()
								end)
								else
									ExecuteCommand('setjob ' .. Playerid .. " " .. data00.current.value .. " 0")
									ESX.ShowNotification('تم اعطاء الاعب وظيفة - ' .. data00.current.label)										
								end
							end, function(data00, menu00)
								menu00.close()
						end)
						elseif data3.current.value == 'change_name_player' then
							ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'change_name_player', {
								title = 'ادخل الأسم الأول'
							}, function(data10, menu10)
								local first_name_player = data10.value
								if first_name_player == "" or first_name_player == nil then
									ESX.ShowNotification('<font color=red>يجب عليك ادخال اي شي في الأسم الأول</font>')
								else
									menu10.close()
									ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'change_name_player', {
										title = 'ادخل الأسم الثاني ( العائلة )'
									}, function(data11, menu11)
										local last_name_player = data11.value
										if last_name_player == "" or last_name_player == nil then
											ESX.ShowNotification('<font color=red>يجب عليك ادخال اي شي في الأسم الثاني</font>')
										else
											menu11.close()
											TriggerServerEvent('esx_adminjob:change_name_player', Playerid, first_name_player, last_name_player)
										end
									end, function(data11, menu11)
										menu11.close()
								end)
								end
							end, function(data10, menu10)
								menu10.close()
						end)
						elseif data3.current.value == 'spec_to_player' then
							TriggerServerEvent("EasyAdmin:requestSpectate", Playerid)
						elseif data3.current.value == 'teleport_player_gh' then
							TriggerServerEvent("esx_misc:SwapPlayer", Playerid)
						elseif data3.current.value == 'getinfo' then
							ExecuteCommand('id '..Playerid)
						elseif data3.current.value == 'Givetp' then
						-------------------------------
		    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_menu', {
                    title    = 'هل أنت متأكد من إعطاء قائمة الإنتقال للاعب <span style="color:orange">'..name..'</span>',
                    align    = 'bottom-right',
                    elements = {
							{label = '<span style="color:red">رجوع</span>',  value = 'no'},
							{label = '<span style="color:green">نعم</span>', value = 'yes'},
						}
					}, function(data2, menu2)
						if data2.current.value == 'yes' then
			            TriggerServerEvent("esx_misc:GiveTeleportMenu", Playerid)
						end
						menu2.close()
					end, function(data2, menu2) menu2.close() end)
					-------------------------------
				elseif data3.current.value == 'give_lsn' then
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_menu', {
				title    = 'هل أنت متأكد من إعطاء اي رخصة؟ <span style="color:orange">'..name..'</span>',
				align    = 'bottom-right',
				elements = {
						{label = '<span style="color:red">رجوع</span>',  value = 'no'},
						{label = '<span style="color:green">رخصة اجتياز اختبار النظري</span>',  value = 'dmv'},
						{label = '<span style="color:green">رخصة قيادة مركبة 🚗</span>',  value = 'drive'},
						{label = '<span style="color:green">رخصة قيادة طائرة✈️</span>',  value = 'drive_aircraft'},
						{label = '<span style="color:green">رخصة قيادة دراجة 🏍️</span>',  value = 'drive_bike'},
						{label = '<span style="color:green">رخصة قيادة قارب🛶</span>',  value = 'drive_boat'},
						{label = '<span style="color:green">رخصة قيادة شاحنة 🚛</span>',  value = 'drive_truck'},
						{label = '<span style="color:green">رخصة حمل سلاح 🔫</span>',  value = 'weapon'},
					}
				}, function(data2, menu2)
					if data2.current.value == 'dmv' then
						ESX.TriggerServerCallback('esx_dmvschooladmin:addLicenseadmin', function()
						end,data2.current.value, Playerid)	
						ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم اعطاء</font>')
						elseif data2.current.value == 'drive' then
						ESX.TriggerServerCallback('esx_dmvschooladmin:addLicenseadmin', function()
						end,data2.current.value, Playerid)	
						ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم اعطاء</font>')
						elseif data2.current.value == 'drive_aircraft' then
						ESX.TriggerServerCallback('esx_dmvschooladmin:addLicenseadmin', function()
						end,data2.current.value, Playerid)	
						ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم اعطاء</font>')
						elseif data2.current.value == 'drive_bike' then
						ESX.TriggerServerCallback('esx_dmvschooladmin:addLicenseadmin', function()
						end,data2.current.value, Playerid)	
						ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم اعطاء</font>')
						elseif data2.current.value == 'drive_boat' then
						ESX.TriggerServerCallback('esx_dmvschooladmin:addLicenseadmin', function()
						end,data2.current.value, Playerid)	
						ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم اعطاء</font>')
						elseif data2.current.value == 'drive_truck' then
						ESX.TriggerServerCallback('esx_dmvschooladmin:addLicenseadmin', function()
						end,data2.current.value, Playerid)	
						ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم اعطاء</font>')
						elseif data2.current.value == 'weapon' then
						ESX.TriggerServerCallback('esx_dmvschooladmin:addLicenseadmin', function()
						end,data2.current.value, Playerid)	
						ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم اعطاء</font>')
					end
					menu2.close()
				end, function(data2, menu2) menu2.close() end)
			-------------------------------
		elseif data3.current.value == 'remove_lsn' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_menu', {
					title    = 'هل أنت متأكد من إعطاء اي رخصة؟ <span style="color:orange">'..name..'</span>',
					align    = 'bottom-right',
					elements = {
							{label = '<span style="color:green">رجوع</span>',  value = 'no'},
							{label = '<span style="color:red">رخصة اجتياز اختبار النظري</span>',  value = 'dmv'},
							{label = '<span style="color:red">رخصة قيادة مركبة 🚗</span>',  value = 'drive'},
							{label = '<span style="color:red">رخصة قيادة طائرة✈️</span>',  value = 'drive_aircraft'},
							{label = '<span style="color:red">رخصة قيادة دراجة 🏍️</span>',  value = 'drive_bike'},
							{label = '<span style="color:red">رخصة قيادة قارب🛶</span>',  value = 'drive_boat'},
							{label = '<span style="color:red">رخصة قيادة شاحنة 🚛</span>',  value = 'drive_truck'},
							{label = '<span style="color:red">رخصة حمل سلاح 🔫</span>',  value = 'weapon'},
						}
					}, function(data2, menu2)
						if data2.current.value == 'dmv' then
							ESX.TriggerServerCallback('esx_dmvschooladmin:removeLicenseadmin', function()
							end,data2.current.value, Playerid)	
							ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم سحب</font>')
							elseif data2.current.value == 'drive' then
							ESX.TriggerServerCallback('esx_dmvschooladmin:removeLicenseadmin', function()
							end,data2.current.value, Playerid)	
							ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم سحب</font>')
							elseif data2.current.value == 'drive_aircraft' then
							ESX.TriggerServerCallback('esx_dmvschooladmin:removeLicenseadmin', function()
							end,data2.current.value, Playerid)	
							ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم سحب</font>')
							elseif data2.current.value == 'drive_bike' then
							ESX.TriggerServerCallback('esx_dmvschooladmin:removeLicenseadmin', function()
							end,data2.current.value, Playerid)	
							ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم سحب</font>')
							elseif data2.current.value == 'drive_boat' then
							ESX.TriggerServerCallback('esx_dmvschooladmin:removeLicenseadmin', function()
							end,data2.current.value, Playerid)	
							ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم سحب</font>')
							elseif data2.current.value == 'drive_truck' then
							ESX.TriggerServerCallback('esx_dmvschooladmin:removeLicenseadmin', function()
							end,data2.current.value, Playerid)	
							ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم سحب</font>')
							elseif data2.current.value == 'weapon' then
							ESX.TriggerServerCallback('esx_dmvschooladmin:removeLicenseadmin', function()
							end,data2.current.value, Playerid)	
							ESX.ShowNotification('<font color=red>  '..name.. '  ' .. data2.current.label.. ' تم سحب</font>')
						end
						menu2.close()
					end, function(data2, menu2) menu2.close() end)
								--------------------------------------			
									elseif data3.current.value == 'giveshop' then
									ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'menu_car', {
										title = 'اكتب ايدي المتجر'
										}, function(data3, menu3)
										menu3.close()
										ESX.ShowNotification('<font color=green>  تم اعطاء   '..name.. ' متجر بنجاح </font>')
										TriggerServerEvent('esx_adminjob:wesamshop', data3.value,Playerid)
									end)
								---------------------------------------
							elseif data3.current.value == 'givebkg' then
								ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_bkg_player', {
									title = 'قائمة اعطاء وظيفة للاعب 💼',
									align = 'top-left',
									elements = {
												{label = '<span style="color:#ffcc00">رواعي 🏅</span>',  value = 'raee'},
												{label = '<span style="color:#008ae6">ضعف خبرة 💠</span>',  value = 'th3f'},
												{label = '<span style="color:#737373">اخرى ...</span>',  value = 'other'},
									}
								}, function(data00, menu00)
									if data00.current.value == 'raee' then
										ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_jobs_player2', {
											title = 'قائمة اعطاء   - <font color=blue>رواعي للاعب</font>',
											align = 'top-left',
											elements = {
												{label = '<span style="color:#CD7F32">راعي برونزي 🥉</span>',  value = 'bronze'},
												{label = '<span style="color:#C0C0C0">راعي فضي🥈</span>',  value = 'fde'},
												{label = '<span style="color:#FFD700">راعي ذهبي🏅</span>',  value = 'gold'},
												{label = '<span style="color:#E5E4E2">راعي بلاتيني🏅</span>',  value = 'plat'},
												{label = '<span style="color:#00d0ff">راعي الماسي💎</span>',  value = 'dimond'},
												{label = '<span style="color:#0000ff">راعي رسمي🏆</span>',  value = 'offical'},
												{label = '<span style="color:#800000">راعي إستراتيجي🥇</span>',  value = 'strategy'},
											}
										}, function(data01, menu01)
											if data01.current.value == 'bronze' then
												TriggerServerEvent('tebexstore:bkgat',Playerid,'5681213','give')
												elseif data01.current.value == 'fde' then
													TriggerServerEvent('tebexstore:bkgat',Playerid,'5681214','give')
												elseif data01.current.value == 'gold' then
													TriggerServerEvent('tebexstore:bkgat',Playerid,'5681215','give')
												elseif data01.current.value == 'plat' then
													TriggerServerEvent('tebexstore:bkgat',Playerid,'5681216','give')
												elseif data01.current.value == 'dimond' then
													TriggerServerEvent('tebexstore:bkgat',Playerid,'5681217','give')
												elseif data01.current.value == 'offical' then
													TriggerServerEvent('tebexstore:bkgat',Playerid,'5681219','give')
												elseif data01.current.value == 'strategy' then
													TriggerServerEvent('tebexstore:bkgat',Playerid,'5681220','give')
											end
											ESX.ShowNotification('تم اعطاء الاعب  - ' .. data01.current.label)
										end, function(data01, menu01)
											menu01.close()
									end)
									elseif data00.current.value == 'th3f' then
										ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_jobs_player3', {
											title = ' قائمة اعطاء ضعف- <font color=#0000ff>خبرة</font>',
											align = 'top-left',
											elements = {
												{label = '<span style="color:yellow">ضعف خبرة لمدة</span><span style="color:#0000ff"> 24 ساعة</span>',  value = '24h'},
												{label = '<span style="color:yellow">ضعف خبرة لمدة</span><span style="color:#0000ff"> 12 ساعة</span>',  value = '12h'},

												{label = '<span style="color:yellow">ضعف خبرة لمدة</span><span style="color:#0000ff"> 6 ساعة</span>',  value = '6h'},
											}
										}, function(data02, menu02)
											if data02.current.value == '24h' then
												TriggerServerEvent('tebexstore:bkgat',Playerid,'5681203','give')
												elseif data02.current.value == '12h' then
													TriggerServerEvent('tebexstore:bkgat',Playerid,'5681202','give')
												elseif data02.current.value == '6h' then
													TriggerServerEvent('tebexstore:bkgat',Playerid,'5681200','give')
											end
											ESX.ShowNotification('تم اعطاء الاعب  - ' .. data02.current.label)
										end, function(data02, menu02)
											menu02.close()
									end)
									elseif data00.current.value == 'other' then
											ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'menu_otherbkg', {
												title = 'اكتب ايدي البكج'
											}, function(data800, menu14)
												menu14.close()
												TriggerServerEvent('tebexstore:bkgat',Playerid,data800.value,'give')
											end)
									end
								end, function(data00, menu00)
									menu00.close()
							end)
											--------------------------------------			
									elseif data3.current.value == 'removeshop' then
										ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Confiorm_adminmenu', {
											title    = '<font color=red>تأكيد</font>'..name..' - سحب متجر',
											align    = 'top-left',
											elements = {
												{ label = '<font color=red>إلغاء</font>', value = 'no' },
												{ label = '<font color=green>تأكيد</font>', value = 'yes' },
											}
										}, function(data99, menu99)
											if data99.current.value == 'no' then
												menu99.close()
											else
												TriggerServerEvent('esx_adminjob:wesamremoveshop', Playerid)
												ESX.ShowNotification('<font color=red>  تم سحب متجر  '..name.. ' بنجاح  </font>')
												menu99.close()
											end
										end)
 						        -------------------------------
						elseif data3.current.value == 'freeze' then
						menu3.close()
							TriggerServerEvent('esx_adminjob:freezePlayer', Playerid, name)
							TriggerServerEvent('Mina:8adoji2adminjob:killkickfreeze', ('تجميد لاعب'), "***تم تجميد لاعب من قبل***", " \n steam `"..GetPlayerName(PlayerId()).."` \n لاعب الذي تم تجميده \n `id: "..Playerid.."` (`"..name.."`)", 15158332)
						elseif data3.current.value == 'ataflows_cash' then
							ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'admin_menu_3', {
								title    = 'كم تبي تعطي مبلغ في ( الكاش )'
							}, function(data14, menu14)
								local smdoidhodhud = tonumber(data14.value)
								if not smdoidhodhud then
									ESX.ShowNotification(_U('quantity_invalid'))
								else
									menu14.close()
									ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'admin_menu_15', {
										title    = 'الرجاء إدخال السبب'
									}, function(data15, menu15)
										local smdoidhodhud15 = tostring(data15.value)
										if not smdoidhodhud15 then
											ESX.ShowNotification(_U('quantity_invalid'))
										else
											menu15.close()
											ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'password_give', {
												title = 'ادخل الباسورد'
											}, function(data_password, menu_password)
												local password = data_password.value
												if password == nil then
													ESX.ShowNotification(_U('quantity_invalid'))
												else
													menu_password.close()
													ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Confiorm_adminmenu', {
														title    = '<font color=green>تأكيد</font> - اضافة مبلغ',
														align    = 'top-left',
														elements = {
															{ label = '<font color=red>إلغاء</font>', value = 'no' },
															{ label = '<font color=green>تأكيد</font>', value = 'yes' },
														}
													}, function(data99, menu99)
														if data99.current.value == 'no' then
															menu99.close()
														else
															TriggerServerEvent('esx_adminjob:givePlayerMoney', {id = data2.current.value, securityToken = securityToken}, data3.current.value, smdoidhodhud, '', smdoidhodhud15, password)
															menu99.close()
														end
													end, function(data99, menu99)
														menu99.close()
													end)
												end
											end, function(data_password, menu_password)
												menu_password.close()
											end)
										end
									end, function(data15, menu15)
										menu15.close()
									end)
								end
							end, function(data14, menu14)
								menu14.close()
							end)
						elseif data3.current.value == 'ataflows_bank' then
							ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'admin_menu_3', {
								title    = 'كم تبي تعطي مبلغ في ( البنك )'
							}, function(data14, menu14)
								local smdoidhodhud = tonumber(data14.value)
								if not smdoidhodhud then
									ESX.ShowNotification(_U('quantity_invalid'))
								else
									menu14.close()
									ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'admin_menu_15', {
										title    = 'الرجاء إدخال السبب'
									}, function(data15, menu15)
										local smdoidhodhud15 = tostring(data15.value)
										if not smdoidhodhud15 then
											ESX.ShowNotification(_U('quantity_invalid'))
										else
											menu15.close()
											ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'password_give', {
												title = 'ادخل الباسورد'
											}, function(data_password, menu_password)
												local password = data_password.value
												if password == nil then
													ESX.ShowNotification(_U('quantity_invalid'))
												else
													menu_password.close()
													ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Confiorm_adminmenu', {
														title    = '<font color=green>تأكيد</font> - اضافة مبلغ',
														align    = 'top-left',
														elements = {
															{ label = '<font color=red>إلغاء</font>', value = 'no' },
															{ label = '<font color=green>تأكيد</font>', value = 'yes' },
														}
													}, function(data99, menu99)
														if data99.current.value == 'no' then
															menu99.close()
														else
															TriggerServerEvent('esx_adminjob:givePlayerMoney', {id = data2.current.value, securityToken = securityToken}, data3.current.value, smdoidhodhud, '', smdoidhodhud15, password)
															menu99.close()
														end
													end, function(data99, menu99)
														menu99.close()
													end)
												end
											end, function(data_password, menu_password)
												menu_password.close()
											end)
										end
									end, function(data15, menu15)
										menu15.close()
									end)
								end
							end, function(data14, menu14)
								menu14.close()
							end)
						elseif data3.current.value == 'asd3a_ala3b' then
							ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Confiorm_adminmenu', {
								title    = '<font color=green>تأكيد</font> - اضافة استدعاء الاعب ' .. data2.current.name,
								align    = 'top-left',
								elements = {
									{ label = '<font color=red>إلغاء</font>', value = 'no' },
									{ label = '<font color=green>تأكيد</font>', value = 'yes' },
								}
							}, function(data99, menu99)
								if data99.current.value == 'no' then
									menu99.close()
								else
									TriggerServerEvent('esx_adminjob:astd3a_ala3b', data2.current.value)
									menu99.close()
								end
							end, function(data99, menu99)
								menu99.close()
							end)
						elseif data3.current.value == 'ataflowsblack' then
							ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'admin_menu_3', {
								title    = 'كم تبي تعطي مبلغ غير قانوني'
							}, function(data14, menu14)
								local smdoidhodhud = tonumber(data14.value)
								if not smdoidhodhud then
									ESX.ShowNotification(_U('quantity_invalid'))
								else
									menu14.close()
									ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'admin_menu_15', {
										title    = 'الرجاء إدخال السبب'
									}, function(data15, menu15)
										local smdoidhodhud15 = tostring(data15.value)
										if not smdoidhodhud15 then
											ESX.ShowNotification(_U('quantity_invalid'))
										else
											menu15.close()
											ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'password_give', {
												title = 'ادخل الباسورد'
											}, function(data_password, menu_password)
												local password2 = data_password.value
												if password2 == nil then
													ESX.ShowNotification(_U('quantity_invalid'))
												else
													menu_password.close()
													ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Confiorm_adminmenu', {
														title    = '<font color=green>تأكيد</font> - اضافة مبلغ غير قانوني',
														align    = 'top-left',
														elements = {
															{ label = '<font color=red>إلغاء</font>', value = 'no' },
															{ label = '<font color=green>تأكيد</font>', value = 'yes' },
														}
													}, function(data99, menu99)
														if data99.current.value == 'no' then
															menu99.close()
														else
															TriggerServerEvent('esx_adminjob:givePlayerMoney', {id = data2.current.value, securityToken = securityToken}, data3.current.value, smdoidhodhud, '', smdoidhodhud15, password2)
															menu99.close()
														end
													end, function(data99, menu99)
														menu99.close()
													end)
												end
											end, function(data_password, menu_password)
												menu_password.close()
											end)
										end
									end, function(data15, menu15)
										menu15.close()
									end)
								end
							end, function(data14, menu14)
								menu14.close()
							end)
						elseif data3.current.value == 's7b_money_from_cash' then
							ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'admin_menu_3', {
								title    = 'كم تبي تسحب مبلغ من ( الكاش )'
							}, function(data14, menu14)
								local smdoidhodhud = tonumber(data14.value)
								if not smdoidhodhud then
									ESX.ShowNotification(_U('quantity_invalid'))
								else
									menu14.close()
									ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'admin_menu_15', {
										title    = 'الرجاء إدخال السبب'
									}, function(data15, menu15)
										local smdoidhodhud15 = tostring(data15.value)
										if not smdoidhodhud15 then
											ESX.ShowNotification(_U('quantity_invalid'))
										else
											menu15.close()
											ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'password_give', {
												title = 'ادخل الباسورد'
											}, function(data_password, menu_password)
												local password3 = data_password.value
												if password3 == nil then
													ESX.ShowNotification(_U('quantity_invalid'))
												else
													menu_password.close()
													ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Confiorm_adminmenu', {
														title    = '<font color=green>تأكيد</font> - سحب مبلغ',
														align    = 'top-left',
														elements = {
															{ label = '<font color=red>إلغاء</font>', value = 'no' },
															{ label = '<font color=green>تأكيد</font>', value = 'yes' },
														}
													}, function(data99, menu99)
														if data99.current.value == 'no' then
															menu99.close()
														else
															TriggerServerEvent('esx_adminjob:givePlayerMoney', {id = data2.current.value, securityToken = securityToken}, data3.current.value, smdoidhodhud, '', smdoidhodhud15, password3)
															menu99.close()
														end
													end, function(data99, menu99)
														menu99.close()
													end)
												end
											end, function(data_password, menu_password)
												menu_password.close()
											end)
										end
									end, function(data15, menu15)
										menu15.close()
									end)
								end
							end, function(data14, menu14)
								menu14.close()
							end)
						elseif data3.current.value == 's7b_money_from_bank' then
							ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'admin_menu_3', {
								title    = 'كم تبي تسحب مبلغ من ( البنك )'
							}, function(data14, menu14)
								local smdoidhodhud = tonumber(data14.value)
								if not smdoidhodhud then
									ESX.ShowNotification(_U('quantity_invalid'))
								else
									menu14.close()
									ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'admin_menu_15', {
										title    = 'الرجاء إدخال السبب'
									}, function(data15, menu15)
										local smdoidhodhud15 = tostring(data15.value)
										if not smdoidhodhud15 then
											ESX.ShowNotification(_U('quantity_invalid'))
										else
											menu15.close()
											ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'password_give', {
												title = 'ادخل الباسورد'
											}, function(data_password, menu_password)
												local password3 = data_password.value
												if password3 == nil then
													ESX.ShowNotification(_U('quantity_invalid'))
												else
													menu_password.close()
													ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Confiorm_adminmenu', {
														title    = '<font color=green>تأكيد</font> - سحب مبلغ',
														align    = 'top-left',
														elements = {
															{ label = '<font color=red>إلغاء</font>', value = 'no' },
															{ label = '<font color=green>تأكيد</font>', value = 'yes' },
														}
													}, function(data99, menu99)
														if data99.current.value == 'no' then
															menu99.close()
														else
															TriggerServerEvent('esx_adminjob:givePlayerMoney', {id = data2.current.value, securityToken = securityToken}, data3.current.value, smdoidhodhud, '', smdoidhodhud15, password3)
															menu99.close()
														end
													end, function(data99, menu99)
														menu99.close()
													end)
												end
											end, function(data_password, menu_password)
												menu_password.close()
											end)
										end
									end, function(data15, menu15)
										menu15.close()
									end)
								end
							end, function(data14, menu14)
								menu14.close()
							end)
						elseif data3.current.value == 'admin_menu1010' then
							ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'admin_menu_3', {
								title    = 'كم تبي تسحب مبلغ غير قانوني'
							}, function(data14, menu14)
								local smdoidhodhud = tonumber(data14.value)
								if not smdoidhodhud then
									ESX.ShowNotification(_U('quantity_invalid'))
								else
									menu14.close()
									ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'admin_menu_15', {
										title    = 'الرجاء إدخال السبب'
									}, function(data15, menu15)
										local smdoidhodhud15 = tostring(data15.value)
										if not smdoidhodhud15 then
											ESX.ShowNotification(_U('quantity_invalid'))
										else
											menu15.close()
											ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'password_give', {
												title = 'ادخل الباسورد'
											}, function(data_password, menu_password)
												local password4 = data_password.value
												if password4 == nil then
													ESX.ShowNotification(_U('quantity_invalid'))
												else
													menu_password.close()
													ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Confiorm_adminmenu', {
														title    = '<font color=green>تأكيد</font> - سحب مبلغ غير قانوني',
														align    = 'top-left',
														elements = {
															{ label = '<font color=red>إلغاء</font>', value = 'no' },
															{ label = '<font color=green>تأكيد</font>', value = 'yes' },
														}
													}, function(data99, menu99)
														if data99.current.value == 'no' then
															menu99.close()
														else
															TriggerServerEvent('esx_adminjob:givePlayerMoney', {id = data2.current.value, securityToken = securityToken}, data3.current.value, smdoidhodhud, '', smdoidhodhud15, password4)
															menu99.close()
														end
													end, function(data99, menu99)
														menu99.close()
													end)
												end
											end, function(data_password, menu_password)
												menu_password.close()
											end)
										end
									end, function(data15, menu15)
										menu15.close()
									end)
								end
							end, function(data14, menu14)
								menu14.close()
							end)
						elseif data3.current.value == 'ataganthar' then
							OpenFineCategoryAdminMenuAnthar(data2.current.value)
						elseif data3.current.value == 'sglalabanthar' then
							OpenpaidBillsAntharlogMenu(data2.current.value)
						elseif data3.current.value == 'sglalab' then
							OpenpaidBillslogMenu(data2.current.value)
						elseif data3.current.value == 'weapon_player_2' then
							menu3.close()
							TriggerServerEvent('esx_adminjob:weaponPlayer2', Playerid, name)
						elseif data3.current.value == 'givecar' then
							ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'menu_car', {
								title = 'اكتب اسم المركبة'
							}, function(data14, menu14)
								menu14.close()
								ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'menu_car1', {
									title = 'اكتب اللوحة مثال GHM 707'
								}, function(data16, menu16)
									menu16.close()
									ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'menu_car2', {
										title = 'الوظيفة الخاصة للمركبة اذا مركبة عامة حط /civ '
									}, function(data17, menu17)
										menu17.close()
										ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'menu_car3', {
											title = 'موديل المركبة '
										}, function(data13, menu13)
											menu13.close()
											ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'menu_car4', {
												title = ' سعر المركبة بحيث اذا جاء يعرضها في مستعمل '
											}, function(data18, menu18)
												menu18.close()
												ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'menu_car5', {
													title = ' خبرة المركبة بحيث اذا جاء يعرضها في مستعمل '
												}, function(data19, menu19)
													menu19.close()
													ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'menu_car6', {
														title = ' نوع المركبة car/truck... '
													}, function(data20, menu20)
														menu20.close()
														TriggerServerEvent('esx_adminjob:wesamcar', Playerid,data14.value,data16.value,data17.value,data13.value,data18.value,data19.value,data20.value)							
													end)
												end)
											end)
										end)
									end)
								end)
							end)
						elseif data3.current.value == 'ataghramh' then
							ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'jali_menu_playerzz', {
								title = 'قائمة اعطاء غرامة',
								align = 'top-left',
								elements = {
									{label = '<font color=green>خيارات الغرامات</font>', value = 'khearat_ghramat'},
									{label = '<font color=orange>كتابة الغرامة بنفسك</font>', value = 'ktabt_alghramh_bnfsk'}
								}
							}, function(data6, menu6)
								if data6.current.value == 'khearat_ghramat' then
									OpenFineCategoryAdminkhearatMenu(data2.current.value)
								elseif data6.current.value == 'ktabt_alghramh_bnfsk' then
									if grade >= 2 then
									OpenFineCategoryAdminMenu(data2.current.value)
									end
								end
							end, function(data6, menu6)
								menu6.close()
						end)
						elseif data3.current.value == 'kill' then
						menu3.close()
							TriggerServerEvent('esx_adminjob:killPlayer', Playerid)
							TriggerServerEvent('Mina:8adoji2adminjob:killkickfreeze', ('قتل عبر f6 رقابة'), "***تم قتل لاعب من قبل***", " \n steam `"..GetPlayerName(PlayerId()).."` \n لاعب الذي تم تجميده \n `id: "..Playerid.."` (`"..name.."`)", 15158332)
						elseif data3.current.value == 'kick' then
						 ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'kick_confirm', {
			title = "هل أنت متأكد من طرد اللاعب من السيرفر? <font color=green>"..name.."</font>?",
			align = 'top-left',
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		}}, function(data, menu)
			menu.close()

			if data.current.value == 'yes' then
				TriggerServerEvent('esx_adminjob:kickplayerFromServer', Playerid)
							TriggerServerEvent('_chat:messageEntered', GetPlayerName(PlayerId()), { 0, 0, 0 }, "تم فصل^3 "..name.."^0 من السيرفر")
							TriggerServerEvent('Mina:8adoji2adminjob:killkickfreeze', ('طرد لاعب!'), "***تم طرد لاعب من قبل***", " \n steam `"..GetPlayerName(PlayerId()).."` \n الاعب الذي تم طرده \n `id: "..Playerid.."` (`"..name.."`)", 15158332)
							end
							end)
						elseif data3.current.value == 'revive_player' then
						 ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'kick_confirm', {
			title = "هل أنت متأكد من <font color=green>إنعاش</font> اللاعب : <font color=green>"..name.."</font>?",
			align = 'top-left',
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		}}, function(data, menu)
			menu.close()

			if data.current.value == 'yes' then
						menu3.close()
							TriggerServerEvent('esx_ambulancejob:revive', data2.current.value)
							TriggerServerEvent('Mina:lad97ygadminjob:f6revive', ('أنعاش لاعب'), "***تم أنعاش لاعب من قبل***", " \n steam `"..GetPlayerName(PlayerId()).."` \n الاعب الذي تم أنعاشه \n `id: "..Playerid.."` (`"..name.."`)", 15158332)
						end
						end)
						elseif data3.current.value == 'goto' then
						 ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'kick_confirm', {
			title = "هل أنت متأكد من الإنتقال للاعب؟ <font color=green>"..name.."</font>?",
			align = 'top-left',
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		}}, function(data, menu)
			menu.close()

			if data.current.value == 'yes' then
						menu3.close()
							TriggerServerEvent('esx_adminjob:goto', Playerid, name)
							TriggerServerEvent('Mina:ol2349oadminjob:gotobring', ('أنتقال'), "***ذهب المراقب الى لاعب***", " \n steam `"..GetPlayerName(PlayerId()).."` \n الاعب \n `id: "..Playerid.."` (`"..name.."`)", 15158332)
						end
						end)
						elseif data3.current.value == 'bring' then
						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'kick_confirm', {
			title = "هل أنت متأكد من سحب اللاعب لك <font color=green>"..name.."</font>?",
			align = 'top-left',
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		}}, function(data, menu)
			menu.close()

			if data.current.value == 'yes' then
						menu3.close()
							TriggerServerEvent('esx_adminjob:bring', Playerid, name)
							TriggerServerEvent('Mina:ol2349oadminjob:gotobring', ('سحب لاعب'), "***قام المراقب بسحب لاعب***", " \n steam `"..GetPlayerName(PlayerId()).."` \n الاعب \n `id: "..Playerid.."` (`"..name.."`)", 15158332)
						end
						end)
						elseif data3.current.value == 'weapon_player' then
						menu3.close()
							TriggerServerEvent('esx_adminjob:weaponPlayer', Playerid, name)
		elseif data3.current.value == 'addxp' then
			menu.close()

			ESX.UI.Menu.Open(
          		'dialog', GetCurrentResourceName(), 'jail_choose_time_menu',
          		{
            		title = "العدد؟"
          		},
          	function(data2, menu2)

            	local jailTime = tonumber(data2.value)

            	if jailTime == nil then
              		ESX.ShowNotification("يجب أن يكون العدد صحيح!")
            	else
              		menu2.close()

						ESX.UI.Menu.Open(
							'dialog', GetCurrentResourceName(), 'jail_choose_reason_menu',
							{
							  title = "سبب الإضافة"
							},
						function(data3, menu3)
		  
						  	local reason = data3.value
		  
						  	if reason == nil then
								ESX.ShowNotification("يجب ملئ سبب الإضافة")
						  	else
								menu3.close()
								ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'password_give', {
									title = 'ادخل الباسورد'
								}, function(data_password, menu_password)
									local password_xp = data_password.value
									if password_xp == nil then
										ESX.ShowNotification(_U('quantity_invalid'))
									else
										menu_password.close()
										ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
											title = "هل أنت متأكد من <font color=green>إعطاء</font> <font color=#5DADE2>"..jailTime.."</font> خبرة للاعب: <font color=green>"..name.."</font>?",
											align = 'top-left',
											elements = {
												{label = _U('no'), value = 'no'},
												{label = _U('yes'), value = 'yes'}
											}
										}, function(data, menu)
											menu.close()
											if data.current.value == 'yes' then
												TriggerServerEvent("esx_adminjob:giveplayerxp", Playerid, jailTime, reason, name, password_xp) -- jailTime = xp
											end
										end, function(data, menu)
											menu.close()
										end)
									end
								end, function(data_password, menu_password)
									menu_password.close()
								end)
						  	end
		  
						end, function(data3, menu3)
							menu3.close()
						end)

				end

          	end, function(data2, menu2)
				menu2.close()
			end)
		elseif data3.current.value == 'jail' then

			menu.close()

			ESX.UI.Menu.Open(
          		'dialog', GetCurrentResourceName(), 'jail_choose_time_menu',
          		{
            		title = "مدة السجن؟"
          		},
          	function(data2, menu2)

            	local jailTime = tonumber(data2.value)

            	if jailTime == nil then
              		ESX.ShowNotification("يجب أن يكون العدد صحيح!")
            	else
              		menu2.close()

						ESX.UI.Menu.Open(
							'dialog', GetCurrentResourceName(), 'jail_choose_reason_menu',
							{
							  title = "أكتب اي شي هنا ضروري عشان تسجن"
							},
						function(data3, menu3)
		  
						  	local reason = data3.value
		  
						  	if reason == nil then
								ESX.ShowNotification("يجب ملئ سبب السجن")
						  	else
								menu3.close()
		                    --print("jail "..Playerid.." "..jailTime.." "..reason)
							TriggerServerEvent('esx_jail:jailPlayer', Playerid, jailTime, reason)
							TriggerServerEvent('esx_misc3:jailLog', Playerid, reason)		  
						  	end
		  
						end, function(data3, menu3)
							menu3.close()
						end)

				end

          	end, function(data2, menu2)
				menu2.close()
			end)
		elseif data3.current.value == 'unjail' then
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'kick_confirm', {
			title = "هل أنت متأكد من إخراج اللاعب من السجن <font color=green>"..name.."</font>?",
			align = 'top-left',
			elements = {
				{label = '<font color=gray>لاتضغط في حال ماكان مسجون</font>'},
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		}}, function(data, menu)
			menu.close()

			if data.current.value == 'yes' then
               ExecuteCommand("unjail "..Playerid)			
			   TriggerServerEvent("esx_misc3:unjailLog", Playerid)
			  end
			  end)
		elseif data3.current.value == 'removexp' then

			menu.close()

			ESX.UI.Menu.Open(
          		'dialog', GetCurrentResourceName(), 'jail_choose_time_menu',
          		{
            		title = "العدد المراد ازالتها"
          		},
          	function(data2, menu2)

            	local jailTime = tonumber(data2.value)

            	if jailTime == nil then
              		ESX.ShowNotification("يجب أن يكون العدد صحيح!")
            	else
              		menu2.close()

						ESX.UI.Menu.Open(
							'dialog', GetCurrentResourceName(), 'jail_choose_reason_menu',
							{
							  title = "سبب الإزالة"
							},
						function(data3, menu3)
		  
						  	local reason = data3.value
		  
						  	if reason == nil then
								ESX.ShowNotification("يرجى ملئ سبب الإزالة")
						  	else
								menu3.close()
								ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'password_give', {
									title = 'ادخل الباسورد'
								}, function(data_password, menu_password)
									local password_remove_xp = data_password.value
									if password_remove_xp == nil then
										ESX.ShowNotification(_U('quantity_invalid'))
									else
										menu_password.close()
										ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
											title = "هل أنت متأكد من <font color=red>خصم</font> <font color=#5DADE2>"..jailTime.."</font> خبرة من اللاعب: <font color=green>"..name.."</font>?",
											align = 'top-left',
											elements = {
												{label = _U('no'), value = 'no'},
												{label = _U('yes'), value = 'yes'}
											}
										}, function(data, menu)
											menu.close()
											if data.current.value == 'yes' then
												TriggerServerEvent("esx_adminjob:removeXpFromPlayer", Playerid, jailTime, reason, password_remove_xp)
											end
										end, function(data, menu)
											menu.close()
										end)
									end
								end, function(data_password, menu_password)
									menu_password.close()
								end)
						  	end
						end, function(data3, menu3)
							menu3.close()
						end)

				end

          	end, function(data2, menu2)
				menu2.close()
			end)						
						end
					end, function(data3, menu3)
						menu3.close()
					end)
		   end
				end, function(data2, menu2)
					menu2.close()
				end)
		
			end)
		end

		if data.current.value == 'doublemenu' then
			local elements = {
				{label = "<font color=red>:::: ابتداء قائمة التحكم [بضعف الخبرة]  ::::</font>"}, -- You add this line
				{label = "بدء/إيقاف ضعف الخبرة - <span style='color:#64ADDE;'>ضعف الخبرة 🌐</span>", value = 'doubleXP'}, -- You add this line
				{label = "بدء/إيقاف ضعف الأجر - <span style='color:green;'>جميع الوظائف العامة 👷</span>", value = 'dblpay-all'}, -- You add this line
				{label = "بدء/إيقاف ضعف الأجر - <span style='color:green;'>الشركة الدولية للمعادن⛏️</span>", value = 'dblpay-miner'}, -- You add this line
				{label = "بدء/إيقاف ضعف الأجر - <span style='color:#E5FFCC;'>الشركة الوطنية للدواجن 🐔</span>", value = 'dblpay-slaughterer'}, -- You add this line	
				{label = "بدء/إيقاف ضعف الأجر - <span style='color:yellow;'>شركة الأخشاب المحلية  🌲</span>", value = 'dblpay-lumberjack'}, -- You add this line
				{label = "بدء/إيقاف ضعف الأجر - <span style='color:#FF99CC;'>شركة الأقمشة 👚</span>", value = 'dblpay-tailor'}, -- You add this line
				{label = "بدء/إيقاف ضعف الأجر - <span style='color:#FF3333;'>نفط وغاز ⛽</span>", value = 'dblpay-fueler'}, -- You add this line	
				{label = "بدء/إيقاف ضعف الأجر - <span style='color:#661BF2;'>شركة المزارع 🍇</span>", value = 'dblpay-farmer'}, -- You add this line		
				{label = "بدء/إيقاف ضعف الأجر - <span style='color:#00CCFF;'>شركة الأسماك المتحدة 🐟</span>", value = 'dblpay-fisherman'}, -- You add this line
				{label = "بدء/إيقاف ضعف الأجر - <span style='color:#00CCFF;'>شركة الخضروات 🥦</span>", value = 'dblpay-vegetables'}, -- You add this line
				{label = "بدء/إيقاف ضعف الأجر - <span style='color:#FFA54C;'>ضعف الخبره للوظائف المعتمده</span>", value = 'dblpay-fork'}, -- You add this line					
				{label = "بدء/إيقاف الضعف - <span style='color:white;'>ضعف صندوق المتجر 📦🏪</span>", value = 'doubleStoreBoxQty'}, -- You add this line
				{label = "<font color=red>:::: ابتداء قائمة التحكم [بأعادة ضبط الوقت]  ::::</font>"}, -- You add this line
				{label = '<font color=yellow>إعادة ضبط وقت ضعف الخبرة 🌐</font>', value = 'timeng', promotionName = 'doubleXP'},
				{label = '<font color=yellow>إعادة ضبط وقت ضعف الأجر جميع الوظائف 👷</font>', value = 'timeng', promotionName = 'all'},
				{label = '<font color=yellow>إعادة ضبط وقت ضعف الأجر الأسماك المتحدة 🐟</font>', value = 'timeng', promotionName = 'fisherman'},
				{label = '<font color=yellow>إعادة ضبط وقت ضعف الأجر المزارع 🍇</font>', value = 'timeng', promotionName = 'farmer'},
				{label = '<font color=yellow>إعادة ضبط وقت ضعف الأجر نفط وغاز ⛽</font>', value = 'timeng', promotionName = 'fueler'},
				{label = '<font color=yellow>إعادة ضبط وقت ضعف الأجر الأقمشة 👚</font>', value = 'timeng', promotionName = 'tailor'},
				{label = '<font color=yellow>إعادة ضبط وقت ضعف الأجر الأخشاب 🌲</font>', value = 'timeng', promotionName = 'lumberjack'},
				{label = '<font color=yellow>إعادة ضبط وقت ضعف الأجر الدواجن 🐔</font>', value = 'timeng', promotionName = 'slaughterer'},
				{label = '<font color=yellow>إعادة ضبط وقت ضعف الأجر المعادن ⛏️</font>', value = 'timeng', promotionName = 'miner'},
				{label = '<font color=yellow>إعادة ضبط وقت ضعف الأجر شركة الخضروات 🥦</font>', value = 'timeng', promotionName = 'vegetables'},
				{label = '<font color=yellow>إعادة ضبط وقت ضعف الأجر صندوق المتجر📦🏪</font>', value = 'timeng', promotionName = '9ndo8_almtagr'},
			}

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'moneydbl', {
				title    = ":::: قائمة الضعف ::::",
				align    = 'bottom-right',
				elements = elements
			},
			function(data2, menu2)
				if data2.current.value == "timeng" then

					local Mtime = 0

					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'timeng', {

						title = 'أكتب الوقت بالدقائق (أكتب 111 في حال الرغبة في إلغاء الوقت)',

					}, function(data4, menu4)

						Mtime = tonumber(data4.value)
						
						if Mtime ~= nil and Mtime >= 0 and ESX.PlayerData.grade == 4 or Mtime <= 1000 then

							TriggerServerEvent("esx_misc:NoCrimetime", data2.current.promotionName, false, Mtime)

						end

						menu4.close()

					end, function(data4, menu4)

						menu4.close()

					end)

				end
			    if data2.current.value == 'doubleXP' then		
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dublexp_confirm', {
						title = 'هل أنت متأكد من بدء/إيقاف ضعف الخبرة؟',
						align = 'top-left',
						elements = {
							{label = _U('no'), value = 'no'},
							{label = _U('yes'), value = 'yes'}
						}}, function(data, menu)
							menu.close()

							if data.current.value == 'yes' then
								TriggerServerEvent("esx_misc:NoCrimetime", "doubleXP", true)
							end
						end)
					elseif data2.current.value == 'dblpay-all' then		
						ESX.UI.Menu.Open('default', GetCurrentResourceName(), '642_confirm', {
							title = 'هل أنت متأكد من بدء/إيقاف ضعف اجر جميع الوظائف العامة؟',
							align = 'top-left',
							elements = {
								{label = _U('no'), value = 'no'},
								{label = _U('yes'), value = 'yes'}
						}}, function(data, menu)
							menu.close()
							if data.current.value == 'yes' then
								TriggerServerEvent('esx_jobs:togglePromotion_duble', 'all', true, "from_admin")
							end
						end)							
	
				elseif data2.current.value == 'dblpay-miner' then		
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), '642_confirm', {
						title = 'هل أنت متأكد من بدء/إيقاف ضعف اجر المعادن؟',
						align = 'top-left',
						elements = {
							{label = _U('no'), value = 'no'},
							{label = _U('yes'), value = 'yes'}
					}}, function(data, menu)
						menu.close()
						if data.current.value == 'yes' then
							TriggerServerEvent('esx_jobs:togglePromotion_duble', 'miner', true, "from_admin")
						end
					end)							
				elseif data2.current.value == 'dblpay-lumberjack' then	
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), '3had_confirm', {
						title = 'هل أنت متأكد من بدء/إيقاف ضعف اجر الأخشاب؟',
						align = 'top-left',
						elements = {
							{label = _U('no'), value = 'no'},
							{label = _U('yes'), value = 'yes'}
					}}, function(data, menu)
						menu.close()

						if data.current.value == 'yes' then
							TriggerServerEvent('esx_jobs:togglePromotion_duble', 'lumberjack', true, "from_admin")
						end											
					end)
				elseif data2.current.value == 'dblpay-slaughterer' then		
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'g213r_confirm', {
						title = 'هل أنت متأكد من بدء/إيقاف ضعف اجر الدواجن؟',
						align = 'top-left',
						elements = {
							{label = _U('no'), value = 'no'},
							{label = _U('yes'), value = 'yes'}
					}}, function(data, menu)
						menu.close()
						if data.current.value == 'yes' then
							TriggerServerEvent('esx_jobs:togglePromotion_duble', 'slaughterer', true, "from_admin")
						end
					end)
				elseif data2.current.value == 'dblpay-tailor' then			
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'jae2y_confirm', {
						title = 'هل أنت متأكد من بدء/إيقاف ضعف اجر الأقمشة؟',
						align = 'top-left',
						elements = {
							{label = _U('no'), value = 'no'},
							{label = _U('yes'), value = 'yes'}
					}}, function(data, menu)
						menu.close()
						if data.current.value == 'yes' then
							TriggerServerEvent('esx_jobs:togglePromotion_duble', 'tailor', true, "from_admin")
						end										
					end)
				elseif data2.current.value == 'dblpay-fueler' then		
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'h23ra_confirm', {
						title = 'هل أنت متأكد من بدء/إيقاف ضعف اجر نفط وغاز؟',
						align = 'top-left',
						elements = {
							{label = _U('no'), value = 'no'},
							{label = _U('yes'), value = 'yes'}
					}}, function(data, menu)
						menu.close()
						if data.current.value == 'yes' then	
							TriggerServerEvent('esx_jobs:togglePromotion_duble', 'fueler', true, "from_admin")
						end														
					end)														
				elseif data2.current.value == 'dblpay-farmer' then	
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'h23t6_confirm', {
						title = 'هل أنت متأكد من بدء/إيقاف ضعف اجر شركة العنب؟',
						align = 'top-left',
						elements = {
							{label = _U('no'), value = 'no'},
							{label = _U('yes'), value = 'yes'}
					}}, function(data, menu)
						menu.close()
						if data.current.value == 'yes' then
							TriggerServerEvent('esx_jobs:togglePromotion_duble', 'farmer', true, "from_admin")
						end														
					end)
				elseif data2.current.value == 'dblpay-fisherman' then
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'j23w4g_confirm', {
						title = 'هل أنت متأكد من بدء/إيقاف ضعف اجر الأسماك',
						align = 'top-left',
						elements = {
							{label = _U('no'), value = 'no'},
							{label = _U('yes'), value = 'yes'}
					}}, function(data, menu)
						menu.close()
						if data.current.value == 'yes' then
				  			TriggerServerEvent('esx_jobs:togglePromotion_duble', 'fisherman', true, "from_admin")
						end														
					end)														
				elseif data2.current.value == 'dblpay-vegetables' then		
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'h234tk_confirm', {
						title = 'هل أنت متأكد من بدء/إيقاف ضعف شركة الخضروات؟',
						align = 'top-left',
						elements = {
							{label = _U('no'), value = 'no'},
							{label = _U('yes'), value = 'yes'}
					}}, function(data, menu)
						menu.close()
						if data.current.value == 'yes' then
							TriggerServerEvent('esx_jobs:togglePromotion_duble', 'vegetables', true, "from_admin")
						end													
					end)							
                elseif data2.current.value == 'dblpay-fork' then		
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'h234tkd_confirm', {
						title = 'هل أنت متأكد من بدء/إيقاف ضعف الخبره للوظايف المعتمدة؟',
						align = 'top-left',
						elements = {
							{label = _U('no'), value = 'no'},
							{label = _U('yes'), value = 'yes'}
					}}, function(data, menu)
						menu.close()
						if data.current.value == 'yes' then
				 			TriggerServerEvent('esx_adminjob:is_set_police_level')
							TriggerServerEvent('esx_misc:setdubelxpjob')
						end													
					end)										
                elseif data2.current.value == 'doubleStoreBoxQty' then		
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'jq3hjj_confirm', {
						title = 'هل أنت متأكد من بدء/إيقاف ضعف صندوق المتجر؟',
						align = 'top-left',
						elements = {
							{label = _U('no'), value = 'no'},
							{label = _U('yes'), value = 'yes'}
					}}, function(data, menu)
						menu.close()

						if data.current.value == 'yes' then
							TriggerServerEvent('esx_shops2:setDUBLExp')
						end																		 	
					end)																 	
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end		
		if data.current.value == 'dblmtjr' then
			local elements = {
				{label = "<span style='color:green;'>بدء ضعف خبرة</span>", value = 'dblmtjr-start'}, -- You add this line
				{label = "<span style='color:red;'>ايقاف ضعف خبرة</span>", value = 'dblmtjr-stop'} -- You add this line
			}

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dblmtjr', {
				title    = "قائمة ضعف صندوق المتجر",
				align    = 'bottom-right',
				elements = elements
			},
			function(data2, menu2)
				if data2.current.value == 'dblmtjr-start' then
                    ESX.UI.Menu.CloseAll()				  
					local msg = '<font size=5 color=white>جاري التنفيذ'
				    TriggerEvent('pogressBar:drawBar', 50, msg)
					Citizen.Wait(50)				
					 ExecuteCommand("dlmtjr 1")
					 TriggerServerEvent('_chat:messageEntered', GetPlayerName(PlayerId()), { 0, 0, 0 }, "تم بدء ^3ضعف صندوق المتجر^0 ")
				elseif data2.current.value == 'dblmtjr-stop' then
                    ESX.UI.Menu.CloseAll()				  
					local msg = '<font size=5 color=white>جاري التنفيذ'
				    TriggerEvent('pogressBar:drawBar', 50, msg)
					Citizen.Wait(50)				
					 ExecuteCommand("dlmtjr 0")
					 TriggerServerEvent('_chat:messageEntered', GetPlayerName(PlayerId()), { 0, 0, 0 }, "تم إيقاف ^3ضعف صندوق المتجر^0 ")
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end			
		if data.current.value == 'times' then
			local elements = {
			  {label = _U('Panic_Button_Menu'),		value = 'Panic_Button_Menu'},
			  {label = "<span style='color:gray;'>منطقة محظورة</span>", value = 'restricted_area'}, -- You add this line
			  {label = "<span style='color:green;'>ﻣﻮﻗﻊ ﺁﻣﻦ</span>",	value = 'my_location_safezone'},
			  {label = _U('event_menu'), 				value = 'event_menu'},
			  {label = "<font color=purple>وقت راحة</font>", value = 'peace_time'}, -- You add this line
			  {label = "<font color=purple>وقت صيانة</font>", value = '9eanh_time'}, -- You add this line
			 -- {label = "<font color=purple>وقت مزاد</font>", value = 'mazad_time'}, -- You add this line
			  {label = "<font color=red>وقت رستارت</font>", value = 'restart_time'}, -- You add this line
			  {label = "<font color=red>⛔ قائمة التحكم بالمنع</font>", value = 'NoCrimetimeMenu'}, -- You add this line
			  {label = "<span style='color:gold;'>🚗 قائمة حذف جميع المركبات</span>", value = 'delete_all_cars'}, -- You add this line
			  {label = "<span style='color:gold;'>⚠️ بدء/إيقاف صافرة إنذار المكافحة</span>", value = 'hacker'}, -- You add this line
			  {label = "<span style='color:orange;'>🛸 إعطاء قائمة الأنتقال للكل</span>", value = 'teleportForall'}, -- You add this line
			  {label = "<span style='color:orange;'>🛸 إعطاء قائمة الأنتقال لشخص</span>", value = 'teleport'}, -- You add this line
			}

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'peacetime', {
			  title    = "⌛ تحكم وقت الراحة/ريستارت/المكافحة",
			  align    = 'bottom-right',
			  elements = elements
			}, 
			function(data, menu)
			action = data.current.value
			label = data.current.label
			  if action == 'teleportForall' then
			  -------------------------------
		    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_menu', {
                    title    = 'تأكيد <span style="color:orange">إعطاء قائمة الأنتقال للكل</span>',
                    align    = 'bottom-right',
                    elements = {
							{label = '<span style="color:red">رجوع</span>',  value = 'no'},
							{label = '<span style="color:green">نعم</span>', value = 'yes'},
						}
					}, function(data2, menu2)
						if data2.current.value == 'yes' then
			            TriggerServerEvent("esx_misc:GiveTeleportMenu", "all")
						end
						menu2.close()
					end, function(data2, menu2) menu2.close() end)
			elseif action == 'delete_all_cars' then
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'select_delete_all_cars', {
					title = 'قائمة حذف المركبات',
					align = 'top-left',
					elements = {
						{label = '🚗 أعلان وقت حذف المركبات', value = 'ads_delete_all_cars'},
						{label = '🚗 حدد وقت حذف المركبات', value = 'time_delete_all_cars'},
						{label = '🚗 حذف جميع المركبات', value = 'delete_all_cars_now'}
					}
				}, function(data10, menu10)
					if data10.current.value == 'time_delete_all_cars' then
						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'confierm_delete_all_cars', {
							title = 'حدد كم تبي الوقت الي تنحذف فيه المركبات'
						}, function(data11, menu11)
							toss = tonumber(data11.value)
							if toss == nil then
								ESX.ShowNotification(_U('quantity_invalid'))
							else
								menu11.close()
								TriggerServerEvent("esx_misc:NoCrimetime", 'deleteallcars', false, toss)
							end
						end, function(data11, menu11)
							menu11.close()
					end)
					elseif data10.current.value == 'ads_delete_all_cars' then
						TriggerServerEvent('_chat:messageEntered', 'الرقابة و التفتيش', {198, 40, 40}, 'سيتم حذف جميع المركبات بعد ^9' .. toss .. '^0 دقائق')
						TriggerServerEvent("esx_misc:NoCrimetime", 'deleteallcars', true)
					elseif data10.current.value == 'delete_all_cars_now' then
						TriggerServerEvent('EasyAdmin:requestCleanup', "cars")
						TriggerServerEvent('EasyAdmin:requestCleanup', "peds")
						TriggerServerEvent('EasyAdmin:requestCleanup', "props")
						TriggerServerEvent('_chat:messageEntered', 'الرقابة و التفتيش', {198, 40, 40}, 'تم حذف جميع المركبات ^9')
					end
				end, function(data10, menu10)
					menu10.close()
			end)
			-------------------------------
			elseif action == 'teleport' then
			  -------------------------------
					local t1 = 0
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'peace_time',
					{
						title = 'أيدي الشخص الذي تريد إعطائه قائمة الأنتقال',
					}, function(data2, menu2)
						t1 = tonumber(data2.value)
						if t1 > 0 then
						TriggerServerEvent("esx_misc:GiveTeleportMenu", t1)
						end
							menu2.close()
					end, function(data2, menu2)
						menu2.close()
					end)
					-------------------------------
			elseif action == 'NoCrimetimeMenu' then
				local elements = {
					
					{label = '<font color=red>ممنوع الأجرام</font>',	value = 'toggle', promotionName = 'NoCrimetime'},

					{label = '<font color=yellow>إعادة ضبط وقت ممنوع الأجرام</font>',	value = 'timeng', promotionName = 'NoCrimetime'},

					{label = '<font color=red>ممنوع الأجرام في لوس</font>',	value = 'toggle', promotionName = 'LosSantonNoCrime'},
					
					{label = '<font color=yellow>إعادة ضبط وقت ممنوع الأجرام في لوس</font>',	value = 'timeng', promotionName = 'LosSantonNoCrime'},

					{label = '<font color=red>ممنوع الأجرام في ساندي</font>',	value = 'toggle', promotionName = 'SandyNoCrime'},

					{label = '<font color=yellow>إعادة ضبط وقت ممنوع الأجرام في ساندي</font>',	value = 'timeng', promotionName = 'SandyNoCrime'},

					{label = '<font color=red>ممنوع الأجرام في بوليتو</font>',	value = 'toggle', promotionName = 'PoletoNoCrime'},

					{label = '<font color=yellow>إعادة ضبط وقت ممنوع الأجرام في بوليتو</font>',	value = 'timeng', promotionName = 'PoletoNoCrime'},

					{label = '<font color=red>ممنوع الأجرام في ساندي وبليتو</font>',	value = 'toggle', promotionName = 'SandyAndPoleto'},

					{label = '<font color=yellow>إعادة ضبط وقت ممنوع الأجرام في ساندي وبليتو</font>',	value = 'timeng', promotionName = 'SandyAndPoleto'},

					{label = '<font color=red>ممنوع بدأ سيناريو جديد</font>',	value = 'toggle', promotionName = 'NewScenario'},

					{label = '<font color=yellow>إعادة ضبط وقت ممنوع بدأ سيناريو جديد</font>',	value = 'timeng', promotionName = 'NewScenario'},

					{label = '<font color=red>ممنوع سرقة معرض الفنون</font>',	value = 'toggle', promotionName = 'alfnon'},

					{label = '<font color=yellow>إعادة ضبط وقت ممنوع سرقة معرض الفنون</font>',	value = 'timeng', promotionName = 'alfnon'},

					{label = '<font color=red>ممنوع بدأ سرقة البنك المركزي</font>',	value = 'toggle', promotionName = 'MainBank'},

					{label = '<font color=yellow>إعادة ضبط وقت ممنوع سرقة البنك المركزي</font>',	value = 'timeng', promotionName = 'MainBank'},

					{label = '<font color=red>يوجد حاليا سرقة بنك مركزي</font>',	value = 'toggle', promotionName = 'MainBankHave'},

					{label = '<font color=yellow>إعادة ضبط وقت يوجد حاليا بنك مركزي</font>',	value = 'timeng', promotionName = 'MainBankHave'},

					{label = '<font color=red>ممنوع بدأ سرقة البنوك الصغيرة</font>',	value = 'toggle', promotionName = 'SmallBanks'},

					{label = '<font color=yellow>إعادة ضبط وقت ممنوع سرقة البنوك الصغيرة</font>',	value = 'timeng', promotionName = 'SmallBanks'},

					{label = '<font color=red>يوجد حاليا سرقة بنك صغير</font>',	value = 'toggle', promotionName = 'SmallBanksHave'},

					{label = '<font color=yellow>إعادة ضبط وقت يوجد حاليا بنك صغير</font>',	value = 'timeng', promotionName = 'SmallBanksHave'},

					{label = '<font color=red>ممنوع بدأ سرقة المتاجر</font>',	value = 'toggle', promotionName = 'Stores'},

					{label = '<font color=yellow>إعادة ضبط وقت ممنوع سرقة المتاجر</font>',	value = 'timeng', promotionName = 'Stores'},

					{label = '<font color=red>يوجد حاليا سرقة متجر</font>',	value = 'toggle', promotionName = 'StoresHave'},

					{label = '<font color=yellow>إعادة ضبط وقت يوجد حاليا سرقة متجر</font>',	value = 'timeng', promotionName = 'StoresHave'},

					{label = '<font color=red>ممنوع تهريب الممنوعات</font>',	value = 'toggle', promotionName = 'SellDrugs'},

					{label = '<font color=yellow>إعادة ضبط وقت ممنوع تهريب الممنوعات</font>',	value = 'timeng', promotionName = 'SellDrugs'},

				}
			
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Panic_Button_Menu', {

					title    = 'التحكم بالمنع',

					align    = 'top-left',

					elements = elements

				}, function(data3, menu3)

					local action = data3.current.value

					local label = data3.current.label

					local promotion = data3.current.promotionName
					
					if action == 'toggle' then

						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_menu', {

							title    = 'تأكيد أعلان '..label,

							align    = 'bottom-right',

							elements = {

								{label = '<span style="color:red">رجوع</span>',  value = 'no'},

								{label = '<span style="color:green">نعم</span>', value = 'yes'},

							}

						}, function(data2, menu2)

							if data2.current.value == 'yes' then

								TriggerServerEvent("esx_misc:NoCrimetime", promotion, true)

							end

							menu2.close()

						end, function(data2, menu2)
							
							menu2.close()

						end)

					elseif action == 'timeng' then

						local Mtime = 0

						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'timeng', {

							title = 'أكتب الوقت بالدقائق (أكتب 111 في حال الرغبة في إلغاء الوقت)',

						}, function(data2, menu2)

							Mtime = tonumber(data2.value)
							
							if Mtime ~= nil and Mtime >= 0 and Mtime <= 1000 then

								TriggerServerEvent("esx_misc:NoCrimetime", promotion, false, Mtime)

							end

							menu2.close()

						end, function(data2, menu2)

							menu2.close()

						end)
						
					end
						
				end, function(data3, menu3)

					menu3.close()

				end)

			  elseif  data.current.value == '9eanh_time' then
				local p1, p2 = 0, 0 
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), '9eanh_time',
				{
					title = 'بعد كم دقيقة وقت صيانة يبدأ (أقصى شيء 10 اذا تبي يحط وقت صيانة على طول 11)',
				}, function(data2, menu2)
					p1 = tonumber(data2.value)
					if p1 ~= nil and p1 >= 0 then
						------------------------------------------
						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), '9eanh_time_2',
						{
							title = 'كم مدة وقت الصيانة بالدقائق؟',
						}, function(data3, menu3)
							p2 = tonumber(data3.value)
							if p2 ~= nil and p2 >= 0 then
								TriggerServerEvent("esx_misc:TogglePanicButton", '9eanh_time', 0, p1, p2)
								--ESX.UI.Menu.CloseAll()
							end
								menu3.close()
						end, function(data3, menu3)
							menu3.close()
						end)
						------------------------------------------
					end
						menu2.close()
				end, function(data2, menu2)
					menu2.close()
				end)
			  elseif data.current.value == 'peace_time' then
					-------------------------------
					local p1, p2 = 0, 0 
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'peace_time',
					{
						title = 'بعد كم دقيقة وقت الراحة يبدأ (أقصى شيء 10 اذا تبي يحط وقت راحة على طول 11)',
					}, function(data2, menu2)
						p1 = tonumber(data2.value)
						if p1 ~= nil and p1 >= 0 then
							------------------------------------------
							ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'peace_time_2',
							{
								title = 'كم مدة وقت الراحة بالدقائق؟',
							}, function(data3, menu3)
								p2 = tonumber(data3.value)
								if p2 ~= nil and p2 >= 0 then
									TriggerServerEvent("esx_misc:TogglePanicButton", 'peace_time', 0, p1, p2)
									--ESX.UI.Menu.CloseAll()
								end
									menu3.close()
							end, function(data3, menu3)
								menu3.close()
							end)
							------------------------------------------
						end
							menu2.close()
					end, function(data2, menu2)
						menu2.close()
					end)
				-------------------------------
			elseif action == 'restricted_area' then
                -------------------------------
                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_menu', {
                        title    = 'تأكيد اعلان منطقة محظورة بنفس موقعك؟ (او إلغاء اذا كانت مفعلة)',
                        align    = 'bottom-right',
                        elements = {
                                {label = '<span style="color:red">رجوع</span>',  value = 'no'},
                                {label = '<span style="color:green">نعم</span>', value = 'yes'},
                            }
                        }, function(data2, menu2)
                            if data2.current.value == 'yes' then
                                local ped = PlayerPedId()
                local pedCoords = GetEntityCoords(ped)
                TriggerServerEvent("esx_misc:TogglePanicButton", 'restricted_area', pedCoords)
                            end
                            menu2.close()
                        end, function(data2, menu2) menu2.close() end)
                -------------------------------
            elseif action == 'my_location_safezone' then
            -------------------------------
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_menu', {
                        title    = 'تأكيد اعلان ﻣﻮﻗﻊ ﺁﻣﻦ بنفس موقعك؟ (او إلغاء اذا كانت مفعلة)',
                        align    = 'bottom-right',
                        elements = {
                                {label = '<span style="color:red">رجوع</span>',  value = 'no'},
                                {label = '<span style="color:green">نعم</span>', value = 'yes'},
                            }
                        }, function(data2, menu2)
                            if data2.current.value == 'yes' then
                                local ped = PlayerPedId()
                local pedCoords = GetEntityCoords(ped)
                TriggerServerEvent("esx_misc:TogglePanicButton", 'my_location_safezone', pedCoords)
                            end
                            menu2.close()
                        end, function(data2, menu2) menu2.close() end)

		elseif action == 'Panic_Button_Menu' then 
				
					local elements = {
						{label = _U('ports_PB_Menu'),			value = 'ports_PB_Menu'},
						{label = _U('banks_PB_Menu'),			value = 'banks_PB_Menu'},
						{label = _U('public_garage_PB_Menu'),	value = 'public_garage_PB_Menu'},
						{label = _U('Other_PB_Menu'),			value = 'Other_PB_Menu'},
						{label = _U('my_place_PB_Menu'),		value = 'my_place_PB_Menu'},
						--{label = _U('hacker_PB_Menu'),			value = 'hacker_PB_Menu'},
					}
				
					ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'Panic_Button_Menu',
					{
						title    = _U('Panic_Button_Menu'),
						align    = 'top-left',
						elements = elements
					}, function(data3, menu3)
						local action = data3.current.value
						
						if action == 'ports_PB_Menu' then
						--start ports
							local elements = {
							{label = _U('sea_port'),		value = 'sea_port'},
							{label = _U('seaport_west'),	value = 'seaport_west'},
							{label = _U('international_airport'),	value = 'international_airport'},
							{label = _U('sandy_airport'),			value = 'sandy_airport'},
							{label = _U('farm_airport'),			value = 'farm_airport'},
							}
						
							ESX.UI.Menu.Open(
							'default', GetCurrentResourceName(), 'ports_PB_Menu',
							{
								title    = _U('Panic_Button_Menu')..' - '.._U('ports_PB_Menu'),
								align    = 'top-left',
								elements = elements
							}, function(data4, menu4)
								local action = data4.current.value
								
								TriggerServerEvent("esx_misc:TogglePanicButton", action)
								
							end, function(data4, menu4)
								menu4.close()
							end)
						--end ports
						elseif action == 'banks_PB_Menu' then
						--start banks
							--start menu
							local elements = {
								--add menu elements
								
								{label = _U('pacific_bank'),value = 'pacific_bank'},
								{label = _U('paleto_bank'),	value = 'paleto_bank'},
								{label = _U('sandy_bank'),	value = 'sandy_bank'},
							}
						
							ESX.UI.Menu.Open(
							'default', GetCurrentResourceName(), 'banks_PB_Menu',
							{
								title    = _U('Panic_Button_Menu')..' - '.._U('banks_PB_Menu'), --menu tittle
								align    = 'top-left',
								elements = elements
							}, function(data4, menu4) --change data menu number
								local action = data4.current.value
								--add if statment to excute
								TriggerServerEvent("esx_misc:TogglePanicButton", action)
								
							end, function(data4, menu4) --change data menu number
								menu4.close()
							end)
							--end menu	
						--end banks
						elseif action == 'public_garage_PB_Menu' then
						--start public_garage
							--start menu
							local elements = {
								--add menu elements
								{label = _U('public_car_garage_los_santos'),value = 'public_car_garage_los_santos'},
								{label = _U('public_car_garage_sandy'),		value = 'public_car_garage_sandy'},
								{label = _U('public_car_garage_paleto'),	value = 'public_car_garage_paleto'},
							}
						
							ESX.UI.Menu.Open(
							'default', GetCurrentResourceName(), 'public_garage_PB_Menu',
							{
								title    = _U('Panic_Button_Menu')..' - '.._U('public_garage_PB_Menu'), --menu tittle
								align    = 'top-left',
								elements = elements
							}, function(data4, menu4) --change data menu number
								local action = data4.current.value
								--add if statment to excute
								TriggerServerEvent("esx_misc:TogglePanicButton", action)
								
							end, function(data4, menu4) --change data menu number
								menu4.close()
							end)
							--end menu	
						--end public_garage
						elseif action == 'Other_PB_Menu' then
							--start 
								--start menu
								local elements = {
									--add menu elements
									{label = _U('alshaheed_gardeen'),			value = 'alshaheed_gardeen'},
									{label = _U('army_base'),					value = 'army_base'},
									--{label = _U('white_house'),					value = 'white_house'},
									--{label = _U('cardealer_new'),				value = 'cardealer_new'},
									--{label = _U('aucation_house'),				value = 'aucation_house'},
								}
							
								ESX.UI.Menu.Open(
								'default', GetCurrentResourceName(), 'Other_PB_Menu',
								{
									title    = _U('Panic_Button_Menu')..' - '.._U('Other_PB_Menu'), --menu tittle
									align    = 'top-left',
									elements = elements
								}, function(data4, menu4) --change data menu number
									local action = data4.current.value
									--add if statment to excute
									TriggerServerEvent("esx_misc:TogglePanicButton", action)	
									
								end, function(data4, menu4) --change data menu number
									menu4.close()
								end)
								--end menu	
							--end
						elseif action == 'my_place_PB_Menu' then
							local ped = PlayerPedId()
							local pedCoords = GetEntityCoords(ped)
							exports["esx_misc"]:TriggerMyLocPanicButton()
						elseif action == 'hacker_PB_Menu' then
							TriggerServerEvent("esx_misc:TogglePanicButton", 'hacker')
							Citizen.Wait(2000)
							ESX.ShowNotification('لاتنسى أنعاش الجميع في حال التفعيل')
						end
					
					end, function(data3, menu3)
						menu3.close()
					end)		
		elseif action == 'hacker' then
		 -------------------------------
		    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_menu', {
                    title    = 'تأكيد أعلان '..label,
                    align    = 'bottom-right',
                    elements = {
							{label = '<span style="color:red">رجوع</span>',  value = 'no'},
							{label = '<span style="color:green">نعم</span>', value = 'yes'},
						}
					}, function(data2, menu2)
						if data2.current.value == 'yes' then
							TriggerServerEvent("esx_misc:TogglePanicButton", 'hacker')
			                Citizen.Wait(1)
			                ESX.ShowNotification('لاتنسى أنعاش الجميع في حال التفعيل')
						end
						menu2.close()
					end, function(data2, menu2) menu2.close() end)
			-------------------------------
		elseif action == 'restart_time' then
					--[[ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_menu', {
                    title    = 'تأكيد اعلان<font color=orange> '..label..'</font> ?',
                    align    = 'bottom-right',
                    elements = {
							{label = '<span style="color:red">رجوع</span>',  value = 'no'},
							{label = '<span style="color:green">نعم</span>', value = 'yes'},
						}
					}, function(data2, menu2)
						if data2.current.value == 'yes' then
							TriggerServerEvent("esx_misc:TogglePanicButton", action, 0, 1, 3)
						end
						menu2.close()
					end, function(data2, menu2) menu2.close() end)]]
					-------------------------------
					local p1, p2 = 0, 0 
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'peace_time',
					{
						title = 'بعد كم دقيقة يبدأ وقت الريستارت؟ (أقصى شيء 10 اذا تبي يحط وقت راحة على طول 11)',
					}, function(data2, menu2)
						p1 = tonumber(data2.value)
						if p1 ~= nil and p1 >= 0 then
							------------------------------------------
							ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'peace_time_2',
							{
								title = 'كم مدة وقت الرستارت بالدقيقة',
							}, function(data3, menu3)
								p2 = tonumber(data3.value)
								if p2 ~= nil and p2 >= 0 then
									TriggerServerEvent("esx_misc:TogglePanicButton", action, 0, p1, p2)
									--ESX.UI.Menu.CloseAll()
								end
									menu3.close()
							end, function(data3, menu3)
								menu3.close()
							end)
							------------------------------------------
						end
							menu2.close()
					end, function(data2, menu2)
						menu2.close()
					end)
					-------------------------------
					
				--panic_button_menu
		
		elseif action == 'event_menu' then
					------------
					local elements = {
						{label = _U('event_location'),		value = 'event_location'},
						{label = _U('event_start'),			value = 'event_start'},
						{label = _U('event_registration'),	value = 'event_registration'},
						{label = _U('event_end'),			value = 'event_end'},
					}
				
					ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'event_menu',
					{
						title    = 'إدارة الفعاليات',
						align    = 'top-left',
						elements = elements
					}, function(data3, menu3)
						local action = data3.current.value
						local label = data3.current.label
						---------
						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_menu', {
							title    = 'تأكيد اعلان <font color=orange>'..label..'</font>',
							align    = 'bottom-right',
							elements = {
									{label = '<span style="color:red">رجوع</span>',  value = 'no'},
									{label = '<span style="color:green">نعم</span>', value = 'yes'},
								}
							}, function(data4, menu4)
								if data4.current.value == 'yes' then
									local ped = PlayerPedId()
									local pedCoords = GetEntityCoords(ped)
									TriggerServerEvent("esx_misc:TogglePanicButton", action, pedCoords)
								end
								menu4.close()
						end, function(data4, menu4) menu4.close() end)
					
				
			
			end, function(data2, menu2)
				menu2.close()
			end)	
			  elseif data55.current.value == 'peace-stop' then
				ExecuteCommand("peacestop") -- ExecuteCommand("peace 1440")
			  end
			end, function(data55, menu2)
			  menu2.close()
			end)
		end
		if data.current.value == 'stnfar' then
		
			TriggerEvent("iysood_panic:NewPanicAlt")
	    end
		if data.current.value == 'mina' then
			local elements = {
			  {label = _U('sea_port_close'), value = 'sea_port_close'},
				{label = _U('seaport_west_close'), value = 'seaport_west_close'},
				{label = _U('internationa_close'), value = 'internationa_close'},
			  {label = '<span style="color:yellow;"> تحويل </span> موقع التصدير', value = 'convert'},
			  {label = '<span style="color:yellow;"> افتتاح </span> التوسعات', value = 'afttah_altws3at'},
			  --{label = '💴 <span style="color:white;"> تهريب المخدرات بالميناء </span> إغلاق/إتاحة', value = 'control_selldrugs'},
			}
	  
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mina', {
			  title    = "🛳️ الميناء",
			  align    = 'bottom-right',
			  elements = elements
			}, function(data2, menu2)
			local action = data2.current.value
			local label = data2.current.label
			  if action == 'sea_port_close' or action == 'seaport_west_close' or action == 'internationa_close' then
				 -------------------------------
		    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_menu', {
                    title    = 'تأكيد أعلان '..label,
                    align    = 'bottom-right',
                    elements = {
							{label = '<span style="color:red">رجوع</span>',  value = 'no'},
							{label = '<span style="color:green">نعم</span>', value = 'yes'},
						}
					}, function(data2, menu2)
						if data2.current.value == 'yes' then
							TriggerServerEvent("esx_misc:TogglePanicButton", action)
						end
						menu2.close()
					end, function(data2, menu2) menu2.close() end)
			-------------------------------
		elseif data2.current.value == 'afttah_altws3at' then
			menu2.close()
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = "افتتاح توسعة",
				align    = 'bottom-right',
				elements = {
					{label = 'توسعة <span style="color:green">1', value = 'tws3h_1'},
					{label = 'توسعة <span style="color:green">2', value = 'tws3h_2'},
					{label = 'توسعة <span style="color:green">3', value = 'tws3h_3'},
					{label = 'توسعة <span style="color:green">4', value = 'tws3h_4'}
				}
			}, function(data2, menu2)
				if data2.current.value == 'tws3h_1' then
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'conf2irm_menu', {
						title    = 'تأكيد تحويل موقع التصدير الى ميناء 707 ستور البحري ' .. '<span style="color:green"> توسعة 1',
						align    = 'bottom-right',
						elements = {
							{label = '<span style="color:red">رجوع</span>',  value = 'no'},
							{label = '<span style="color:green">نعم</span>', value = 'yes'},
						}
					}, function(data3, menu3)
						if data3.current.value == 'yes' then
							TriggerServerEvent("esx_misc:togglePort", 11)
						end
							menu3.close()
					end, function(data3, menu3) 
						menu3.close() 
				end)
				elseif data2.current.value == 'tws3h_2' then
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'conf2irm_menu', {
						title    = 'تأكيد تحويل موقع التصدير الى ميناء 707 ستور البحري ' .. '<span style="color:green"> توسعة 2',
						align    = 'bottom-right',
						elements = {
							{label = '<span style="color:red">رجوع</span>',  value = 'no'},
							{label = '<span style="color:green">نعم</span>', value = 'yes'},
						}
					}, function(data3, menu3)
						if data3.current.value == 'yes' then
							TriggerServerEvent("esx_misc:togglePort", 12)
						end
							menu3.close()
					end, function(data3, menu3) 
						menu3.close() 
				end)
				elseif data2.current.value == 'tws3h_3' then
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'conf2irm_menu', {
						title    = 'تأكيد تحويل موقع التصدير الى ميناء 707 ستور البحري ' .. '<span style="color:green"> توسعة 3',
						align    = 'bottom-right',
						elements = {
							{label = '<span style="color:red">رجوع</span>',  value = 'no'},
							{label = '<span style="color:green">نعم</span>', value = 'yes'},
						}
					}, function(data3, menu3)
						if data3.current.value == 'yes' then
						TriggerServerEvent("esx_misc:togglePort", 13)
						end
						menu3.close()
					end, function(data3, menu3) menu3.close() end)
				elseif data2.current.value == 'tws3h_4' then
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'conf2irm_menu', {
						title    = 'تأكيد تحويل موقع التصدير الى ميناء 707 ستور البحري ' .. '<span style="color:green"> توسعة 4',
						align    = 'bottom-right',
						elements = {
							{label = '<span style="color:red">رجوع</span>',  value = 'no'},
							{label = '<span style="color:green">نعم</span>', value = 'yes'},
						}
					}, function(data3, menu3)
						if data3.current.value == 'yes' then
							TriggerServerEvent("esx_misc:togglePort", 14)
						end
						menu3.close()
					end, function(data3, menu3) menu3.close() end)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
				elseif data2.current.value == 'control_selldrugs' then
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'control-selldrugs', {
			title = "هل أنت متأكد من إغلاق/إتاحة التهريب بالميناء?",
			align = 'top-left',
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		    }}, function(data, menu)
			menu.close()

			if data.current.value == 'yes' then
				TriggerServerEvent('esx_drugs:toggleselldrugs')
				end
				end)
			  elseif data2.current.value == 'convert' then
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				  title    = "تحويل الموانئ",
				  align    = 'bottom-right',
				  elements = {
					{label = 'ميناء 707 ستور البحري', value = 'main'},
					{label = 'ميناء 707 ستور الغربي', value = 'west'},
					{label = 'مطار الملك عبدالعزيز الدولي', value = 'airport'}
				  }
				}, function(data2, menu2)
				  if data2.current.value == 'main' then
				    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'conf2irm_menu', {
                  title    = 'تأكيد تحويل موقع التصدير الى ميناء 707 ستور البحري',
                  align    = 'bottom-right',
                  elements = {
					{label = '<span style="color:red">رجوع</span>',  value = 'no'},
					{label = '<span style="color:green">نعم</span>', value = 'yes'},
				}
			}, function(data3, menu3)
				if data3.current.value == 'yes' then
					TriggerServerEvent("esx_misc:togglePort", 1)
				end
				menu3.close()
			end, function(data3, menu3) menu3.close() end)
			elseif data2.current.value == 'west' then
				  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_mdenu', {
                  title    = 'تأكيد تحويل موقع التصدير الى ميناء 707 ستور الغربي',
                  align    = 'bottom-right',
                  elements = {
					{label = '<span style="color:red">رجوع</span>',  value = 'no'},
					{label = '<span style="color:green">نعم</span>', value = 'yes'},
				}
			}, function(data3, menu3)
				if data3.current.value == 'yes' then
					TriggerServerEvent("esx_misc:togglePort", 2)
				end
				menu3.close()
			end, function(data3, menu3) menu3.close() end)
				  elseif data2.current.value == 'airport' then
				     ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirmad_menu', {
                  title    = 'تأكيد تحويل موقع التصدير الى مطار الملك عبدالعزيز الدولي',
                  align    = 'bottom-right',
                  elements = {
					{label = '<span style="color:red">رجوع</span>',  value = 'no'},
					{label = '<span style="color:green">نعم</span>', value = 'yes'},
				}
			}, function(data3, menu3)
				if data3.current.value == 'yes' then
					TriggerServerEvent("esx_misc:togglePort", 3)
				end
				menu3.close()
			end, function(data3, menu3) menu3.close() end)
					
				  end
				end, function(data2, menu2)
				  menu2.close()
				end)
			  end
			end, 
			function(data2, menu2)
			  menu2.close()
			end)
		end

		if data.current.value == 'citizen_interaction' then
			local elements = {
				{label = _U('id_card'), value = 'identity_card'},
				{label = _U('search'), value = 'search'},
				{label = _U('handcuff'), value = 'handcuff'},
				-- {label = "فك كلبشة 🟢", value = 'unhandcuff'},
				{label = _U('drag'), value = 'drag'},
				{label = _U('put_in_vehicle'), value = 'put_in_vehicle'},
				{label = _U('out_the_vehicle'), value = 'out_the_vehicle'},
				{label = _U('fine'), value = 'fine'},
				{label = _U('unpaid_bills'), value = 'unpaid_bills'},
				--{label = 'سجل جنائي - الشرطة',      value = 'criminalrecords'},
				--{label = 'سجل جنائي  - الرقابة و التفتيش',      value = 'criminalrecordsr9abh'},
				{label = "<span style='color:#5DADE2;'>التحقق من الخبرة 🌐", value = 'checkxp'},
				--{label = "<span style='color:#0fd644;'>اضافة خبرة ⏫ <br><span  style='color:#FF0E0E;font-size:15'>تنبيه: <span style='color:gray;'>يمنع الأستعمال الا في حال استشارة الادارة العليا", value = 'addxp'},
				--{label = '<span style="color:#d60f0f;">ازالة خبرة ⏬ <br><span  style="color:#FF0E0E;font-size:15">تنبيه: <span style="color:gray;">يمنع الأستعمال الا في حال استشارة الادارة العليا', value = 'removexp'},
			}
			
			if grade >= 1 then
		--table.insert(elements, {label = _U('Panic_Button_Menu'), value = 'Panic_Button_Menu'})
		table.insert(elements, {label = 'سجل جنائي - الشرطة', value = 'criminalrecords'})
		table.insert(elements, {label = 'سجل حرس الحدود', value = 'criminalrecordsagent'})
		table.insert(elements, {label = 'سجل الرقابة و التفتيش', value = 'criminalrecordsr9abh'})
		table.insert(elements, {label = 'سجل متجر المدينة 🛒', value = 'criminalrecords_tebex'})
	else
		--table.insert(elements, {label = _U('Panic_Button_Menu_unavailable')})
		table.insert(elements, {label = '<font color=gray>سجل جنائي شرطة متاح من رتبة مشرف'})
		table.insert(elements, {label = '<font color=gray>سجل حرس الحدود متاح من رتبة مشرف'})
		table.insert(elements, {label = '<font color=gray>سجل الرقابة و التفتيش متاح من رتبة مشرف'})
		table.insert(elements, {label = '<font color=gray>سجل متجر المدينة متاح من رتبة مشرف'})
	end	
	


			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = _U('citizen_interaction'),
				align    = 'top-left',
				elements = elements
			}, function(data2, menu2)
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					local action = data2.current.value

					if action == 'identity_card' then
						OpenIdentityCardMenu(closestPlayer)
					elseif action == 'search' then
						OpenBodySearchMenu(closestPlayer)
					elseif action == 'handcuff' then 
					    TriggerEvent('esx_misc:togglehandcuff')
					elseif action == 'drag' then
					    TriggerServerEvent('esx_misc:drag', GetPlayerServerId(closestPlayer))
					elseif action == 'put_in_vehicle' then
					    TriggerServerEvent('esx_misc:putInVehicle', GetPlayerServerId(closestPlayer))
					elseif action == 'out_the_vehicle' then
						TriggerServerEvent('esx_misc:OutVehicle', GetPlayerServerId(closestPlayer))
					elseif action == 'fine' then
						OpenFineMenu(closestPlayer)
					elseif action == 'license' then
						ShowPlayerLicense(closestPlayer)
					elseif action == 'unpaid_bills' then
						OpenUnpaidBillsMenu(closestPlayer)
					elseif action == 'criminalrecords' then
						OpenCriminalRecords(closestPlayer)
					elseif action == 'criminalrecordsagent' then -- criminalrecordsagent
						OpenCriminalRecordsAgent(closestPlayer)
					elseif action == 'criminalrecordsr9abh' then
						OpenCriminalRecordsr9abh(closestPlayer)			
                    elseif action == 'criminalrecords_tebex' then
						OpenCriminalRecords_tebex(closestPlayer)																
					elseif action == 'checkxp' then
						ESX.TriggerServerCallback('getRankPlayer:getRankPlayerByMenuwesam', function(xp)
							ESX.ShowNotification('<font color=#5DADE2>'..xp..'</font> خبرة اللاعب')
						end, GetPlayerServerId(closestPlayer))
		elseif action == 'addxp' then

			menu.close()

			ESX.UI.Menu.Open(
          		'dialog', GetCurrentResourceName(), 'jail_choose_time_menu',
          		{
            		title = "العدد؟"
          		},
          	function(data2, menu2)

            	local jailTime = tonumber(data2.value)

            	if jailTime == nil then
              		ESX.ShowNotification("يجب أن يكون العدد صحيح!")
            	else
              		menu2.close()

						ESX.UI.Menu.Open(
							'dialog', GetCurrentResourceName(), 'jail_choose_reason_menu',
							{
							  title = "سبب الإضافة"
							},
						function(data3, menu3)
		  
						  	local reason = data3.value
		  
						  	if reason == nil then
								ESX.ShowNotification("يجب ملئ سبب الإضافة")
						  	else
								menu3.close()
								if closestPlayer == -1 or closestDistance > 3.0 then
									ESX.ShowNotification("لا يوجد لاعب بالجوار!")
							  	else		  
									TriggerServerEvent("esx_xp:addXP-NODUBLE", GetPlayerServerId(closestPlayer), jailTime)
									ESX.ShowNotification("لقد قمت بإضافة <span style='color:#34abeb;'>" ..jailTime.."</span> خبرة الى <br><span style='color:orange;'>" .. GetPlayerName(closestPlayer))
									TriggerServerEvent("wesam:NotifyPlayer", GetPlayerServerId(closestPlayer), jailTime, reason)
									--TriggerServerEvent('esx_xp:f6givexp', ('اضافة خبرة'), 'قام الأدمن\n`' ..GetPlayerName(PlayerId()).. '`\n\nبإضافة خبرة الى اللاعب\n`' ..GetPlayerName(closestPlayer).. '`\nXP: `' .. jailTime..'`', 3066993)
		                            TriggerServerEvent('esx_xp:f6givexplog', ('أضافة خبرة'), 'قام المراقب\n`' ..GetPlayerName(PlayerId()).. '` \n\nبأضافة خبرة للاعب\n`' ..GetPlayerName(GetPlayerFromServerId(Playerid)).. '`\nXP: `' .. jailTime..'`\n سبب : `'..reason..'` ',10038562)
								    --TriggerServerEvent('_chat:messageEntered', GetPlayerName(PlayerId()), { 0, 0, 0 }, reason.."^0"..xPlayer.getName().."^3 خصم خبرة")
								end
						  	end
		  
						end, function(data3, menu3)
							menu3.close()
						end)

				end

          	end, function(data2, menu2)
				menu2.close()
			end)
		elseif action == 'removexp' then

			menu.close()

			ESX.UI.Menu.Open(
          		'dialog', GetCurrentResourceName(), 'jail_choose_time_menu',
          		{
            		title = "العدد المراد ازالتها"
          		},
          	function(data2, menu2)

            	local jailTime = tonumber(data2.value)

            	if jailTime == nil then
              		ESX.ShowNotification("يجب أن يكون العدد صحيح!")
            	else
              		menu2.close()

						ESX.UI.Menu.Open(
							'dialog', GetCurrentResourceName(), 'jail_choose_reason_menu',
							{
							  title = "سبب الإزالة"
							},
						function(data3, menu3)
		  
						  	local reason = data3.value
		  
						  	if reason == nil then
								ESX.ShowNotification("يرجى ملئ سبب الإزالة")
						  	else
								menu3.close()
		  
								if closestPlayer == -1 or closestDistance > 3.0 then
								  ESX.ShowNotification("لا يوجد لاعب بالجوار!")
							    else		  
								  TriggerServerEvent("esx_xp:removeXP", GetPlayerServerId(closestPlayer), jailTime)
								  ESX.ShowNotification("لقد قمت بإزالة <span style='color:#ed1515;'>" ..jailTime.."</span> خبرة من <br><span style='color:orange;'>" .. GetPlayerName(closestPlayer))
								  TriggerServerEvent("wesam:NotifyPlayerRemove", GetPlayerServerId(closestPlayer), jailTime, reason)
								  --TriggerServerEvent('esx_adminjob:msg1', ('ازالة خبرة'), 'قام الأدمن\n`' ..GetPlayerName(PlayerId()).. '`\n\nبإزالة خبرة من الاعب\n`' ..GetPlayerName(closestPlayer).. '`\nXP: `' .. jailTime..'`',10038562)
		                          TriggerServerEvent('esx_xp:f6removexplog', ('إزالة خبرة'), 'قام المراقب\n`' ..GetPlayerName(PlayerId()).. '` \n\n خصم خبرة للاعب\n`' ..GetPlayerName(GetPlayerFromServerId(Playerid)).. '`\nXP: `' .. jailTime..'`\n سبب : `'..reason..'` ',10038562)
								end
						  	end
		  
						end, function(data3, menu3)
							menu3.close()
						end)

				end

          	end, function(data2, menu2)
				menu2.close()
			end)						
						end
				elseif action == 'ems_revive' then
				revivePlayer(closestPlayer)
				else
					ESX.ShowNotification(_U('no_players_nearby'))
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'vehicle_interaction' then
			local elements  = {}
			local playerPed = PlayerPedId()
			local vehicle = ESX.Game.GetVehicleInDirection()

			if DoesEntityExist(vehicle) then
				table.insert(elements, {label = _U('vehicle_info'), value = 'vehicle_infos'})
				table.insert(elements, {label = _U('pick_lock'), value = 'hijack_vehicle'})
				--table.insert(elements, {label = _U('impound'), value = 'impound'})
			end

			table.insert(elements, {label = _U('search_database'), value = 'search_database'})

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_interaction', {
				title    = _U('vehicle_interaction'),
				align    = 'top-left',
				elements = elements
			}, function(data2, menu2)
				local coords  = GetEntityCoords(playerPed)
				vehicle = ESX.Game.GetVehicleInDirection()
				action  = data2.current.value

				if action == 'search_database' then
					LookupVehicle()
				elseif DoesEntityExist(vehicle) then
					if action == 'vehicle_infos' then
						local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
						OpenVehicleInfosMenu(vehicleData)
					elseif action == 'hijack_vehicle' then
						if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
							TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
							Citizen.Wait(20000)
							ClearPedTasksImmediately(playerPed)

							SetVehicleDoorsLocked(vehicle, 1)
							SetVehicleDoorsLockedForAllPlayers(vehicle, false)
							ESX.ShowNotification(_U('vehicle_unlocked'))
						end
					elseif action == 'impound' then
						-- is the script busy?
						if currentTask.busy then
							return
						end

						ESX.ShowHelpNotification(_U('impound_prompt'))
						TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)

						currentTask.busy = true
						currentTask.task = ESX.SetTimeout(10000, function()
							ClearPedTasks(playerPed)
							ImpoundVehicle(vehicle)
							Citizen.Wait(100) -- sleep the entire script to let stuff sink back to reality
						end)

						-- keep track of that vehicle!
						Citizen.CreateThread(function()
							while currentTask.busy do
								Citizen.Wait(1000)

								vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
								if not DoesEntityExist(vehicle) and currentTask.busy then
									ESX.ShowNotification(_U('impound_canceled_moved'))
									ESX.ClearTimeout(currentTask.task)
									ClearPedTasks(playerPed)
									currentTask.busy = false
									break
								end
							end
						end)
					end
				else
					ESX.ShowNotification(_U('no_vehicles_nearby'))
				end

			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'object_spawner' then -- props
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = _U('traffic_interaction'),
				align    = 'top-left',
				elements = {
				--[[
					{label = _U('cone'), model = 'prop_roadcone02a'},
					{label = 'حاجز سهم', model = 'prop_mp_arrow_barrier_01'},
					{label = 'حاجز حديد تنظيم', model = 'prop_fncsec_04a'},
					{label = 'حاجز اسمنتي طويل', model = 'prop_mp_barrier_01b'},
					{label = 'حاجز بلاستيكي صغير', model = 'prop_barrier_wat_03b'},
					{label = 'حاجز حديدي صغير', model = 'prop_mp_barrier_02b'},
					{label = 'عامود <font color=yellow>اصفر</font> صغير', model = 'prop_bollard_02a'},
					{label = 'حاجز اسمنتي احمر صغير', model = 'prop_barier_conc_05c'},
					{label = 'حاجز اسمنتي صغير', model = 'prop_barier_conc_02a'},
					{label = 'کوخ تفتیش', model = 'prop_air_sechut_01'},
					{label = 'مظلة عمود', model = 'prop_parasol_05'},
					{label = 'حاجز اسمنتي احمر طويل', model = 'prop_barier_conc_05b'},
					--{label = 'حاجز بلاستيكي الموانئ', model = 'prop_barrier_wat_01a'},
					{label = 'عمود نور کبیر', model = 'prop_worklight_03b'},
					{label = 'عمود نور', model = 'prop_worklight_01a'},
					--{label = 'مهبط هيلي', model = 'prop_helipad_01'},
					{label = 'حاجز مغطي', model = 'prop_fncsec_03d'},
					--{label = 'كوخ رقابة صغير', model = 'prop_trailer_01_new'},
					{label = 'مخفض سرعة كبير', model = 'stt_prop_track_slowdown_t2'},
					{label = 'مخفض سرعة صغير', model = 'stt_prop_track_slowdown'},
					--{label = 'مضخة بنزين ⛽', model = 'prop_vintage_pump'},
					{label = '<span style="color:white;">مضخة بنزين ⛽ <br><span  style="color:#FF0E0E;font-size:15"> <span style="color:gray;">استخدمها بحذر وحط حواجز و عواميد صفرة صغيرة<br><span  style="color:#FF0E0E;font-size:15"> <span style="color:gray;">عشان ماتنفجر على الناس', model = 'prop_vintage_pump'},
					{label = 'صرافة 🏧', model = 'prop_atm_01'},
					{label = 'برادة ماء 💧', model = 'prop_watercooler'},
					--{label = 'برادة ماء 💧 2', model = 'prop_watercooler_dark'},
					{label = 'كرسي', model = 'v_ilev_chair02_ped'},
					{label = 'كرسي مكتبي', model = 'prop_off_chair_01'},
					{label = 'أكياس أسمنت', model = 'prop_conc_sacks_02a'},
					{label = 'مربع داخله رمل', model = 'prop_mb_sandblock_01'},
					{label = 'شبك حديدي', model = 'prop_fncsec_03b'},
					{label = 'شبك حديدي لايمكن النط من فوقه', model = 'prop_fnclink_04a'},
					{label = _U('barrier'), model = 'prop_barrier_work05'},
					{label = _U('spikestrips'), model = 'p_ld_stinger_s'},
					{label = _U('box'), model = 'prop_boxpile_07d'},
					{label = _U('cash'), model = 'hei_prop_cash_crate_half_full'}
					--]]
					{label = _U('cone'),			model = 'prop_roadcone02a'},
					{label = _U('barrier_police'),	model = 'prop_barrier_work05'},
					{label = _U('barrier_arrow'),	model = 'prop_mp_arrow_barrier_01'},
					{label = _U('barrier_cment'),	model = 'prop_mp_barrier_01'},
					{label = _U('spikestrips'),		model = 'p_ld_stinger_s'},
					{label = _U('light_blue'),		model = 'prop_air_lights_02a'},
					{label = _U('light_red'),		model = 'prop_air_lights_02b'},
					{label = _U('light_white'),		model = 'prop_air_lights_03a'},
					{label = _U('light_high'),		model = 'prop_worklight_01a'},
					{label = _U('box'),				model = 'prop_boxpile_07d'},
					{label = _U('cash'),			model = 'hei_prop_cash_crate_half_full'},
					{label = _U('bbq'),				model = 'prop_bbq_1'},
					{label = _U('dog_house'),		model = 'prop_doghouse_01'},
					{label = _U('tent'),			model = 'prop_gazebo_02'},
					{label = _U('tent2'),			model = 'prop_parasol_01_b'},
					{label = _U('table'),			model = 'prop_ven_market_table1'},
					{label = _U('chair'),			model = 'prop_table_03_chr'},
					{label = _U('chair2'),			model = 'prop_off_chair_05'},
					{label = 'كرسي الرئاسة',				model = 'prop_sol_chair'},
					{label = _U('checkpoint'),		model = 'prop_air_sechut_01'},
					{label = _U('cctv_tvs'),		model = 'prop_cctv_unit_04'},
					{label = _U('cctv_pole1'),		model = 'prop_cctv_pole_02'},
					{label = _U('cctv_pole2'),		model = 'prop_cctv_pole_03'},
					{label = 'قوس كبير',				model = 'prop_inflatearch_01'},
					{label = 'مخروط كبير',				model = 'prop_inflategate_01'},
					{label = 'بوابة سباق',				model = 'prop_start_gate_01'},
					{label = 'علم',					model = 'prop_golfflag'},
					--{label = 'عامود حاجز احمر اسود',			model = 'prop_bollard_01b'},
					{label = 'حاجز ستيل صغير',				model = 'prop_fncsec_04a'},
					{label = 'حاجز ستيل كبير',				model = 'prop_fncsec_03c'},
					{label = 'حاجز ستيل كبير طربال',			model = 'prop_fncsec_03d'},
					{label = 'صبة اسمنت ملونة وسط',			model = 'prop_barier_conc_05c'},
					{label = 'صبة اسمنت ملونة كبير',			model = 'prop_barier_conc_05b'},
					{label = 'صبة اسمنت رفيع وسط',			model = 'prop_barier_conc_01c'},
					{label = 'صبة اسمنت رفيع كبير',			model = 'prop_barier_conc_02c'},
					{label = 'حاجز اكياس رمل',				model = 'prop_conc_sacks_02a'},
					{label = 'حاجز بلاستيك الموانئ',			model = 'prop_barrier_wat_01a'},
					{label = 'كنتينر صغير',				model = 'prop_container_03_ld'},
					{label = 'كنتينر كبير',				model = 'prop_container_ld_d'},
					{label = 'كشك مزارع',				model = 'prop_fruitstand_b'},
					{label = 'كشاف وسط',				model = 'prop_ind_light_04'},
					{label = 'كشاف مع مولد كهرب',			model = 'prop_generator_03b'},
					--{label = 'صراف',					model = 'prop_atm_01'},
					{label = 'مضخة بنزين',				model = 'prop_vintage_pump'},
					{label = 'صرافة 🏧', model = 'prop_atm_01'},
					{label = 'برادة ماء 💧', model = 'prop_watercooler'},
					--{label = 'لابتوب',					model = 'prop_laptop_lester'},
					--{label = 'كاشير',					model = 'prop_till_01'},
					{label = 'مهبط هليكوبتر',					model = 'prop_helipad_01'},
					{label = 'برج اتصالات',					model = 'prop_radiomast01'},
					--{label = 'طقم مشروب',					model = 'prop_champset'},
					--{label = 'براد كولا',					model = 'prop_vend_soda_01'},
					{label = 'استعراض دراجات',				model = 'prop_skate_halfpipe_cr'},
					{label = 'استعراض دراجات 2',				model = 'prop_skate_kickers'},
					{label = 'استعراض دراجات 3',				model = 'prop_skate_spiner'},
					{label = 'استعراض دراجات 4',				model = 'prop_skate_flatramp'},
					{label = 'نقطة نهاية سباق',				model = 'prop_tri_finish_banner'},
					{label = 'نقطة بداية سباق',				model = 'prop_tri_start_banner'},
					{label = 'كاميرا تلفزيون',					model = 'prop_tv_cam_02'},
					{label = 'كرفان جر',					model = 'prop_trailer_01_new'},
					{label = 'مطب تخفيف سرعة احمر - صغير', model = 'stt_prop_track_slowdown'},
					{label = 'مطب تخفيف سرعة احمر - كبير', model = 'stt_prop_track_slowdown_t1'},
					{label = 'مطب تخفيف سرعة احمر - كبير 2', model = 'stt_prop_track_slowdown_t2'},
			}}, function(data2, menu2)
				local playerPed = PlayerPedId()
				local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
				local objectCoords = (coords + forward * 1.0)
				
				ESX.Game.SpawnObject(data2.current.model, objectCoords, function(obj)
					SetEntityHeading(obj, GetEntityHeading(playerPed))
					PlaceObjectOnGroundProperly(obj)
					FreezeEntityPosition(obj, true)
				end)
			end, function(data2, menu2)
				menu2.close()
			end)
		end
	end, function(data, menu)
		menu.close()
	end)
end

getPos = function()
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
  	return x,y,z
end

getCamDirection = function()
	local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
	local pitch = GetGameplayCamRelativePitch()

	local x = -math.sin(heading*math.pi/180.0)
	local y = math.cos(heading*math.pi/180.0)
	local z = math.sin(pitch*math.pi/180.0)

	local len = math.sqrt(x*x+y*y+z*z)
	if len ~= 0 then
	  x = x/len
	  y = y/len
	  z = z/len
	end

	return x,y,z
end

local bulletproof_cooltime = 0

function OpenPersonalMenu()

	local playerPed = PlayerPedId()
	local grade = ESX.PlayerData.job.grade

	local elements = {}
	
	--table.insert(elementsAccessories, {label = _U('bullet_wear'), value = 'bullet_wear'})
	
	--table.insert(elements, {label = _U('mask_remove'), value = 'mask_remove'})
	table.insert(elements, {label = _U('helmet_open_police'), value = 'helmet_open_police'})
	table.insert(elements, {label = _U('helmet_1'), value = 'helmet_1'})
	table.insert(elements, {label = _U('helmet_2'), value = 'helmet_2'})
	table.insert(elements, {label = "كاب الرقابة و التفتيش ⭐‍", value = 'control_helmet'})
	table.insert(elements, {label = _U('helmet_remove'), value = 'helmet_remove'})
	
	if grade >= 1 then
		table.insert(elements, {label = _U('cid_badge'), value = 'cid_badge'})
		table.insert(elements, {label = _U('cid_badge_remove'), value = 'cid_badge_remove'})
	else
		table.insert(elements, {label = _U('cid_badge_unavailable')})
	end
	
	if grade >= 1 then
		table.insert(elements, {label = _U('bullet_wear'), value = 'bullet_wear'})
		table.insert(elements, {label = _U('remove_bullet_wear'), value = 'remove_bullet_wear'})
	else
		table.insert(elements, {label = _U('bullet_wear_unavailable')})
	end
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'personal_menu',
	{
		title    = _U('personal_menu'),
		align    = 'top-left',
		elements = elements
	}, function(data2, menu2)

		if
			data2.current.value == 'control_helmet' or
			data2.current.value == 'cid_badge' or
			data2.current.value == 'cid_badge_remove' or
			data2.current.value == 'mask_remove' or
			data2.current.value == 'helmet_open_police' or
			data2.current.value == 'helmet_1' or
			data2.current.value == 'helmet_2' or
			data2.current.value == 'remove_bullet_wear' or
			data2.current.value == 'helmet_remove'
		then
			setUniform(data2.current.value, playerPed)
		elseif data2.current.value == 'bullet_wear' and bulletproof_cooltime == 0 then
			setUniform(data2.current.value, playerPed)
			Citizen.CreateThread(function()
				bulletproof_cooltime = Config.bulletproof_cooltime
				while bulletproof_cooltime ~= 0 do
					Citizen.Wait(60000)
					bulletproof_cooltime = bulletproof_cooltime -1
				end
			end)
		else
			exports.pNotify:SendNotification({
            text = '<font color=red>عليك الانتظار</font><font color=orange> '..bulletproof_cooltime..'</font> دقيقة</br>لاستخدام مضاد الرصاص',
            type = "alert",
			queue = "killer",
            timeout = 8000,
            layout = "centerLeft",
        })
		end

	end, function(data2, menu2)
		menu2.close()
	end)
end

--[[
RegisterNetEvent('esx_adminjob:godmod_all')
AddEventHandler('esx_adminjob:godmod_all', function(status)
	godmod = status	
	
	Citizen.CreateThread(function()

		if godmod and godmodOFF then
			SetPedCanRagdoll(GetPlayerPed(-1), false)
			while godmod do
				Citizen.Wait(0)
				SetPlayerInvincible(PlayerId(), true)
				SetEntityInvincible(GetPlayerPed(-1), true)
				
				ClearPedBloodDamage(GetPlayerPed(-1))
				ResetPedVisibleDamage(GetPlayerPed(-1))
				ClearPedLastWeaponDamage(GetPlayerPed(-1))
				SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
				SetEntityOnlyDamagedByPlayer(GetPlayerPed(-1), false)
				SetEntityCanBeDamaged(GetPlayerPed(-1), false)
				SetEntityHealth(PlayerPedId(-1), 200)
				
				NetworkRequestControlOfEntity(GetVehiclePedIsIn(-1))
				SetVehicleFixed(GetVehiclePedIsIn(GetPlayerPed(-1), false))
				SetVehicleDirtLevel(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0)
				SetVehicleLights(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				SetVehicleBurnout(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
				Citizen.InvokeNative(0x1FD09E7390A74D54, GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
			end
			godmodOFF = false
		elseif not godmod and not godmodOFF then

			SetPlayerInvincible(PlayerId(), false)
			SetEntityInvincible(GetPlayerPed(-1), false)
			SetPedCanRagdoll(GetPlayerPed(-1), true)
			ClearPedLastWeaponDamage(GetPlayerPed(-1))
			SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
			SetEntityOnlyDamagedByPlayer(GetPlayerPed(-1), true)
			SetEntityCanBeDamaged(GetPlayerPed(-1), true)
			
			godmodOFF = true
		end
	end)
end)

function toggleServerGodmod()
	
	if godmodall then
		ESX.ShowHelpNotification('ﻦﻴﺒﻋﻼﻟﺍ ﻊﻴﻤﺠﻟ godmode ~r~ﻞﻴﻌﻔﺗ ﺀﺎﻐﻟﺇ')
		ESX.ShowNotification('إلغاء تفعيل جود مود لجميع اللاعبين')
		godmodall = false
	else
		ESX.ShowHelpNotification('ﻦﻴﺒﻋﻼﻟﺍ ﻊﻴﻤﺠﻟ godmode ~g~ﻞﻴﻌﻔﺗ')
		ESX.ShowNotification('تفعيل godmode لجميع اللاعبين')
		godmodall = true
	end
	
	TriggerServerEvent('esx_adminjob:toggle_godmod', godmodall)
end
--]]

function Draw3DText(x, y, z, text, newScale)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        local dist = GetDistanceBetweenCoords(GetGameplayCamCoords(), x, y, z, 1)
        local scale = newScale * (1 / dist) * (1 / GetGameplayCamFov()) * 100
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropShadow(0, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

function GetNeareastPlayers()
    local playerPed = PlayerPedId()
    local players_clean = {}
    local playerCoords = GetEntityCoords(playerPed)
    if IsPedInAnyVehicle(playerPed, false) then
        local playersId = tostring(GetPlayerServerId(PlayerId()))
        table.insert(players_clean, {topText = onlinePlayers[playersId], playerId = playersId, coords = playerCoords} )
    else
        local players, _ = GetPlayersInArea(playerCoords, wesam.drawDistance)
        for i = 1, #players, 1 do
            local playerServerId = GetPlayerServerId(players[i])
            local player = GetPlayerFromServerId(playerServerId)
            local ped = GetPlayerPed(player)
            if IsEntityVisible(ped) then
                for x, identifier in pairs(onlinePlayers) do 
                    if x == tostring(playerServerId) then
                        table.insert(players_clean, {topText = identifier:upper(), playerId = playerServerId, coords = GetEntityCoords(ped)})
                    end
                end
            end
        end
    end
   
    return players_clean
end

function GetPlayersInArea(coords, area)
	local players, playersInArea = GetPlayers(), {}
	local coords = vector3(coords.x, coords.y, coords.z)
	for i=1, #players, 1 do
		local target = GetPlayerPed(players[i])
		local targetCoords = GetEntityCoords(target)

		if #(coords - targetCoords) <= area then
			table.insert(playersInArea, players[i])
		end
	end
	return playersInArea
end

function GetPlayers()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        if DoesEntityExist(ped) then
            table.insert(players, player)
        end
    end
    return players
end

TPtoMarker = function()
        local WaypointHandle = GetFirstBlipInfoId(8)

        if DoesBlipExist(WaypointHandle) then
            local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

            for height = 1, 1000 do
                SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

                if foundGround then
                    SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

					break
                end
				Citizen.Wait(10)
            end
			exports['t-notify']:Alert({
				style  =  'success',
				message  =  _U('tp_true')
			})
        else
			exports['t-notify']:Alert({
				style  =  'info',
				message  =  _U('tp_false')
			})
        end
end

function GoVeh()
	local playerPed = PlayerPedId()
	local playerPedPos = GetEntityCoords(playerPed, true)
	local CloseVeh = GetClosestVehicle(GetEntityCoords(playerPed, true), 1000.0, 0, 4)
	local CloseVehPos = GetEntityCoords(CloseVeh, true)
	local CloseAir = GetClosestVehicle(GetEntityCoords(playerPed, true), 1000.0, 0, 10000)
	local CloseAirPos = GetEntityCoords(CloseAir, true)
		exports['t-notify']:Alert({
			style  =  'info',
			message  =  _U('veh_wait'),
			duration = 1200
		})
		Citizen.Wait(1600)
	if (CloseVeh == 0) and (CloseAir == 0) then
		exports['t-notify']:Alert({
			style  =  'error',
			message  =  _U('veh_false')
		})
	elseif (CloseVeh == 0) and (CloseAir ~= 0) then
		if IsVehicleSeatFree(CloseAir, -1) then
			SetPedIntoVehicle(playerPed, CloseAir, -1)
			SetVehicleAlarm(CloseAir, false)
			SetVehicleDoorsLocked(CloseAir, 1)
			SetVehicleNeedsToBeHotwired(CloseAir, false)
			Citizen.Wait(1)
		else
			local driverPed = GetPedInVehicleSeat(CloseAir, -1)
			ClearPedTasksImmediately(driverPed)
			SetEntityAsMissionEntity(driverPed, 1, 1)
			DeleteEntity(driverPed)
			SetPedIntoVehicle(playerPed, CloseAir, -1)
			SetVehicleAlarm(CloseAir, false)
			SetVehicleDoorsLocked(CloseAir, 1)
			SetVehicleNeedsToBeHotwired(CloseAir, false)
			Citizen.Wait(1)
		end
			exports['t-notify']:Alert({
				style  =  'success',
				message  =  _U('veh_true')
			})
	elseif (CloseVeh ~= 0) and (CloseAir == 0) then
		if IsVehicleSeatFree(CloseVeh, -1) then
			SetPedIntoVehicle(playerPed, CloseVeh, -1)
			SetVehicleAlarm(CloseVeh, false)
			SetVehicleDoorsLocked(CloseVeh, 1)
			SetVehicleNeedsToBeHotwired(CloseVeh, false)
			Citizen.Wait(1)
		else
			local driverPed = GetPedInVehicleSeat(CloseVeh, -1)
			ClearPedTasksImmediately(driverPed)
			SetEntityAsMissionEntity(driverPed, 1, 1)
			DeleteEntity(driverPed)
			SetPedIntoVehicle(playerPed, CloseVeh, -1)
			SetVehicleAlarm(CloseVeh, false)
			SetVehicleDoorsLocked(CloseVeh, 1)
			SetVehicleNeedsToBeHotwired(CloseVeh, false)
			Citizen.Wait(1)
		end
			exports['t-notify']:Alert({
				style  =  'success',
				message  =  _U('veh_true')
			})
	elseif (CloseVeh ~= 0) and (CloseAir ~= 0) then
		if Vdist(CloseVehPos.x, CloseVehPos.y, CloseVehPos.z, playerPedPos.x, playerPedPos.y, playerPedPos.z) < Vdist(CloseAirPos.x, CloseAirPos.y, CloseAirPos.z, playerPedPos.x, playerPedPos.y, playerPedPos.z) then
			if IsVehicleSeatFree(CloseVeh, -1) then
				SetPedIntoVehicle(playerPed, CloseVeh, -1)
				SetVehicleAlarm(CloseVeh, false)
				SetVehicleDoorsLocked(CloseVeh, 1)
				SetVehicleNeedsToBeHotwired(CloseVeh, false)
				Citizen.Wait(1)
			else
				local driverPed = GetPedInVehicleSeat(CloseVeh, -1)
				ClearPedTasksImmediately(driverPed)
				SetEntityAsMissionEntity(driverPed, 1, 1)
				DeleteEntity(driverPed)
				SetPedIntoVehicle(playerPed, CloseVeh, -1)
				SetVehicleAlarm(CloseVeh, false)
				SetVehicleDoorsLocked(CloseVeh, 1)
				SetVehicleNeedsToBeHotwired(CloseVeh, false)
				Citizen.Wait(1)
			end
		elseif Vdist(CloseVehPos.x, CloseVehPos.y, CloseVehPos.z, playerPedPos.x, playerPedPos.y, playerPedPos.z) > Vdist(CloseAirPos.x, CloseAirPos.y, CloseAirPos.z, playerPedPos.x, playerPedPos.y, playerPedPos.z) then
			if IsVehicleSeatFree(CloseAir, -1) then
				SetPedIntoVehicle(playerPed, CloseAir, -1)
				SetVehicleAlarm(CloseAir, false)
				SetVehicleDoorsLocked(CloseAir, 1)
				SetVehicleNeedsToBeHotwired(CloseAir, false)
				Citizen.Wait(1)
			else
				local driverPed = GetPedInVehicleSeat(CloseAir, -1)
				ClearPedTasksImmediately(driverPed)
				SetEntityAsMissionEntity(driverPed, 1, 1)
				DeleteEntity(driverPed)
				SetPedIntoVehicle(playerPed, CloseAir, -1)
				SetVehicleAlarm(CloseAir, false)
				SetVehicleDoorsLocked(CloseAir, 1)
				SetVehicleNeedsToBeHotwired(CloseAir, false)
				Citizen.Wait(1)
			end
		end
			exports['t-notify']:Alert({
				style  =  'success',
				message  =  _U('veh_true')
			})
		Citizen.Wait(1)	
	end
end

RegisterNetEvent('esx_jobs:wesam:9ndo8Almtajr_end')
AddEventHandler('esx_jobs:wesam:9ndo8Almtajr_end', function(pr)

	TriggerServerEvent("esx_shops2:setDUBLExp")

end)

RegisterNetEvent('esx_adminjob:freezePlayer')
AddEventHandler('esx_adminjob:freezePlayer', function()
	freeze = not freeze
	local ped = PlayerPedId()
	if freeze == true then
		SetEntityCollision(ped, false)
		FreezeEntityPosition(ped, true)
		SetPlayerInvincible(ped, true)
		ClearPedTasksImmediately(ped, true)
		RequestAnimDict("amb@world_human_jog_standing@female@idle_a")
			while not HasAnimDictLoaded("amb@world_human_jog_standing@female@idle_a") do
				Citizen.Wait(0)
			end
		TaskPlayAnim(ped, "amb@world_human_jog_standing@female@idle_a", "idle_a", -25.0, -8.0, -1, 1, 0, false, false, false)
	else
		SetEntityCollision(ped, true)
		FreezeEntityPosition(ped, false)  
		SetPlayerInvincible(ped, false)
		ClearPedTasksImmediately(ped, false)
	end
end)

RegisterNetEvent('esx_adminjob:revivePlayer')
AddEventHandler('esx_adminjob:revivePlayer', function()
	local ped = PlayerPedId()
	local player = IsPedFatallyInjured(ped)
	if player then
		TriggerEvent('esx_ambulancejob:revive')
	else
		if Config.Tnotify then
			exports['t-notify']:Alert({
				style  =  'error',
				message  = _U('not_dead')
			})
		elseif Config.ESX then
			ESX.ShowNotification(_U('not_dead'), false, false, 0)
		end
	end
end)

RegisterNetEvent('esx_adminjob:killPlayer')
AddEventHandler('esx_adminjob:killPlayer', function()
	local ped = PlayerPedId()
	local player = IsPedDeadOrDying(ped, p1)
	if player then
		if Config.Tnotify then
			exports['t-notify']:Alert({
				style  =  'error',
				message  = _U('not_alive')
			})
		elseif Config.ESX then
			ESX.ShowNotification(_U('not_alive'), false, false, 0)
		end
	else
		SetEntityHealth(ped, 0)
	end
end)

RegisterNetEvent('esx_adminjob:weaponPlayer')
AddEventHandler('esx_adminjob:weaponPlayer', function()
	local ped = PlayerPedId()
	GiveWeaponToPed(ped, Config.Weapon, 84, true, true)
end)

RegisterNetEvent('esx_adminjob:weaponPlayer2')
AddEventHandler('esx_adminjob:weaponPlayer2', function()
	local ped = PlayerPedId()
	GiveWeaponToPed(ped, Config.WeaponPUMPSHOTGUN, 100, true, true)
end)

RegisterNetEvent('esx_adminjob:god')
AddEventHandler('esx_adminjob:god', function()
	PE_god = not PE_god
	local playerPed = PlayerPedId()
	SetEntityInvincible(playerPed, not PE_god, true)
	if PE_god == true then
		exports['t-notify']:Alert({
			style  =  'error',
			message  =  _U('god_false')
		})		
	else
		exports['t-notify']:Alert({
			style  =  'success',
			message  =  _U('god_true')
		})		
	end
end)

RegisterNetEvent("esx_adminjob:coords")
AddEventHandler("esx_adminjob:coords", function(input)
	coords = not coords
	local x = GetEntityCoords(PlayerPedId())
	if coords == true then
		exports['t-notify']:Persist({
			id = '12',
			step = 'start',
			options = {
				style = 'info',
				message = tostring(x),
				title = _U('coords')
			}
		})
		
	else
		exports['t-notify']:Persist({
			id = '12',
			step = 'end'
		})
    end
end)

RegisterNetEvent('esx_adminjob:healPlayer')
AddEventHandler('esx_adminjob:healPlayer', function()
		PE_heal = not PE_heal
		local PE_ped = PlayerPedId()
		if PE_heal == true then
			SetEntityHealth(PE_ped, 200)
			SetPedArmour(PE_ped, 100)
			ClearPedBloodDamage(PE_ped)
        	ResetPedVisibleDamage(PE_ped)
			ClearPedLastWeaponDamage(PE_ped)
			exports['t-notify']:Alert({
				style  =  'success',
				message  =  _U('heal_true')
			})
		elseif PE_heal == false then
			SetEntityHealth(PE_ped, 200)
			SetPedArmour(PE_ped, 0)
			exports['t-notify']:Alert({
				style  =  'warning',
				message  =  _U('heal_false')
			})
		end
end)

RegisterNetEvent('esx_adminjob:repairVehicle')
AddEventHandler('esx_adminjob:repairVehicle', function()
    local ply = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(ply)
    if IsPedInAnyVehicle(ply) then 
        SetVehicleFixed(plyVeh)
        SetVehicleDeformationFixed(plyVeh)
        SetVehicleUndriveable(plyVeh, false)
		SetVehicleEngineOn(plyVeh, true, true)
		exports['t-notify']:Alert({
			style  =  'success',
			message  =  _U('fix_true')
		})
    else
		exports['t-notify']:Alert({
			style  =  'error',
			message  =  _U('fix_false')
		})
    end
end)

RegisterNetEvent("esx_adminjob:clearchat_clientSide")
AddEventHandler("esx_adminjob:clearchat_clientSide", function()
    TriggerEvent('chat:clear', -1)
end)

RegisterNetEvent('esx_adminjob:noclipveh')
AddEventHandler('esx_adminjob:noclipveh',function()
		PE_noclipveh = not PE_noclipveh
		if PE_noclipveh == true then
			if Config.Tnotify then
				exports['t-notify']:Alert({
					style  =  'success',
					message  =  _U('noclip_true')
				})
			elseif Config.ESX then
				ESX.ShowNotification(_U('noclip_true'), false, false, 0)
			end
		else
			if Config.Tnotify then
				exports['t-notify']:Alert({
					style  =  'error',
					message  =  _U('noclip_false')
				})
			elseif Config.ESX then
				ESX.ShowNotification(_U('noclip_false'), false, false, 0)
			end
		end
end)

RegisterNetEvent('esx_adminjob:noclip')
AddEventHandler('esx_adminjob:noclip',function()
		ped = PlayerPedId()
		PE_noclip = not PE_noclip
		if PE_noclip == true then
			RequestAnimDict("swimming@base")
			while not HasAnimDictLoaded("swimming@base") do
				Citizen.Wait(0)
			end
			TaskPlayAnim(ped, "swimming@base", "dive_idle", -25.0, -8.0, -1, 1, 0, false, false, false)
			if Config.Tnotify then
				exports['t-notify']:Alert({
					style  =  'success',
					message  =  _U('noclip_true')
				})
			elseif Config.ESX then
				ESX.ShowNotification(_U('noclip_true'), false, false, 0)
			end
		else
			ClearPedTasks(ped)
			if Config.Tnotify then
				exports['t-notify']:Alert({
					style  =  'error',
					message  =  _U('noclip_false')
				})
			elseif Config.ESX then
				ESX.ShowNotification(_U('noclip_false'), false, false, 0)
			end
		end
end)

RegisterNetEvent('esx_adminjob:invisible')
AddEventHandler('esx_adminjob:invisible', function()
		PE_invisible = not PE_invisible
		local ped = PlayerPedId()
		SetEntityVisible(ped, not PE_invisible, false)
		if PE_invisible == true then
				if Config.Tnotify then
				exports['t-notify']:Alert({
					style  =  'success',
					message  =  _U('inv_true')
				})
			elseif Config.ESX then
				ESX.ShowNotification(_U('inv_true'), false, false, 0)
			end
		else
			if Config.Tnotify then
				exports['t-notify']:Alert({
					style  =  'error',
					message  =  _U('inv_false')
				})
			elseif Config.ESX then
				ESX.ShowNotification(_U('inv_false'), false, false, 0)
			end
		end
end)

function OpenIdentityCardMenu(player)
	ESX.TriggerServerCallback('esx_adminjob:getOtherPlayerData', function(data)
		local elements = {
			{label = _U('name', data.name)},
			{label = _U('job', ('%s - %s'):format(data.job, data.grade))}
		}

		if Config.EnableESXIdentity then
			table.insert(elements, {label = _U('sex', _U(data.sex))})
			table.insert(elements, {label = _U('dob', data.dob)})
			table.insert(elements, {label = _U('height', data.height)})
		end

		if data.drunk then
			table.insert(elements, {label = _U('bac', data.drunk)})
		end

		if data.licenses then
			table.insert(elements, {label = _U('license_label')})

			for i=1, #data.licenses, 1 do
				table.insert(elements, {label = data.licenses[i].label})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
			title    = _U('citizen_interaction'),
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenCriminalRecords(closestPlayer)
    ESX.TriggerServerCallback('esx_qalle_brottsregister:grab', function(crimes)

        local elements = {}

        table.insert(elements, {label = 'اضافة سجل جنائي شرطة', value = 'crime'})
        table.insert(elements, {label = '----= السجلات =----', value = 'spacer'})

        for i=1, #crimes, 1 do
            table.insert(elements, {label = crimes[i].date .. ' - ' .. crimes[i].crime, value = crimes[i].crime, name = crimes[i].name})
        end


        ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'brottsregister',
            {
                title    = 'السجل الجنائي',
				align = 'bottom-right',
                elements = elements
            },
        function(data2, menu2)

            if data2.current.value == 'crime' then
                ESX.UI.Menu.Open(
                    'dialog', GetCurrentResourceName(), 'brottsregister_second',
                    {
                        title = 'التهمة?'
                    },
                function(data3, menu3)
                    local crime = (data3.value)

                    if crime == tonumber(data3.value) then
                        ESX.ShowNotification('حصل خطئ')
                        menu3.close()               
                    else
                        menu2.close()
                        menu3.close()
                        TriggerServerEvent('esx_qalle_brottsregister:add', GetPlayerServerId(closestPlayer), crime)
                        ESX.ShowNotification('تم اضافة التهمة بنجاح')
                        Citizen.Wait(100)
                        OpenCriminalRecords(closestPlayer)
                    end

                end,
            function(data3, menu3)
                menu3.close()
            end)
        else
            ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'remove_confirmation',
                    {
                    title    = 'ازلة?',
                    elements = {
                        {label = 'نعم', value = 'yes'},
                        {label = 'لا', value = 'no'}
                    }
                },
            function(data3, menu3)

                if data3.current.value == 'yes' then
                    menu2.close()
                    menu3.close()
                    TriggerServerEvent('esx_qalle_brottsregister:remove', GetPlayerServerId(closestPlayer), data2.current.value)
                    ESX.ShowNotification('تم إزالة التهمة')
                    Citizen.Wait(100)
                    OpenCriminalRecords(closestPlayer)
                else
                    menu3.close()
                end                         

                end,
            function(data3, menu3)
                menu3.close()
            end)                 
        end

        end,
        function(data2, menu2)
            menu2.close()
        end)

    end, GetPlayerServerId(closestPlayer))
end

function OpenCriminalRecordsr9abh(closestPlayer)
    ESX.TriggerServerCallback('esx_qalle_brottsregister:grabr9abh', function(crimes)

        local elements = {}

        table.insert(elements, {label = 'اضافة سجل رقابة على الشخص', value = 'crime'})
        table.insert(elements, {label = '----= السجلات =----'})

        for i=1, #crimes, 1 do
            table.insert(elements, {label = crimes[i].date .. ' - ' .. crimes[i].crime, value = crimes[i].crime, name = crimes[i].name})
        end


        ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'brottsregister',
            {
                title    = 'السجل الرقابة',
				align = 'bottom-right',
                elements = elements
            },
        function(data2, menu2)

            if data2.current.value == 'crime' then
                ESX.UI.Menu.Open(
                    'dialog', GetCurrentResourceName(), 'brottsregister_second',
                    {
                        title = 'التهمة?'
                    },
                function(data3, menu3)
                    local crime = (data3.value)

                    if crime == tonumber(data3.value) then
                        ESX.ShowNotification('حصل خطئ')
                        menu3.close()               
                    else
                        menu2.close()
                        menu3.close()
                        TriggerServerEvent('esx_qalle_brottsregister:addr9abh', GetPlayerServerId(closestPlayer), crime)
                        ESX.ShowNotification('تم اضافة التهمة بنجاح')
                        Citizen.Wait(100)
                    end

                end,
            function(data3, menu3)
                menu3.close()
            end)
        else
            ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'remove_confirmation',
                    {
                    title    = 'ازلة?',
                    elements = {
                        {label = 'نعم', value = 'yes'},
                        {label = 'لا', value = 'no'}
                    }
                },
            function(data3, menu3)

                if data3.current.value == 'yes' then
                    menu2.close()
                    menu3.close()
                    TriggerServerEvent('esx_qalle_brottsregister:remover9abh', GetPlayerServerId(closestPlayer), data2.current.value)
                    ESX.ShowNotification('تم الزالة!')
                    Citizen.Wait(100)
                else
                    menu3.close()
                end                         

                end,
            function(data3, menu3)
                menu3.close()
            end)                 
        end

        end,
        function(data2, menu2)
            menu2.close()
        end)

    end, GetPlayerServerId(closestPlayer))
end

function OpenCriminalRecordsAgent(closestPlayer) -- سجل حرس الحدود
    ESX.TriggerServerCallback('esx_qalle_brottsregister:grab_agent', function(crimes)

        local elements = {}

        table.insert(elements, {label = 'إضافة سجل حراسات أمنية', value = 'crime'})
        table.insert(elements, {label = '----= السجلات =----', value = 'spacer'})

        for i=1, #crimes, 1 do
            table.insert(elements, {label = crimes[i].date .. ' - ' .. crimes[i].crime, value = crimes[i].crime, name = crimes[i].name})
        end


        ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'brottsregister',
            {
                title    = 'سجل حرس الحدود',
				align = 'bottom-right',
                elements = elements
            },
        function(data2, menu2)

            if data2.current.value == 'crime' then
                ESX.UI.Menu.Open(
                    'dialog', GetCurrentResourceName(), 'brottsregister_second',
                    {
                        title = 'التهمة?'
                    },
                function(data3, menu3)
                    local crime = (data3.value)

                    if crime == tonumber(data3.value) then
                        ESX.ShowNotification('حصل خطئ')
                        menu3.close()               
                    else
                        menu2.close()
                        menu3.close()
                        TriggerServerEvent('esx_qalle_brottsregister:add_agent', GetPlayerServerId(closestPlayer), crime)
                        ESX.ShowNotification('تم إضافة سجل حرس الحدود بنجاح')
                        Citizen.Wait(100)
                        OpenCriminalRecords(closestPlayer)
                    end

                end,
            function(data3, menu3)
                menu3.close()
            end)
        else
            ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'remove_confirmation',
                    {
                    title    = '?هل انت متأكد من إزالة سجل حرس الحدود هاذا',
                    elements = {
                        {label = 'نعم', value = 'yes'},
                        {label = 'لا', value = 'no'}
                    }
                },
            function(data3, menu3)

                if data3.current.value == 'yes' then
                    menu2.close()
                    menu3.close()
                    TriggerServerEvent('esx_qalle_brottsregister:remove_agent', GetPlayerServerId(closestPlayer), data2.current.value)
                    ESX.ShowNotification('تم إزالة التهمة')
                    Citizen.Wait(100)
                    OpenCriminalRecords(closestPlayer)
                else
                    menu3.close()
                end                         

                end,
            function(data3, menu3)
                menu3.close()
            end)                 
        end

        end,
        function(data2, menu2)
            menu2.close()
        end)

    end, GetPlayerServerId(closestPlayer))
end -- إنتهاء سجل حرس الحدود

--Tebex Store Records TebexStore
function OpenCriminalRecords_tebex(closestPlayer) -- سجل المتجر
        ESX.TriggerServerCallback('esx_qalle_brottsregister:grab_TebexStore', function(crimes, ifivem, iname, isteam, idiscord)
		
        local elements = {}
        table.insert(elements, {label = '<font color=gray>[____ بيانات اللاعب ____]</font><font color=#CCCCCC></br>'..ifivem..'</br>'..iname..'</br>'..isteam..'</br>'..idiscord..'</font>', value = 'spacer'})
        --table.insert(elements, {label = '<font color=gray>[____ بياناتك الشخصية صورها في التكت في حال طلب المساعدة  ____]</font><font color=#CCCCCC></br>'..GetPlayerName(PlayerId())..'</br>'..name..'</font>', value = 'spacer'})
        --table.insert(elements, {label = '<font color=gray>[____ بياناتك الشخصية صورها في التكت في حال طلب المساعدة  ____]</font><font color=#CCCCCC></br>'..GetPlayerName(PlayerId())..'</font>', value = 'spacer'})
        table.insert(elements, {label = '<font color=gray>[______ السجل ______]</font>', value = 'spacer'})

        for i=1, #crimes, 1 do
            table.insert(elements, {label = '<font color=gray>'..crimes[i].date .. '</font> - ' .. crimes[i].crime, value = crimes[i].crime, name = crimes[i].name})
        end


        ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'brottsregister_tebex',
            {
                title    = ':::: سجل متجر 707 ستور ::::',
                elements = elements
            },
        function(data2, menu2)
		--[[
        if data2.current.value == 'crime' then
                ESX.UI.Menu.Open(
                    'dialog', GetCurrentResourceName(), 'brottsregister_second',
                    {
                        title = 'اكتب وصف الحالة المطلوب تقيدها في السجل'
                    },
                function(data3, menu3)
                    local crime = (data3.value)

                    if crime == tonumber(data3.value) then
                        ESX.ShowNotification('Action Impossible')
                        menu3.close()               
                    else
                        menu2.close()
                        menu3.close()
                        TriggerServerEvent('esx_qalle_brottsregister:add_TebexStore', GetPlayerServerId(closestPlayer), crime)
                        ESX.ShowNotification('Added to register!')
                        Citizen.Wait(100)
                        OpenCriminalRecords(closestPlayer)
                    end

                end,
            function(data3, menu3)
                menu3.close()
            end)
        else
            ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'remove_confirmation',
                    {
                    title    = 'تأكيد حذف السجل؟',
                    elements = {
                        {label = 'حذف سجل', value = 'yes'},
                        {label = 'رجوع', value = 'no'}
                    }
                },
            function(data3, menu3)

                if data3.current.value == 'yes' then
                    menu2.close()
                    menu3.close()
                    TriggerServerEvent('esx_qalle_brottsregister:remove_TebexStore', GetPlayerServerId(closestPlayer), data2.current.value)
                    ESX.ShowNotification('Removed!')
                    Citizen.Wait(100)
                    OpenCriminalRecords(closestPlayer)
                else
                    menu3.close()
                end                         

                end,
            function(data3, menu3)
                menu3.close()
            end)                 
        end ]]

        end,
        function(data2, menu2)
            menu2.close()
        end)

    end, GetPlayerServerId(closestPlayer))
end --]]

function OpenBodySearchMenu(player)
	ESX.TriggerServerCallback('esx_adminjob:getOtherPlayerData', function(data)
		local elements = {}

		for i=1, #data.accounts, 1 do
			if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
				table.insert(elements, {
					label    = _U('confiscate_dirty', ESX.Math.Round(data.accounts[i].money)),
					value    = 'black_money',
					itemType = 'item_account',
					amount   = data.accounts[i].money
				})

				break
			end
		end

		table.insert(elements, {label = _U('guns_label')})

		for i=1, #data.weapons, 1 do
			table.insert(elements, {
				label    = _U('confiscate_weapon', ESX.GetWeaponLabel(data.weapons[i].name), data.weapons[i].ammo),
				value    = data.weapons[i].name,
				itemType = 'item_weapon',
				amount   = data.weapons[i].ammo
			})
		end

		table.insert(elements, {label = _U('inventory_label')})

		for i=1, #data.inventory, 1 do
			if data.inventory[i].count > 0 then
				table.insert(elements, {
					label    = _U('confiscate_inv', data.inventory[i].label, data.inventory[i].count),
					value    = data.inventory[i].name,
					itemType = 'item_standard',
					amount   = data.inventory[i].count
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'body_search', {
			title    = _U('search'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			if data.current.value then
				TriggerServerEvent('esx_adminjob:confiscatePlayerItem', GetPlayerServerId(player), data.current.itemType, data.current.value, data.current.amount)
				OpenBodySearchMenu(player)
			end
		end, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenBodySearchMenu2(player)
	ESX.TriggerServerCallback('esx_adminjob:getOtherPlayerData', function(data)
		local elements = {}

		for i=1, #data.accounts, 1 do
			if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
				table.insert(elements, {
					label    = _U('confiscate_dirty', ESX.Math.Round(data.accounts[i].money)),
					value    = 'black_money',
					itemType = 'item_account',
					amount   = data.accounts[i].money
				})

				break
			end
		end

		table.insert(elements, {label = _U('guns_label')})

		for i=1, #data.weapons, 1 do
			table.insert(elements, {
				label    = _U('confiscate_weapon', ESX.GetWeaponLabel(data.weapons[i].name), data.weapons[i].ammo),
				value    = data.weapons[i].name,
				itemType = 'item_weapon',
				amount   = data.weapons[i].ammo
			})
		end

		table.insert(elements, {label = _U('inventory_label')})

		for i=1, #data.inventory, 1 do
			if data.inventory[i].count > 0 then
				table.insert(elements, {
					label    = _U('confiscate_inv', data.inventory[i].label, data.inventory[i].count),
					value    = data.inventory[i].name,
					itemType = 'item_standard',
					amount   = data.inventory[i].count
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'body_search', {
			title    = _U('search'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			if data.current.value then
				TriggerServerEvent('esx_adminjob:confiscatePlayerItem', player, data.current.itemType, data.current.value, data.current.amount)
				OpenBodySearchMenu(player)
			end
		end, function(data, menu)
			menu.close()
		end)
	end, player)
end

local societyname = { 
	['police'] = 'society_police',
	['police2'] = 'society_police2',
	['admin'] = 'society_admin',
}

function OpenFineMenu(player)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine', {
		title    = _U('fine'),
		align    = 'top-left',
		elements = {
			{label = _U('traffic_offense'), value = 0},
			{label = _U('minor_offense'),   value = 1},
			{label = _U('average_offense'), value = 2},
			{label = _U('major_offense'),   value = 3},
			{label = _U('control_offense'),   value = 5}
	}}, function(data, menu)
		OpenFineCategoryMenu(player, data.current.value)
	end, function(data, menu)
		menu.close()
	end)
end


function OpenFineCategoryMenu(player, category)
	ESX.TriggerServerCallback('esx_adminjob:getFineList', function(fines)
		local elements = {}

		for k,fine in ipairs(fines) do
			table.insert(elements, {
				label     = ('%s <span style="color:green;">%s</span>'):format(fine.label, _U('armory_item', ESX.Math.GroupDigits(fine.amount))),
				value     = fine.id,
				amount    = fine.amount,
				fineLabel = fine.label
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine_category', {
			title    = _U('fine'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			menu.close()
            
			billPass = 'a82mKba0bma2'
			if Config.EnablePlayerManagement then
				TriggerServerEvent('esx_billing:sendKBill_28vn2', billPass, GetPlayerServerId(player), 'society_admin', _U('fine_total', data.current.fineLabel), data.current.amount)
			else
				TriggerServerEvent('esx_billing:sendKBill_28vn2', billPass, GetPlayerServerId(player), '', _U('fine_total', data.current.fineLabel), data.current.amount)
			end

			ESX.SetTimeout(300, function()
				OpenFineCategoryMenu(player, category)
			end)
		end, function(data, menu)
			menu.close()
		end)
	end, category)
end

function OpenFineCategoryAdminkhearatMenu(player)
	local elements = {}
	local category = 1
	for i = 1, #Config.finesAdmin[category], 1 do
		table.insert(elements, {
			label     = ('%s <span style="color:green;">%s</span>'):format(Config.finesAdmin[category][i].label, _U('armory_item', ESX.Math.GroupDigits(Config.finesAdmin[category][i].amount))),
			almrh    = Config.finesAdmin[category][i].almrh,
			amount    = Config.finesAdmin[category][i].amount,
			fineLabel = Config.finesAdmin[category][i].label,
			ticket = Config.finesAdmin[category][i].ticket,
		})
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine_category', {
		title    = _U('fine'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()
		TriggerServerEvent('esx_billing:sendBillfromAdmin', player, societyname[ESX.PlayerData.job.name], _U('fine_total', data.current.fineLabel), data.current.almrh, data.current.amount, data.current.ticket)
		TriggerServerEvent('esx_billing:sendBilllog', player, societyname[ESX.PlayerData.job.name], _U('fine_total', data.current.fineLabel), data.current.amount, data.current.ticket)

		ESX.SetTimeout(300, function()
			OpenFineCategoryAdminkhearatMenu(player)
		end)
	end, function(data, menu)
		menu.close()
	end)
end
function OpenFineCategoryAdminMenu(player)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'menu_ktabh', {
		title = 'اكتب الغرامة'
	}, function(data14, menu14)
		local what_type_the_admin = tostring(data14.value)
		if what_type_the_admin == nil then
			ESX.ShowNotification(_U('quantity_invalid'))
		else
			menu14.close()
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'km_ram_alghramh', {
				title = 'اكتب سعر الغرامة'
			}, function(data15, menu15)
				local what_type_the_admin_ram = tostring(data15.value)
				if what_type_the_admin_ram == nil then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					menu15.close()
					TriggerServerEvent('esx_billing:sendBillfromAdmin', player, societyname[ESX.PlayerData.job.name], what_type_the_admin, what_type_the_admin, what_type_the_admin_ram, false)
					TriggerServerEvent('esx_billing:sendBilllog', player, societyname[ESX.PlayerData.job.name], what_type_the_admin, what_type_the_admin_ram, false)
				end
			end, function(data15)
				menu15.close()
		end)
		end
	end, function(data14, menu14)
		menu14.close()
	end)
end

function OpenFineCategoryAdminMenuAnthar(player)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'menu_ktabh', {
		title = 'اكتب الانذار'
	}, function(data14, menu14)
		local what_type_the_admin = tostring(data14.value)
		if what_type_the_admin == nil then
			ESX.ShowNotification(_U('quantity_invalid'))
		else
			menu14.close()
			TriggerServerEvent('esx_billing:sendAntharlog', player, societyname[ESX.PlayerData.job.name], what_type_the_admin)
		end
	end, function(data14, menu14)
		menu14.close()
	end)
end

function LookupVehicle()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'lookup_vehicle', {
		title = _U('search_database_title'),
	}, function(data, menu)
		local length = string.len(data.value)
		if not data.value or length < 2 or length > 8 then
			ESX.ShowNotification(_U('search_database_error_invalid'))
		else
			ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(retrivedInfo)
				ESX.TriggerServerCallback('esx_policejob:getRentedVehicleInfos', function(retrivedRentedInfo)
					local elements = {{label = _U('plate', retrivedInfo.plate)}}
					menu.close()

					if not retrivedInfo.owner then
						table.insert(elements, {label = _U('owner_unknown')})
					else
						table.insert(elements, {label = _U('owner', retrivedInfo.owner)})
					end

					if retrivedRentedInfo.owner then
						table.insert(elements, {label = _U('renter', retrivedRentedInfo.owner)})			
					else
						table.insert(elements, {label = _U('not_rented')})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos', {
						title    = _U('vehicle_info'),
						align    = 'top-left',
						elements = elements
					}, nil, function(data2, menu2)
						menu2.close()
					end)
				end, data.value)				
			end, data.value)

		end
	end, function(data, menu)
		menu.close()
	end)
end

function ShowPlayerLicense2(player)
	local elements = {}

	ESX.TriggerServerCallback('esx_adminjob:getOtherPlayerData', function(playerData)
		if playerData.licenses then
			for i=1, #playerData.licenses, 1 do
				if playerData.licenses[i].label and playerData.licenses[i].type then
					table.insert(elements, {
						label = playerData.licenses[i].label,
						type = playerData.licenses[i].type
					})
				end
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_license', {
			title    = _U('license_revoke'),
			align    = 'top-left',
			elements = elements,
		}, function(data, menu)
			ESX.ShowNotification(_U('licence_you_revoked', data.current.label, playerData.name))
			TriggerServerEvent('esx_adminjob:message', GetPlayerServerId(player), _U('license_revoked', data.current.label))

			TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(player), data.current.type)
			
			TriggerServerEvent('license_revokeLog:msg', ('سحب رخص الرقابة و التفتيش'), "***سحب {"..data.current.label.." |"..data.current.type.."}***", " المراقب الذي سحب \n steam `"..GetPlayerName(PlayerId()).."` \n المواطن steam`"..GetPlayerName(player).."`", 15158332) -- justtest1

			ESX.SetTimeout(300, function()
				ShowPlayerLicense(player)
			end)
		end, function(data, menu)
			menu.close()
		end)

	end, player)
end

function ShowPlayerLicense(player)
	local elements = {}

	ESX.TriggerServerCallback('esx_adminjob:getOtherPlayerData', function(playerData)
		if playerData.licenses then
			for i=1, #playerData.licenses, 1 do
				if playerData.licenses[i].label and playerData.licenses[i].type then
					table.insert(elements, {
						label = playerData.licenses[i].label,
						type = playerData.licenses[i].type
					})
				end
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_license', {
			title    = _U('license_revoke'),
			align    = 'top-left',
			elements = elements,
		}, function(data, menu)
			ESX.ShowNotification(_U('licence_you_revoked', data.current.label, playerData.name))
			TriggerServerEvent('esx_adminjob:message', GetPlayerServerId(player), _U('license_revoked', data.current.label))

			TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(player), data.current.type)
			
			TriggerServerEvent('license_revokeLog:msg', ('سحب رخص الرقابة و التفتيش'), "***سحب {"..data.current.label.." |"..data.current.type.."}***", " المراقب الذي سحب \n steam `"..GetPlayerName(PlayerId()).."` \n المواطن steam`"..GetPlayerName(player).."`", 15158332) -- justtest1

			ESX.SetTimeout(300, function()
				ShowPlayerLicense(player)
			end)
		end, function(data, menu)
			menu.close()
		end)

	end, GetPlayerServerId(player))
end

function OpenUnpaidBillsMenu(player)
	local elements = {}

	ESX.TriggerServerCallback('esx_billing:getTargetBills', function(bills)
		for k,bill in ipairs(bills) do
			table.insert(elements, {
				label = ('%s - <span style="color:red;">%s</span>'):format(bill.label, _U('armory_item', ESX.Math.GroupDigits(bill.amount))),
				billId = bill.id
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing', {
			title    = _U('unpaid_bills'),
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenpaidBillslogMenu(player)
	local elements = {}

	ESX.TriggerServerCallback('esx_billing:getTargetBillsLog', function(bills)
		for k,bill in ipairs(bills) do
			table.insert(elements, {
				label = ('%s - <span style="color:red;">%s</span>'):format(bill.label, _U('armory_item', ESX.Math.GroupDigits(bill.amount))),
				billId = bill.id
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billinglog', {
			title    = 'سجل الاعب  في الغرامات',
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, player)
end

function OpenpaidBillsAntharlogMenu(player)
	local elements = {}

	ESX.TriggerServerCallback('esx_billing:getTargetBillsAntharLog', function(bills)
		for k,bill in ipairs(bills) do
			table.insert(elements, {
				label = ('<span style="color:red;">%s</span>'):format(bill.label),
				billId = bill.id
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billingAntharlog', {
			title    = 'سجل الاعب  في الأنذارات',
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, player)
end

function OpenVehicleInfosMenu(vehicleData)
	ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(retrivedInfo)
	    ESX.TriggerServerCallback('esx_policejob:getRentedVehicleInfos', function(retrivedRentedInfo)
		local elements = {{label = _U('plate', retrivedInfo.plate)}}

		if not retrivedInfo.owner then
			table.insert(elements, {label = _U('owner_unknown')})
		else
			table.insert(elements, {label = _U('owner', retrivedInfo.owner)})
		end

		if retrivedRentedInfo.owner then
			table.insert(elements, {label = _U('renter', retrivedRentedInfo.owner)})			
		else
			table.insert(elements, {label = _U('not_rented')})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos', {
			title    = _U('vehicle_info'),
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
		end, vehicleData.plate)
	end, vehicleData.plate)
end

function OpenGetWeaponMenu()
	ESX.TriggerServerCallback('esx_adminjob:getArmoryWeapons', function(weapons)
		local elements = {}

		for i=1, #weapons, 1 do
			if weapons[i].count > 0 then
				table.insert(elements, {
					label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name),
					value = weapons[i].name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_weapon', {
			title    = _U('get_weapon_menu'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			menu.close()

			ESX.TriggerServerCallback('esx_adminjob:removeArmoryWeapon', function()
				OpenGetWeaponMenu()
			end, data.current.value)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutWeaponMenu()
	local elements   = {}
	local playerPed  = PlayerPedId()
	local weaponList = ESX.GetWeaponList()

	for i=1, #weaponList, 1 do
		local weaponHash = GetHashKey(weaponList[i].name)

		if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
			table.insert(elements, {
				label = weaponList[i].label,
				value = weaponList[i].name
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_put_weapon', {
		title    = _U('put_weapon_menu'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()

		ESX.TriggerServerCallback('esx_adminjob:addArmoryWeapon', function()
			OpenPutWeaponMenu()
		end, data.current.value, true)
	end, function(data, menu)
		menu.close()
	end)
end

function OpenBuyWeaponsMenu()
	local elements = {}
	local playerPed = PlayerPedId()

	for k,v in ipairs(Config.AuthorizedWeapons[ESX.PlayerData.job.grade_name]) do
		local weaponNum, weapon = ESX.GetWeapon(v.weapon)
		local components, label = {}
		local hasWeapon = HasPedGotWeapon(playerPed, GetHashKey(v.weapon), false)

		if v.components then
			for i=1, #v.components do
				if v.components[i] then
					local component = weapon.components[i]
					local hasComponent = HasPedGotWeaponComponent(playerPed, GetHashKey(v.weapon), component.hash)

					if hasComponent then
						label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('armory_owned'))
					else
						if v.components[i] > 0 then
							label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('armory_item', ESX.Math.GroupDigits(v.components[i])))
						else
							label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('armory_free'))
						end
					end

					table.insert(components, {
						label = label,
						componentLabel = component.label,
						hash = component.hash,
						name = component.name,
						price = v.components[i],
						hasComponent = hasComponent,
						componentNum = i
					})
				end
			end
		end

		if hasWeapon and v.components then
			label = ('%s: <span style="color:green;">></span>'):format(weapon.label)
		elseif hasWeapon and not v.components then
			label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('armory_owned'))
		else
			if v.price > 0 then
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('armory_item', ESX.Math.GroupDigits(v.price)))
			else
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('armory_free'))
			end
		end

		table.insert(elements, {
			label = label,
			weaponLabel = weapon.label,
			name = weapon.name,
			components = components,
			price = v.price,
			hasWeapon = hasWeapon
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_buy_weapons', {
		title    = _U('armory_weapontitle'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.hasWeapon then
			if #data.current.components > 0 then
				OpenWeaponComponentShop(data.current.components, data.current.name, menu)
			end
		else
			ESX.TriggerServerCallback('esx_adminjob:buyWeapon', function(bought)
				if bought then
					if data.current.price > 0 then
						ESX.ShowNotification(_U('armory_bought', data.current.weaponLabel, ESX.Math.GroupDigits(data.current.price)))
					end

					menu.close()
					OpenBuyWeaponsMenu()
				else
					ESX.ShowNotification(_U('armory_money'))
				end
			end, data.current.name, 1)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenWeaponComponentShop(components, weaponName, parentShop)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_buy_weapons_components', {
		title    = _U('armory_componenttitle'),
		align    = 'top-left',
		elements = components
	}, function(data, menu)
		if data.current.hasComponent then
			ESX.ShowNotification(_U('armory_hascomponent'))
		else
			ESX.TriggerServerCallback('esx_adminjob:buyWeapon', function(bought)
				if bought then
					if data.current.price > 0 then
						ESX.ShowNotification(_U('armory_bought', data.current.componentLabel, ESX.Math.GroupDigits(data.current.price)))
					end

					menu.close()
					parentShop.close()
					OpenBuyWeaponsMenu()
				else
					ESX.ShowNotification(_U('armory_money'))
				end
			end, weaponName, 2, data.current.componentNum)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenGetStocksMenu()
	ESX.TriggerServerCallback('esx_adminjob:getStockItems', function(items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('admin_stock'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if not count then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_adminjob:getStockItem', itemName, count)

					Citizen.Wait(300)
					OpenGetStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutStocksMenu()
	ESX.TriggerServerCallback('esx_adminjob:getPlayerInventory', function(inventory)
		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('inventory'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if not count then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_adminjob:putStockItems', itemName, count)

					Citizen.Wait(300)
					OpenPutStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = _U('phone_admin'),
		number     = 'admin',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoV2luZG93cykiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDFGQTJDRkI0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDFGQTJDRkM0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo0MUZBMkNGOTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo0MUZBMkNGQTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PoW66EYAAAjGSURBVHjapJcLcFTVGcd/u3cfSXaTLEk2j80TCI8ECI9ABCyoiBqhBVQqVG2ppVKBQqUVgUl5OU7HKqNOHUHU0oHamZZWoGkVS6cWAR2JPJuAQBPy2ISEvLN57+v2u2E33e4k6Ngz85+9d++95/zP9/h/39GpqsqiRYsIGz8QZAq28/8PRfC+4HT4fMXFxeiH+GC54NeCbYLLATLpYe/ECx4VnBTsF0wWhM6lXY8VbBE0Ch4IzLcpfDFD2P1TgrdC7nMCZLRxQ9AkiAkQCn77DcH3BC2COoFRkCSIG2JzLwqiQi0RSmCD4JXbmNKh0+kc/X19tLtc9Ll9sk9ZS1yoU71YIk3xsbEx8QaDEc2ttxmaJSKC1ggSKBK8MKwTFQVXRzs3WzpJGjmZgvxcMpMtWIwqsjztvSrlzjYul56jp+46qSmJmMwR+P3+4aZ8TtCprRkk0DvUW7JjmV6lsqoKW/pU1q9YQOE4Nxkx4ladE7zd8ivuVmJQfXZKW5dx5EwPRw4fxNx2g5SUVLw+33AkzoRaQDP9SkFu6OKqz0uF8yaz7vsOL6ycQVLkcSg/BlWNsjuFoKE1knqDSl5aNnmPLmThrE0UvXqQqvJPyMrMGorEHwQfEha57/3P7mXS684GFjy8kreLppPUuBXfyd/ibeoS2kb0mWPANhJdYjb61AxUvx5PdT3+4y+Tb3mTd19ZSebE+VTXVGNQlHAC7w4VhH8TbA36vKq6ilnzlvPSunHw6Trc7XpZ14AyfgYeyz18crGN1Alz6e3qwNNQSv4dZox1h/BW9+O7eIaEsVv41Y4XeHJDG83Nl4mLTwzGhJYtx0PzNTjOB9KMTlc7Nkcem39YAGU7cbeBKVLMPGMVf296nMd2VbBq1wmizHoqqm/wrS1/Zf0+N19YN2PIu1fcIda4Vk66Zx/rVi+jo9eIX9wZGGcFXUMR6BHUa76/2ezioYcXMtpyAl91DSaTfDxlJbtLprHm2ecpObqPuTPzSNV9yKz4a4zJSuLo71/j8Q17ON69EmXiPIlNMe6FoyzOqWPW/MU03Lw5EFcyKghTrNDh7+/vw545mcJcWbTiGKpRdGPMXbx90sGmDaux6sXk+kimjU+BjnMkx3kYP34cXrFuZ+3nrHi6iDMt92JITcPjk3R3naRwZhpuNSqoD93DKaFVU7j2dhcF8+YzNlpErbIBTVh8toVccbaysPB+4pMcuPw25kwSsau7BIlmHpy3guaOPtISYyi/UkaJM5Lpc5agq5Xkcl6gIHkmqaMn0dtylcjIyPThCNyhaXyfR2W0I1our0v6qBii07ih5rDtGSOxNVdk1y4R2SR8jR/g7hQD9l1jUeY/WLJB5m39AlZN4GZyIQ1fFJNsEgt0duBIc5GRkcZF53mNwIzhXPDgQPoZIkiMkbTxtstDMVnmFA4cOsbz2/aKjSQjev4Mp9ZAg+hIpFhB3EH5Yal16+X+Kq3dGfxkzRY+KauBjBzREvGN0kNCTARu94AejBLMHorAQ7cEQMGs2cXvkwesamYLDi6e9l728O8P1XW6hKeB2yv42q18tjj+iFTGoSi+X9jJM9RTxS9E+OHT0krhNiZqlbqraoT7RAU5bBGrEknEBhgJks7KXbLS8qERI0ErVqF/Y4K6NHZfLZB+/wzJvncacvFd91oXO3o/O40MfZKJOKu/rne+mRQByXM4lYreb1tUnkizVVA/0SpfpbWaCNBeEE5gb/UH19NLqEgDF+oNDQWcn41Cj0EXFEWqzkOIyYekslFkThsvMxpIyE2hIc6lXGZ6cPyK7Nnk5OipixRdxgUESAYmhq68VsGgy5CYKCUAJTg0+izApXne3CJFmUTwg4L3FProFxU+6krqmXu3MskkhSD2av41jLdzlnfFrSdCZxyqfMnppN6ZUa7pwt0h3fiK9DCt4IO9e7YqisvI7VYgmNv7mhBKKD/9psNi5dOMv5ZjukjsLdr0ffWsyTi6eSlfcA+dmiVyOXs+/sHNZu3M6PdxzgVO9GmDSHsSNqmTz/R6y6Xxqma4fwaS5Mn85n1ZE0Vl3CHBER3lUNEhiURpPJRFdTOcVnpUJnPIhR7cZXfoH5UYc5+E4RzRH3sfSnl9m2dSMjE+Tz9msse+o5dr7UwcQ5T3HwlWUkNuzG3dKFSTbsNs7m/Y8vExOlC29UWkMJlAxKoRQMR3IC7x85zOn6fHS50+U/2Untx2R1voinu5no+DQmz7yPXmMKZnsu0wrm0Oe3YhOVHdm8A09dBQYhTv4T7C+xUPrZh8Qn2MMr4qcDSRfoirWgKAvtgOpv1JI8Zi77X15G7L+fxeOUOiUFxZiULD5fSlNzNM62W+k1yq5gjajGX/ZHvOIyxd+Fkj+P092rWP/si0Qr7VisMaEWuCiYonXFwbAUTWWPYLV245NITnGkUXnpI9butLJn2y6iba+hlp7C09qBcvoN7FYL9mhxo1/y/LoEXK8Pv6qIC8WbBY/xr9YlPLf9dZT+OqKTUwfmDBm/GOw7ws4FWpuUP2gJEZvKqmocuXPZuWYJMzKuSsH+SNwh3bo0p6hao6HeEqwYEZ2M6aKWd3PwTCy7du/D0F1DsmzE6/WGLr5LsDF4LggnYBacCOboQLHQ3FFfR58SR+HCR1iQH8ukhA5s5o5AYZMwUqOp74nl8xvRHDlRTsnxYpJsUjtsceHt2C8Fm0MPJrphTkZvBc4It9RKLOFx91Pf0Igu0k7W2MmkOewS2QYJUJVWVz9VNbXUVVwkyuAmKTFJayrDo/4Jwe/CT0aGYTrWVYEeUfsgXssMRcpyenraQJa0VX9O3ZU+Ma1fax4xGxUsUVFkOUbcama1hf+7+LmA9juHwesamwmwOE1iMmCFYEzg1jtIm1BaxW6wCGGoFdewPfvyE4ertTiv4rHC73B855dwp2a23bbd4tC1hvhOCbX7b4VyUQKhxrtSOaYKngasizvwi0RmOS4O1QZf2yYfiaR+73AvhTQEVf+rpn9/8IMAChKDrDzfsdIQAAAABJRU5ErkJggg=='
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

-- don't show dispatches if the player isn't in service
AddEventHandler('esx_phone:cancelMessage', function(dispatchNumber)
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'admin' and ESX.PlayerData.job.name == dispatchNumber then
		-- if esx_service is enabled
		if Config.EnableESXService and not playerInService then
			CancelEvent()
		end
	end
end)

AddEventHandler('esx_adminjob:hasEnteredMarker', function(station, part, partNum)
	if part == 'Cloakroom' then
		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	elseif part == 'Armory' then
		CurrentAction     = 'menu_armory'
		CurrentActionMsg  = _U('open_armory')
		CurrentActionData = {station = station}
	elseif part == 'Vehicles' then
		CurrentAction     = 'menu_vehicle_spawner'
		CurrentActionMsg  = _U('garage_prompt')
		CurrentActionData = {station = station, part = part, partNum = partNum}
	elseif part == 'Helicopters' then
		CurrentAction     = 'Helicopters'
		CurrentActionMsg  = _U('helicopter_prompt')
		CurrentActionData = {station = station, part = part, partNum = partNum}
	elseif part == 'BossActions' then
		CurrentAction     = 'menu_boss_actions'
		CurrentActionMsg  = _U('open_bossmenu')
		CurrentActionData = {}
	end
end)

AddEventHandler('esx_adminjob:hasExitedMarker', function(station, part, partNum)
	if not isInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

AddEventHandler('esx_adminjob:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'admin' and IsPedOnFoot(playerPed) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('remove_prop')
		CurrentActionData = {entity = entity}
	end

	if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed)

			for i=0, 7, 1 do
				SetVehicleTyreBurst(vehicle, i, true, 1000)
			end
		end
	end
end)

AddEventHandler('esx_adminjob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)


RegisterNetEvent('esx_adminjob:handcuff')
AddEventHandler('esx_adminjob:handcuff', function()
	isHandcuffed = not isHandcuffed
	local playerPed = PlayerPedId()

	if isHandcuffed then
		RequestAnimDict('mp_arresting')
		while not HasAnimDictLoaded('mp_arresting') do
			Citizen.Wait(100)
		end

		TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

		SetEnableHandcuffs(playerPed, true)
		DisablePlayerFiring(playerPed, true)
		SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
		SetPedCanPlayGestureAnims(playerPed, false)
		FreezeEntityPosition(playerPed, true)
		DisplayRadar(false)

		if Config.EnableHandcuffTimer then
			if handcuffTimer.active then
				ESX.ClearTimeout(handcuffTimer.task)
			end

			StartHandcuffTimer()
		end
	else
		if Config.EnableHandcuffTimer and handcuffTimer.active then
			ESX.ClearTimeout(handcuffTimer.task)
		end

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)
	end
end)

--]]

RegisterNetEvent('esx_adminjob:handcuff')
AddEventHandler('esx_adminjob:handcuff', function()
	isHandcuffed = not isHandcuffed
	local playerPed = PlayerPedId()

	if isHandcuffed then
		RequestAnimDict('mp_arresting')
		while not HasAnimDictLoaded('mp_arresting') do
			Citizen.Wait(100)
		end

		TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

		SetEnableHandcuffs(playerPed, true)
		DisablePlayerFiring(playerPed, true)
		SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
		SetPedCanPlayGestureAnims(playerPed, false)
		FreezeEntityPosition(playerPed, true)
		DisplayRadar(false)

		if Config.EnableHandcuffTimer then
			if handcuffTimer.active then
				ESX.ClearTimeout(handcuffTimer.task)
			end

			StartHandcuffTimer()
		end
	else
		if Config.EnableHandcuffTimer and handcuffTimer.active then
			ESX.ClearTimeout(handcuffTimer.task)
		end

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)
	end
end)


RegisterNetEvent('esx_adminjob:unrestrain')
AddEventHandler('esx_adminjob:unrestrain', function()
	if isHandcuffed then
		local playerPed = PlayerPedId()
		isHandcuffed = false

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)

		-- end timer
		if Config.EnableHandcuffTimer and handcuffTimer.active then
			ESX.ClearTimeout(handcuffTimer.task)
		end
	end
end)

RegisterNetEvent('esx_adminjob:drag')
AddEventHandler('esx_adminjob:drag', function(copId)
	if isHandcuffed then
		dragStatus.isDragged = not dragStatus.isDragged
		dragStatus.CopId = copId
	end
end)

Citizen.CreateThread(function()
	local wasDragged

	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if isHandcuffed and dragStatus.isDragged then
			local targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))

			if DoesEntityExist(targetPed) and IsPedOnFoot(targetPed) and not IsPedDeadOrDying(targetPed, true) then
				if not wasDragged then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					wasDragged = true
				else
					Citizen.Wait(1000)
				end
			else
				wasDragged = false
				dragStatus.isDragged = false
				DetachEntity(playerPed, true, false)
			end
		elseif wasDragged then
			wasDragged = false
			DetachEntity(playerPed, true, false)
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('esx_adminjob:putInVehicle')
AddEventHandler('esx_adminjob:putInVehicle', function()
	if isHandcuffed then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if IsAnyVehicleNearPoint(coords, 5.0) then
			local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

			if DoesEntityExist(vehicle) then
				local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

				for i=maxSeats - 1, 0, -1 do
					if IsVehicleSeatFree(vehicle, i) then
						freeSeat = i
						break
					end
				end

				if freeSeat then
					TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
					dragStatus.isDragged = false
				end
			end
		end
	end
end)

RegisterNetEvent('esx_adminjob:OutVehicle')
AddEventHandler('esx_adminjob:OutVehicle', function()
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		TaskLeaveVehicle(playerPed, vehicle, 64)
	end
end)

-- Handcuff
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if isHandcuffed then
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 243, true) -- Animations 2
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)
RegisterFontFile('Font')
fontid = RegisterFontId('A9eelsh')
-- Create blips
Citizen.CreateThread(function()
	for k,v in pairs(Config.adminStations) do
		local blip = AddBlipForCoord(v.Blip.Coords)

		SetBlipSprite (blip, v.Blip.Sprite)
		SetBlipDisplay(blip, v.Blip.Display)
		SetBlipScale  (blip, v.Blip.Scale)
		SetBlipColour (blip, v.Blip.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('<FONT FACE="A9eelsh">ﻢﻴﻈﻨﺘﻟﺍ و ﻖﻴﻘﺤﺘﻟﺍ ﺔﺌﻴﻫ')
		EndTextCommandSetBlipName(blip)
	end
end)

-- Draw markers and more
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'admin' then
			local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed)
			local isInMarker, hasExited, letSleep = false, false, true
			local currentStation, currentPart, currentPartNum

			for k,v in pairs(Config.adminStations) do
				for i=1, #v.Cloakrooms, 1 do
					local distance = #(playerCoords - v.Cloakrooms[i])

					if distance < Config.DrawDistance then
						DrawMarker(Config.MarkerType.Cloakrooms, v.Cloakrooms[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false

						if distance < Config.MarkerSize.x then
							isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Cloakroom', i
						end
					end
				end

				for i=1, #v.Armories, 1 do
					local distance = #(playerCoords - v.Armories[i])

					if distance < Config.DrawDistance then
						DrawMarker(Config.MarkerType.Armories, v.Armories[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false

						if distance < Config.MarkerSize.x then
							isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Armory', i
						end
					end
				end

				for i=1, #v.Vehicles, 1 do
					local distance = #(playerCoords - v.Vehicles[i].Spawner)

					if distance < Config.DrawDistance then
						DrawMarker(Config.MarkerType.Vehicles, v.Vehicles[i].Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false

						if distance < Config.MarkerSize.x then
							isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Vehicles', i
						end
					end
				end

				for i=1, #v.Helicopters, 1 do
					local distance =  #(playerCoords - v.Helicopters[i].Spawner)

					if distance < Config.DrawDistance then
						DrawMarker(Config.MarkerType.Helicopters, v.Helicopters[i].Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false

						if distance < Config.MarkerSize.x then
							isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Helicopters', i
						end
					end
				end

				if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'high_admin' then
					for i=1, #v.BossActions, 1 do
						local distance = #(playerCoords - v.BossActions[i])

						if distance < Config.DrawDistance then
							DrawMarker(Config.MarkerType.BossActions, v.BossActions[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
							letSleep = false

							if distance < Config.MarkerSize.x then
								isInMarker, currentStation, currentPart, currentPartNum = true, k, 'BossActions', i
							end
						end
					end
				end
			end

			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
				if
					(LastStation and LastPart and LastPartNum) and
					(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('esx_adminjob:hasExitedMarker', LastStation, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				TriggerEvent('esx_adminjob:hasEnteredMarker', currentStation, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_adminjob:hasExitedMarker', LastStation, LastPart, LastPartNum)
			end

			if letSleep then
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Enter / Exit entity zone events
Citizen.CreateThread(function()
	local trackedEntities = {
		'prop_barrier_wat_03b',
		'prop_mp_barrier_02b',
		'prop_bollard_02a',
		'prop_fnclink_04a',
		'prop_barier_conc_05c',
		'prop_barier_conc_02a',
		'prop_air_sechut_01',
		'prop_parasol_05',
		'prop_barier_conc_05b',
		'prop_barrier_wat_01a',
		'prop_worklight_03b',
		'prop_worklight_01a',
		'prop_generator_03b',
		'prop_helipad_01',
		'prop_fncsec_03d',
		'prop_mb_sandblock_01',
		'prop_fncsec_03b',
		'prop_off_chair_01',
		'prop_trailer_01_new',
		'stt_prop_track_slowdown_t2',
		'prop_vintage_pump', -- (-462817101) مضخة بنزين
		'stt_prop_track_slowdown',
		'v_ilev_chair02_ped',
		'prop_atm_01', -- الصرافة
		'prop_watercooler', -- برادة الماء
		'prop_watercooler_dark', -- برادة الماء 2
		'prop_mp_barrier_01b',
		'prop_ld_binbag_01', --سرير الاسعاف
		'prop_roadcone02a',
		'prop_barrier_work05',
		'prop_mp_arrow_barrier_01',
		'p_ld_stinger_s',
		'prop_air_lights_02a',
		'prop_air_lights_02b',
		'prop_air_lights_03a',
		'prop_worklight_01a',
		'prop_boxpile_07d',
		'hei_prop_cash_crate_half_full',
		'prop_cctv_pole_02',
		'prop_bbq_1',
		'prop_doghouse_01',
		'prop_gazebo_02',
		'prop_parasol_01_b',
		'prop_ven_market_table1',
		'prop_table_03_chr',
		'prop_off_chair_05',
		'prop_air_sechut_01',
		'prop_sol_chair',
		'prop_cctv_unit_04',
		'prop_cctv_pole_02',
		'prop_cctv_pole_03',
		'prop_mp_barrier_01',
		'prop_inflatearch_01',
		'prop_inflategate_01',
		'prop_start_gate_01',
		'prop_golfflag',
		--'prop_bollard_01b',
		'prop_fncsec_04a',
		'prop_fncsec_03c',
		'prop_fncsec_03d',
		'prop_barier_conc_05c',
		'prop_barier_conc_05b',
		'prop_barier_conc_01c',
		'prop_barier_conc_02c',
		'prop_conc_sacks_02a',
		'prop_barrier_wat_01a',
		'prop_container_03_ld',
		'prop_container_ld_d',
		'prop_fruitstand_b',
		'prop_ind_light_04',
		'prop_generator_03b',
		--'prop_atm_01',
		'prop_vintage_pump',
		--'prop_laptop_lester',
		--'prop_till_01',
		'prop_helipad_01',
		'prop_radiomast01',
		--'prop_champset',
		--'prop_vend_soda_01',
		'prop_skate_halfpipe_cr',
		'prop_skate_kickers',
		'prop_skate_spiner',
		'prop_skate_flatramp',
		'prop_tri_finish_banner',
		'prop_tri_start_banner',
		'prop_tv_cam_02',
		'prop_trailer_01_new',
		'stt_prop_track_slowdown_t1',
		'stt_prop_track_slowdown_t2',
	}

	while true do
		Citizen.Wait(500)

		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)

		local closestDistance = -1
		local closestEntity   = nil

		for i=1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(playerCoords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

			if DoesEntityExist(object) then
				local objCoords = GetEntityCoords(object)
				local distance = #(playerCoords - objCoords)

				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestEntity   = object
				end
			end
		end

		if closestDistance ~= -1 and closestDistance <= 3.0 then
			if LastEntity ~= closestEntity then
				TriggerEvent('esx_adminjob:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
			end
		else
			if LastEntity then
				TriggerEvent('esx_adminjob:hasExitedEntityZone', LastEntity)
				LastEntity = nil
			end
		end
	end
end)

--------------
--extas menu--
--------------
function OpenVehicleExtrasMenu()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    local availableExtras = {}

    if not DoesEntityExist(vehicle) then
	    ESX.ShowNotification("أنت لست في مركبة")
        return
    end

    for i=0, 12 do
        if DoesExtraExist(vehicle, i) then
            local state = IsVehicleExtraTurnedOn(vehicle, i) == 1
            table.insert(availableExtras, {
                label = ('اكسسوار <span style="color:darkgoldenrod;">%s</span>: %s'):format(i, GetExtraLabel(state)),
                state = state,
                extraId = i
            })
        end
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_extras', {
        title    = 'اكسسوارات السيارة',
        align    = 'top-left',
        elements = availableExtras
    }, function(data, menu)
        ToggleVehicleExtra(vehicle, data.current.extraId, data.current.state)

        menu.close()
        OpenVehicleExtrasMenu()
    end, function(data, menu)
        menu.close()
    end)
end

function ToggleVehicleExtra(vehicle, extraId, extraState)
    SetVehicleExtra(vehicle, extraId, extraState)
end

function GetExtraLabel(state)
    if state then
        return '<span style="color:green;">مفعل</span>'
    elseif not state then
        return '<span style="color:darkred;">غير مفعل</span>'
    end
end

--------------------
--END--extras menu--
--------------------

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'admin' then
				if CurrentAction == 'menu_cloakroom' then
					OpenCloakroomMenu()
				elseif CurrentAction == 'menu_armory' then
						OpenArmoryMenu(CurrentActionData.station)
				elseif CurrentAction == 'menu_vehicle_spawner' then
						OpenVehicleSpawnerMenu('car', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
				elseif CurrentAction == 'Helicopters' then
						OpenVehicleSpawnerMenu('helicopter', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
				elseif CurrentAction == 'delete_vehicle' then
					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
					--[[
				elseif CurrentAction == 'menu_boss_actions' then
					ESX.UI.Menu.CloseAll()
					TriggerEvent('esx_society:openBossMenu', 'admin', function(data, menu)
						menu.close()

						CurrentAction     = 'menu_boss_actions'
						CurrentActionMsg  = _U('open_bossmenu')
						CurrentActionData = {}
					end, { wash = true }) -- disable washing money
				--elseif CurrentAction == 'remove_entity' then
					--DeleteEntity(CurrentActionData.entity)
				--end --]]

				CurrentAction = nil
			end
		end -- CurrentAction end
		
		--if IsControlJustReleased(0, 58) and not isDead and ESX.PlayerData.job and ESX.PlayerData.job.name == 'admin' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'admin_actions') then
          if IsControlJustReleased(0, 58) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'admin' then
		  
				if CurrentAction == 'menu_boss_actions' then
					ESX.UI.Menu.CloseAll()
					TriggerEvent('esx_society:openBossMenu', 'admin', function(data, menu)
						menu.close()

						CurrentAction     = 'menu_boss_actions'
						CurrentActionMsg  = _U('open_bossmenu')
						CurrentActionData = {}
					end, { wash = true }) -- disable washing money
				elseif CurrentAction == 'remove_entity' then
					DeleteEntity(CurrentActionData.entity)
				end

				CurrentAction = nil
			end
		end -- CurrentAction end
		if IsControlJustReleased(0, 167) and not isDead and ESX.PlayerData.job and ESX.PlayerData.job.name == 'admin' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'admin_actions') then
			OpenadminActionsMenu()
		end
		if IsControlJustReleased(0, 38) and currentTask.busy then
			ESX.ShowNotification(_U('impound_canceled'))
			ESX.ClearTimeout(currentTask.task)
			ClearPedTasks(PlayerPedId())

			currentTask.busy = false
		end
	end
end)

local player_id_af = nil
RegisterNetEvent('esx_adminjob:givePlayerMenuAfterJoin')
AddEventHandler('esx_adminjob:givePlayerMenuAfterJoin', function()
	ESX.TriggerServerCallback('getPlayerId:esx', function(player_idd_what)
		player_id_af = player_idd_what
		ESX.TriggerServerCallback('esx_policejob:checkJail', function(status_what_in_jail)
			if not status_what_in_jail then
				ESX.TriggerServerCallback('esx_misc:TpAutoMaticAfterJoin', function(status_after_send)
					if status_after_send.check_status_tp_automatic then
						TriggerServerEvent("esx_misc:GiveTeleportMenu", player_id_af)
					end
				end)
			else
				local acaca = nil
			end
		end)
	end, ESX.PlayerData.identifier)
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
	TriggerEvent('esx_adminjob:unrestrain')

	if not hasAlreadyJoined then
		TriggerServerEvent('esx_adminjob:spawned')
	end
	hasAlreadyJoined = true
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_adminjob:unrestrain')
		TriggerEvent('esx_phone:removeSpecialContact', 'admin')

		if Config.EnableESXService then
			TriggerServerEvent('esx_service:disableService', 'admin')
		end

		if Config.EnableHandcuffTimer and handcuffTimer.active then
			ESX.ClearTimeout(handcuffTimer.task)
		end
	end
end)

-- handcuff timer, unrestrain the player after an certain amount of time
function StartHandcuffTimer()
	if Config.EnableHandcuffTimer and handcuffTimer.active then
		ESX.ClearTimeout(handcuffTimer.task)
	end

	handcuffTimer.active = true

	handcuffTimer.task = ESX.SetTimeout(Config.HandcuffTimer, function()
		ESX.ShowNotification(_U('unrestrained_timer'))
		TriggerEvent('esx_adminjob:unrestrain')
		handcuffTimer.active = false
	end)
end

RegisterCommand('sendcoords', function()
    local playerCoords 	= GetEntityCoords(PlayerPedId())
	local heading = GetEntityHeading(PlayerPedId())
	if ESX.PlayerData.job.name == 'admin' then
    TriggerServerEvent('esx_adminjob:sendcoordsToDiscord', playerCoords, heading)
	end
end, false)

-- TODO
--   - return to garage if owned
--   - message owner that his vehicle has been impounded
function ImpoundVehicle(vehicle)
	--local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
	--ESX.Game.DeleteVehicle(vehicle)
	ESX.ShowNotification(_U('impound_successful'))
	currentTask.busy = false
end

function RespawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)

	TriggerServerEvent('esx:onPlayerSpawn')
	TriggerEvent('esx:onPlayerSpawn')
	TriggerEvent('playerSpawned') -- compatibility with old scripts, will be removed soon
end