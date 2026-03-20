ESX = nil
local availableJobs = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()
    MySQL.Async.fetchAll('SELECT name, label FROM jobs WHERE whitelisted = @whitelisted', {
        ['@whitelisted'] = false
    }, function(result)
        for i=1, #result, 1 do
            table.insert(availableJobs, {
                job = result[i].name,
                label = result[i].label,
                grade   = result[i].grade
            })
        end
    end)
end)

local disroles = {
    ["1214434164661686322"] = {"police", "<span style='color:#34aeeb;'> إدارة الشرطة - جندي", 0},
    ["1214434163109797909"] = {"police", "<span style='color:#34aeeb;'> إدارة الشرطة - جندي اول", 1},
    ["1214434161994235954"] = {"police", "<span style='color:#34aeeb;'> إدارة الشرطة - عريف", 2},
    ["1224144266037694635"] = {"police", "<span style='color:#34aeeb;'> إدارة الشرطة - وكيل رقيب", 3},
    ["1214434160257802283"] = {"police", "<span style='color:#34aeeb;'> إدارة الشرطة - رقيب", 4},
    ["1214434158453981214"] = {"police", "<span style='color:#34aeeb;'> إدارة الشرطة - رقيب اول", 5},
    ["1214434157090836520"] = {"police", "<span style='color:#34aeeb;'> إدارة الشرطة - رئيس رقباء", 6},
    ["1214434154024804402"] = {"police", "<span style='color:#34aeeb;'> إدارة الشرطة - ملازم", 7},
    ["1214434152896536617"] = {"police", "<span style='color:#34aeeb;'> إدارة الشرطة - ملازم اول", 8},
    ["1214434151780843530"] = {"police", "<span style='color:#34aeeb;'> إدارة الشرطة - نقيب", 9},
    ["1214434149981749258"] = {"police", "<span style='color:#34aeeb;'> إدارة الشرطة - رائد", 10},
    ["1214434148614283304"] = {"police", "<span style='color:#34aeeb;'> إدارة الشرطة - مقدم", 11},
    ["1214434147360047184"] = {"police", "<span style='color:#34aeeb;'> إدارة الشرطة - مقدم ركن", 12},
    ["1214434146244624384"] = {"police", "<span style='color:#34aeeb;'> إدارة الشرطة - عقيد", 13},
    ["1214434145070092339"] = {"police", "<span style='color:#34aeeb;'> إدارة الشرطة - عقيد ركن", 14},
    ["1214434143849553920"] = {"police", "<span style='color:#34aeeb;'> إدارة الشرطة - عميد", 15},
    ["1214434142670946374"] = {"police", "<span style='color:#34aeeb;'> إدارة الشرطة - عميد ركن", 16},
    ["1214434141538353182"] = {"police", "<span style='color:#34aeeb;'> إدارة الشرطة - لواء", 17},
    ["1214434140242583632"] = {"police", "<span style='color:#34aeeb;'> إدارة الشرطة - لواء ركن", 18},
    ["1214434138237698059"] = {"police", "<span style='color:#34aeeb;'> إدارة الشرطة - فريق ", 19},
    ["1214434134986989588"] = {"police", "<span style='color:#34aeeb;'> إدارة الشرطة - فريق اول", 20},
    ["1214434117832282162"] = {"police", "<span style='color:#34aeeb;'> إدارة الشرطة - نائب قائد الشرطة", 23},
    ["1214434116502556682"] = {"police", "<span style='color:#34aeeb;'> إدارة الشرطة - قائد الشرطة", 24},

    ["1214434191622541393"] = {"ambulance", "<span style='color:#FF6C00;'>الدفاع المدني - متدرب", 0},
    ["1214434190247075900"] = {"ambulance", "<span style='color:#FF6C00;'>الدفاع المدني - مستوى 1", 1},
    ["1214434188770545665"] = {"ambulance", "<span style='color:#FF6C00;'>الدفاع المدني - مستوى 2", 2},
    ["1214434187889606677"] = {"ambulance", "<span style='color:#FF6C00;'>الدفاع المدني - مستوى 3", 3},
    ["1214434186782576671"] = {"ambulance", "<span style='color:#FF6C00;'>الدفاع المدني - مستوى 4", 4},
    ["1214434185486270514"] = {"ambulance", "<span style='color:#FF6C00;'>الدفاع المدني - مستوى 5", 5},
    ["1214434184177918033"] = {"ambulance", "<span style='color:#FF6C00;'>الدفاع المدني - مستوى 6", 6},
    ["1214434182931939438"] = {"ambulance", "<span style='color:#FF6C00;'>الدفاع المدني - مستوى 7", 7},
    ["1214434181518725141"] = {"ambulance", "<span style='color:#FF6C00;'>الدفاع المدني - مستوى 8", 8},
    ["1214434179945857065"] = {"ambulance", "<span style='color:#FF6C00;'>الدفاع المدني  - مستوى 9", 9},
    ["1214434171678629908"] = {"ambulance", "<span style='color:#FF6C00;'> الدفاع المدني - مستوى 10", 10},
    ["1214434170504482836"] = {"ambulance", "<span style='color:#FF6C00;'>الدفاع المدني  - نائب قائد", 11},
    ["1214434169212506133"] = {"ambulance", "<span style='color:#FF6C00;'>الدفاع المدني  - قائد", 12},

    ["1214434255707316235"] = {"agent", "<span style='color:#3EFF00;'> حرس الحدود - جندي", 0},
    ["1214434254382170164"] = {"agent", "<span style='color:#3EFF00;'> حرس الحدود - جندي اول", 1},
    ["1214434253232939068"] = {"agent", "<span style='color:#3EFF00;'> حرس الحدود - عريف", 2},
    ["1214434252121313290"] = {"agent", "<span style='color:#3EFF00;'> حرس الحدود - وكيل رقيب", 3},
    ["1094780547580035082"] = {"agent", "<span style='color:#3EFF00;'> حرس الحدود - رقيب", 4},
    ["1214434251018342400"] = {"agent", "<span style='color:#3EFF00;'> حرس الحدود - رقيب اول ", 5},
    ["1214434249743138856"] = {"agent", "<span style='color:#3EFF00;'> حرس الحدود - رئيس رقباء", 6},
    ["1214434247222497340"] = {"agent", "<span style='color:#3EFF00;'> حرس الحدود - ملازم", 7},
    ["1214434246022922320"] = {"agent", "<span style='color:#3EFF00;'> حرس الحدود - ملازم اول", 8},
    ["1214434244273635338"] = {"agent", "<span style='color:#3EFF00;'> حرس الحدود - نقيب", 9},
    ["1214434239211110410"] = {"agent", "<span style='color:#3EFF00;'> حرس الحدود - رائد", 10},
    ["1214434237789241386"] = {"agent", "<span style='color:#3EFF00;'> حرس الحدود - مقدم", 11},
    ["1214434236585611294"] = {"agent", "<span style='color:#3EFF00;'> حرس الحدود - عقيد", 12},
    ["1214434235197431868"] = {"agent", "<span style='color:#3EFF00;'> حرس الحدود - عميد", 13},
    ["1214434233976754236"] = {"agent", "<span style='color:#3EFF00;'> حرس الحدود - لواء", 14},
    ["1214434226804359238"] = {"agent", "<span style='color:#3EFF00;'> حرس الحدود - نائب قائد", 15},
    ["1214434224954671104"] = {"agent", "<span style='color:#3EFF00;'> حرس الحدود - قائد حرس الحدود", 16},

    ["1214434221385580594"] = {"mechanic", "<span style='color:gray;'> كراج الميكانيك - متدرب", 0},
    ["1214434220009721866"] = {"mechanic", "<span style='color:gray;'> كراج الميكانيك - مستوى 1", 1},
    ["1214434218805956669"] = {"mechanic", "<span style='color:gray;'> كراج الميكانيك - مستوى 2", 2},
    ["1214434217275170907"] = {"mechanic", "<span style='color:gray;'> كراج الميكانيك - مستوى 3", 3},
    ["1214434215756697640"] = {"mechanic", "<span style='color:gray;'> كراج الميكانيك - مستوى 4", 4},
    ["1214434214532096041"] = {"mechanic", "<span style='color:gray;'> كراج الميكانيك - مستوى 5", 5},
    ["1214434213198045224"] = {"mechanic", "<span style='color:gray;'> كراج الميكانيك - مستوى 6", 6},
    ["1214434211524513813"] = {"mechanic", "<span style='color:gray;'> كراج الميكانيك - مستوى 7", 7},
    ["1214434210547499018"] = {"mechanic", "<span style='color:gray;'> كراج الميكانيك - مستوى 8", 8},
    ["1214434209075171359"] = {"mechanic", "<span style='color:gray;'> كراج الميكانيك - مستوى 9", 9},
    ["1214434206378360873"] = {"mechanic", "<span style='color:gray;'> كراج الميكانيك - مستوى 10", 10},
    ["1214434197461147669"] = {"mechanic", "<span style='color:gray;'> كراج الميكانيك - نائب مدير الكراج", 11},
    ["1214434196118966282"] = {"mechanic", "<span style='color:gray;'> كراج الميكانيك - مدير الكراج", 12},

    ["1214434076698869761"] = {"admin", "<span style='color:gold;'>الرقابة و التفتيش - الدعم الفني", 0},
    ["1214434075541110784"] = {"admin", "<span style='color:gold;'>الرقابة و التفتيش - مشرف", 1},
    ["1214434074500792341"] = {"admin", "<span style='color:gold;'>الرقابة و التفتيش -  مشرف +", 2},
    ["1214434073456410726"] = {"admin", "<span style='color:gold;'>الرقابة و التفتيش - ادمن", 3},
    ["1214434072311373905"] = {"admin", "<span style='color:gold;'>الرقابة و التفتيش - ادمن +", 4},
}

ESX.RegisterServerCallback('esx_joblisting:getJobsList', function(source, cb)
    local src = source
    local disjobs = {}
    for k, v in pairs(availableJobs) do 
        disjobs[k] = v 
    end

    for k, v in pairs(exports['discord_perms'].GetRoles(src, src)) do
        for i, j in pairs(disroles) do 
            if i == v then 
                table.insert(disjobs, {
                    job = j[1],
                    label = j[2],
                    grade = j[3],
                })
                break
            end
        end
    end
    cb(disjobs)
end)

local AdminWebHook = "https://discord.com/api/webhooks/1219066007331541094/s5wJh9oYdK8Wt7VaPhKFJ2n8bNkoHhb5_1k2VIKGHpy3EaRC5K0bbAs0iP0j3EKNdWre" -- سجل تغير وظيفة الرقابة و التفتيش
local PoliceWebHook = "https://discord.com/api/webhooks/1219067223528968293/egeF6c7DW5mTLCKqKYkF1hmnmj-lVTewweS54W9cCTncoSkem4t-A9ahC9keYSleXvaB" -- سجل تغير وظيفة الشرطة
local AgentWebHook = "https://discord.com/api/webhooks/1219067074429714482/gbCA00Etge0-0SszPzqYuAsLD8G9h_tAcBA6V8DYGob-er_V-dMG83caK4sSMFwTpBwd" -- سجل تغير وظيفة حرس الحدود
local AmbulanceWebHook = "https://discord.com/api/webhooks/1219066182045405274/bfelPPpwZ3WtN0dBKD_mFsS7UOxkJbVwwfjZkR_0-Y5mnyLPd47ksrW1wsLtSrNY0cj1" -- سجل تغير وظيفة الدفاع المدني
local MechanicWebHook = "https://discord.com/api/webhooks/1219066612187926599/SUxci2Tg5XCdpmKrzBF4lS0bpj0k0d8u6g0msc5pRzfDKyeq_ykR4lbHbY_3bf6PJZXz" -- سجل تغير وظيفة الميكانيكي
RegisterServerEvent('esx_joblisting:setJob_kaugy36')
AddEventHandler('esx_joblisting:setJob_kaugy36', function(newjob, grade)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not grade then grade = 0 end
    if grade < 0 then grade = 0 end
    if xPlayer then
	if xPlayer.job.name == "admin" then
	xPlayer.setJob(newjob, grade)
	local embeds_admin = {
		{
			["title"]= "تغير وظيفة من وظيفة الرقابة و التفتيش الى وظيفة اخرى",
			["type"]="rich",
            ["description"] = "اللاعب \nname:`"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[5].."`\n الهوية: `"..xPlayer.getName().."`\nقام بتغير وظيفته من وظيفة إدارة الرقابة و التفتيش الى وظيفة أخرى",
			["color"] = "16777215",
			["footer"]=  { ["text"]= "سجل تغير الوظيفة", 
            ["icon_url"] = "https://cdn.discordapp.com/attachments/1094780759950241913/1105667435006263346/c9ea4b4198cd73e9.png"},
		}
	}
	PerformHttpRequest(AdminWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds_admin}), { ['Content-Type'] = 'application/json' })
	elseif xPlayer.job.name == "police" then
	xPlayer.setJob(newjob, grade)
	local embeds_police = {
		{
			["title"]= "تغير وظيفة من وظيفة إدارة الشرطة الى وظيفة اخرى",
			["type"]="rich",
            ["description"] = "اللاعب \nname:`"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[5].."`\n الهوية: `"..xPlayer.getName().."`\nقام بتغير وظيفته من وظيفة إدارة الشرطة الى وظيفة اخرى",
			["color"] = "16777215",
			["footer"]=  { ["text"]= "سجل تغير الوظيفة", 
            ["icon_url"] = "https://cdn.discordapp.com/attachments/1101510296067133511/1105516071672365196/big.png"},
		}
	}
	PerformHttpRequest(PoliceWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds_police}), { ['Content-Type'] = 'application/json' })
	elseif xPlayer.job.name == "agent" then
	xPlayer.setJob(newjob, grade)
	local embeds_agent = {
		{
			["title"]= "تغير وظيفة من وظيفة حرس الحدود الى وظيفة أخرى",
			["type"]="rich",
            ["description"] = "اللاعب \nname:`"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[5].."`\n الهوية: `"..xPlayer.getName().."`\nقام بتغير وظيفته من وظيفة حرس الحدود الى وظيفة أخرى",
			["color"] = "16777215",
			["footer"]=  { ["text"]= "سجل تغير الوظيفة", 
            ["icon_url"] = "https://cdn.discordapp.com/attachments/1101293898921418783/1105246763218120744/images-removebg-preview.png"},
		}
	}
	PerformHttpRequest(AgentWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds_agent}), { ['Content-Type'] = 'application/json' })
	elseif xPlayer.job.name == "ambulance" then
	xPlayer.setJob(newjob, grade)
	local embeds_ambulance = {
		{
			["title"]= "تغير وظيفة من وظيفة الدفاع المدني الى وظيفة أخرى",
			["type"]="rich",
            ["description"] = "اللاعب \nname:`"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[5].."`\n الهوية: `"..xPlayer.getName().."`\nقام بتغير وظيفته من وظيفة الدفاع المدني الى وظيفة أخرى",
			["color"] = "16777215",
			["footer"]=  { ["text"]= "سجل تغير الوظيفة", 
            ["icon_url"] = "https://cdn.discordapp.com/attachments/1101510296067133511/1107624360891658240/5eadf2c883859_0.png"},
		}
	}
	PerformHttpRequest(AmbulanceWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds_ambulance}), { ['Content-Type'] = 'application/json' })
	elseif xPlayer.job.name == "mechanic" then
	xPlayer.setJob(newjob, grade)
	local embeds_mechanic = {
		{
			["title"]= "تغير وظيفة من وظيفة كراج الميكانيكي الى وظيفة أخرى",
			["type"]="rich",
            ["description"] = "اللاعب \nname:`"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[5].."`\n الهوية: `"..xPlayer.getName().."`\nقام بتغير وظيفته من وظيفة كراج الميكانيك الى وظيفة اخرى ",
			["color"] = "16777215",
			["footer"]=  { ["text"]= "سجل تغير الوظيفة", 
            ["icon_url"] = "https://cdn.discordapp.com/attachments/1105165717558530159/1105166854177177660/KG.png"},
		}
	}
	PerformHttpRequest(MechanicWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds_mechanic}), { ['Content-Type'] = 'application/json' })
	else
	xPlayer.setJob(newjob, grade)
    end
    end
end)

RegisterServerEvent('esx_joblisting:setJob_admin_73alhdba762_dkab62dvbeme')
AddEventHandler('esx_joblisting:setJob_admin_73alhdba762_dkab62dvbeme', function(job, grade)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not grade then grade = 0 end
    if grade < 0 then grade = 0 end
    if xPlayer then
	        local embeds = {
		{
			["title"]= "تغير وظيفة الى وظيفة الرقابة و التفتيش",
			["type"]="rich",
            ["description"] = "اللاعب \nname:`"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[5].."`\n الهوية: `"..xPlayer.getName().."`\n من وظيفة: **"..xPlayer.job.label.." - "..xPlayer.job.grade_label.."** \n الى وظيفة: `الرقابة و التفتيش` \n المستوى الوظيفي : "..grade.."",
			["color"] = "2303786",
			["footer"]=  { ["text"]= "سجل تغير الوظيفة", 
            ["icon_url"] = "https://probot.media/X3kaJPpSj7.png"},
		}
	}
	        PerformHttpRequest(AdminWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
			xPlayer.setJob(job, grade)
    end
end)

RegisterServerEvent('esx_joblisting:setJob_police_da3oid63')
AddEventHandler('esx_joblisting:setJob_police_da3oid63', function(job, grade)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not grade then grade = 0 end
    if grade < 0 then grade = 0 end
    if xPlayer then
	        local embeds = {
		{
			["title"]= "تغير وظيفة الى وظيفة إدارة الشرطة",
			["type"]="rich",
            ["description"] = "اللاعب \nname:`"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[5].."`\n الهوية: `"..xPlayer.getName().."`\n من وظيفة: **"..xPlayer.job.label.." - "..xPlayer.job.grade_label.."** \n الى وظيفة: `إدارة الشرطة` \n المستوى الوظيفي : "..grade.."",
			["color"] = "2303786",
			["footer"]=  { ["text"]= "سجل تغير الوظيفة", 
            ["icon_url"] = "https://probot.media/X3kaJPpSj7.png"},
		}
	}
	        PerformHttpRequest(PoliceWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
			xPlayer.setJob(job, grade)
    end
end)

RegisterServerEvent('esx_joblisting:setJob_agent_kaug362')
AddEventHandler('esx_joblisting:setJob_agent_kaug362', function(job, grade)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not grade then grade = 0 end
    if grade < 0 then grade = 0 end
    if xPlayer then
	        local embeds = {
		{
			["title"]= "تغير وظيفة الى وظيفة حرس الحدود",
			["type"]="rich",
            ["description"] = "اللاعب \nname:`"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[5].."`\n الهوية: `"..xPlayer.getName().."`\n من وظيفة: **"..xPlayer.job.label.." - "..xPlayer.job.grade_label.."** \n الى وظيفة: `حرس الحدود` \n المستوى الوظيفي : "..grade.."",
			["color"] = "2303786",
			["footer"]=  { ["text"]= "سجل تغير الوظيفة", 
            ["icon_url"] = "https://probot.media/X3kaJPpSj7.png"},
		}
	}
	        PerformHttpRequest(AgentWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
			xPlayer.setJob(job, grade)
    end
end)

RegisterServerEvent('esx_joblisting:setJob_ambulance_d8labd3')
AddEventHandler('esx_joblisting:setJob_ambulance_d8labd3', function(job, grade)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not grade then grade = 0 end
    if grade < 0 then grade = 0 end
    if xPlayer then
	        local embeds = {
		{
			["title"]= "تغير وظيفة الى وظيفة الدفاع المدني",
			["type"]="rich",
            ["description"] = "اللاعب \nname:`"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[5].."`\n الهوية: `"..xPlayer.getName().."`\n من وظيفة: **"..xPlayer.job.label.." - "..xPlayer.job.grade_label.."** \n الى وظيفة: `الدفاع المدني \n المستوى الوظيفي : "..grade.."",
			["color"] = "2303786",
			["footer"]=  { ["text"]= "سجل تغير الوظيفة", 
            ["icon_url"] = "https://probot.media/X3kaJPpSj7.png"},
		}
	}
	        PerformHttpRequest(AmbulanceWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
			xPlayer.setJob(job, grade)
    end
end)

RegisterServerEvent('esx_joblisting:setJob_mechanic_a73kvgad3')
AddEventHandler('esx_joblisting:setJob_mechanic_a73kvgad3', function(job, grade)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not grade then grade = 0 end
    if grade < 0 then grade = 0 end
    if xPlayer then
	        local embeds = {
		{
			["title"]= "تغير وظيفة الى وظيفة كراج الميكانيك",
			["type"]="rich",
            ["description"] = "اللاعب \nname:`"..GetPlayerName(source).."` | `"..GetPlayerIdentifiers(source)[1].."` | `"..GetPlayerIdentifiers(source)[5].."`\n الهوية: `"..xPlayer.getName().."`\n من وظيفة: **"..xPlayer.job.label.." - "..xPlayer.job.grade_label.."** \n الى وظيفة: `كراج الميكانيك \n المستوى الوظيفي : "..grade.."",
			["color"] = "2303786",
			["footer"]=  { ["text"]= "سجل تغير الوظيفة", 
            ["icon_url"] = "https://probot.media/X3kaJPpSj7.png"},
		}
	}
	        PerformHttpRequest(MechanicWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
			xPlayer.setJob(job, grade)
    end
end)
