ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
function OpenWeaponsSkinsMenu()
    local elements = {}
    ESX.UI.Menu.CloseAll()
    table.insert(elements, {label = "الأساسي", istint = true, value = 0})
    table.insert(elements, {label = "اخضر", istint = true, value = 1})
    table.insert(elements, {label = "ذهبي", istint = true, value = 2})
    table.insert(elements, {label = "وردي", istint = true, value = 3})
    table.insert(elements, {label = "جيشي", istint = true, value = 4})
    table.insert(elements, {label = "شرطة", istint = true, value = 5})
    table.insert(elements, {label = "برتقالي", istint = true, value = 6})
    table.insert(elements, {label = "بلاتيني", istint = true, value = 7})
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'esx_extraitems_skins', {
        title    = 'قائمة كفرات سلاح مجانا',
        align    = 'top-left',
         elements = elements
    }, function(data, menu)
        SetPedWeaponTintIndex(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), data.current.value)
    end, function(data, menu)
        menu.close()
    end)
end


Citizen.CreateThread(function()
    while true do
        if not IsPedInAnyVehicle(PlayerPedId(), false) and GetSelectedPedWeapon(PlayerPedId()) ~= GetHashKey("WEAPON_UNARMED") then
            if not IsPlayerFreeAiming(PlayerId()) then
                if IsControlJustReleased(0, 246) or IsControlPressed(0, 344) and GetLastInputMethod(2) and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'esx_extraitems_skins') then
                    Sleep = 0
                    OpenWeaponsSkinsMenu()
                end
            end
        end
        Citizen.Wait(0)
    end
end)
