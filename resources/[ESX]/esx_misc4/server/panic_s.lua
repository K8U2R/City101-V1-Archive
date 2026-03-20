ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--time, coords, state
local sharedpanic = {
    ['peace_time'] = {
        coords = { x = 401.25, y = 1902.82, z = 167.91, r = 5850.0},
        state = false,
        time = 0,
    },

    ['9eanh_time'] = {
        coords = { x = 401.25, y = 1902.82, z = 167.91, r = 5850.0},
        state = false,
        time = 0,
    },

    ['restart_time'] = {
        coords = { x = 401.25, y = 1902.82, z = 167.91, r = 5850.0},
        state = false,
        time = 0,
    },

    ['area_port'] = {
        coords = { x = 1009.84, y = -3136.89, z = 5.9, r = 370.0},
        state = false,
        port = 1,
        label = 'يﺮﺤﺒﻟﺍ 101 ﺔﻨﻳﺪﻣ ءﺎﻨﻴﻣ',
        name = 'ميناء مدينة 101 البحري'
    },  

    ['bank_los'] = {
        coords = {x = 228.70913696289, y = 213.41168212891, z = 105.51474761963, r = 200.0},
        state = false,
    },

    ['bank_7degh'] = {
        coords = {x = 151.35455322266, y = -1036.1141357422, z = 29.33927154541, r = 200.0},
        state = false,
    },

    ['bank_north_los'] = {
        coords = {x = 315.86590576172, y = -273.97470092773, z = 53.921455383301, r = 200.0},
        state = false,
    },

    ['bank_sandy'] = {
        coords = {x = 1175.1813964844, y = 2701.9978027344, z = 38.172805786133, r = 200.0}, 
        state = false,
    },

    ['bank_sa7l'] = {
        coords = {x = -2968.2219238281, y = 482.95932006836, z = 15.46870136261, r = 200.0},
        state = false,
    },

    ['bank_paleto'] = {
        coords = {x = -112.91865539551, y = 6460.7138671875, z = 31.468463897705, r = 200.0},
        state = false,
    },

    ['garage_los_cars'] = {
        coords = {x = 208.10009765625, y = -1465.6199951172, z = 29.16015625, r = 200.0},
        state = false,
    },

    ['garage_hjz_los_mror'] = {
        coords = {x = 384.69, y = -1634.09, z = 29.29, r = 200.0},
        state = false,
    },

    ['garage_los_trucks'] = {
        coords = {x = 925.71997070312, y = -1564.1099853516, z = 30.872943878174, r = 200.0},
        state = false,
    },

    ['garage_sandy_cars'] = {
        coords = {x = 1727.9499511719, y = 3715.8898925781, z = 34.142578125, r = 200.0},
        state = false,
    },

    ['garage_sandy_trucks'] = {
        coords = {x = 188.8631439209, y = 2786.8696289062, z = 45.587043762207, r = 200.0},
        state = false,
    },

    ['garage_paleto_cars'] = {
        coords = {x = -217.35984802246, y = 6252.4399414062, z = 31.489372253418, r = 200.0},
        state = false,
    },

    ['garage_paleto_trucks'] = {
        coords = {x = -276.27423095703, y = 6045.6762695312, z = 31.588581085205, r = 200.0},
        state = false,
    },

    ['port_one'] = {
        coords = {x = 1009.84, y = -3136.89, z = 5.9, r = 370.0},
        state = false,
    },

    ['port_two'] = {
        coords = {x = -86.65, y = -2547.61, z = 6.01, r = 280.0},
        state = false,
    },

    ['port_tws3h_one'] = {
        coords = {x = 1.0, y = 1.0, z = 1.0, r = 200.0},
        state = false,
    },

    ['port_tws3h_two'] = {
        coords = {x = 1.0, y = 1.0, z = 1.0, r = 200.0},
        state = false,
    },

    ['port_tws3h_three'] = {
        coords = {x = 1.0, y = 1.0, z = 1.0, r = 200.0},
        state = false,
    },

    ['port_tws3h_four'] = {
        coords = {x = 1.0, y = 1.0, z = 1.0, r = 200.0},
        state = false,
    },

    ['public_7degh'] = {
        coords = {x = 191.91207885742, y = -938.83056640625, z = 30.690099716187, r = 200.0},
        state = false,
    },

    ['player_location'] = {
        coords = nil,
        state = false,
    },

    ['help_me_police'] = {
        coords = nil,
        state = false,
    },

    ['help_me_police2'] = {
        coords = nil,
        state = false,
    },

    ['DUBLEXP'] = {
        state = false,
    },
}

function adminControlOnly(name, time__D, value__D)
    local getjobstring = exports.chat:getjobcolor('admin')
    --if xPlayer then
        if name == 'restart_time' then
            if value__D == false and sharedpanic['restart_time'].state == true then
                sharedpanic['restart_time'].state = false
                sharedpanic['restart_time'].time = 0
                TriggerClientEvent('chatMessage', -1, getjobstring,  { 128, 0, 0 }, 'إنتهاء وقت رستارت')
                TriggerClientEvent('esx_misc:removeblip', -1, 'restart_time')
                TriggerClientEvent('InteractSound_CL:PlayOnOne', -1, 'peace', 0.3)
                TriggerClientEvent('JoinTransistion:start', -1)
            elseif value__D == true and sharedpanic['restart_time'].state == false then
                sharedpanic['restart_time'].state = true
                sharedpanic['restart_time'].time = time__D
                TriggerClientEvent('chatMessage', -1, getjobstring,  { 128, 0, 0 }, 'إعلان وقت رستارت')
            else
                -- if value__D == true then
                --     xPlayer.showNotification('<font color=red>وقت رستارت مفعل بالفعل</font>')
                -- else
                --     xPlayer.showNotification('<font color=red>لا يوجد وقت رستارت مفعل</font>')
                -- end
            end
        elseif name == 'peace_time' then
            if value__D == false and sharedpanic['peace_time'].state == true then
                sharedpanic['peace_time'].state = false
                sharedpanic['peace_time'].time = 0
                TriggerClientEvent('chatMessage', -1, getjobstring,  { 128, 0, 128 }, 'إنتهاء وقت الراحة')
                TriggerClientEvent('esx_misc:removeblip', -1, 'peace_time')
                TriggerClientEvent('InteractSound_CL:PlayOnOne', -1, 'peace', 0.3)
                TriggerClientEvent('JoinTransistion:start', -1)
            elseif value__D == true and sharedpanic['peace_time'].state == false then
                sharedpanic['peace_time'].state = true
                sharedpanic['peace_time'].time = time__D
                TriggerClientEvent('chatMessage', -1, getjobstring,  { 128, 0, 128 }, 'إعلان وقت راحة لمدة ^3'..time__D..' دقيقة')
            else
                -- if value__D == true then
                --     xPlayer.showNotification('<font color=red>وقت راحة مفعل بالفعل</font>')
                -- else
                --     xPlayer.showNotification('<font color=red>لا يوجد وقت راحة مفعل</font>')
                -- end
            end
        elseif name == '9eanh_time' then
            if value__D == false and sharedpanic['9eanh_time'].state == true then
                sharedpanic['9eanh_time'].state = false
                sharedpanic['9eanh_time'].time = 0
                TriggerClientEvent('chatMessage', -1, getjobstring,  { 128, 0, 128 }, 'إنتهاء وقت صيانة')
                TriggerClientEvent('esx_misc:removeblip', -1, '9eanh_time')
                TriggerClientEvent('InteractSound_CL:PlayOnOne', -1, 'peace', 0.3)
                TriggerClientEvent('JoinTransistion:start', -1)
            elseif value__D == true and sharedpanic['9eanh_time'].state == false then
                sharedpanic['9eanh_time'].state = true
                sharedpanic['9eanh_time'].time = time__D
                TriggerClientEvent('chatMessage', -1, getjobstring,  { 128, 0, 128 }, 'إعلان وقت صيانة لمدة ^3'..time__D..' دقيقة')
            else
                -- if value__D == true then
                --     xPlayer.showNotification('<font color=red>وقت راحة مفعل بالفعل</font>')
                -- else
                --     xPlayer.showNotification('<font color=red>لا يوجد وقت راحة مفعل</font>')
                -- end
            end
        elseif name == 'DUBLEXP' then
            if sharedpanic['DUBLEXP'].state then
                sharedpanic['DUBLEXP'].state = false
            else
                sharedpanic['DUBLEXP'].state = true
            end
        end
        
        TriggerClientEvent('esx_misc:UpdatePanic', -1, sharedpanic)
    --end
end

Citizen.CreateThread( function()
    while true do
        Citizen.Wait(60000)
        for location, data in pairs(sharedpanic) do
            if sharedpanic[location].time then
                if sharedpanic[location].time > 0 then
                    if sharedpanic[location].time == 1 then
                        adminControlOnly(location, 0, false)
                    end
                    sharedpanic[location].time = sharedpanic[location].time - 1
                    TriggerClientEvent('esx_misc:UpdatePanic', -1, sharedpanic)
                end
            end
        end
    end
end)

Citizen.CreateThread( function()
    while true do
        Citizen.Wait(60000)
        TriggerClientEvent('esx_misc:UpdatePanic', -1, sharedpanic)
        TriggerClientEvent('esx_misc:changeLocations', -1, sharedpanic['area_port'].port)
    end
end)

--Get Shared sharedpanic
RegisterNetEvent('esx_misc:spawned')
AddEventHandler('esx_misc:spawned', function()
	Citizen.Wait(5000)
    TriggerClientEvent('esx_misc:UpdatePanic', -1, sharedpanic)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
        TriggerClientEvent('esx_misc:UpdatePanic', -1, sharedpanic)
	end
end)

--START 

RegisterNetEvent('esx_misc:StartPanic')
AddEventHandler('esx_misc:StartPanic', function(name, label)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local namee = xPlayer.getName()
    local getjobstring = exports.chat:getjobcolor(xPlayer.job.name)
    local plyCoords = xPlayer.getCoords(false)

    if xPlayer then
        if xPlayer.job.name == 'police' or xPlayer.job.name == 'police2' or xPlayer.job.name == 'admin' then
            if sharedpanic[name].state then
                if name == 'player_location' then
                    sharedpanic[name].coords = nil
                end
                sharedpanic[name].state = false
                TriggerClientEvent('esx_misc:removeblip', -1, name)
                TriggerClientEvent('chatMessage', -1, getjobstring..namee,  { 255, 255, 255 }, 'إنتهاء حالة الخطر في ^3'.. label)
            else
                if name == 'player_location' then
                    sharedpanic[name].coords = { x = plyCoords.x, y = plyCoords.y, z = plyCoords.z, r = 200.0}
                end
                sharedpanic[name].state = true
                TriggerClientEvent('chatMessage', -1, getjobstring..namee,  { 255, 255, 255 }, 'استنفار أمني في ^3'.. label .. '^0 الرجاء مغادرة الموقع لتجنب العقوبات')
            end
            
            TriggerClientEvent('esx_misc:UpdatePanic', -1, sharedpanic)
        else
            local Resooonnn = "لقد تم حظرك من المدينة لمحاولة إستخدام ثغرات برمجية .. أحفظ آخر 10 دقائق وتوجه الدعم الفني"
            TriggerEvent('EasyAdmin:banPlayer', src, Resooonnn, 10444633200)
            return false
        end
    end
end)

RegisterNetEvent('esx_misc:StartPanicSSs')
AddEventHandler('esx_misc:StartPanicSSs', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local namee = xPlayer.getName()
    local getjobstring = exports.chat:getjobcolor(xPlayer.job.name)
    local name = ''
    local plyCoords = xPlayer.getCoords(false)

    if xPlayer then
        if xPlayer.job.name == 'police' or xPlayer.job.name == 'police2' or xPlayer.job.name == 'admin' then
            if xPlayer.getJob().name == 'police' then
                name = 'help_me_police'
            elseif xPlayer.getJob().name == 'police2' then
                name = 'help_me_police2'
            end

            if name ~= '' then
                if sharedpanic[name].state then
                    sharedpanic[name].coords = { x = plyCoords.x, y = plyCoords.y, z = plyCoords.z, r = 100.0}
                    sharedpanic[name].state = false
                    TriggerClientEvent('esx_misc:removeblip', -1, name)
                    TriggerClientEvent('chatMessage', -1, getjobstring..namee,  { 255, 255, 255 }, 'إنتهاء حالة نداء إستغاثة ^3')
                else
                    sharedpanic[name].coords = { x = plyCoords.x, y = plyCoords.y, z = plyCoords.z, r = 100.0}
                    sharedpanic[name].state = true
                    TriggerClientEvent('chatMessage', -1, getjobstring..namee,  { 255, 255, 255 }, 'نداء إستغاثة ^3')
                end
            else
                xPlayer.showNotification('<font color=red>حدث خطأ</font>')
            end
            TriggerClientEvent('esx_misc:UpdatePanic', -1, sharedpanic)
        else
            local Resooonnn = "لقد تم حظرك من المدينة لمحاولة إستخدام ثغرات برمجية .. أحفظ آخر 10 دقائق وتوجه الدعم الفني"
            TriggerEvent('EasyAdmin:banPlayer', src, Resooonnn, 10444633200)
            return false
        end
    end
end)

RegisterNetEvent('esx_misc:change_port_off_on:start')
AddEventHandler('esx_misc:change_port_off_on:start', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local namee = xPlayer.getName()
    local getjobstring = exports.chat:getjobcolor(xPlayer.job.name)

    if xPlayer then
        if xPlayer.job.name == 'police' or xPlayer.job.name == 'police2' or xPlayer.job.name == 'admin' then
            if not sharedpanic['area_port'].state then
                sharedpanic['area_port'].state = true
                TriggerClientEvent('chatMessage', -1, getjobstring..namee,  { 255, 255, 255 }, 'تم إعلان إغلاق موقع التصدير ^3'.. sharedpanic['area_port'].name )
            else
                sharedpanic['area_port'].state = false
                TriggerClientEvent('esx_misc:removeblip', -1, 'area_port')
                TriggerClientEvent('chatMessage', -1, getjobstring..namee,  { 255, 255, 255 }, 'تم إعلان إفتتاح موقع التصدير ^3'.. sharedpanic['area_port'].name )
            end
            
            TriggerClientEvent('esx_misc:UpdatePanic', -1, sharedpanic)
        else
            local Resooonnn = "لقد تم حظرك من المدينة لمحاولة إستخدام ثغرات برمجية .. أحفظ آخر 10 دقائق وتوجه الدعم الفني"
            TriggerEvent('EasyAdmin:banPlayer', src, Resooonnn, 10444633200)
            return false
        end
    end
end)

RegisterNetEvent('esx_misc:change_port_location:start')
AddEventHandler('esx_misc:change_port_location:start', function(name)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local namee = xPlayer.getName()
    local getjobstring = exports.chat:getjobcolor(xPlayer.job.name)

    if xPlayer then
        if xPlayer.job.name == 'police' or xPlayer.job.name == 'police2' or xPlayer.job.name == 'admin' then
            if name == 'port_one' then
                sharedpanic['area_port'] = {
                    coords = { x = 1009.84, y = -3136.89, z = 5.9, r = 370.0},
                    state = false,
                    port = 1,
                    label = 'يﺮﺤﺒﻟﺍ 101 ﺔﻨﻳﺪﻣ ءﺎﻨﻴﻣ',
                    name = 'ميناء مدينة 101 البحري'
                }
            elseif name == 'port_two' then
                sharedpanic['area_port'] = {
                    coords = { x = -86.65, y = -2547.61, z = 6.01, r = 280.0},
                    state = false,
                    port = 2,
                    label = 'ﻲﺑﺮﻐﻟﺍ 101 ﺔﻨﻳﺪﻣ ءﺎﻨﻴﻣ',
                    name = 'ميناء مدينة 101 الغربي'
                }
            end
            
            TriggerClientEvent('chatMessage', -1, getjobstring..namee,  { 255, 255, 255 }, 'تم تغيير موقع التصدير إلى ^3'.. sharedpanic['area_port'].name)
            TriggerClientEvent('esx_misc:UpdatePanic', -1, sharedpanic)
            TriggerClientEvent('esx_misc:changeport', -1,  sharedpanic['area_port'].label)
            TriggerClientEvent('esx_misc:changeLocations', -1, sharedpanic['area_port'].port)
        else
            local Resooonnn = "لقد تم حظرك من المدينة لمحاولة إستخدام ثغرات برمجية .. أحفظ آخر 10 دقائق وتوجه الدعم الفني"
            TriggerEvent('EasyAdmin:banPlayer', src, Resooonnn, 10444633200)
            return false
        end
    end
end)

RegisterNetEvent('esx_misc:peacetime_restarttime:start')
AddEventHandler('esx_misc:peacetime_restarttime:start', function(name, time__D, value__D)
    -- local src = source
    -- local xPlayer = ESX.GetPlayerFromId(src)

    local src = source
    --if src ~= 0 or src ~= "" then
        if not exports.EasyAdmin:IsPlayerAdmin(src) then
            local Resooonnn = "لقد تم حظرك من المدينة لمحاولة إستخدام ثغرات برمجية .. أحفظ آخر 10 دقائق وتوجه الدعم الفني"
            TriggerEvent('EasyAdmin:banPlayer', src, Resooonnn, 10444633200)
            return false
        end
    --end

    adminControlOnly(name, time__D, value__D)
end)