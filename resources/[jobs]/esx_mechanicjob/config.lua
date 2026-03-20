Config = {}
Config.Locale                     = 'en'
Config.counter_login_mechanic = 0
Config.counter_login_ms3f = 0
Config.counter_login_agent = 0
Config.counter_swap_police = 0
Config.DrawDistance               = 20.0 -- How close you need to be in order for the markers to be drawn (in GTA units).
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true -- Enable society managing.
Config.EnableSocietyOwnedVehicles = false

Config.EnableServiceMain = true -- إيقاف تشغيل وتشغيل الحاجة لتسجيل الدخول للعمل و القائمة

Config.NPCSpawnDistance           = 500.0
Config.NPCNextToDistance          = 25.0
Config.NPCJobEarnings             = { min = 15, max = 40 }
Config.NPCJobEarningsXp             = { min = 5, max = 10 }

Config.MechanicCar = {
	--[[1373104750,
	-722261003,
	-1735036962,
	-1486714434--]]
	1353720154
}
Config.allowedTowModels = { 
    ['c3navistar'] = {x = -0.0, y = -1.85, z = 1.50},
    ['c3pwrollback'] = {x = -0.0, y = -2.35, z = 0.87},
    ['flatbed33'] = {x = -0.0, y = -1.15, z = 1.15},
    ['flatbed'] = {x = -0.0, y = -1.15, z = 1.15},
    ['bigtex40'] = {x = -0.0, y = -1.15, z = 1.15}
}


allowTowingBoats = false -- Set to true if you want to be able to tow boats.
allowTowingPlanes = false -- Set to true if you want to be able to tow planes.
allowTowingHelicopters = false -- Set to true if you want to be able to tow helicopters.
allowTowingTrains = false -- Set to true if you want to be able to tow trains.
allowTowingTrailers = true -- Disables trailers. NOTE: THIS ALSO DISABLES THE AIRTUG, TOWTRUCK, SADLER, AND ANY OTHER VEHICLE THAT IS IN THE UTILITY CLASS.

Config.vehcar = {
	32663974,
	-1872656223
}

Config.Vehicles = {
	'adder',
	'asea',
	'asterope',
	'banshee',
	'buffalo',
	'sultan',
	'baller3'
}

Config.Zones = {

	MechanicActions = {
		Pos   = { x = 831.8596, y = -980.5688, z = 32.07742},
		Size  = { x = 1.0, y = 1.0, z = 1.0 },
		Color = { r = 255, g = 255, b = 0 },
		Type  = 21
	},

	MechanicSandyShores = {
		Pos   = { x = 2208.2976, y = 2908.5554, z = 48.0371},
		Size  = { x = 1.0, y = 1.0, z = 1.0 },
		Color = { r = 255, g = 255, b = 0 },
		Type  = 21
	},

	MechanicLosSantos = {
		Pos   = {x = 93.0484, y = 6517.2480, z = 31.2553},
		Size  = { x = 1.0, y = 1.0, z = 1.0 },
		Color = { r = 255, g = 255, b = 0 },
		Type  = 21
	},

	MechanicCraftActions = {
		Pos   = {x = 808.6031, y = -928.0184, z = 25.97509},
		Size  = { x = 1.0, y = 1.0, z = 1.0 },
		Color = { r = 255, g = 255, b = 0 },
		Type  = 21
	},

	MechanicCraftSandyShores = {
		Pos   = {x = 2260.3537597656, y = 2901.1552734375, z = 48.027160644531},
		Size  = { x = 1.0, y = 1.0, z = 1.0 },
		Color = { r = 255, g = 255, b = 0 },
		Type  = 21
	},

	MechanicCraftLosSantos = {
		Pos   = {x = 803.54010009766, y = -963.13751220703, z = 25.975080490112},
		Size  = { x = 1.0, y = 1.0, z = 1.0 },
		Color = { r = 255, g = 255, b = 0 },
		Type  = 21
	},
	MechanicCraftActions2 = {
		Pos   = {x = 803.8461, y = -928.0092, z = 25.97509},
		Size  = { x = 1.0, y = 1.0, z = 1.0 },
		Color = { r = 255, g = 255, b = 0 },
		Type  = 21
	},

	MechanicCraftSandyShores2 = {
		Pos   = {x = 2260.3420410156, y = 2905.5419921875, z = 48.027168273926},
		Size  = { x = 1.0, y = 1.0, z = 1.0 },
		Color = { r = 255, g = 255, b = 0 },
		Type  = 21
	},

	MechanicCraftLosSantos2 = {
		Pos   = {x = 803.63116455078, y = -960.96350097656, z = 25.975080490112},
		Size  = { x = 1.0, y = 1.0, z = 1.0 },
		Color = { r = 255, g = 255, b = 0 },
		Type  = 21
	},

	--[[Garage = {
	Pos   = { x = -595.4299926757812, y = -1137.530029296875, z = 22.18000030517578 },
		Size  = { x = 0.0, y = 0.0, z = 0.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = -1
	},


--- مدينة لوس سانتوس
	Craft = { 
		Pos   = { x = -607.1500244140625, y = -1162.43994140625, z = 22.32999992370605 },
		Size  = { x = 0.5, y = 0.2, z = 0.5 },
		Color = { r = 50, g = 150, b = 204 },
		Type  = 21
	},

	CraftTwo = {
		Pos   = { x = -604.2453, y = -1162.513, z = 22.32854 },
		Size  = { x = 0.5, y = 0.2, z = 0.5 },
		Color = { r = 50, g = 150, b = 204 },
		Type  = 21
	},

--- مدينة ساندي شورز

	CraftThree = {
		Pos   = { x = 2250.13, y = 2910.74, z = 48.04 },
		Size  = { x = 0.5, y = 0.2, z = 0.5 },
		Color = { r = 50, g = 150, b = 204 },
		Type  = 21
	},

	CraftFour = {
		Pos   = { x = 2252.84, y = 2910.92, z = 48.04 },
		Size  = { x = 0.5, y = 0.2, z = 0.5 },
		Color = { r = 50, g = 150, b = 204 },
		Type  = 21
	},

	CraftFive = { 
		Pos   = { x = 178.83999633789065, y = 3159.699951171875, z = 43.22000122070312 },
		Size  = { x = 0.5, y = 0.2, z = 0.5 },
		Color = { r = 50, g = 150, b = 204 },
		Type  = 21
	},


	VehicleSpawnPoint = {
		Pos   = { x = 56.6255, y = 6525.0591, z = 31.2550 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = -1
	},

	VehicleDeleter = {
		Pos   = { x = -595.4099731445312, y = -1141.56005859375, z = 22.18000030517578 },
		Size  = { x = 2.5, y = 2.5, z = 2.5 },
		Color = { r = 204, g = 0, b = 0 },
		Type  = 36
	},

	VehicleDelivery = {
		Pos   = { x = 56.6255, y = 6525.0591, z = 31.2550 },
		Size  = { x = 20.0, y = 20.0, z = 3.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = -1
	}--]]
}


Config.timeBetwenImpoundMechanic = 100

Config.impoundxp = 600 
Config.impoundmoney = 10000

Config.impound = {
	location = {
		[1] = {label='حجز لوس سانتوس',coords=vector3(401.76,-1631.69,29.29),radius=10.0},
		[2] = {label='حجز ساندي شورز',coords=vector3(1743.81,3629.39,34.57),radius=20.0},
		[3] = {label='حجز بليتو',coords=vector3(-360.17,6071.86,31.5),radius=15.0}
	}
}

Config.Towables = {
	vector3(-2480.9, -212.0, 17.4),
	vector3(-2723.4, 13.2, 15.1),
	vector3(-3169.6, 976.2, 15.0),
	vector3(-3139.8, 1078.7, 20.2),
	vector3(-1656.9, -246.2, 54.5),
	vector3(-1586.7, -647.6, 29.4),
	vector3(-1036.1, -491.1, 36.2),
	vector3(-1029.2, -475.5, 36.4),
	vector3(75.2, 164.9, 104.7),
	vector3(-534.6, -756.7, 31.6),
	vector3(487.2, -30.8, 88.9),
	vector3(-772.2, -1281.8, 4.6),
	vector3(-663.8, -1207.0, 10.2),
	vector3(719.1, -767.8, 24.9),
	vector3(-971.0, -2410.4, 13.3),
	vector3(-1067.5, -2571.4, 13.2),
	vector3(-619.2, -2207.3, 5.6),
	vector3(1192.1, -1336.9, 35.1),
	vector3(-432.8, -2166.1, 9.9),
	vector3(-451.8, -2269.3, 7.2),
	vector3(939.3, -2197.5, 30.5),
	vector3(-556.1, -1794.7, 22.0),
	vector3(591.7, -2628.2, 5.6),
	vector3(1654.5, -2535.8, 74.5),
	vector3(1642.6, -2413.3, 93.1),
	vector3(1371.3, -2549.5, 47.6),
	vector3(383.8, -1652.9, 37.3),
	vector3(27.2, -1030.9, 29.4),
	vector3(229.3, -365.9, 43.8),
	vector3(-85.8, -51.7, 61.1),
	vector3(-4.6, -670.3, 31.9),
	vector3(-111.9, 92.0, 71.1),
	vector3(-314.3, -698.2, 32.5),
	vector3(-366.9, 115.5, 65.6),
	vector3(-592.1, 138.2, 60.1),
	vector3(-1613.9, 18.8, 61.8),
	vector3(-1709.8, 55.1, 65.7),
	vector3(-521.9, -266.8, 34.9),
	vector3(-451.1, -333.5, 34.0),
	vector3(322.4, -1900.5, 25.8)
}

for k,v in ipairs(Config.Towables) do
	Config.Zones['Towable' .. k] = {
		Pos   = v,
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = -1
	}
end

return Config