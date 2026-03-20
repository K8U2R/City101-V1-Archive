CurrentXP = 0
CurrentRank = 0
Leaderboard = nil
Players = {}
Player = nil
UIActive = true
ESX = nil
Ready = false
local dubleXP = false
local is_store = false
Citizen.CreateThread(function()
    -- Wait for ESX
    while ESX == nil do
        Citizen.Wait(10)
        TriggerEvent("esx:getSharedObject", function(esx)
            ESX = esx
        end)
    end
        
    -- Wait for ESX player
    while not ESX.IsPlayerLoaded() do
        Citizen.Wait(10)
    end

    if not Ready then
        TriggerServerEvent("SystemXpLevel:InitialPlayerServerSide")
    end    
end)	

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    while ESX == nil do Citizen.Wait(0) end
	PlayerData = xPlayer	
end)

------------------------------------------------------------
--                        CONTROLS                        --
------------------------------------------------------------

------------------------------------------------------------
--                        COMMANDS                        --
------------------------------------------------------------
RegisterNetEvent('esx:ESXP')
AddEventHandler('esx:ESXP', function(source, args)
    Citizen.CreateThread(function()
        local xpToNext = ESXP_GetXPToNextRank()

        -- SHOW THE XP BAR
        SendNUIMessage({ xpm_display = true })        

        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = true,
            args = {"SYSTEM", _('cmd_current_xp', CurrentXP)}
        })
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = true,
            args = {"SYSTEM", _('cmd_current_lvl', CurrentRank)}
        })
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = true,
            args = {"SYSTEM", _('cmd_next_lvl', xpToNext, CurrentRank + 1)}
        })                
    end)
end)

TriggerEvent('chat:addSuggestion', '/ESXP', 'Display your XP stats')

RegisterCommand('ESXP', function(source, args)
    Citizen.CreateThread(function()
        local xpToNext = ESXP_GetXPToNextRank()

        -- SHOW THE XP BAR
        SendNUIMessage({ xpm_display = true })        

        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = true,
            args = {"SYSTEM", _('cmd_current_xp', CurrentXP)}
        })
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = true,
            args = {"SYSTEM", _('cmd_current_lvl', CurrentRank)}
        })
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = true,
            args = {"SYSTEM", _('cmd_next_lvl', xpToNext, CurrentRank + 1)}
        })                
    end)
end)


RegisterNetEvent('SystemXpLevel:getRank_cl')
AddEventHandler('SystemXpLevel:getRank_cl', function()
	TriggerServerEvent("SystemXpLevel:SendRank", exports.Roma_xplevel:ESXP_GetRank())
end)

RegisterNetEvent("SystemXpLevel:StoreDoubleXpLevel")
AddEventHandler("SystemXpLevel:StoreDoubleXpLevel", function(what)
    is_store = what
end)

RegisterNetEvent("SystemXpLevel:Promotion_client")
AddEventHandler("SystemXpLevel:Promotion_client", function(duble)
    local src = source
    dubleXP = duble
end)
