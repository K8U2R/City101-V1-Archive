ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


-- Event --

-- Mina
RegisterNetEvent('Mody:Log:MinaOFF')
AddEventHandler('Mody:Log:MinaOFF', function()
	MinaOFF()
end)

RegisterNetEvent('Mody:Log:MinaON')
AddEventHandler('Mody:Log:MinaON', function()
	MinaON()
end)

-- Panic
RegisterNetEvent('Mody:Log:PanicStart')
AddEventHandler('Mody:Log:PanicStart', function()
	PanicStartLog()
end)

RegisterNetEvent('Mody:Log:PanicStopLog')
AddEventHandler('Mody:Log:PanicStopLog', function()
	PanicStopLog()
end)

-- PeaceTime
RegisterNetEvent('Mody:Log:PeaceTimeStartLog')
AddEventHandler('Mody:Log:PeaceTimeStartLog', function(time)
	local time = time
	PeaceTimeStartLog(time)
end)

RegisterNetEvent('Mody:Log:PeaceTimeStopLog')
AddEventHandler('Mody:Log:PeaceTimeStopLog', function()
	PeaceTimeStopLog()
end)

-- Store Log
RegisterNetEvent('Mody:Log:StoreLog')
AddEventHandler('Mody:Log:StoreLog', function(StoreName, OwnerName)
	StoreLog(StoreName, OwnerName)
end)

-- Function --

-- Mina

function MinaOFF()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer ~= nil then
		if xPlayer.getJob().name == 'police' then
			local DISCORD_IMAGE = ''
			local DISCORD_NAME = ''..xPlayer.getJob().label..''
			local connect = {
		 	 	{
					  ["color"] = 0,
			 		 ["title"] = "اغلاق ميناء مدينة 101 البحري\nتنويه",
			 		 ["description"] = "يمنع الدخول حتى يتم اعلان الافتتاح\nتواجد المواطنين داخل الميناء اثناء اعلان اغلاق الرسمي يخصم من الخبرة ومخالف للنظام العام",
			 		 ["footer"] = {
				 	 	["text"] = ""..xPlayer.getJob().label.."",
				  		["icon_url"] = "https://discord.com/api/webhooks/1219052188047900773/cE8Qo99-DAH_P-6wDq6XCpyKb4p-jgoJInxYpOHOfVpSfprvJxWsxd7In87_2sYR0sF1"
			 		 },
			 		 ["fields"] = {{
						["name"] = ""..xPlayer.getJob().grade_label.."",
						["value"] = ""..xPlayer.getName()..""
					}}
		 		 }
	  		}
			--PerformHttpRequest('https://discord.com/api/webhooks/1219052188047900773/cE8Qo99-DAH_P-6wDq6XCpyKb4p-jgoJInxYpOHOfVpSfprvJxWsxd7In87_2sYR0sF1', function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })

		else
			local DISCORD_IMAGE = 'https://discord.com/api/webhooks/1219052188047900773/cE8Qo99-DAH_P-6wDq6XCpyKb4p-jgoJInxYpOHOfVpSfprvJxWsxd7In87_2sYR0sF1'
			local DISCORD_NAME = ''..xPlayer.getJob().label..''
			local connect = {
				  {
					  ["color"] = 0,
					  ["title"] = "اغلاق ميناء مدينة 101 البحري\nتنويه",
					  ["description"] = "يمنع الدخول حتى يتم اعلان الافتتاح\nتواجد المواطنين داخل الميناء اثناء اعلان اغلاق الرسمي يخصم من الخبرة ومخالف للنظام العام",
					  ["footer"] = {
					 	 ["text"] = ""..xPlayer.getJob().label.."",
					 	 ["icon_url"] = "https://discord.com/api/webhooks/1219052188047900773/cE8Qo99-DAH_P-6wDq6XCpyKb4p-jgoJInxYpOHOfVpSfprvJxWsxd7In87_2sYR0sF1"
					  },
				 	 ["fields"] = {{
						["name"] = ""..xPlayer.getJob().grade_label.."",
						["value"] = ""..xPlayer.getName()..""
					}}
			 	 }
		 	 }
			--PerformHttpRequest('https://discord.com/api/webhooks/1219052188047900773/cE8Qo99-DAH_P-6wDq6XCpyKb4p-jgoJInxYpOHOfVpSfprvJxWsxd7In87_2sYR0sF1', function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
		end
	end
end

function MinaON()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer ~= nil then
		if xPlayer.getJob().name == 'police' then
			local DISCORD_IMAGE = 'https://discord.com/api/webhooks/1219052188047900773/cE8Qo99-DAH_P-6wDq6XCpyKb4p-jgoJInxYpOHOfVpSfprvJxWsxd7In87_2sYR0sF1'
			local DISCORD_NAME = ''..xPlayer.getJob().label..''
			local connect = {
		 	 	{
					  ["color"] = 5360128,
			 		 ["title"] = "افتتاح ميناء مدينة 101 البحري\nتنويه",
			 		 ["description"] = "يمكنك الآن بيع واستلام البضائع من الموقع",
			 		 ["footer"] = {
				 	 	["text"] = ""..xPlayer.getJob().label.."",
				  		["icon_url"] = "https://discord.com/api/webhooks/1219052188047900773/cE8Qo99-DAH_P-6wDq6XCpyKb4p-jgoJInxYpOHOfVpSfprvJxWsxd7In87_2sYR0sF1"
			 		 },
			 		 ["fields"] = {{
						["name"] = ""..xPlayer.getJob().grade_label.."",
						["value"] = ""..xPlayer.getName()..""
					}}
		 		 }
	  		}
			--PerformHttpRequest('https://discord.com/api/webhooks/1219052188047900773/cE8Qo99-DAH_P-6wDq6XCpyKb4p-jgoJInxYpOHOfVpSfprvJxWsxd7In87_2sYR0sF1', function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })

		else
			local DISCORD_IMAGE = ''
			local DISCORD_NAME = ''..xPlayer.getJob().label..''
			local connect = {
				  {
					  ["color"] = 5360128,
					  ["title"] = "افتتاح ميناء مدينة 101 البحري\nتنويه",
					  ["description"] = "يمكنك الآن بيع واستلام البضائع من الموقع",
					  ["footer"] = {
					 	 ["text"] = ""..xPlayer.getJob().label.."",
					 	 ["icon_url"] = "https://discord.com/api/webhooks/1219052188047900773/cE8Qo99-DAH_P-6wDq6XCpyKb4p-jgoJInxYpOHOfVpSfprvJxWsxd7In87_2sYR0sF1"
					  },
				 	 ["fields"] = {{
						["name"] = ""..xPlayer.getJob().grade_label.."",
						["value"] = ""..xPlayer.getName()..""
					}}
			 	 }
		 	 }
			--PerformHttpRequest('https://discord.com/api/webhooks/1219052188047900773/cE8Qo99-DAH_P-6wDq6XCpyKb4p-jgoJInxYpOHOfVpSfprvJxWsxd7In87_2sYR0sF1', function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
		end
	end
end

-- Panic
function PanicStartLog()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer ~= nil then
		if xPlayer.getJob().name == 'police' then
			local DISCORD_IMAGE = 'https://cdn.discordapp.com/attachments/950654664129523762/966322587485491220/932cfe9cf4291960.png'
			local DISCORD_NAME = ''..xPlayer.getJob().label..''
			local connect = {
		 	 	{
					  ["color"] = 11468800,
			 		 ["title"] = "تم ارسال نداء استغاثة\nرسالة",
			 		 ["description"] = "احتاج مساعدة أو النجدة في موقعي",
			 		 ["footer"] = {
				 	 	["text"] = ""..xPlayer.getJob().label.."",
				  		["icon_url"] = "https://discord.com/api/webhooks/1219056158094921858/2-HrNaioqCsiJkkm8cAB4MLZQgjd7d5k54TZ8CUbyeVarr3Eul4NyXDKtpHeiEgP5ne3"
			 		 },
			 		 ["fields"] = {{
				 		 ["name"] = "تعليمات للعام",
				 		 ["value"] = "حاول المساعدة ولا تعرض حياتك للخطر إذا كان يوجد تبادل اطلاق نار راقب من بعيد وحاول اخذ مواصفات المشتبه بهم وابلاغ الجهات الأمنية عن طريق الجوال أو في الموقع"
			 		 },
					  {
						["name"] = ""..xPlayer.getJob().grade_label.."",
						["value"] = ""..xPlayer.getName()..""
					  }
					}
		 		 }
	  		}
			--PerformHttpRequest('https://discord.com/api/webhooks/816264991400263700/uZXLulWj7u1lARij47neXpLzDGjm3haeqUw3k9oqUS-7Zadzu6dSw45GyKr2acUue8pb', function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })

		else
			local DISCORD_IMAGE = 'https://cdn.discordapp.com/attachments/950654664129523762/966322587485491220/932cfe9cf4291960.png'
			local DISCORD_NAME = ''..xPlayer.getJob().label..''
			local connect = {
				  {
					  ["color"] = 11468800,
					  ["title"] = "تم ارسال نداء استغاثة\nرسالة",
					  ["description"] = "احتاج مساعدة أو النجدة في موقعي",
					  ["footer"] = {
					 	 ["text"] = ""..xPlayer.getJob().label.."",
					 	 ["icon_url"] = "https://discord.com/api/webhooks/1219056158094921858/2-HrNaioqCsiJkkm8cAB4MLZQgjd7d5k54TZ8CUbyeVarr3Eul4NyXDKtpHeiEgP5ne3"
					  },
				 	 ["fields"] = {{
						  ["name"] = "تعليمات للعام",
					  	["value"] = "حاول المساعدة ولا تعرض حياتك للخطر إذا كان يوجد تبادل اطلاق نار راقب من بعيد وحاول اخذ مواصفات المشتبه بهم وابلاغ الجهات الأمنية عن طريق الجوال أو في الموقع"
				  	},
				 	 {
						["name"] = ""..xPlayer.getJob().grade_label.."",
						["value"] = ""..xPlayer.getName()..""
				 	 }
					}
			 	 }
		 	 }
			--PerformHttpRequest('https://discord.com/api/webhooks/816264991400263700/uZXLulWj7u1lARij47neXpLzDGjm3haeqUw3k9oqUS-7Zadzu6dSw45GyKr2acUue8pb', function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
		end
	end
end

function PanicStopLog()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer ~= nil then
		if xPlayer.getJob().name == 'police' then
			local DISCORD_IMAGE = 'https://discord.com/api/webhooks/1219056158094921858/2-HrNaioqCsiJkkm8cAB4MLZQgjd7d5k54TZ8CUbyeVarr3Eul4NyXDKtpHeiEgP5ne3'
			local DISCORD_NAME = ''..xPlayer.getJob().label..''
			local connect = {
		 	 	{
					  ["color"] = 5360128,
			 		 ["title"] = "انتهاء نداء استغاثة\nرسالة",
			 		 ["description"] = "انتهت حالة الاستغاثة في الموقع",
			 		 ["footer"] = {
				 	 	["text"] = ""..xPlayer.getJob().label.."",
				  		["icon_url"] = "https://discord.com/api/webhooks/1219056158094921858/2-HrNaioqCsiJkkm8cAB4MLZQgjd7d5k54TZ8CUbyeVarr3Eul4NyXDKtpHeiEgP5ne3"
			 		 },
			 		 ["fields"] = {--[[{
				 		 ["name"] = "تعليمات للعام",
				 		 ["value"] = "حاول المساعدة ولا تعرض حياتك للخطر إذا كان يوجد تبادل اطلاق نار راقب من بعيد وحاول اخذ مواصفات المشتبه بهم وابلاغ الجهات الأمنية عن طريق الجوال أو في الموقع"
			 		 },]]
					  {
						["name"] = ""..xPlayer.getJob().grade_label.."",
						["value"] = ""..xPlayer.getName()..""
					  }
					}
		 		 }
	  		}
			--PerformHttpRequest('https://discord.com/api/webhooks/816264991400263700/uZXLulWj7u1lARij47neXpLzDGjm3haeqUw3k9oqUS-7Zadzu6dSw45GyKr2acUue8pb', function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })

		else
			local DISCORD_IMAGE = 'https://discord.com/api/webhooks/1219056158094921858/2-HrNaioqCsiJkkm8cAB4MLZQgjd7d5k54TZ8CUbyeVarr3Eul4NyXDKtpHeiEgP5ne3'
			local DISCORD_NAME = ''..xPlayer.getJob().label..''
			local connect = {
				  {
					  ["color"] = 5360128,
					  ["title"] = "انتهاء نداء استغاثة\nرسالة",
					  ["description"] = "انتهت حالة الاستغاثة في الموقع",
					  ["footer"] = {
					 	 ["text"] = ""..xPlayer.getJob().label.."",
					 	 ["icon_url"] = "https://discord.com/api/webhooks/1219056158094921858/2-HrNaioqCsiJkkm8cAB4MLZQgjd7d5k54TZ8CUbyeVarr3Eul4NyXDKtpHeiEgP5ne3"
					  },
				 	 ["fields"] = {--[[{
						  ["name"] = "تعليمات للعام",
					  	["value"] = "حاول المساعدة ولا تعرض حياتك للخطر إذا كان يوجد تبادل اطلاق نار راقب من بعيد وحاول اخذ مواصفات المشتبه بهم وابلاغ الجهات الأمنية عن طريق الجوال أو في الموقع"
				  	},]]
				 	 {
						["name"] = ""..xPlayer.getJob().grade_label.."",
						["value"] = ""..xPlayer.getName()..""
				 	 }
					}
			 	 }
		 	 }
			--PerformHttpRequest('https://discord.com/api/webhooks/816264991400263700/uZXLulWj7u1lARij47neXpLzDGjm3haeqUw3k9oqUS-7Zadzu6dSw45GyKr2acUue8pb', function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
		end
	end
end

-- PeaceTime
function PeaceTimeStartLog(time)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer ~= nil then
			local DISCORD_IMAGE = 'https://discord.com/api/webhooks/1219048510461186120/Z0OS6hUvnlQyLY39ToGRTR2LkfDS1vQq9DDxL_gnuX5jXjijwu3PhfIWUx-D9AY3x2e6'
			local DISCORD_NAME = 'إدارة الرقابة و التفتيش'
			local time = time
			local connect = {
		 	 	{
					  ["color"] = 5360128,
			 		 ["title"] = "اعلان وقت راحة | المدة "..time.." دقيقة\nتنويه",
			 		 ["description"] = "يمنع العمل الاجرامي وتعطل جميع الدوائر الحكومية والخاصة حتى انتهاء الوقت التخريب خلال وقت الراحة يعرضك لعقوبات مشددة",
			 		 ["footer"] = {
				 	 	["text"] = "إدارة الرقابة و التفتيش",
				  		["icon_url"] = "https://discord.com/api/webhooks/1219048510461186120/Z0OS6hUvnlQyLY39ToGRTR2LkfDS1vQq9DDxL_gnuX5jXjijwu3PhfIWUx-D9AY3x2e6"
			 		 },
			 		 ["fields"] = {--[[{
				 		 ["name"] = "تعليمات للعام",
				 		 ["value"] = "حاول المساعدة ولا تعرض حياتك للخطر إذا كان يوجد تبادل اطلاق نار راقب من بعيد وحاول اخذ مواصفات المشتبه بهم وابلاغ الجهات الأمنية عن طريق الجوال أو في الموقع"
			 		 },]]
					  {
						["name"] = "الوظائف المعتمدة",
						["value"] = "يجب موافقة الرتبة الأعلى لتغير الوظيفة يمنع تغيير الوظيفة إذا كان وقت الراحة قصير"
					  }
					}
		 		 }
	  		}
			--PerformHttpRequest('https://discord.com/api/webhooks/816264991400263700/uZXLulWj7u1lARij47neXpLzDGjm3haeqUw3k9oqUS-7Zadzu6dSw45GyKr2acUue8pb', function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
	end
end

function PeaceTimeStopLog()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer ~= nil then
			local DISCORD_IMAGE = 'https://discord.com/api/webhooks/1219048510461186120/Z0OS6hUvnlQyLY39ToGRTR2LkfDS1vQq9DDxL_gnuX5jXjijwu3PhfIWUx-D9AY3x2e6'
			local DISCORD_NAME = 'إدارة الرقابة و التفتيش'
			local time = 10
			local connect = {
		 	 	{
					  ["color"] = 5360128,
			 		 ["title"] = "انتهاء وقت راحة \nرسالة",
			 		 ["description"] = "عودة الحياة طبيعية في المقاطعة",
			 		 ["footer"] = {
				 	 	["text"] = "إدارة الرقابة و التفتيش",
				  		["icon_url"] = "https://discord.com/api/webhooks/1219048510461186120/Z0OS6hUvnlQyLY39ToGRTR2LkfDS1vQq9DDxL_gnuX5jXjijwu3PhfIWUx-D9AY3x2e6"
			 		 },
			 		 --[["fields"] = {
				 		 ["name"] = "تعليمات للعام",
				 		 ["value"] = "حاول المساعدة ولا تعرض حياتك للخطر إذا كان يوجد تبادل اطلاق نار راقب من بعيد وحاول اخذ مواصفات المشتبه بهم وابلاغ الجهات الأمنية عن طريق الجوال أو في الموقع"
			 		 },
					  {
						["name"] = "الوظائف المعتمدة",
						["value"] = "يجب موافقة الرتبة الأعلى لتغير الوظيفة يمنع تغيير الوظيفة إذا كان وقت الراحة قصير"
					  }
					}]]
		 		 }
	  		}
			--PerformHttpRequest('https://discord.com/api/webhooks/816264991400263700/uZXLulWj7u1lARij47neXpLzDGjm3haeqUw3k9oqUS-7Zadzu6dSw45GyKr2acUue8pb', function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
	end
end

-- Store Log

function StoreLog(StoreName, OwnerName)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer ~= nil then
			local DISCORD_IMAGE = 'https://discord.com/api/webhooks/1219056158094921858/2-HrNaioqCsiJkkm8cAB4MLZQgjd7d5k54TZ8CUbyeVarr3Eul4NyXDKtpHeiEgP5ne3'
			local DISCORD_NAME = 'متجر'
			local StoreName = StoreName
			local OwnerName = OwnerName
			local connect = {
		 	 	{
					  ["color"] = 13174278,
			 		 ["title"] = "تم رصد سرقة متجر",
			 		 --["description"] = ""..StoreName.."",
			 		 ["footer"] = {
				 	 	["text"] = "إدارة المتاجر",
				  		["icon_url"] = "https://discord.com/api/webhooks/1219056158094921858/2-HrNaioqCsiJkkm8cAB4MLZQgjd7d5k54TZ8CUbyeVarr3Eul4NyXDKtpHeiEgP5ne3"
			 		 },
			 		 ["fields"] = {{
						["name"] = "اسم المتجر :",
						["value"] = ""..StoreName..""
			 		 },
					  {
						["name"] = "المالك :",
						["value"] = ""..OwnerName..""
					  }
					}
				}
		 	 }
	  	
			--PerformHttpRequest('https://discord.com/api/webhooks/816264991400263700/uZXLulWj7u1lARij47neXpLzDGjm3haeqUw3k9oqUS-7Zadzu6dSw45GyKr2acUue8pb', function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
	end
end