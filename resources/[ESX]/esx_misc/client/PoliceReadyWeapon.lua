local setWeapon 		 	= ""
local www = ""
local weaponCount			= 0
local disablePedWeaponDraw 	= false  --- Set this to true and non-police players will be set to unarmed when exiting a vehicle. If you use a custom unholstering animation enable this to prevent players bypassing it.

Citizen.CreateThread(function()
	while PlayerData == nil do
		Citizen.Wait(500)
	end
	
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		if MycurrentJobLeo then
			if IsPedInAnyVehicle(ped, false) or IsPedInAnyVehicle(ped, false) == 0 then
				DisableControlAction(0,157,true) -- disable '1' Key
				if IsDisabledControlJustReleased(0, 157) then
					ReadyWeaponCounter()
					Citizen.Wait(800)
				end

			end
		end
	end
end)

Citizen.CreateThread(function()
	while PlayerData == nil do
		Citizen.Wait(500)
	end
	
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped, false) or IsPedInAnyVehicle(ped, false) == 0 then
			if MycurrentJobLeo then
				if IsControlJustReleased(0, 75) then
					SetCurrentPedWeapon(ped, setWeapon, true)
					TriggerEvent('esx_wesam:setPolice', setWeapon)
					ClearPedSecondaryTask()
					Citizen.Wait(1000)
				end
			else
				if disablePedWeaponDraw then
					if IsControlJustReleased(0, 75) then
						SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"))
						Citizen.Wait(1000)
					end
				end
			end
		end
	end
end)

function ReadyWeaponCounter()
	weaponCount = weaponCount + 1
	if weaponCount == 1 then
		www = "WEAPON_STUNGUN"
		setWeapon = GetHashKey("WEAPON_STUNGUN")
		ReadyWeaponSendNotification('صاعق')
	elseif weaponCount == 2 then
		www = "WEAPON_PISTOL"
		setWeapon = GetHashKey("WEAPON_PISTOL")
		ReadyWeaponSendNotification('مسدس')
	elseif weaponCount == 3 then
		www = "WEAPON_PUMPSHOTGUN"
		setWeapon = GetHashKey("WEAPON_PUMPSHOTGUN")
		ReadyWeaponSendNotification('شوزن')
	elseif weaponCount == 4 then
		www = "WEAPON_CARBINERIFLE"
		setWeapon = GetHashKey("WEAPON_CARBINERIFLE")
		ReadyWeaponSendNotification('رشاش')
	elseif weaponCount == 5 then
		setWeapon = GetHashKey("WEAPON_UNARMED")
		ReadyWeaponSendNotification('غير مسلح')
	elseif weaponCount <= 6 then
		weaponCount = 0
	end
end

function ReadyWeaponSendNotification(msg)
	exports.pNotify:SetQueueMax("left", 1)
	exports.pNotify:SendNotification({
	text = "<font size=6 ><center><b>"..msg.."</center></b></font>",
	type = "info",
	timeout = 600,
	layout = "centerLeft",
	queue = "left",
	killer = true
	})
end