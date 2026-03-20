Config = {
	Default_Prio = 500000, -- This is the default priority value if a discord isn't found
	AllowedPerTick = 60, -- How many players should we allow to connect at a time?
	HostDisplayQueue = false,
	onlyActiveWhenFull = true,
	Requirements = { -- A player must have the identifier to be allowed into the server
		Discord = true,
		Steam = false
	},
	WhitelistRequired = false, -- If this option is set to true, a player must have a role in Config.Rankings to be allowed into the server
	Debug = false,
	Webhook = 'https://discord.com/api/webhooks/1219036530631507978/vYZ5xw0jk6ttwx_Dhwf7m5PDJYB9sxDDWdvApxwlsf7Yw_vOmvgAvuChBv9noD7zXpF9',
	Displays = {
		Prefix = '[Queue]',
		ConnectingLoop = { 
			'🦡🌿🦡🌿🦡🌿',
			'🌿🦡🌿🦡🌿🦡',
			'🦡🌿🦡🌿🦡🥦',
			'🌿🦡🌿🦡🥦🦡',
			'🦡🌿🦡🥦🦡🥦',
			'🌿🦡🥦🦡🥦🦡',
			'🦡🥦🦡🥦🦡🥦',
			'🥦🦡🥦🦡🥦🦡',
			'🦡🥦🦡🥦🦡🌿',
			'🥦🦡🥦🦡🌿🦡',
			'🦡🥦🦡🌿🦡🌿',
			'🥦🦡🌿🦡🌿🦡',
		},
		Messages = {
			MSG_CONNECTING = 'جاري الدخول [{QUEUE_NUM}/{QUEUE_MAX}]: ', -- Default message if they have no discord roles 
			MSG_CONNECTED = 'جاري الدخول',
			MSG_DISCORD_REQUIRED = 'الرجاء التأكد من تشغيل ديسكورد - https://discord.gg/bKa9YVR8',
			MSG_STEAM_REQUIRED = 'يجب فتح برنامج ستيم لدخول السيرفر - https://discord.gg/bKa9YVR8',
			MSG_NOT_WHITELISTED = 'أنت لست مفعل يرجى التوجه الى الديسكورد و تفعيل نفسك فورا بدون مقابلة - https://discord.gg/bKa9YVR8',
		},
	},
}

Config.Rankings = {
	-- رقم اقل === أولوية أعلى
	-- ['رقم الرول'] = {الرسالة - الأولوية},
	['1214434284455329864'] = {500, "جاري الدخول [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- مواطن مفعل
	-- الباقات
	['1214434100895682672'] = {400, "جاري الدخول [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- باقة برونزية
	['1214434099721150474'] = {350, "جاري الدخول [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- باقة فضية
	['1214434098492211230'] = {300, "جاري الدخول [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- باقة ذهبية
	['1214434096256786462'] = {200, "جاري الدخول [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- الباقة الألماسية
	['1214434094968995860'] = {150, "جاري الدخول [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- الباقة الرسمية
	['1214434093517770764'] = {100, "جاري الدخول [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- الباقة الإستراتيجية
	-- الإدارة
	['1214434076698869761'] = {499, "{أولوية إدارية} جاري الدخول [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- دعم فني
	['1214434075541110784'] = {4, "{أولوية إدارية} جاري الدخول [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- مشرف
	['1214434074500792341'] = {3, "{أولوية إدارية} جاري الدخول [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- مشرف بلس
	['1214434073456410726'] = {2, "{أولوية إدارية} جاري الدخول [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- أدمن
	['1214434072311373905'] = {1, "{أولوية إدارية} جاري الدخول [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- أدمن بلس
}