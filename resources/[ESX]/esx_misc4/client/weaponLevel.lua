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


function checkRequiredXPlevel(required)
	local level = exports.ESX_SystemXpLevel.ESXP_GetRank()
	if level >= required then
		return true
	else
		return false
	end
end

Citizen.CreateThread(function()
	local sleep = 3000
	while true do
		ESX.TriggerServerCallback('esx_adminjob:checkJobPlayer', function(job_player_what)
			sleep = 1000
			local ped = PlayerPedId()
			local _,pedWeapon = GetCurrentPedWeapon(ped, true)
			if job_player_what == 'police' or job_player_what == 'admin' or job_player_what == 'agent' then
				--print()
			else
				if not leojob then
					if IsPedArmed(ped, 6) and GetHashKey('WEAPON_UNARMED') ~= pedWeapon then
						for i=1, #Config.WeaponLevel, 1 do
							local item = Config.WeaponLevel[i]
							if pedWeapon == GetHashKey(item.item) then
								if job_player_what == "ambulance" then
									SetCurrentPedWeapon(ped, 'WEAPON_UNARMED', 1)
									ESX.ShowNotification("انت <span style='color:red;'>مسعف</span> <span style='color:white;'>لايسمح لك ب استخدام الأسلحة</span>")
									blocked	 = false
									TriggerEvent('wesam:esx_animations2:holsterweapon:fix_blocked') -- يصلح مشكلة ركوب السيارة و إخراج السلاح
								elseif job_player_what == "mechanic" then
									SetCurrentPedWeapon(ped, 'WEAPON_UNARMED', 1)
									ESX.ShowNotification("انت <span style='color:gray;'>ميكانيكي</span> <span style='color:white;'>لايسمح لك ب استخدام الأسلحة</span>")
									blocked	 = false
									TriggerEvent('wesam:esx_animations2:holsterweapon:fix_blocked') -- يصلح مشكلة ركوب السيارة و إخراج السلاح	
								end
								if not checkRequiredXPlevel(item.level) then
									SetCurrentPedWeapon(ped, 'WEAPON_UNARMED', 1)
									ESX.ShowNotification('المستوى المطلوب لسلاح <font color=orange>'..item.label..'</font> <font color=red>'..item.level)
									blocked	 = false
									TriggerEvent('wesam:esx_animations2:holsterweapon:fix_blocked') -- يصلح مشكلة ركوب السيارة و إخراج السلاح
								end
							end					
						end	
					end
				end
			end
		end, ESX.PlayerData.identifier)
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	local sleep = 3000
	while true do
		sleep = 1000
		local ped = PlayerPedId()
		local _,pedWeapon = GetCurrentPedWeapon(ped, true)
		
		if IsPedArmed(ped, 6) and GetHashKey('WEAPON_UNARMED') ~= pedWeapon and GetHashKey('WEAPON__PETROLCAN') ~= pedWeapon then
			local panic = exports.esx_misc4:panicstate()
			if panic['peace_time'].state or panic['9eanh_time'].state then
				SetCurrentPedWeapon(ped, 'WEAPON_UNARMED', 1)
				blocked	 = false
			end
		end
		Citizen.Wait(sleep)
	end
end)