local Player          = nil
local CruisedSpeed, CruisedSpeedKm, VehicleVectorY = 0, 0, 0

Citizen.CreateThread(function ()
  while true do
    Wait(0)
    if IsControlJustPressed(1, 246) and IsDriver() then
      Player = PlayerPedId()
      TriggerCruiseControl()
    end
  end
end)

function TriggerCruiseControl ()
  if IsPedInAnyBoat(PlayerPedId()) then
    ESX.ShowNotification('<font color=red>لا يمكن استعمال مثبت السرعة في القوارب')
    return false
  end

  if IsPedInAnyHeli(PlayerPedId()) then
    ESX.ShowNotification('<font color=red>لا يمكن استعمال مثبت السرعة في المروحيات')
    return false
  end

  if IsPedInAnyPlane(PlayerPedId()) then
    ESX.ShowNotification('<font color=red>لا يمكن استعمال مثبت السرعة في الطائرات')
    return false
  end
  if CruisedSpeed == 0 and IsDriving() then
    if GetVehiculeSpeed() > 0 and GetVehicleCurrentGear(GetVehicle()) > 0  then
      CruisedSpeed = GetVehiculeSpeed()
      CruisedSpeedKm = TransformToKm(CruisedSpeed)

      exports.pNotify:SendNotification({
				text = "<font size=5><p align=center><b>مثبت سرعة: <font color=orange>" .. CruisedSpeedKm .. "<font color=gray> كم/ساعة",	   
					type = "alert",
					timeout = 7000,
					layout = "centerleft",
					queue = "left",
					killer = true
			})

      Citizen.CreateThread(function ()
        while CruisedSpeed > 0 and IsInVehicle() == Player do
          Wait(0)

          if not IsTurningOrHandBraking() and GetVehiculeSpeed() < (CruisedSpeed - 1.5) then
            CruisedSpeed = 0
            exports.pNotify:SendNotification({
							text = "<font color=red size=5><p align=center><b>إلغاء مثبت السرعة",	   
								type = "alert",
								timeout = 5000,
								layout = "centerleft",
								queue = "left",
								killer = true
						})
            Wait(2000)
            break
          end

          if not IsTurningOrHandBraking() and IsVehicleOnAllWheels(GetVehicle()) and GetVehiculeSpeed() < CruisedSpeed then
            SetVehicleForwardSpeed(GetVehicle(), CruisedSpeed)
          end

          if IsControlJustPressed(1, 246) then
            CruisedSpeed = GetVehiculeSpeed()
            CruisedSpeedKm = TransformToKm(CruisedSpeed)
          end

          if IsControlJustPressed(2, 72) then
            CruisedSpeed = 0
            exports.pNotify:SendNotification({
							text = "<font color=red size=5><p align=center><b>إلغاء مثبت السرعة",	   
								type = "alert",
								timeout = 5000,
								layout = "centerleft",
								queue = "left",
								killer = true
						})
            Wait(2000)
            break
          end
        end
      end)
    end
  end
end

function IsTurningOrHandBraking ()
  return IsControlPressed(2, 76) or IsControlPressed(2, 63) or IsControlPressed(2, 64)
end

function IsDriving ()
  return IsPedInAnyVehicle(Player, false)
end

function GetVehicle ()
  return GetVehiclePedIsIn(Player, false)
end

function IsInVehicle ()
  return GetPedInVehicleSeat(GetVehicle(), -1)
end

function IsDriver ()
  return GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId()
end

function GetVehiculeSpeed ()
  return GetEntitySpeed(GetVehicle())
end

function TransformToKm (speed)
  return math.floor(speed * 3.6 + 0.5)
end
