 
local MeleeD = { -1569615261, 1737195953, 1317494643, -1786099057, 1141786504, -2067956739, -868994466 }
local KnifeD = { -1716189206, 1223143800, -1955384325, -1833087301, 910830060, }
local BulletD = { 453432689, 1593441988, 584646201, -1716589765, 324215364, 736523883, -270015777, -1074790547, -2084633992, -1357824103, -1660422300, 2144741730, 487013001, 2017895192, -494615257, -1654528753, 100416529, 205991906, 1119849093 }
local AnimalD = { -100946242, 148160082 }
local FallDamageD = { -842959696 }
local ExplosionD = { -1568386805, 1305664598, -1312131151, 375527679, 324506233, 1752584910, -1813897027, 741814745, -37975472, 539292904, 341774354, -1090665087 }
local GasD = { -1600701090 }
local BurnD = { 615608432, 883325847, -544306709 }
local DrownD = { -10959621, 1936677264 }
local CarD = { 133987706, -1553120962 }

function checkArrayDeathCause (array, val)
	for name, value in ipairs(array) do
		if value == val then
			return true
		end
	end

	return false
end

Citizen.CreateThread(function()
	while ESX == nil do
		Citizen.Wait(500)
	end
	
	while true do
		local sleep = 15000

		if not IsPedInAnyVehicle(PlayerPedId()) then
			
			local player, distance = ESX.Game.GetClosestPlayer()

			if distance ~= -1 and distance < 10.0 then

				if distance ~= -1 and distance <= 2.0 then	
					if IsPedDeadOrDying(GetPlayerPed(player)) then
						StartDeathCause(GetPlayerPed(player))
					end
				end

			elseif distance ~= -1 then
				sleep = sleep / 100 * distance 
			end

		end

		Citizen.Wait(sleep)

	end
end)

function StartDeathCause(ped)
	checking = true

	while checking do
		Citizen.Wait(1)

		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(ped))

		local x,y,z = table.unpack(GetEntityCoords(ped))

		if distance < 2.0 then
			DrawText3DeathCause(x,y,z, 'ﺔﺑﺎﺻﻹﺍ ﺐﺒﺳ ﻦﻣ ﻖﻘﺤﺗ [~g~E~s~] ﻂﻐﺿﺍ', 0.4)
			
			if IsControlPressed(0,  Keys['E']) then
				OpenDeathMenu(ped)
			end
		end

		if distance > 7.5 or not IsPedDeadOrDying(ped) then
			checking = false
		end

	end
end

function NotificationDeathCause(x,y,z)
	local timestamp = GetGameTimer()

	while (timestamp + 4500) > GetGameTimer() do
		Citizen.Wait(0)
		DrawText3DeathCause(x, y, z, 'ﺔﺑﺎﺻﻹﺍ ﻥﺎﻜﻣ ﺎﻨﻫ ﺮﻫﺎﻈﻟﺍ', 0.4)
		checking = false
	end
end

function OpenDeathMenu(player)

	loadAnimDictDeathCause('amb@medic@standing@kneel@base')
	loadAnimDictDeathCause('anim@gangops@facility@servers@bodysearch@')

	local elements   = {}

	table.insert(elements, {label = 'تحقق من سبب الإصابة', value = 'deathcause'})
	table.insert(elements, {label = 'تحقق من مكان الإصابة', value = 'damage'})


	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'dead_citizen',
		{
			title    = 'فحص الشخص',
			align    = 'top-right',
			elements = elements,
		},
	function(data, menu)
		local ac = data.current.value

		if ac == 'damage' then

			local bone
			local success = GetPedLastDamageBone(player,bone)

			local success,bone = GetPedLastDamageBone(player)
			if success then
				--print(bone)
				local x,y,z = table.unpack(GetPedBoneCoords(player, bone))
					NotificationDeathCause(x,y,z)
				
			else
				ESX.ShowNotification('<font color=red>لايمكن التعرف على مكان الإصابة')
			end
		end

		if ac == 'deathcause' then
			--gets deathcause
			local d = GetPedCauseOfDeath(player)		
			local playerPed = PlayerPedId()

			--starts animation

			TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
			TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )

			Citizen.Wait(5000)

			--exits animation			

			ClearPedTasksImmediately(playerPed)

			if checkArrayDeathCause(MeleeD, d) then
				ESX.ShowNotification('احتمال تعرض الشخص لضربة قوية على الرأس')
			elseif checkArrayDeathCause(BulletD, d) then
				ESX.ShowNotification('احتمال اصابة برصاصة, يوجد اثر طلق في الجسم واحتمال الاصابة قاتلة ولا مجال للشفاء')
			elseif checkArrayDeathCause(KnifeD, d) then
				ESX.ShowNotification('يوجد اثر جروح بآلة حادة مثل السكين')
			elseif checkArrayDeathCause(AnimalD, d) then
				ESX.ShowNotification('يوجد اثر عض او جروح بسبب حيوان مفترس')
			elseif checkArrayDeathCause(FallDamageD, d) then
				ESX.ShowNotification('احتمال سقوط من مكان مرتفع, يوجد كسر في الرجل او الرجلين احتمال الشفاء ضعيف جدا')
			elseif checkArrayDeathCause(ExplosionD, d) then
				ESX.ShowNotification('الشخص متوفي بسبب تعرضه لانفجار ولا مجال للشفاء')
			elseif checkArrayDeathCause(GasD, d) then
				ESX.ShowNotification('تعرض الشخص للاختناق بسبب استنشاق غاز سام او غاز خانق')
			elseif checkArrayDeathCause(BurnD, d) then
				ESX.ShowNotification('احتمال اغمى عليه بسبب استنشاق غاز من مطفأة حريق')
			elseif checkArrayDeathCause(DrownD, d) then
				ESX.ShowNotification('تعرض الشخص لحروق خطيرة')
			elseif checkArrayDeathCause(CarD, d) then
				ESX.ShowNotification('تعرض الشخص لحادث مروري')
			else
				ESX.ShowNotification('سبب الإصابة غير واضح')
			end
		end


	end,
	function(data, menu)
		menu.close()
	end
	)
end

function loadAnimDictDeathCause(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		
		Citizen.Wait(1)
	end
end

function DrawText3DeathCause(x, y, z, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 215)

	AddTextComponentString("<FONT FACE='A9eelsh'>"..text)
	DrawText(_x, _y)

end