Config                            = {}

Config.DrawDistance               = 10.0 -- How close do you need to be for the markers to be drawn (in GTA units).
Config.MarkerType                 = {cloakroom = 2, Armories = 21, BossActions = 22, Vehicles = 36, Helicopters = 34, GiveBackMoney = 21, Liverys = 36, deleteRecord = 2, Tasleem = 2}
Config.MarkerSize                 = {x = 1.5, y = 1.5, z = 0.5}
Config.MarkerColor                = {r = 50, g = 50, b = 204}

Config.EnablePlayerManagement     = true -- Enable if you want society managing.
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- Enable if you're using esx_identity.
Config.EnableLicenses             = true -- Enable if you're using esx_license.

Config.EnableHandcuffTimer        = true -- Enable handcuff timer? will unrestrain player after the time ends.
Config.HandcuffTimer              = 10 * 60000 -- 10 minutes.

Config.EnableJobBlip              = true -- Enable blips for cops on duty, requires esx_society.
Config.EnableCustomPeds           = false -- Enable custom peds in cloak room? See Config.CustomPeds below to customize peds.

Config.EnableESXService           = false -- لاتغير شي واسحب عليه ولاتحذفه بس خليه وشكرا
Config.MaxInService               = -1 -- لاتعدل شي

Config.EnableServiceMain           = false --  تفعيل وإلغاء إذا موب مسجل دخول مايقدر يفتح قائمة الشرطة و الكراج وكذا

Config.bulletproof_cooltime = 10 --min

Config.Locale                     = 'en'

Config.timeBetwenImpoundMechanic = 100

Config.impoundxp = 80 
Config.impoundmoney = 5000

Config.ShowRecordsMoney = 2000
Config.DeleteRecordsMoney = 10000

Config.impound = {
	location = {
		[1] = {label='حجز لوس سانتوس',coords=vector3(401.76,-1631.69,29.29),radius=10.0},
		[2] = {label='حجز ساندي شورز',coords=vector3(1748.01,3642.55,35.01),radius=20.0},
		[3] = {label='حجز بليتو',coords=vector3(-360.17,6071.86,31.5),radius=15.0}
	}
}

Config.counter_login_police = 0

Config.CarsPolice = {
	{ name = 'باترول شرطة', model = 'doreat11'},
	{ name = 'دوج  دورانجو شرطة', model = 'doreat10'},
	{ name = 'ربع شرطة', model = 'doreat8'},
	{ name = 'يوكن شرطة', model = 'doreat5'},
	{ name = 'تورس شرطة', model = 'doreat3'},
	{ name = 'اكسبلور شرطة', model = 'doreat2'},
	{ name = 'فورد كراون فكتوريا شرطة', model = 'doreatb1'},
}

Config.Uniform = {
	[0] = {
		agent = { -- متدرب قوات حرس الحدود --
		m = {
			torso_1 = 190,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 42,
			helmet_2 = 0,
			arms = 30,
		},
		f = {
			torso_1 = 192,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			},
		},
		Police = { -- متدرب الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 99,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 4000,
				helmet_2 = 0,
				arms = 14,
			},
		},
		mrowr = { -- متدرب الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 10,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 87,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn1 = { -- متدرب قوات حرس الحدود --
		m = {
			torso_1 = 193,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 42,
			helmet_2 = 0,
			arms = 30,
		},
		f = {
			torso_1 = 99,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 4000,
			helmet_2 = 0,
			arms = 14,
			},
		},
		amn2 = { -- متدرب الشرطة --
			m = {
				torso_1 = 213,
				torso_2 = 0,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 0,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		refe = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 0,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
	},
	[1] = {
		agent = { -- وكيل عريف قوات حرس الحدود --
			m = {
				torso_2 = 1,
				helmet_2 = 0,
				shoes_1 = 24,
			},
			f = {
				torso_2 = 1,
				helmet_2 = 20,
				shoes_1 = 24,
			},
		},
		amn1 = { -- متدرب قوات حرس الحدود --
		m = {
			torso_1 = 193,
			torso_2 = 1,
			shoes_1 = 25,
			helmet_1 = 42,
			helmet_2 = 0,
			arms = 30,
		},
		f = {
			torso_1 = 192,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			},
		},
			amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 0,
				shoes_1 = 25,
				decals_1 = 12,
				decals_2 = 0,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		Police = { -- وكيل عريف الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 25,
				helmet_1 = 10,
				helmet_2 = 0,
				decals_1 = 12,
				decals_2 = 5,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 1,
				shoes_1 = 24,
				helmet_1 = 106,
				helmet_2 = 20,
				arms = 14,
			},
		},
		amn2 = { -- متدرب الشرطة --
			m = {
				torso_1 = 213,
				torso_2 = 1,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		mrowr = { -- متدرب الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 10,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				decals_1 = 12,
				decals_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 85,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		refe = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 0,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				decals_1 = 12,
				decals_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
	},
	[2] = {
		agent = { -- عريف قوات حرس الحدود --
			m = {
				torso_2 = 2,
				helmet_2 = 0,
				shoes_1 = 24,
			},
			f = {
				torso_2 = 2,
				helmet_2 = 20,
				shoes_1 = 24,
			},
		},
		amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 0,
				shoes_1 = 25,
				decals_1 = 12,
				decals_2 = 1,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn1 = { -- متدرب قوات حرس الحدود --
		m = {
			torso_1 = 193,
			torso_2 = 2,
			shoes_1 = 25,
			helmet_1 = 42,
			helmet_2 = 0,
			arms = 30,
		},
		f = {
			torso_1 = 192,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			},
		},
		Police = { -- وكيل عريف الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 25,
				helmet_1 = 10,
				helmet_2 = 0,
				decals_1 = 12,
				decals_2 = 6,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 2,
				shoes_1 = 24,
				helmet_1 = 106,
				helmet_2 = 20,
				arms = 14,
			},
		},
		amn2 = { -- متدرب الشرطة --
			m = {
				torso_1 = 213,
				torso_2 = 2,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		mrowr = { -- متدرب الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 10,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				decals_1 = 12,
				decals_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 85,
				torso_2 = 1,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		
		refe = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 0,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				decals_1 = 12,
				decals_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
	},
	[3] = {
		agent = { -- رقيب قوات حرس الحدود --
			m = {
				torso_2 = 3,
				helmet_2 = 0,
				shoes_1 = 24,
			},
			f = {
				torso_2 = 3,
				helmet_2 = 20,
				shoes_1 = 24,
			},
		},
		amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 0,
				shoes_1 = 25,
				decals_1 = 12,
				decals_2 = 2,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn1 = { -- متدرب قوات حرس الحدود --
		m = {
			torso_1 = 193,
			torso_2 = 3,
			shoes_1 = 25,
			helmet_1 = 42,
			helmet_2 = 0,
			arms = 30,
		},
		f = {
			torso_1 = 192,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			},
		},
		Police = { -- وكيل عريف الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 25,
				helmet_1 = 10,
				helmet_2 = 0,
				decals_1 = 12,
				decals_2 = 7,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 3,
				shoes_1 = 24,
				helmet_1 = 106,
				helmet_2 = 20,
				arms = 14,
			},
		},
		amn2 = { -- متدرب الشرطة --
			m = {
				torso_1 = 213,
				torso_2 = 4,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		mrowr = { -- متدرب الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 10,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 3,
				decals_1 = 12,
				decals_2 = 2,
				arms = 30,
			},
			f = {
				torso_1 = 85,
				torso_2 = 2,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},

		
		refe = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 0,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				decals_1 = 12,
				decals_2 = 2,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
	},
	[4] = {
		agent = { -- رقيب أول قوات حرس الحدود --
			m = {
				torso_2 = 4,
				helmet_2 = 0,
				shoes_1 = 24,
			},
			f = {
				torso_2 = 4,
				helmet_2 = 20,
				shoes_1 = 24,
			},
		},
		amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 0,
				shoes_1 = 25,
				decals_1 = 12,
				decals_2 = 3,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn1 = { -- متدرب قوات حرس الحدود --
		m = {
			torso_1 = 193,
			torso_2 = 4,
			shoes_1 = 25,
			helmet_1 = 42,
			helmet_2 = 0,
			arms = 30,
		},
		f = {
			torso_1 = 192,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			},
		},
		amn2 = { -- متدرب الشرطة --
			m = {
				torso_1 = 213,
				torso_2 = 4,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		tdryb = { -- متدرب الشرطة --
			m = {
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		Police = { -- وكيل عريف الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 25,
				helmet_1 = 10,
				helmet_2 = 0,
				decals_1 = 13,
				decals_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 1,
				shoes_1 = 24,
				helmet_1 = 106,
				helmet_2 = 20,
				arms = 14,
			},
		},
		mrowr = { -- متدرب الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 10,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 4,
				decals_1 = 12,
				decals_2 = 3,
				arms = 30,
			},
			f = {
				torso_1 = 84,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		refe = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 0,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				decals_1 = 12,
				decals_2 = 3,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
	},
	[5] = {
		agent = { -- وكيل ضابط قوات حرس الحدود --
			m = {
				torso_2 = 5,
				helmet_2 = 0,
				shoes_1 = 24,
			},
			f = {
				torso_2 = 5,
				helmet_2 = 20,
				shoes_1 = 24,
			},
		},
		tdryb = { -- متدرب الشرطة --
			m = {
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 0,
				shoes_1 = 25,
				decals_1 = 12,
				decals_2 = 4,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn1 = { -- متدرب قوات حرس الحدود --
		m = {
			torso_1 = 193,
			torso_2 = 5,
			shoes_1 = 25,
			helmet_1 = 42,
			helmet_2 = 0,
			arms = 30,
		},
		f = {
			torso_1 = 192,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			},
		},
		amn2 = { -- متدرب الشرطة --
			m = {
				torso_1 = 213,
				torso_2 = 5,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		Police = { -- وكيل عريف الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 25,
				helmet_1 = 10,
				helmet_2 = 0,
				decals_1 = 14,
				decals_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 1,
				shoes_1 = 24,
				helmet_1 = 106,
				helmet_2 = 20,
				arms = 14,
			},
		},
		mrowr = { -- متدرب الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 10,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 4,
				decals_1 = 12,
				decals_2 = 4,
				arms = 30,
			},
			f = {
				torso_1 = 84,
				torso_2 = 1,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		refe = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 0,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				decals_1 = 12,
				decals_2 = 4,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
	},
	[6] = { -- وكيل ضابط أول قوات حرس الحدود --
		agent = {
			m = {
				torso_2 = 0,
				helmet_2 = 0,
				decals_1 = 11,
				decals_2 = 1,
				shoes_1 = 24,
			},
			f = {
				torso_2 = 0,
				helmet_2 = 20,
				decals_1 = 11,
				decals_2 = 1,
				shoes_1 = 24,
			},
		},
		tdryb = { -- متدرب الشرطة --
			m = {
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 1,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn1 = { -- متدرب قوات حرس الحدود --
		m = {
			torso_1 = 73,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 42,
			helmet_2 = 0,
			arms = 30,
		},
		f = {
			torso_1 = 192,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			},
		},
		Police = { -- وكيل عريف الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 1,
				shoes_1 = 25,
				helmet_1 = 10,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 1,
				shoes_1 = 24,
				helmet_1 = 106,
				helmet_2 = 20,
				arms = 14,
			},
		},
		mrowr = { -- متدرب الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 11,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 4,
				arms = 30,
			},
			f = {
				torso_1 = 84,
				torso_2 = 2,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn2 = { -- متدرب الشرطة --
			m = {
				torso_1 = 213,
				torso_2 = 0,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				decals_1 = 11,
				decals_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		refe = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 1,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
	},
	[7] = {
		agent = { -- ملازم قوات حرس الحدود --
			m = {
				torso_2 = 0,
				helmet_2 = 20,
				decals_1 = 11,
				decals_2 = 2,
				shoes_1 = 25,
				
			},
			f = {
				torso_2 = 0,
				helmet_2 = 20,
				decals_1 = 11,
				decals_2 = 2,
				shoes_1 = 25,
			},
		},
		tdryb = { -- متدرب الشرطة --
			m = {
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 2,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn1 = { -- متدرب قوات حرس الحدود --
		m = {
			torso_1 = 73,
			torso_2 = 1,
			shoes_1 = 25,
			helmet_1 = 42,
			helmet_2 = 0,
			arms = 30,
		},
		f = {
			torso_1 = 192,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			},
		},
		Police = { -- ملازم الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 2,
				shoes_1 = 25,
				helmet_1 = 107,
				helmet_2 = 20,
				arms = 31,
			},
			f = {
				torso_1 = 195,
				torso_2 = 0,
				shoes_1 = 25,
				helmet_1 = 106,
				helmet_2 = 20,
				arms = 6,
			},
		},
		swat = { -- متدرب الشرطة --
		m = {
			torso_1 = 209,
			torso_2 = 1,
			shoes_1 = 25,
			helmet_1 = 107,
			helmet_2 = 20,
			arms = 31,
		},
		f = {
			torso_1 = 195,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 106,
			helmet_2 = 20,
			arms = 6,
		},
	},
		amn2 = { -- متدرب الشرطة --
			m = {
				torso_1 = 213,
				torso_2 = 0,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				decals_1 = 11,
				decals_2 = 2,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		mrowr = { -- متدرب الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 12,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 4,
				arms = 30,
			},
			f = {
				torso_1 = 86,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		refe = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 2,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
	},
	[8] = {
		agent = { -- ملازم أول قوات حرس الحدود --
			m = {
				torso_2 = 0,
				helmet_2 = 20,
				decals_1 = 11,
				decals_2 = 3,
				shoes_1 = 25,
			},
			f = {
				torso_2 = 0,
				helmet_2 = 20,
				decals_1 = 11,
				decals_2 = 3,
				shoes_1 = 25,
			},
		},
		tdryb = { -- متدرب الشرطة --
			m = {
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 3,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn1 = { -- متدرب قوات حرس الحدود --
		m = {
			torso_1 = 73,
			torso_2 = 2,
			shoes_1 = 25,
			helmet_1 = 42,
			helmet_2 = 0,
			arms = 30,
		},
		f = {
			torso_1 = 192,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			},
		},
		swat = { -- متدرب الشرطة --
		m = {
			torso_1 = 209,
			torso_2 = 2,
			shoes_1 = 25,
			helmet_1 = 107,
			helmet_2 = 20,
			arms = 31,
		},
		f = {
			torso_1 = 195,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 106,
			helmet_2 = 20,
			arms = 6,
		},
	},
		amn2 = { -- متدرب الشرطة --
			m = {
				torso_1 = 213,
				torso_2 = 0,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				decals_1 = 11,
				decals_2 = 3,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		Police = { -- ملازم أول الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 3,
				shoes_1 = 25,
				helmet_1 = 107,
				helmet_2 = 20,
				arms = 31,
			},
			f = {
				torso_1 = 195,
				torso_2 = 1,
				shoes_1 = 25,
				helmet_1 = 106,
				helmet_2 = 20,
				arms = 6,
			},
		},
		mrowr = { -- متدرب الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 13,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 4,
				arms = 30,
			},
			f = {
				torso_1 = 83,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		refe = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 3,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
	},
	[9] = {
		agent = { -- نقيب قوات حرس الحدود --
			m = {
				torso_2 = 0,
				helmet_2 = 20,
				decals_1 = 11,
				decals_2 = 4,
				shoes_1 = 25,
			},
			f = {
				torso_2 = 0,
				helmet_2 = 20,
				decals_1 = 11,
				decals_2 = 4,
				shoes_1 = 25,
			},
		},
		tdryb = { -- متدرب الشرطة --
			m = {
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 4,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn1 = { -- متدرب قوات حرس الحدود --
		m = {
			torso_1 = 73,
			torso_2 = 3,
			shoes_1 = 25,
			helmet_1 = 42,
			helmet_2 = 0,
			arms = 30,
		},
		f = {
			torso_1 = 192,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			},
		},
		swat = { -- متدرب الشرطة --
		m = {
			torso_1 = 209,
			torso_2 = 3,
			shoes_1 = 25,
			helmet_1 = 107,
			helmet_2 = 20,
			arms = 31,
		},
		f = {
			torso_1 = 195,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 106,
			helmet_2 = 20,
			arms = 6,
		},
	},
		Police = { -- نقيب الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 4,
				shoes_1 = 25,
				helmet_1 = 107,
				helmet_2 = 20,
				arms = 31,
			},
			f = {
				torso_1 = 195,
				torso_2 = 2,
				shoes_1 = 25,
				helmet_1 = 106,
				helmet_2 = 20,
				arms = 6,
			},
		},
		amn2 = { -- متدرب الشرطة --
			m = {
				torso_1 = 213,
				torso_2 = 0,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				decals_1 = 11,
				decals_2 = 4,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		mrowr = { -- متدرب الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 14,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 4,
				arms = 30,
			},
			f = {
				torso_1 = 83,
				torso_2 = 1,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		refe = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 3,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		refe = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 4,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
	},
	[10] = {
		agent = { -- رائد قوات حرس الحدود
			m = {
				torso_2 = 0,
				helmet_2 = 20,
				decals_1 = 11,
				decals_2 = 5,
				shoes_1 = 25,
			},
			f = {
				torso_2 = 0,
				helmet_2 = 20,
				decals_1 = 11,
				decals_2 = 5,
				shoes_1 = 25,
			},
		},
		tdryb = { -- متدرب الشرطة --
			m = {
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 5,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn1 = { -- متدرب قوات حرس الحدود --
		m = {
			torso_1 = 73,
			torso_2 = 4,
			shoes_1 = 25,
			helmet_1 = 42,
			helmet_2 = 0,
			arms = 30,
		},
		f = {
			torso_1 = 192,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			},
		},
		swat = { -- متدرب الشرطة --
		m = {
			torso_1 = 209,
			torso_2 = 4,
			shoes_1 = 25,
			helmet_1 = 107,
			helmet_2 = 20,
			arms = 31,
		},
		f = {
			torso_1 = 195,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 106,
			helmet_2 = 20,
			arms = 6,
		},
	},
		amn2 = { -- متدرب الشرطة --
			m = {
				torso_1 = 213,
				torso_2 = 0,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				decals_1 = 11,
				decals_2 = 5,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		Police = { -- رائد الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 5,
				shoes_1 = 25,
				helmet_1 = 107,
				helmet_2 = 20,
				arms = 31,
			},
			f = {
				torso_1 = 195,
				torso_2 = 3,
				shoes_1 = 25,
				helmet_1 = 106,
				helmet_2 = 20,
				arms = 6,
			},
		},
		mrowr = { -- متدرب الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 15,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 4,
				arms = 30,
			},
			f = {
				torso_1 = 83,
				torso_2 = 2,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		refe = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 5,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
	},
	[11] = {
		agent = {  -- مقدم قوات حرس الحدود --
			m = {
				torso_2 = 6,
				helmet_2 = 0,
				shoes_1 = 25,
			},
			f = {
				torso_2 = 6,
				helmet_2 = 0,
				shoes_1 = 25,
			},
		},
		tdryb = { -- متدرب الشرطة --
			m = {
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 6,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn1 = { -- متدرب قوات حرس الحدود --
		m = {
			torso_1 = 73,
			torso_2 = 5,
			shoes_1 = 25,
			helmet_1 = 42,
			helmet_2 = 0,
			arms = 30,
		},
		f = {
			torso_1 = 192,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			},
		},
		swat = { -- متدرب الشرطة --
		m = {
			torso_1 = 209,
			torso_2 = 5,
			shoes_1 = 25,
			helmet_1 = 107,
			helmet_2 = 20,
			arms = 31,
		},
		f = {
			torso_1 = 195,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 106,
			helmet_2 = 20,
			arms = 6,
		},
	},
		Police = { -- مقدم الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 6,
				shoes_1 = 25,
				helmet_1 = 107,
				helmet_2 = 20,
				arms = 31,
			},
			f = {
				torso_1 = 195,
				torso_2 = 0,
				shoes_1 = 25,
				helmet_1 = 106,
				helmet_2 = 20,
				arms = 6,
			},
		},
		mrowr = { -- متدرب الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 16,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 4,
				arms = 30,
			},
			f = {
				torso_1 = 83,
				torso_2 = 3,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		refe = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 6,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn2 = { -- متدرب الشرطة --
			m = {
				torso_1 = 213,
				torso_2 = 6,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				decals_1 = 11,
				decals_2 = 6,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
	},
	[102] = {
		agent = { --  مقدم ركن قوات حرس الحدود --
			m = {
				torso_2 = 7,
				helmet_2 = 0,
				shoes_1 = 25,
			},
			f = {
				torso_2 = 7,
				helmet_2 = 0,
				shoes_1 = 25,
			},
		},
		tdryb = { -- متدرب الشرطة --
			m = {
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 7,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn1 = { -- متدرب قوات حرس الحدود --
		m = {
			torso_1 = 73,
			torso_2 = 6,
			shoes_1 = 25,
			helmet_1 = 42,
			helmet_2 = 0,
			arms = 30,
		},
		f = {
			torso_1 = 192,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			},
		},
		swat = { 
		m = {
			torso_1 = 209,
			torso_2 = 5,
			shoes_1 = 25,
			helmet_1 = 107,
			helmet_2 = 20,
			arms = 31,
		},
		f = {
			torso_1 = 195,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 106,
			helmet_2 = 20,
			arms = 6,
		},
	},
		Police = { -- مقدم ركن الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 7,
				shoes_1 = 25,
				helmet_1 = 107,
				helmet_2 = 20,
				arms = 31,
			},
			f = {
				torso_1 = 195,
				torso_2 = 5,
				shoes_1 = 25,
				helmet_1 = 106,
				helmet_2 = 20,
				arms = 6,
			},
		},
		mrowr = { -- متدرب الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 17,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 4,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn2 = { -- متدرب الشرطة --
			m = {
				torso_1 = 213,
				torso_2 = 7,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				decals_1 = 11,
				decals_2 = 7,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		refe = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 7,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
	},
	[13] = {
		agent = { -- عقيد قوات حرس الحدود --
			m = {
				torso_2 = 8,
				helmet_2 = 0,
				shoes_1 = 25,
			},
			f = {
				torso_2 = 8,
				helmet_2 = 0,
				shoes_1 = 25,
			},
		},
		tdryb = { -- متدرب الشرطة --
			m = {
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 7,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn1 = { -- متدرب قوات حرس الحدود --
		m = {
			torso_1 = 73,
			torso_2 = 6,
			shoes_1 = 25,
			helmet_1 = 42,
			helmet_2 = 0,
			arms = 30,
		},
		f = {
			torso_1 = 192,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			},
		},
		swat = { -- متدرب الشرطة --
		m = {
			torso_1 = 209,
			torso_2 = 6,
			shoes_1 = 25,
			helmet_1 = 107,
			helmet_2 = 20,
			arms = 31,
		},
		f = {
			torso_1 = 195,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 106,
			helmet_2 = 20,
			arms = 6,
		},
	},
		Police = { -- عقيد الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 7,
				shoes_1 = 25,
				helmet_1 = 107,
				helmet_2 = 20,
				arms = 31,
			},
			f = {
				torso_1 = 195,
				torso_2 = 1,
				shoes_1 = 25,
				helmet_1 = 106,
				helmet_2 = 20,
				arms = 6,
			},
		},
		amn2 = { -- متدرب الشرطة --
			m = {
				torso_1 = 213,
				torso_2 = 7,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 8,
				decals_1 = 0,
				decals_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		mrowr = { -- متدرب الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 17,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 4,
				arms = 30,
			},
			f = {
				torso_1 = 83,
				torso_2 = 4,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		refe = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 7,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
	},
	[104] = {
		agent = { -- عقيد ركن قوات حرس الحدود --
			m = {
				torso_2 = 9,
				helmet_2 = 0,
				shoes_1 = 25,
			},
			f = {
				torso_2 = 9,
				helmet_2 = 0,
				shoes_1 = 25,
			},
		},
		amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 9,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		tdryb = { -- متدرب الشرطة --
			m = {
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn1 = { -- متدرب قوات حرس الحدود --
		m = {
			torso_1 = 73,
			torso_2 = 8,
			shoes_1 = 25,
			helmet_1 = 42,
			helmet_2 = 0,
			arms = 30,
		},
		f = {
			torso_1 = 192,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			},
		},
		swat = { -- متدرب الشرطة --
		m = {
			torso_1 = 209,
			torso_2 = 8,
			shoes_1 = 25,
			helmet_1 = 107,
			helmet_2 = 20,
			arms = 31,
		},
		f = {
			torso_1 = 195,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 106,
			helmet_2 = 20,
			arms = 6,
		},
	},
		Police = { -- عقيد ركن الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 9,
				shoes_1 = 25,
				helmet_1 = 107,
				helmet_2 = 20,
				arms = 31,
			},
			f = {
				torso_1 = 195,
				torso_2 = 8,
				shoes_1 = 25,
				helmet_1 = 106,
				helmet_2 = 20,
				arms = 6,
			},
		},
		amn2 = { -- متدرب الشرطة --
			m = {
				torso_1 = 213,
				torso_2 = 9,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				decals_1 = 11,
				decals_2 = 9,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		mrowr = { -- متدرب الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 20,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 4,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		refe = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 9,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
	},
	[15] = {
		agent = { -- عقيد ركن قوات حرس الحدود --
		m = {
			torso_2 = 9,
			helmet_2 = 0,
			shoes_1 = 25,
		},
		f = {
			torso_2 = 9,
			helmet_2 = 0,
			shoes_1 = 25,
		},
	},
	tdryb = { -- متدرب الشرطة --
			m = {
				shoes_1 = 25,
				helmet_1 = 27,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
	amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 8,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
	amn1 = { -- متدرب قوات حرس الحدود --
	m = {
		torso_1 = 73,
		torso_2 = 7,
		shoes_1 = 25,
		helmet_1 = 42,
		helmet_2 = 0,
		arms = 30,
	},
	f = {
		torso_1 = 192,
		torso_2 = 0,
		shoes_1 = 24,
		helmet_1 = 45,
		helmet_2 = 0,
		arms = 14,
		},
	},
	swat = { -- متدرب الشرطة --
	m = {
		torso_1 = 209,
		torso_2 = 7,
		shoes_1 = 25,
		helmet_1 = 107,
		helmet_2 = 20,
		arms = 31,
	},
	f = {
		torso_1 = 195,
		torso_2 = 0,
		shoes_1 = 25,
		helmet_1 = 106,
		helmet_2 = 20,
		arms = 6,
	},
},
	Police = { -- عقيد ركن الشرطة --
		m = {
			torso_1 = 208,
			torso_2 = 8,
			shoes_1 = 25,
			helmet_1 = 107,
			helmet_2 = 20,
			arms = 31,
		},
		f = {
			torso_1 = 195,
			torso_2 = 2,
			shoes_1 = 25,
			helmet_1 = 106,
			helmet_2 = 20,
			arms = 6,
		},
	},
	amn2 = { -- متدرب الشرطة --
		m = {
			torso_1 = 213,
			torso_2 = 8,
			shoes_1 = 25,
			helmet_1 = 28,
			helmet_2 = 1,
			decals_1 = 11,
			decals_2 = 9,
			arms = 30,
		},
		f = {
			torso_1 = 208,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
		},
	},
	mrowr = { -- متدرب الشرطة --
		m = {
			torso_1 = 208,
			torso_2 = 19,
			shoes_1 = 25,
			helmet_1 = 28,
			helmet_2 = 4,
			arms = 30,
		},
		f = {
			torso_1 = 83,
			torso_2 = 5,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
		},
	},
	refe = { -- متدرب الشرطة --
		m = {
			torso_1 = 210,
			torso_2 = 8,
			shoes_1 = 25,
			helmet_1 = 28,
			helmet_2 = 1,
			arms = 30,
		},
		f = {
			torso_1 = 208,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
		},
	},
	},
	[16] = {
		agent = { -- عقيد ركن قوات حرس الحدود --
		m = {
			torso_2 = 9,
			helmet_2 = 0,
			shoes_1 = 25,
		},
		f = {
			torso_2 = 9,
			helmet_2 = 0,
			shoes_1 = 25,
		},
	},
	tdryb = { -- متدرب الشرطة --
			m = {
				shoes_1 = 25,
				helmet_1 = 27,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
	amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 8,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
	amn1 = { -- متدرب قوات حرس الحدود --
	m = {
		torso_1 = 73,
		torso_2 = 7,
		shoes_1 = 25,
		helmet_1 = 42,
		helmet_2 = 0,
		arms = 30,
	},
	f = {
		torso_1 = 192,
		torso_2 = 0,
		shoes_1 = 24,
		helmet_1 = 45,
		helmet_2 = 0,
		arms = 14,
		},
	},
	swat = { -- متدرب الشرطة --
	m = {
		torso_1 = 209,
		torso_2 = 7,
		shoes_1 = 25,
		helmet_1 = 107,
		helmet_2 = 20,
		arms = 31,
	},
	f = {
		torso_1 = 195,
		torso_2 = 0,
		shoes_1 = 25,
		helmet_1 = 106,
		helmet_2 = 20,
		arms = 6,
	},
},
	Police = { -- عقيد ركن الشرطة --
		m = {
			torso_1 = 208,
			torso_2 = 8,
			shoes_1 = 25,
			helmet_1 = 107,
			helmet_2 = 20,
			arms = 31,
		},
		f = {
			torso_1 = 195,
			torso_2 = 2,
			shoes_1 = 25,
			helmet_1 = 106,
			helmet_2 = 20,
			arms = 6,
		},
	},
	amn2 = { -- متدرب الشرطة --
		m = {
			torso_1 = 213,
			torso_2 = 8,
			shoes_1 = 25,
			helmet_1 = 28,
			helmet_2 = 1,
			decals_1 = 11,
			decals_2 = 9,
			arms = 30,
		},
		f = {
			torso_1 = 208,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
		},
	},
	mrowr = { -- متدرب الشرطة --
		m = {
			torso_1 = 208,
			torso_2 = 19,
			shoes_1 = 25,
			helmet_1 = 28,
			helmet_2 = 4,
			arms = 30,
		},
		f = {
			torso_1 = 83,
			torso_2 = 5,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
		},
	},
	refe = { -- متدرب الشرطة --
		m = {
			torso_1 = 210,
			torso_2 = 8,
			shoes_1 = 25,
			helmet_1 = 28,
			helmet_2 = 1,
			arms = 30,
		},
		f = {
			torso_1 = 208,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
		},
	},
	},
	[101] = {
		agent = {  -- مقدم قوات حرس الحدود --
			m = {
				torso_2 = 6,
				helmet_2 = 0,
				shoes_1 = 25,
			},
			f = {
				torso_2 = 6,
				helmet_2 = 0,
				shoes_1 = 25,
			},
		},
		tdryb = { -- متدرب الشرطة --
			m = {
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 6,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn1 = { -- متدرب قوات حرس الحدود --
		m = {
			torso_1 = 73,
			torso_2 = 5,
			shoes_1 = 25,
			helmet_1 = 42,
			helmet_2 = 0,
			arms = 30,
		},
		f = {
			torso_1 = 192,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			},
		},
		swat = { -- متدرب الشرطة --
		m = {
			torso_1 = 209,
			torso_2 = 5,
			shoes_1 = 25,
			helmet_1 = 107,
			helmet_2 = 20,
			arms = 31,
		},
		f = {
			torso_1 = 195,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 106,
			helmet_2 = 20,
			arms = 6,
		},
	},
		Police = { -- مقدم الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 6,
				shoes_1 = 25,
				helmet_1 = 107,
				helmet_2 = 20,
				arms = 31,
			},
			f = {
				torso_1 = 195,
				torso_2 = 4,
				shoes_1 = 25,
				helmet_1 = 106,
				helmet_2 = 20,
				arms = 6,
			},
		},
		mrowr = { -- متدرب الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 16,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 4,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		refe = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 6,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn2 = { -- متدرب الشرطة --
			m = {
				torso_1 = 213,
				torso_2 = 6,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				decals_1 = 11,
				decals_2 = 6,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
	},
	[12] = {
		agent = { --  مقدم ركن قوات حرس الحدود --
			m = {
				torso_2 = 7,
				helmet_2 = 0,
				shoes_1 = 25,
			},
			f = {
				torso_2 = 7,
				helmet_2 = 0,
				shoes_1 = 25,
			},
		},
		tdryb = { -- متدرب الشرطة --
			m = {
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 6,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn1 = { -- متدرب قوات حرس الحدود --
		m = {
			torso_1 = 73,
			torso_2 = 6,
			shoes_1 = 25,
			helmet_1 = 42,
			helmet_2 = 0,
			arms = 30,
		},
		f = {
			torso_1 = 192,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			},
		},
		swat = { -- متدرب الشرطة --
		m = {
			torso_1 = 209,
			torso_2 = 5,
			shoes_1 = 25,
			helmet_1 = 107,
			helmet_2 = 20,
			arms = 31,
		},
		f = {
			torso_1 = 195,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 106,
			helmet_2 = 20,
			arms = 6,
		},
	},
		Police = { -- مقدم ركن الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 6,
				shoes_1 = 25,
				helmet_1 = 107,
				helmet_2 = 20,
				arms = 31,
			},
			f = {
				torso_1 = 195,
				torso_2 = 0,
				shoes_1 = 25,
				helmet_1 = 106,
				helmet_2 = 20,
				arms = 6,
			},
		},
		mrowr = { -- متدرب الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 16,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 4,
				arms = 30,
			},
			f = {
				torso_1 = 83,
				torso_2 = 3,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn2 = { -- متدرب الشرطة --
			m = {
				torso_1 = 213,
				torso_2 = 6,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				decals_1 = 11,
				decals_2 = 7,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		refe = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 7,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
	},
	[103] = {
		agent = { -- عقيد قوات حرس الحدود --
			m = {
				torso_2 = 8,
				helmet_2 = 0,
				shoes_1 = 25,
			},
			f = {
				torso_2 = 8,
				helmet_2 = 0,
				shoes_1 = 25,
			},
		},
		tdryb = { -- متدرب الشرطة --
			m = {
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 8,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn1 = { -- متدرب قوات حرس الحدود --
		m = {
			torso_1 = 73,
			torso_2 = 7,
			shoes_1 = 25,
			helmet_1 = 42,
			helmet_2 = 0,
			arms = 30,
		},
		f = {
			torso_1 = 192,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			},
		},
		swat = { -- متدرب الشرطة --
		m = {
			torso_1 = 209,
			torso_2 = 7,
			shoes_1 = 25,
			helmet_1 = 107,
			helmet_2 = 20,
			arms = 31,
		},
		f = {
			torso_1 = 195,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 106,
			helmet_2 = 20,
			arms = 6,
		},
	},
		Police = { -- عقيد الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 8,
				shoes_1 = 25,
				helmet_1 = 107,
				helmet_2 = 20,
				arms = 31,
			},
			f = {
				torso_1 = 195,
				torso_2 = 6,
				shoes_1 = 25,
				helmet_1 = 106,
				helmet_2 = 20,
				arms = 6,
			},
		},
		amn2 = { -- متدرب الشرطة --
			m = {
				torso_1 = 213,
				torso_2 = 8,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 8,
				decals_1 = 0,
				decals_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		mrowr = { -- متدرب الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 19,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 4,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		refe = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 8,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
	},
	[14] = {
		agent = { -- عقيد قوات حرس الحدود --
			m = {
				torso_2 = 8,
				helmet_2 = 0,
				shoes_1 = 25,
			},
			f = {
				torso_2 = 8,
				helmet_2 = 0,
				shoes_1 = 25,
			},
		},
		tdryb = { -- متدرب الشرطة --
			m = {
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 7,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn1 = { -- متدرب قوات حرس الحدود --
		m = {
			torso_1 = 73,
			torso_2 = 6,
			shoes_1 = 25,
			helmet_1 = 42,
			helmet_2 = 0,
			arms = 30,
		},
		f = {
			torso_1 = 192,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			},
		},
		swat = { -- متدرب الشرطة --
		m = {
			torso_1 = 209,
			torso_2 = 6,
			shoes_1 = 25,
			helmet_1 = 107,
			helmet_2 = 20,
			arms = 31,
		},
		f = {
			torso_1 = 195,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 106,
			helmet_2 = 20,
			arms = 6,
		},
	},
		Police = { -- عقيد الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 7,
				shoes_1 = 25,
				helmet_1 = 107,
				helmet_2 = 20,
				arms = 31,
			},
			f = {
				torso_1 = 195,
				torso_2 = 1,
				shoes_1 = 25,
				helmet_1 = 106,
				helmet_2 = 20,
				arms = 6,
			},
		},
		amn2 = { -- متدرب الشرطة --
			m = {
				torso_1 = 213,
				torso_2 = 7,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 8,
				decals_1 = 0,
				decals_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		mrowr = { -- متدرب الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 17,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 4,
				arms = 30,
			},
			f = {
				torso_1 = 83,
				torso_2 = 4,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		refe = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 7,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
	},

	[17] = {
		agent = { -- عقيد قوات حرس الحدود --
			m = {
				torso_2 = 8,
				helmet_2 = 0,
				shoes_1 = 25,
			},
			f = {
				torso_2 = 8,
				helmet_2 = 0,
				shoes_1 = 25,
			},
		},
		tdryb = { -- متدرب الشرطة --
			m = {
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 9,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn1 = { -- متدرب قوات حرس الحدود --
		m = {
			torso_1 = 73,
			torso_2 = 9,
			shoes_1 = 25,
			helmet_1 = 42,
			helmet_2 = 0,
			arms = 30,
		},
		f = {
			torso_1 = 192,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			},
		},
		swat = { -- متدرب الشرطة --
		m = {
			torso_1 = 209,
			torso_2 = 8,
			shoes_1 = 25,
			helmet_1 = 107,
			helmet_2 = 20,
			arms = 31,
		},
		f = {
			torso_1 = 195,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 106,
			helmet_2 = 20,
			arms = 6,
		},
	},
		Police = { -- عقيد الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 9,
				shoes_1 = 25,
				helmet_1 = 107,
				helmet_2 = 20,
				arms = 31,
			},
			f = {
				torso_1 = 195,
				torso_2 = 3,
				shoes_1 = 25,
				helmet_1 = 106,
				helmet_2 = 20,
				arms = 6,
			},
		},
		amn2 = { -- متدرب الشرطة --
			m = {
				torso_1 = 213,
				torso_2 = 9,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 8,
				decals_1 = 0,
				decals_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		mrowr = { -- متدرب الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 20,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 4,
				arms = 30,
			},
			f = {
				torso_1 = 83,
				torso_2 = 6,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		refe = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 9,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
	},

	[18] = {
		agent = { -- عقيد قوات حرس الحدود --
			m = {
				torso_2 = 8,
				helmet_2 = 0,
				shoes_1 = 25,
			},
			f = {
				torso_2 = 8,
				helmet_2 = 0,
				shoes_1 = 25,
			},
		},
		tdryb = { -- متدرب الشرطة --
			m = {
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 9,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn1 = { -- متدرب قوات حرس الحدود --
		m = {
			torso_1 = 73,
			torso_2 = 9,
			shoes_1 = 25,
			helmet_1 = 42,
			helmet_2 = 0,
			arms = 30,
		},
		f = {
			torso_1 = 192,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			},
		},
		swat = { -- متدرب الشرطة --
		m = {
			torso_1 = 209,
			torso_2 = 8,
			shoes_1 = 25,
			helmet_1 = 107,
			helmet_2 = 20,
			arms = 31,
		},
		f = {
			torso_1 = 195,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 106,
			helmet_2 = 20,
			arms = 6,
		},
	},
		Police = { -- عقيد الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 9,
				shoes_1 = 25,
				helmet_1 = 107,
				helmet_2 = 20,
				arms = 31,
			},
			f = {
				torso_1 = 195,
				torso_2 = 3,
				shoes_1 = 25,
				helmet_1 = 106,
				helmet_2 = 20,
				arms = 6,
			},
		},
		amn2 = { -- متدرب الشرطة --
			m = {
				torso_1 = 213,
				torso_2 = 9,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 8,
				decals_1 = 0,
				decals_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		mrowr = { -- متدرب الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 20,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 4,
				arms = 30,
			},
			f = {
				torso_1 = 83,
				torso_2 = 6,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		refe = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 9,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
	},
	[19] = {
		agent = { -- عقيد قوات حرس الحدود --
			m = {
				torso_2 = 8,
				helmet_2 = 0,
				shoes_1 = 25,
			},
			f = {
				torso_2 = 8,
				helmet_2 = 0,
				shoes_1 = 25,
			},
		},
		tdryb = { -- متدرب الشرطة --
			m = {
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 10,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn1 = { -- متدرب قوات حرس الحدود --
		m = {
			torso_1 = 73,
			torso_2 = 10,
			shoes_1 = 25,
			helmet_1 = 42,
			helmet_2 = 0,
			arms = 30,
		},
		f = {
			torso_1 = 192,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			},
		},
		swat = { -- متدرب الشرطة --
		m = {
			torso_1 = 209,
			torso_2 = 9,
			shoes_1 = 25,
			helmet_1 = 107,
			helmet_2 = 20,
			arms = 31,
		},
		f = {
			torso_1 = 195,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 106,
			helmet_2 = 20,
			arms = 6,
		},
	},
		Police = { -- عقيد الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 1,
				shoes_1 = 25,
				helmet_1 = 107,
				helmet_2 = 20,
				arms = 31,
			},
			f = {
				torso_1 = 195,
				torso_2 = 4,
				shoes_1 = 25,
				helmet_1 = 106,
				helmet_2 = 20,
				arms = 6,
			},
		},
		amn2 = { -- متدرب الشرطة --
			m = {
				torso_1 = 213,
				torso_2 = 10,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 8,
				decals_1 = 0,
				decals_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		mrowr = { -- متدرب الشرطة --
			m = {
				torso_1 = 225,
				torso_2 = 0,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 4,
				arms = 30,
			},
			f = {
				torso_1 = 86,
				torso_2 = 1,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		refe = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 10,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
	},		[20] = {
		agent = { -- عقيد قوات حرس الحدود --
			m = {
				torso_2 = 8,
				helmet_2 = 0,
				shoes_1 = 25,
			},
			f = {
				torso_2 = 8,
				helmet_2 = 0,
				shoes_1 = 25,
			},
		},
		tdryb = { -- متدرب الشرطة --
			m = {
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 10,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn1 = { -- متدرب قوات حرس الحدود --
		m = {
			torso_1 = 73,
			torso_2 = 10,
			shoes_1 = 25,
			helmet_1 = 42,
			helmet_2 = 0,
			arms = 30,
		},
		f = {
			torso_1 = 192,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			},
		},
		swat = { -- متدرب الشرطة --
		m = {
			torso_1 = 209,
			torso_2 = 10,
			shoes_1 = 25,
			helmet_1 = 107,
			helmet_2 = 20,
			arms = 31,
		},
		f = {
			torso_1 = 195,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 106,
			helmet_2 = 20,
			arms = 6,
		},
	},
		Police = { -- عقيد الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 25,
				helmet_1 = 107,
				helmet_2 = 20,
				arms = 31,
			},
			f = {
				torso_1 = 195,
				torso_2 = 5,
				shoes_1 = 25,
				helmet_1 = 106,
				helmet_2 = 20,
				arms = 6,
			},
		},
		amn2 = { -- متدرب الشرطة --
			m = {
				torso_1 = 213,
				torso_2 = 10,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 8,
				decals_1 = 0,
				decals_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		mrowr = { -- متدرب الشرطة --
			m = {
				torso_1 = 225,
				torso_2 = 1,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 4,
				arms = 30,
			},
			f = {
				torso_1 = 86,
				torso_2 = 2,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		refe = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 10,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},

	},
	[23] = {
		agent = { -- عقيد قوات حرس الحدود --
			m = {
				torso_2 = 8,
				helmet_2 = 0,
				shoes_1 = 25,
			},
			f = {
				torso_2 = 8,
				helmet_2 = 0,
				shoes_1 = 25,
			},
		},
		tdryb = { -- متدرب الشرطة --
			m = {
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 11,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn1 = { -- متدرب قوات حرس الحدود --
		m = {
			torso_1 = 73,
			torso_2 = 11,
			shoes_1 = 25,
			helmet_1 = 42,
			helmet_2 = 0,
			arms = 30,
		},
		f = {
			torso_1 = 192,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			},
		},
		swat = { -- متدرب الشرطة --
		m = {
			torso_1 = 209,
			torso_2 = 10,
			shoes_1 = 25,
			helmet_1 = 107,
			helmet_2 = 20,
			arms = 31,
		},
		f = {
			torso_1 = 195,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 106,
			helmet_2 = 20,
			arms = 6,
		},
	},
		Police = { -- عقيد الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 25,
				helmet_1 = 107,
				helmet_2 = 20,
				arms = 31,
			},
			f = {
				torso_1 = 195,
				torso_2 = 5,
				shoes_1 = 25,
				helmet_1 = 106,
				helmet_2 = 20,
				arms = 6,
			},
		},
		amn2 = { -- متدرب الشرطة --
			m = {
				torso_1 = 213,
				torso_2 = 11,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 8,
				decals_1 = 0,
				decals_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		mrowr = { -- متدرب الشرطة --
			m = {
				torso_1 = 225,
				torso_2 = 1,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 4,
				arms = 30,
			},
			f = {
				torso_1 = 86,
				torso_2 = 2,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		refe = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 11,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},

	},	[24] = {
		agent = { -- عقيد قوات حرس الحدود --
			m = {
				torso_2 = 8,
				helmet_2 = 0,
				shoes_1 = 25,
			},
			f = {
				torso_2 = 8,
				helmet_2 = 0,
				shoes_1 = 25,
			},
		},
		tdryb = { -- متدرب الشرطة --
			m = {
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn3 = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 11,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		amn1 = { -- متدرب قوات حرس الحدود --
		m = {
			torso_1 = 73,
			torso_2 = 11,
			shoes_1 = 25,
			helmet_1 = 42,
			helmet_2 = 0,
			arms = 30,
		},
		f = {
			torso_1 = 192,
			torso_2 = 0,
			shoes_1 = 24,
			helmet_1 = 45,
			helmet_2 = 0,
			arms = 14,
			},
		},
		swat = { -- متدرب الشرطة --
		m = {
			torso_1 = 209,
			torso_2 = 10,
			shoes_1 = 25,
			helmet_1 = 107,
			helmet_2 = 20,
			arms = 31,
		},
		f = {
			torso_1 = 195,
			torso_2 = 0,
			shoes_1 = 25,
			helmet_1 = 106,
			helmet_2 = 20,
			arms = 6,
		},
	},
		Police = { -- عقيد الشرطة --
			m = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 25,
				helmet_1 = 107,
				helmet_2 = 20,
				arms = 31,
			},
			f = {
				torso_1 = 195,
				torso_2 = 5,
				shoes_1 = 25,
				helmet_1 = 106,
				helmet_2 = 20,
				arms = 6,
			},
		},
		amn2 = { -- متدرب الشرطة --
			m = {
				torso_1 = 213,
				torso_2 = 11,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 8,
				decals_1 = 0,
				decals_2 = 0,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		mrowr = { -- متدرب الشرطة --
			m = {
				torso_1 = 225,
				torso_2 = 1,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 4,
				arms = 30,
			},
			f = {
				torso_1 = 86,
				torso_2 = 2,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},
		refe = { -- متدرب الشرطة --
			m = {
				torso_1 = 210,
				torso_2 = 11,
				shoes_1 = 25,
				helmet_1 = 28,
				helmet_2 = 1,
				arms = 30,
			},
			f = {
				torso_1 = 208,
				torso_2 = 0,
				shoes_1 = 24,
				helmet_1 = 45,
				helmet_2 = 0,
				arms = 14,
			},
		},

	},
}

Config.PoliceStations = {

	LSPD = {

		Blip = {
			Coords  = vector3(425.1, -979.5, 30.7),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		cloakroom = {
			vector3(461.4700012207031, -999, 30.69000053405761),
			vector3(360.2799987792969, -1593.81005859375, 25.45000076293945)
		},

		Armories = {
			vector3(482.67, -996.04, 30.69),
		},

		Liverys = {
			vector3(449.56, -1024.73, 28.21+0.4),
			vector3(445.9, -1025.35, 28.28+0.4),
			vector3(442.41, -1025.44, 28.33+0.4),
			vector3(438.92, -1026.15, 28.42+0.4),
			vector3(435.51, -1026.52, 28.49+0.4),
		},

		Tasleem = {
			vector3(472.8147, -995.0278, 26.27327)
		},
		
		Vehicles = {
			{
				Spawner = vector3(455.2, -1017.41, 28.42),
				InsideShop = vector3(455.2, -1017.41, 28.42),
				SpawnPoints = {
					{ coords = vector3(446.3, -1025.75, 28.17), heading = 1.56, radius = 6.0 },
					{ coords = vector3(442.41, -1025.77, 28.35), heading = 3.55, radius = 9.0 },
					{ coords = vector3(438.72, -1026.26, 28.42), heading = 2.87, radius = 9.0 },
					{ coords = vector3(434.86, -1026.87, 28.5), heading = 1.68, radius = 9.0 },
					{ coords = vector3(431.24, -1027.02, 28.56), heading = 3.94, radius = 6.0 },
					{ coords = vector3(427.53, -1027.34, 28.63), heading = 0.85, radius = 6.0 }
				}
			},

			{
				Spawner = vector3(473.3, -1018.8, 28.0),
				InsideShop = vector3(228.5, -993.5, -99.0),
				SpawnPoints = {
					{coords = vector3(475.9, -1021.6, 28.0), heading = 276.1, radius = 6.0},
					{coords = vector3(484.1, -1023.1, 27.5), heading = 302.5, radius = 6.0}
				}
			},

			
		},

		Helicopters = {
			{
				Spawner = vector3(461.1, -981.5, 43.6),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{ coords = vector3(449.5, -981.2, 43.6), heading = 92.6, radius = 10.0 }
				}
			}
		},


		BossActions = {
			vector3(459.7004, -985.2955, 30.7281),
		},

	},

	sandy = { -- ساندي

		Blip = {
			Coords  = vector3(1850.8262939453, 3693.4907226563, 34.26708984375),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},


		cloakroom = {
			vector3(1850.8262939453, 3693.4907226563, 34.26708984375),
		},

		Armories = {
			vector3(1841.7760009766, 3691.076171875, 34.267105102539),
		},

		Tasleem = {
			vector3(1855.8240966797, 3699.208984375, 34.267070770264),
		},
	},

	
	paleto = { -- بوليتو

		Blip = {
			Coords  = vector3(-449.92427978516, 6011.064140625, 31.726449737549),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		cloakroom = {
			vector3(-449.92427978516, 6011.064140625, 31.726449737549),
		},

		Armories = {
			vector3(-438.03391357422, 5988.6140429688, 31.726077804565),
		},

		Vehicles = {

		},

		Tasleem = {
			vector3(-441.97019165039, 5985.9109375, 31.725635757446),
		},
	},

	remove_sglat = {
		{ Pos = vector3(441.05087280273, -981.78002929688, 30.689506530762), job = 'police', Color = { r = 0, g = 0, b = 255 }},
		{ Pos = vector3(1854.0554199219, 3687.7919921875, 34.267093658447), job = 'police', Color = { r = 0, g = 0, b = 255 }},
		{ Pos = vector3(-447.38238525391, 6013.9267578125, 31.716453552246), job = 'police', Color = { r = 0, g = 0, b = 255 }},
	},

	--[[LSPD2 = {

		Blip = {
			Coords  = vector3(1862.24, 3690.87, 34.26),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		cloakroom = {
            vector3(1849.44, 3695.66, -3333334.26),			
		},

		Armories = {
			vector3(1841.3, 3691.18, 34.26),
		},

		Liverys = {
		},

		Vehicles = {

			{
				Spawner = vector3(1867.78, 3685.9, 33.78),
				InsideShop = vector3(1872.59, 3691.14, 33.57),
				SpawnPoints = {
					{coords = vector3(1872.59, 3691.14, 33.57), heading = 213.9, radius = 6.0},
					{coords = vector3(1867.68, 3700.21, 33.57), heading = 211.53, radius = 6.0}
				}
			},
			
		},

		Helicopters = {
		},

		BossActions = {
			vector3(1862.24, 3690.87, 34.26),
		}

	},

	LSPD3 = {

		Blip = {
			Coords  = vector3(-440.553, 6019.816, 31.489),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		cloakroom = {
            vector3(-453.350, 6015.530, -333333341.716)			
		},

		Armories = {
			vector3(-428.703, 5995.285, 31.716),
		},

		Liverys = {
		},
		
		Vehicles = {

			{
				Spawner = vector3(-460.91, 6015.0, 31.49),
				InsideShop = vector3(-460.91, 6015.0, 31.49),
				SpawnPoints = {
					{coords = vector3(-482.86, 6024.32, 31.04), heading = 223.76, radius = 6.0},
					{coords = vector3(-479.39, 6028.19, 31.04), heading = 223.76, radius = 6.0}
				}
			},
			
		},

		Helicopters = {
		},

		BossActions = {
			vector3(-444.975, 6012.624, 36.686),
		}

	}--]]

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

Config.WeaponsPrice = {
	WEAPON_PISTOL = 3000,
	WEAPON_PUMPSHOTGUN = 35000,
	WEAPON_ADVANCEDRIFLE = 35000,
	WEAPON_CARBINERIFLE = 45000,
	WEAPON_COMPACTRIFLE = 50000,
	WEAPON_STUNGUN = 5000,
	WEAPON_FLAREGUN = 5000,
	WEAPON_FLARE = 3000,
	WEAPON_NIGHTSTICK = 0,
	WEAPON_FLASHLIGHT = 0,
	WEAPON_PETROLCAN = 0,
	WEAPON_FIREEXTINGUISHER = 0
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
		{ weapon = 'WEAPON_NIGHTSTICK', price = Config.WeaponsPrice.WEAPON_NIGHTSTICK},
		{ weapon = 'WEAPON_STUNGUN',    price = Config.WeaponsPrice.WEAPON_STUNGUN },
		{ weapon = 'WEAPON_FLASHLIGHT', price = Config.WeaponsPrice.WEAPON_FLASHLIGHT },
		{ weapon = 'WEAPON_FLARE',      price = Config.WeaponsPrice.WEAPON_FLARE },
		{ weapon = 'WEAPON_PETROLCAN',  price = Config.WeaponsPrice.WEAPON_PETROLCAN },
		{ weapon = 'WEAPON_FIREEXTINGUISHER',  price = Config.WeaponsPrice.WEAPON_FIREEXTINGUISHER }
	},

	sergeant = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil }, price = Config.WeaponsPrice.WEAPON_PISTOL },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil },                  price = Config.WeaponsPrice.WEAPON_PUMPSHOTGUN },
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

	mola = {
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

	deputy = {
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

	sandy2 = {
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

	fbi0 = {
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

	fbi2 = {
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

	agent = {
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

	special = {
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

	supervisor = {
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

	fbi3 = {
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

	fbi4 = {
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

	fbi5 = {
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

	assistant = {
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

	sandy0 = {
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

	sandy02 = {
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
	},

	m8dmrkn = {
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

	akedrkn = {
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

	amedrkn = {
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

	lwarkn = {
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

	fre8rkn = {
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

	fre8awlrkn = {
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
		{model = 'polkuw30',label = 'فورد فيكتوريا - شامل', price = 299900},
		},

		officer = {
		{model = 'polkuw30',label = 'فورد فيكتوريا - شامل', price = 299900},
		{model = 'pol3',label = 'فان نقل السجن - فلشر ازرق احمر', price = 299900},
		{model = 'pbus',label = 'باص نقل السجن', price = 299900},
		},

		sergeant = {
		{model = 'polkuw30',label = 'فورد فيكتوريا - شامل', price = 299900},
		{model = 'polkuw31',label = 'فورد إكسبلور - شامل', price = 799900},
		{model = 'pol3',label = 'فان نقل السجن - فلشر ازرق احمر', price = 299900},
		{model = 'pbus',label = 'باص نقل السجن', price = 299900},
		},

		intendent = {
		{model = 'polkuw30',label = 'فورد فيكتوريا - شامل', price = 299900},
		{model = 'polkuw31',label = 'فورد إكسبلور - شامل', price = 799900},
		{model = 'polkuw32',label = 'فورد تورس - شامل', price = 799900},
		{model = 'polkuwb1',label = 'دورية دراجة نارية - مرور', price = 299900},
		{model = 'pol3',label = 'فان نقل السجن - فلشر ازرق احمر', price = 299900},
		{model = 'pbus',label = 'باص نقل السجن', price = 299900},
		},

		lieutenant = {
		{model = 'polkuw30',label = 'فورد فيكتوريا - شامل', price = 299900},
		{model = 'polkuw31',label = 'فورد إكسبلور - شامل', price = 799900},
		{model = 'polkuw32',label = 'فورد تورس - شامل', price = 799900},
		{model = 'polkuwb1',label = 'دورية دراجة نارية - مرور', price = 299900},
		{model = 'pol3',label = 'فان نقل السجن - فلشر ازرق احمر', price = 299900},
		{model = 'pbus',label = 'باص نقل السجن', price = 299900},
		},

		chef = {
		{model = 'polkuw30',label = 'فورد فيكتوريا - شامل', price = 299900},
		{model = 'polkuw31',label = 'فورد إكسبلور - شامل', price = 799900},
		{model = 'polkuw32',label = 'فورد تورس - شامل', price = 799900},
		{model = 'polkuw06',label = 'كابرس - نجدة', price = 799900},
		{model = 'polkuwb1',label = 'دورية دراجة نارية - مرور', price = 299900},
		{model = 'pol3',label = 'فان نقل السجن - فلشر ازرق احمر', price = 299900},
		{model = 'pbus',label = 'باص نقل السجن', price = 299900},
		},

		inspector = {
		{model = 'polkuw30',label = 'فورد فيكتوريا - شامل', price = 299900},
		{model = 'polkuw31',label = 'فورد إكسبلور - شامل', price = 799900},
		{model = 'polkuw32',label = 'فورد تورس - شامل', price = 799900},
		{model = 'polkuw06',label = 'كابرس - نجدة', price = 799900},
		{model = 'polkuwb1',label = 'دورية دراجة نارية - مرور', price = 299900},
		{model = 'pol3',label = 'فان نقل السجن - فلشر ازرق احمر', price = 299900},
		{model = 'pbus',label = 'باص نقل السجن', price = 299900},
		},
		
		mola = {
		{model = 'polkuw30',label = 'فورد فيكتوريا - شامل', price = 299900},
		{model = 'polkuw31',label = 'فورد إكسبلور - شامل', price = 799900},
		{model = 'polkuw32',label = 'فورد تورس - شامل', price = 799900},
		{model = 'polkuw06',label = 'كابرس - نجدة', price = 799900},
		{model = 'polkuwb1',label = 'دورية دراجة نارية - مرور', price = 299900},
		{model = 'polkuw34',label = 'دورية دودج شارجر ', price = 1200000},
		{model = 'polkuw02',label = 'دورية شفر تاهو  ', price = 999000},
		{model = 'sspres',label = 'سوبربان مصفح  ', price = 499900},
		{model = 'polchall70',label = 'دورية سري - دودج شالنجر ', price = 799900},
		{model = 'unmarked10',label = 'دورية سري - دودج شارجر 2014 ', price = 799900},
		{model = 'unmarked11',label = 'دورية سري - دودج شارجر 2015 ', price = 799900},
		{model = 'unmarked12',label = 'دورية سري - فورد اكسبلورر 16 ', price = 799900},
		{model = 'unmarked13',label = 'دورية سري - تاهو 2016 2 ', price = 799900},
		{model = 'unmarked14',label = 'دورية سري - وانيت سلفرادو 2017 ', price = 799900},
		{model = 'unmarked15',label = 'دورية سري - إمبالا ', price = 799900},
		{model = 'unmarked16',label = 'دورية سري - فورد كراون فكتوريا 2 ', price = 799900},
		{model = 'unmarked17',label = 'دورية سري - دودج شالنجر هيلكات ', price = 799900},
		{model = 'riot',label = 'شاحنة القوات الخاصة ', price = 499900},
		{model = 'riot4',label = 'شاحنة القوات الخاصة2 ', price = 499900},
		{model = 'pol5',label = 'همر قوات خاصة  -  أمن المحافظات ', price = 499900},
		{model = 'pol3',label = 'فان نقل السجن - فلشر ازرق احمر', price = 299900},
		{model = 'pbus',label = 'باص نقل السجن', price = 299900},
		},		

		captain = {
		{model = 'polkuw30',label = 'فورد فيكتوريا - شامل', price = 299900},
		{model = 'polkuw31',label = 'فورد إكسبلور - شامل', price = 799900},
		{model = 'polkuw32',label = 'فورد تورس - شامل', price = 799900},
		{model = 'polkuw06',label = 'كابرس - نجدة', price = 799900},
		{model = 'polkuwb1',label = 'دورية دراجة نارية - مرور', price = 299900},
		{model = 'polkuw34',label = 'دورية دودج شارجر ', price = 1200000},
		{model = 'polkuw02',label = 'دورية شفر تاهو  ', price = 999000},
		{model = 'sspres',label = 'سوبربان مصفح  ', price = 499900},
		{model = 'polchall70',label = 'دورية سري - دودج شالنجر ', price = 799900},
		{model = 'unmarked10',label = 'دورية سري - دودج شارجر 2014 ', price = 799900},
		{model = 'unmarked11',label = 'دورية سري - دودج شارجر 2015 ', price = 799900},
		{model = 'unmarked12',label = 'دورية سري - فورد اكسبلورر 16 ', price = 799900},
		{model = 'unmarked13',label = 'دورية سري - تاهو 2016 2 ', price = 799900},
		{model = 'unmarked14',label = 'دورية سري - وانيت سلفرادو 2017 ', price = 799900},
		{model = 'unmarked15',label = 'دورية سري - إمبالا ', price = 799900},
		{model = 'unmarked16',label = 'دورية سري - فورد كراون فكتوريا 2 ', price = 799900},
		{model = 'unmarked17',label = 'دورية سري - دودج شالنجر هيلكات ', price = 799900},
		{model = 'riot',label = 'شاحنة القوات الخاصة ', price = 499900},
		{model = 'riot4',label = 'شاحنة القوات الخاصة2 ', price = 499900},
		{model = 'pol5',label = 'همر قوات خاصة  -  أمن المحافظات ', price = 499900},
		{model = 'pol3',label = 'فان نقل السجن - فلشر ازرق احمر', price = 299900},
		{model = 'pbus',label = 'باص نقل السجن', price = 299900},
		},

		deputy = {
		{model = 'polkuw30',label = 'فورد فيكتوريا - شامل', price = 299900},
		{model = 'polkuw31',label = 'فورد إكسبلور - شامل', price = 799900},
		{model = 'polkuw32',label = 'فورد تورس - شامل', price = 799900},
		{model = 'polkuw06',label = 'كابرس - نجدة', price = 799900},
		{model = 'polkuwb1',label = 'دورية دراجة نارية - مرور', price = 299900},
		{model = 'polkuw34',label = 'دورية دودج شارجر ', price = 1200000},
		{model = 'polkuw02',label = 'دورية شفر تاهو  ', price = 999000},
		{model = 'sspres',label = 'سوبربان مصفح  ', price = 499900},
		{model = 'polchall70',label = 'دورية سري - دودج شالنجر ', price = 799900},
		{model = 'unmarked10',label = 'دورية سري - دودج شارجر 2014 ', price = 799900},
		{model = 'unmarked11',label = 'دورية سري - دودج شارجر 2015 ', price = 799900},
		{model = 'unmarked12',label = 'دورية سري - فورد اكسبلورر 16 ', price = 799900},
		{model = 'unmarked13',label = 'دورية سري - تاهو 2016 2 ', price = 799900},
		{model = 'unmarked14',label = 'دورية سري - وانيت سلفرادو 2017 ', price = 799900},
		{model = 'unmarked15',label = 'دورية سري - إمبالا ', price = 799900},
		{model = 'unmarked16',label = 'دورية سري - فورد كراون فكتوريا 2 ', price = 799900},
		{model = 'unmarked17',label = 'دورية سري - دودج شالنجر هيلكات ', price = 799900},
		{model = 'riot',label = 'شاحنة القوات الخاصة ', price = 499900},
		{model = 'riot4',label = 'شاحنة القوات الخاصة2 ', price = 499900},
		{model = 'pol5',label = 'همر قوات خاصة  -  أمن المحافظات ', price = 499900},
		{model = 'pol3',label = 'فان نقل السجن - فلشر ازرق احمر', price = 299900},
		{model = 'pbus',label = 'باص نقل السجن', price = 299900},
		},		

		sandy2 = {
		{model = 'polkuw30',label = 'فورد فيكتوريا - شامل', price = 299900},
		{model = 'polkuw31',label = 'فورد إكسبلور - شامل', price = 799900},
		{model = 'polkuw32',label = 'فورد تورس - شامل', price = 799900},
		{model = 'polkuw06',label = 'كابرس - نجدة', price = 799900},
		{model = 'polkuwb1',label = 'دورية دراجة نارية - مرور', price = 299900},
		{model = 'polkuw34',label = 'دورية دودج شارجر ', price = 1200000},
		{model = 'polkuw02',label = 'دورية شفر تاهو  ', price = 999000},
		{model = 'sspres',label = 'سوبربان مصفح  ', price = 499900},
		{model = 'polchall70',label = 'دورية سري - دودج شالنجر ', price = 799900},
		{model = 'unmarked10',label = 'دورية سري - دودج شارجر 2014 ', price = 799900},
		{model = 'unmarked11',label = 'دورية سري - دودج شارجر 2015 ', price = 799900},
		{model = 'unmarked12',label = 'دورية سري - فورد اكسبلورر 16 ', price = 799900},
		{model = 'unmarked13',label = 'دورية سري - تاهو 2016 2 ', price = 799900},
		{model = 'unmarked14',label = 'دورية سري - وانيت سلفرادو 2017 ', price = 799900},
		{model = 'unmarked15',label = 'دورية سري - إمبالا ', price = 799900},
		{model = 'unmarked16',label = 'دورية سري - فورد كراون فكتوريا 2 ', price = 799900},
		{model = 'unmarked17',label = 'دورية سري - دودج شالنجر هيلكات ', price = 799900},
		{model = 'riot',label = 'شاحنة القوات الخاصة ', price = 499900},
		{model = 'riot4',label = 'شاحنة القوات الخاصة2 ', price = 499900},
		{model = 'pol5',label = 'همر قوات خاصة  -  أمن المحافظات ', price = 499900},
		{model = 'asea3',label = 'دورية سري -آسيا ', price = 199900},
		{model = 'FIBJackal',label = 'دورية سري - جاكل ', price = 199900},
		{model = 'panto99',label = 'دورية سري -آسيا ', price = 99900},
		{model = 'pol3',label = 'فان نقل السجن - فلشر ازرق احمر', price = 299900},
		{model = 'pbus',label = 'باص نقل السجن', price = 299900},
		},
		
		fbi0 = {
		{model = 'polkuw30',label = 'فورد فيكتوريا - شامل', price = 299900},
		{model = 'polkuw31',label = 'فورد إكسبلور - شامل', price = 799900},
		{model = 'polkuw32',label = 'فورد تورس - شامل', price = 799900},
		{model = 'polkuw06',label = 'كابرس - نجدة', price = 799900},
		{model = 'polkuwb1',label = 'دورية دراجة نارية - مرور', price = 299900},
		{model = 'polkuw34',label = 'دورية دودج شارجر ', price = 1200000},
		{model = 'polkuw02',label = 'دورية شفر تاهو  ', price = 999000},
		{model = 'sspres',label = 'سوبربان مصفح  ', price = 499900},
		{model = 'polchall70',label = 'دورية سري - دودج شالنجر ', price = 799900},
		{model = 'unmarked10',label = 'دورية سري - دودج شارجر 2014 ', price = 799900},
		{model = 'unmarked11',label = 'دورية سري - دودج شارجر 2015 ', price = 799900},
		{model = 'unmarked12',label = 'دورية سري - فورد اكسبلورر 16 ', price = 799900},
		{model = 'unmarked13',label = 'دورية سري - تاهو 2016 2 ', price = 799900},
		{model = 'unmarked14',label = 'دورية سري - وانيت سلفرادو 2017 ', price = 799900},
		{model = 'unmarked15',label = 'دورية سري - إمبالا ', price = 799900},
		{model = 'unmarked16',label = 'دورية سري - فورد كراون فكتوريا 2 ', price = 799900},
		{model = 'unmarked17',label = 'دورية سري - دودج شالنجر هيلكات ', price = 799900},
		{model = 'riot',label = 'شاحنة القوات الخاصة ', price = 499900},
		{model = 'riot4',label = 'شاحنة القوات الخاصة2 ', price = 499900},
		{model = 'pol5',label = 'همر قوات خاصة  -  أمن المحافظات ', price = 499900},
		{model = 'asea3',label = 'دورية سري -آسيا ', price = 199900},
		{model = 'FIBJackal',label = 'دورية سري - جاكل ', price = 199900},
		{model = 'panto99',label = 'دورية سري -آسيا ', price = 99900},
		{model = 'pol3',label = 'فان نقل السجن - فلشر ازرق احمر', price = 299900},
		{model = 'pbus',label = 'باص نقل السجن', price = 299900},
		},

		fbi1 = {
		{model = 'polkuw30',label = 'فورد فيكتوريا - شامل', price = 299900},
		{model = 'polkuw31',label = 'فورد إكسبلور - شامل', price = 799900},
		{model = 'polkuw32',label = 'فورد تورس - شامل', price = 799900},
		{model = 'polkuw06',label = 'كابرس - نجدة', price = 799900},
		{model = 'polkuwb1',label = 'دورية دراجة نارية - مرور', price = 299900},
		{model = 'polkuw34',label = 'دورية دودج شارجر ', price = 1200000},
		{model = 'polkuw02',label = 'دورية شفر تاهو  ', price = 999000},
		{model = 'sspres',label = 'سوبربان مصفح  ', price = 499900},
		{model = 'polchall70',label = 'دورية سري - دودج شالنجر ', price = 799900},
		{model = 'unmarked10',label = 'دورية سري - دودج شارجر 2014 ', price = 799900},
		{model = 'unmarked11',label = 'دورية سري - دودج شارجر 2015 ', price = 799900},
		{model = 'unmarked12',label = 'دورية سري - فورد اكسبلورر 16 ', price = 799900},
		{model = 'unmarked13',label = 'دورية سري - تاهو 2016 2 ', price = 799900},
		{model = 'unmarked14',label = 'دورية سري - وانيت سلفرادو 2017 ', price = 799900},
		{model = 'unmarked15',label = 'دورية سري - إمبالا ', price = 799900},
		{model = 'unmarked16',label = 'دورية سري - فورد كراون فكتوريا 2 ', price = 799900},
		{model = 'unmarked17',label = 'دورية سري - دودج شالنجر هيلكات ', price = 799900},
		{model = 'riot',label = 'شاحنة القوات الخاصة ', price = 499900},
		{model = 'riot4',label = 'شاحنة القوات الخاصة2 ', price = 499900},
		{model = 'pol5',label = 'همر قوات خاصة  -  أمن المحافظات ', price = 499900},
		{model = 'asea3',label = 'دورية سري -آسيا ', price = 199900},
		{model = 'FIBJackal',label = 'دورية سري - جاكل ', price = 199900},
		{model = 'panto99',label = 'دورية سري -آسيا ', price = 99900},
		{model = 'pol3',label = 'فان نقل السجن - فلشر ازرق احمر', price = 299900},
		{model = 'pbus',label = 'باص نقل السجن', price = 299900},
		},

		fbi2 = {
		{model = 'polkuw30',label = 'فورد فيكتوريا - شامل', price = 299900},
		{model = 'polkuw31',label = 'فورد إكسبلور - شامل', price = 799900},
		{model = 'polkuw32',label = 'فورد تورس - شامل', price = 799900},
		{model = 'polkuw06',label = 'كابرس - نجدة', price = 799900},
		{model = 'polkuwb1',label = 'دورية دراجة نارية - مرور', price = 299900},
		{model = 'polkuw34',label = 'دورية دودج شارجر ', price = 1200000},
		{model = 'polkuw02',label = 'دورية شفر تاهو  ', price = 999000},
		{model = 'sspres',label = 'سوبربان مصفح  ', price = 499900},
		{model = 'polchall70',label = 'دورية سري - دودج شالنجر ', price = 799900},
		{model = 'unmarked10',label = 'دورية سري - دودج شارجر 2014 ', price = 799900},
		{model = 'unmarked11',label = 'دورية سري - دودج شارجر 2015 ', price = 799900},
		{model = 'unmarked12',label = 'دورية سري - فورد اكسبلورر 16 ', price = 799900},
		{model = 'unmarked13',label = 'دورية سري - تاهو 2016 2 ', price = 799900},
		{model = 'unmarked14',label = 'دورية سري - وانيت سلفرادو 2017 ', price = 799900},
		{model = 'unmarked15',label = 'دورية سري - إمبالا ', price = 799900},
		{model = 'unmarked16',label = 'دورية سري - فورد كراون فكتوريا 2 ', price = 799900},
		{model = 'unmarked17',label = 'دورية سري - دودج شالنجر هيلكات ', price = 799900},
		{model = 'riot',label = 'شاحنة القوات الخاصة ', price = 499900},
		{model = 'riot4',label = 'شاحنة القوات الخاصة2 ', price = 499900},
		{model = 'pol5',label = 'همر قوات خاصة  -  أمن المحافظات ', price = 499900},
		{model = 'asea3',label = 'دورية سري -آسيا ', price = 199900},
		{model = 'FIBJackal',label = 'دورية سري - جاكل ', price = 199900},
		{model = 'panto99',label = 'دورية سري -آسيا ', price = 99900},
		{model = 'pol3',label = 'فان نقل السجن - فلشر ازرق احمر', price = 299900},
		{model = 'pbus',label = 'باص نقل السجن', price = 299900},
		},

		agent = {
		{model = 'polkuw30',label = 'فورد فيكتوريا - شامل', price = 299900},
		{model = 'polkuw31',label = 'فورد إكسبلور - شامل', price = 799900},
		{model = 'polkuw32',label = 'فورد تورس - شامل', price = 799900},
		{model = 'polkuw06',label = 'كابرس - نجدة', price = 799900},
		{model = 'polkuwb1',label = 'دورية دراجة نارية - مرور', price = 299900},
		{model = 'polkuw34',label = 'دورية دودج شارجر ', price = 1200000},
		{model = 'polkuw02',label = 'دورية شفر تاهو  ', price = 999000},
		{model = 'sspres',label = 'سوبربان مصفح  ', price = 499900},
		{model = 'polchall70',label = 'دورية سري - دودج شالنجر ', price = 799900},
		{model = 'unmarked10',label = 'دورية سري - دودج شارجر 2014 ', price = 799900},
		{model = 'unmarked11',label = 'دورية سري - دودج شارجر 2015 ', price = 799900},
		{model = 'unmarked12',label = 'دورية سري - فورد اكسبلورر 16 ', price = 799900},
		{model = 'unmarked13',label = 'دورية سري - تاهو 2016 2 ', price = 799900},
		{model = 'unmarked14',label = 'دورية سري - وانيت سلفرادو 2017 ', price = 799900},
		{model = 'unmarked15',label = 'دورية سري - إمبالا ', price = 799900},
		{model = 'unmarked16',label = 'دورية سري - فورد كراون فكتوريا 2 ', price = 799900},
		{model = 'unmarked17',label = 'دورية سري - دودج شالنجر هيلكات ', price = 799900},
		{model = 'riot',label = 'شاحنة القوات الخاصة ', price = 499900},
		{model = 'riot4',label = 'شاحنة القوات الخاصة2 ', price = 499900},
		{model = 'pol5',label = 'همر قوات خاصة  -  أمن المحافظات ', price = 499900},
		{model = 'asea3',label = 'دورية سري -آسيا ', price = 199900},
		{model = 'FIBJackal',label = 'دورية سري - جاكل ', price = 199900},
		{model = 'panto99',label = 'دورية سري -آسيا ', price = 99900},
		{model = 'pol3',label = 'فان نقل السجن - فلشر ازرق احمر', price = 299900},
		{model = 'pbus',label = 'باص نقل السجن', price = 299900},
		},

		special = {
		{model = 'polkuw30',label = 'فورد فيكتوريا - شامل', price = 299900},
		{model = 'polkuw31',label = 'فورد إكسبلور - شامل', price = 799900},
		{model = 'polkuw32',label = 'فورد تورس - شامل', price = 799900},
		{model = 'polkuw06',label = 'كابرس - نجدة', price = 799900},
		{model = 'polkuwb1',label = 'دورية دراجة نارية - مرور', price = 299900},
		{model = 'polkuw34',label = 'دورية دودج شارجر ', price = 1200000},
		{model = 'polkuw02',label = 'دورية شفر تاهو  ', price = 999000},
		{model = 'sspres',label = 'سوبربان مصفح  ', price = 499900},
		{model = 'polchall70',label = 'دورية سري - دودج شالنجر ', price = 799900},
		{model = 'unmarked10',label = 'دورية سري - دودج شارجر 2014 ', price = 799900},
		{model = 'unmarked11',label = 'دورية سري - دودج شارجر 2015 ', price = 799900},
		{model = 'unmarked12',label = 'دورية سري - فورد اكسبلورر 16 ', price = 799900},
		{model = 'unmarked13',label = 'دورية سري - تاهو 2016 2 ', price = 799900},
		{model = 'unmarked14',label = 'دورية سري - وانيت سلفرادو 2017 ', price = 799900},
		{model = 'unmarked15',label = 'دورية سري - إمبالا ', price = 799900},
		{model = 'unmarked16',label = 'دورية سري - فورد كراون فكتوريا 2 ', price = 799900},
		{model = 'unmarked17',label = 'دورية سري - دودج شالنجر هيلكات ', price = 799900},
		{model = 'riot',label = 'شاحنة القوات الخاصة ', price = 499900},
		{model = 'riot4',label = 'شاحنة القوات الخاصة2 ', price = 499900},
		{model = 'pol5',label = 'همر قوات خاصة  -  أمن المحافظات ', price = 499900},
		{model = 'asea3',label = 'دورية سري -آسيا ', price = 199900},
		{model = 'FIBJackal',label = 'دورية سري - جاكل ', price = 199900},
		{model = 'panto99',label = 'دورية سري -آسيا ', price = 99900},
		{model = 'pol3',label = 'فان نقل السجن - فلشر ازرق احمر', price = 299900},
		{model = 'pbus',label = 'باص نقل السجن', price = 299900},
		},

		supervisor = {
		{model = 'polkuw30',label = 'فورد فيكتوريا - شامل', price = 299900},
		{model = 'polkuw31',label = 'فورد إكسبلور - شامل', price = 799900},
		{model = 'polkuw32',label = 'فورد تورس - شامل', price = 799900},
		{model = 'polkuw06',label = 'كابرس - نجدة', price = 799900},
		{model = 'polkuwb1',label = 'دورية دراجة نارية - مرور', price = 299900},
		{model = 'polkuw34',label = 'دورية دودج شارجر ', price = 1200000},
		{model = 'polkuw02',label = 'دورية شفر تاهو  ', price = 999000},
		{model = 'sspres',label = 'سوبربان مصفح  ', price = 499900},
		{model = 'polchall70',label = 'دورية سري - دودج شالنجر ', price = 799900},
		{model = 'unmarked10',label = 'دورية سري - دودج شارجر 2014 ', price = 799900},
		{model = 'unmarked11',label = 'دورية سري - دودج شارجر 2015 ', price = 799900},
		{model = 'unmarked12',label = 'دورية سري - فورد اكسبلورر 16 ', price = 799900},
		{model = 'unmarked13',label = 'دورية سري - تاهو 2016 2 ', price = 799900},
		{model = 'unmarked14',label = 'دورية سري - وانيت سلفرادو 2017 ', price = 799900},
		{model = 'unmarked15',label = 'دورية سري - إمبالا ', price = 799900},
		{model = 'unmarked16',label = 'دورية سري - فورد كراون فكتوريا 2 ', price = 799900},
		{model = 'unmarked17',label = 'دورية سري - دودج شالنجر هيلكات ', price = 799900},
		{model = 'riot',label = 'شاحنة القوات الخاصة ', price = 499900},
		{model = 'riot4',label = 'شاحنة القوات الخاصة2 ', price = 499900},
		{model = 'pol5',label = 'همر قوات خاصة  -  أمن المحافظات ', price = 499900},
		{model = 'asea3',label = 'دورية سري -آسيا ', price = 199900},
		{model = 'FIBJackal',label = 'دورية سري - جاكل ', price = 199900},
		{model = 'panto99',label = 'دورية سري -آسيا ', price = 99900},
		{model = 'pol3',label = 'فان نقل السجن - فلشر ازرق احمر', price = 299900},
		{model = 'pbus',label = 'باص نقل السجن', price = 299900},
		},
		
		fbi3 = {
		{model = 'polkuw30',label = 'فورد فيكتوريا - شامل', price = 299900},
		{model = 'polkuw31',label = 'فورد إكسبلور - شامل', price = 799900},
		{model = 'polkuw32',label = 'فورد تورس - شامل', price = 799900},
		{model = 'polkuw06',label = 'كابرس - نجدة', price = 799900},
		{model = 'polkuwb1',label = 'دورية دراجة نارية - مرور', price = 299900},
		{model = 'polkuw34',label = 'دورية دودج شارجر ', price = 1200000},
		{model = 'polkuw02',label = 'دورية شفر تاهو  ', price = 999000},
		{model = 'sspres',label = 'سوبربان مصفح  ', price = 499900},
		{model = 'polchall70',label = 'دورية سري - دودج شالنجر ', price = 799900},
		{model = 'unmarked10',label = 'دورية سري - دودج شارجر 2014 ', price = 799900},
		{model = 'unmarked11',label = 'دورية سري - دودج شارجر 2015 ', price = 799900},
		{model = 'unmarked12',label = 'دورية سري - فورد اكسبلورر 16 ', price = 799900},
		{model = 'unmarked13',label = 'دورية سري - تاهو 2016 2 ', price = 799900},
		{model = 'unmarked14',label = 'دورية سري - وانيت سلفرادو 2017 ', price = 799900},
		{model = 'unmarked15',label = 'دورية سري - إمبالا ', price = 799900},
		{model = 'unmarked16',label = 'دورية سري - فورد كراون فكتوريا 2 ', price = 799900},
		{model = 'unmarked17',label = 'دورية سري - دودج شالنجر هيلكات ', price = 799900},
		{model = 'riot',label = 'شاحنة القوات الخاصة ', price = 499900},
		{model = 'riot4',label = 'شاحنة القوات الخاصة2 ', price = 499900},
		{model = 'pol5',label = 'همر قوات خاصة  -  أمن المحافظات ', price = 499900},
		{model = 'asea3',label = 'دورية سري -آسيا ', price = 199900},
		{model = 'FIBJackal',label = 'دورية سري - جاكل ', price = 199900},
		{model = 'panto99',label = 'دورية سري -آسيا ', price = 99900},
		{model = 'pol3',label = 'فان نقل السجن - فلشر ازرق احمر', price = 299900},
		{model = 'pbus',label = 'باص نقل السجن', price = 299900},
		},

		fbi4 = {
		{model = 'polkuw30',label = 'فورد فيكتوريا - شامل', price = 299900},
		{model = 'polkuw31',label = 'فورد إكسبلور - شامل', price = 799900},
		{model = 'polkuw32',label = 'فورد تورس - شامل', price = 799900},
		{model = 'polkuw06',label = 'كابرس - نجدة', price = 799900},
		{model = 'polkuwb1',label = 'دورية دراجة نارية - مرور', price = 299900},
		{model = 'polkuw34',label = 'دورية دودج شارجر ', price = 1200000},
		{model = 'polkuw02',label = 'دورية شفر تاهو  ', price = 999000},
		{model = 'sspres',label = 'سوبربان مصفح  ', price = 499900},
		{model = 'polchall70',label = 'دورية سري - دودج شالنجر ', price = 799900},
		{model = 'unmarked10',label = 'دورية سري - دودج شارجر 2014 ', price = 799900},
		{model = 'unmarked11',label = 'دورية سري - دودج شارجر 2015 ', price = 799900},
		{model = 'unmarked12',label = 'دورية سري - فورد اكسبلورر 16 ', price = 799900},
		{model = 'unmarked13',label = 'دورية سري - تاهو 2016 2 ', price = 799900},
		{model = 'unmarked14',label = 'دورية سري - وانيت سلفرادو 2017 ', price = 799900},
		{model = 'unmarked15',label = 'دورية سري - إمبالا ', price = 799900},
		{model = 'unmarked16',label = 'دورية سري - فورد كراون فكتوريا 2 ', price = 799900},
		{model = 'unmarked17',label = 'دورية سري - دودج شالنجر هيلكات ', price = 799900},
		{model = 'riot',label = 'شاحنة القوات الخاصة ', price = 499900},
		{model = 'riot4',label = 'شاحنة القوات الخاصة2 ', price = 499900},
		{model = 'pol5',label = 'همر قوات خاصة  -  أمن المحافظات ', price = 499900},
		{model = 'asea3',label = 'دورية سري -آسيا ', price = 199900},
		{model = 'FIBJackal',label = 'دورية سري - جاكل ', price = 199900},
		{model = 'panto99',label = 'دورية سري -آسيا ', price = 99900},
		{model = 'pol3',label = 'فان نقل السجن - فلشر ازرق احمر', price = 299900},
		{model = 'pbus',label = 'باص نقل السجن', price = 299900},
		},

		fbi5 = {
		{model = 'polkuw30',label = 'فورد فيكتوريا - شامل', price = 299900},
		{model = 'polkuw31',label = 'فورد إكسبلور - شامل', price = 799900},
		{model = 'polkuw32',label = 'فورد تورس - شامل', price = 799900},
		{model = 'polkuw06',label = 'كابرس - نجدة', price = 799900},
		{model = 'polkuwb1',label = 'دورية دراجة نارية - مرور', price = 299900},
		{model = 'polkuw34',label = 'دورية دودج شارجر ', price = 1200000},
		{model = 'polkuw02',label = 'دورية شفر تاهو  ', price = 999000},
		{model = 'sspres',label = 'سوبربان مصفح  ', price = 499900},
		{model = 'polchall70',label = 'دورية سري - دودج شالنجر ', price = 799900},
		{model = 'unmarked10',label = 'دورية سري - دودج شارجر 2014 ', price = 799900},
		{model = 'unmarked11',label = 'دورية سري - دودج شارجر 2015 ', price = 799900},
		{model = 'unmarked12',label = 'دورية سري - فورد اكسبلورر 16 ', price = 799900},
		{model = 'unmarked13',label = 'دورية سري - تاهو 2016 2 ', price = 799900},
		{model = 'unmarked14',label = 'دورية سري - وانيت سلفرادو 2017 ', price = 799900},
		{model = 'unmarked15',label = 'دورية سري - إمبالا ', price = 799900},
		{model = 'unmarked16',label = 'دورية سري - فورد كراون فكتوريا 2 ', price = 799900},
		{model = 'unmarked17',label = 'دورية سري - دودج شالنجر هيلكات ', price = 799900},
		{model = 'riot',label = 'شاحنة القوات الخاصة ', price = 499900},
		{model = 'riot4',label = 'شاحنة القوات الخاصة2 ', price = 499900},
		{model = 'pol5',label = 'همر قوات خاصة  -  أمن المحافظات ', price = 499900},
		{model = 'asea3',label = 'دورية سري -آسيا ', price = 199900},
		{model = 'FIBJackal',label = 'دورية سري - جاكل ', price = 199900},
		{model = 'panto99',label = 'دورية سري -آسيا ', price = 99900},
		{model = 'pol3',label = 'فان نقل السجن - فلشر ازرق احمر', price = 299900},
		{model = 'pbus',label = 'باص نقل السجن', price = 299900},
		},

		assistant = {
		{model = 'polkuw30',label = 'فورد فيكتوريا - شامل', price = 299900},
		{model = 'polkuw31',label = 'فورد إكسبلور - شامل', price = 799900},
		{model = 'polkuw32',label = 'فورد تورس - شامل', price = 799900},
		{model = 'polkuw06',label = 'كابرس - نجدة', price = 799900},
		{model = 'polkuwb1',label = 'دورية دراجة نارية - مرور', price = 299900},
		{model = 'polkuw34',label = 'دورية دودج شارجر ', price = 1200000},
		{model = 'polkuw02',label = 'دورية شفر تاهو  ', price = 999000},
		{model = 'sspres',label = 'سوبربان مصفح  ', price = 499900},
		{model = 'polchall70',label = 'دورية سري - دودج شالنجر ', price = 799900},
		{model = 'unmarked10',label = 'دورية سري - دودج شارجر 2014 ', price = 799900},
		{model = 'unmarked11',label = 'دورية سري - دودج شارجر 2015 ', price = 799900},
		{model = 'unmarked12',label = 'دورية سري - فورد اكسبلورر 16 ', price = 799900},
		{model = 'unmarked13',label = 'دورية سري - تاهو 2016 2 ', price = 799900},
		{model = 'unmarked14',label = 'دورية سري - وانيت سلفرادو 2017 ', price = 799900},
		{model = 'unmarked15',label = 'دورية سري - إمبالا ', price = 799900},
		{model = 'unmarked16',label = 'دورية سري - فورد كراون فكتوريا 2 ', price = 799900},
		{model = 'unmarked17',label = 'دورية سري - دودج شالنجر هيلكات ', price = 799900},
		{model = 'riot',label = 'شاحنة القوات الخاصة ', price = 499900},
		{model = 'riot4',label = 'شاحنة القوات الخاصة2 ', price = 499900},
		{model = 'pol5',label = 'همر قوات خاصة  -  أمن المحافظات ', price = 499900},
		{model = 'asea3',label = 'دورية سري -آسيا ', price = 199900},
		{model = 'FIBJackal',label = 'دورية سري - جاكل ', price = 199900},
		{model = 'panto99',label = 'دورية سري -آسيا ', price = 99900},
		{model = 'pol3',label = 'فان نقل السجن - فلشر ازرق احمر', price = 299900},
		{model = 'pbus',label = 'باص نقل السجن', price = 299900},
		},

		sandy0 = {
		{model = 'polkuw30',label = 'فورد فيكتوريا - شامل', price = 299900},
		{model = 'polkuw31',label = 'فورد إكسبلور - شامل', price = 799900},
		{model = 'polkuw32',label = 'فورد تورس - شامل', price = 799900},
		{model = 'polkuw06',label = 'كابرس - نجدة', price = 799900},
		{model = 'polkuwb1',label = 'دورية دراجة نارية - مرور', price = 299900},
		{model = 'polkuw34',label = 'دورية دودج شارجر ', price = 1200000},
		{model = 'polkuw02',label = 'دورية شفر تاهو  ', price = 999000},
		{model = 'sspres',label = 'سوبربان مصفح  ', price = 499900},
		{model = 'polchall70',label = 'دورية سري - دودج شالنجر ', price = 799900},
		{model = 'unmarked10',label = 'دورية سري - دودج شارجر 2014 ', price = 799900},
		{model = 'unmarked11',label = 'دورية سري - دودج شارجر 2015 ', price = 799900},
		{model = 'unmarked12',label = 'دورية سري - فورد اكسبلورر 16 ', price = 799900},
		{model = 'unmarked13',label = 'دورية سري - تاهو 2016 2 ', price = 799900},
		{model = 'unmarked14',label = 'دورية سري - وانيت سلفرادو 2017 ', price = 799900},
		{model = 'unmarked15',label = 'دورية سري - إمبالا ', price = 799900},
		{model = 'unmarked16',label = 'دورية سري - فورد كراون فكتوريا 2 ', price = 799900},
		{model = 'unmarked17',label = 'دورية سري - دودج شالنجر هيلكات ', price = 799900},
		{model = 'riot',label = 'شاحنة القوات الخاصة ', price = 499900},
		{model = 'riot4',label = 'شاحنة القوات الخاصة2 ', price = 499900},
		{model = 'pol5',label = 'همر قوات خاصة  -  أمن المحافظات ', price = 499900},
		{model = 'asea3',label = 'دورية سري -آسيا ', price = 199900},
		{model = 'FIBJackal',label = 'دورية سري - جاكل ', price = 199900},
		{model = 'panto99',label = 'دورية سري -آسيا ', price = 99900},
		{model = 'pol3',label = 'فان نقل السجن - فلشر ازرق احمر', price = 299900},
		{model = 'pbus',label = 'باص نقل السجن', price = 299900},
		},

		sandy02 = {
		{model = 'polkuw30',label = 'فورد فيكتوريا - شامل', price = 299900},
		{model = 'polkuw31',label = 'فورد إكسبلور - شامل', price = 799900},
		{model = 'polkuw32',label = 'فورد تورس - شامل', price = 799900},
		{model = 'polkuw06',label = 'كابرس - نجدة', price = 799900},
		{model = 'polkuwb1',label = 'دورية دراجة نارية - مرور', price = 299900},
		{model = 'polkuw34',label = 'دورية دودج شارجر ', price = 1200000},
		{model = 'polkuw02',label = 'دورية شفر تاهو  ', price = 999000},
		{model = 'sspres',label = 'سوبربان مصفح  ', price = 499900},
		{model = 'polchall70',label = 'دورية سري - دودج شالنجر ', price = 799900},
		{model = 'unmarked10',label = 'دورية سري - دودج شارجر 2014 ', price = 799900},
		{model = 'unmarked11',label = 'دورية سري - دودج شارجر 2015 ', price = 799900},
		{model = 'unmarked12',label = 'دورية سري - فورد اكسبلورر 16 ', price = 799900},
		{model = 'unmarked13',label = 'دورية سري - تاهو 2016 2 ', price = 799900},
		{model = 'unmarked14',label = 'دورية سري - وانيت سلفرادو 2017 ', price = 799900},
		{model = 'unmarked15',label = 'دورية سري - إمبالا ', price = 799900},
		{model = 'unmarked16',label = 'دورية سري - فورد كراون فكتوريا 2 ', price = 799900},
		{model = 'unmarked17',label = 'دورية سري - دودج شالنجر هيلكات ', price = 799900},
		{model = 'riot',label = 'شاحنة القوات الخاصة ', price = 499900},
		{model = 'riot4',label = 'شاحنة القوات الخاصة2 ', price = 499900},
		{model = 'pol5',label = 'همر قوات خاصة  -  أمن المحافظات ', price = 499900},
		{model = 'asea3',label = 'دورية سري -آسيا ', price = 199900},
		{model = 'FIBJackal',label = 'دورية سري - جاكل ', price = 199900},
		{model = 'panto99',label = 'دورية سري -آسيا ', price = 99900},
		{model = 'pol3',label = 'فان نقل السجن - فلشر ازرق احمر', price = 299900},
		{model = 'pbus',label = 'باص نقل السجن', price = 299900},
		},

		bosstwo = {
		{model = 'polkuw30',label = 'فورد فيكتوريا - شامل', price = 299900},
		{model = 'polkuw31',label = 'فورد إكسبلور - شامل', price = 799900},
		{model = 'polkuw32',label = 'فورد تورس - شامل', price = 799900},
		{model = 'polkuw06',label = 'كابرس - نجدة', price = 799900},
		{model = 'polkuwb1',label = 'دورية دراجة نارية - مرور', price = 299900},
		{model = 'polkuw34',label = 'دورية دودج شارجر ', price = 1200000},
		{model = 'polkuw02',label = 'دورية شفر تاهو  ', price = 999000},
		{model = 'sspres',label = 'سوبربان مصفح  ', price = 499900},
		{model = 'polchall70',label = 'دورية سري - دودج شالنجر ', price = 799900},
		{model = 'unmarked8',label = 'دورية سري - تاهو 2016 ', price = 799900},
		{model = 'unmarked10',label = 'دورية سري - دودج شارجر 2014 ', price = 799900},
		{model = 'unmarked11',label = 'دورية سري - دودج شارجر 2015 ', price = 799900},
		{model = 'unmarked12',label = 'دورية سري - فورد اكسبلورر 16 ', price = 799900},
		{model = 'unmarked13',label = 'دورية سري - تاهو 2016 2 ', price = 799900},
		{model = 'unmarked14',label = 'دورية سري - وانيت سلفرادو 2017 ', price = 799900},
		{model = 'unmarked15',label = 'دورية سري - إمبالا ', price = 799900},
		{model = 'unmarked16',label = 'دورية سري - فورد كراون فكتوريا 2 ', price = 799900},
		{model = 'unmarked17',label = 'دورية سري - دودج شالنجر هيلكات ', price = 799900},
		{model = 'riot',label = 'شاحنة القوات الخاصة ', price = 499900},
		{model = 'riot4',label = 'شاحنة القوات الخاصة2 ', price = 499900},
		{model = 'pol5',label = 'همر قوات خاصة  -  أمن المحافظات ', price = 499900},
		{model = 'asea3',label = 'دورية سري -آسيا ', price = 199900},
		{model = 'FIBJackal',label = 'دورية سري - جاكل ', price = 199900},
		{model = 'panto99',label = 'دورية سري -آسيا ', price = 99900},
		{model = 'pol3',label = 'فان نقل السجن - فلشر ازرق احمر', price = 299900},
		{model = 'pbus',label = 'باص نقل السجن', price = 299900},
		},

		boss = {
		{model = 'polkuw30',label = 'فورد فيكتوريا - شامل', price = 299900},
		{model = 'polkuw31',label = 'فورد إكسبلور - شامل', price = 799900},
		{model = 'polkuw32',label = 'فورد تورس - شامل', price = 799900},
		{model = 'polkuw06',label = 'كابرس - نجدة', price = 799900},
		{model = 'polkuwb1',label = 'دورية دراجة نارية - مرور', price = 299900},
		{model = 'polkuw34',label = 'دورية دودج شارجر ', price = 1200000},
		{model = 'polkuw02',label = 'دورية شفر تاهو  ', price = 999000},
		{model = 'sspres',label = 'سوبربان مصفح  ', price = 499900},
		{model = 'polchall70',label = 'دورية سري - دودج شالنجر ', price = 799900},
		{model = 'unmarked8',label = 'دورية سري - تاهو 2016 ', price = 799900},
		{model = 'unmarked10',label = 'دورية سري - دودج شارجر 2014 ', price = 799900},
		{model = 'unmarked11',label = 'دورية سري - دودج شارجر 2015 ', price = 799900},
		{model = 'unmarked12',label = 'دورية سري - فورد اكسبلورر 16 ', price = 799900},
		{model = 'unmarked13',label = 'دورية سري - تاهو 2016 2 ', price = 799900},
		{model = 'unmarked14',label = 'دورية سري - وانيت سلفرادو 2017 ', price = 799900},
		{model = 'unmarked15',label = 'دورية سري - إمبالا ', price = 799900},
		{model = 'unmarked16',label = 'دورية سري - فورد كراون فكتوريا 2 ', price = 799900},
		{model = 'unmarked17',label = 'دورية سري - دودج شالنجر هيلكات ', price = 799900},
		{model = 'riot',label = 'شاحنة القوات الخاصة ', price = 499900},
		{model = 'riot4',label = 'شاحنة القوات الخاصة2 ', price = 499900},
		{model = 'pol5',label = 'همر قوات خاصة  -  أمن المحافظات ', price = 499900},
		{model = 'asea3',label = 'دورية سري -آسيا ', price = 199900},
		{model = 'FIBJackal',label = 'دورية سري - جاكل ', price = 199900},
		{model = 'panto99',label = 'دورية سري -آسيا ', price = 99900},
		{model = 'pol3',label = 'فان نقل السجن - فلشر ازرق احمر', price = 299900},
		{model = 'pbus',label = 'باص نقل السجن', price = 299900},
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
			--{model = 'polmav', label = 'هيليكوبتر - الشرطة', props = {modLivery = 0}, price = 200000}
		},

		mola = {
			--{model = 'polmav', label = 'هيليكوبتر - الشرطة', props = {modLivery = 0}, price = 200000}
		},

		captain = {
			--{model = 'polmav', label = 'هيليكوبتر - الشرطة', props = {modLivery = 0}, price = 200000}
		},

		deputy = {
			--{model = 'polmav', label = 'هيليكوبتر - الشرطة', props = {modLivery = 0}, price = 200000}
		},

		sandy2 = {
			--{model = 'polmav', label = 'هيليكوبتر - الشرطة', props = {modLivery = 0}, price = 200000}
		},

		fbi0 = {
			--{model = 'polmav', label = 'هيليكوبتر - الشرطة', props = {modLivery = 0}, price = 200000}
		},

		fbi1 = {
			--{model = 'polmav', label = 'هيليكوبتر - الشرطة', props = {modLivery = 0}, price = 200000}
		},

		fbi2 = {
			--{model = 'polmav', label = 'هيليكوبتر - الشرطة', props = {modLivery = 0}, price = 200000}
		},

		agent = {
			--{model = 'polmav', label = 'هيليكوبتر - الشرطة', props = {modLivery = 0}, price = 200000}
		},

		special = {
			--{model = 'polmav', label = 'هيليكوبتر - الشرطة', props = {modLivery = 0}, price = 200000}
		},

		supervisor = {
			--{model = 'polmav', label = 'هيليكوبتر - الشرطة', props = {modLivery = 0}, price = 200000}
		},

		fbi3 = {
			--{model = 'polmav', label = 'هيليكوبتر - الشرطة', props = {modLivery = 0}, price = 200000}
		},

		fbi4 = {
			--{model = 'polmav', label = 'هيليكوبتر - الشرطة', props = {modLivery = 0}, price = 200000}
		},

		fbi5 = {
			--{model = 'polmav', label = 'هيليكوبتر - الشرطة', props = {modLivery = 0}, price = 200000}
		},

		assistant = {
			--{model = 'polmav', label = 'هيليكوبتر - الشرطة', props = {modLivery = 0}, price = 200000}
		},

		sandy0 = {
			--{model = 'polmav', label = 'هيليكوبتر - الشرطة', props = {modLivery = 0}, price = 200000}
		},

		sandy02 = {
			--{model = 'polmav', label = 'هيليكوبتر - الشرطة', props = {modLivery = 0}, price = 200000}
		},

		bosstwo = {
			--{model = 'polmav', label = 'هيليكوبتر - الشرطة', props = {modLivery = 0}, price = 200000}
		},

		boss = {
			--{model = 'polmav', label = 'هيليكوبتر - الشرطة', props = {modLivery = 0}, price = 200000}
		}
	}
}

Config.CustomPeds = {
	shared = {
		--{label = 'Sheriff Ped', maleModel = 's_m_y_sheriff_01', femaleModel = 's_f_y_sheriff_01'},
		--{label = 'Police Ped', maleModel = 's_m_y_cop_01', femaleModel = 's_f_y_cop_01'}
	},

	recruit = {},

	officer = {},

	sergeant = {},

	lieutenant = {},

	boss = {
		--{label = 'SWAT Ped', maleModel = 's_m_y_swat_01', femaleModel = 's_m_y_swat_01'}
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements
Config.Uniforms = { -- ['torso_1'] = 190,   ['torso_2'] = 5,
	cap_refe = {
		male = {
			['helmet_1'] = 107,  ['helmet_2'] = 25,
		},
		famle = {
			['helmet_1'] = 107,  ['helmet_2'] = 25,
		}
	},
	weapon_one_in_rgl = {
		male = {
			['chain_1'] = 1,
			['chain_2'] = 0,
		},
		famle = {
			['chain_1'] = 92,
			['chain_2'] = 0,
		}
	},
	weapon_two_in_rgl = {
		male = {
			['tshirt_1'] = 91,
			['tshirt_2'] = 0,
		},
		famle = {
			['tshirt_1'] = 91,
			['tshirt_2'] = 0,
		}
	},
	bullet_wear = { -- مضاد رصاص
		male = {
			['bproof_1'] = 29,  ['bproof_2'] = 2
		},
		female = {
			['bproof_1'] = 29,  ['bproof_2'] = 2
		}
	},
	remove_bullet_wear = { -- إزالة مضاد رصاص
		male = {
			['bproof_1'] = 0, 
			['bproof_2'] = 0,
			['tshirt_1'] = 15,
			['tshirt_2'] = 0
		},
		female = {
			['bproof_1'] = 0, 
			['bproof_2'] = 0,
			['tshirt_1'] = 15,
			['tshirt_2'] = 0
		}
	},
	
	bullet_amn3am = { -- درع إدارة الشرطة
		male = {
			['bproof_1'] = 8,  ['bproof_2'] = 0
		},
		female = {
			['bproof_1'] = 13,  ['bproof_2'] = 1
		}
	},

	bullet_amn3am_2 = { -- درع إدارة الشرطة
		male = {
			['bproof_1'] = 19,  ['bproof_2'] = 0
		},
		female = {
			['bproof_1'] = 59,  ['bproof_2'] = 1
		}
	},

	bullet_amn3am_3 = { -- درع إدارة الشرطة
		male = {
			['bproof_1'] = 1,  ['bproof_2'] = 2 
		},
		female = {
			['chain_1'] = 12,  ['chain_2'] = 0
		}
	},

	bullet_amn3am_4 = { -- درع إدارة الشرطة
		male = {
			['bproof_1'] = 1,  ['bproof_2'] = 0
		},
		female = {
			['chain_1'] = 12,  ['chain_2'] = 0
		}
	},

	bullet_amn3am_5 = { -- درع إدارة الشرطة
		male = {
			['bproof_1'] = 1,  ['bproof_2'] = 2
		},
		female = {
			['chain_1'] = 12,  ['chain_2'] = 0
		}
	},

	bullet_amn3am_6 = { -- درع إدارة الشرطة
		male = {
			['bproof_1'] = 1,  ['bproof_2'] = 1
		},
		female = {
			['chain_1'] = 12,  ['chain_2'] = 0
		}
	},
	
	bullet_amnwlayh = { --  درع أمن المحافظات
		male = {
			['bproof_1'] = 8,  ['bproof_2'] = 4
		},
		female = {
			['bproof_1'] = 13,  ['bproof_2'] = 1
		}
	},
	
	bullet_swat_clothes = { -- ضابط قوات خاصة
		m = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 53,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 31,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 117,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 1,
			['glasses_1'] = 0, 	['glasses_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 52,    ['mask_2'] = 0,
			['bproof_1'] = 1,  	['bproof_2'] = 2,
			['chain_1'] = 1,    ['chain_2'] = 0
		},
		f = {
			['tshirt_1'] = 122,  ['tshirt_2'] = 0,
			['torso_1'] = 53,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 96,
			['pants_1'] = 33,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 117,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 90,     ['mask_2'] = 6
		},
	},

	bullet_swat = { -- درع القوات الخاصة
		male = {
			['bproof_1'] = 1,  ['bproof_2'] = 2
		},
		female = {
			['bproof_1'] = 1,  ['bproof_2'] = 1
		}
	},

	swat_hel = {
		male = {
			['helmet_1'] = 117,  ['helmet_2'] = 0
		},
		female = {
			['helmet_1'] = 117,  ['helmet_2'] = 0
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
	swat_wear = { --5 ضابط قوات خاصة
        male = {
			['tshirt_1'] = 122,  ['tshirt_2'] = 0,
			['torso_1'] = 53,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 96,
			['pants_1'] = 33,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 117,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			--['mask_1'] = 90,     ['mask_2'] = 6
		},
	    female = {
			['tshirt_1'] = 122,  ['tshirt_2'] = 0,
			['torso_1'] = 53,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 96,
			['pants_1'] = 33,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 117,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 90,     ['mask_2'] = 6
		}
	},
	
	empty = { -- تسجيل الدخول بنفس اللبس
        male = {
			--['mask_1'] = 90,     ['mask_2'] = 6 -- هاذه تسجيل دخول بنفس لبسك طبيعي مايكون فيه شي (:
		},
	    female = {
            --['mask_1'] = 90,     ['mask_2'] = 6
		}
	},
	
	cid_badge = { -- باقة الامن الجنائي
		male = {
			--['chain_1'] = 125,  ['chain_2'] = 0
			['chain_1'] = 43,  ['chain_2'] = 0
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
			['tshirt_1'] = 137,  ['tshirt_2'] = 0
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
	black_jacket = { -- جاكيت اسود
		male = {
			['tshirt_1'] = 56,  ['tshirt_2'] = 0
		},
		female = {
			['tshirt_1'] = 56,  ['tshirt_2'] = 0
		}
	},   

	bullet_frd = { -- حزام
		male = {
			['tshirt_1'] = 122,  ['tshirt_2'] = 0
		},
		female = {
			['tshirt_1'] = 56,  ['tshirt_2'] = 0
		}
	},   
	
	helmet_open_police = { 	-- خوذة اسود مفتوح 
		male = {
			['helmet_1'] = 126,  ['helmet_2'] = 18
		},
		female = {
			['helmet_1'] = 126,  ['helmet_2'] = 18
		}
	},
	helmet_1 = { --بريهة اسود
		male = {
			['helmet_1'] = 106,  ['helmet_2'] = 1,
		},
		female = {
			['helmet_1'] = 106,  ['helmet_2'] = 20,
		}
	},
	helmet_2 = { --بريهة اسود
		male = {
			['helmet_1'] = 106,  ['helmet_2'] = 0,
		},
		female = {
			['helmet_1'] = 106,  ['helmet_2'] = 0,
		}
	},
	
	helmet_1_shaml = { --بريهة اسود
		male = {
			['helmet_1'] = 29,  ['helmet_2'] = 0,
		},
		female = {
			['helmet_1'] = 29,  ['helmet_2'] = 0,
		}
	},
	helmet_2_shaml = { --بريهة اسود
		male = {
			['helmet_1'] = 29,  ['helmet_2'] = 1,
		},
		female = {
			['helmet_1'] = 29,  ['helmet_2'] = 1,
		}
	},

	helmet_close_police = {	-- خوذة اسود مغلق
		male = {
			['helmet_1'] = 125,  ['helmet_2'] = 18
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
	
	mask_remove = { -- إزالة قناع
		male = {
			['mask_1'] = 0,		['mask_2'] = 0,
		},
		female = {
			['mask_1'] = 0,		['mask_2'] = 0,
		}
	},
	helmet_remove = { -- إزالة قناع
		male = {
			['helmet_1'] = -1, ['helmet_2'] = 0
		},
		female = {
			['helmet_1'] = -1, ['helmet_2'] = 0
		}
	},

    mroor = { -- لبس المرور
		male = {
			['tshirt_1'] = 130,  ['tshirt_2'] = 0,
			['torso_1'] = 118,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 59,   ['pants_2'] = 0,
			['shoes_1'] = 53,   ['shoes_2'] = 0,
			['helmet_1'] = 107,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['bags_1'] = 0,     ['bags_2'] = 0	
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


	recruit = {
		male = {
			['tshirt_1'] = 44,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 22,   ['pants_2'] = 3,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 1,     ['ears_2'] = 0,
			['bags_1'] = 0,     ['bags_2'] = 0	
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

	officer = {
		male = {
			['tshirt_1'] = 105,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 22,   ['pants_2'] = 0,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bags_1'] = 52,     ['bags_2'] = 1	
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	sergeant = {
		male = {
			['tshirt_1'] = 105,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 22,   ['pants_2'] = 0,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bags_1'] = 52,     ['bags_2'] = 1	
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 1,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	intendent = {
		male = {
			['tshirt_1'] = 105,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 22,   ['pants_2'] = 0,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bags_1'] = 52,     ['bags_2'] = 1			
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 45,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},

	lieutenant = {
		male = {
			['tshirt_1'] = 105,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 4,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 22,   ['pants_2'] = 0,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bags_1'] = 52,     ['bags_2'] = 1	
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	chef = {
		male = {
			['tshirt_1'] = 105,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 5,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 22,   ['pants_2'] = 0,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bags_1'] = 52,     ['bags_2'] = 1	
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	inspector = {
		male = {
			['tshirt_1'] = 105,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 6,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 22,   ['pants_2'] = 0,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bags_1'] = 52,     ['bags_2'] = 1	
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	mola = {
		male = {
			['tshirt_1'] = 105,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 7,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 22,   ['pants_2'] = 0,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bags_1'] = 52,     ['bags_2'] = 1	
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	captain = {
		male = {
			['tshirt_1'] = 105,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 8,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 22,   ['pants_2'] = 0,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bags_1'] = 52,     ['bags_2'] = 1	
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	deputy = {
		male = {
			['tshirt_1'] = 105,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 9,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 22,   ['pants_2'] = 0,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bags_1'] = 52,     ['bags_2'] = 1	
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	sandy2 = {
		male = {
			['tshirt_1'] = 105,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 10,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 22,   ['pants_2'] = 0,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bags_1'] = 52,     ['bags_2'] = 1	
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	fbi0 = {
		male = {
			['tshirt_1'] = 105,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 11,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 22,   ['pants_2'] = 0,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bags_1'] = 52,     ['bags_2'] = 1	
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	fbi1 = {
		male = {
			['tshirt_1'] = 105,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 12,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 22,   ['pants_2'] = 0,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bags_1'] = 52,     ['bags_2'] = 1	
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	fbi2 = {
		male = {
			['tshirt_1'] = 105,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 13,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 22,   ['pants_2'] = 0,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bags_1'] = 52,     ['bags_2'] = 1	
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	agent = {
		male = {
			['tshirt_1'] = 105,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 14,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 22,   ['pants_2'] = 0,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bags_1'] = 52,     ['bags_2'] = 1	
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	special = {
		male = {
			['tshirt_1'] = 105,  ['tshirt_2'] = 8,
			['torso_1'] = 190,   ['torso_2'] = 15,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 22,   ['pants_2'] = 0,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bags_1'] = 52,     ['bags_2'] = 1	
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	supervisor = {
		male = {
			['tshirt_1'] = 105,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 16,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 22,   ['pants_2'] = 0,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bags_1'] = 52,     ['bags_2'] = 1	
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	fbi3 = {
		male = {
			['tshirt_1'] = 105,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 17,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 22,   ['pants_2'] = 0,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bags_1'] = 52,     ['bags_2'] = 1	
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	fbi4 = {
		male = {
			['tshirt_1'] = 105,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 18,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 22,   ['pants_2'] = 0,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bags_1'] = 52,     ['bags_2'] = 1	
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	fbi5 = {
		male = {
			['tshirt_1'] = 105,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 19,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 22,   ['pants_2'] = 0,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bags_1'] = 52,     ['bags_2'] = 1	
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	assistant = {
		male = {
			['tshirt_1'] = 105,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 20,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 22,   ['pants_2'] = 0,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bags_1'] = 52,     ['bags_2'] = 1	
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	sandy0 = {
		male = {
			['tshirt_1'] = 105,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 21,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 22,   ['pants_2'] = 0,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bags_1'] = 52,     ['bags_2'] = 1	
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	sandy02 = {
		male = {
			['tshirt_1'] = 105,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 22,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 22,   ['pants_2'] = 0,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bags_1'] = 52,     ['bags_2'] = 1	
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    --[[
	bosstwo = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 15,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 35,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bags_1'] = 52,     ['bags_2'] = 1	
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 3,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	boss = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 15,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 35,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 28,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bags_1'] = 52,     ['bags_2'] = 1	
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 3,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	}, --]]
--[[
	bullet_wear = {
		male = {
			bproof_1 = 11,  bproof_2 = 1
		},
		female = {
			bproof_1 = 13,  bproof_2 = 1
		}
	}, --]]

	gilet_wear = {
		male = {
			tshirt_1 = 59,  tshirt_2 = 1
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1
		}
	}
}