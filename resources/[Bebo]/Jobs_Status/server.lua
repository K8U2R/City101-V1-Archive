ESX = exports['es_extended']:getSharedObject()



Citizen.CreateThread(function()
    while true do
	if Config.MessageId ~= nil and Config.MessageId ~= '' then
		Players()
	else
		DeployStatusMessage()
		break
	end

	Citizen.Wait(Config.UpdateTime)
    end
end)


function DeployStatusMessage()
	local footer = nil
	if Config.Use24hClock then
		footer = os.date('Date: %d/%m/%Y  |  Hour: %H:%M')
	else
		footer = os.date('Date: %d/%m/%Y  |  Hour: %I:%M %p')
	end

	if Config.Debug then
		print('Deplying Status Message ['..footer..']')
	end

	local embed = {
		{
			["color"] = 10622624,
			["title"] = "**معلومه مهمه**",
			["description"] = 'انسخ ايدي الرسالة وحطه بالكونفق ورست السكربت',
			["footer"] = {
				["text"] = footer,
			},
		}
	}

	PerformHttpRequest(Config.JobsWebhook, function(err, text, headers) end, 'POST', json.encode({
		embeds = embed, 
	}), { ['Content-Type'] = 'application/json' })
end



function Players()
	local footer = nil
	local xPlayers = ESX.GetPlayers()
	local players = GetNumPlayerIndices()
	local maxplayers = GetConvarInt('sv_maxclients', 0)
	police = 0
	policeINservice = 0
	agent = 0
	agentINservice = 0
	medic = 0
	medicINservice = 0
	staffs = 0
	mechanic = 0
	mechanicINservice = 0
	mechanic1 = 0
	mechanic1INservice = 0
	slaughterer = 0
	slaughtererINservice = 0
	lumberjack = 0
	fisherman = 0
	tailor = 0
	fueler = 0
	miner = 0
	farmer = 0
	taxi = 0
	reporter = 0
	none = 0
	unemployed = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == Config.Job1 then
			police = police + 1
		end
		if xPlayer.job.name == Config.Job2 then
			medic = medic + 1
		end
		if xPlayer.job.name == Config.Job3 then
			mechanic = mechanic + 1
		end	
		if xPlayer.job.name == Config.Job4 then
			slaughterer = slaughterer + 1
		end
		if xPlayer.job.name == Config.Job5 then
			unemployed = unemployed + 1
		end
		if xPlayer.job.name == Config.Job6 then
			mechanic1 = mechanic1 + 1
		end		 	
		if xPlayer.job.name == Config.Job7 then
			lumberjack = lumberjack + 1
		end
		if xPlayer.job.name == Config.Job8 then
			fisherman = fisherman + 1
		end
		if xPlayer.job.name == Config.Job9 then
			tailor = tailor + 1
		end
		if xPlayer.job.name == Config.Job10 then
			fueler = fueler + 1
		end
		if xPlayer.job.name == Config.Job11 then
			miner = miner + 1
		end
		if xPlayer.job.name == Config.Job12 then
			farmer = farmer + 1
		end
		if xPlayer.job.name == Config.Job13 then
			taxi = taxi + 1
		end
		if xPlayer.job.name == Config.Job14 then
			reporter = reporter + 1
		end		
		if xPlayer.job.name == Config.Job15 then
			agent = agent + 1
		end		
        if xPlayer.getGroup() ~= "user" then
			staffs = staffs + 1
		end	
	end
	if Config.Use24hClock then
		footer = os.date('%I:%M %Y-%d-%m مركز التوظيف ')
	else   
		footer = os.date('%d/%m/%Y %I:%M %p مركز التوظيف ')
	end

	if Config.Debug then
		print('Updating Status Message ['..footer..']')
	end

	policeINservice = exports.esx_service:GetInServiceCount('police')
	agentINservice = exports.esx_service:GetInServiceCount('agent')
	 mechanicINservice = exports.esx_service:GetInServiceCount('ambulance')
	 mechanicINservice2 = exports.esx_service:GetInServiceCount('slaughterer')	
	local message = json.encode({
		embeds = {
			{
				["username"] = "الحالة العامة لجميع الوظائف", 
				["avatar_url"]= "https://cdn.discordapp.com/attachments/1214451372133715978/1218658614231826432/logo.png?ex=66087747&is=65f60247&hm=a45febad8f76f76fffb3e60a2742d755696a7de120b22e5cde57ec1c9eb22812&", 
				["color"] = 2763306, 
				["title"] = '**الحالة العامة لجميع الوظائف**',
			    ["fields"] = {
					{
					["name"]= "["..police.."] إدارة الشرطة👮 " ,
					["value"]= "داخل الوظيفة : " ..policeINservice.."\n خارج الوظيفة : "..outService(police, policeINservice).. "" ,
					["inline"]= true,
					},			
					{
						["name"]= "["..agent.."]  حرس الحدود 🕴 " ,
						["value"]= "داخل الوظيفة : " ..agentINservice.."\n خارج الوظيفة : "..outService(agent, agentINservice).. "" ,
						["inline"]= true,
					},		
					{
						["name"]= "["..mechanic.."] الدفاع المدني 🚨",
						["value"]= "داخل الوظيفة : " ..mechanicINservice.."\n خارج الوظيفة : "..outService(mechanic, mechanicINservice).. "" ,
						["inline"]= true,
					},
					{
						["name"]= "["..mechanic1.."] كراج ميكانيكي🔧",
						["value"]= "داخل الوظيفة : " ..mechanic1INservice.."\n خارج الوظيفة : "..outService(mechanic1, mechanic1INservice).. "" ,
						["inline"]= true,
					},
					{
						["name"]= "["..slaughterer.."] الدواجن🐓",
					    ["value"]= "داخل الوظيفة : " ..slaughterer.."" ,
						["inline"]= true,
					},
                    {					
						["name"]= "["..lumberjack.."] الأخشاب🌲",
						["value"]= "داخل الوظيفة : " ..lumberjack.."" ,
						["inline"]= true,
					},
					{
						["name"]= "["..fisherman.."] الأسماك🐟",
						["value"]= "داخل الوظيفة : " ..fisherman.."" ,
						["inline"]= true,
					},
					{
						["name"]= "["..tailor.."] الأقمشة👚",
						["value"]= "داخل الوظيفة : " ..tailor.. "" ,
						["inline"]= true,
					},
					{
						["name"]= "["..fueler.."] النفط والغاز⛽️",
						["value"]= "داخل الوظيفة : " ..fueler.."" ,
						["inline"]= true,
					},
					{
						["name"]= "["..miner.."] المعادن👷",
						["value"]= "داخل الوظيفة : " ..miner.."" ,
						["inline"]= true,
					},
					{
						["name"]= "["..farmer.."] المزارع👨‍🌾",
						["value"]= "داخل الوظيفة : " ..farmer.."" ,
						["inline"]= true,
					},
					{
						["name"]= "["..none.."]  خدمات الموانئ⚓️",
						["value"]= "داخل الوظيفة : " ..none.."" ,
						["inline"]= true,
					},					
					{
						["name"]= "["..taxi.."]  تاكسي🚕",
						["value"]= "داخل الوظيفة : " ..taxi.."" ,
						["inline"]= true,
					},
					{
						["name"]= "["..reporter.."]  صحافه🎥",
						["value"]= "داخل الوظيفة : " ..reporter.. "" ,
						["inline"]= true,
					},					
					{
						["name"]= "["..unemployed.."]  غير موظف👤",
						["value"]= "عاطل" ,
						["inline"]= true,
					}
					
		    	},
				["footer"] = {
					["text"] = footer,
				},
			}
		},
	})

	PerformHttpRequest(Config.JobsWebhook..'/messages/'..Config.MessageId, function(err, text, headers) 
		if Config.Debug then
			print('[DEBUG] err=', err)
			print('[DEBUG] text=', text)
		end
	end, 'PATCH',message, { ['Content-Type'] = 'application/json' })

end

function outService(count, inCount)

    return count - inCount

end

ESX.RegisterServerCallback('callbackplayers', function(source, cb)
	
	Players()

    local data  = {
        cpolice = police,
        cagent = agent,
        cslaughterer = slaughterer,
        cmedic = medic,
        cstaffs = staffs,
        slaughterer = slaughterer,
        unemployed = unemployed,
        cmechanic = mechanic,
        mechanic1 = mechanic1,
        lumberjack = lumberjack,
        fisherman = fisherman,
        tailor = tailor,
        fueler = fueler,
        miner = miner,
        farmer = farmer,
        taxi = taxi,
        reporter = reporter,
        police1 = police1,
        agent1 = agent1,
        slaughterer1 = slaughterer1,
    }
        cb(data)
end)