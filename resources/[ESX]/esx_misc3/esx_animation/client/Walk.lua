function WalkMenuStart(name)
	if name == "Reset" then
		ResetPedMovementClipset(PlayerPedId())
		TriggerServerEvent('esx_misc3:AddWalkToDataBase', 'reset', x)
		return
	else
		x = table.unpack(DP.Walks[name])
		RequestWalking(x)
		SetPedMovementClipset(PlayerPedId(), x, 0.2)
		RemoveAnimSet(x)
		TriggerServerEvent('esx_misc3:AddWalkToDataBase', 'add', x)
	end	
end

RegisterNetEvent('esx_misc3:addWalkPlayerJoin')
AddEventHandler('esx_misc3:addWalkPlayerJoin', function(name, x)
	if name == "Reset" then
		ResetPedMovementClipset(PlayerPedId()) return
	else
		RequestWalking(x)
		SetPedMovementClipset(PlayerPedId(), x, 0.2)
		RemoveAnimSet(x)
	end	
end)

AddEventHandler('playerSpawned', function()
	Citizen.Wait(7000)
	TriggerServerEvent('esx_misc3:AddWalkToDataBase_server')
end)

function RequestWalking(set)
  RequestAnimSet(set)
  while not HasAnimSetLoaded(set) do
    Citizen.Wait(1)
  end 
end

--[[
function WalksOnCommand(source, args, raw)
  local WalksCommand = ""
  for a in pairsByKeys(DP.Walks) do
    WalksCommand = WalksCommand .. ""..string.lower(a)..", "
  end
  EmoteChatMessage(WalksCommand)
  EmoteChatMessage("To reset do /walk reset")
end

function WalkCommandStart(source, args, raw)
	local name = firstToUpper(args[1])
	
	if name == "Reset" then
		ResetPedMovementClipset(PlayerPedId()) return
	end
	
	local name2 = table.unpack(DP.Walks[name])
	if name2 ~= nil then
		WalkMenuStart(name2)
	else
		EmoteChatMessage("'"..name.."' is not a valid walk")
	end	
end
]]