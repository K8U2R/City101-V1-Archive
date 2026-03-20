ESX = nil

PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(10)

        TriggerEvent("esx:getSharedObject", function(response)
            ESX = response
        end)
    end

    if ESX.IsPlayerLoaded() then
		PlayerData = ESX.GetPlayerData()

		RemoveVehicles()
		RemoveVehicles()		

		Citizen.Wait(700)

		LoadSellPlace()

		SpawnVehicles()
    end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(response)
	PlayerData = response
	
	LoadSellPlace()

	SpawnVehicles()
end)

RegisterNetEvent("esx-qalle-selltrucks:refreshVehicles")
AddEventHandler("esx-qalle-selltrucks:refreshVehicles", function()
	RemoveVehicles()
	RemoveVehicles()	

	Citizen.Wait(700)

	SpawnVehicles()
end)

function LoadSellPlace()
	Citizen.CreateThread(function()

		local SellPos = Config.SellPosition

		local Blip = AddBlipForCoord(SellPos["x"], SellPos["y"], SellPos["z"])
		SetBlipSprite (Blip, 67)
		SetBlipDisplay(Blip, 4)
		SetBlipScale  (Blip, 0.8)
		SetBlipColour (Blip, 59)
		SetBlipAsShortRange(Blip, true)
        fontId = RegisterFontId('A9eelsh')
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString("<FONT FACE='A9eelsh'>ﺔﻠﻤﻌﺘﺴﻣ ﺕﺎﻨﺣﺎﺷ</font>")
		EndTextCommandSetBlipName(Blip)

		while true do
			local sleepThread = 0

			local ped = PlayerPedId()
			local pedCoords = GetEntityCoords(ped)

			local dstCheck = GetDistanceBetweenCoords(pedCoords, SellPos["x"], SellPos["y"], SellPos["z"], true)

			if dstCheck <= 25.0 then
				sleepThread = 0

				if dstCheck <= 22.2 then
					DrawMarker(39, SellPos["x"], SellPos["y"], SellPos["z"]-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 249, 104, 19, 130, false, true, 2, true, false, false, false)  
                end	

				if dstCheck <= 4.2 then
					DisplayHelpText('<FONT FACE="A9eelsh">ﻊﻴﺒﻠﻟ ﺔﻨﺣﺎﺸﻟﺍ ﺽﺮﻌﻟ ~y~E~w~ ﻂﻐﺿﺍ')	
					if IsControlJustPressed(0, 38) then
					    if checkRequiredXPlevel(Config.Minimun) then
							local msg = '<font size=5 color=white>جاري التنفيذ'
							TriggerEvent('pogressBar:drawBar', 2000, msg)
							Citizen.Wait(2000)					
							if IsPedInAnyVehicle(ped, false) then
								OpenSellMenu(GetVehiclePedIsUsing(ped))
							else
								ESX.ShowNotification("عليك الجلوس داخل الشاحنة")
							end
						else
							TriggerEvent("pNotify:SendNotification", {
								text = "<font size='5'><center> المستوى الأدنى المطلوب <font color='red'>"..Config.Minimun.."</font> لإستخدام المعرض </font></center>",
								type = "alert",
								timeout = 7000,
								layout = "centerLeft",
								queue = "left"})
						end						
					end
				end
            end
			for i = 1, #Config.VehiclePositions, 1 do
				if Config.VehiclePositions[i]["entityId"] ~= nil then
					local pedCoords = GetEntityCoords(ped)
					local vehCoords = GetEntityCoords(Config.VehiclePositions[i]["entityId"])

					local dstCheck = GetDistanceBetweenCoords(pedCoords, vehCoords, true)

					if dstCheck <= 2.5 then
						sleepThread = 0
						DrawText3D2(vehCoords," ﻡﺎﻋ ﺕﺎﻨﺣﺎﺷ ﺽﺮﻌﻣ", 1.05)
						DrawText3D(vehCoords, "~r~"..Config.M3rdName.."~w~: ﺔﻟﺎﺤﻟﺍ".." <br /><br /> ~g~ $" .. ESX.Math.GroupDigits(Config.VehiclePositions[i]["price"]) .. "~w~ : ﺮﻌﺴﻟﺍ", 0.95)
						
						if IsControlJustPressed(0, 38) then
							if IsPedInVehicle(ped, Config.VehiclePositions[i]["entityId"], false) then
								OpenSellMenu(Config.VehiclePositions[i]["entityId"], Config.VehiclePositions[i]["price"], Config.VehiclePositions[i]["info"], true, Config.VehiclePositions[i]["owner"], Config.VehiclePositions[i]["priceold"], Config.VehiclePositions[i]["name"], Config.VehiclePositions[i]["levelold"])
							else
								ESX.ShowNotification("عليك الجلوس داخل الشاحنة")
							end
						end
					end
				end
			end

			Citizen.Wait(sleepThread)
		end
	end)
end

DrawText3D = function(coords, text, size)
	coords = vector3(coords.x, coords.y, coords.z+1.2)

	local camCoords = GetGameplayCamCoords()
	local distance = #(coords - camCoords)

	if not size then size = 1 end

	local scale = (size / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	scale = scale * fov

	SetTextScale(0.0 * scale, 0.55 * scale)
	fontId = RegisterFontId('A9eelsh')
    SetTextFont(fontId)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	SetDrawOrigin(coords, 0)
	BeginTextCommandDisplayText('STRING')
	AddTextComponentString(text)
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
end

DrawText3D2 = function(coords, text, size)
	coords = vector3(coords.x, coords.y, coords.z+1.4)

	local camCoords = GetGameplayCamCoords()
	local distance = #(coords - camCoords)

	if not size then size = 1 end

	local scale = (size / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	scale = scale * fov

	SetTextScale(0.0 * scale, 0.55 * scale)
	fontId = RegisterFontId('A9eelsh')
    SetTextFont(fontId)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	SetDrawOrigin(coords, 0)
	BeginTextCommandDisplayText('STRING')
	AddTextComponentString(text)
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function checkRequiredXPlevel(required)
	if exports.ESX_SystemXpLevel.ESXP_GetRank() >= required then
		return true
	else
		return false
	end
end

function OpenSellMenu(veh, price, info, buyVehicle, owner, priceold, name, levelold)
	local elements = {}
	local ped = PlayerPedId()
	local vehentity = GetVehiclePedIsUsing(ped)	

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
   statutVehicleClass = '<font color=orange> كومباكت كارز'
   elseif GetVehicleClass(vehentity) == 1 then
   statutVehicleClass = '<font color=orange> سيدان'
   elseif GetVehicleClass(vehentity) == 2 then
   statutVehicleClass = '<font color=orange> أس يو في' 
   elseif GetVehicleClass(vehentity) == 3 then
   statutVehicleClass = '<font color=orange> كوبيه' 
   elseif GetVehicleClass(vehentity) == 4 then
   statutVehicleClass = '<font color=orange> ماسال كارز'    
   elseif GetVehicleClass(vehentity) == 5 then
   statutVehicleClass = '<font color=orange> سبورت كلاسيك' 
   elseif GetVehicleClass(vehentity) == 6 then
   statutVehicleClass = '<font color=orange> سبورت'   
   elseif GetVehicleClass(vehentity) == 7 then
   statutVehicleClass = '<font color=orange> سوبر'
   elseif GetVehicleClass(vehentity) == 8 then
   statutVehicleClass = '<font color=orange> موتور سيكل'
   elseif GetVehicleClass(vehentity) == 9 then
   statutVehicleClass = '<font color=orange> أوفرود' 
   elseif GetVehicleClass(vehentity) == 10 then
   statutVehicleClass = '<font color=orange> مركبة عمل'  
   elseif GetVehicleClass(vehentity) == 11 then
   statutVehicleClass = '<font color=orange> مركبات خدماتية'
   elseif GetVehicleClass(vehentity) == 20 then
   statutVehicleClass = '<font color=orange> مركبات تجارية' 
   elseif GetVehicleClass(vehentity) == 17 then
   statutVehicleClass = '<font color=orange> مركبات خدماتية'  
   elseif GetVehicleClass(vehentity) == 21 then
   statutVehicleClass = '<font color=orange> مقطورات'  
   elseif GetVehicleClass(vehentity) == 12 then
   statutVehicleClass = '<font color=orange> فان'
   else
   statutVehicleClass = '<font color=orange> غير معروف'  
   end  

	if not buyVehicle then
		if price ~= nil then
			table.insert(elements, { ["label"] = "<font color=white> ".."تعديل السعر : <font color=green> " .. ESX.Math.GroupDigits(price) .. "$", ["value"] = "price" })
			table.insert(elements, { ["label"] = "<font color=white> عرض المركبة ", ["value"] = "sell" })
		else
			table.insert(elements, { ["label"] = "<font color=white>وضع السعر", ["value"] = "price" })
		end
	elseif checkRequiredXPlevel(levelold) and not owner then
	    table.insert(elements, { ["label"] = "<font color=white> الإسم : <font color=orange>"..name.."<br /><font color=white> الفئة : "..statutVehicleClass.."<br /><font color=white> الحالة : <font color=red> مستعمل".."<br /><font color=white> سعر المركبة جديد : <font color=orange>"..priceold.."$ ".."<br /><font color=white> المستوى المطلوب : <font color=orange>"..levelold.."<br /><font color=white> سعر البيع : <font color=green>" ..ESX.Math.GroupDigits(price).."$ ".."<br /><font color=white> الوصف : <font color=orange>" ..info, ["value"] = "" })
		table.insert(elements, { ["label"] = "<font color=grey> المحرك : " ..statutEngine.."<br /><font color=grey> الفرامل : " ..statutBrakes.."<br /><font color=grey> ناقل الحركة : " ..statutTransmission.."<br /><font color=grey> المعاونات : " ..statutSuspension.."<br /><font color=grey> تعزيز الهيكل : " ..statutArmor.."<br /><font color=grey> التيربو : " ..statutTurbo.."<br /><font color=grey> زنون : " ..statutXenon.."", ["value"] = "" })
		table.insert(elements, { ["label"] = "<font color=green>شراء", ["value"] = "buy" })	
	elseif owner and checkRequiredXPlevel(levelold) then
	    table.insert(elements, { ["label"] = "<font color=white> الإسم : <font color=orange>"..name.."<br /><font color=white> الفئة : "..statutVehicleClass.."<br /><font color=white> الحالة : <font color=red> مستعمل".."<br /><font color=white> سعر المركبة جديد : <font color=orange>"..priceold.."$ ".."<br /><font color=white> المستوى المطلوب : <font color=orange>"..levelold.."<br /><font color=white> سعر البيع : <font color=green>" ..ESX.Math.GroupDigits(price).."$ ".."<br /><font color=white> الوصف : <font color=orange>" ..info, ["value"] = "" })
		table.insert(elements, { ["label"] = "<font color=grey> المحرك : " ..statutEngine.."<br /><font color=grey> الفرامل : " ..statutBrakes.."<br /><font color=grey> ناقل الحركة : " ..statutTransmission.."<br /><font color=grey> المعاونات : " ..statutSuspension.."<br /><font color=grey> تعزيز الهيكل : " ..statutArmor.."<br /><font color=grey> التيربو : " ..statutTurbo.."<br /><font color=grey> زنون : " ..statutXenon.."", ["value"] = "" })
		table.insert(elements, { ["label"] = "<font color=green>شراء", ["value"] = "buy" })			
		table.insert(elements, { ["label"] = "<font color=orange>إزالة المركبة", ["value"] = "remove" })
	elseif owner then
	    table.insert(elements, { ["label"] = "<font color=white> الإسم : <font color=orange>"..name.."<br /><font color=white> الفئة : "..statutVehicleClass.."<br /><font color=white> الحالة : <font color=red> مستعمل".."<br /><font color=white> سعر المركبة جديد : <font color=orange>"..priceold.."$ ".."<br /><font color=white> المستوى المطلوب : <font color=orange>"..levelold.."<br /><font color=white> سعر البيع : <font color=green>" ..ESX.Math.GroupDigits(price).."$ ".."<br /><font color=white> الوصف : <font color=orange>" ..info, ["value"] = "" })
		table.insert(elements, { ["label"] = "<font color=grey> المحرك : " ..statutEngine.."<br /><font color=grey> الفرامل : " ..statutBrakes.."<br /><font color=grey> ناقل الحركة : " ..statutTransmission.."<br /><font color=grey> المعاونات : " ..statutSuspension.."<br /><font color=grey> تعزيز الهيكل : " ..statutArmor.."<br /><font color=grey> التيربو : " ..statutTurbo.."<br /><font color=grey> زنون : " ..statutXenon.."", ["value"] = "" })		
		table.insert(elements, { ["label"] = "<font color=orange>إزالة المركبة", ["value"] = "remove" })			
	else
	    table.insert(elements, { ["label"] = "<font color=white> الإسم : <font color=orange>"..name.."<br /><font color=white> الفئة : "..statutVehicleClass.."<br /><font color=white> الحالة : <font color=red> مستعمل".."<br /><font color=white> سعر المركبة جديد : <font color=orange>"..priceold.."$ ".."<br /><font color=white> المستوى المطلوب : <font color=orange>"..levelold.."<br /><font color=white> سعر البيع : <font color=green>" ..ESX.Math.GroupDigits(price).."$ ".."<br /><font color=white> الوصف : <font color=orange>" ..info, ["value"] = "" })
		table.insert(elements, { ["label"] = "<font color=grey> المحرك : " ..statutEngine.."<br /><font color=grey> الفرامل : " ..statutBrakes.."<br /><font color=grey> ناقل الحركة : " ..statutTransmission.."<br /><font color=grey> المعاونات : " ..statutSuspension.."<br /><font color=grey> تعزيز الهيكل : " ..statutArmor.."<br /><font color=grey> التيربو : " ..statutTurbo.."<br /><font color=grey> زنون : " ..statutXenon.."", ["value"] = "" })

	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sell_veh',
		{
			title    = '<b style="color:#fff;font-size:17px;"> معرض :<b style="color:#ea1f1f;font-size:19px;"> الشاحنات',
			align    = 'bottom-right',
			elements = elements
		},
	function(data, menu)
		local action = data.current.value

		if action == "price" then
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sell_veh_price',
				{
					title = "🚗 معرض الشاحنات"
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
							if vehPrice < Config.VehiclesShop1['Cars'].Vehicles[i].price then
								ESX.ShowNotification("لايمكنك عرض سعر الشاحنة اقل من سعر الشاحنة في المعرض الاصلي | سعر الشاحنة الأصلي <font color='yellow'>"..Config.VehiclesShop1['Cars'].Vehicles[i].price)
								vehPrice = 0
								menu2.close()
								menu.close()
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
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sell_truck_info', {
						title = 'الوصف'
					}, function(data3, menu3)
						local vehInfo = data3.value
						menu3.close()
						OpenSellMenu(veh, vehPrice, vehInfo)
					end, function(data3, menu3)
						menu3.close()
					end)
					is_model_have = false
				elseif not is_model_have then
					ESX.ShowNotification('لايمكنك عرض مركبة ليست من معرض الوكالة')
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif action == "sell" then
			print(info)
			local vehProps = ESX.Game.GetVehicleProperties(veh)
	        local Vehicle = GetEntityModel(veh)
			ESX.TriggerServerCallback("esx-qalle-selltrucks:isVehicleValid", function(valid)

				if valid then
					DeleteVehicle(veh)
                    TriggerEvent("pNotify:SendNotification", {
                        text = "<font size='4'><center> لقد قمت بعرض المركبة مقابل <font color='green'>"..price.." دولار </font></font></center>",
                        type = "alert",
                        timeout = 7000,
                        layout = "centerLeft",
                        queue = "left"
                	})					
					menu.close()
				else
                    TriggerEvent("pNotify:SendNotification", {
                        text = "<font size='4'><center> أنت لاتملك المركبة أو هناك <font color='red'>"..#Config.VehiclePositions.." مركبة معروضة </font> مسبقا </font></center>",
                        type = "alert",
                        timeout = 7000,
                        layout = "centerLeft",
                        queue = "left"
                	})
				end
	
			end, vehProps, price, info)
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
				ESX.TriggerServerCallback("esx-qalle-selltrucks:buyVehicle", function(isPurchasable, totalMoney)
					if isPurchasable then
						DeleteVehicle(veh)
						TriggerEvent("pNotify:SendNotification", {
							text = "<font size='4'><center> لقد إشتريت المركبة مقابل <font color='green'>"..price.." دولار </font></font></center>",
							type = "alert",
							timeout = 7000,
							layout = "centerLeft",
							queue = "left"
						})					
						menu.close()
					else		
						ESX.ShowNotification("لاتمتلك المبلغ الكافي في (البنك)")
					end
				end, ESX.Game.GetVehicleProperties(veh), price, info)
			end
		elseif action == "remove" then
			ESX.TriggerServerCallback("esx-qalle-selltrucks:buyVehicle", function(isPurchasable, totalMoney)
				if isPurchasable then
					DeleteVehicle(veh)
                    TriggerEvent("pNotify:SendNotification", {
                        text = "<font size='4'><center> لقد قمت بإزالة المركبة من المعرض ",
                        type = "alert",
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

function SpawnVehicles()
	local VehPos = Config.VehiclePositions

	ESX.TriggerServerCallback("esx-qalle-selltrucks:retrieveVehicles", function(vehicles)
		for i = 1, #vehicles, 1 do

			local vehicleProps = vehicles[i]["vehProps"]

			LoadModel(vehicleProps["model"])

	     	VehPos[i]["entityId"] = CreateVehicle(vehicleProps["model"], VehPos[i]["x"], VehPos[i]["y"], VehPos[i]["z"] - 0.975, VehPos[i]["h"], false)
			VehPos[i]["price"] = vehicles[i]["price"]
			VehPos[i]["priceold"] = vehicles[i]["priceold"]
			VehPos[i]["name"] = vehicles[i]["name"]
			VehPos[i]["levelold"] = vehicles[i]["levelold"]
			VehPos[i]["info"] = vehicles[i]["info"]
			VehPos[i]["owner"] = vehicles[i]["owner"]

			ESX.Game.SetVehicleProperties(VehPos[i]["entityId"], vehicleProps)

			FreezeEntityPosition(VehPos[i]["entityId"], true)
			SetEntityAsMissionEntity(VehPos[i]["entityId"], true, true)
			SetModelAsNoLongerNeeded(vehicleProps["model"])
		end
	end)


end

LoadModel = function(model)
	while not HasModelLoaded(model) do
		RequestModel(model)

		Citizen.Wait(1)
	end
end
