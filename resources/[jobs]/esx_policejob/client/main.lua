local CurrentActionData, handcuffTimer, dragStatus, blipsCops, currentTask = {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker, isDead, isHandcuffed, hasAlreadyJoined = false, false, false, false
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg
dragStatus.isDragged, isInShopMenu = false, false
ESX = nil
local is_shown = false
local countergetgps = 0
local in_open_menu = false
local isBusyRevivePolice = false
local isOnDuty = false
local is_player_in_dfa3_3am = {}
local _disableAllControlActions = false
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

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

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

function AccsMenu(job, grade)
	local elements2 = {}
	if job == 'police' then
		if grade >= 7 then
		table.insert(elements2, {label = '<font color=#808080>درع</font><font color=#0066CC> الأمن العام</font><font color=#FFFFFF> - </font><font color=#808080>1</font>', value = 'bullet_amn3am_5'})
		table.insert(elements2, {label = '<font color=#808080>درع</font><font color=#0066CC> مكافحة المخدرات</font><font color=#FFFFFF> - </font><font color=#808080>2</font>', value = 'bullet_amn3am_4'})
	    end
		if grade == 2 or grade == 3 or grade == 4 or grade == 5 or grade == 6 then
		table.insert(elements2, {label = '<font color=#808080>درع</font><font color=#0066CC> الأمن العام</font><font color=#FFFFFF> - </font><font color=#808080>2</font>', value = 'bullet_amn3am_2'})
		end
		table.insert(elements2, {label = '<font color=#66FF66>إزالة أكسسوارات الشرطة</font>', value = 'remove_anyting'})
		if grade >= 7 then
			table.insert(elements2, {label = '<font color=#66FF66>حزام</font>', value = 'bullet_frd'})
		end
		if grade >= 7 then
			table.insert(elements2, {label = '<font color=#FF0000>حماية الرأس</font>', value = 'helmet_open_police'})
		end
		if grade >= 7 then
			table.insert(elements2, {label = '<font color=#808080>بريهه اسود ( شامل )</font>', value = 'helmet_1_shaml'})
			table.insert(elements2, {label = '<font color=#FF0000>بريهه حمراء ( شامل )</font>', value = 'helmet_2_shaml'})
		end
		if grade >= 7 then
			table.insert(elements2, {label = '<font color=#808080>ازالة غطاء الرأس</font>', value = 'helmet_remove'})
		end
		if grade >= 7 then
			table.insert(elements2, {label = 'سلاح على قدم واحده', value = 'weapon_one_in_rgl'})
			table.insert(elements2, {label = 'سلاحين على القدمين', value = 'weapon_two_in_rgl'})
		end
		if grade >= 7 then
			table.insert(elements2, {label = _U('cid_badge'), value = 'cid_badge'})
			table.insert(elements2, {label = _U('cid_badge_remove'), value = 'cid_badge_remove'})
		end
	end
	ESX.UI.Menu.Open( 'default', GetCurrentResourceName(), 'cloakroom_accs', {
		title    = '<font color=ef6c00>قائمة الإكسسوارات',
		align = 'top-left', 
		elements = elements2
	}, function(data2, menu2)
		if data2.current.value == 'bullet_amn3am' then
			setUniform("bullet_amn3am", PlayerPedId())
			AddArmourToPed(PlayerPedId(), 100)
			SetPedArmour(PlayerPedId(), 100)
		elseif data2.current.value == "weapon_one_in_rgl" then
			setUniform("weapon_one_in_rgl", PlayerPedId())
		elseif data2.current.value == "weapon_two_in_rgl" then
			setUniform("weapon_two_in_rgl", PlayerPedId())
		elseif data2.current.value == "cap_refe" then
			setUniform("cap_refe", PlayerPedId())
		elseif data2.current.value == 'bullet_amn3am_2' then
			setUniform("bullet_amn3am_2", PlayerPedId())
			AddArmourToPed(PlayerPedId(), 100)
			SetPedArmour(PlayerPedId(), 100)
		elseif data2.current.value == 'bullet_amn3am_3' then
			setUniform("bullet_amn3am_3", PlayerPedId())
			AddArmourToPed(PlayerPedId(), 100)
			SetPedArmour(PlayerPedId(), 100)
		elseif data2.current.value == 'bullet_amn3am_4' then
			setUniform("bullet_amn3am_4", PlayerPedId())
			AddArmourToPed(PlayerPedId(), 100)
			SetPedArmour(PlayerPedId(), 100)
		elseif data2.current.value == 'bullet_amn3am_5' then
			setUniform("bullet_amn3am_5", PlayerPedId())
			AddArmourToPed(PlayerPedId(), 100)
			SetPedArmour(PlayerPedId(), 100)
		elseif data2.current.value == 'bullet_amn3am_6' then
			setUniform("bullet_amn3am_6", PlayerPedId())
			AddArmourToPed(PlayerPedId(), 100)
			SetPedArmour(PlayerPedId(), 100)
		elseif data2.current.value == "bullet_swat" then
			setUniform("bullet_swat", PlayerPedId())
			AddArmourToPed(PlayerPedId(), 100)
			SetPedArmour(PlayerPedId(), 100)
		elseif data2.current.value == "remove_anyting" then
			setUniform("remove_bullet_wear", PlayerPedId())
			AddArmourToPed(PlayerPedId(), 0)
			SetPedArmour(PlayerPedId(), 0)
		else
			setUniform(data2.current.value, PlayerPedId())
		end
	end, function(data2, menu2) 
		menu2.close()
	end)
end

function setUniform2(uniform, playerPed, type)
	TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject

		if skin.sex == 0 then -- male
			if type == 'agent' then
				uniformObject = { ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
				['torso_1'] = 213,   ['torso_2'] = Config.Uniform[uniform].agent.m.torso_2,
				['decals_1'] = Config.Uniform[uniform].agent.m.decals_1,   ['decals_2'] = Config.Uniform[uniform].agent.m.decals_2,
				['arms'] = 41,
				['pants_1'] = 4,   ['pants_2'] = 3,
				['shoes_1'] = Config.Uniform[uniform].agent.m.shoes_1,   ['shoes_2'] = 0,
				['helmet_1'] = 106,  ['helmet_2'] = 1,
				['chain_1'] = 0,    ['chain_2'] = 0,
				['glasses_1'] = 0, 	['glasses_2'] = 0,
				['ears_1'] = -1,     ['ears_2'] = 0,
				['bproof_1'] = 0,  	['bproof_2'] = 0,
				['chain_1'] = 0,    ['chain_2'] = 0 }
			elseif type == "police_save_drugs_clothes" then
				if uniform == 0 then
					uniformObject = { ['tshirt_1'] = 90,  ['tshirt_2'] = 0,
					['torso_1'] = 111,   ['torso_2'] = 3,
					['decals_1'] = 0,   ['decals_2'] = 0,
					['arms'] = 31,
					['pants_1'] = 34,   ['pants_2'] = 0,
					['shoes_1'] = 25,   ['shoes_2'] = 0,
					['helmet_1'] = -1,  ['helmet_2'] = 1,
					['chain_1'] = 0,    ['chain_2'] = 0,
					['glasses_1'] = 0, 	['glasses_2'] = 0,
					['ears_1'] = -1,     ['ears_2'] = 0,
					['bproof_1'] = 1,  	['bproof_2'] = 0,
					['chain_1'] = 0,    ['chain_2'] = 0 }
				else
					uniformObject = { ['tshirt_1'] = 90,  ['tshirt_2'] = 0,
					['torso_1'] = 111,   ['torso_2'] = 3,
					['decals_1'] = 0,   ['decals_2'] = 0,
					['arms'] = 31,
					['pants_1'] = 34,   ['pants_2'] = 0,
					['shoes_1'] = 25,   ['shoes_2'] = 0,
					['helmet_1'] = -1,  ['helmet_2'] = 1,
					['chain_1'] = 0,    ['chain_2'] = 0,
					['glasses_1'] = 0, 	['glasses_2'] = 0,
					['ears_1'] = -1,     ['ears_2'] = 0,
					['bproof_1'] = 1,  	['bproof_2'] = 0,
					['chain_1'] = 0,    ['chain_2'] = 0 }
				end
			elseif type == "b7th_police_jnay" then
				if uniform == 0 then
					uniformObject = { ['tshirt_1'] = 90,  ['tshirt_2'] = 0,
					['torso_1'] = 111,   ['torso_2'] = 3,
					['decals_1'] = 0,   ['decals_2'] = 0,
					['arms'] = 31,
					['pants_1'] = 33,   ['pants_2'] = 0,
					['shoes_1'] = 25,   ['shoes_2'] = 0,
					['helmet_1'] = -1,  ['helmet_2'] = 1,
					['chain_1'] = 0,    ['chain_2'] = 0,
					['glasses_1'] = 0, 	['glasses_2'] = 0,
					['ears_1'] = -1,     ['ears_2'] = 0,
					['bproof_1'] = 1,  	['bproof_2'] = 2,
					['chain_1'] = 0,    ['chain_2'] = 0 }
				else
					uniformObject = { ['tshirt_1'] = 90,  ['tshirt_2'] = 0,
					['torso_1'] = 111,   ['torso_2'] = 3,
					['decals_1'] = 0,   ['decals_2'] = 0,
					['arms'] = 31,
					['pants_1'] = 33,   ['pants_2'] = 0,
					['shoes_1'] = 25,   ['shoes_2'] = 0,
					['helmet_1'] = -1,  ['helmet_2'] = 1,
					['chain_1'] = 0,    ['chain_2'] = 0,
					['glasses_1'] = 0, 	['glasses_2'] = 0,
					['ears_1'] = -1,     ['ears_2'] = 0,
					['bproof_1'] = 1,  	['bproof_2'] = 2,
					['chain_1'] = 0,    ['chain_2'] = 0 }
				end
			elseif type == 'Police' then
				if uniform > 18 then
					uniformObject = { ['tshirt_1'] = 93,  ['tshirt_2'] = 0,
					['torso_1'] = 190,   ['torso_2'] = Config.Uniform[uniform].Police.m.torso_2,
					['decals_1'] = 0,   ['decals_2'] = 0,
					['arms'] = 30,
					['pants_1'] = 4,   ['pants_2'] = 0,
					['shoes_1'] = Config.Uniform[uniform].Police.m.shoes_1,   ['shoes_2'] = 0,
					['helmet_1'] = 106,  ['helmet_2'] = 1,
					['chain_1'] = 0,    ['chain_2'] = 0,
					['glasses_1'] = 0, 	['glasses_2'] = 0,
					['ears_1'] = -1,     ['ears_2'] = 0,
					['bproof_1'] = 0,  	['bproof_2'] = 0,
					['chain_1'] = 0,    ['chain_2'] = 0 }
				else
					uniformObject = { ['tshirt_1'] = 93,  ['tshirt_2'] = 0,
					['torso_1'] = 208,   ['torso_2'] = Config.Uniform[uniform].Police.m.torso_2,
					['decals_1'] = Config.Uniform[uniform].Police.m.decals_1,   ['decals_2'] = Config.Uniform[uniform].Police.m.decals_2,
					['arms'] = 30,
					['pants_1'] = 4,   ['pants_2'] = 0,
					['shoes_1'] = Config.Uniform[uniform].Police.m.shoes_1,   ['shoes_2'] = 0,
					['helmet_1'] = 106,  ['helmet_2'] = 1,
					['chain_1'] = 0,    ['chain_2'] = 0,
					['glasses_1'] = 0, 	['glasses_2'] = 0,
					['ears_1'] = -1,     ['ears_2'] = 0,
					['bproof_1'] = 0,  	['bproof_2'] = 0,
					['chain_1'] = 0,    ['chain_2'] = 0 }
				end
			elseif type == 'refe' then
				uniformObject = { ['tshirt_1'] = 93,  ['tshirt_2'] = 0,
				['torso_1'] = Config.Uniform[uniform].refe.m.torso_1,   ['torso_2'] = Config.Uniform[uniform].refe.m.torso_2,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 30,
				['pants_1'] = 4,   ['pants_2'] = 2,
				['shoes_1'] = 15,   ['shoes_2'] = 0,
				['helmet_1'] = 106,  ['helmet_2'] = 1,
				['chain_1'] = 0,    ['chain_2'] = 0,
				['glasses_1'] = 0, 	['glasses_2'] = 0,
				['ears_1'] = -1,     ['ears_2'] = 0,
				['decals_1'] = Config.Uniform[uniform].refe.m.decals_1,  	['decals_2'] = Config.Uniform[uniform].refe.m.decals_2,
				['chain_1'] = 0,    ['chain_2'] = 0 }
			elseif type == 'mrowr' then
				if uniform > 18 then
				uniformObject = { ['tshirt_1'] = 93,  ['tshirt_2'] = 0,
				['torso_1'] = 225,   ['torso_2'] = Config.Uniform[uniform].mrowr.m.torso_2,
				['decals_1'] = Config.Uniform[uniform].mrowr.m.decals_1,   ['decals_2'] = Config.Uniform[uniform].mrowr.m.decals_2,
				['arms'] = 30,
				['pants_1'] = 4,   ['pants_2'] = 1,
				['shoes_1'] = 25,   ['shoes_2'] = 0,
				['helmet_1'] = 106,  ['helmet_2'] = 1,
				['chain_1'] = 0,    ['chain_2'] = 0,
				['glasses_1'] = 0, 	['glasses_2'] = 0,
				['ears_1'] = -1,     ['ears_2'] = 0,
				['bproof_1'] = 0,  	['bproof_2'] = 0,
				['chain_1'] = 0,    ['chain_2'] = 0 }
				else 
					uniformObject = { ['tshirt_1'] = 93,  ['tshirt_2'] = 0,
					['torso_1'] = 208,   ['torso_2'] = Config.Uniform[uniform].mrowr.m.torso_2,
					['decals_1'] = Config.Uniform[uniform].mrowr.m.decals_1,   ['decals_2'] = Config.Uniform[uniform].mrowr.m.decals_2,
					['arms'] = 30,
					['pants_1'] = 4,   ['pants_2'] = 1,
					['shoes_1'] = 25,   ['shoes_2'] = 0,
					['helmet_1'] = 106,  ['helmet_2'] = 1,
					['chain_1'] = 0,    ['chain_2'] = 0,
					['glasses_1'] = 0, 	['glasses_2'] = 0,
					['ears_1'] = -1,     ['ears_2'] = 0,
					['bproof_1'] = 0,  	['bproof_2'] = 0,
					['chain_1'] = 0,    ['chain_2'] = 0 }
				end	
			elseif type == 'swat' then
				uniformObject = { ['tshirt_1'] = 93,  ['tshirt_2'] = 0,
				['torso_1'] = 209,   ['torso_2'] = Config.Uniform[uniform].swat.m.torso_2,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 31,
				['pants_1'] = 35,   ['pants_2'] = 0,
				['shoes_1'] = Config.Uniform[uniform].swat.m.shoes_1,   ['shoes_2'] = 0,
				['helmet_1'] = 29,  ['helmet_2'] = 0,
				['chain_1'] = 0,    ['chain_2'] = 0,
				['glasses_1'] = 0, 	['glasses_2'] = 0,
				['ears_1'] = -1,     ['ears_2'] = 0,
				['bproof_1'] = 0,  	['bproof_2'] = 0,
				['chain_1'] = 0,    ['chain_2'] = 0 }
			elseif type == 'tdryb' then
				uniformObject = { ['tshirt_1'] = 93,  ['tshirt_2'] = 0,
				['torso_1'] = 97,   ['torso_2'] = Config.Uniform[uniform].tdryb.m.torso_2,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 41,
				['pants_1'] = 34,   ['pants_2'] = 0,
				['shoes_1'] = Config.Uniform[uniform].tdryb.m.shoes_1,   ['shoes_2'] = 0,
				['helmet_1'] = 29,  ['helmet_2'] = 0,
				['chain_1'] = 0,    ['chain_2'] = 0,
				['glasses_1'] = 0, 	['glasses_2'] = 0,
				['ears_1'] = -1,     ['ears_2'] = 0,
				['bproof_1'] = 0,  	['bproof_2'] = 0,
				['chain_1'] = 0,    ['chain_2'] = 0 }
			elseif type == 'amn1' then
				uniformObject = { ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
				['torso_1'] = Config.Uniform[uniform].amn1.m.torso_1,   ['torso_2'] = Config.Uniform[uniform].amn1.m.torso_2,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 52,
				['pants_1'] = 4,   ['pants_2'] = 5,
				['shoes_1'] = 24,   ['shoes_2'] = 0,
				['helmet_1'] = 107,  ['helmet_2'] = 1,
				['chain_1'] = 0,    ['chain_2'] = 0,
				['glasses_1'] = 0, 	['glasses_2'] = 0,
				['ears_1'] = 0,     ['ears_2'] = 0,
				['bproof_1'] = 0,  	['bproof_2'] = 0,
				['chain_1'] = 0,    ['chain_2'] = 0 }
			elseif type == 'amn3' then
				uniformObject = { ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
				['torso_1'] = Config.Uniform[uniform].amn3.m.torso_1,   ['torso_2'] = Config.Uniform[uniform].amn3.m.torso_2,
				['decals_1'] = Config.Uniform[uniform].amn3.m.decals_1,   ['decals_2'] = Config.Uniform[uniform].amn3.m.decals_2,
				['arms'] = 52,
				['pants_1'] = 4,   ['pants_2'] = 2,
				['shoes_1'] = 24,   ['shoes_2'] = 0,
				['helmet_1'] = 106,  ['helmet_2'] = 0,
				['chain_1'] = 0,    ['chain_2'] = 0,
				['glasses_1'] = 0, 	['glasses_2'] = 0,
				['ears_1'] = 0,     ['ears_2'] = 0,
				['bproof_1'] = 0,  	['bproof_2'] = 0,
				['chain_1'] = 0,    ['chain_2'] = 0 }
			elseif type == 'amn2' then
				uniformObject = { ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
				['torso_1'] = Config.Uniform[uniform].amn2.m.torso_1,  ['torso_2'] = Config.Uniform[uniform].amn2.m.torso_2,
				['decals_1'] = Config.Uniform[uniform].amn2.m.decals_1,   ['decals_2'] = Config.Uniform[uniform].amn2.m.decals_2,
				['arms'] = 31,
				['pants_1'] = 4,   ['pants_2'] = 3,
				['shoes_1'] = 10,   ['shoes_2'] = 0,
				['helmet_1'] = 106,  ['helmet_2'] = 1,
				['chain_1'] = 1,    ['chain_2'] = 1,
				['glasses_1'] = 0, 	['glasses_2'] = 0,
				['ears_1'] = 0,     ['ears_2'] = 0,
				['mask_1'] = 0,    ['mask_2'] = 0,
				['bproof_1'] = 0,  	['bproof_2'] = 0,
				['chain_1'] = 0,    ['chain_2'] = 0 }
			elseif type == 'admin' then
				uniformObject = { ['tshirt_1'] = 15,  ['tshirt_2'] = 0, -- تيشيرت
				['torso_1'] = 118,   ['torso_2'] = 5, --جاكيت
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 17,
				['pants_1'] = 0,   ['pants_2'] = 2,
				['shoes_1'] = 8,   ['shoes_2'] = 1,
				['helmet_1'] = 55,  ['helmet_2'] = 25,
				['chain_1'] = 0,    ['chain_2'] = 0,
				['glasses_1'] = 0, 	['glasses_2'] = 0,
				['ears_1'] = -1,     ['ears_2'] = 0,
				['bproof_1'] = 0,  	['bproof_2'] = 0,
				['chain_1'] = 1,    ['chain_2'] = 0 }
			elseif type == 'admin2' then
				uniformObject = { ['tshirt_1'] = 15,  ['tshirt_2'] = 0, -- تيشيرت
				['torso_1'] = 118,   ['torso_2'] = 8, --جاكيت
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 17,
				['pants_1'] = 0,   ['pants_2'] = 2,
				['shoes_1'] = 8,   ['shoes_2'] = 1,
				['helmet_1'] = 55,  ['helmet_2'] = 25,
				['chain_1'] = 0,    ['chain_2'] = 0,
				['glasses_1'] = 0, 	['glasses_2'] = 0,
				['ears_1'] = -1,     ['ears_2'] = 0,
				['bproof_1'] = 0,  	['bproof_2'] = 0,
				['chain_1'] = 1,    ['chain_2'] = 0 }
			elseif type == 'police_55' then
				uniformObject = { ['tshirt_1'] = uniform,  ['tshirt_2'] = 0 }
			elseif type == 'agent_2' then
				uniformObject = { ['tshirt_1'] = uniform,  ['tshirt_2'] = 0 }
			end
		else
			if type == 'agent' then
				uniformObject = { ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
				['torso_1'] = 218,   ['torso_2'] = Config.Uniform[uniform].agent.f.torso_2,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 1,
				['pants_1'] = 90,   ['pants_2'] = 0,
				--['shoes_1'] = Config.Uniform[uniform].agent.f.shoes_1,   ['shoes_2'] = 0,
				['helmet_1'] = 105,  ['helmet_2'] = Config.Uniform[uniform].agent.f.helmet_2,
				['chain_1'] = 0,    ['chain_2'] = 0,
				['glasses_1'] = 0, 	['glasses_2'] = 0,
				['ears_1'] = -1,     ['ears_2'] = 0,
				['bproof_1'] = 0,  	['bproof_2'] = 0,
				['chain_1'] = 0,    ['chain_2'] = 0 }
			elseif type == 'mrowr' then
				uniformObject = { ['tshirt_1'] = 35,  ['tshirt_2'] = 0,
				['torso_1'] = Config.Uniform[uniform].mrowr.f.torso_1,   ['torso_2'] = Config.Uniform[uniform].mrowr.f.torso_2,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 22,
				['pants_1'] = 3,   ['pants_2'] = 2,
				['shoes_1'] = 24,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 0,    ['chain_2'] = 0,
				['glasses_1'] = -1, 	['glasses_2'] = 0,
				['ears_1'] = -1,     ['ears_2'] = 0,
				['bproof_1'] = 0,  	['bproof_2'] = 0,
				['chain_1'] = 0,    ['chain_2'] = 0 }

			elseif type == 'Police' then
				print(uniform)
				if uniform >= 11 then 
					uniformObject = { ['tshirt_1'] = 35,  ['tshirt_2'] = 0,
					['torso_1'] = 101,   ['torso_2'] = Config.Uniform[uniform].Police.f.torso_2,
					['decals_1'] = 0,   ['decals_2'] = 0,
					['arms'] = 22,
					['pants_1'] = 3,   ['pants_2'] = 0,
					['shoes_1'] = 24,   ['shoes_2'] = 0,
					['helmet_1'] = -1,  ['helmet_2'] = 0,
					['chain_1'] = 0,    ['chain_2'] = 0,
					['glasses_1'] = -1, 	['glasses_2'] = 0,
					['ears_1'] = -1,     ['ears_2'] = 0,
					['bproof_1'] = 0,  	['bproof_2'] = 0,
					['chain_1'] = 0,    ['chain_2'] = 0 }
				else
					uniformObject = { ['tshirt_1'] = 35,  ['tshirt_2'] = 0,
					['torso_1'] = 99,   ['torso_2'] = uniform,
					['decals_1'] = 0,   ['decals_2'] = 0,
					['arms'] = 22,
					['pants_1'] = 3,   ['pants_2'] = 0,
					['shoes_1'] = 24,   ['shoes_2'] = 0,
					['helmet_1'] = -1,  ['helmet_2'] = 0,
					['chain_1'] = 0,    ['chain_2'] = 0,
					['glasses_1'] = -1, 	['glasses_2'] = 0,
					['ears_1'] = -1,     ['ears_2'] = 0,
					['bproof_1'] = 0,  	['bproof_2'] = 0,
					['chain_1'] = 0,    ['chain_2'] = 0 }
				end
			elseif type == 'admin2' then
				uniformObject = {}
			end
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

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlJustReleased(0, 167) and ESX.PlayerData.job and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions') then
			if ESX.PlayerData.job.name == 'police' then
				if not isDead then
					if Config.playerInService then
						if isBusyRevivePolice then
							ESX.ShowNotification('حاليا تجري لديك عمليات انعاش لايمكنك تكرير العملية')
						else
							for k,v in ipairs(is_player_in_dfa3_3am) do
								if v.iden_player == ESX.PlayerData.identifier then
									in_open_menu = true
									break
								end
							end
							if in_open_menu then
								OpenPoliceActionsMenuDFA33AM()
							elseif not in_open_menu then
								OpenPoliceActionsMenu()
							end
						end
					else
						ESX.ShowNotification(_U('service_not'))
					end
				end
			end
		end
	end
end)

RegisterNetEvent('esx_policejob:checkLevelPlayer')
AddEventHandler('esx_ploicejob:checkLevelPlayer', function()
	local mylevel = exports.ESX_SystemXpLevel.ESXP_GetRank()
	return mylevel
end)

function OpenCloakroomMenu()
	local playerPed = PlayerPedId()
	local grade = ESX.PlayerData.job.grade
	local gradelabel = ESX.PlayerData.job.grade_label
	local gradename = ESX.PlayerData.job.grade_name
	local elements = {}
	local elements2 = {}
	local elements3 = {}
	local elements4 = {}
	local elements5 = {}
	local elements6 = {}
	local elements7 = {}
	local is_in_dfa3_3am = nil
	table.insert(elements, {label = _U('citizen_wear'), value = 'citizen_wear'})
	if ESX.PlayerData.job.name == 'police' then
		if gradename == 'ss' or gradename == 'ss' then
			table.insert(elements, {label = '<font color=A0A0A0>إدارة الشرطة - شامل🚔</font>', value = 'amn_mrowr'})
			table.insert(elements2, {label = '<font color=0064D5>ملازم - الأمن العام 👮🏻</font>', uniform = 7, type = 'Police'})
			table.insert(elements4, {label = '<font color=ffea00>ملازم - مرور 🚦</font>', uniform = 7, type = 'mrowr'})
			table.insert(elements2, {label = '<font color=0064D5>ملازم أول - الأمن العام 👮🏻</font>', uniform = 8, type = 'Police'})
			table.insert(elements4, {label = '<font color=ffea00>ملازم أول - مرور 🚦</font>', uniform = 8, type = 'mrowr'})
			table.insert(elements2, {label = '<font color=0064D5>نقيب - الأمن العام 👮🏻</font>', uniform = 9, type = 'Police'})
			table.insert(elements4, {label = '<font color=ffea00>نقيب - مرور 🚦</font>', uniform = 9, type = 'mrowr'})
			table.insert(elements2, {label = '<font color=0064D5>رائد - الأمن العام 👮🏻</font>', uniform = 10, type = 'Police'})
			table.insert(elements4, {label = '<font color=ffea00>رائد - مرور 🚦</font>', uniform = 10, type = 'mrowr'})
			table.insert(elements2, {label = '<font color=0064D5>مقدم - الأمن العام 👮🏻</font>', uniform = 11, type = 'Police'})
			table.insert(elements4, {label = '<font color=ffea00>مقدم - مرور 🚦</font>', uniform = 11, type = 'mrowr'})
			table.insert(elements2, {label = '<font color=0064D5>عقيد - الأمن العام 👮🏻</font>', uniform = 12, type = 'Police'})
			table.insert(elements4, {label = '<font color=ffea00>عقيد - مرور 🚦</font>', uniform = 12, type = 'mrowr'})
			table.insert(elements2, {label = '<font color=0064D5>عميد - الأمن العام 👮🏻</font>', uniform = 13, type = 'Police'})
			table.insert(elements4, {label = '<font color=ffea00>عميد - مرور 🚦</font>', uniform = 13, type = 'mrowr'})
			table.insert(elements2, {label = '<font color=0064D5>لواء - الأمن العام 👮🏻</font>', uniform = 14, type = 'Police'})
			table.insert(elements4, {label = '<font color=ffea00>لواء - مرور 🚦</font>', uniform = 14, type = 'mrowr'})
			table.insert(elements5, {label = '<font color=616161> القوات الخاصة 🚔</font>', uniform = 23, type = 'swat'})
			table.insert(elements6, {label = '<font color=43a047>  امن الطرق ⚡</font>', uniform = 23, type = 'amn1'})
			table.insert(elements6, {label = '<font color=050202>  تدريب ⚡</font>', uniform = 23, type = 'tdryb'})
		else
			table.insert(elements, {label = '<font color=0064D5>'..gradelabel..' - الدوريات الامنية 👮🏻</font>', uniform = grade, type = 'Police'})
		end
			if grade == 0 or grade == 1 or grade == 2 or grade == 3 or grade == 4 or grade == 5 or grade == 6 or grade == 7 or grade == 8 or grade == 9 or grade == 10 or grade == 11 or grade == 12 or grade == 13 or grade == 14 or grade == 15 or grade == 16 or grade == 17 or grade == 18 or grade == 19 or grade == 20 or grade == 21 or grade == 22 or grade >= 23 then
		    table.insert(elements, {label = '<font color=ffea00>'..gradelabel..' - المرور 🚦</font>', uniform = grade, type = 'mrowr'})
		end
		if grade == 7 or grade == 8 or grade == 9 or grade == 10 or grade == 11 or grade == 12 or grade == 13 or grade == 14 or grade == 15 or grade == 16 or grade == 17 or grade == 18 or grade == 19 or grade == 20 or grade == 21 or grade == 22 or grade >= 23 then
			table.insert(elements, {label = '<font color=616161>'..gradelabel..' - الأمن العام - شامل 🚔</font>', uniform = grade, type = 'swat'})
		end

		

		if grade >= 6 then
		table.insert(elements, {label = "<font color=43a047>مكافحة المخدرات</font>", uniform = grade, type = "police_save_drugs_clothes"})
		table.insert(elements, {label = "<font color=red>البحث الجنائي</font>", uniform = grade, type = "b7th_police_jnay"})
		end
	elseif ESX.PlayerData.job.name == 'agent' then
		if gradename == 'bosstwo' or gradename == 'boss' then
			if grade >=7 then
				table.insert(elements, {label = '<font color=558b2f>ملازم - حرس الحدود 💂‍♂️</font>', uniform = 7, type = 'agent'})
			end
		if grade>=8 then
			table.insert(elements, {label = '<font color=558b2f>ملازم أول - حرس الحدود 💂‍♂️</font>', uniform = 8, type = 'agent'})
		end
			if grade>=9 then
			table.insert(elements, {label = '<font color=558b2f>نقيب - حرس الحدود 💂‍♂️</font>', uniform = 9, type = 'agent'})
		end
		if grade>=10 then
			table.insert(elements, {label = '<font color=558b2f>رائد - حرس الحدود 💂‍♂️</font>', uniform = 10, type = 'agent'})
		end
		if grade>=11 then
			table.insert(elements, {label = '<font color=558b2f>مقدم - حرس الحدود 💂‍♂️</font>', uniform = 11, type = 'agent'})
		end
		if grade>=12 then
			table.insert(elements, {label = '<font color=558b2f>عقيد - حرس الحدود 💂‍♂️</font>', uniform = 12, type = 'agent'})
		end
		 if grade>=13 then
			table.insert(elements, {label = '<font color=558b2f>عميد - حرس الحدود 💂‍♂️</font>', uniform = 13, type = 'agent'})
		end
		if grade>=16 then
			table.insert(elements, {label = '<font color=558b2f>لواء - حرس الحدود 💂‍♂️</font>', uniform = 14, type = 'agent'})
		end
		 if grade>=15 then
			table.insert(elements, {label = '<font color=558b2f>نائب قائد - حرس الحدود 💂‍♂️</font>', uniform = 13, type = 'agent'})
		end
		 if grade>=16 then
			table.insert(elements, {label = '<font color=558b2f> قائد - حرس الحدود 💂‍♂️</font>', uniform = 16, type = 'agent'})
		end
		else
			table.insert(elements, {label = '<font color=558b2f>'..gradelabel..' - حرس الحدود 💂‍♂️</font>', uniform = grade, type = 'agent'})
		end

	elseif ESX.PlayerData.job.name == 'admin' then

		if grade >= 1 then

			table.insert(elements, {label = '<font color=fafafa> مراقب </font>', uniform = 0, type = 'admin'})

		end

		table.insert(elements, {label = '<font color=ffeb3b> الدعم الفني </font>', uniform = 0, type = 'admin2'})

	end

	table.insert(elements, {label = '<font color=ef6c00>قائمة الإكسسوارات', value = 'accs'})
	table.insert(elements, {label = 'تسجيل دخول بنفس الملابس', value = 'citizen_wear2inservice'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = '<font color=white>::: <font color=00FF00>غرفة تبديل <font color=white>:::',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		cleanPlayer(playerPed)

		if data.current.value == 'police_clothe' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroo22222m', {
				title    = _U('cloakroom'),
				align    = 'top-left',
				elements = elements2
			}, function(data2, menu2)
				cleanPlayer(playerPed)

				if data2.current.uniform then
					setUniform2(data2.current.uniform, playerPed, data2.current.type, grade)
				end
			end, function(data2, menu2)
				menu2.close()

				CurrentAction     = 'menu_cloakroom'
				CurrentActionMsg  = _U('open_cloackroom')
				CurrentActionData = {}
			end)
		elseif data.current.value == 'police_refe' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroo33333m', {
				title    = _U('cloakroom'),
				align    = 'top-left',
				elements = elements3
			}, function(data2, menu2)
				cleanPlayer(playerPed)

				if data2.current.uniform then
					setUniform2(data2.current.uniform, playerPed, data2.current.type, grade)
				end
			end, function(data2, menu2)
				menu2.close()

				CurrentAction     = 'menu_cloakroom'
				CurrentActionMsg  = _U('open_cloackroom')
				CurrentActionData = {}
			end)
		elseif data.current.value == 'dfa3_3am' then
			for k,v in ipairs(is_player_in_dfa3_3am) do
				if v.iden_player == ESX.PlayerData.identifier then
					is_in_dfa3_3am = true
					ESX.ShowNotification('انت مسجل دخول بالفعل')
					break
				end
			end
			if not is_in_dfa3_3am then
				ESX.ShowNotification('تم تسجيل الدخول')
				table.insert(is_player_in_dfa3_3am, {iden_player = ESX.PlayerData.identifier})
			end
		elseif data.current.value == 'amn_mrowr' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroo44444m', {
				title    = _U('cloakroom'),
				align    = 'top-left',
				elements = elements4
			}, function(data2, menu2)
				cleanPlayer(playerPed)

				if data2.current.uniform then
					setUniform2(data2.current.uniform, playerPed, data2.current.type, grade)
				end
			end, function(data2, menu2)
				menu2.close()

				CurrentAction     = 'menu_cloakroom'
				CurrentActionMsg  = _U('open_cloackroom')
				CurrentActionData = {}
			end)
		elseif data.current.value == 'amn_swat' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroo55555m', {
				title    = _U('cloakroom'),
				align    = 'top-left',
				elements = elements5
			}, function(data2, menu2)
				cleanPlayer(playerPed)

				if data2.current.uniform then
					setUniform2(data2.current.uniform, playerPed, data2.current.type, grade)
				end
			end, function(data2, menu2)
				menu2.close()

				CurrentAction     = 'menu_cloakroom'
				CurrentActionMsg  = _U('open_cloackroom')
				CurrentActionData = {}
			end)
		elseif data.current.value == 'amn1_clothes' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroo66666m', {
				title    = _U('cloakroom'),
				align    = 'top-left',
				elements = elements6
			}, function(data2, menu2)
				cleanPlayer(playerPed)

				if data2.current.uniform then
					setUniform2(data2.current.uniform, playerPed, data2.current.type, grade)
				end
			end, function(data2, menu2)
				menu2.close()

				CurrentAction     = 'menu_cloakroom'
				CurrentActionMsg  = _U('open_cloackroom')
				CurrentActionData = {}
			end)
		elseif data.current.value == 'amn2_clothes' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroo77777m', {
				title    = _U('cloakroom'),
				align    = 'top-left',
				elements = elements7
			}, function(data2, menu2)
				cleanPlayer(playerPed)

				if data2.current.uniform then
					setUniform2(data2.current.uniform, playerPed, data2.current.type, grade)
				end
			end, function(data2, menu2)
				menu2.close()

				CurrentAction     = 'menu_cloakroom'
				CurrentActionMsg  = _U('open_cloackroom')
				CurrentActionData = {}
			end)
		elseif data.current.value == 'citizen_wear' then
			if Config.playerInService then
				for k,v in ipairs(is_player_in_dfa3_3am) do
					if v.iden_player == ESX.PlayerData.identifier then
						is_in_dfa3_3am = false
						table.remove(is_player_in_dfa3_3am, k)
						break
					end
				end
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
				Config.playerInService = false
				ESX.ShowNotification(_U('service_out'))
				TriggerServerEvent('esx_service:disableService', ESX.PlayerData.job.name)
			end
		elseif data.current.value == 'accs' then
			AccsMenu(ESX.PlayerData.job.name, grade)
		end
		if data.current.value ~= 'citizen_wear' and data.current.value ~= 'accs' then
			ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
				if not Config.playerInService then
					Config.playerInService = true
					ESX.ShowNotification(_U('service_in'))
					TriggerServerEvent('esx_policejob:sendToAllPlayersNotficiton', ESX.PlayerData.job.grade_label)
				end
			end, ESX.PlayerData.job.name)
		end

		if data.current.uniform then
			setUniform2(data.current.uniform, playerPed, data.current.type, grade)
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
	if Config.playerInService then
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
	else
		ESX.ShowNotification(_U('service_not'))
	end
end
exports("OpenArmoryMenu",OpenArmoryMenu)
local bulletproof_cooltime = 0

function OpenPersonalMenu()

	local playerPed = PlayerPedId()
	local grade = ESX.PlayerData.job.grade

	local elements = {}
	if grade >= 7 then
		--table.insert(elements, {label = '<font color=#808080>سترة</font><font color=#0066CC> الأمن العام</font><font color=#FFFFFF> - </font><font color=#808080>1</font>', value = 'bullet_amn3am'})
		table.insert(elements, {label = '<font color=#808080>درع</font><font color=#0066CC> الامن العام</font><font color=#FFFFFF> - </font><font color=#808080>1</font>', value = 'bullet_amn3am_5'})
		table.insert(elements, {label = '<font color=#808080>درع</font><font color=#0066CC> مكافحة المخدرات</font><font color=#FFFFFF> - </font><font color=#808080>2</font>', value = 'bullet_amn3am_4'})
		table.insert(elements, {label = '<font color=#808080>درع</font><font color=#0066CC> حرس الحدود</font><font color=#FFFFFF> - </font><font color=#808080>2</font>', value = 'bullet_amn3am_6'})
		--table.insert(elements, {label = '<font color=#808080>سترة</font><font color=#0066CC> دوريات الأمن</font><font color=#FFFFFF> - </font><font color=#808080>3</font>', value = 'bullet_amn3am_3'})
	end
	table.insert(elements, {label = '<font color=#66FF66>إزالة أكسسوارات الشرطة</font>', value = 'remove_anyting'})
	if grade >= 11 then
		table.insert(elements, {label = '<font color=#808080>درع القوات الخاصة</font>', value = 'bullet_swat'})
	end
	table.insert(elements, {label = '<font color=#FFFF33>راديو على الكتف</font>', value = 'bullet_njdh'})
	if grade >= 7 then
		table.insert(elements, {label = '<font color=#66FF66>حزام</font>', value = 'bullet_frd'})
	end
	if grade >= 7 then
		table.insert(elements, {label = '<font color=#FF0000>حماية الرأس</font>', value = 'helmet_open_police'})
	end
	if grade >= 11 then
		table.insert(elements, {label = '<font color=#808080>بريهه اسود</font>', value = 'helmet_1'})
		table.insert(elements, {label = '<font color=#FF0000>بريهه حمراء</font>', value = 'helmet_2'})
	end
	if grade >= 7 then
		table.insert(elements, {label = '<font color=#808080>بريهه اسود ( شامل )</font>', value = 'helmet_1_shaml'})
		table.insert(elements, {label = '<font color=#FF0000>بريهه حمراء ( شامل )</font>', value = 'helmet_2_shaml'})
	end
	if grade >= 7 then
		table.insert(elements, {label = '<font color=#808080>ازالة غطاء الرأس</font>', value = 'helmet_remove'})
	end
	if grade >= 11 then
		table.insert(elements, {label = 'سلاح على قدم واحده', value = 'weapon_one_in_rgl'})
		table.insert(elements, {label = 'سلاحين على القدمين', value = 'weapon_two_in_rgl'})
	end
	if grade >= 7 then
		table.insert(elements, {label = _U('cid_badge'), value = 'cid_badge'})
		table.insert(elements, {label = _U('cid_badge_remove'), value = 'cid_badge_remove'})
	end
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'personal_menu',
	{
		title    = '<font color=ef6c00>القائمة الشخصية',
		align    = 'top-left',
		elements = elements
	}, function(data2, menu2)
		if data2.current.value == 'lol' or data2.current.value == 'sandy2' or data2.current.value == 'fbi0' or data2.current.value == 'fbi1' or data2.current.value == 'fbi2' or data2.current.value == 'agent' or data2.current.value == 'special' or data2.current.value == 'supervisor' or data2.current.value == 'fbi3' or data2.current.value == 'fbi4' or data2.current.value == 'fbi5' or data2.current.value == 'assistant' or data2.current.value == 'sandy0' or data2.current.value == 'sandy02' or data2.current.value == 'bullet_njdh' or data2.current.value == 'bullet_frd' or data2.current.value == 'cid_badge' or data2.current.value == 'cid_badge_remove' or data2.current.value == 'mask_remove' or data2.current.value == 'helmet_open_police' or data2.current.value == 'swat_hel' or data2.current.value == 'helmet_1' or data2.current.value == 'helmet_2' or data2.current.value == 'helmet_remove' or data2.current.value == "helmet_1_shaml" or data2.current.value == "helmet_2_shaml" then
			setUniform(data2.current.value, playerPed)
		elseif data2.current.value == "cap_refe" then
			setUniform("cap_refe", playerPed)
		elseif data2.current.value == 'bullet_amn3am' or data2.current.value == 'bullet_swat' or data2.current.value == "bullet_amn3am_2" or data2.current.value == "bullet_amn3am_3" or data2.current.value == "bullet_amn3am_4" or data2.current.value == "bullet_amn3am_5"or data2.current.value == "bullet_amn3am_6"then
			if Cooldown_count == 0 then
				Cooldown(5)
				setUniform(data2.current.value, playerPed)
				AddArmourToPed(playerPed, 100)
				SetPedArmour(playerPed, 100)
			else
				ESX.ShowNotification('<font color=red>يجب الأنتظار</font>. <font color=orange>'..Cooldown_count..' ثانية')
			end
		elseif data2.current.value == "weapon_one_in_rgl" then
			setUniform("weapon_one_in_rgl", playerPed)
		elseif data2.current.value == "weapon_two_in_rgl" then
			setUniform("weapon_two_in_rgl", playerPed)
		elseif data2.current.value == 'remove_anyting' then
			setUniform("remove_bullet_wear", playerPed)
			AddArmourToPed(playerPed, 0)
			SetPedArmour(playerPed, 0)
		elseif data2.current.value == 'bullet_wear' and bulletproof_cooltime == 0 then
			Citizen.CreateThread(function()
				bulletproof_cooltime = Config.bulletproof_cooltime
				while bulletproof_cooltime ~= 0 do
					Citizen.Wait(60000)
					bulletproof_cooltime = bulletproof_cooltime -1
				end
			end)
		else
		if data2.current.value == 'bullet_wear' then
		--[[
			exports.pNotify:SendNotification({
            text = '<font color=red>عليك الانتظار</font><font color=orange> '..bulletproof_cooltime..'</font> دقيقة</br>لاستخدام مضاد الرصاص',
            type = "alert",
			queue = "killer",
            timeout = 8000,
            layout = "centerLeft",
        })--]]
		ESX.ShowNotification('<font color=red>عليك الانتظار</font><font color=orange> '..bulletproof_cooltime..'</font> دقيقة</br>لاستخدام مضاد الرصاص')
		end
		end

	end, function(data2, menu2)
		menu2.close()
	end)
end

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

function DoActionDFA33AM(item,waitime)
	_disableAllControlActions = true
	Citizen.CreateThread(function()
		while _disableAllControlActions do
			Citizen.Wait(0)
			DisableAllControlActions(0)
		end
	end)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	if IsPedSittingInAnyVehicle(playerPed) then
		ESX.ShowNotification('يجب النزول من المركبة')
		return
	end
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = nil
		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 10.0, 0, 71)	
		if DoesEntityExist(vehicle) then
			if Cooldown_count == 0 then
				Cooldown(60)
				if item == 'fixkit' then
					exports['progressBars']:startUI(waitime, 'تصليح المركبة')
				elseif item == 'carokit' then	
					exports['progressBars']:startUI(waitime, 'سمكرة المركبة')
				end	
				SetVehicleDoorOpen(vehicle, 4, false)
				Citizen.Wait(1500)
				if item == 'fixkit' then
					TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
				elseif item == 'carokit' then	
					TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_HAMMERING', 0, true)
				end	
				Citizen.CreateThread(function()
					Citizen.Wait(waitime-3000)
					SetVehicleFixed(vehicle)
					SetVehicleDeformationFixed(vehicle)
					SetVehicleUndriveable(vehicle, false)
					ClearPedTasksImmediately(playerPed)
					Citizen.Wait(1500)
					SetVehicleDoorShut(vehicle, 4, false)
					_disableAllControlActions = false
				end)
			else
				_disableAllControlActions = false
				ESX.ShowNotification('<font color=red>يجب الأنتظار</font>. <font color=orange>'..Cooldown_count..' ثانية')
			end
		else
			ESX.ShowNotification('لايوجد مركبة قريبة منك')
			_disableAllControlActions = false
		end	
	else
		ESX.ShowNotification('لايوجد مركبة قريبة منك')
		_disableAllControlActions = false
	end		
end

local MeleeD = { -1569615261, 1737195953, 1317494643, -1786099057, 1141786504, -2067956739, -868994466 }
local KnifeD = { -1716189206, 1223143800, -1955384325, -1833087301, 910830060, }
local BulletD = { 453432689, 1593441988, 584646201, -1716589765, 324215364, 736523883, -270015777, -1074790547, -2084633992, -1357824103, -1660422300, 2144741730, 487013001, 2017895192, -494615257, -1654528753, 100416529, 205991906, 1119849093 }
local AnimalD = { -100946242, 148160082 }
local FallDamageD = { -842959696 }
local ExplosionD = { -1568386805, 1305664598, -1312131151, 375527679, 324506233, 1752584910, -1813897027, 741814745, -37975472, 539292904, 341774354, -1090665087 }
local GasD = { -1600701090 }
local BurnD = { 615608432, 883325847, -544306709 }
local DrownD = { -10959621, 1936677264 }
local CarD = { 133987706, -1553120962 }

function checkArrayDeathCause (array, val)
	for name, value in ipairs(array) do
		if value == val then
			return true
		end
	end

	return false
end

function NotificationDeathCause(x,y,z)
	local timestamp = GetGameTimer()
	while (timestamp + 4500) > GetGameTimer() do
		Citizen.Wait(0)
		DrawText3DeathCause(x, y, z, 'ﺔﺑﺎﺻﻹﺍ ﻥﺎﻜﻣ ﺎﻨﻫ ﺮﻫﺎﻈﻟﺍ', 0.4)
		checking = false
	end
end

function OpenDeathMenu(player, ac)
	if ac == 'damage' then
		loadAnimDictDeathCause('amb@medic@standing@kneel@base')
		loadAnimDictDeathCause('anim@gangops@facility@servers@bodysearch@')
		local bone
		local success = GetPedLastDamageBone(player,bone)
		local success,bone = GetPedLastDamageBone(player)
		if success then
			local x,y,z = table.unpack(GetPedBoneCoords(player, bone))
			NotificationDeathCause(x,y,z)
		else
			ESX.ShowNotification('<font color=red>لايمكن التعرف على مكان الإصابة')
		end
	end
	if ac == 'deathcause' then
		local d = GetPedCauseOfDeath(player)		
		local playerPed = PlayerPedId()
		TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
		TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
		Citizen.Wait(5000)		
		ClearPedTasksImmediately(playerPed)
		if checkArrayDeathCause(MeleeD, d) then
			ESX.ShowNotification('احتمال تعرض الشخص لضربة قوية على الرأس')
		elseif checkArrayDeathCause(BulletD, d) then
			ESX.ShowNotification('احتمال اصابة برصاصة, يوجد اثر طلق في الجسم واحتمال الاصابة قاتلة ولا مجال للشفاء')
		elseif checkArrayDeathCause(KnifeD, d) then
			ESX.ShowNotification('يوجد اثر جروح بآلة حادة مثل السكين')
		elseif checkArrayDeathCause(AnimalD, d) then
			ESX.ShowNotification('يوجد اثر عض او جروح بسبب حيوان مفترس')
		elseif checkArrayDeathCause(FallDamageD, d) then
			ESX.ShowNotification('احتمال سقوط من مكان مرتفع, يوجد كسر في الرجل او الرجلين احتمال الشفاء ضعيف جدا')
		elseif checkArrayDeathCause(ExplosionD, d) then
			ESX.ShowNotification('الشخص متوفي بسبب تعرضه لانفجار ولا مجال للشفاء')
		elseif checkArrayDeathCause(GasD, d) then
			ESX.ShowNotification('تعرض الشخص للاختناق بسبب استنشاق غاز سام او غاز خانق')
		elseif checkArrayDeathCause(BurnD, d) then
			ESX.ShowNotification('احتمال اغمى عليه بسبب استنشاق غاز من مطفأة حريق')
		elseif checkArrayDeathCause(DrownD, d) then
			ESX.ShowNotification('تعرض الشخص لحروق خطيرة')
		elseif checkArrayDeathCause(CarD, d) then
			ESX.ShowNotification('تعرض الشخص لحادث مروري')
		else
			ESX.ShowNotification('سبب الإصابة غير واضح')
		end
	end
end

function OpenPoliceActionsMenuDFA33AM()
	local elements = {}
	table.insert(elements, {label = 'قائمة سباون الأشياء', value = 'object_spawner'})
	table.insert(elements, {label = "<span  style='color:#FF0E0E;font-size:15'>جديد<span style='color:gray;'><font color=white> حمل الحالة</span>", value = 'bodydrag'})
	table.insert(elements, {label = '<span style="color:#00FFFF">قائمة الأمن</span>', value = 'menu_police'})
	table.insert(elements, {label = '<font color=red>قائمة الأسعاف</span>', value = 'menu_as3af'})
	table.insert(elements, {label = '<font color=gray>قائمة الميكانيكي</span>', value = 'menu_mechanic'})
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'police_actions', {
		title    = ':::: <span style="color:#FFFF00">قائمة الدفاع العام</span> ::::',
		align    = 'top-left',
		elements = elements
		}, function(data, menu)
			if data.current.value == 'object_spawner' then
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
					title    = '::: قائمة سباون الأشياء :::',
					align    = 'top-left',
					elements = {
						{label = 'مخروط 🛢', model = 'prop_roadcone02a'},
						{label = 'حاجز سهم', model = 'prop_mp_arrow_barrier_01'},
						{label = 'حاجز اسمنتي طويل', model = 'prop_mp_barrier_01b'},
						{label = 'حاجز بلاستيكي صغير', model = 'prop_barrier_wat_03b'},
						{label = 'حاجز اسمنتي احمر صغير', model = 'prop_barier_conc_05c'},
						{label = 'حاجز اسمنتي صغير', model = 'prop_barier_conc_02a'},
						{label = 'کوخ تفتیش', model = 'prop_air_sechut_01'},
						{label = 'حاجز اسمنتي احمر طويل', model = 'prop_barier_conc_05b'},
						{label = 'عمود نور کبیر', model = 'prop_worklight_03b'},
						{label = 'عمود نور', model = 'prop_worklight_01a'},
						{label = 'حاجز مغطي', model = 'prop_fncsec_03d'},
						{label = 'كرسي', model = 'v_ilev_chair02_ped'},
						{label = 'حاجز خشب شرطة 🚧', model = 'prop_barrier_work05'},
						{label =  'فخ شوكي', model = 'p_ld_stinger_s'},
						{label = 'صندوق 📦', model = 'prop_boxpile_07d'},
						{label = 'صندوق فلوس 🛢 ', model = 'hei_prop_cash_crate_half_full'}
				}}, function(data2, menu2)
					local playerPed = PlayerPedId()
					local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
					local objectCoords = (coords + forward * 1.0)
					ESX.Game.SpawnObject(data2.current.model, objectCoords, function(obj)
						SetEntityHeading(obj, GetEntityHeading(playerPed))
						PlaceObjectOnGroundProperly(obj)
					end)
				end, function(data2, menu2)
					menu2.close()
				end)
			elseif data.current.value == 'menu_as3af' then
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_as3af_opened', {
					title    = '::: <font color=red>قائمة الأسعاف</span><font color=white></span> :::',
					align    = 'top-left',
					elements = {
						{label = 'أنعاش لاعب', value = 'revive'},
						{label = 'علاج أصابات خفيفة', value = 'small'},
						{label = 'علاج أصابات خطيرة', value = 'big'},
						{label = 'تحقق من سبب الإصابة', value = 'deathcause'},
						{label = 'تحقق من مكان الإصابة', value = 'damage'}
				}}, function(data2, menu2)
					if data2.current.value == 'revive' then
						local playerPed = PlayerPedId()
						local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
						local objectCoords = (coords + forward * 1.0)
		
						ESX.Game.SpawnObject(data2.current.model, objectCoords, function(obj)
							SetEntityHeading(obj, GetEntityHeading(playerPed))
							PlaceObjectOnGroundProperly(obj)
					end)
					elseif data2.current.value == 'small' then
						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)
								if health > 0 then
									local playerPed = PlayerPedId()
									ESX.ShowNotification('جاري المعالجة')
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)
									TriggerServerEvent('esx_ambulancejob:removeItem', 'bandage')
									TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
									ESX.ShowNotification(_U('لقد عالجت ', GetPlayerName(closestPlayer)))
								else
									ESX.ShowNotification('الشخص ليس فاقد الوعي')
								end
							else
								ESX.ShowNotification('لاتمتلك ضمادة')
							end
						end, 'bandage')
					elseif data2.current.value == 'big' then
						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)
								if health > 0 then
									local playerPed = PlayerPedId()
									ESX.ShowNotification('جاري المعالجة')
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)
									TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
									TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
									ESX.ShowNotification(_U('لقد عالجت ', GetPlayerName(closestPlayer)))
								else
									ESX.ShowNotification('الشخص ليس فاقد الوعي')
								end
							else
								ESX.ShowNotification('لاتمتلك ضمادة')
							end
						end, 'medikit')
					elseif data2.current.value == 'deathcause' then
						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						OpenDeathMenu(GetPlayerPed(closestPlayer), "deathcause")
					elseif data2.current.value == "damage" then
						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						OpenDeathMenu(GetPlayerPed(closestPlayer), "deathcause")
					end
				end, function(data2, menu2)
					menu2.close()
				end)
			elseif data.current.value == 'menu_mechanic' then
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_mechanic', {
					title = '::: <font color=gray>قائمة الميكانيكي</span><font color=white></span> :::',
					align = 'top-left',
					elements = {
						{label = '<font color=C0C0C0>إعطاء فاتورة</font>', value = 'billing'},
						{label = 'كسر قفل المركبة 🔑', value = 'ksr_8fl'},
						{label = '<font color=C0C0C0>تصليح</font>', value = 'fixcar'},
						{label = '<font color=C0C0C0>سمكرة</font>', value = 'smkrhcar'},
						{label = '<font color=C0C0C0>تنظيف</font>', value = 'cleancar'},
						{label = '<font color=C0C0C0>حجز مركبة</font>', value = 'hjzcar'},
					}
				}, function(data1, menu1)
					if data1.current.value == 'billing' then
						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
							title = 'مبلغ الفاتورة',
						}, function(data, menu)
							local amount = tonumber(data.value)
							if amount == nil or amount < 0 then
								ESX.ShowNotification('قيمة خاطئة')
							else
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
								if closestPlayer == -1 or closestDistance > 3.0 then
									ESX.ShowNotification('لايوجد شخص قريب منك')
								else
									menu.close()
									billPass = 'a82mKba0bma2'
									TriggerServerEvent('esx_billing:sendKBill_28vn2', billPass, GetPlayerServerId(closestPlayer), 'society_mechanic', _U('mechanic'), amount)
								end
							end
						end, function(data, menu)
							menu.close()
						end)
					elseif data1.current.value == 'ksr_8fl' then
						if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
							TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
							Citizen.Wait(20000)
							ClearPedTasksImmediately(playerPed)
							SetVehicleDoorsLocked(vehicle, 1)
							SetVehicleDoorsLockedForAllPlayers(vehicle, false)
							ESX.ShowNotification('تم فتح قفل المركبة')
						end
					elseif data1.current.value == 'fixcar' then
						DoActionDFA33AM('fixkit',15000)
					elseif data1.current.value == 'smkrhcar' then
						DoActionDFA33AM('carokit',25000)
					elseif data1.current.value == 'cleancar' then
						local playerPed = PlayerPedId()
						local vehicle   = ESX.Game.GetVehicleInDirection()
						local coords    = GetEntityCoords(playerPed)
						if IsPedSittingInAnyVehicle(playerPed) then
							ESX.ShowNotification('يجب النزول من المركبة')
							return
						end
						if DoesEntityExist(vehicle) then
							TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
							Citizen.CreateThread(function()
								Citizen.Wait(10000)

								SetVehicleDirtLevel(vehicle, 0)
								ClearPedTasksImmediately(playerPed)
							end)
						else
							ESX.ShowNotification('لايوجد مركبة قريبة منك')
						end
					elseif data1.current.value == 'hjzcar' then
						DoActionImpound(10000)
					end
				end, function(data1, menu1)
					menu1.close()
				end)
			elseif data.current.value == 'menu_police' then
				local grade = ESX.PlayerData.job.grade
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_police', {
					title = '::: <span style="color:#00FFFF">قائمة الأمن</span> :::',
					align = 'top-left',
					elements = {
						{label = '<span style="color:#">🧑🏻 التعامل مع الأفراد</span>', value = 'alt3aml_m3_alafrad'},
						{label = '<span style="color:#">🚗 التعامل مع المركبات</span>', value = 'alt3aml_m3_alsearat'},
						{label = '<span style="color:#FF0000">استنفار امني</span>', value = 'astnfar_amny'},
					}
				}, function(data10, menu10)
					if data10.current.value == 'alt3aml_m3_alafrad' then
						local elements = {
							{label = _U('id_card'), value = 'identity_card'},
							{label = _U('search'), value = 'search'},
							{label = _U('handcuff'), value = 'handcuff'},
							{label = _U('drag'), value = 'drag'},
							{label = _U('put_in_vehicle'), value = 'put_in_vehicle'},
							{label = _U('out_the_vehicle'), value = 'out_the_vehicle'},
							{label = '<span style="color:#ff0000">جديد</span>حمل الحالة',			value = 'bodydrag'},
							{label = _U('fine'), value = 'fine'},
							{label = _U('unpaid_bills'), value = 'unpaid_bills'},
							{label = 'السجل الجنائي الشرطة', value = 'criminalrecords'},
							{label = _U('jail_menu'), value = 'jail_menu'},
						}
						if Config.EnableLicenses then
							table.insert(elements, {label = _U('license_check'), value = 'license'})
						end	
						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
							title    = '<span style="color:#">🧑🏻 التعامل مع الأفراد</span>',
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
								elseif action == 'bodydrag' then 
									TriggerServerEvent('icemallow-drag:attach',  GetPlayerServerId(closestPlayer))
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
								elseif action == 'jail_menu' then
									TriggerEvent("esx_jail:openJailMenu")									
								end
							else
								ESX.ShowNotification(_U('no_players_nearby'))
							end
						end, function(data2, menu2)
							menu2.close()
						end)
					elseif data10.current.value == 'alt3aml_m3_alsearat' then
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
							title    = '<span style="color:#">🚗 التعامل مع المركبات</span>',
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
									DoActionImpound(10000)
								end
							else
								ESX.ShowNotification(_U('no_vehicles_nearby'))
							end
						end, function(data2, menu2)
							menu2.close()
						end)
					elseif data10.current.value == 'astnfar_amny' then
						local elements = {
							{label = _U('ports_PB_Menu'),			value = 'ports_PB_Menu'},
							{label = _U('banks_PB_Menu'),			value = 'banks_PB_Menu'},
							{label = _U('public_garage_PB_Menu'),	value = 'public_garage_PB_Menu'},
							{label = _U('Other_PB_Menu'),			value = 'Other_PB_Menu'},
							{label = _U('my_place_PB_Menu'),		value = 'my_place_PB_Menu'},
						}
			
						ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'Panic_Button_Menu',
						{
							title    = _U('Panic_Button_Menu'),
							align    = 'top-left',
							elements = elements
						}, function(data2, menu2)
							local action = data2.current.value
							local label = data2.current.label
							
							--START
							if action == 'ports_PB_Menu' then
							--start ports
								local elements = {
								{label = _U('sea_port'),				value = 'sea_port'},
								{label = _U('seaport_west'),			value = 'seaport_west'},
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
								}, function(data3, menu3)
									local action = data3.current.value
									
									if action == 'sea_port' then
										TriggerServerEvent("esx_misc:TogglePanicButton", 'sea_port')
									elseif action == 'seaport_west' then
										TriggerServerEvent("esx_misc:TogglePanicButton", 'seaport_west')
									elseif action == 'international_airport' then
										TriggerServerEvent("esx_misc:TogglePanicButton", 'international_airport')
									elseif action == 'sandy_airport' then
										TriggerServerEvent("esx_misc:TogglePanicButton", 'sandy_airport')
									elseif action == 'farm_airport' then
										TriggerServerEvent("esx_misc:TogglePanicButton", 'farm_airport')
									end
									
								end, function(data3, menu3)
									menu3.close()
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
								}, function(data3, menu3) --change data menu number
									local action = data3.current.value
									--add if statment to excute
									if action == 'pacific_bank' then
										TriggerServerEvent("esx_misc:TogglePanicButton", 'pacific_bank')
									elseif action == 'paleto_bank' then
										TriggerServerEvent("esx_misc:TogglePanicButton", 'paleto_bank')
									elseif action == 'sandy_bank' then
										TriggerServerEvent("esx_misc:TogglePanicButton", 'sandy_bank')
									end
									
								end, function(data3, menu3) --change data menu number
									menu3.close()
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
								}, function(data3, menu3) --change data menu number
									local action = data3.current.value
									--add if statment to excute
									if action == 'public_car_garage_los_santos' then
										TriggerServerEvent("esx_misc:TogglePanicButton", 'public_car_garage_los_santos')
									elseif action == 'public_car_garage_sandy' then
										TriggerServerEvent("esx_misc:TogglePanicButton", 'public_car_garage_sandy')
									elseif action == 'public_car_garage_paleto' then
										TriggerServerEvent("esx_misc:TogglePanicButton", 'public_car_garage_paleto')
									end
									
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
										--{label = _U('army_base'),					value = 'army_base'},
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
									}, function(data3, menu3) --change data menu number
										local action = data3.current.value
										--add if statment to excute
										if action == 'alshaheed_gardeen' then
											TriggerServerEvent("esx_misc:TogglePanicButton", 'alshaheed_gardeen')
										elseif action == 'army_base' then
											TriggerServerEvent("esx_misc:TogglePanicButton", 'army_base')
										elseif action == 'white_house' then
											TriggerServerEvent("esx_misc:TogglePanicButton", 'white_house')
										elseif action == 'cardealer_new' then
											TriggerServerEvent("esx_misc:TogglePanicButton", 'cardealer_new')
										elseif action == 'aucation_house' then
											TriggerServerEvent("esx_misc:TogglePanicButton", 'aucation_house')	
										end
										
									end, function(data3, menu3) --change data menu number
										menu3.close()
									end)
									--end menu	
							elseif action == 'my_place_PB_Menu' then
								exports["esx_misc"]:TriggerMyLocPanicButton()
							end		
						end, function(data2, menu2)
							menu2.close()
						end)
					end
				end, function(data10, menu10)
					menu10.close()
			end)
			end
		end, function(data, menu)
			menu.close()
	end)
end

RegisterNetEvent('esx_policejob:setCOOLDOWNOnSYSTEM')
AddEventHandler('esx_policejob:setCOOLDOWNOnSYSTEM', function()
	Cooldown(120)
end)

RegisterNetEvent('esx_policejob:getGPSplayerClient')
AddEventHandler('esx_policejob:getGPSplayerClient', function(id_target, job_target, SteamNameTarget, coordstarget)
	local myserverId = GetPlayerServerId(PlayerId())
	if ESX.PlayerData.job ~= nil then
		if ESX.PlayerData.job.name == "police" or ESX.PlayerData.job.name == "agent" then
			if myserverId == id_target then
				ESX.ShowNotification("لايمكنك تحديد موقعك")
			else
				if ESX.PlayerData.job.name == job_target then
					ESX.ShowNotification("لايمكن العثور على موقع احد وهو معك بنفس الوظيفة")
				else
					if not is_shown then
						ESX.ShowNotification("تم تحديد موقع الشخص الأن موجود في الخريطة ب اللون الأحمر")
						is_shown = true
					end
					local cIdtarget = GetPlayerFromServerId(id_target)
					if cIdtarget ~= -1 then
						TriggerServerEvent('esx_polcejob:setDoWithCoords', false)
						local blip = AddBlipForEntity(GetPlayerPed(cIdtarget))
						if IsPedInAnyVehicle(GetPlayerPed(cIdtarget)) then
							SetBlipSprite(blip, 326)
						else
							SetBlipSprite(blip, 1)
						end
						SetBlipDisplay(blip, 2)
						SetBlipScale(blip, 1.0)
						SetBlipColour(blip, 1)
						SetBlipFlashes(blip, false)
						SetBlipShowCone(blip, true)
						SetBlipCategory(blip, 7)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(SteamNameTarget)
						EndTextCommandSetBlipName(blip)
						Citizen.Wait(10000)
						RemoveBlip(blip)
						is_shown = false
					else
						if countergetgps < 10 then
							TriggerServerEvent('esx_polcejob:setDoWithCoords', true)
							local blip = AddBlipForCoord(coordstarget)
							if IsPedInAnyVehicle(GetPlayerPed(cIdtarget)) then
								SetBlipSprite(blip, 326)
							else
								SetBlipSprite(blip, 1)
							end
							SetBlipDisplay(blip, 2)
							SetBlipScale(blip, 1.0)
							SetBlipColour(blip, 1)
							SetBlipFlashes(blip, false)
							SetBlipShowCone(blip, true)
							SetBlipCategory(blip, 7)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString(SteamNameTarget)
							EndTextCommandSetBlipName(blip)
							countergetgps = countergetgps + 1
							Citizen.Wait(1000)
							RemoveBlip(blip)
						else
							TriggerServerEvent('esx_polcejob:setDoWithCoords', false)
							RemoveBlip(blip)
							countergetgps = 0
							is_shown = false
						end
					end
				end
			end
		end
	end
end)
function OpenPoliceActionsMenu()
    local grade = ESX.PlayerData.job.grade
	local add_msafen = false
	local isBusy = false
	ESX.UI.Menu.CloseAll()

	local elements = {
		{label = '<span style="color:#">التعامل مع الأفراد 🧑🏻</span>', value = 'citizen_interaction'},
		{label = '<span style="color:#">التعامل مع المركبات 🚗</span>', value = 'vehicle_interaction'},
		{label = "<span style='color:#CE5200'>قائمة بلاغات اطلاق النار 🔫</span>", value = "menu_shot_fire"},
		{label = "<span style='color:#FF0000'>معلومات الأستنفارات ⚠️</span>", value = "get_info_astnfar"},
		{label = "<font color=green>تغيير المسمى الميداني 🎫</font>", value = "change_name_in_radio"},
		{label = '<span style="color:3399FF">حالة العساكر 👮‍♂️</span>', value = "status_police"}
	}
	table.insert(elements, {label = _U('object_spawner'), value = 'object_spawner'})
	if grade >= 1 then
		table.insert(elements, {label = _U('Panic_Button_Menu'), value = 'Panic_Button_Menu'})
	else
		table.insert(elements, {label = _U('Panic_Button_Menu_unavailable')})
	end	
	
	if grade >= 7 then
		table.insert(elements, {label = '<font color=gold>إدارة موقع التصدير ⚓</font>', value = 'mina'})
	else
		table.insert(elements, {label = '<font color=gray>إدارة موقع التصدير متاح من ملازم</font>'})
	end	
	if grade >= 7 then
		table.insert(elements, {label = _U('personal_menu'), value = 'personal_menu'})
		else
		table.insert(elements, {label = '<font color=gray>القائمة الشخصية متاح من ملازم</font>'})
		end
	
	--[[if grade >= 7 then
		table.insert(elements, {label = _U('lightbarsmenu'), value = 'lightbarsmenu'})
	else
		table.insert(elements, {label = _U('lightbarsmenu_unavailable')})
	end--]]
	
	--[[table.insert(elements, {label = 'تركيب الإيقاف الإجباري', value = 'addgrappler'})
	table.insert(elements, {label = 'نزع الإيقاف الإجباري', value = 'removegrappler'})--]]

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'police_actions', {
		title    = ':::: <span style="color:#0080FF">إدارة الشرطة</span> ::::',
		align    = 'top-left',
		elements = elements
		}, function(data, menu)
		if data.current.value == 'lightbarsmenu' then
        	TriggerEvent("openLightbarMenu")
        end
		if data.current.value == "use_shalied" then
			TriggerEvent("tarcza:useitem")
		end
		if data.current.value == "status_police" then
			ESX.TriggerServerCallback("esx_policejob:getStatusPolice", function(data)
				local elements = {}
				for k,v in pairs(data) do
					table.insert(elements, {label = data[k].label})
				end
				ESX.UI.Menu.Open("default", GetCurrentResourceName(), "status_police", {
					title = '<span style="color:3399FF">حالة العساكر 👮‍♂️</span>',
					align = "top-left",
					elements = elements
				}, function(data, menu)
				end, function(data, menu)
					menu.close()
				end)
			end)
		end
		if data.current.value == "change_name_in_radio" then
			ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "change_name_in_radio_menu", {
				title = "اكتب المسمى الميداني الجديد"
			}, function(data, menu)
				local name_new = data.value
				if name_new == nil or name_new == "" then
					ESX.ShowNotification("رجاء اكتب اي شي")
				else
					menu.close()
					ExecuteCommand("nameinradio " .. name_new)
				end
			end, function(data, menu)
				menu.close()
			end)
		end
		if data.current.value == "get_info_closest_player" then
			local eeee = {}
			local ped222 = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 3.0)
			for k_s,playerNearby_s in ipairs(ped222) do
				ESX.TriggerServerCallback('esx_adminjob:getNameplayer', function(name_player_s)
					table.insert(eeee, {label = name_player_s.name, playerId = name_player_s.id, coords_player = name_player_s.coords_player})
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stretcher_menu3', {
						title		= 'حدد من الشخص',
						align		= 'top-left',
						elements	= eeee
					}, function(data3, menu3)
						menu3.close()
						TriggerEvent("esx_wesam:getInfoPlayerPoliceJob", data3.current.playerId)
					end, function(data3, menu3)
						menu2.close()
				end)
				end, GetPlayerServerId(playerNearby_s))
			end
		end
		if data.current.value == "get_info_astnfar" then
			local elements = {}
			ESX.TriggerServerCallback("esx_wesam:esx_misc:getListAstnfarStateTrue", function(data)
				for k,v in pairs(data) do
					table.insert(elements, {label = "<span style='color:#FF0000'>استنفار</span> رقم <font color=orange>" .. k .. "</font>", value = v})
				end
				ESX.UI.Menu.Open("default", GetCurrentResourceName(), "astnfar_list", {
					title = "قائمة <span style='color:#FF0000'>الأستنفارات</span>",
					align = "top-left",
					elements = elements
				}, function(data, menu)
					local elements2 = {}
					ESX.TriggerServerCallback("esx_wesam:esx_misc:getListPlayerInAstnfar", function(data_2)
						for k,v in pairs(data_2) do
							table.insert(elements2, {label = v.label})
						end
						ESX.UI.Menu.Open("default", GetCurrentResourceName(), "astnfar_list_2", {
							title = "قائمة <span style='color:#FF0000'>الأستنفارات</span>",
							align = "top-left",
							elements = elements2
						}, function(data2, menu2)
						end, function(data2, menu2)
							menu2.close()
						end)
					end, data.current.value)
				end, function(data, menu)
					menu.close()
				end)
			end)
		end
		if data.current.value == "get_my_info_police_job" then
			TriggerEvent("esx_wesam:getInfoPlayerPoliceJob", GetPlayerServerId(PlayerId()))
		end
		if data.current.value == 'addgrappler' then
			ExecuteCommand("grappler install")
		elseif data.current.value == 'removegrappler' then
			ExecuteCommand("grappler remove")
		end
		if data.current.value == "menu_shot_fire" then
			TriggerServerEvent('esx_wesam:goTolistShotFire')
		end
		if data.current.value == "get_players" then
			local players_in_none = false
			local em = {}
			ESX.TriggerServerCallback("esx_adminjob:getPlayerverify", function(players)
				for i=1, #players.data, 1 do
					players_in_none = true
				end
				if not players_in_none then
					table.insert(em, {label = "لايوجد احد متصل من اي وظيفة معتمده"})
				else
					table.insert(em, {label = "<font color=#0080FF>الشرطة</font> <font color=white>:</font> [<font color=#0080FF>" .. players.counter_police .. "</font><font color=white>]</font>"})
					table.insert(em, {label = "<font color=#00FF00>شركة حرس الحدود</font> <font color=white>:</font> [<font color=#00FF00>" .. players.counter_agent .. "</font><font color=white>]</font>"})
					table.insert(em, {label = "<font color=#EB3C3C>الهلال الأحمر</font> <font color=white>:</font> [<font color=#EB3C3C>" .. players.counter_ambulance .. "</font><font color=white>]</font>"})
					table.insert(em, {label = "<font color=#606060>كراج الميكانيك</font> <font color=white>:</font> [<font color=#606060>" .. players.counter_mechanic .. "</font><font color=white>]</font>"})
				end
				ESX.UI.Menu.Open("default", GetCurrentResourceName(), 'wesam_get_player', {
					title = "قائمة موظفين المعتمد",
					align = "top-left",
					elements = em
				}, function(data_get_player, menu_get_player)
					--print()
				end, function(data_get_player, menu_get_player)
					menu_get_player.close()
				end)
			end)
		end
		if data.current.value == "getGPSPlayer" then
			ESX.UI.Menu.Open("default", GetCurrentResourceName(), "choiceGPSplayer", {
				title = "حدد عن طريق ايش تبي تحدد موقع الشخص",
				align = "top-left",
				elements = {
					{label = "تحديد موقع عن طريق رقم جوال", value = "phone_number"},
					{label = "تحديد موقع عن طريق ارقام و احرف لوحة سيارة", value = "plate_car"}
				}
			}, function(data_choice_gps, menu_choice_gps)
				if data_choice_gps.current.value == "phone_number" then
					if Cooldown_count == 0 then
						menu_choice_gps.close()
						ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "getGPSPlayerMENU", {
							title = "اكتب رقم جوال الشخص الي تبي تحدد موقعه"
						}, function(data_get_gps, menu_get_gps)
							if data_get_gps.value == nil then
								ESX.ShowNotification("رجاء اكتب رقم جوال صحيح")
							else
								menu_get_gps.close()
								TriggerServerEvent('esx_polcejob:getGPSplayer', "from_phone_number", data_get_gps.value)
							end
						end, function(data_get_gps, menu_get_gps)
							menu_get_gps.close()
						end)
					else
						ESX.ShowNotification('<font color=red>يجب الأنتظار</font>. <font color=orange>'..Cooldown_count..' ثانية')
					end
				elseif data_choice_gps.current.value == "plate_car" then
					if Cooldown_count == 0 then
						menu_choice_gps.close()
						ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "getGPSPlayerMENUPLATE", {
							title = "اكتب ارقام و احرف لوحة سيارة الشخص الي تبي تحدد موقعه"
						}, function(data_get_gps_plate, menu_get_gps_plate)
							if data_get_gps_plate.value == nil then
								ESX.ShowNotification("رجاء اكتب ارقام و احرف لوحة سيارة صحيحه")
							else
								menu_get_gps_plate.close()
								TriggerServerEvent('esx_polcejob:getGPSplayer', "plate_car", data_get_gps_plate.value)
							end
						end, function(data_get_gps_plate, menu_get_gps_plate)
							menu_get_gps_plate.close()
						end)
					else
						ESX.ShowNotification('<font color=red>يجب الأنتظار</font>. <font color=orange>'..Cooldown_count..' ثانية')
					end
				end
			end, function(data_choice_gps, menu_choice_gps)
				menu_choice_gps.close()
			end)
		end
		if data.current.value == 'citizen_interaction' then
			local elements = {
				{label = _U('id_card'), value = 'identity_card'},
				{label = _U('search'), value = 'search'},
				{label = ('تقييد / فك القيد🔴'), value = 'handcuff'},
				-- {label = _U('unhandcuff'), value = 'unhandcuff'},
				{label = _U('drag'), value = 'drag'},
				{label = _U('put_in_vehicle'), value = 'put_in_vehicle'},
				{label = _U('out_the_vehicle'), value = 'out_the_vehicle'},
				{label = '<span style="color:#ff0000">جديد</span>حمل الحالة',			value = 'bodydrag'},
				{label = _U('fine'), value = 'fine'},
				{label = _U('unpaid_bills'), value = 'unpaid_bills'},
				{label = 'السجل الجنائي الشرطة', value = 'criminalrecords'},
				{label = _U('jail_menu'), value = 'jail_menu'},
			}

			if Config.EnableLicenses then
				table.insert(elements, {label = _U('license_check'), value = 'license'})
			end


			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = '<span style="color:#7CFC00">🧑🏻 التعامل مع الأفراد</span>',
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
					--[[ old
					elseif action == 'handcuff' then
						TriggerServerEvent('esx_ruski_areszt:startAreszt', GetPlayerServerId(closestPlayer))									-- Rozpoczyna Funkcje na Animacje (Cala Funkcja jest Powyzej^^^)
					Citizen.Wait(3000)																									-- Czeka 2.1 Sekund**
					TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'unbuckle', 0.7)									
					Citizen.Wait(3100)																									-- Czeka 3.1 Sekund**
					TriggerServerEvent('esx_policejob:handcuff',  GetPlayerServerId(closestPlayer))
					elseif action == 'unhandcuff' then																								-- Czeka 3.1 Sekund**
					TriggerServerEvent('esx_policejob:unrestrain',  GetPlayerServerId(closestPlayer))
					elseif action == 'drag' then
						TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer)) -- esx_policejob:unrestrain
					elseif action == 'put_in_vehicle' then
						TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
					elseif action == 'out_the_vehicle' then
						TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))]]
					elseif action == 'bodydrag' then 
						TriggerServerEvent('icemallow-drag:attach',  GetPlayerServerId(closestPlayer))
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
					elseif action == 'jail_menu' then
						TriggerEvent("esx_jail:openJailMenu")								
					end
				else
					ESX.ShowNotification(_U('no_players_nearby'))
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'info_to_player' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'get_info_player', {
				title    = 'خصائص الأستعلام 🔍',
				align    = 'top-left',
				elements = {
					{label = '🌝 استعلام عن طريق اسم الأول و الأخير', value = 'info_by_first_name_and_last_name'},
					{label = '📱 استعلام عن طريق رقم جوالة', value = 'info_by_phone_number'},
					{label = '📝 استعلام عن طريق رقم اللوحة', value = 'info_by_plate_car'},
				}
			}, function(data2, menu2)
				if data2.current.value == 'info_by_first_name_and_last_name' then
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'name_player', {
						title = 'اكتب الأسم ( الأول )'
					}, function(data3, menu3)
						local name_player_one = data3.value
						menu3.close()
						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'name_player2', {
							title = 'اكتب الأسم ( الأخير )'
						}, function(data4, menu4)
							local name_player_two = data4.value
							menu4.close()
							ESX.TriggerServerCallback('esx_policejob:getPlayerInfo', function(Cars)
								local Carsssss = {}
								local HaveOverOne = false
								for i = 1, #Cars, 1 do
									if Cars[i] then
										table.insert(Carsssss, { label = '<font color=gray>اسم المركبة: '..Cars[i].name..' | رقم اللوحة: '..tostring(Cars[i].plate)..'</font>', value = nil })
										HaveOverOne = true
									end
								end

								if not HaveOverOne then
									table.insert(Carsssss, { label = '<font color=gray>لا توجد أي مركبة مسجلة بأسم اللاعب</font>', value = nil })
								end

								ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'admin_menu_cars', {
									title    = 'الأستعلام عن المركبات 🚗',
									align    = 'top-left',
									elements = Carsssss
								}, function(data55, menu55)
								end, function(data55, menu55)
									menu55.close()
								end)
						end, 'first_name_and_last_name', name_player_one, name_player_two)
						end, function(data4, menu4)
							menu4.close()
						end)
					end, function(data3, menu3)
						menu3.close()
					end)
				elseif data2.current.value == 'info_by_phone_number' then
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'name_player', {
						title = 'اكتب رقم الجوال'
					}, function(data3, menu3)
						local name_player_one = data3.value
						menu3.close()
						ESX.TriggerServerCallback('esx_policejob:getPlayerInfo', function(Cars)
							local Carsssss = {}
							local HaveOverOne = false
							for i = 1, #Cars, 1 do
								if Cars[i] then
									table.insert(Carsssss, { label = '<font color=gray>اسم المركبة: '..Cars[i].name..' | رقم اللوحة: '..tostring(Cars[i].plate)..'</font>', value = nil })
									HaveOverOne = true
								end
							end

							if not HaveOverOne then
								table.insert(Carsssss, { label = '<font color=gray>لا توجد أي مركبة مسجلة بأسم اللاعب</font>', value = nil })
							end

							ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'admin_menu_cars', {
								title    = 'الأستعلام عن المركبات 🚗',
								align    = 'top-left',
								elements = Carsssss
							}, function(data55, menu55)
							end, function(data55, menu55)
								menu55.close()
							end)
						end, 'search_by_phone_number', name_player_one, 'ascascasc')
					end, function(data3, menu3)
						menu3.close()
					end)
				elseif data2.current.value == 'info_by_plate_car' then
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'name_player', {
						title = 'اكتب رقم اللوحة'
					}, function(data3, menu3)
						local name_player_one = data3.value
						menu3.close()
						ESX.TriggerServerCallback('esx_policejob:getPlayerInfo', function(Cars)
							local Carsssss = {}
							local HaveOverOne = false
							for i = 1, #Cars, 1 do
								if Cars[i] then
									table.insert(Carsssss, { label = '<font color=gray>اسم المركبة: '..Cars[i].name..' | رقم اللوحة: '..tostring(Cars[i].plate)..'</font>', value = nil })
									HaveOverOne = true
								end
							end

							if not HaveOverOne then
								table.insert(Carsssss, { label = '<font color=gray>لا توجد أي مركبة مسجلة بأسم اللاعب</font>', value = nil })
							end

							ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'admin_menu_cars', {
								title    = 'الأستعلام عن المركبات 🚗',
								align    = 'top-left',
								elements = Carsssss
							}, function(data55, menu55)
							end, function(data55, menu55)
								menu55.close()
							end)
						end, 'search_by_plate', name_player_one, 'ascascasc')
					end, function(data3, menu3)
						menu3.close()
					end)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'police_menu_revive' then
			ESX.TriggerServerCallback('getPlayerCheckOnlineBywesam:check', function(add_msafen)
				if add_msafen then
					ESX.ShowNotification('لايمكن انعاش الاعب لوجود مسعفين')
				elseif not add_msafen then
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					menu.close()
					isBusyRevivePolice = true
					local eeee = {}
					local ped222 = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 3.0)
					for k_s,playerNearby_s in ipairs(ped222) do
						ESX.TriggerServerCallback('esx_adminjob:getNameplayer', function(name_player_s)
							table.insert(eeee, {label = name_player_s.name, playerId = name_player_s.id, coords_player = name_player_s.coords_player})
							ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stretcher_menu3',
							{
								title		= 'حدد من المسقط',
								align		= 'top-left',
								elements	= eeee
							}, function(data3, menu3)
								menu3.close()
								revivePlayer(data3.current.playerId)
							end, function(data3, menu3)
								menu3.close()
						end)
						end, GetPlayerServerId(playerNearby_s))
					end
				end
			end, 'ambulance')
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
				title    = '<span style="color:#FFFF00">🚗 التعامل مع المركبات</span>',
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
						  DoActionImpound(10000)
					end
				else
					ESX.ShowNotification(_U('no_vehicles_nearby'))
				end

			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'object_spawner' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = _U('traffic_interaction'),
				align    = 'top-left',
				elements = {
					{label = _U('cone'), model = 'prop_roadcone02a'},
					{label = 'حاجز سهم', model = 'prop_mp_arrow_barrier_01'},
					{label = 'حاجز اسمنتي طويل', model = 'prop_mp_barrier_01b'},
					{label = 'حاجز بلاستيكي صغير', model = 'prop_barrier_wat_03b'},
					--{label = 'حاجز حديدي صغير', model = 'prop_mp_barrier_02b'},
					--{label = 'عمود صغير أصفر', model = 'prop_bollard_02a'},
					{label = 'حاجز اسمنتي احمر صغير', model = 'prop_barier_conc_05c'},
					{label = 'حاجز اسمنتي صغير', model = 'prop_barier_conc_02a'},
					{label = 'کوخ تفتیش', model = 'prop_air_sechut_01'},
					--{label = 'مظلة عمود', model = 'prop_parasol_05'},
					{label = 'حاجز اسمنتي احمر طويل', model = 'prop_barier_conc_05b'},
					--{label = 'حاجز بلاستيكي الموانئ', model = 'prop_barrier_wat_01a'},
					{label = 'عمود نور کبیر', model = 'prop_worklight_03b'},
					{label = 'عمود نور', model = 'prop_worklight_01a'},
					{label = 'حاجز مغطي', model = 'prop_fncsec_03d'},
					--{label = 'مخفض سرعة كبير', model = 'stt_prop_track_slowdown_t2'},
					--{label = 'مخفض سرعة صغير', model = 'stt_prop_track_slowdown'},
					{label = 'كرسي', model = 'v_ilev_chair02_ped'},
					{label = _U('barrier'), model = 'prop_barrier_work05'},
					{label = _U('spikestrips'), model = 'p_ld_stinger_s'},
					{label = _U('box'), model = 'prop_boxpile_07d'},
					{label = _U('cash'), model = 'hei_prop_cash_crate_half_full'}
			}}, function(data2, menu2)
				local playerPed = PlayerPedId()
				local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
				local objectCoords = (coords + forward * 1.0)

				ESX.Game.SpawnObject(data2.current.model, objectCoords, function(obj)
					SetEntityHeading(obj, GetEntityHeading(playerPed))
					PlaceObjectOnGroundProperly(obj)
				end)
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'mina' then
			local elements = {
			  {label = _U('sea_port_close'), value = 'sea_port_close'},
				{label = _U('seaport_west_close'), value = 'seaport_west_close'},
				{label = _U('internationa_close'), value = 'internationa_close'},
			  --{label = '🔒 <span style="color:yellow;"> تحويل </span> الميناء', value = 'convert'},
			}
    --[[
	if grade >= 10 then
		table.insert(elements,  {label = '⚓  تحويل موقع<span style="color:yellow;"> التصدير </span>', value = 'convert'})
	else
		table.insert(elements, {label = '<font color=gray>تحويل موقع التصدير متاح من رتبة رائد</font>'})
	end	]]
	  
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mina', {
			  title    = "🛳️ إدارة مواقع التصدير",
			  align    = 'bottom-right',
			  elements = elements
			}, function(data2, menu2)
			action = data2.current.value
			label = data2.current.label
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
			  elseif data2.current.value == 'convert' then
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				  title    = "تحويل الموانئ",
				  align    = 'bottom-right',
				  elements = {
					{label = 'الميناء البحري الرئيسي', value = 'main'},
					{label = 'الميناء البحري الغربي', value = 'west'},
					--{label = 'مطار الملك عبدالعزيز الدولي', value = 'airport'}
					{label = '<font color=gray>مطار الملك عبدالعزيز الدولي متاح لالرقابة و التفتيش فقط</font>'}
				  }
				}, function(data2, menu2)
				  if data2.current.value == 'main' then
				    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'conf2irm_menu', {
                  title    = 'تأكيد تحويل موقع التصدير الى الميناء البحري الرئيسي',
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
                  title    = 'تأكيد تحويل موقع التصدير الى الميناء البحري الغربي',
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
				    ESX.UI.Menu.CloseAll()				  
					local msg = '<font size=5 color=white>جاري التنفيذ'
				    TriggerEvent('pogressBar:drawBar', 1000, msg)
					Citizen.Wait(1050)			
					TriggerEvent("wesam:client:mina:airport")
					ExecuteCommand("changemina 3")
				  end
				end, function(data2, menu2)
				  menu2.close()
				end)
			  end
			end, 
			function(data2, menu2)
			  menu2.close()
			end)		 
		elseif data.current.value == 'Panic_Button_Menu' then
			local elements = {
						{label = _U('ports_PB_Menu'),			value = 'ports_PB_Menu'},
						{label = _U('banks_PB_Menu'),			value = 'banks_PB_Menu'},
						{label = _U('public_garage_PB_Menu'),	value = 'public_garage_PB_Menu'},
						{label = _U('Other_PB_Menu'),			value = 'Other_PB_Menu'},
						{label = _U('my_place_PB_Menu'),		value = 'my_place_PB_Menu'},
			}
		
			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'Panic_Button_Menu',
			{
				title    = _U('Panic_Button_Menu'),
				align    = 'top-left',
				elements = elements
			}, function(data2, menu2)
				local action = data2.current.value
				local label = data2.current.label
				
				--START
				if action == 'ports_PB_Menu' then
				--start ports
					local elements = {
					{label = _U('sea_port'),				value = 'sea_port'},
					{label = _U('seaport_west'),			value = 'seaport_west'},
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
					}, function(data3, menu3)
						local action = data3.current.value
						
						if action == 'sea_port' then
							TriggerServerEvent("esx_misc:TogglePanicButton", 'sea_port')
						elseif action == 'seaport_west' then
							TriggerServerEvent("esx_misc:TogglePanicButton", 'seaport_west')
						elseif action == 'international_airport' then
							TriggerServerEvent("esx_misc:TogglePanicButton", 'international_airport')
						elseif action == 'sandy_airport' then
							TriggerServerEvent("esx_misc:TogglePanicButton", 'sandy_airport')
						elseif action == 'farm_airport' then
							TriggerServerEvent("esx_misc:TogglePanicButton", 'farm_airport')
						end
						
					end, function(data3, menu3)
						menu3.close()
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
					}, function(data3, menu3) --change data menu number
						local action = data3.current.value
						--add if statment to excute
						if action == 'pacific_bank' then
							TriggerServerEvent("esx_misc:TogglePanicButton", 'pacific_bank')
						elseif action == 'paleto_bank' then
							TriggerServerEvent("esx_misc:TogglePanicButton", 'paleto_bank')
						elseif action == 'sandy_bank' then
							TriggerServerEvent("esx_misc:TogglePanicButton", 'sandy_bank')
						end
						
					end, function(data3, menu3) --change data menu number
						menu3.close()
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
					}, function(data3, menu3) --change data menu number
						local action = data3.current.value
						--add if statment to excute
						if action == 'public_car_garage_los_santos' then
							TriggerServerEvent("esx_misc:TogglePanicButton", 'public_car_garage_los_santos')
						elseif action == 'public_car_garage_sandy' then
							TriggerServerEvent("esx_misc:TogglePanicButton", 'public_car_garage_sandy')
						elseif action == 'public_car_garage_paleto' then
							TriggerServerEvent("esx_misc:TogglePanicButton", 'public_car_garage_paleto')
						end
						
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
							--{label = _U('army_base'),					value = 'army_base'},
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
						}, function(data3, menu3) --change data menu number
							local action = data3.current.value
							--add if statment to excute
							if action == 'alshaheed_gardeen' then
								TriggerServerEvent("esx_misc:TogglePanicButton", 'alshaheed_gardeen')
							elseif action == 'army_base' then
								TriggerServerEvent("esx_misc:TogglePanicButton", 'army_base')
							elseif action == 'white_house' then
								TriggerServerEvent("esx_misc:TogglePanicButton", 'white_house')
							elseif action == 'cardealer_new' then
								TriggerServerEvent("esx_misc:TogglePanicButton", 'cardealer_new')
							elseif action == 'aucation_house' then
								TriggerServerEvent("esx_misc:TogglePanicButton", 'aucation_house')	
							end
							
						end, function(data3, menu3) --change data menu number
							menu3.close()
						end)
						--end menu	
				elseif action == 'my_place_PB_Menu' then
					exports["esx_misc"]:TriggerMyLocPanicButton()
				end		
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'personal_menu' then
			OpenPersonalMenu()			 
		end
	end, function(data, menu)
		menu.close()
	end)
end

  function DoActionImpound(waitime)
	  _disableAllControlActions = true
	  local playerPed = PlayerPedId()
	  local coords    = GetEntityCoords(playerPed)
	  local found = false
	  
	  for locationNumber,data in pairs(Config.impound.location) do	
		  local dist = GetDistanceBetweenCoords(coords,data.coords)
		  if dist <= data.radius then
			  found = true
			  Citizen.CreateThread(function()
				  while _disableAllControlActions do
					  Citizen.Wait(0)
					  DisableAllControlActions(0) --disable all control (comment it if you want to detect how many time key pressed)
					  EnableControlAction(0, 249, true)  -- N
					  EnableControlAction(0, 311, true)  -- K
					  EnableControlAction(0, 1, true) -- Disable pan
					  EnableControlAction(0, 2, true) -- Disable tilt
				  end
			  end)
			  
			  if IsPedSittingInAnyVehicle(playerPed) then
				  ESX.ShowNotification(_U('inside_vehicle'))
				  return
			  end
			  
			  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
				  local vehicle = nil
			  
				  vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 10.0, 0, 71)
				  --vehicle = ESX.Game.GetVehicleInDirection()
				  
				  if DoesEntityExist(vehicle) then
					  --------------------------
					  ESX.TriggerServerCallback('esx_policejob:canMechanicImpound', function(canImpound)
						  if canImpound then
							  TriggerEvent('pogressBar:drawBar', waitime, '<font size=5>حجز المركبة')
							  Citizen.Wait(1500)
							  TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
							  Citizen.CreateThread(function()
								  Citizen.Wait(waitime-3000)
								  --ESX.Game.DeleteVehicle(vehicle)
								  AdvancedOnesyncDeleteVehicle(vehicle)
								  ClearPedTasksImmediately(playerPed)
								--  TriggerServerEvent('esx_policejob:impoundvehicle', vehicle)
								  Citizen.Wait(1500)
								  _disableAllControlActions = false
								  if Config.EnableJobLogs == true then
									  --TriggerServerEvent('esx_joblogs:AddInLog', "mecano", "del_vehicle", GetPlayerName(PlayerId()))
								  end
							  end)
						  else
							  _disableAllControlActions = false
						  end
					  end,locationNumber)
				  else
					  ESX.ShowNotification(_U('no_vehicle_nearby'))
					  _disableAllControlActions = false
				  end	
			  else
				  ESX.ShowNotification(_U('no_vehicle_nearby'))
				  _disableAllControlActions = false
			  end
		  end	
	  end
	  if not found then 
			exports.pNotify:SendNotification({
            text = '<font color=red>يجب سحب المركبة إلى اقرب كراج حجز',
            type = "alert",
			queue = "killer",
            timeout = 8000,
            layout = "centerLeft",
        })		  
		  
		  _disableAllControlActions = true
		  EnableControlAction(0, 249, true)  -- N
		  EnableControlAction(0, 311, true)  -- K
	  end
  end

  function AdvancedOnesyncDeleteVehicle(vehicle)
	  ESX.Game.DeleteVehicle(vehicle)
	  
	  local entity = vehicle
	  carModel = GetEntityModel(entity)
	  carName = GetDisplayNameFromVehicleModel(carModel)
	  NetworkRequestControlOfEntity(entity)
	  
	  local timeout = 2000
	  while timeout > 0 and not NetworkHasControlOfEntity(entity) do
		  Wait(100)
		  timeout = timeout - 100
	  end
  
	  SetEntityAsMissionEntity(entity, true, true)
	  
	  local timeout = 2000
	  while timeout > 0 and not IsEntityAMissionEntity(entity) do
		  Wait(100)
		  timeout = timeout - 100
	  end
  
	  Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
	  
	  if (DoesEntityExist(entity)) then 
		  DeleteEntity(entity)
	  end 
  end

  function PlayerPanicSound(position)
    pos = position
    playing = true
    TriggerServerEvent("esx_misc4:xsound:playe3dsound", "play", musicId, { position = pos, link = "https://cdn.discordapp.com/attachments/662449900226609173/861485316505206794/ems.ogg" })
end

function revivePlayer(closestPlayer)
	isBusyRevivePolice = true
	ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
		if quantity > 0 then
			local closestPlayerPed = GetPlayerPed(closestPlayer)
			--TriggerServerEvent('esx_ambulancejob:setPlayerDeadAnim', closestPlayer, true)
			ESX.TriggerServerCallback("esx_ambulancejob:checkPlayerIsDead", function(data)
				if data then
					local playerPed = PlayerPedId()
					local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'
					ESX.ShowNotification(_U('revive_inprogress'))
					--TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 8.0, 'ems', 0.8)
					local position = GetEntityCoords(PlayerPedId())
					PlayerPanicSound(position)
					for i=1, 15 do
						Citizen.Wait(900)

						ESX.Streaming.RequestAnimDict(lib, function()
							TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
						end)
					end

					TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
					TriggerServerEvent('esx_ambulancejob:revive', closestPlayer)
					--TriggerServerEvent('esx_ambulancejob:setPlayerDeadAnim', closestPlayer, false)
					Timmingg = 60
				else
					ESX.ShowNotification(_U('player_not_unconscious'))
				end
			end, closestPlayer)
		else
			ESX.ShowNotification(_U('not_enough_medikit'))
		end
		isBusyRevivePolice = false
	end, 'medikit')
end

function OpenIdentityCardMenu(player)
	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
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

function OpenBodySearchMenu(player)
	ESX.TriggerServerCallback('esx_wesam:checkPlayerIsDead', function(data_check)
		if not data_check.status then
			ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
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
							label    = _U('confiscate_inv', data.inventory[i].count, data.inventory[i].label),
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
						TriggerServerEvent('esx_policejob:confiscatePlayerItem', GetPlayerServerId(player), data.current.itemType, data.current.value, data.current.amount)
						OpenBodySearchMenu(player)
					end
				end, function(data, menu)
					menu.close()
				end)
			end, data_check.id_player)
		end
	end, GetPlayerServerId(player))
end

function OpenFineMenu(player)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine', {
		title    = _U('fine'),
		align    = 'top-left',
		elements = {
			{label = _U('traffic_offense'), value = 0},
			{label = _U('minor_offense'),   value = 1},
			{label = _U('average_offense'), value = 2},
			{label = _U('major_offense'),   value = 3},
	}}, function(data, menu)
		OpenFineCategoryMenu(player, data.current.value)
	end, function(data, menu)
		menu.close()
	end)
end

function OpenFineCategoryMenu(player, category)
	ESX.TriggerServerCallback('esx_policejob:getFineList', function(fines)
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
            if Cooldown_count == 0 then
				Cooldown(10)
				billPass = 'a82mKba0bma2'
				if Config.EnablePlayerManagement then
					TriggerServerEvent('esx_adminjob:fine')
					TriggerServerEvent('esx_billing:sendKBill_28vn2', billPass, GetPlayerServerId(player), 'society_police', _U('fine_total', data.current.fineLabel), data.current.amount)
				else
					TriggerServerEvent('esx_billing:sendKBill_28vn2', billPass, GetPlayerServerId(player), '', _U('fine_total', data.current.fineLabel), data.current.amount)
				end
				ESX.UI.Menu.CloseAll()
			else
				ESX.ShowNotification('<font color=red>يجب الأنتظار</font>. <font color=orange>'..Cooldown_count..' ثانية')
			end
		end, function(data, menu)
			menu.close()
		end)
	end, category)
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
						print('[x')
						table.insert(elements, {label = _U('renter', retrivedRentedInfo.owner)})			
					else
						print('[not]')
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

function ShowPlayerLicense(player)
	local elements = {}

	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(playerData)
		if playerData.licenses then
			for i=1, #playerData.licenses, 1 do
				if playerData.licenses[i].label and playerData.licenses[i].type then
				    table.insert(elements, {label = _U('license_warning')})
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
			--ESX.ShowNotification(_U('licence_you_revoked', data.current.label, playerData.name))
			ESX.ShowNotification(_U('licence_you_revoked', playerData.name, data.current.label))
			TriggerServerEvent('esx_policejob:message', GetPlayerServerId(player), _U('license_revoked', data.current.label))

			TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(player), data.current.type)
			
			TriggerServerEvent('license_revokeLog:msg', ('سحب رخص الشرطة'), "***سحب {"..data.current.label.." |"..data.current.type.."}***", " الشرطي \n steam `"..GetPlayerName(PlayerId()).."` \n المواطن steam`"..GetPlayerName(player).."`", 15158332) -- justtest1

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

function OpenCriminalRecords(closestPlayer)
    ESX.TriggerServerCallback('esx_qalle_brottsregister:grab', function(crimes)

        local elements = {}

        table.insert(elements, {label = 'إضافة قيد', value = 'crime'})
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
        end

        end,
        function(data2, menu2)
            menu2.close()
        end)

    end, GetPlayerServerId(closestPlayer))
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
	ESX.TriggerServerCallback('esx_policejob:getArmoryWeapons', function(weapons)
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

			ESX.TriggerServerCallback('esx_policejob:removeArmoryWeapon', function()
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

		ESX.TriggerServerCallback('esx_policejob:addArmoryWeapon', function()
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
			ESX.TriggerServerCallback('esx_policejob:buyWeapon', function(bought)
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
			ESX.TriggerServerCallback('esx_policejob:buyWeapon', function(bought)
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
	ESX.TriggerServerCallback('esx_policejob:getStockItems', function(items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('police_stock'),
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
					TriggerServerEvent('esx_policejob:getStockItem', itemName, count)

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
	ESX.TriggerServerCallback('esx_policejob:getPlayerInventory', function(inventory)
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
					TriggerServerEvent('esx_policejob:putStockItems', itemName, count)

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

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job

	Citizen.Wait(5000)
	TriggerServerEvent('esx_policejob:forceBlip')
	isOnDuty = false -- addon service
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = 'Police',
		number     = 'police',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEwAACxMBAJqcGAAABp5JREFUWIW1l21sFNcVhp/58npn195de23Ha4Mh2EASSvk0CPVHmmCEI0RCTQMBKVVooxYoalBVCVokICWFVFVEFeKoUdNECkZQIlAoFGMhIkrBQGxHwhAcChjbeLcsYHvNfsx+zNz+MBDWNrYhzSvdP+e+c973XM2cc0dihFi9Yo6vSzN/63dqcwPZcnEwS9PDmYoE4IxZIj+ciBb2mteLwlZdfji+dXtNU2AkeaXhCGteLZ/X/IS64/RoR5mh9tFVAaMiAldKQUGiRzFp1wXJPj/YkxblbfFLT/tjq9/f1XD0sQyse2li7pdP5tYeLXXMMGUojAiWKeOodE1gqpmNfN2PFeoF00T2uLGKfZzTwhzqbaEmeYWAQ0K1oKIlfPb7t+7M37aruXvEBlYvnV7xz2ec/2jNs9kKooKNjlksiXhJfLqf1PXOIU9M8fmw/XgRu523eTNyhhu6xLjbSeOFC6EX3t3V9PmwBla9Vv7K7u85d3bpqlwVcvHn7B8iVX+IFQoNKdwfstuFtWoFvwp9zj5XL7nRlPXyudjS9z+u35tmuH/lu6dl7+vSVXmDUcpbX+skP65BxOOPJA4gjDicOM2PciejeTwcsYek1hyl6me5nhNnmwPXBhjYuGC699OpzoaAO0PbYJSy5vgt4idOPrJwf6QuX2FO0oOtqIgj9pDU5dCWrMlyvXf86xsGgHyPeLos83Brns1WFXLxxgVBorHpW4vfQ6KhkbUtCot6srns1TLPjNVr7+1J0PepVc92H/Eagkb7IsTWd4ZMaN+yCXv5zLRY9GQ9xuYtQz4nfreWGdH9dNlkfnGq5/kdO88ekwGan1B3mDJsdMxCqv5w2Iq0khLs48vSllrsG/Y5pfojNugzScnQXKBVA8hrX51ddHq0o6wwIlgS8Y7obZdUZVjOYLC6e3glWkBBVHC2RJ+w/qezCuT/2sV6Q5VYpowjvnf/iBJJqvpYBgBS+w6wVB5DLEOiTZHWy36nNheg0jUBs3PoJnMfyuOdAECqrZ3K7KcACGQp89RAtlysCphqZhPtRzYlcPx+ExklJUiq0le5omCfOGFAYn3qFKS/fZAWS7a3Y2wa+GJOEy4US+B3aaPUYJamj4oI5LA/jWQBt5HIK5+JfXzZsJVpXi/ac8+mxWIXWzAG4Wb4g/jscNMp63I4U5FcKaVvsNyFALokSA47Kx8PVk83OabCHZsiqwAKEpjmfUJIkoh/R+L9oTpjluhRkGSPG4A7EkS+Y3HZk0OXYpIVNy01P5yItnptDsvtIwr0SunqoVP1GG1taTHn1CloXm9aLBEIEDl/IS2W6rg+qIFEYR7+OJTesqJqYa95/VKBNOHLjDBZ8sDS2998a0Bs/F//gvu5Z9NivadOc/U3676pEsizBIN1jCYlhClL+ELJDrkobNUBfBZqQfMN305HAgnIeYi4OnYMh7q/AsAXSdXK+eH41sykxd+TV/AsXvR/MeARAttD9pSqF9nDNfSEoDQsb5O31zQFprcaV244JPY7bqG6Xd9K3C3ALgbfk3NzqNE6CdplZrVFL27eWR+UASb6479ULfhD5AzOlSuGFTE6OohebElbcb8fhxA4xEPUgdTK19hiNKCZgknB+Ep44E44d82cxqPPOKctCGXzTmsBXbV1j1S5XQhyHq6NvnABPylu46A7QmVLpP7w9pNz4IEb0YyOrnmjb8bjB129fDBRkDVj2ojFbYBnCHHb7HL+OC7KQXeEsmAiNrnTqLy3d3+s/bvlVmxpgffM1fyM5cfsPZLuK+YHnvHELl8eUlwV4BXim0r6QV+4gD9Nlnjbfg1vJGktbI5UbN/TcGmAAYDG84Gry/MLLl/zKouO2Xukq/YkCyuWYV5owTIGjhVFCPL6J7kLOTcH89ereF1r4qOsm3gjSevl85El1Z98cfhB3qBN9+dLp1fUTco+0OrVMnNjFuv0chYbBYT2HcBoa+8TALyWQOt/ImPHoFS9SI3WyRajgdt2mbJgIlbREplfveuLf/XXemjXX7v46ZxzPlfd8YlZ01My5MUEVdIY5rueYopw4fQHkbv7/rZkTw6JwjyalBCHur9iD9cI2mU0UzD3P9H6yZ1G5dt7Gwe96w07dl5fXj7vYqH2XsNovdTI6KMrlsAXhRyz7/C7FBO/DubdVq4nBLPaohcnBeMr3/2k4fhQ+Uc8995YPq2wMzNjww2X+vwNt1p00ynrd2yKDJAVN628sBX1hZIdxXdStU9G5W2bd9YHR5L3f/CNmJeY9G8WAAAAAElFTkSuQmCC'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
	end)
-- don't show dispatches if the player isn't in service
AddEventHandler('esx_phone:cancelMessage', function(dispatchNumber)
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' and ESX.PlayerData.job.name == dispatchNumber then
		-- if esx_service is enabled
		if Config.EnableESXService and not Config.playerInService then
			CancelEvent()
		end
	end
end)

AddEventHandler('esx_policejob:hasEnteredMarker', function(station, part, partNum)
	if part == 'cloakroom' then
		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	elseif part == 'Liverys' then
		CurrentAction     = 'menu_Liverys'
		CurrentActionMsg  = _U('open_Liverys')
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
	elseif part == 'Tasleem' then
		CurrentAction     = 'Tasleem'
		CurrentActionMsg  = _U('Tasleem')
		CurrentActionData = {station = station}
	elseif part == 'BossActions' then
		CurrentAction     = 'menu_boss_actions'
		CurrentActionMsg  = _U('open_bossmenu')
		CurrentActionData = {}
	elseif part == 'deleteRecord' then
		CurrentAction     = 'deleteRecord'
		CurrentActionMsg  = _U('deleteRecord')
		CurrentActionData = {station = station}
	end
end)

local jobcolor = {
	['police'] = '<font color=#0070CD> الشرطة </font>',
	['agent'] = '<font color=#558b2f> شركة حرس الحدود  </font>',
	['admin'] = '<font color=#3D3D3D> ادارة الرقابة و التفتيش </font>',
}

function remove_sglat()
    ESX.TriggerServerCallback('esx_qalle_brottsregister:grab', function(result)
		local elements = {}
		local have_any_b = false
        table.insert(elements, {label = '----= السجلات =----'})
		--table.insert(elements, {label = "<font color=green>تحديث</font> القائمة", value = "refresh"})
        for i=1, #result, 1 do
			have_any_b = true
            table.insert(elements, {label = result[i].label, value = result[i].id, name = result[i].name})
        end

		if not have_any_b then
			table.insert(elements, {label = "لايوجد لديك اي سجل جنائي"})
		end
		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'recorddd', {
			title    = 'السجل الجنائي',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			if data.current.value == "refresh" then
				remove_sglat()
			else
				if data.current.value then
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'record', {
						title    = ' تأكيد حذف القيد بمبلغ <font color=green>$</font>'..ESX.Math.GroupDigits(Config.DeleteRecordsMoney),
						align    = 'top-left',
						elements = {
							{label = '<font color=green>تأكيد</font>', value = 'show'},
							{label = '<font color=red>إلغاء</font>', value = 'no'},
						}
					}, function(data2, menu2)
						if data2.current.value == 'show' then
							menu2.close()
							TriggerServerEvent('esx_qalle_brottsregister:remove', data.current.value)
							remove_sglat()
						elseif data2.current.value == 'no' then
							menu2.close()
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				end
			end
		end, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(PlayerId()))
end

RegisterNetEvent('esx_policejob:showRecordsss')
AddEventHandler('esx_policejob:showRecordsss', function()
	remove_sglat()
end)

function deleteRecord(station)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'record', {
		title    = 'عرض سجل '..jobcolor[station]..' بمبلغ <font color=green>$</font>'..ESX.Math.GroupDigits(Config.ShowRecordsMoney),
		align    = 'top-left',
		elements = {
			{label = '<font color=green>تأكيد عرض</font>', value = 'show'},
			{label = '<font color=red>إلغاء</font>', value = 'no'},
		}
	}, function(data2, menu2)
		if data2.current.value == 'show' then
			TriggerServerEvent('esx_policejob:removedeleteRecordMoney', 'show', Config.ShowRecordsMoney, '', station)
			menu2.close()
		elseif data2.current.value == 'no' then
			ESX.UI.Menu.CloseAll()
		end
	end, function(data2, menu2)
		menu2.close()

		CurrentAction     = 'deleteRecord'
		CurrentActionMsg  = _U('deleteRecord')
		CurrentActionData = {station = station}
	end)
end

AddEventHandler('esx_policejob:hasExitedMarker', function(station, part, partNum)
	if not isInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

AddEventHandler('esx_policejob:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' and IsPedOnFoot(playerPed) then
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

AddEventHandler('esx_policejob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

--[[
RegisterNetEvent('esx_policejob:handcuff')
AddEventHandler('esx_policejob:handcuff', function()
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

RegisterNetEvent('esx_policejob:handcuff')
AddEventHandler('esx_policejob:handcuff', function()
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

RegisterNetEvent('esx_policejob:unrestrain')
AddEventHandler('esx_policejob:unrestrain', function()
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

RegisterNetEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(copId)
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

RegisterNetEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function()
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

RegisterNetEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function()
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

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()	
	    local playerCoords = GetEntityCoords(PlayerPedId())	
		Citizen.Wait(1000)
		if IsPedInAnyVehicle(playerPed, false) then
		--print("In Vehicle")
		DisableControlAction(0, 68, true)
		DisableControlAction(0, 91, true)	
		DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
		DisablePlayerFiring(playerPed,true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
		DisableControlAction(0, 45, true) -- Disable R Button
		DisableControlAction(0, 24, true) -- Disable R Button
		DisableControlAction(0, 69, true)
		DisableControlAction(0, 92, true)
		DisableControlAction(0, 106, true)
		DisableControlAction(0, 140, true)	
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee	
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1			
		end	
    end
end)

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()			
		Citizen.Wait(10)
		if IsPedOnFoot(playerPed) then		
			DisableControlAction(0, 140, true)
            DisableControlAction(0, 303, true)	
            DisableControlAction(0, 106, true)			
		elseif IsPedReloadingWeapon then
			DisableControlAction(0, 140, true)	
			DisableControlAction(0, 24, true)		
		end	
    end
end)


-- Create blips
Citizen.CreateThread(function()
	for k,v in pairs(Config.PoliceStations) do
		if k == "remove_sglat" then
			--print()
		else
			local blip = AddBlipForCoord(v.Blip.Coords)

			SetBlipSprite (blip, v.Blip.Sprite)
			SetBlipDisplay(blip, v.Blip.Display)
			SetBlipScale  (blip, v.Blip.Scale)
			SetBlipColour (blip, v.Blip.Colour)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName('STRING')
			AddTextComponentSubstringPlayerName(_U('map_blip'))
			EndTextCommandSetBlipName(blip)
		end
	end
end)

-- Draw markers and more
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if ESX.PlayerData.job then
			local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed)
			local isInMarker, hasExited, letSleep = false, false, true
			local currentStation, currentPart, currentPartNum

			for k,v in pairs(Config.PoliceStations) do
				if k == "remove_sglat" then
					for i=1, #v, 1 do
						local distance = #(playerCoords - v[i].Pos)

						if distance < Config.DrawDistance then
							DrawMarker(Config.MarkerType.deleteRecord, v[i].Pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, v[i].Color.r, v[i].Color.g, v[i].Color.b, 100, false, true, 2, true, false, false, false)
							letSleep = false
							if distance < Config.MarkerSize.x then
								isInMarker, currentStation, currentPart, currentPartNum = true, v[i].job, 'deleteRecord', i
							end
						end
					end
				else
					if ESX.PlayerData.job.name == "police" then
						if v.cloakroom then

							for i=1, #v.cloakroom, 1 do
								local distance = #(playerCoords - v.cloakroom[i])

								if distance < Config.DrawDistance then
									DrawMarker(Config.MarkerType.cloakroom, v.cloakroom[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
									letSleep = false

									if distance < Config.MarkerSize.x then
										isInMarker, currentStation, currentPart, currentPartNum = true, k, 'cloakroom', i
									end
								end
							end

						end

						if v.Armories then

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

						end

						if v.Vehicles then

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

						end

						if v.Helicopters then

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

						end

						if v.Liverys then
						
							for i=1, #v.Liverys, 1 do
								local distance = #(playerCoords - v.Liverys[i])

								if distance < 30 then
									DrawMarker(Config.MarkerType.Liverys, v.Liverys[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, true, false, false, false)
									letSleep = false

									if distance < Config.MarkerSize.x then
										isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Liverys', i
									end
								end
							end

						end
						
						if v.Tasleem then
							for i=1, #v.Tasleem, 1 do
								local distance = #(playerCoords - v.Tasleem[i])
								if distance < Config.DrawDistance then
									DrawMarker(Config.MarkerType.Tasleem, v.Tasleem[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
									letSleep = false

									if distance < Config.MarkerSize.x then
										isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Tasleem', i
									end
								end
							end
						end

						if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'bosstwo' then
							if v.BossActions then
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

					end
					
				end
			end

			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
				if
					(LastStation and LastPart and LastPartNum) and
					(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				TriggerEvent('esx_policejob:hasEnteredMarker', currentStation, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
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
		--'prop_bollard_02a',
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
		'prop_fncsec_03b',
		'prop_trailer_01_new',
		--'stt_prop_track_slowdown_t2',
		--'stt_prop_track_slowdown',
		'v_ilev_chair02_ped',
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
				TriggerEvent('esx_policejob:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
			end
		else
			if LastEntity then
				TriggerEvent('esx_policejob:hasExitedEntityZone', LastEntity)
				LastEntity = nil
			end
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) and ESX.PlayerData.job then
				if CurrentAction == 'menu_cloakroom' and ESX.PlayerData.job.name == 'police' then
					exports['pogressBar']:drawBar(1500, 'جاري التنفيذ')
					Citizen.SetTimeout(1500, function()
						OpenCloakroomMenu()
					end)
				elseif CurrentAction == 'menu_Liverys' and ESX.PlayerData.job.name == 'police' then
					ESX.UI.Menu.CloseAll()
					if Config.playerInService then
						exports['pogressBar']:drawBar(1500, 'جاري التنفيذ')
						Citizen.SetTimeout(1500, function()
							OpenLiveryMenu()
						end)
					else
						ESX.ShowNotification(_U('service_not'))
					end
				elseif CurrentAction == 'deleteRecord' then
					exports['pogressBar']:drawBar(1500, 'جاري التنفيذ')
					Citizen.SetTimeout(1500, function()
						deleteRecord(CurrentActionData.station)
					end)
				elseif CurrentAction == 'menu_armory' and ESX.PlayerData.job.name == 'police' then
					exports['pogressBar']:drawBar(1500, 'جاري التنفيذ')
					Citizen.SetTimeout(1500, function()
						OpenArmoryMenu()
					end)
				elseif CurrentAction == 'Tasleem' and ESX.PlayerData.job.name == 'police' then
					if Config.playerInService then
						exports['pogressBar']:drawBar(1500, 'جاري التنفيذ')
						Citizen.SetTimeout(3000, function()
							TriggerServerEvent('esx_policejob:Tasleem')
						end)
					else
						ESX.ShowNotification(_U('service_not'))
					end
				elseif CurrentAction == 'menu_vehicle_spawner' and ESX.PlayerData.job.name == 'police' then
					if Config.playerInService then
						ESX.UI.Menu.CloseAll()				  
						exports['pogressBar']:drawBar(1500, 'جاري التنفيذ')
						Citizen.SetTimeout(3000, function()
							OpenVehicleSpawnerMenu('car', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
						end)
					else
						ESX.ShowNotification(_U('service_not'))
					end
				elseif CurrentAction == 'Helicopters' and ESX.PlayerData.job.name == 'police' then
					ESX.UI.Menu.CloseAll()
					if Config.playerInService then
						exports['pogressBar']:drawBar(1500, 'جاري التنفيذ')
						Citizen.SetTimeout(3000, function()
							OpenVehicleSpawnerMenu('helicopter', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
						end)
					else
						ESX.ShowNotification(_U('service_not'))
					end
				elseif CurrentAction == 'delete_vehicle' and ESX.PlayerData.job.name == 'police' then
					ESX.UI.Menu.CloseAll()
					if Config.playerInService then
						exports['pogressBar']:drawBar(1500, 'جاري التنفيذ')
							Citizen.SetTimeout(3000, function()
							ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
						end)
					else
						ESX.ShowNotification(_U('service_not'))
					end
				elseif CurrentAction == 'menu_boss_actions' and ESX.PlayerData.job.name == 'police' then
					ESX.UI.Menu.CloseAll()
					if Config.playerInService then
						exports['pogressBar']:drawBar(1500, 'جاري التنفيذ')
						Citizen.SetTimeout(3000, function()
							TriggerEvent('esx_society:openBossMenu', 'police', function(data, menu)
								CurrentAction     = 'menu_boss_actions'
								CurrentActionMsg  = _U('open_bossmenu')
								CurrentActionData = {}
							end, { wash = true })
						end)
					else
						ESX.ShowNotification(_U('service_not'))
					end
				elseif CurrentAction == 'remove_entity' and ESX.PlayerData.job.name == 'police' then
					DeleteEntity(CurrentActionData.entity)
				end
				CurrentAction = nil
			end
		end

		if IsControlJustReleased(0, 38) and currentTask.busy then
			ESX.ShowNotification(_U('impound_canceled'))
			ESX.ClearTimeout(currentTask.task)
			ClearPedTasks(PlayerPedId())

			currentTask.busy = false
		end
	end
end)
exports("OpenCloakroomMenu",OpenCloakroomMenu)
exports("OpenPoliceActionsMenu",OpenPoliceActionsMenu)
-- Create blip for colleagues

function GetExtraLabel(state)
    if state then
        return '<span style="color:green;">مفعل</span>'
    elseif not state then
        return '<span style="color:darkred;">غير مفعل</span>'
    end
end

function ToggleVehicleExtra(vehicle, extraId, extraState)
    SetVehicleExtra(vehicle, extraId, extraState)
end

function OpenLiveryMenu()
    local playerPed = PlayerPedId()
    if IsPedInAnyVehicle(playerPed) then
        local vehicle  = GetVehiclePedIsIn(playerPed, false)
        local LiveryCount = GetVehicleLiveryCount(vehicle)
        local elements = {
            { label = '<span style="color:Red;">الملصقات و الأكسترا</span>', value = 'title'}
        }
        for i=1,LiveryCount do
            table.insert(elements, {label = 'الملصق '..i, value = i, type = "livery"})
        end
		for i=0, 12 do
			if DoesExtraExist(vehicle, i) then
				local state = IsVehicleExtraTurnedOn(vehicle, i) == 1
				table.insert(elements, {label = ('اكسسوار <span style="color:darkgoldenrod;">%s</span>: %s'):format(i, GetExtraLabel(state)), state = state, extraId = i, type = "extra"})
			end
		end
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'livery',
        {
            title    = 'قائمة الملصقات',
            align    = 'bottom-right',
            elements = elements
        }, function(data, menu)
            if not (data.current.value == 'title') then
				if data.current.type == "livery" then
					local currentLivery = GetVehicleLivery(vehicle)
					if not (currentLivery == data.current.value) then
						SetVehicleLivery(vehicle, data.current.value)
					end
				elseif data.current.type == "extra" then
					ToggleVehicleExtra(vehicle, data.current.extraId, data.current.state)
					OpenLiveryMenu()
				end
            end
        end, function(data2, menu2)
            menu2.close()
        end)
    else
        ESX.ShowNotification('يجب أن تكون داخل السيارة')
    end
end

function createBlip(id)
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then -- Add blip and create head display on player
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)
		ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
		SetBlipNameToPlayerName(blip, id) -- update blip name
		SetBlipScale(blip, 0.85) -- set scale
		SetBlipAsShortRange(blip, true)

		table.insert(blipsCops, blip) -- add blip to array so we can remove it later
	end
end

RegisterNetEvent('esx_policejob:updateBlip')
AddEventHandler('esx_policejob:updateBlip', function()

	-- Refresh all blips
	for k, existingBlip in pairs(blipsCops) do
		RemoveBlip(existingBlip)
	end

	-- Clean the blip table
	blipsCops = {}

	-- Enable blip?
	if Config.EnableESXService and not Config.playerInService then
		return
	end

	if not Config.EnableJobBlip then
		return
	end

	-- Is the player a cop? In that case show all the blips for other cops
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
		ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'police' then
					local id = GetPlayerFromServerId(players[i].source)
					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						createBlip(id)
					end
				end
			end
		end)
	end

end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
	TriggerEvent('esx_policejob:unrestrain')

	if not hasAlreadyJoined then
		TriggerServerEvent('esx_policejob:spawned')
	end
	hasAlreadyJoined = true
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_policejob:unrestrain')
		TriggerEvent('esx_phone:removeSpecialContact', 'police')

		if Config.EnableESXService then
			TriggerServerEvent('esx_service:disableService', 'police')
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
		TriggerEvent('esx_policejob:unrestrain')
		handcuffTimer.active = false
	end)
end

-- TODO
--   - return to garage if owned
--   - message owner that his vehicle has been impounded
function ImpoundVehicle(vehicle)
	--local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
	ESX.Game.DeleteVehicle(vehicle)
	ESX.ShowNotification(_U('impound_successful'))
	currentTask.busy = false
end
