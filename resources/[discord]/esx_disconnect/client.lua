--client 
disconnect = {}
distance = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100000)
	end
end)

Citizen.CreateThread(function()
    Citizen.Wait(20)
	TriggerServerEvent('esx_disconnect:GetUpdate')
end)

local firstSpawn = true
player = PlayerId()
AddEventHandler("playerSpawned", function()
    if firstSpawn then
        Citizen.Wait(30000)
        SetPlayerControl(player, false, 0)
        firstSpawn = false
        TriggerServerEvent('wesam:SystemXpLevel', "start")
        TriggerServerEvent("esx_disconnect:connect")
        SetPlayerControl(player, true, 0)
        firstSpawn = false
    end
end)

RegisterNetEvent("esx_disconnect:Update")
AddEventHandler("esx_disconnect:Update", function(wesamData)
   disconnect = wesamData
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(2)
	
	local pedcoords = GetEntityCoords(PlayerPedId())
	--------------------------
	if #disconnect > 0 then
	for i=1, #disconnect, 1 do
	if disconnect[i].active then
	distance[i] = GetDistanceBetweenCoords(pedcoords, disconnect[i].coords, false)
	coords = disconnect[i].coords
	if distance[i] < Config.ShowDisconnect then
	DrawText3D(coords.x, coords.y, coords.z +0.5, "~b~"..disconnect[i].name.." ~y~"..disconnect[i].code.." <FONT FACE='A9eelsh'>~r~ﻞﺼﻓ</font>", 0.25)
    DrawMarker(27, coords.x, coords.y, coords.z -0.9, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, false, false, false, false)
	
	end
    end
    end
    end
	--------------------------
	end
end)

function DrawText3D(x, y, z, text, scale) 
  local onScreen, _x, _y = World3dToScreen2d(x, y, z) 
  RegisterFontFile('A9eelsh') 
  fontId = RegisterFontId('A9eelsh') 
  ---------------------
  SetTextFont(fontId) 
  SetTextProportional(1) 
  SetTextEntry("STRING") 
  SetTextCentre(true) 
  SetTextWrap(0.0, 1.0)
  SetTextScale(0.5, 0.5)
  SetTextColour(255, 255, 255, 215) 
  SetTextDropshadow(2, 2, 0, 0, 0)
  SetTextEdge(1, 0, 0, 0, 205)
  SetTextOutline()
  AddTextComponentString(text) 
  DrawText(_x, _y) 
 ---------------------
end