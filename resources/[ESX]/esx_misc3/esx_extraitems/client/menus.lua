-- https://wiki.rage.mp/index.php?title=Weapons_Components#Pistol

RegisterNetEvent('esx_extraitems:OpenCompMenu')
AddEventHandler('esx_extraitems:OpenCompMenu', function()
	OpenCompMenu()
end)

function OpenCompMenu()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'uni_skins', {
		title = _U('uni_skins'),
		align = GetConvar('esx_MenuAlign', 'top-left'),
		elements = {
			{label = 'طبيعي', value = 'skin_normal'},
			{label = '<font color=#008000>أخضر</font>', value = 'skin_green'},
			{label = '<font color=#ffd700>ذهبي</font>', value = 'skin_gold'},
			{label = '<font color=#ffc0cb>زهري</font>', value = 'skin_pink'},
			{label = '<font color=#FFFAFA>لون جيشي</font>', value = 'skin_army'},
			{label = '<font color=#FFFAFA>لون عسكري</font>', value = 'skin_lspd'},
			{label = '<font color=#ffa500>برتقالي</font>', value = 'skin_orange'},
			{label = '<font color=#e5e4e2>بلاتيني</font>', value = 'skin_platinum'}
	}}, function(data2, menu2)
		local action2 = data2.current.value

		if action2 == 'skin_normal' then
			SetPedWeaponTintIndex(PlayerPed, CurrentWeaponHash, 0)
		elseif action2 == 'skin_green' then
			SetPedWeaponTintIndex(PlayerPed, CurrentWeaponHash, 1)
		elseif action2 == 'skin_gold' then
			SetPedWeaponTintIndex(PlayerPed, CurrentWeaponHash, 2)
		elseif action2 == 'skin_pink' then
			SetPedWeaponTintIndex(PlayerPed, CurrentWeaponHash, 3)
		elseif action2 == 'skin_army' then
			SetPedWeaponTintIndex(PlayerPed, CurrentWeaponHash, 4)
		elseif action2 == 'skin_lspd' then
			SetPedWeaponTintIndex(PlayerPed, CurrentWeaponHash, 5)
		elseif action2 == 'skin_orange' then
			SetPedWeaponTintIndex(PlayerPed, CurrentWeaponHash, 6)
		elseif action2 == 'skin_platinum' then
			SetPedWeaponTintIndex(PlayerPed, CurrentWeaponHash, 7)
		end
	end, function(data2, menu2)
		menu2.close()
	end)
end