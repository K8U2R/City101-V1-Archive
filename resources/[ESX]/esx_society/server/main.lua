ESX = nil
local Jobs = {}
local RegisteredSocieties = {}

local AdminWebHook = "https://discord.com/api/webhooks/1219048510461186120/Z0OS6hUvnlQyLY39ToGRTR2LkfDS1vQq9DDxL_gnuX5jXjijwu3PhfIWUx-D9AY3x2e6"
local PoliceWebHook = "https://discord.com/api/webhooks/1219059893584265257/SyRiYPOkk_QakLYwfF0XmNdMdcUjXNequOYsexysYqV8FR-jM45M7T-gWmU8Nq2m1t4V"
local AgentWebHook = "https://discord.com/api/webhooks/1219059411583242351/UKvPbB-tns0urbPUGLpIAfVV7AXxufvC2uRa4EztqIJL3mgvFm1ZiTcc9Wy24MwQLlDB"
local AmbulanceWebHook = "https://discord.com/api/webhooks/1219059673605476434/EdbG6qI6n7tVG-fLksBhCw2dyJlMurbAU_yL4s4kkWO1SKOFF7ki-43fMTH_QnRijaHA"
local MechanicWebHook = "https://discord.com/api/webhooks/1219051852172099725/baoYZpesT-wT2Qqmz9HMtrOqAomYYdAEtD38im5nmYYvEaRQSzJiukQ3G0DeqInCBPrE"

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--Send the message to your discord server
function sendToDiscord2 (name,message,color)
  local DiscordWebHook = "https://discord.com/api/webhooks/1219060588114870272/-7jNcTPhsvW29isz5pku2W4H0jqqxENYmJuwXSPw8tZv3N3Geeyn75CDiFIOyiHegctk"
  -- Modify here your discordWebHook username = name, content = message,embeds = embeds

local embeds = {
    {
        ["title"]=message,
        ["type"]="rich",
        ["color"] =color,
        ["footer"]=  {
            ["text"]= "خزنات الوظائف المعتمدة",
       },
    }
}

  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function sendToDiscord (name, title, message, color, WebHook)
	
	local embeds = {
		{
			["title"]=title,
			["type"]="rich",
            ["description"] = message,
			["color"] =color,
			["footer"]=  { ["text"]= "خزنات الوظائف المعتمدة", 
            ["icon_url"] = "https://probot.media/X3kaJPpSj7.png"},
		}
	}
	
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(WebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function GetSociety(name)
	for i=1, #RegisteredSocieties, 1 do
		if RegisteredSocieties[i].name == name then
			return RegisteredSocieties[i]
		end
	end
end

AddEventHandler('onResourceStart', function(resourceName)
	if resourceName == GetCurrentResourceName() then
		local result = MySQL.Sync.fetchAll('SELECT * FROM jobs', {})
		
		for i=1, #result, 1 do
			Jobs[result[i].name]        = result[i]
			Jobs[result[i].name].grades = {}
		end

		local result2 = MySQL.Sync.fetchAll('SELECT * FROM job_grades', {})

		for i=1, #result2, 1 do
			if Jobs[result2[i].job_name] then
				Jobs[result2[i].job_name].grades[tostring(result2[i].grade)] = result2[i]
			end
		end
	end
end)

AddEventHandler('esx_society:registerSociety', function(name, label, account, datastore, inventory, data)
	local found = false

	local society = {
		name      = name,
		label     = label,
		account   = account,
		datastore = datastore,
		inventory = inventory,
		data      = data
	}

	for i=1, #RegisteredSocieties, 1 do
		if RegisteredSocieties[i].name == name then
			found = true
			RegisteredSocieties[i] = society
			break
		end
	end

	if not found then
		table.insert(RegisteredSocieties, society)
	end
end)

AddEventHandler('esx_society:getSocieties', function(cb)
	cb(RegisteredSocieties)
end)

AddEventHandler('esx_society:getSociety', function(name, cb)
	cb(GetSociety(name))
end)

RegisterServerEvent('esx_K2sociabdurhmanety:withdrawMoney') -- esx_society:withdrawMoney
AddEventHandler('esx_K2sociabdurhmanety:withdrawMoney', function(society, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local society = GetSociety(society)
	amount = ESX.Math.Round(tonumber(amount))
	--Disocrd
	local ids = ExtractIdentifiers(source)
	_discordID ="<@" ..ids.discord:gsub("discord:", "")..">"
    _identifierID ="" ..xPlayer.identifier..""
	--
	nowmoney = ''
	if xPlayer.job.name == society.name then
		TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
			if amount > 0 and account.money >= amount then
				account.removeMoney(amount)
				xPlayer.addMoney(amount)
				--Disocrd
				nowmoney = 'المبلغ الحالي الموجود بالخزنة: '..account.money..'$'
                if society.account == 'society_police' then
				sendToDiscord ('الخزنة الوظيفية للشرطة', 'سحب مال من خزنة الشرطة', '**'..xPlayer.getName()..'**\n'.._discordID..'\n'.._identifierID..'\n\n **المبلغ: '..amount..'**$\n'..nowmoney..'', '15158332', PoliceWebHook)
				elseif society.account == 'society_agent' then
				sendToDiscord ('الخزنة الوظيفية حرس الحدود', 'سحب مال من خزنة حرس الحدود', '**'..xPlayer.getName()..'**\n'.._discordID..'\n'.._identifierID..'\n\n **المبلغ: '..amount..'**$\n'..nowmoney..'', '15158332', AgentWebHook)
				elseif society.account == 'society_admin' then
				sendToDiscord ('الخزنة الوظيفية للرقابة والتفيش', 'سحب مال من خزنة الرقابة والتفتيش', '**'..xPlayer.getName()..'**\n'.._discordID..'\n'.._identifierID..'\n\n **المبلغ: '..amount..'**$\n'..nowmoney..'', '15158332', AdminWebHook)
				elseif society.account == 'society_ambulance' then
				sendToDiscord ('الخزنة الوظيفية للدفاع المدني', 'سحب مال من خزنة الدفاع المدني', '**'..xPlayer.getName()..'**\n'.._discordID..'\n'.._identifierID..'\n\n **المبلغ: '..amount..'**$\n'..nowmoney..'', '15158332', AmbulanceWebHook)
				elseif society.account == 'society_mechanic' then
				sendToDiscord ('الخزنة الوظيفية لكراج الميكانيك', 'سحب مال من خزنة كراج الميكانيك', '**'..xPlayer.getName()..'**\n'.._discordID..'\n'.._identifierID..'\n\n **المبلغ: '..amount..'**$\n'..nowmoney..'', '15158332', MechanicWebHook)
				end
				
				sendToDiscord2((' الخزنات '), "قام `"..GetPlayerName(source).."` (`"..GetPlayerIdentifiers(source)[1].."`) (`"..GetPlayerIdentifiers(source)[5].."`)\n بسحب فلوس من خزنة `"..society.account.."` \n المبلغ : `"..amount.."`$",56108)
			    --
			else
			end
		end)
	else
		print(('esx_society: %s attempted to call withdrawMoney!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_K2sociabdurhmanety:depositMoney') -- esx_society:depositMoney
AddEventHandler('esx_K2sociabdurhmanety:depositMoney', function(society, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local society = GetSociety(society)
	amount = ESX.Math.Round(tonumber(amount))
    
	--Disocrd
	local ids = ExtractIdentifiers(source)
	_discordID ="<@" ..ids.discord:gsub("discord:", "")..">"
    _identifierID ="" ..xPlayer.identifier..""
    msg1 ="إيداع مال بخزنة"
	--
	nowmoney = ''
	
	if xPlayer.job.name == society.name then
		if amount > 0 and xPlayer.getMoney() >= amount then
			TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
				xPlayer.removeMoney(amount)
				account.addMoney(amount)
				--Disocrd
				nowmoney = 'المبلغ الحالي الموجود بالخزنة: '..account.money..'$'
                if society.account == 'society_police' then
				sendToDiscord ('الخزنة الوظيفية للشرطة', msg1..' الشرطة', '**'..xPlayer.getName()..'**\n'.._discordID..'\n'.._identifierID..'\n\n **المبلغ: '..amount..'**$\n'..nowmoney..'', '9807270', PoliceWebHook)
				elseif society.account == 'society_agent' then
				sendToDiscord ('الخزنة الوظيفية حرس الحدود', msg1..' حرس الحدود', '**'..xPlayer.getName()..'**\n'.._discordID..'\n'.._identifierID..'\n\n **المبلغ: '..amount..'**$\n'..nowmoney..'', '9807270', AgentWebHook)
				elseif society.account == 'society_admin' then
				sendToDiscord ('الخزنة الوظيفية للرقابة والتفيش', msg1..' الرقابة والتفتيش', '**'..xPlayer.getName()..'**\n'.._discordID..'\n'.._identifierID..'\n\n **المبلغ: '..amount..'**$\n'..nowmoney..'', '9807270', AdminWebHook)
				elseif society.account == 'society_ambulance' then
				sendToDiscord ('الخزنة الوظيفية للدفاع المدني', msg1..' الدفاع المدني', '**'..xPlayer.getName()..'**\n'.._discordID..'\n'.._identifierID..'\n\n **المبلغ: '..amount..'**$\n'..nowmoney..'', '9807270', AmbulanceWebHook)
				elseif society.account == 'society_mechanic' then
				sendToDiscord ('الخزنة الوظيفية لكراج الميكانيك', msg1..' كرج الميكانيكي', '**'..xPlayer.getName()..'**\n'.._discordID..'\n'.._identifierID..'\n\n **المبلغ: '..amount..'**$\n'..nowmoney..'', '9807270', MechanicWebHook)
				end
                sendToDiscord2((' الخزنات '), "قام `"..GetPlayerName(source).."` (`"..GetPlayerIdentifiers(source)[1].."`) (`"..GetPlayerIdentifiers(source)[5].."`)\n بإيداع مال بخزنة `"..society.account.."` \n المبلغ : `"..amount.."`$",56108)				
			end)
		else
		end
	else
		print(('esx_society: %s attempted to call depositMoney!'):format(xPlayer.identifier))
	end
end)

function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = "",
        fivem = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
		elseif string.find(id, "fivem") then
            identifiers.fivem = id
        end
    end

    return identifiers
end

RegisterServerEvent('esx_society:addmoney_tosociety') -- ايفنت إضافة مبلغ معين لخزنة وظيفة معين يستعمل في بعض الاشياء مثل كميرات رادار السرعة
AddEventHandler('esx_society:addmoney_tosociety', function(tosociety, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local society = GetSociety(tosociety)
	amount = ESX.Math.Round(tonumber(amount))

			TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
				account.addMoney(amount)				
			end)
end)

RegisterServerEvent('esx_K2sociabdurhmanety:washMoney') -- esx_society:washMoney
AddEventHandler('esx_K2sociabdurhmanety:washMoney', function(society, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local account = xPlayer.getAccount('black_money')
	amount = ESX.Math.Round(tonumber(amount))

	if xPlayer.job.name == society then
		if amount and amount > 0 and account.money >= amount then
		TriggerEvent("esx:washingmoneyalert",xPlayer.name,amount)
			xPlayer.removeAccountMoney('black_money', amount)

			MySQL.Async.insert('INSERT INTO society_moneywash (identifier, society, amount) VALUES (@identifier, @society, @amount)', {
				['@identifier'] = xPlayer.identifier,
				['@society']    = society,
				['@amount']     = amount
			}, function(rowsChanged)
			end)
		else
		end
	else
		print(('esx_society: %s attempted to call washMoney!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_society:putVehicleInGarage')
AddEventHandler('esx_society:putVehicleInGarage', function(societyName, vehicle)
	local society = GetSociety(societyName)

	TriggerEvent('esx_datastore:getSharedDataStore', society.datastore, function(store)
		local garage = store.get('garage') or {}

		table.insert(garage, vehicle)
		store.set('garage', garage)
	end)
end)

RegisterServerEvent('esx_society:removeVehicleFromGarage')
AddEventHandler('esx_society:removeVehicleFromGarage', function(societyName, vehicle)
	local society = GetSociety(societyName)

	TriggerEvent('esx_datastore:getSharedDataStore', society.datastore, function(store)
		local garage = store.get('garage') or {}

		for i=1, #garage, 1 do
			if garage[i].plate == vehicle.plate then
				table.remove(garage, i)
				break
			end
		end

		store.set('garage', garage)
	end)
end)

ESX.RegisterServerCallback('esx_society:getSocietyMoney', function(source, cb, societyName)
	local society = GetSociety(societyName)

	if society then
		TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
			cb(account.money)
		end)
	else
		cb(0)
	end
end)

ESX.RegisterServerCallback('esx_society:getEmployees', function(source, cb, society)
	local employees = {}

	local xPlayers = ESX.GetExtendedPlayers('job', society)
	for _, xPlayer in pairs(xPlayers) do

		local name = xPlayer.name
		if Config.EnableESXIdentity and name == GetPlayerName(xPlayer.source) then
			name = xPlayer.get('firstName') .. ' ' .. xPlayer.get('lastName')
		end

		table.insert(employees, {
			name = name,
			identifier = xPlayer.identifier,
			job = {
				name = society,
				label = xPlayer.job.label,
				grade = xPlayer.job.grade,
				grade_name = xPlayer.job.grade_name,
				grade_label = xPlayer.job.grade_label
			}
		})
	end
		
	local query = "SELECT identifier, job_grade FROM `users` WHERE `job`= ? ORDER BY job_grade DESC"

	if Config.EnableESXIdentity then
		query = "SELECT identifier, job_grade, firstname, lastname FROM `users` WHERE `job`= ? ORDER BY job_grade DESC"
	end

	MySQL.Async.fetchAll(query, {society},
	function(result)
		for k, row in pairs(result) do
			local alreadyInTable
			local identifier = row.identifier

			for k, v in pairs(employees) do
				if v.identifier == identifier then
					alreadyInTable = true
				end
			end

			if not alreadyInTable then
				local name = "Name not found." -- maybe this should be a locale instead ¯\_(ツ)_/¯

				if Config.EnableESXIdentity then
					name = row.firstname .. ' ' .. row.lastname 
				end
				
				table.insert(employees, {
					name = name,
					identifier = identifier,
					job = {
						name = society,
						label = Jobs[society].label,
						grade = row.job_grade,
						grade_name = Jobs[society].grades[tostring(row.job_grade)].name,
						grade_label = Jobs[society].grades[tostring(row.job_grade)].label
					}
				})
			end
		end

		cb(employees)
	end)

end)
ESX.RegisterServerCallback('esx_society:getJob', function(source, cb, society)
	local job    = json.decode(json.encode(Jobs[society]))
	local grades = {}

	for k,v in pairs(job.grades) do
		table.insert(grades, v)
	end

	table.sort(grades, function(a, b)
		return a.grade < b.grade
	end)

	job.grades = grades

	cb(job)
end)

ESX.RegisterServerCallback('esx_sK222ociabdurhmanety:setJob', function(source, cb, identifier, job, grade, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local isBoss = xPlayer.job.grade_name == 'boss'
	local isBossTwo = xPlayer.job.grade_name == 'bosstwo'

	if isBoss or isBossTwo then
		local xTarget = ESX.GetPlayerFromIdentifier(identifier)

		if xTarget then
			xTarget.setJob(job, grade)

			if type == 'hire' then
				xTarget.showNotification(_U('you_have_been_hired', job))
			elseif type == 'promote' then
				xTarget.showNotification(_U('you_have_been_promoted'))
			elseif type == 'fire' then
				xTarget.showNotification(_U('you_have_been_fired', xTarget.getJob().label))
			end

			cb()
		else
			MySQL.Async.execute('UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier', {
				['@job']        = job,
				['@job_grade']  = grade,
				['@identifier'] = identifier
			}, function(rowsChanged)
				cb()
			end)
		end
	else
		print(('esx_society: %s attempted to setJob'):format(xPlayer.identifier))
		cb()
	end
end)

ESX.RegisterServerCallback('esx_socKDKDKDDieABDURHMANty:setJobSalary', function(source, cb, job, grade, salary)
	local isBoss = isPlayerBoss(source, job)
	local identifier = GetPlayerIdentifier(source, 0)

	if isBoss then
		if salary <= Config.MaxSalary then
			MySQL.Async.execute('UPDATE job_grades SET salary = @salary WHERE job_name = @job_name AND grade = @grade', {
				['@salary']   = salary,
				['@job_name'] = job,
				['@grade']    = grade
			}, function(rowsChanged)
				Jobs[job].grades[tostring(grade)].salary = salary
				local xPlayers = ESX.GetPlayers()

				for i=1, #xPlayers, 1 do
					local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

					if xPlayer.job.name == job and xPlayer.job.grade == grade then
						xPlayer.setJob(job, grade)
					end
				end

				cb()
			end)
		else
			print(('esx_society: %s attempted to setJobSalary over config limit!'):format(identifier))
			cb()
		end
	else
		print(('esx_society: %s attempted to setJobSalary'):format(identifier))
		cb()
	end
end)

--[[local getOnlinePlayers, onlinePlayers = false, {}
ESX.RegisterServerCallback('esx_society:getOnlinePlayers', function(source, cb)
	local xPlayers = ESX.GetPlayers()
	local players = {}

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		table.insert(players, {
			source = xPlayer.source,
			identifier = xPlayer.identifier,
			name = xPlayer.name,
			job = xPlayer.job,
			Coords = xPlayer.getCoords(true),
			ped = GetPlayerPed(xPlayer.source),
			SteamName = GetPlayerName(xPlayer.source),
		})
	end

	cb(players)
end)--]]

ESX.RegisterServerCallback('esx_society:getVehiclesInGarage', function(source, cb, societyName)
	local society = GetSociety(societyName)

	TriggerEvent('esx_datastore:getSharedDataStore', society.datastore, function(store)
		local garage = store.get('garage') or {}
		cb(garage)
	end)
end)

ESX.RegisterServerCallback('esx_society:isBoss', function(source, cb, job)
	cb(isPlayerBoss(source, job))
end)

function isPlayerBoss(playerId, job)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer.job.name == job and (xPlayer.job.grade_name == 'boss' or xPlayer.job.grade_name == 'bosstwo' or xPlayer.job.grade_name == 'high_admin' or xPlayer.job.grade_name == 'meduim_admin') then
		return true
	else
		print(('esx_society: %s attempted open a society boss menu!'):format(xPlayer.identifier))
		return false
	end
end

function WashMoneyCRON(d, h, m)
	MySQL.Async.fetchAll('SELECT * FROM society_moneywash', {}, function(result)
		for i=1, #result, 1 do
			local society = GetSociety(result[i].society)
			local xPlayer = ESX.GetPlayerFromIdentifier(result[i].identifier)

			-- add society money
			TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
				account.addMoney(result[i].amount)
			end)

			-- send notification if player is online
			if xPlayer then
				xPlayer.showNotification(_U('you_have_laundered', ESX.Math.GroupDigits(result[i].amount)))
			end

			MySQL.Async.execute('DELETE FROM society_moneywash WHERE id = @id', {
				['@id'] = result[i].id
			})
		end
	end)
end

TriggerEvent('cron:runAt', 3, 0, WashMoneyCRON)
