

local locales = xMDConfig.Locales[xMDConfig.Locale]
local startTimestamp = os.time()
local days = 0
local hours = 0
local minutes = 0
local realHour = 0
local realMinutes = 0
local completed = 4
local total = 100
local totalVehicles = 0
local totalObjects = 0
local players = 0
local maxplayerIn = 0
local newPlayers = 0
local maxplayerWaiting = 0
local waitingQueue = {}
local zwar = 0
local totalChar = 0
local waitings = 0 



function secondsToTimeDesc( seconds )
	if seconds then
		local results = {}
		local min = math.floor ( ( seconds % 3600 ) /60 )
		local hou = math.floor ( ( seconds % 86400 ) /3600 )
		local day = math.floor ( seconds /86400 )
		
		table.insert( results, "ي:" ..day ) 
		table.insert( results, "س:" ..hou  ) 
		table.insert( results, "د:" ..min  ) 
		
		return string.reverse ( table.concat ( results, " | " ):reverse():gsub("|", " | ", 1 ) )
	end
	return ""
end

function SavexMDToFile(maxPlayers, maxQueue)
    local filePath = '1xmd_stats.txt' 
    local file, errorString = io.open(filePath, 'w') 

    if file then
		file:write('MaxPlayersTOP = ' .. tostring(maxPlayers) .. '\n')
		file:write('MaxWaitingQueue = ' .. tostring(maxQueue) .. '\n')
        file:close()
    end
end


function GetxMDValues()
    local filePath = '1xmd_stats.txt'
    local file, errorString = io.open(filePath, 'r')

    if file then
        local xMD = {}
        for line in file:lines() do
            local key, value = line:match("(%a+)%s*=%s*(%d+)")
            if key and value then
                xMD[key] = tonumber(value)
            end
        end

        file:close()
        return xMD
    else
        return nil
    end
end



local function ChangeProgressBar(players)
    local percent = players / GetConvarInt('sv_maxclients', 32) * 100
    local index = math.ceil(percent / (100 / #xMDConfig.progressImages))

	return xMDConfig.progressImages[index+1]
end

local function UpdateStatusMessage(statue, color)
   local players = #GetPlayers()
   local maxplayers = GetConvarInt('sv_maxclients', 0)
   local footer = nil
   local imageUrl = ChangeProgressBar(players)

   if players > maxplayerIn then
		maxplayerIn = players
		SavexMDToFile(maxplayerIn,maxplayerWaiting)
   end

	
	if waitings > maxplayerWaiting then
		SavexMDToFile(maxplayerIn,waitings)
	end

	if xMDConfig.Use24hClock then
		footer = os.date(locales['date']..': %d/%m/%Y  |  '..locales['time']..': %H:%M')
	else
		footer = os.date(locales['date']..': %d/%m/%Y  |  '..locales['time']..': %I:%M %p')
	end

    local xMD = GetxMDValues()

	if xMD then
		maxplayerIn = tonumber(xMD.MaxPlayersTOP or 0)
		maxplayerWaiting = tonumber(xMD.MaxWaitingQueue or 0)
	end 

	local fields = {
		{
			name = ' <:time:1217236837874270260> مدة التشغيل ',
			value = secondsToTimeDesc(os.time() - startTimestamp),
			inline = true
		  },

		  {
			name='<a:xLoading:1217236853376290858> '..'  الإنتظار ',
			value = waitings,
			inline = true
		  },

		 {
			 name=':globe_with_meridians: المتصلين ',
			 value=  locales['players']..':  `'..players..'/'..maxplayers..'`',
			 inline = true
		 },

		  {
			name = "🚗 المركبات",
			value = #GetAllVehicles(),
			inline = true
		  },
		  {
			name = " 🚧 المجسمات",
			value = #GetAllObjects(),
			inline = true
		  },
		  {
			name = " 😁 الزوار",
			value = zwar,
			inline = true
		  },
		  {
			name = "<:player:1217236810170761298> عدد الشخصيات ",
			value = totalChar,
			inline = true
		  },
		  {
			name = " 🥺 لاعب جديد",
			value = newPlayers,
			inline = true
		  },
		  {
			name= " 📊 الإحصائية",
			value = "اعلي متصلين : "..maxplayerIn.."\nاعلي انتظار : "..maxplayerWaiting.."\n"
		  },
		  {
			name= " 🔗 رابط دخول السيرفر",
			value = xMDConfig.JoinLink
		  },
	}

	local embed = {
		{
			["color"] = 2763306,
			["title"] = '**'.. statue ..'**',
			["footer"] = {
				["text"] = os.date("%H:%M  %Y-%m-%d  " .. xMDConfig.ServerName),
			},
			["image"] = {
				["url"] = imageUrl
			},
			["thumbnail"] = {
				["url"] = xMDConfig.ServerLogo
			},
			["fields"] = fields
		}
	}

    PerformHttpRequest(xMDConfig.Webhook.."/messages/"..xMDConfig.MessageId, function(err, text, headers) end, 'PATCH', json.encode({ embeds = embed }), { ['Content-Type'] = 'application/json' })
end


Citizen.CreateThread(function()
    while true do
		if xMDConfig.Online then 
			if xMDConfig.MessageId ~= nil and xMDConfig.MessageId ~= '' then
				MySQL.Async.fetchAll('SELECT * FROM users', { }, function(response)
					totalChar = #response
				end)

				UpdateStatusMessage("أونلاين 🟢", 2067276)
			else
				print("invaild discord-webhook message id!")
				break
			end
		else 
			days = 0
			hours = 0
			minutes = 0
			realHour = 0
			realMinutes = 0
			completed = 4
			total = 100
			totalVehicles = 0
			totalObjects = 0
			UpdateStatusMessage('اوفلاين 🔴', 15548997)
		end 	

		Citizen.Wait(xMDConfig.UpdateTime)
    end
end)



AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		print("Server is shutting down gracefully or due to Ctrl + C")

	  return
	end
	 days = 0
	 hours = 0
	 minutes = 0
	 realHour = 0
	 realMinutes = 0
	 completed = 4
	 total = 100
	 totalVehicles = 0
	 totalObjects = 0
	 UpdateStatusMessage(0,'اوفلاين 🔴')
  end)

AddEventHandler("playerConnecting", function ()
	zwar = zwar + 1
end)


AddEventHandler('esx:playerLoaded', function(table)
	if table and #table.inventory>0 then 
		newPlayers = newPlayers + 1
	end 
end)

  
AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end

	MySQL.ready(function ()
		MySQL.Async.fetchAll('SELECT * FROM users', { }, function(response)
			totalChar = #response
		end)
	end)
	
end)