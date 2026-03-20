----------------------
-- Author : Deediezi
-- Version 4.5
--
-- Contributors : No contributors at the moment.
--
-- Github link : https://github.com/Deediezi/FiveM_LockSystem
-- You can contribute to the project. All the information is on Github.

--  Vehicle object manager - Client side

function newVehicle()
    local self = {}

    self.id = nil
    self.plate = nil
    self.lockStatus = nil

    rTable = {}

    rTable.__construct = function(id, plate, lockStatus)
        if(id and type(id) == "number")then
            self.id = id
        end
        if(plate and type(plate) == "string")then
            self.plate = plate
        end
        if(lockStatus and type(lockStatus) == "number")then
            self.lockStatus = lockStatus
        end
    end

    -- Methods

    rTable.update = function(id, lockStatus)
        self.id = id
        self.lockStatus = lockStatus
    end
	
    -- 0, 1 = unlocked
    -- 2 = locked
    -- 4 = locked and player can't get out
    rTable.lock = function()
        lockStatus = self.lockStatus
        if(lockStatus <= 2)then
            self.lockStatus = 4
            SetVehicleDoorsLocked(self.id, self.lockStatus)
            SetVehicleDoorsLockedForAllPlayers(self.id, 1)
            TriggerEvent("ls:notify", _U("vehicle_locked"))
            --TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "lock", 0.3)
			playHornSound(self.id,true)
			drawTxt(0.5,0.5 ,0.4, 'ﺔﺒﻛﺮﻤﻟﺍ ﻞﻔﻗ', 255,0,0,255)
        elseif(lockStatus > 2)then
            self.lockStatus = 1
            SetVehicleDoorsLocked(self.id, self.lockStatus)
            SetVehicleDoorsLockedForAllPlayers(self.id, false)
            TriggerEvent("ls:notify", _U("vehicle_unlocked"))
			playHornSound(self.id,false)
			drawTxt(0.5,0.5 ,0.4, 'ﺔﺒﻛﺮﻤﻟﺍ ﺢﺘﻓ', 0,255,0,255)
            --TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "unlock", 0.3)
        end
    end

    -- Setters

    rTable.setId = function(id)
        if(type(id) == "number" and id >= 0)then
            self.id = id
        end
    end

    rTable.setPlate = function(plate)
        if(type(plate) == "string")then
            self.plate = plate
        end
    end

    rTable.setLockStatus = function(lockStatus)
        if(type(lockStatus) == "number" and lockStatus >= 0)then
            self.lockStatus = lockStatus
            SetVehicleDoorsLocked(self.id, lockStatus)
        end
    end

    -- Getters

    rTable.getId = function()
        return self.id
    end

    rTable.getPlate = function()
        return self.plate
    end

    rTable.getLockStatus = function()
        return self.lockStatus
    end

    return rTable
end

function playHornSound(vehicle,status)
	Citizen.CreateThread(function()
		
		if not IsPedInVehicle(GetPlayerPed(-1),vehicle,true) then
			--anim
			local lib = 'anim@mp_player_intmenu@key_fob@'
			--local anim = 'fob_click_fp'
			local anim = 'fob_click'
			
			RequestAnimDict(lib)
			while not HasAnimDictLoaded( lib) do
				Citizen.Wait(1)
			end
			TaskPlayAnim(GetPlayerPed(-1), lib ,anim ,8.0, -8.0, -1, 0, 0, false, false, false)
			Citizen.Wait(600)
		
			--horn
			local sleep = 60
			local count = sleep
			
			SetVehicleLights(vehicle,2)
			
			repeat
				SoundVehicleHornThisFrame(vehicle)
				count = count - 1
			until count == 0
			
			Citizen.Wait(150)
			
			if not status then -- true = locked (double horn)	
				count = sleep
				
				repeat
					SoundVehicleHornThisFrame(vehicle)
					count = count - 1
				until count == 0
			end	
			
			SetVehicleLights(vehicle,0)
			
		end
		
	end)	
end

RegisterFontFile('A9eelsh')
local fontId = RegisterFontId('A9eelsh')
local drawTxtCount = 50

function drawTxt(x, y, scale, text, r,g,b,a)
	Citizen.CreateThread(function()
		drawTxtCount = 0
		Citizen.Wait(100)
		drawTxtCount = 50
		
		while drawTxtCount >= 0 do
			Citizen.Wait(0)
			
			SetTextFont(fontId)
			SetTextProportional(0)
			SetTextScale(scale, scale)
			SetTextColour(r, g, b, a)
			SetTextDropShadow(0, 0, 0, 0,255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(x,y)
			
			drawTxtCount = drawTxtCount -1
		end
	end)	
end