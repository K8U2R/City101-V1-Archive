xSound = exports.esx_xsound

local musicId
local playing = false
local pos
Citizen.CreateThread(function()
    Citizen.Wait(1000)
    musicId = "music_id_" .. PlayerPedId()
    while true do
        Citizen.Wait(100)
        if xSound:soundExists(musicId) and playing then
            if xSound:isPlaying(musicId) then
                TriggerServerEvent("esx_misc:xsound:playe3dsound", "position", musicId, { position = pos })
            else
                Citizen.Wait(1000)
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

function PlayerPanicSound(position)
    pos = position
    playing = true
    TriggerServerEvent("esx_misc:xsound:playe3dsound", "play", musicId, { position = pos, link = "https://www.youtube.com/watch?v=pLuNy8qfK9Q" })
end

RegisterNetEvent("esx_misc:xsound:playe3dsound")
AddEventHandler("esx_misc:xsound:playe3dsound", function(type, musicId, data)
    if type == "position" then
        if xSound:soundExists(musicId) then
            xSound:Position(musicId, data.position)
            xSound:setVolumeMax(musicId, 0.15)
        end
    end

    if type == "play" then
        xSound:PlayUrlPos(musicId, data.link, 1, data.position)
        xSound:Distance(musicId, 300)
        xSound:setVolumeMax(musicId, 0.15)
    end
end)