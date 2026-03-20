Config = {

    Settings = {
        license = "45XC6DXZ9UWN",

    },

}

Config.DrawDistance               = 10.0 -- How close do you need to be for the markers to be drawn (in GTA units).
Config.MarkerType                 = {Cloakrooms = 20, Armories = 21, BossActions = 22, Vehicles = 36, Helicopters = 34, GiveBackMoney = 21, Liverys = 36, Tasleem = 2, deleteRecord = 2}
Config.MarkerSize                 = {x = 1.5, y = 1.5, z = 0.5}
--Config.MarkerColor                = {r = 50, g = 50, b = 204}
Config.MarkerColor                = {r = 0, g = 217, b = 33}

Config.EnablePlayerManagement     = true -- Enable if you want society managing.
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- Enable if you're using esx_identity.
Config.EnableLicenses             = true -- Enable if you're using esx_license.

Config.ShowRecordsMoney = 2000
Config.DeleteRecordsMoney = 10000

Config.EnableHandcuffTimer        = true -- Enable handcuff timer? will unrestrain player after the time ends.
Config.HandcuffTimer              = 10 * 60000 -- 10 minutes.

Config.EnableJobBlip              = true -- Enable blips for cops on duty, requires esx_society.
Config.EnableCustomPeds           = false -- Enable custom peds in cloak room? See Config.CustomPeds below to customize peds.

Config.EnableESXService           = false -- لاتعدل شي
Config.MaxInService               = -1 -- لاتعدل شي


Config.EnableServiceMain           = false --  تفعيل وإلغاء إذا موب مسجل دخول مايقدر يفتح قائمة الشرطة و الكراج وكذا

Config.bulletproof_cooltime = 10 --min

Config.Locale                     = 'en'

Config.timeBetwenImpoundMechanic = 100

Config.impoundxp = 80 
Config.impoundmoney = 5000

Config.impound = {
	location = {
		[1] = {label='حجز لوس سانتوس',coords=vector3(401.76,-1631.69,29.29),radius=10.0},
		[2] = {label='حجز ساندي شورز',coords=vector3(1743.81,3629.39,34.57),radius=20.0},
		[3] = {label='حجز بليتو',coords=vector3(-360.17,6071.86,31.5),radius=15.0},
		[4] = {label=' الميناء البحري الرئيسي مركز حرس الحدود',coords=vector3(815.21,-2931.13,5.91),radius=30.0},
		[5] = {label='2 الميناء البحري الغربي مركز حرس الحدود',coords=vector3(839.06,-2907.85,5.91),radius=25.0},
		[6] = {label='الميناء البحري الغربي',coords=vector3(-40.82,-2523.64,6.01),radius=15.0}
	}
}

Config.AgentStations = {
	LSPD = {

		Blip = {
			Coords  = vector3(799.1341, -2967.218, 17.77148),
			Sprite  = 487,
			Display = 4,
			Scale   = 1.2,
			Colour  = 2
		},

		Cloakrooms = {
            vector3(810.1630, -2952.3708, 5.980),		
			vector3(-53.32747, -2524.787, 7.391968),
		},

		Armories = {
			vector3(818.7297, -2952.448, 5.976562),
		},

		Liverys = {
			vector3(792.5275, -2943.099, 5.875488+0.4),
			vector3(797.0692, -2943.4285, 5.9048+0.4),
			vector3(801.6738, -2943.3489, 5.9084+0.4),
		},

		Vehicles = {

			{
				Spawner = vector3(784.34, -2943.12, 5.9),
				Spawner2 = vector3(-67.62198, -2520.237, 5.993408),
				InsideShop = vector3(784.34, -2943.12, 5.9),
				SpawnPoints = {
					{coords = vector3(792.5275, -2943.099, 5.875488), heading = 28.0845, radius = 6.0},
					{coords = vector3(801.6738, -2943.3489, 5.9084), heading = 25.9656, radius = 6.0},
					{coords = vector3(796.7860, -2942.8794, 5.9014), heading = 28.2857, radius = 6.0},
				}
			},
			
		},

		Helicopters = {
			{
				Spawner = vector3(798.7218, -2916.946, 7.834545),
				InsideShop = vector3(805.73, -2915.81, 12.09),
				SpawnPoints = {
					{coords = vector3(805.73, -2915.81, 12.09), heading = 266.67, radius = 6.0}
				}
			}
		},

		Tasleem = {
			vector3(815.0798, -2953.1714, 5.980)
		},

		BossActions = {
			vector3(799.5229, -2972.135, 5.980265),
		}

	},

	remove_sglat = {
		{ Pos = vector3(792.1763, -2963.7556, 5.9803), job = 'agent', Color = { r = 0, g = 255, b = 0 }},
	},

}

Config.WeaponsPrice = {
	WEAPON_PISTOL            = 3000,
	WEAPON_PUMPSHOTGUN       = 35000,
	WEAPON_ADVANCEDRIFLE     = 35000,
	WEAPON_CARBINERIFLE      = 45000,
	WEAPON_STUNGUN           = 5000,
	WEAPON_FLAREGUN          = 5000,
	WEAPON_FLARE             = 3000,
	WEAPON_NIGHTSTICK        = 0,
	WEAPON_FLASHLIGHT        = 0,
	WEAPON_PETROLCAN         = 0,
	WEAPON_FIREEXTINGUISHER  = 0
}

Config.AuthorizedWeapons = {
	recruit = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil }, price = Config.WeaponsPrice.WEAPON_PISTOL },
		{ weapon = 'WEAPON_NIGHTSTICK', price = Config.WeaponsPrice.WEAPON_NIGHTSTICK},
		{ weapon = 'WEAPON_STUNGUN',    price = Config.WeaponsPrice.WEAPON_STUNGUN },
		{ weapon = 'WEAPON_FLASHLIGHT', price = Config.WeaponsPrice.WEAPON_FLASHLIGHT },
		{ weapon = 'WEAPON_FLARE',      price = Config.WeaponsPrice.WEAPON_FLARE },
		{ weapon = 'WEAPON_PETROLCAN',  price = Config.WeaponsPrice.WEAPON_PETROLCAN },
		{ weapon = 'WEAPON_FIREEXTINGUISHER',  price = Config.WeaponsPrice.WEAPON_FIREEXTINGUISHER }
	},

	officer = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil }, price = Config.WeaponsPrice.WEAPON_PISTOL },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil },                  price = Config.WeaponsPrice.WEAPON_PUMPSHOTGUN },
		{ weapon = 'WEAPON_NIGHTSTICK', price = Config.WeaponsPrice.WEAPON_NIGHTSTICK},
		{ weapon = 'WEAPON_STUNGUN',    price = Config.WeaponsPrice.WEAPON_STUNGUN },
		{ weapon = 'WEAPON_FLASHLIGHT', price = Config.WeaponsPrice.WEAPON_FLASHLIGHT },
		{ weapon = 'WEAPON_FLARE',      price = Config.WeaponsPrice.WEAPON_FLARE },
		{ weapon = 'WEAPON_PETROLCAN',  price = Config.WeaponsPrice.WEAPON_PETROLCAN },
		{ weapon = 'WEAPON_FIREEXTINGUISHER',  price = Config.WeaponsPrice.WEAPON_FIREEXTINGUISHER }
	},

	sergeant = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil }, price = Config.WeaponsPrice.WEAPON_PISTOL },
		{ weapon = 'WEAPON_NIGHTSTICK', price = Config.WeaponsPrice.WEAPON_NIGHTSTICK},
		{ weapon = 'WEAPON_STUNGUN',    price = Config.WeaponsPrice.WEAPON_STUNGUN },
		{ weapon = 'WEAPON_FLASHLIGHT', price = Config.WeaponsPrice.WEAPON_FLASHLIGHT },
		{ weapon = 'WEAPON_FLARE',      price = Config.WeaponsPrice.WEAPON_FLARE },
		{ weapon = 'WEAPON_PETROLCAN',  price = Config.WeaponsPrice.WEAPON_PETROLCAN },
		{ weapon = 'WEAPON_FIREEXTINGUISHER',  price = Config.WeaponsPrice.WEAPON_FIREEXTINGUISHER }
	},

	intendent = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil }, price = Config.WeaponsPrice.WEAPON_PISTOL },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil },                  price = Config.WeaponsPrice.WEAPON_PUMPSHOTGUN },
		{ weapon = 'WEAPON_NIGHTSTICK', price = Config.WeaponsPrice.WEAPON_NIGHTSTICK},
		{ weapon = 'WEAPON_STUNGUN',    price = Config.WeaponsPrice.WEAPON_STUNGUN },
		{ weapon = 'WEAPON_FLASHLIGHT', price = Config.WeaponsPrice.WEAPON_FLASHLIGHT },
		{ weapon = 'WEAPON_FLARE',      price = Config.WeaponsPrice.WEAPON_FLARE },
		{ weapon = 'WEAPON_PETROLCAN',  price = Config.WeaponsPrice.WEAPON_PETROLCAN },
		{ weapon = 'WEAPON_FIREEXTINGUISHER',  price = Config.WeaponsPrice.WEAPON_FIREEXTINGUISHER }
	},

	lieutenant = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil }, price = Config.WeaponsPrice.WEAPON_PISTOL },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil },                  price = Config.WeaponsPrice.WEAPON_PUMPSHOTGUN },
		{ weapon = 'WEAPON_NIGHTSTICK', price = Config.WeaponsPrice.WEAPON_NIGHTSTICK},
		{ weapon = 'WEAPON_STUNGUN',    price = Config.WeaponsPrice.WEAPON_STUNGUN },
		{ weapon = 'WEAPON_FLASHLIGHT', price = Config.WeaponsPrice.WEAPON_FLASHLIGHT },
		{ weapon = 'WEAPON_FLARE',      price = Config.WeaponsPrice.WEAPON_FLARE },
		{ weapon = 'WEAPON_PETROLCAN',  price = Config.WeaponsPrice.WEAPON_PETROLCAN },
		{ weapon = 'WEAPON_FIREEXTINGUISHER',  price = Config.WeaponsPrice.WEAPON_FIREEXTINGUISHER }
	},

	chef = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil }, price = Config.WeaponsPrice.WEAPON_PISTOL },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil },                  price = Config.WeaponsPrice.WEAPON_PUMPSHOTGUN },
		{ weapon = 'WEAPON_NIGHTSTICK', price = Config.WeaponsPrice.WEAPON_NIGHTSTICK},
		{ weapon = 'WEAPON_STUNGUN',    price = Config.WeaponsPrice.WEAPON_STUNGUN },
		{ weapon = 'WEAPON_FLASHLIGHT', price = Config.WeaponsPrice.WEAPON_FLASHLIGHT },
		{ weapon = 'WEAPON_FLARE',      price = Config.WeaponsPrice.WEAPON_FLARE },
		{ weapon = 'WEAPON_PETROLCAN',  price = Config.WeaponsPrice.WEAPON_PETROLCAN },
		{ weapon = 'WEAPON_FIREEXTINGUISHER',  price = Config.WeaponsPrice.WEAPON_FIREEXTINGUISHER }
	},

	inspector = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil }, price = Config.WeaponsPrice.WEAPON_PISTOL },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil },                  price = Config.WeaponsPrice.WEAPON_PUMPSHOTGUN },
		{ weapon = 'WEAPON_NIGHTSTICK', price = Config.WeaponsPrice.WEAPON_NIGHTSTICK},
		{ weapon = 'WEAPON_STUNGUN',    price = Config.WeaponsPrice.WEAPON_STUNGUN },
		{ weapon = 'WEAPON_FLASHLIGHT', price = Config.WeaponsPrice.WEAPON_FLASHLIGHT },
		{ weapon = 'WEAPON_FLARE',      price = Config.WeaponsPrice.WEAPON_FLARE },
		{ weapon = 'WEAPON_PETROLCAN',  price = Config.WeaponsPrice.WEAPON_PETROLCAN },
		{ weapon = 'WEAPON_FIREEXTINGUISHER',  price = Config.WeaponsPrice.WEAPON_FIREEXTINGUISHER }
	},

	bigboss = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil },                 price = Config.WeaponsPrice.WEAPON_PISTOL },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil },                  price = Config.WeaponsPrice.WEAPON_PUMPSHOTGUN },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 9000, 15000, 4000, 10000, 10000, 8000, nil }, price = Config.WeaponsPrice.WEAPON_CARBINERIFLE },
		{ weapon = 'WEAPON_NIGHTSTICK',     price = Config.WeaponsPrice.WEAPON_NIGHTSTICK },
		{ weapon = 'WEAPON_STUNGUN',        price = Config.WeaponsPrice.WEAPON_STUNGUN },
		{ weapon = 'WEAPON_FLASHLIGHT',     price = Config.WeaponsPrice.WEAPON_FLASHLIGHT },
		{ weapon = 'WEAPON_FLARE',          price = Config.WeaponsPrice.WEAPON_FLARE },
		{ weapon = 'WEAPON_PETROLCAN',      price = Config.WeaponsPrice.WEAPON_PETROLCAN },
		{ weapon = 'WEAPON_FIREEXTINGUISHER',  price = Config.WeaponsPrice.WEAPON_FIREEXTINGUISHER }
	},

	captain = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil },                 price = Config.WeaponsPrice.WEAPON_PISTOL },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil },                  price = Config.WeaponsPrice.WEAPON_PUMPSHOTGUN },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 9000, 15000, 4000, 10000, 10000, 8000, nil }, price = Config.WeaponsPrice.WEAPON_CARBINERIFLE },
		{ weapon = 'WEAPON_NIGHTSTICK',     price = Config.WeaponsPrice.WEAPON_NIGHTSTICK },
		{ weapon = 'WEAPON_STUNGUN',        price = Config.WeaponsPrice.WEAPON_STUNGUN },
		{ weapon = 'WEAPON_FLASHLIGHT',     price = Config.WeaponsPrice.WEAPON_FLASHLIGHT },
		{ weapon = 'WEAPON_FLARE',          price = Config.WeaponsPrice.WEAPON_FLARE },
		{ weapon = 'WEAPON_PETROLCAN',      price = Config.WeaponsPrice.WEAPON_PETROLCAN },
		{ weapon = 'WEAPON_FIREEXTINGUISHER',  price = Config.WeaponsPrice.WEAPON_FIREEXTINGUISHER }
	},

	sany = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil },                 price = Config.WeaponsPrice.WEAPON_PISTOL },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil },                  price = Config.WeaponsPrice.WEAPON_PUMPSHOTGUN },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 9000, 15000, 4000, 10000, 10000, 8000, nil }, price = Config.WeaponsPrice.WEAPON_CARBINERIFLE },
		{ weapon = 'WEAPON_NIGHTSTICK',     price = Config.WeaponsPrice.WEAPON_NIGHTSTICK },
		{ weapon = 'WEAPON_STUNGUN',        price = Config.WeaponsPrice.WEAPON_STUNGUN },
		{ weapon = 'WEAPON_FLASHLIGHT',     price = Config.WeaponsPrice.WEAPON_FLASHLIGHT },
		{ weapon = 'WEAPON_FLARE',          price = Config.WeaponsPrice.WEAPON_FLARE },
		{ weapon = 'WEAPON_PETROLCAN',      price = Config.WeaponsPrice.WEAPON_PETROLCAN },
		{ weapon = 'WEAPON_FIREEXTINGUISHER',  price = Config.WeaponsPrice.WEAPON_FIREEXTINGUISHER }
	},

	sany2 = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil },                 price = Config.WeaponsPrice.WEAPON_PISTOL },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil },                  price = Config.WeaponsPrice.WEAPON_PUMPSHOTGUN },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 9000, 15000, 4000, 10000, 10000, 8000, nil }, price = Config.WeaponsPrice.WEAPON_CARBINERIFLE },
		{ weapon = 'WEAPON_NIGHTSTICK',     price = Config.WeaponsPrice.WEAPON_NIGHTSTICK },
		{ weapon = 'WEAPON_STUNGUN',        price = Config.WeaponsPrice.WEAPON_STUNGUN },
		{ weapon = 'WEAPON_FLASHLIGHT',     price = Config.WeaponsPrice.WEAPON_FLASHLIGHT },
		{ weapon = 'WEAPON_FLARE',          price = Config.WeaponsPrice.WEAPON_FLARE },
		{ weapon = 'WEAPON_PETROLCAN',      price = Config.WeaponsPrice.WEAPON_PETROLCAN },
		{ weapon = 'WEAPON_FIREEXTINGUISHER',  price = Config.WeaponsPrice.WEAPON_FIREEXTINGUISHER }
	},

	sany3 = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil },                 price = Config.WeaponsPrice.WEAPON_PISTOL },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil },                  price = Config.WeaponsPrice.WEAPON_PUMPSHOTGUN },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 9000, 15000, 4000, 10000, 10000, 8000, nil }, price = Config.WeaponsPrice.WEAPON_CARBINERIFLE },
		{ weapon = 'WEAPON_NIGHTSTICK',     price = Config.WeaponsPrice.WEAPON_NIGHTSTICK },
		{ weapon = 'WEAPON_STUNGUN',        price = Config.WeaponsPrice.WEAPON_STUNGUN },
		{ weapon = 'WEAPON_FLASHLIGHT',     price = Config.WeaponsPrice.WEAPON_FLASHLIGHT },
		{ weapon = 'WEAPON_FLARE',          price = Config.WeaponsPrice.WEAPON_FLARE },
		{ weapon = 'WEAPON_PETROLCAN',      price = Config.WeaponsPrice.WEAPON_PETROLCAN },
		{ weapon = 'WEAPON_FIREEXTINGUISHER',  price = Config.WeaponsPrice.WEAPON_FIREEXTINGUISHER }
	},

	fbi1 = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil },                 price = Config.WeaponsPrice.WEAPON_PISTOL },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil },                  price = Config.WeaponsPrice.WEAPON_PUMPSHOTGUN },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 9000, 15000, 4000, 10000, 10000, 8000, nil }, price = Config.WeaponsPrice.WEAPON_CARBINERIFLE },
		{ weapon = 'WEAPON_NIGHTSTICK',     price = Config.WeaponsPrice.WEAPON_NIGHTSTICK },
		{ weapon = 'WEAPON_STUNGUN',        price = Config.WeaponsPrice.WEAPON_STUNGUN },
		{ weapon = 'WEAPON_FLASHLIGHT',     price = Config.WeaponsPrice.WEAPON_FLASHLIGHT },
		{ weapon = 'WEAPON_FLARE',          price = Config.WeaponsPrice.WEAPON_FLARE },
		{ weapon = 'WEAPON_PETROLCAN',      price = Config.WeaponsPrice.WEAPON_PETROLCAN },
		{ weapon = 'WEAPON_FIREEXTINGUISHER',  price = Config.WeaponsPrice.WEAPON_FIREEXTINGUISHER }
	},

	high = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil },                 price = Config.WeaponsPrice.WEAPON_PISTOL },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil },                  price = Config.WeaponsPrice.WEAPON_PUMPSHOTGUN },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 9000, 15000, 4000, 10000, 10000, 8000, nil }, price = Config.WeaponsPrice.WEAPON_CARBINERIFLE },
		{ weapon = 'WEAPON_NIGHTSTICK',     price = Config.WeaponsPrice.WEAPON_NIGHTSTICK },
		{ weapon = 'WEAPON_STUNGUN',        price = Config.WeaponsPrice.WEAPON_STUNGUN },
		{ weapon = 'WEAPON_FLASHLIGHT',     price = Config.WeaponsPrice.WEAPON_FLASHLIGHT },
		{ weapon = 'WEAPON_FLARE',          price = Config.WeaponsPrice.WEAPON_FLARE },
		{ weapon = 'WEAPON_PETROLCAN',      price = Config.WeaponsPrice.WEAPON_PETROLCAN },
		{ weapon = 'WEAPON_FIREEXTINGUISHER',  price = Config.WeaponsPrice.WEAPON_FIREEXTINGUISHER }
	},

	high1 = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil },                 price = Config.WeaponsPrice.WEAPON_PISTOL },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil },                  price = Config.WeaponsPrice.WEAPON_PUMPSHOTGUN },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 9000, 15000, 4000, 10000, 10000, 8000, nil }, price = Config.WeaponsPrice.WEAPON_CARBINERIFLE },
		{ weapon = 'WEAPON_NIGHTSTICK',     price = Config.WeaponsPrice.WEAPON_NIGHTSTICK },
		{ weapon = 'WEAPON_STUNGUN',        price = Config.WeaponsPrice.WEAPON_STUNGUN },
		{ weapon = 'WEAPON_FLASHLIGHT',     price = Config.WeaponsPrice.WEAPON_FLASHLIGHT },
		{ weapon = 'WEAPON_FLARE',          price = Config.WeaponsPrice.WEAPON_FLARE },
		{ weapon = 'WEAPON_PETROLCAN',      price = Config.WeaponsPrice.WEAPON_PETROLCAN },
		{ weapon = 'WEAPON_FIREEXTINGUISHER',  price = Config.WeaponsPrice.WEAPON_FIREEXTINGUISHER }
	},

	high2 = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil },                 price = Config.WeaponsPrice.WEAPON_PISTOL },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil },                  price = Config.WeaponsPrice.WEAPON_PUMPSHOTGUN },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 9000, 15000, 4000, 10000, 10000, 8000, nil }, price = Config.WeaponsPrice.WEAPON_CARBINERIFLE },
		{ weapon = 'WEAPON_NIGHTSTICK',     price = Config.WeaponsPrice.WEAPON_NIGHTSTICK },
		{ weapon = 'WEAPON_STUNGUN',        price = Config.WeaponsPrice.WEAPON_STUNGUN },
		{ weapon = 'WEAPON_FLASHLIGHT',     price = Config.WeaponsPrice.WEAPON_FLASHLIGHT },
		{ weapon = 'WEAPON_FLARE',          price = Config.WeaponsPrice.WEAPON_FLARE },
		{ weapon = 'WEAPON_PETROLCAN',      price = Config.WeaponsPrice.WEAPON_PETROLCAN },
		{ weapon = 'WEAPON_FIREEXTINGUISHER',  price = Config.WeaponsPrice.WEAPON_FIREEXTINGUISHER }
	},

	bosstwo = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil },                 price = Config.WeaponsPrice.WEAPON_PISTOL },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil },                  price = Config.WeaponsPrice.WEAPON_PUMPSHOTGUN },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 9000, 15000, 4000, 10000, 10000, 8000, nil }, price = Config.WeaponsPrice.WEAPON_CARBINERIFLE },
		{ weapon = 'WEAPON_NIGHTSTICK',     price = Config.WeaponsPrice.WEAPON_NIGHTSTICK },
		{ weapon = 'WEAPON_STUNGUN',        price = Config.WeaponsPrice.WEAPON_STUNGUN },
		{ weapon = 'WEAPON_FLASHLIGHT',     price = Config.WeaponsPrice.WEAPON_FLASHLIGHT },
		{ weapon = 'WEAPON_FLARE',          price = Config.WeaponsPrice.WEAPON_FLARE },
		{ weapon = 'WEAPON_PETROLCAN',      price = Config.WeaponsPrice.WEAPON_PETROLCAN },
		{ weapon = 'WEAPON_FIREEXTINGUISHER',  price = Config.WeaponsPrice.WEAPON_FIREEXTINGUISHER }
	},
	
	boss = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil },                 price = Config.WeaponsPrice.WEAPON_PISTOL },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil },                  price = Config.WeaponsPrice.WEAPON_PUMPSHOTGUN },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 9000, 15000, 4000, 10000, 10000, 8000, nil }, price = Config.WeaponsPrice.WEAPON_CARBINERIFLE },
		{ weapon = 'WEAPON_NIGHTSTICK',     price = Config.WeaponsPrice.WEAPON_NIGHTSTICK },
		{ weapon = 'WEAPON_STUNGUN',        price = Config.WeaponsPrice.WEAPON_STUNGUN },
		{ weapon = 'WEAPON_FLASHLIGHT',     price = Config.WeaponsPrice.WEAPON_FLASHLIGHT },
		{ weapon = 'WEAPON_FLARE',          price = Config.WeaponsPrice.WEAPON_FLARE },
		{ weapon = 'WEAPON_PETROLCAN',      price = Config.WeaponsPrice.WEAPON_PETROLCAN },
		{ weapon = 'WEAPON_FIREEXTINGUISHER',  price = Config.WeaponsPrice.WEAPON_FIREEXTINGUISHER }
	}
}

Config.AuthorizedVehicles = {
	car = {
		recruit = {
		{model = 'gruppe3',label = 'دورية فورد اكسبلورر - شامل', price = 299000}
		},

		officer = {
		{model = 'gruppe1',label = 'دورية فورد كروان فكتوريا - شامل', price = 799000}
		},

		sergeant = {
		{model = '7rs02',label = 'فورد فيكتوريا', price = 100000}
		},

		intendent = {
		{model = '7rs02',label = 'فورد فيكتوريا', price = 100000},
		{model = '7rs03',label = 'فورد إكسبلور', price = 120000},
		},

		lieutenant = {
		{model = '7rs02',label = 'فورد فيكتوريا', price = 100000},
		{model = '7rs03',label = 'فورد إكسبلور', price = 120000},
		},

		chef = {
		{model = '7rs02',label = 'فورد فيكتوريا', price = 100000},
		{model = '7rs03',label = 'فورد إكسبلور', price = 120000},			
		},

		inspector = {
		{model = '7rs02',label = 'فورد فيكتوريا', price = 100000},
		{model = '7rs03',label = 'فورد إكسبلور', price = 120000},			
		},
		
		bigboss = {
		{model = '7rs02',label = 'فورد فيكتوريا', price = 100000},
		{model = '7rs03',label = 'فورد إكسبلور', price = 120000},
		{model = '7rs01',label = 'تاهو', price = 150000},		
		},		

		captain = {
		{model = '7rs02',label = 'فورد فيكتوريا', price = 100000},
		{model = '7rs03',label = 'فورد إكسبلور', price = 120000},
		{model = '7rs01',label = 'تاهو', price = 150000},				
		},

		sany = {
		{model = '7rs02',label = 'فورد فيكتوريا', price = 100000},
		{model = '7rs03',label = 'فورد إكسبلور', price = 120000},
		{model = '7rs01',label = 'تاهو', price = 150000},	
		},		

		sany2 = {
		{model = '7rs02',label = 'فورد فيكتوريا', price = 100000},
		{model = '7rs03',label = 'فورد إكسبلور', price = 120000},
		{model = '7rs01',label = 'تاهو', price = 150000},	
		{model = '7rs04',label = 'فورد تورس', price = 215000},
		},
		
		sany3 = {
		{model = '7rs02',label = 'فورد فيكتوريا', price = 100000},
		{model = '7rs03',label = 'فورد إكسبلور', price = 120000},
		{model = '7rs01',label = 'تاهو', price = 150000},	
		{model = '7rs04',label = 'فورد تورس', price = 215000},
		},

		sany4 = {
		{model = '7rs02',label = 'فورد فيكتوريا', price = 100000},
		{model = '7rs03',label = 'فورد إكسبلور', price = 120000},
		{model = '7rs01',label = 'تاهو', price = 150000},	
		{model = '7rs04',label = 'فورد تورس', price = 215000},
		},

		high = {
		{model = '7rs02',label = 'فورد فيكتوريا', price = 100000},
		{model = '7rs03',label = 'فورد إكسبلور', price = 120000},
		{model = '7rs01',label = 'تاهو', price = 150000},	
		{model = '7rs04',label = 'فورد تورس', price = 215000},
		{model = '7rs05',label = 'شارجر', price = 225000},
		},

		high1 = {
		{model = '7rs02',label = 'فورد فيكتوريا', price = 100000},
		{model = '7rs03',label = 'فورد إكسبلور', price = 120000},
		{model = '7rs01',label = 'تاهو', price = 150000},	
		{model = '7rs04',label = 'فورد تورس', price = 215000},
		{model = '7rs05',label = 'شارجر', price = 225000},
		},

		high2 = {
		{model = '7rs02',label = 'فورد فيكتوريا', price = 100000},
		{model = '7rs03',label = 'فورد إكسبلور', price = 120000},
		{model = '7rs01',label = 'تاهو', price = 150000},	
		{model = '7rs04',label = 'فورد تورس', price = 215000},
		{model = '7rs05',label = 'شارجر', price = 225000},		
		},
		
		bosstwo = {
		{model = '7rs02',label = 'فورد فيكتوريا', price = 100000},
		{model = '7rs03',label = 'فورد إكسبلور', price = 120000},
		{model = '7rs01',label = 'تاهو', price = 150000},	
		{model = '7rs04',label = 'فورد تورس', price = 215000},
		{model = '7rs05',label = 'شارجر', price = 225000},
		},

		boss = {
		{model = '7rs02',label = 'فورد فيكتوريا', price = 100000},
		{model = '7rs03',label = 'فورد إكسبلور', price = 120000},
		{model = '7rs01',label = 'تاهو', price = 150000},	
		{model = '7rs04',label = 'فورد تورس', price = 215000},
		{model = '7rs05',label = 'شارجر', price = 225000},		
		}
	},

	helicopter = {
		recruit = {},

		officer = {
		},

		sergeant = {
		},

		intendent = {
		},

		lieutenant = {
		},

		chef = {
		},

		inspector = {
			{model = 'polmav', props = {modLivery = 0}, price = 200000}
		},

		bigboss = {
			{model = 'polmav', props = {modLivery = 0}, price = 200000}
		},

		captain = {
			{model = 'polmav', props = {modLivery = 0}, price = 200000}
		},

		sany = {
			{model = 'polmav', props = {modLivery = 0}, price = 200000}
		},

		sany2 = {
			{model = 'polmav', props = {modLivery = 0}, price = 200000}
		},

		sany3 = {
			{model = 'polmav', props = {modLivery = 0}, price = 200000}
		},

		sany4 = {
			{model = 'polmav', props = {modLivery = 0}, price = 200000}
		},

		high = {
			{model = 'polmav', props = {modLivery = 0}, price = 200000}
		},

		high1 = {
			{model = 'polmav', props = {modLivery = 0}, price = 100000}
		},

		high2 = {
			{model = 'polmav', props = {modLivery = 0}, price = 100000}
		},

		bosstwo = {
			{model = 'polmav', props = {modLivery = 0}, price = 100000}
		},

		boss = {
			{model = 'polmav', props = {modLivery = 0}, price = 100000}
		}
	}
}

Config.CustomPeds = {
	shared = {
		--{label = 'Sheriff Ped', maleModel = 's_m_y_sheriff_01', femaleModel = 's_f_y_sheriff_01'},
		--{label = 'Agent Ped', maleModel = 's_m_y_cop_01', femaleModel = 's_f_y_cop_01'}
	},

	recruit = {},

	officer = {},

	sergeant = {},

	lieutenant = {},

	boss = {
		--{label = 'SWAT Ped', maleModel = 's_m_y_swat_01', femaleModel = 's_m_y_swat_01'}
	}
}

Config.mmno3at = {
	items = {beer = {xp = 6, money = 250},
	coke = {xp = 6, money = 250},
	coke_pooch = {xp = 6, money = 250},
	dia_box = {xp = 10, money = 500},
	gold_bar = {xp = 8, money = 350},
	grand_cru = {xp = 6, money = 250},
	meth =  {xp = 6, money = 250},
	meth_pooch = {xp = 6, money = 250},
	opium = {xp = 6, money = 250},
	opium_pooch = {xp = 6, money = 250},
	shark = {xp = 10, money = 400},
	turtle = {xp = 7, money = 280},
	weed = {xp = 6, money = 250},
	weed_pooch = {xp = 6, money = 250}},

	weapons = {
		WEAPON_BATTLEAXE = {xp = 4, money = 50},
		WEAPON_MACHETE = {xp = 4, money = 50},
		WEAPON_MICROSMG = {xp = 4, money = 50},
		WEAPON_PUMPSHOTGUN = {xp = 4, money = 50},
		WEAPON_SWITCHBLADE = {xp = 4, money = 50},
	},
}


-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements
Config.Uniforms = {
	[0] = {
		male = {
			tshirt_1 = 130,
			tshirt_2 = 0,
			torso_1 = 213,
			torso_2 = 0,
			shoes_1 = 25,
			shoes_2 = 0,
			helmet_1 = 106,
			helmet_2 = 1,
			arms = 31,
			pants_1 = 4,
			pants_2 = 3,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
		female = {
			torso_1 = 216,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 3,
			helmet_2 = 0,
			arms = 32,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
	},
	[1] = {
		male = {
			tshirt_1 = 130,
			tshirt_2 = 0,
			torso_1 = 213,
			torso_2 = 1,
			shoes_1 = 25,
			shoes_2 = 0,
			helmet_1 = 106,
			helmet_2 = 1,
			arms = 31,
			pants_1 = 4,
			pants_2 = 3,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
		female = {
			torso_1 = 208,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
	},
	[2] = {
		male = {
			tshirt_1 = 130,
			tshirt_2 = 0,
			torso_1 = 213,
			torso_2 = 2,
			shoes_1 = 25,
			shoes_2 = 0,
			helmet_1 = 106,
			helmet_2 = 1,
			arms = 31,
			pants_1 = 4,
			pants_2 = 3,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
		female = {
			torso_1 = 208,
			torso_2 = 3,
			shoes_1 = 25,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
	},
	[3] = {
		male = {
			tshirt_1 = 130,
			tshirt_2 = 0,
			torso_1 = 213,
			torso_2 = 3,
			shoes_1 = 25,
			shoes_2 = 0,
			helmet_1 = 106,
			helmet_2 = 1,
			arms = 31,
			pants_1 = 4,
			pants_2 = 3,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
		female = {
			torso_1 = 208,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
	},
	[4] = {
		male = {
			tshirt_1 = 130,
			tshirt_2 = 0,
			torso_1 = 213,
			torso_2 = 4,
			shoes_1 = 25,
			shoes_2 = 0,
			helmet_1 = 106,
			helmet_2 = 1,
			arms = 31,
			pants_1 = 4,
			pants_2 = 3,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
		female = {
			torso_1 = 208,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			pants_1 = 13,
			pants_2 = 0,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
	},
	[5] = {
		male = {
			tshirt_1 = 130,
			tshirt_2 = 0,
			torso_1 = 213,
			torso_2 = 5,
			shoes_1 = 25,
			shoes_2 = 0,
			helmet_1 = 106,
			helmet_2 = 1,
			arms = 31,
			pants_1 = 4,
			pants_2 = 3,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
		female = {
			torso_1 = 208,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
	},
	[6] = { -- وكيل ضابط أول حرس الحدود --
		male = {
			tshirt_1 = 130,
			tshirt_2 = 0,
			torso_1 = 213,
			torso_2 = 6,
			shoes_1 = 25,
			shoes_2 = 0,
			helmet_1 = 106,
			helmet_2 = 1,
			arms = 31,
			pants_1 = 4,
			pants_2 = 3,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
		female = {
			torso_1 = 208,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
	},
	[7] = {
		male = {
			tshirt_1 = 130,
			tshirt_2 = 0,
			torso_1 = 213,
			torso_2 = 7,
			shoes_1 = 25,
			shoes_2 = 0,
			helmet_1 = 106,
			helmet_2 = 1,
			arms = 31,
			pants_1 = 4,
			pants_2 = 3,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
		female = {
			torso_1 = 208,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
	},
	[8] = {
		male = {
			tshirt_1 = 130,
			tshirt_2 = 0,
			torso_1 = 213,
			torso_2 = 8,
			shoes_1 = 25,
			shoes_2 = 0,
			helmet_1 = 106,
			helmet_2 = 1,
			arms = 31,
			pants_1 = 4,
			pants_2 = 3,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
		female = {
			torso_1 = 208,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
	},
	[9] = {
		male = {
			tshirt_1 = 130,
			tshirt_2 = 0,
			torso_1 = 213,
			torso_2 = 9,
			shoes_1 = 25,
			shoes_2 = 0,
			helmet_1 = 106,
			helmet_2 = 1,
			arms = 31,
			pants_1 = 4,
			pants_2 = 3,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
		female = {
			torso_1 = 208,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
	},
	[10] = {
		male = {
			tshirt_1 = 130,
			tshirt_2 = 0,
			torso_1 = 213,
			torso_2 = 9,
			shoes_1 = 25,
			shoes_2 = 0,
			helmet_1 = 106,
			helmet_2 = 1,
			arms = 31,
			pants_1 = 4,
			pants_2 = 3,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
		female = {
			torso_1 = 208,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
	},
	[11] = {
		male = {
			tshirt_1 = 130,
			tshirt_2 = 0,
			torso_1 = 213,
			torso_2 = 9,
			shoes_1 = 25,
			shoes_2 = 0,
			helmet_1 = 106,
			helmet_2 = 1,
			arms = 31,
			pants_1 = 4,
			pants_2 = 3,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
		female = {
			torso_1 = 208,
			torso_2 = 11,
			shoes_1 = 25,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			pants_1 = 46,
			pants_2 = 0,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
	},
	[12] = {
		male = {
			tshirt_1 = 130,
			tshirt_2 = 0,
			torso_1 = 213,
			torso_2 = 9,
			shoes_1 = 25,
			shoes_2 = 0,
			helmet_1 = 106,
			helmet_2 = 1,
			arms = 31,
			pants_1 = 4,
			pants_2 = 3,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
		female = {
			torso_1 = 208,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 1,
			chain_2 = 0,
		},
	},
	[13] = {
		male = {
			tshirt_1 = 130,
			tshirt_2 = 0,
			torso_1 = 213,
			torso_2 = 9,
			shoes_1 = 25,
			shoes_2 = 0,
			helmet_1 = 106,
			helmet_2 = 1,
			arms = 31,
			pants_1 = 4,
			pants_2 = 3,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
		female = {
			tshirt_1 = 10,
			tshirt_2 = 0,
			shoes_1 = 25,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
	},
	[14] = {
		male = {
			tshirt_1 = 130,
			tshirt_2 = 0,
			torso_1 = 213,
			torso_2 = 9,
			shoes_1 = 25,
			shoes_2 = 0,
			helmet_1 = 106,
			helmet_2 = 1,
			arms = 31,
			pants_1 = 4,
			pants_2 = 3,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
		female = {
			torso_1 = 208,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
	},
	[15] = {
		male = {
			tshirt_1 = 130,
			tshirt_2 = 0,
			torso_1 = 213,
			torso_2 = 9,
			shoes_1 = 25,
			shoes_2 = 0,
			helmet_1 = 106,
			helmet_2 = 1,
			arms = 31,
			pants_1 = 4,
			pants_2 = 3,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
		female = {
			torso_1 = 208,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
	},
	[16] = {
		male = {
			tshirt_1 = 130,
			tshirt_2 = 0,
			torso_1 = 213,
			torso_2 = 9,
			shoes_1 = 25,
			shoes_2 = 0,
			helmet_1 = 106,
			helmet_2 = 1,
			arms = 31,
			pants_1 = 4,
			pants_2 = 3,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
		female = {
			torso_1 = 208,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			bproof_1 = 0,
			bproof_2 = 0,
			chain_1 = 0,
			chain_2 = 0,
		},
	},
	remove_bullet_wear = { -- إزالة مضاد رصاص
		male = {
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['bproof_1'] = 0,  ['bproof_2'] = 0
		}
	},

    rsme_wear = { -- 
		male = {
			['tshirt_1'] = 130,  ['tshirt_2'] = 0,
			['torso_1'] = 118,   ['torso_2'] = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 28,
			['pants_1'] = 33,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 107,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['glasses_1'] = 0, 	['glasses_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 0,  	['bproof_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,	
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	gilet_wear = { -- جاكيت التدريب
		male = {
			['tshirt_1'] = 59,  ['tshirt_2'] = 1
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1
		}
	}, 
	bullet_swat = { -- ضابط قوات خاصة
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 274,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 31,
			['pants_1'] = 25,   ['pants_2'] = 6,
			['shoes_1'] = 35,   ['shoes_2'] = 0,
			['helmet_1'] = 5,  ['helmet_2'] = 2,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['glasses_1'] = 24, 	['glasses_2'] = 1,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 52,    ['mask_2'] = 0,
			['bproof_1'] = 6,  	['bproof_2'] = 1,
			['chain_1'] = 0,    ['chain_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 53,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 31,
			['pants_1'] = 33,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 117,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 1,
			['glasses_1'] = 0, 	['glasses_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 52,    ['mask_2'] = 0,
			['bproof_1'] = 4,  	['bproof_2'] = 1,
			['chain_1'] = 1,    ['chain_2'] = 0
		},
	},
	cid_badge = { -- باقة الامن الجنائي
		male = {
			--['chain_1'] = 125,  ['chain_2'] = 0
			['chain_1'] = 128,  ['chain_2'] = 0
		},
		female = {
			['chain_1'] = 128,  ['chain_2'] = 0
		}
	},
	cid_badge_remove = { -- إزالة باقة الامن الجنائي
		male = {
			['chain_1'] = 0,  ['chain_2'] = 0
		},
		female = {
			['chain_1'] = 0,  ['chain_2'] = 0
		}
	},
	
	gun_bealt = {        	-- حزام مسدس
		male = {
			['tshirt_1'] = 130,  ['tshirt_2'] = 0
		},
		female = {       
			['tshirt_1'] = 130,  ['tshirt_2'] = 0
		}
	},
	radio_bealt = { -- حزام لاسلكي ومطاعة
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0
		},
		female = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0
		}
	},

	hzam = { -- حزام
		male = {
			['tshirt_1'] = 122,  ['tshirt_2'] = 0
		},
		female = {
			['tshirt_1'] = 122,  ['tshirt_2'] = 0
		}
	},

	weapon_one_in_rgl = {
		male = {
			['chain_1'] = 1,
			['chain_2'] = 0,
		},
		famle = {
			['chain_1'] = 1,
			['chain_2'] = 0,
		}
	},

	remove_weapon_one_in_rgl = {
		male = {
			['chain_1'] = 0,  ['chain_2'] = 0
		},
		female = {
			['chain_1'] = 0,  ['chain_2'] = 0
		}
	},

	remove_hzam = { -- حزام
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0
		}
	},

	black_jacket = { -- جاكيت اسود
		male = {
			['tshirt_1'] = 56,  ['tshirt_2'] = 0
		},
		female = {
			['tshirt_1'] = 56,  ['tshirt_2'] = 0
		}
	},   
	
	bullet_agent = { -- درع إدارة الشرطة
		male = {
			['bproof_1'] = 6,  ['bproof_2'] = 1
		},
		female = {
			['bproof_1'] = 21,  ['bproof_2'] = 0
		}
	},

	helmet_open_agent = { 	-- خوذة اسود مفتوح 
		male = {
			['helmet_1'] = 126,  ['helmet_2'] = 14
		},
		female = {
			['helmet_1'] = 126,  ['helmet_2'] = 18
		}
	},
	helmet_1 = { --بريهة أحمر
		male = {
			['helmet_1'] = 29,  ['helmet_2'] = 1,
		},
		female = {
			['helmet_1'] = 29,  ['helmet_2'] = 1,
		}
	},
	helmet_2 = { --كاب أسود
		male = {
			['helmet_1'] = 3,  ['helmet_2'] = 1,
		},
		female = {
			['helmet_1'] = 106,  ['helmet_2'] = 20,
		}
	},
	
	helmet_55 = { --بريهة أسود
		male = {
			['helmet_1'] = 29,  ['helmet_2'] = 0,
		},
		female = {
			['helmet_1'] = 29,  ['helmet_2'] = 0,
		}
	},
	
	helmet_close_agent = {	-- خوذة اسود مغلق
		male = {
			['helmet_1'] = 125,  ['helmet_2'] = 14
		},
		female = {
			['helmet_1'] = 125,  ['helmet_2'] = 18
		}
	},
	
	cid_wear = { -- مباحث
		male = {
			['tshirt_1'] = 130,  ['tshirt_2'] = 0,
			['torso_1'] = 43,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 11,
			['pants_1'] = 20,   ['pants_2'] = 2,
			['shoes_1'] = 14,   ['shoes_2'] = 2,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 130,  ['tshirt_2'] = 0,
			['torso_1'] = 43,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 11,
			['pants_1'] = 20,   ['pants_2'] = 2,
			['shoes_1'] = 14,   ['shoes_2'] = 2,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
    empty = { -- مباحث
		male = {
		},
		female = {
		}
	},
	
	mask_remove = { -- إزالة j
		male = {
			['mask_1'] = 0,		['mask_2'] = 0,
		},
		female = {
			['mask_1'] = 0,		['mask_2'] = 0,
		}
	},

	helmet_remove = { -- إزالة غطاء راس
		male = {
			['helmet_1'] = -1, ['helmet_2'] = 0
		},
		female = {
			['helmet_1'] = -1, ['helmet_2'] = 0
		}
	},

	bullet_wear = {
		male = {
			['bproof_1'] = 4,  	['bproof_2'] = 1,
		},
		female = {
			['bproof_1'] = 4,  	['bproof_2'] = 1,
		}
	},

	gilet_wear = {
		male = {
			tshirt_1 = 59,  tshirt_2 = 1
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1
		}
	}
}
return Config