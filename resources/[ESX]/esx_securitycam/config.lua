Config = {}
Config.DrawDistance = 20.0
Config.HideRadar = true -- Hide HUD?
Config.AnimTime = 60 -- Animation for the hacking in seconds. 60 = 1 minute / 60 seconds!

Config.Locale = 'en'
Config.pNotify = true -- Only enable this if you have pNotify (https://github.com/Nick78111/pNotify)
Config.Hacking = false -- Only enable if you have mhacking (https://github.com/GHMatti/FiveM-Scripts/tree/master/mhacking)

-- Connect to the cameras
-- Place: In the polices armory room
Config.Zones = {
	cam1 = {
		location = 'cameras',
		job = 'police',
		Pos   = {x = 482.5, y = -998.53, z = 29.69},
		Size  = {x = 1.7, y = 1.7, z = 0.5},
		Color = {r = 26, g = 55, b = 186},
		Type = 27
	},

	cam2 = {
		location = 'cameras',
		job = 'police',
		Pos   = {x = 1844.5, y = 3691.41, z = 33.26},
		Size  = {x = 1.7, y = 1.7, z = 0.5},
		Color = {r = 26, g = 55, b = 186},
		Type = 27
	},

	cam3 = {
		location = 'cameras',
		job = 'police',
		Pos   = {x = -435.45, y = 6000.21, z = 31.0},
		Size  = {x = 1.7, y = 1.7, z = 0.5},
		Color = {r = 26, g = 55, b = 186},
		Type = 27
	},
	
	--[[cam2 = { --البوابة الرئيسية الميناء
		location = 'cameras',
		job = 'agent',
		Pos   = {x = 740.72, y = -2607.91, z = 17.51},
		Size  = {x = 1.5, y = 1.5, z = 0.5},
		Color = {r = 26, g = 55, b = 186},
		Type = 27
	},
	
	cam3 = { --البوابة الرئيسية الميناء
		location = 'cameras',
		job = 'agent',
		Pos   = {x = 722.35, y = -2607.98, z = 17.55},
		Size  = {x = 1.5, y = 1.5, z = 0.5},
		Color = {r = 26, g = 55, b = 186},
		Type = 27
	},
	]]
	
	cam4 = { --مكتب حرس الحدود الميناء
		location = 'cameras',
		job = 'agent',
		Pos   = {x = 633.2703, y = -2909.47, z = 4.9826},
		Size  = {x = 1.5, y = 1.5, z = 0.5},
		Color = {r = 26, g = 55, b = 186},
		Type = 27
	},

	cam9 = { --مكتب حرس الحدود الميناء
		location = 'cameras',
		job = 'agent',
		Pos   = {x = -56.3279, y = -2522.16, z = 6.3874},
		Size  = {x = 1.5, y = 1.5, z = 0.5},
		Color = {r = 26, g = 55, b = 186},
		Type = 27
	},
	
	cam5 = { --مكتب الشرطة الميناء
		location = 'cameras',
		job = 'police',
		Pos   = {x = 756.19, y = -2908.92, z = 7.55},
		Size  = {x = 1.5, y = 1.5, z = 0.5},
		Color = {r = 26, g = 55, b = 186},
		Type = 27
	},
	
	cam6 = { --مكتب الرقابة و التفتيش الميناء
		location = 'cameras',
		job = 'admin',
		Pos   = {x = 756.94, y = -2917.83, z = 7.55},
		Size  = {x = 1.5, y = 1.5, z = 0.5},
		Color = {r = 26, g = 55, b = 186},
		Type = 27
	},
	
	cam8 = { --مقر الرقابة و التفتيش
		location = 'cameras',
		job = 'admin',
		Pos   = {x = 235.0553, y = -1099.83, z = 28.294},
		Size  = {x = 1.5, y = 1.5, z = 0.5},
		Color = {r = 26, g = 55, b = 186},
		Type = 27
	},	
	
}

-- Keep these the same
-- Place: Behind the polices desk in the policestation
-- Screenshot: https://i.imgur.com/f5WNrRj.jpg
Config.HackingPolice = {
	HackingPolice = {
		Pos   = {x = 440.17, y = -975.74, z = 29.69},
		Size  = {x = 1.7, y = 1.7, z = 0.5},
		Color = {r = 26, g = 55, b = 186},
		Type = 27,
	}
}

Config.UnHackPolice = {
	UnHackPolice = {
		Pos   = {x = 440.17, y = -975.74, z = 29.69},
		Size  = {x = 1.7, y = 1.7, z = 0.5},
		Color = {r = 26, g = 55, b = 186},
		Type = 27,
	}
}

-- Keep these the same
-- Place: Down at the bank vault
-- Screenshot: https://i.imgur.com/nvcFUhu.jpg
Config.HackingBank = {
	HackingBank = {
		Pos   = {x = 264.87, y = 219.93, z = 100.68},
		Size  = {x = 1.7, y = 1.7, z = 0.5},
		Color = {r = 26, g = 55, b = 186},
		Type = 27,
	}
}

Config.UnHackBank = {
	UnHackBank = {
		Pos   = {x = 264.87, y = 219.93, z = 100.68},
		Size  = {x = 1.7, y = 1.7, z = 0.5},
		Color = {r = 26, g = 55, b = 186},
		Type = 27,
	}
}

-- Cameras. You could add more cameras for other banks, apartments, houses, buildings etc. (Remember the "," after each row, but not on the last row)
Config.Locations = {
	{
	bankCamLabel = {label = 'البنك المركزي'},
		bankCameras = {
			{label = _U('bcam'), x = 232.86, y = 221.46, z = 107.83, r = {x = -25.0, y = 0.0, z = -140.91}, canRotate = true},
			{label = _U('bcam2'), x = 257.45, y = 210.07, z = 109.08, r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = true},
			{label = _U('bcam3'), x = 261.50, y = 218.08, z = 107.95, r = {x = -25.0, y = 0.0, z = -149.49}, canRotate = true},
			{label = _U('bcam4'), x = 241.64, y = 233.83, z = 111.48, r = {x = -35.0, y = 0.0, z = 120.46}, canRotate = true},
			{label = _U('bcam5'), x = 269.66, y = 223.67, z = 113.23, r = {x = -30.0, y = 0.0, z = 111.29}, canRotate = true},
			{label = _U('bcam6'), x = 261.98, y = 217.92, z = 113.25, r = {x = -40.0, y = 0.0, z = -159.49}, canRotate = true},
			{label = _U('bcam7'), x = 258.44, y = 204.97, z = 113.25, r = {x = -30.0, y = 0.0, z = 10.50}, canRotate = true},
			{label = _U('bcam8'), x = 235.53, y = 227.37, z = 113.23, r = {x = -35.0, y = 0.0, z = -160.29}, canRotate = true},
			{label = _U('bcam9'), x = 254.72, y = 206.06, z = 113.28, r = {x = -35.0, y = 0.0, z = 44.70}, canRotate = true},
			{label = _U('bcam10'), x = 269.89, y = 223.76, z = 106.48, r = {x = -35.0, y = 0.0, z = 112.62}, canRotate = true},
			{label = _U('bcam11'), x = 252.27, y = 225.52, z = 103.99, r = {x = -35.0, y = 0.0, z = -74.87}, canRotate = true}
		},

	policeCamLabel = {label = 'مركز الشرطة'},
		policeCameras = {
			{label = _U('pcam'), x = 416.744, y = -1009.270, z = 34.08, r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = true},
			{label = _U('pcam2'), x = 465.151, y = -994.266, z = 27.23, r = {x = -30.0, y = 0.0, z = 100.29}, canRotate = true},
			{label = _U('pcam3'), x = 465.631, y = -997.777, z = 27.48, r = {x = -35.0, y = 0.0, z = 90.46}, canRotate = true},
			{label = _U('pcam4'), x = 465.544, y = -1001.583, z = 27.1, r = {x = -25.0, y = 0.0, z = 90.01}, canRotate = true},
			{label = _U('pcam5'), x = 420.241, y = -1009.010, z = 34.95, r = {x = -25.0, y = 0.0, z = 230.95}, canRotate = true},
			{label = _U('pcam6'), x = 433.249, y = -977.786, z = 33.456, r = {x = -40.0, y = 0.0, z = 100.49}, canRotate = true},
			{label = _U('pcam7'), x = 449.440, y = -987.639, z = 33.25, r = {x = -30.0, y = 0.0, z = 50.50}, canRotate = true},
			{label = 'مركز ساندي', x = 1872.11, y = 3680.31, z = 38.45, r = {x = -30.0, y = 0.0, z = 207.14}, canRotate = true},
			{label = 'نقطة بليتو', x = 1385.98, y = 6455.31, z = 29.85, r = {x = -30.0, y = 0.0, z = 262.15}, canRotate = true},
			{label = 'كراج لوس سانتس', x = 218.27, y = -1459.33, z = 36.14, r = {x = -30.0, y = 0.0, z = 348.65}, canRotate = true},
			{label = 'تنظيف الحجر', x = 273.18, y = 2836.73, z = 52.93, r = {x = -30.0, y = 0.0, z = 323.48}, canRotate = true},
		},

	
	seeportCamLabel = {label = 'ميناء مدينة 101 البحري'},
		seeportCameras = {
			{label = 'تفتيش (G1)', x = 707.95, y = -2766.8, z = 13.21, r = {x = -25.0, y = 0.0, z = 195.04}, canRotate = true},
			{label = 'تفتيش (T3)', x = 1267.68, y = -3082.06, z = 29.81, r = {x = -25.0, y = 0.0, z = 86.41}, canRotate = true},
			{label = 'تفتيش (G2)', x = 1151.94, y = -3337.81, z = 29.81, r = {x = -25.0, y = 0.0, z = 83.4}, canRotate = true},
			{label = 'المستودع العام', x = 776.63, y = -3235.38, z = 17.52, r = {x = -25.0, y = 0.0, z = 274.24}, canRotate = true},
			{label = 'المركز (C1)', x = 754.94, y = -3034.7, z = 28.3, r = {x = -25.0, y = 0.0, z = 352.24}, canRotate = true},
			{label = 'نقطة تصدير', x = 857.36, y = -2963.77, z = 28.3, r = {x = -25.0, y = 0.0, z = 286.23}, canRotate = true},
			{label = 'نقطة التفتيش', x = 702.08, y = -2771.74, z = 9.49, r = {x = -25.0, y = 0.0, z = 225.45}, canRotate = true},
			{label = 'نقطةالمراقبه1', x = 720.18, y = -2855.96, z = 9.41, r = {x = -25.0, y = 0.0, z = 351.77}, canRotate = false},
			{label = 'نقطة G2', x = 1020.47, y = -3238.15, z = 29.99, r = {x = -25.0, y = 0.0, z = 6.76}, canRotate = true},
			{label = 'البوابةالرئيسية', x = 731.77, y = -2626.97, z = 21.5, r = {x = -25.0, y = 0.0, z = 359.54}, canRotate = false},
			
			--[[
			{label = 'بقالة 1-1', x = -44.15, y = -1747.94, z = 30.43, r = {x = -25.0, y = 0.0, z = 200.95}, canRotate = true},
			{label = 'بقالة 1-2', x = -53.12, y = -1746.82, z = 31.69, r = {x = -25.0, y = 0.0, z = 190.62}, canRotate = true},
			{label = 'بقالة 2-1', x = 31.45, y = -1341.45, z = 31.32, r = {x = -25.0, y = 0.0, z = 73.82}, canRotate = true},
			{label = 'بقالة 2-2', x = 34.51, y = -1348.69, z = 31.32, r = {x = -25.0, y = 0.0, z = 58.82}, canRotate = true},
			{label = 'بقالة 3-1', x = 1125.14, y = -982.71, z = 47.64, r = {x = -25.0, y = 0.0, z = 319.81}, canRotate = true},
			{label = 'بقالة 3-2', x = 1140.33, y = -983.96, z = 47.64, r = {x = -25.0, y = 0.0, z = 43.81}, canRotate = true},
			{label = 'بقالة 4-1', x = -710.35, y = -904.37, z = 20.6, r = {x = -25.0, y = 0.0, z = 229.79}, canRotate = true},
			{label = 'بقالة 4-2', x = -718.12, y = -915.93, z = 20.97, r = {x = -25.0, y = 0.0, z = 286.79}, canRotate = true},
			]]
		},
	}
	
	
}
