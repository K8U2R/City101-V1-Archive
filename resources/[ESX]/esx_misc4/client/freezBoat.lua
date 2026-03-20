-- تثبيت القارب

Citizen.CreateThread(function()
	while true do
		Wait(0)
		local playerPed = PlayerPedId()
		local playerVeh = GetVehiclePedIsIn(playerPed, false)
		local model = GetEntityModel(playerVeh)
		if IsThisModelABoat(model) then
			if IsControlJustPressed(1, 311) then
				local speed = GetEntitySpeed(playerVeh)
				local kmh = (speed * 3.6)
				if kmh <= 8 then
					if not anchored then
							FreezeEntityPosition(playerVeh, true)
							drawTxt(0.4, 'ﺏﺭﺎﻘﻟﺍ ﺔﻛﺮﺣ ﺖﻴﺒﺜﺗ', 0,255,0,255)
					else
						FreezeEntityPosition(playerVeh, false)
						drawTxt(0.4, 'ﺏﺭﺎﻘﻟﺍ ﺔﻛﺮﺣ ﺮﻳﺮﺤﺗ', 255,0,0,255)
					end
					anchored = not anchored
				else
					ESX.ShowNotification('<font color =red>يجب وقوف القارب تمامًا</font>')
				end
			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterFontFile('Font')
local fontId = RegisterFontId('A9eelsh')
local drawTxtCount = 100

function drawTxt(scale, text, r,g,b,a)
	Citizen.CreateThread(function()
		drawTxtCount = 0
		Citizen.Wait(100)
		drawTxtCount = 100
		
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
			DrawText(0.45,0.65)
			
			drawTxtCount = drawTxtCount -1
		end
	end)	
end