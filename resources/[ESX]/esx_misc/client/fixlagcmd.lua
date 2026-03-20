function fixAllWrongs()
	local playerPed = PlayerPedId()
	ClearPedSecondaryTask(playerPed)
	SetEnableHandcuffs(playerPed, false)
	DisablePlayerFiring(playerPed, false)
	SetPedCanPlayGestureAnims(playerPed, true)
	FreezeEntityPosition(playerPed, false)
	DetachEntity(GetPlayerPed(-1), true, false)
	DisplayRadar(true)
	RemoveLoadingPrompt()
	
	disableAllControlActions = false
	TriggerEvent('esx_atm:closeATM') -- يغلق الصرافة
	TriggerEvent('wesam:esx_animations2:holsterweapon:fix_blocked') -- يصلح مشكلة ركوب السيارة و إخراج السلاح
	TriggerEvent('esx_misc:hidehud', false) -- اذا كان فيه مشكلة في الهود يصلحها
	TriggerEvent('wk:clearScreen') -- رادار الشرطة
	TriggerEvent('esx_headbag:removeBag') -- إزالة الخيشة

	ESX.UI.Menu.CloseAll()
end

--[[ خذ التريقر هذا وحطه بمجلد wk_wars2x اذا كنت تستخدمه، أو غير التريقر للمطلوب
RegisterNetEvent( "wk:clearScreen" )
AddEventHandler( "wk:clearScreen", function()
	SetNuiFocus( false, false )
	SendNUIMessage( { _type = "close" } )
	if ( RADAR:IsMenuOpen() ) then
		RADAR:CloseMenu()
	end
	SYNC:SetRemoteOpenState( false )

end)
-- [[ END ]]--]]

--CreateThread(function()
local count = 0
	
	local function lagCooldown(sec)
		CreateThread(function()
			count = sec
			while count ~= 0 do
				count = count - 1
				Wait(1000)
			end	
			count = 0
		end)	
	end

RegisterCommand('lag', function()
    if count == 0 then 
	fixAllWrongs()
	lagCooldown(5)
	PlaySoundFrontend(source, "OTHER_TEXT", "HUD_AWARDS", true)
	ESX.ShowNotification('في حال عدم حل المشكلة إفصل و ارجع من السيرفر')
	else
	ESX.ShowNotification('<font color=red>يجب الأنتظار.</font> <font color=orange>'..count..' ثانية')
	end
end, false)