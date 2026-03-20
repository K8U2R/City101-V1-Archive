Config = {}
Config.Framework = "ESX" -- "ESX" or "QB"
Config.DiscordLogs = true -- Set webhook in server.lua Line 1
Config.SpaceInLicensePlate = true -- Set to true if you want a space in license plate for vehicle reward
Config.LicensePlateLetters = 3 -- Amount of letters in plate for vehicle reward
Config.LicensePlateNumbers = 3 -- Amount of numbers in plate for vehicle reward
Config.Packages = {
	{
		PackageName = "Money Package", -- Exact package name from tebex
		Items = {
			{
				name = "money", -- Item or account name depending on type specified below
				amount = 2000000, -- Amount of item or money
				type = "account" -- Four types: account, item, or weapon and car
			},
		},
	},
	{
		PackageName = "bronze", -- Exact package name from tebex
		Items = {
			{
				name = "money", -- Item or account name depending on type specified below
				amount = 500000, -- Amount of item or money
				xp = 10000,
				type = "account", -- Four types: account, item, or weapon and car
				des = "🥉راعي برونزي"
			},
		},
	},
	{
		PackageName = "silver", -- Exact package name from tebex
		Items = {
			{
				name = "money", -- Item or account name depending on type specified below
				amount = 1000000, -- Amount of item or money
				xp = 12000,
				type = "account", -- Four types: account, item, or weapon and car
				des = "🥈راعي فضي"
			},
		},
	},
	{
		PackageName = "gold", -- Exact package name from tebex
		Items = {
			{
				name = "money", -- Item or account name depending on type specified below
				amount = 2000000, -- Amount of item or money
				xp = 15000,
				type = "account", -- Four types: account, item, or weapon and car
				des = "🏆راعي ذهبي"
			},
		},
	},
	{
		PackageName = "plat", -- Exact package name from tebex
		Items = {
			{
				name = "money", -- Item or account name depending on type specified below
				amount = 3500000, -- Amount of item or money
				xp = 25000,
				type = "account", -- Four types: account, item, or weapon and car
				des = "⚡راعي  بلاتيني"
			},
		},
	},
	{
		PackageName = "diamond", -- Exact package name from tebex
		Items = {
			{
				name = "money", -- Item or account name depending on type specified below
				amount = 3500000, -- Amount of item or money
				xp = 25000,
				type = "account", -- Four types: account, item, or weapon and car
				des = "💎راعي  ألماسي"
			},
		},
	},
	{
		PackageName = "official", -- Exact package name from tebex
		Items = {
			{
				name = "money", -- Item or account name depending on type specified below
				amount = 4000000, -- Amount of item or money
				xp = 35000,
				type = "account", -- Four types: account, item, or weapon and car
				des = "⭐ داعم اساسي"
			},
		},
	},
	{
		PackageName = "strategy", -- Exact package name from tebex
		Items = {
			{
				name = "money", -- Item or account name depending on type specified below
				amount = 5600000, -- Amount of item or money
				xp = 65000,
				type = "account", -- Four types: account, item, or weapon and car
				des = "💠 داعم استـراتـيـجـي"
			},
		},
	},
	{
		PackageName = "Item Package", -- Exact package name from tebex
		Items = {
			{
				name = "bandage", -- Item or account name depending on type specified below
				amount = 1, -- Amount of item or money
				type = "item" -- Four types: account, item, or weapon and car
			},
		},
	},
	{
		PackageName = "Weapons Package", -- Exact package name from tebex
		Items = {
			{
				name = "weapon_pistol", -- Item or account name depending on type specified below
				amount = 51, -- Amount of item or money
				type = "weapon" -- Four types: account, item, or weapon and car
			},
			{
				name = "weapon_assaultrifle_mk2", -- Item or account name depending on type specified below
				amount = 551, -- Amount of item or money
				type = "weapon" -- Four types: account, item, or weapon and car
			},
		},
	},
	{
		PackageName = "dnh", -- Exact package name from tebex
		Items = {
			{
				model = "dnh", -- Item or account name depending on type specified below
				type = "truck", -- car or truck
				job = "civ",
				name = "حمولة دينة 250 كيلو",
				priceold = "1000000000"
			},
		},
	},
	{
		PackageName = "redeye", -- Exact package name from tebex
		Items = {
			{
				model = "redeye", -- Item or account name depending on type specified below
				type = "car", -- Four types: account, item, or weapon and car
				job = "civ",
				name = "دودج تشالنجر",
				priceold = "1500000"
			},
		},
	},
	{
		PackageName = "GTR", -- Exact package name from tebex
		Items = {
			{
				model = "GTR", -- Item or account name depending on type specified below
				type = "car", -- Four types: account, item, or weapon and car
				job = "civ",
				name = "GTR",
				priceold = "1700000"
			},
		},
	},
	------------------------------------
	--------------------------------
	------------gas_stations---------------------
	---------------------------------------
	-----------------------------------
	-----------------------------------
	-- {
	-- 	PackageName = "gas_station_1", -- Exact package name from tebex
	-- 	Items = {
	-- 		{
	-- 			type = "gas_station", -- Four types: account, item, or weapon and car
	-- 			stationname = "gas_station_1",
	-- 			name = "محطة بنزين",
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	PackageName = "gas_station_3", -- Exact package name from tebex
	-- 	Items = {
	-- 		{
	-- 			type = "gas_station", -- Four types: account, item, or weapon and car
	-- 			stationname = "gas_station_3",
	-- 			name = "محطة بنزين",
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	PackageName = "gas_station_5", -- Exact package name from tebex
	-- 	Items = {
	-- 		{
	-- 			type = "gas_station", -- Four types: account, item, or weapon and car
	-- 			stationname = "gas_station_5",
	-- 			name = "محطة بنزين",
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	PackageName = "gas_station_6", -- Exact package name from tebex
	-- 	Items = {
	-- 		{
	-- 			type = "gas_station", -- Four types: account, item, or weapon and car
	-- 			stationname = "gas_station_6",
	-- 			name = "محطة بنزين",
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	PackageName = "gas_station_8", -- Exact package name from tebex
	-- 	Items = {
	-- 		{
	-- 			type = "gas_station", -- Four types: account, item, or weapon and car
	-- 			stationname = "gas_station_8",
	-- 			name = "محطة بنزين",
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	PackageName = "gas_station_13", -- Exact package name from tebex
	-- 	Items = {
	-- 		{
	-- 			type = "gas_station", -- Four types: account, item, or weapon and car
	-- 			stationname = "gas_station_13",
	-- 			name = "محطة بنزين",
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	PackageName = "gas_station_15", -- Exact package name from tebex
	-- 	Items = {
	-- 		{
	-- 			type = "gas_station", -- Four types: account, item, or weapon and car
	-- 			stationname = "gas_station_15",
	-- 			name = "محطة بنزين",
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	PackageName = "gas_station_16", -- Exact package name from tebex
	-- 	Items = {
	-- 		{
	-- 			type = "gas_station", -- Four types: account, item, or weapon and car
	-- 			stationname = "gas_station_16",
	-- 			name = "محطة بنزين",
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	PackageName = "gas_station_17", -- Exact package name from tebex
	-- 	Items = {
	-- 		{
	-- 			type = "gas_station", -- Four types: account, item, or weapon and car
	-- 			stationname = "gas_station_17",
	-- 			name = "محطة بنزين",
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	PackageName = "gas_station_18", -- Exact package name from tebex
	-- 	Items = {
	-- 		{
	-- 			type = "gas_station", -- Four types: account, item, or weapon and car
	-- 			stationname = "gas_station_18",
	-- 			name = "محطة بنزين",
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	PackageName = "gas_station_19", -- Exact package name from tebex
	-- 	Items = {
	-- 		{
	-- 			type = "gas_station", -- Four types: account, item, or weapon and car
	-- 			stationname = "gas_station_19",
	-- 			name = "محطة بنزين",
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	PackageName = "gas_station_21", -- Exact package name from tebex
	-- 	Items = {
	-- 		{
	-- 			type = "gas_station", -- Four types: account, item, or weapon and car
	-- 			stationname = "gas_station_21",
	-- 			name = "محطة بنزين",
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	PackageName = "gas_station_23", -- Exact package name from tebex
	-- 	Items = {
	-- 		{
	-- 			type = "gas_station", -- Four types: account, item, or weapon and car
	-- 			stationname = "gas_station_23",
	-- 			name = "محطة بنزين",
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	PackageName = "gas_station_25", -- Exact package name from tebex
	-- 	Items = {
	-- 		{
	-- 			type = "gas_station", -- Four types: account, item, or weapon and car
	-- 			stationname = "gas_station_25",
	-- 			name = "محطة بنزين",
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	PackageName = "gas_station_27", -- Exact package name from tebex
	-- 	Items = {
	-- 		{
	-- 			type = "gas_station", -- Four types: account, item, or weapon and car
	-- 			stationname = "gas_station_27",
	-- 			name = "محطة بنزين",
	-- 		},
	-- 	},
	-- },
}