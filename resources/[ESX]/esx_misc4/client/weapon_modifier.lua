--disable vehicle reward
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		DisablePlayerVehicleRewards(PlayerId())
	end
end)

--no driveby
Citizen.CreateThread(function()
	local whitelistVehicle = {
	'polmav',
	'polmav2',
	'polmav4',
	'polmav5',
	'cargobob3',
	}
	
	local function isInVehicle()
		return IsPedInAnyVehicle(PlayerPedId(), true)
	end
	
	local function IsWhitelistVehicle()
		local lPed = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(lPed)
		for _,v in pairs(whitelistVehicle) do
			if IsVehicleModel(vehicle, GetHashKey(v)) then
				return true
			end
		end
		return false
	end
	
	while true do
		Citizen.Wait(0)
		local letsleep = true
		if isInVehicle() then
			if not IsWhitelistVehicle() then
				letsleep = false
				SetPlayerCanDoDriveBy(PlayerId(), false)
				DisableControlAction(2, 37, true)
				HideHudComponentThisFrame(19) -- Weapon Wheel
				DisplayAmmoThisFrame(false)
			else
				SetPlayerCanDoDriveBy(PlayerId(), true)
			end
		end

		if letsleep then
			Citizen.Wait(500)
		end
	end
end)


--damage modifier
Citizen.CreateThread(function()
    --add weapon to modify melee damage
	local weapons = {
		{name="WEAPON_UNARMED", 	damage= 0.1},
		{name="WEAPON_FLASHLIGHT", 	damage= 0.2},
		{name="WEAPON_KNUCKLE",		damage= 0.3},
		{name="WEAPON_BAT",			damage= 0.3},
		{name="WEAPON_GOLFCLUB",	damage= 0.3},
		{name="WEAPON_NIGHTSTICK",	damage= 0.4},
		{name="WEAPON_WRENCH",		damage= 0.4},
		{name="WEAPON_POOLCUE",		damage= 0.2},
		{name="WEAPON_BOTTLE", 		damage= 0.4},
		{name="WEAPON_CROWBAR", 	damage= 0.5},
	}
	
	while true do
		Citizen.Wait(0)
		for _,v in pairs(weapons) do
			N_0x4757f00bc6323cfe(GetHashKey(v.name), v.damage)
		end
		--modify AI melee attack damage
		SetAiMeleeWeaponDamageModifier(0.4)
    end
end)