ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_ammofill:fillAmmo')
AddEventHandler('esx_ammofill:fillAmmo', function()
  ped = GetPlayerPed(-1)
  if IsPedArmed(ped, 4) then
    hash=GetSelectedPedWeapon(ped)
    if hash~=nil then
      TriggerServerEvent('esx_ammofill:remove')
      AddAmmoToPed(GetPlayerPed(-1), hash,100)
      ESX.ShowNotification('استخدام تعبئة طلقات 100')
    else
      ESX.ShowNotification('لايوجد سلاح بيدك للتعبأة')
    end
  else
    ESX.ShowNotification('<font color=red>لايمكن استخدام التعبئة لهذا السلاح')
  end
end)
