ESX                           = nil
local HasAlreadyEnteredMarker = false
local LastZone
local CurrentAction
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local IsInShopMenu            = false
local Categories              = {}
local Vehicles                = {}
local currentDisplayVehicle
local CurrentVehicleData
local name_car = nil
local no3_car = nil
local plate_car = nil
local name_car_no3 = nil
local isBuy = false
local is_do = false
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(10000)
	if ESX.IsPlayerLoaded() then
		PlayerData = ESX.GetPlayerData()
		RemoveVehicles()
		Citizen.Wait(500)
		LoadSellPlace()
		SpawnVehicles()
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		RemoveVehicles()
		Citizen.Wait(100)
		LoadSellPlace()
		SpawnVehicles()
	end
end)

function getVehicleLabelFromModel(model)
	for k,v in ipairs(Vehicles) do
		if v.model == model then
			return v.name
		end
	end

	return
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer, response)
	ESX.PlayerData = xPlayer
	PlayerData = response
	LoadSellPlace()
	SpawnVehicles()
end)



RegisterNetEvent("esx-qalle-sellvehicles:refreshVehicles")
AddEventHandler("esx-qalle-sellvehicles:refreshVehicles", function()
	RemoveVehicles()
	Citizen.Wait(500)
	SpawnVehicles()
end)

function LoadSellPlace()
	Citizen.CreateThread(function()
		local SellPos = Config.SellPosition
		local Blip = AddBlipForCoord(SellPos["x"], SellPos["y"], SellPos["z"])
		SetBlipSprite (Blip, 523)
		SetBlipDisplay(Blip, 4)
		SetBlipScale  (Blip, 1.0)
		SetBlipColour (Blip, 59)
		SetBlipAsShortRange(Blip, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString("<FONT FACE='A9eelsh'> ﺔﻠﻤﻌﺘﺴﻤﻟﺍ ﺽﺭﺎﻌﻤﻟﺍ </font>")
		EndTextCommandSetBlipName(Blip)
		while true do
			local sleepThread = 0

			local ped = PlayerPedId()
			local pedCoords = GetEntityCoords(ped)
			local dstCheck = GetDistanceBetweenCoords(pedCoords, SellPos["x"], SellPos["y"], SellPos["z"], true)
			local vehentity = GetVehiclePedIsUsing(ped)	
			local explevelreq = Config.VehicleExperience[(string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))]
			
			if dstCheck <= 5.5 then
				sleepThread = 0

				if dstCheck <= 15.5 then
					ESX.Game.Utils.DrawText3D(SellPos, " ~y~[E]~w~ ﻊﻴﺒﻠﻟ ﺔﺒﻛﺮﻤﻟﺍ ﺽﺮﻌﻟ ", 2.5)
					
					DrawMarker(36, Config.SellPosition.x, 6543.97021484375, 31.45000076293945 + 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 255, 196, 0, 50, true, true, 2, nil, nil, true)
					if IsControlJustPressed(0, 38) then
						if IsPedInAnyVehicle(ped, false) then
							OpenSellMenu(GetVehiclePedIsUsing(ped))
						else
							--ESX.ShowNotification("<font color=red> ﻋﻠﻴﻚ ﺍﻟﺠﻠﻮﺱ ﺩﺍﺧﻞ ﺍﻟﻤﺮﻛﺒﺔ")
						end
					end
				end
			end

			for i = 1, #Config.VehiclePositions, 1 do
				if Config.VehiclePositions[i]["entityId"] ~= nil then
					local pedCoords = GetEntityCoords(ped)
					local vehCoords = GetEntityCoords(Config.VehiclePositions[i]["entityId"])

					local dstCheck = GetDistanceBetweenCoords(pedCoords, vehCoords, true)

					if dstCheck <= 2.0 then
						sleepThread = 0

						ESX.Game.Utils.DrawText3D(vehCoords, "~r~"..Config.M3rdName.."~w~: ﺔﻟﺎﺤﻟﺍ ".." <br /><br /> ~g~ $" .. ESX.Math.GroupDigits(Config.VehiclePositions[i]["price"]) .. "~w~ : ﺮﻌﺴﻟﺍ", 0.95)

						if IsControlJustPressed(0, 38) then
							if IsPedInVehicle(ped, Config.VehiclePositions[i]["entityId"], false) then
								OpenSellMenu(Config.VehiclePositions[i]["entityId"], Config.VehiclePositions[i]["price"], true, Config.VehiclePositions[i]["owner"])
							else
								ESX.ShowNotification("<font color=red> ﻋﻠﻴﻚ ﺍﻟﺠﻠﻮﺱ ﺩﺍﺧﻞ ﺍﻟﻤﺮﻛﺒﺔ")
							end
						end
					end
				end
			end

			Citizen.Wait(sleepThread)
		end
	end)
end

function OpenSellMenu(veh, price, buyVehicle, owner, level, levelData)
	local elements = {}
	local mylevel = exports.ESX_SystemXpLevel.ESXP_GetRank()
	local ped = PlayerPedId()
	local vehentity = GetVehiclePedIsUsing(ped)	
	local explevelreq = Config.VehicleExperience[(string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))]

   if GetVehicleMod(vehentity, 11) == -1 then
   statutEngine = '<font color=red> لايوجد تزويد'
   elseif GetVehicleMod(vehentity, 11) == 0 then
   statutEngine = '<font color=orange> مستوى 1'
   elseif GetVehicleMod(vehentity, 11) == 1 then
   statutEngine = '<font color=orange> مستوى 2' 
   elseif GetVehicleMod(vehentity, 11) == 2 then
   statutEngine = '<font color=orange> مستوى 3' 
   elseif GetVehicleMod(vehentity, 11) == 3 then
   statutEngine = '<font color=orange> مستوى 4' 
   end

   if GetVehicleMod(vehentity, 12) == -1 then
   statutBrakes = '<font color=red> لايوجد تزويد'
   elseif GetVehicleMod(vehentity, 12) == 0 then
   statutBrakes = '<font color=orange> مستوى 1'
   elseif GetVehicleMod(vehentity, 12) == 1 then
   statutBrakes = '<font color=orange> مستوى 2' 
   elseif GetVehicleMod(vehentity, 12) == 2 then
   statutBrakes = '<font color=orange> مستوى 3' 
   end
   
    if GetVehicleMod(vehentity, 13) == -1 then
   statutTransmission = '<font color=red> لايوجد تزويد'
   elseif GetVehicleMod(vehentity, 13) == 0 then
   statutTransmission = '<font color=orange> مستوى 1'
   elseif GetVehicleMod(vehentity, 13) == 1 then
   statutTransmission = '<font color=orange> مستوى 2' 
   elseif GetVehicleMod(vehentity, 13) == 2 then
   statutTransmission = '<font color=orange> مستوى 3' 
   end  

   if GetVehicleMod(vehentity, 15) == -1 then
   statutSuspension = '<font color=red> لايوجد تزويد'
   elseif GetVehicleMod(vehentity, 15) == 0 then
   statutSuspension = '<font color=orange> مستوى 1'
   elseif GetVehicleMod(vehentity, 15) == 1 then
   statutSuspension = '<font color=orange> مستوى 2' 
   elseif GetVehicleMod(vehentity, 15) == 2 then
   statutSuspension = '<font color=orange> مستوى 3' 
   elseif GetVehicleMod(vehentity, 15) == 3 then
   statutSuspension = '<font color=orange> مستوى 4' 
   elseif GetVehicleMod(vehentity, 15) == 4 then
   statutSuspension = '<font color=orange> مستوى 5'    
   end
   
    if GetVehicleMod(vehentity, 16) == -1 then
   statutArmor = '<font color=red> لايوجد تزويد'
   elseif GetVehicleMod(vehentity, 16) == 0 then
   statutArmor = '<font color=orange> مستوى 1'
   elseif GetVehicleMod(vehentity, 16) == 1 then
   statutArmor = '<font color=orange> مستوى 2' 
   elseif GetVehicleMod(vehentity, 16) == 2 then
   statutArmor = '<font color=orange> مستوى 3' 
   elseif GetVehicleMod(vehentity, 16) == 3 then
   statutArmor = '<font color=orange> مستوى 4' 
   elseif GetVehicleMod(vehentity, 16) == 4 then
   statutArmor = '<font color=orange> مستوى 5'    
   elseif GetVehicleMod(vehentity, 16) == 5 then
   statutArmor = '<font color=orange> مستوى 6'    
   end  
    
    if IsToggleModOn(vehentity, 18) then
   statutTurbo = '<font color=orange> مثبت'
   else
   statutTurbo = '<font color=red> غير مثبت' 
   end  
    if IsToggleModOn(vehentity, 22) then
   statutXenon = '<font color=orange> مثبت'
   else
   statutXenon = '<font color=red> غير مثبت' 
   end       

   if GetVehicleClass(vehentity) == 0 then
   statutVehicleClass = '<font color=orange> سيدان'
   name_car_no3 = 'سيدان'
   elseif GetVehicleClass(vehentity) == 1 then
   statutVehicleClass = '<font color=orange> سيدان'
   name_car_no3 = 'سيدان'
   elseif GetVehicleClass(vehentity) == 2 then
   statutVehicleClass = '<font color=orange> أس يو في' 
   name_car_no3 = 'أس يو في'
   elseif GetVehicleClass(vehentity) == 3 then
   statutVehicleClass = '<font color=orange> صغير' 
   name_car_no3 = 'صغير'
   elseif GetVehicleClass(vehentity) == 4 then
   statutVehicleClass = '<font color=orange> كلاسيك سبورت'
   name_car_no3 = 'كلاسيك سبورت'
   elseif GetVehicleClass(vehentity) == 5 then
   statutVehicleClass = '<font color=orange>  كلاسيك' 
   name_car_no3 = 'كلاسيك'
   elseif GetVehicleClass(vehentity) == 6 then
   statutVehicleClass = '<font color=orange> سبورت'   
   name_car_no3 = 'سبورت'
   elseif GetVehicleClass(vehentity) == 7 then
   statutVehicleClass = '<font color=orange> سوبر'
   name_car_no3 = 'سوبر'
   elseif GetVehicleClass(vehentity) == 8 then
   statutVehicleClass = '<font color=orange> دراجة نارية'
   name_car_no3 = 'دراجة نارية'
   elseif GetVehicleClass(vehentity) == 9 then
   statutVehicleClass = '<font color=orange> حمولة' 
   name_car_no3 = 'حمولة'
   elseif GetVehicleClass(vehentity) == 12 then
   statutVehicleClass = '<font color=orange> حمولة فان'
   name_car_no3 = 'حمولة فان'
   else
   statutVehicleClass = '<font color=red> غير معروف'  
   name_car_no3 = 'غير معروف'
   end

		if not buyVehicle then
if price ~= nil then
			table.insert(elements, { ["label"] = "<font color=white> ".."تعديل السعر : <font color=green> " .. ESX.Math.GroupDigits(price) .. "$", ["value"] = "price" })
			table.insert(elements, { ["label"] = "<font color=white> عرض المركبة ", ["value"] = "sell" })
	else
			table.insert(elements, { ["label"] = "<font color=white> وضع سعر ", ["value"] = "price" })
	end
	else
		table.insert(elements, { ["label"] = "<font color=white><font color=white> الفئة : "..statutVehicleClass.."<br/><font color=white> الحالة : <font color=red> مستعمل".."<br/><font color=white><font color=white> سعر البيع : <font color=green>" ..ESX.Math.GroupDigits(price).."$ "})
		table.insert(elements, { ["label"] = "<font color=grey> المحرك : " ..statutEngine.."<br /><font color=grey> الفرامل : " ..statutBrakes.."<br /><font color=grey> ناقل الحركة : " ..statutTransmission.."<br /><font color=grey> المعاونات : " ..statutSuspension.."<br /><font color=grey> تعزيز الهيكل : " ..statutArmor.."<br /><font color=grey> التيربو : " ..statutTurbo.."<br /><font color=grey> زنون : " ..statutXenon.."", ["value"] = "" })
		table.insert(elements, { ["label"] = "<font color=green>شراء", ["value"] = "buy" })
if owner then
		table.insert(elements, { ["label"] = "<font color=orange>إزالة المركبة", ["value"] = "remove" })
			end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sell_veh',
		{
			title    = '<b style="color:#fff;font-size:17px;"> معرض :<b style="color:#ea1f1f;font-size:19px;"> السيارات المستعملة',
			align    = 'top-right',
			elements = elements
		},
	function(data, menu)
		local action = data.current.value

		if action == "price" then
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sell_veh_price',
				{
					title = "🚗 معرض السيارات المستعملة"
				},
			function(data2, menu2)
				local is_model_have = false
				local vehProps0 = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
				local vehPrice = tonumber(data2.value)
				vehProps0 = string.lower(vehProps0)
				for i=1, #Config.VehiclesShop1['Cars'].Vehicles, 1 do
					if not is_model_have then
						if Config.VehiclesShop1['Cars'].Vehicles[i].model == vehProps0 then
							is_model_have = true
							local vehPrice_high = tonumber(Config.VehiclesShop1['Cars'].Vehicles[i].price) + tonumber(Config.VehiclesShop1['Cars'].Vehicles[i].price)
							local vehPrice_down = math.floor(tonumber(Config.VehiclesShop1['Cars'].Vehicles[i].price) / 2)
							if vehPrice < vehPrice_down then
								ESX.ShowNotification("لايمكنك عرض المركبة اكثر من <font color=green>$</font>" .. vehPrice_high .. "او اقل من <font color=green>$</font>" .. vehPrice_down)
								vehPrice = 0
								menu2.close()
								menu.close()
							elseif vehPrice > vehPrice_high then
								ESX.ShowNotification("لايمكنك عرض المركبة اكثر من <font color=green>$</font>" .. vehPrice_high .. "او اقل من <font color=green>$</font>" .. vehPrice_down)
								vehPrice = 0
								menu2.close()
								menu.close()
							elseif vehPrice >= vehPrice_down and vehPrice <= vehPrice_high then
								OpenSellMenu(veh, vehPrice)
							end
						else
							menu2.close()
							menu.close()
						end
					end
				end
				menu2.close()
				menu.close()
				if vehPrice >= 5000 and is_model_have then
					OpenSellMenu(veh, vehPrice)
					is_model_have = false
				elseif not is_model_have then
					ESX.ShowNotification('لايمكنك عرض مركبة ليست من معرض الوكالة')
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif action == "sell" then
			local vehProps = ESX.Game.GetVehicleProperties(veh)
			ESX.TriggerServerCallback('esx_sellvehicles:getInfoCar', function(name_car_from)
				name_car = name_car_from
			end, vehProps)
			ESX.TriggerServerCallback("esx-qalle-sellvehicles:isVehicleValid", function(valid, plate)
				if valid then
					DeleteVehicle(veh)
                    TriggerEvent("pNotify:SendNotification", {
                        text = "<font size='5'><center> لقد قمت بعرض المركبة مقابل <font color='green'>"..price.." دولار </font></font></center>",
                        type = "info",
                        timeout = 7000,
                        layout = "centerLeft",
                        queue = "left"
                })					
					menu.close()
				else
                    TriggerEvent("pNotify:SendNotification", {
                        text = "<font size='5'><center> أنت لاتملك المركبة أو هناك <font color='red'>"..#Config.VehiclePositions.." مركبة معروضة </font> مسبقا </font></center>",
                        type = "info",
                        timeout = 7000,
                        layout = "centerLeft",
                        queue = "left"
                })
				end
	
			end, vehProps, price)
		elseif action == "buy" then
			local vehProps = ESX.Game.GetVehicleProperties(veh)
			local level = exports.ESX_SystemXpLevel.ESXP_GetRank()
			local is_model_have_2 = false
			local vehProps2 = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
			vehProps2 = string.lower(vehProps2)
			for i=1, #Config.VehiclesShop1['Cars'].Vehicles, 1 do
				if not is_model_have_2 then
					if Config.VehiclesShop1['Cars'].Vehicles[i].model == vehProps2 then
						is_model_have_2 = true
						explevelreq = Config.VehiclesShop1['Cars'].Vehicles[i].level
					end
				end
			end
			if level < explevelreq then
				ESX.ShowNotification("يجب أن تكون بمستوى <font color='red'>"..explevelreq.."<font color='white'> لشراء المركبة")
			else
				ESX.TriggerServerCallback("esx-qalle-sellvehicles:buyVehicle", function(isPurchasable)
					is_do = true
					if isPurchasable.status then
						DeleteVehicle(veh)
						TriggerEvent("pNotify:SendNotification", {
							text = "<font size='5'><center> لقد إشتريت المركبة مقابل <font color='green'>"..price.." دولار </font></font></center>",
							type = "info",
							timeout = 7000,
							layout = "centerLeft",
							queue = "left"
						})					
						menu.close()
					else		
						ESX.ShowNotification("لا تمتلك المبلغ الكافي لشراء المركبة " .. isPurchasable.money)
					end
					is_do = false
				end, ESX.Game.GetVehicleProperties(veh), price)
			end
		elseif action == "remove" then
			ESX.TriggerServerCallback("esx-qalle-sellvehicles:buyVehicle", function(isPurchasable, totalMoney)
				if isPurchasable.status then
					DeleteVehicle(veh)
                    TriggerEvent("pNotify:SendNotification", {
                        text = "<font size='5'><center> لقد قمت بإزالة المركبة من المعرض ",
                        type = "info",
                        timeout = 5000,
                        layout = "centerLeft",
                        queue = "left"
                })						
					menu.close()
				end
			end, ESX.Game.GetVehicleProperties(veh), 0)
		end
		
	end, function(data, menu)
		menu.close()
	end)
end

function RemoveVehicles()
	local VehPos = Config.VehiclePositions

	for i = 1, #VehPos, 1 do
		local veh, distance = ESX.Game.GetClosestVehicle(VehPos[i])
		if DoesEntityExist(veh) and distance <= 1.0 then
			DeleteEntity(veh)
		end
	end
end

local info_spawn = {coords = nil, number = nil}

function CanSpawnVehicleInPos(Pos, ii)
	if ESX.Game.IsSpawnPointClear(Pos, 5.0) then
		info_spawn.coords = Pos
		info_spawn.number = ii
		return true
	else
		local ii_new = ii + 1
		if ii_new == 20 then
			--print(ii_new)
		else
			CanSpawnVehicleInPos(vector3(Config.VehiclePositions[ii_new]["x"], Config.VehiclePositions[ii_new]["x"], Config.VehiclePositions[ii_new]["z"]), ii_new)
		end
	end
end

function SpawnVehicles()
	local VehPos = Config.VehiclePositions
	ESX.TriggerServerCallback("esx-qalle-sellvehicles:retrieveVehicles", function(vehicles)
		for i = 1, #vehicles, 1 do

			local vehicleProps = vehicles[i]["vehProps"]

			LoadModel(vehicleProps["model"])

			local coords_new = vector3(VehPos[i]["x"], VehPos[i]["y"], VehPos[i]["z"])


			local check_can = CanSpawnVehicleInPos(coords_new, i)

			if check_can then

				VehPos[info_spawn.number]["entityId"] = CreateVehicle(vehicleProps["model"], info_spawn.coords.x, info_spawn.coords.y, info_spawn.coords.z, VehPos[info_spawn.number]["h"], false)
				VehPos[info_spawn.number]["price"] = vehicles[info_spawn.number]["price"]
				VehPos[info_spawn.number]["owner"] = vehicles[info_spawn.number]["owner"]

				ESX.Game.SetVehicleProperties(VehPos[info_spawn.number]["entityId"], vehicleProps)

				FreezeEntityPosition(VehPos[info_spawn.number]["entityId"], true)

				SetEntityAsMissionEntity(VehPos[info_spawn.number]["entityId"], true, true)
				SetModelAsNoLongerNeeded(vehicleProps["model"])

				info_spawn = {coords = nil, number = nil}

			end
		end
	end)

end

LoadModel = function(model)
	while not HasModelLoaded(model) do
		RequestModel(model)

		Citizen.Wait(1)
	end
end
