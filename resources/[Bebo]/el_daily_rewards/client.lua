AddEventHandler('esx:playerLoaded', function(xPlayer)
	TriggerServerEvent("daily_reward:updateTimeout")
end)

RegisterNetEvent("daily_reward:toggleFreeMenu")
AddEventHandler("daily_reward:toggleFreeMenu", function(state)
	SetNuiFocus(state, state)
	SendNUIMessage({type = "toggleshow", enable = state})
end)

RegisterNetEvent("daily_reward:setTimeout")
AddEventHandler("daily_reward:setTimeout", function(t)
	SendNUIMessage({type = "settimeout", timeout = tonumber(t * 1000)})
end)

RegisterNetEvent("daily_reward:giveWpn")
AddEventHandler("daily_reward:giveWpn", function(wpn,ammo)
	local ped = GetPlayerPed(-1)
	wpn = GetHashKey(wpn)
	if HasPedGotWeapon(ped, wpn, false) then AddAmmoToPed(ped, wpn, ammo) else GiveWeaponToPed(ped, wpn, ammo, false, false) end
end)

RegisterNUICallback("hidemenu", function(data, cb)
	TriggerEvent("daily_reward:toggleFreeMenu", false)
end)

RegisterNUICallback("collect", function(data, cb)
	TriggerServerEvent("daily_reward:collect", data.t)
end)

Citizen.CreateThread(function()
	TriggerServerEvent("daily_reward:updateTimeout")
	while true do
		Citizen.Wait(600000)
		TriggerServerEvent("daily_reward:updateTimeout") -- update timeout every 10 minutes because why not
	end
end)

TriggerEvent('chat:addSuggestion', '/daily', 'Open daily rewards menu',{})