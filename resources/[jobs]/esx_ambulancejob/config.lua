Config                            = {}
Config.is_set_police_level = false
Config.DrawDistance               = 20.0 -- How close do you need to be in order for the markers to be drawn (in GTA units).

Config.Marker                     = {type = 21, x = 0.9, y = 0.5, z = 0.5, r = 255, g = 0, b = 0, a = 100, rotate = true}

Config.ReviveReward               = 12000  -- Revive reward, set to 0 if you don't want it enabled
Config.ReviveRewardXp             = 500
Config.timeBetwenRevive = 60 -- الوقت مابين كل أنعاش بالثواني

Config.AntiCombatLog              = true -- Enable anti-combat logging? (Removes Items when a player logs back after intentionally logging out while dead.)
Config.LoadIpl                    = true -- Disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'en'

Config.EarlyRespawnTimer          = 60000 * 10  -- time til respawn is available
Config.BleedoutTimer              = 60000 * 10 -- time til the player bleeds out


Config.EnablePlayerManagement     = true -- Enable society managing (If you are using esx_society).

Config.EnableESXService           = false -- لاتغير شي واسحب عليه ولاتحذفه بس خليه وشكرا
Config.MaxInService               = -1 -- لاتعدل شي

Config.EnableServiceMain       = false --  تفعيل وإلغاء إذا موب مسجل دخول مايقدر يفتح قائمة الطوارئ الطبية وكذا -- addon Service [Al Hijaz Region ]

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = true
Config.EarlyRespawnFineAmount     = 15000


Config.PriceRevivePlayer = {
	[0] = {price = 10000},
	[1] = {price = 11000},
	[2] = {price = 12000},
	[3] = {price = 13000},
	[4] = {price = 14000},
	[5] = {price = 14500},
	[6] = {price = 15000},
	[7] = {price = 15500},
	[8] = {price = 16000},
	[9] = {price = 16500},
	[9] = {price = 17000},
	[10] = {price = 17500},
	[11] = {price = 18000},
	[12] = {price = 18500},
}

Config.deathTypeMsg = {
	[0] = '^1'..'تم نقله بعد نزيف حاد',
	[1] = '^1'..'اختار الانتقال قبل انتهاء الوقت',
	[2] = '^1'..'تم نقله للمستشفى فصل وهو في حالة نزيف',
}
Config.jailedRespawnPoint = {
	coords = vector3(1734.09,2623.25,45.96),
	heading = 0.11,	
	label = '🏥 عيادة السجن المركزي'
}	

Config.RespawnPoint = {

	PhillboxHillHospital_1 = {
		coords = vector3(351.64, -588.58, 28.8), 
		heading = 249.85,	
		label = '🏥 مستشفى محافظة شقراء المركزي'
	},
	
	losmaingarage = {
		coords = vector3(338.8747, -1395.125, 32.49817), 
		heading = 46.94,	
		label = '🏥 مستشفى محافظة شقراء'
	},
	
	SandyHospital = {
		coords = vector3(1841.559, 3668.875, 33.679), 
		heading = 227.87,	
		label = '🏥 مستشفى ساندي'
	},
	
	StFaicerHospital = {
		coords = vector3(1152.58, -1527.44, 34.84), 
		heading = 334.17,	
		label = '🏥 مستشفى الدفاع المدني'
	},
	
	PaletoMedicCenter = {
		coords = vector3(-252.61, -6336.2, 32.43), 
		heading = 219.06,	
		label = '🏥  مستشفى الملك فهد'
	},

}

Config.HospitalsBlips = { -- 316.1328, -593.621, 43.292
	CentralLosSantos = {
			coords = vector3(307.7, -1433.4, 28.9),
			sprite = 61,
			scale  = 1.2,
			color  = 2,
			info = "<FONT FACE='A9eelsh'>ﻰﻔﺸﺘﺴﻣ" --'Medical Center'
	},
	
    SandyHospital = {
			--coords = vector3(1826.7,3694.5,34.2),
			coords = vector3(1833.12,3679.01,34.27),
			sprite = 61,
			scale  = 1.0,
			color  = 2,
			info = "<FONT FACE='A9eelsh'>ﻰﻔﺸﺘﺴﻣ" --'Medical Center'
	},
	
	--[[ -- not active
	MountZonahHospital = {
			coords = vector3(-498.89, -335.69, 33.50),
			sprite = 61,
			scale  = 1.0,
			color  = 2,
			info = "<FONT FACE='A9eelsh'>ﻰﻔﺸﺘﺴﻣ" --'Medical Center'
	},--]]
	
	PhillboxHillHospital = {
			coords = vector3(316.1328, -593.621, 43.292),
			sprite = 61,
			scale  = 1.0,
			color  = 2,
			info = "<FONT FACE='A9eelsh'>ﻰﻔﺸﺘﺴﻣ" --'Medical Center'
	},
	
	StFaicerHospital = {
			coords = vector3(1151.91,-1528.58,34.99),
			sprite = 61,
			scale  = 1.0,
			color  = 2,
			info = "<FONT FACE='A9eelsh'>ﻰﻔﺸﺘﺴﻣ" --'Medical Center'
	},
	
	PaletoBayHospital = {
			coords = vector3(-245.7,6329.74,32.43),
			sprite = 61,
			scale  = 1.0,
			color  = 2,
			info = "<FONT FACE='A9eelsh'>ﻰﻔﺸﺘﺴﻣ" --'Medical Center'
	},
	
	-- Fire Stations -- 
	
	LosSantosFireDP = {
			coords = vector3(205.18,-1652.25,29.8),
			sprite = 60,
			scale  = 1.0,
			color  = 1,
			info = "<FONT FACE='A9eelsh'>ﺀﺎﻔﻃﺇ ﺰﻛﺮﻣ" --'Fire Station'
	},
	
	LosSantosFireDP2 = {
			coords = vector3(1201.0,-1475.08,34.86),
			sprite = 60,
			scale  = 1.0,
			color  = 1,
			info = "<FONT FACE='A9eelsh'>ﺀﺎﻔﻃﺇ ﺰﻛﺮﻣ" --'Fire Station'
	},
	
	LosSantosFireDP3 = {
			coords = vector3(-646.13,-115.9,37.89),
			sprite = 60,
			scale  = 1.0,
			color  = 1,
			info = "<FONT FACE='A9eelsh'>ﺀﺎﻔﻃﺇ ﺰﻛﺮﻣ" --'Fire Station'
	},
	
	PaletoFirestation = {
			coords = vector3(-383.6,6122.2,31.4),
			sprite = 60,
			scale  = 1.0,
			color  = 1,
			info = "<FONT FACE='A9eelsh'>ﺀﺎﻔﻃﺇ ﺰﻛﺮﻣ" --'Fire Station'
	},
	
	SandyFirestation = {
			coords = vector3(1693.82,3590.71,35.62),
			sprite = 60,
			scale  = 1.0,
			color  = 1,
			info = "<FONT FACE='A9eelsh'>ﺀﺎﻔﻃﺇ ﺰﻛﺮﻣ" --'Fire Station'
	},
	
	LSIAFirestation = { --مطار الملك عبدالعزيز الدولي
			coords = vector3(-1075.53,-2376.93,13.95),
			sprite = 60,
			scale  = 1.0,
			color  = 1,
			info = "<FONT FACE='A9eelsh'>ﺀﺎﻔﻃﺇ ﺰﻛﺮﻣ" --'Fire Station'
	},

}	

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(316.1328, -593.621, 43.292),
			sprite = 61,
			scale  = 1.2,
			color  = 2
		},

		AmbulanceActions = {
			vector3(301.14, -599.23, 43.0)
		},

		Pharmacies = {
			vector3(306.95, -601.19, 43.28)
		},

		Vehicles = {
			{
				Spawner = vector3(296.0547, -591.250, 0.272),
				InsideShop = vector3(292.5788, -610.463, 0.375),
				Marker = {type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(291.7574, -573.259, 0.199), heading = 71.03, radius = 4.0},
					{coords = vector3(291.5164, -587.700, 0.192), heading = 333.89, radius = 4.0}
				}
			},
			
			{
				Spawner = vector3(328.3928, -577.9638, 28.79685), -- كراج المستشفى تحت
				InsideShop = vector3(292.5788, -610.463, 0.375),
				Marker = {type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(317.6527, -578.515, 28.79685), heading = 339.3, radius = 4.0},
					{coords = vector3(318.9366, -574.1501, 28.79685), heading = 339.3, radius = 4.0},
					{coords = vector3(320.9168, -570.0731, 28.79685), heading = 250.59, radius = 4.0},
					{coords = vector3(320.5235, -565.2094, 28.79685), heading = 250.59, radius = 4.0},
					{coords = vector3(322.9406, -586.9393, 28.79685), heading = 339.3, radius = 4.0}
				}
			}			
			
		},

		Helicopters = {
			{
				Spawner = vector3(340.2613, -589.203, 74.165),
				InsideShop = vector3(360.5834, -594.388, 28.654),
				Marker = {type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(351.2737, -587.872, 74.165), heading = 277.43, radius = 10.0}
				}
			}
		},

		FastTravels = {
			--
			{ -- pillbox
				From = vector3(332.37, -595.72, 43.28),-- up to down
				To = { coords = vector3(341.7, -584.89, 74.16), heading = 246.79 },
				Marker = { type = 2, x = 0.5, y = 0.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = true }
			},

			{ -- pillbox
				From = vector3(339.05, -583.94, 74.16), -- down to up
				To = { coords = vector3(330.32, -601.13, 43.28), heading = 70.87 },
				Marker = { type = 2, x = 0.5, y = 0.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = true }
			},
			
		},

		FastTravelsPrompt = {
		--
			{ -- pillbox
				From = vector3(327.13, -603.96, 43.28),-- up to down garage
				To = { coords = vector3(340.1, -584.69, 28.8), heading = 70.96 },
				Marker = { type = 2, x = 0.5, y = 0.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = true },
				Prompt = _U('fast_travel_gotopillpox')
			},

			{ -- pillbox
				From = vector3(340.1, -584.69, 28.8), -- down to up garage
				To = { coords = vector3(327.13, -603.96, 43.28), heading = 70.87 },
				Marker = { type = 2, x = 0.5, y = 0.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = true },
				Prompt = _U('fast_travel_gotogarage')
			},
			
		},

	},
	
	losmaingarage = { -- مستشفى لوس قرب الكراج العمومي

		Blip = {
			coords = vector3(294.7, -1448.1, 29.0),
			sprite = 61,
			scale  = 1.2,
			color  = 2
		},

		
		AmbulanceActions = {
			vector3(367.92, -1404.53, 32.96),
			vector3(281.09, -1445.61, 29.97)
		},

		Pharmacies = {
			vector3(359.04, -1391.55, 32.43),
			vector3(302.23, -1460.2, 29.97)
		},

		Vehicles = {
			{
				Spawner    = vector3(293.4,-1442.54,29.97),
				InsideShop = vector3(452.18,-1359.85,38.55),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 0, b = 0, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(297.2, -1429.5, 29.8), heading = 227.6, radius = 4.0 },
					{ coords = vector3(294.0, -1433.1, 29.8), heading = 227.6, radius = 4.0 },
					{ coords = vector3(309.4, -1442.5, 29.8), heading = 227.6, radius = 6.0 },
				}
				},
				
                 { -- خلف المستشفى
				Spawner = vector3(395.91, -1433.36, 29.46),
				InsideShop = vector3(452.18,-1359.85,38.55),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 0, b = 0, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(398.78, -1429.06, 29.45), heading = 227.6, radius = 4.0 },
					{ coords = vector3(407.86, -1417.8, 29.42), heading = 133.69, radius = 4.0 },
					{ coords = vector3(397.05, -1438.04, 29.45), heading = 310.22, radius = 6.0 }
				}
				}
			},

		Helicopters = {
			{
				Spawner = vector3(340.2613, -589.203, 74.165),
				InsideShop = vector3(360.5834, -594.388, 28.654),
				Marker = {type = 34, x = 1.5, y = 1.5, z = 1.5, r = 255, g = 0, b = 0, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(351.2737, -587.872, 74.165), heading = 277.43, radius = 10.0}
				}
				}
		},

		FastTravels = {
		},

		FastTravelsPrompt = {
		}

	},
	
	StFaicerHospital = { -- مستشفى شرق لوس فوق الميناء

		Blip = {
			coords = vector3(1150.88,-1529.85,34.37),
			sprite = 61,
			scale  = 1.2,
			color  = 2
		},

		AmbulanceActions = {
			vector3(1147.13,-1591.14,3.95), --StFaicerHospital
			vector3(1139.91,-1568.72,3.95) --StFaicerHospital
		},

		Pharmacies = {
			vector3(1127.8,-1558.98,3.95), --StFaicerHospital
			vector3(1134.83,-1549.31,3.95) --StFaicerHospital
		},

		Vehicles = {
			{ --StFaicerHospital
				Spawner    = vector3(1149.29,-1518,34.84),
				InsideShop = vector3(1193.33, -1566.04, 39.04),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 0, b = 0, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(1154.16,-1513.92,34.42), heading = 270.59, radius = 6.0 },
					{ coords = vector3(1166.27,-1513.8,34.42), heading = 270.59, radius = 6.0 },
				}		
				}	
		},

		Helicopters = {
			{
				Spawner = vector3(340.2613, -589.203, 74.165),
				InsideShop = vector3(360.5834, -594.388, 28.654),
				Marker = {type = 34, x = 1.5, y = 1.5, z = 1.5, r = 255, g = 0, b = 0, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(351.2737, -587.872, 74.165), heading = 277.43, radius = 10.0}
				}
			}
		},

		FastTravels = {
			--[[
			{ -- مستشفى لوس قرب الكراج العمومي
				From = vector3(294.7, -1448.1, 29.0),
				To = { coords = vector3(272.8, -1358.8, 23.5), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{ -- مستشفى لوس قرب الكراج العمومي
				From = vector3(275.3, -1361, 23.5),
				To = { coords = vector3(295.8, -1446.5, 28.9), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},
			
			{ -- مستشفى لوس قرب الكراج العمومي
				From = vector3(247.3, -1371.5, 23.5),
				To = { coords = vector3(333.1, -1434.9, 45.5), heading = 138.6 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{ -- مستشفى لوس قرب الكراج العمومي
				From = vector3(335.5, -1432.0, 45.50),
				To = { coords = vector3(249.1, -1369.6, 23.5), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},
			
			{ -- مستشفى لوس قرب الكراج العمومي
				From = vector3(234.5, -1373.7, 20.9),
				To = { coords = vector3(320.9, -1478.6, 28.8), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{ -- مستشفى لوس قرب الكراج العمومي
				From = vector3(317.9, -1476.1, 28.9),
				To = { coords = vector3(238.6, -1368.4, 23.5), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},
			--]]
			--[[ { --sandy
				From = vector3(1828.28, 3691.99, 33.22), --from outside to inside hostpital
				To = { coords = vector3(1840.73, 3673.08, 9.69), heading = 32.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},
			
			{ --sandy
				From = vector3(1841.58, 3671.04, 9.69), --from inside to outside hostpital
				To = { coords = vector3(1826.61, 3694.72, 33.22), heading = 34.22 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			}, ]]
			
			{ --StFaicerHospital
				From = vector3(1146.92,-1560.05,3.95), --from inside to outside hostpital
				To = { coords = vector3(1152.58, -1527.44, 33.84), heading = 334.17 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},
			
			{ --StFaicerHospital
				From = vector3(1150.88,-1529.85,34.37), --from outside to inside hostpital
				To = { coords = vector3(1146.71, -1563.87, 3.95), heading = 177.24 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},
			
		},

		FastTravelsPrompt = {
		}

	},

	SandyMedicCenter = {

		Blip = {
			coords = vector3(1834.610, 3690.396, 34.270),
			sprite = 61,
			scale  = 1.2,
			color  = 2
		},

		AmbulanceActions = {
			vector3(1825.81005859375, 3674.699951171875, 34.27000045776367)
		},

		Pharmacies = {
			vector3(1820.298, 3674.911, 33.270)
		},

		Vehicles = {
			{
				Spawner = vector3(1824.668, 3690.331, 34.224),
				InsideShop = vector3(1811.752, 3685.040, 34.224),
				Marker = {type = 36, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 0, b = 0, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(1843.365, 3705.736, 33.649), heading = 31.92, radius = 4.0}
				}
			}		
			
		},

		Helicopters = {
			{
				Spawner = vector3(1836.550, 3643.233, 34.212),
				InsideShop = vector3(1847.243, 3634.761, 35.502),
				Marker = {type = 34, x = 1.5, y = 1.5, z = 1.5, r = 255, g = 0, b = 0, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(1847.243, 3634.761, 35.502), heading = 277.43, radius = 10.0}
				}
			}
		},

		FastTravels = {
		},

		FastTravelsPrompt = {
		}

	},
	
	mainmina = { -- ميناء محافظة شقراء البحري

		Blip = {
		},

		AmbulanceActions = {
			vector3(803.4, -2912.34, 6.13)
		},

		Pharmacies = {
			vector3(808.5564, -2912.493, 6.126944)
		},

		Vehicles = {
			{
				Spawner = vector3(825.05, -2931.82, 5.9),
				InsideShop = vector3(791.14, -2992.6, 6.02),
				Marker = {type = 36, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 0, b = 0, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(828.63, -2928.38, 5.9), heading = 271.49, radius = 6.0},
					{coords = vector3(828.63, -2921.65, 5.9), heading = 271.49, radius = 6.0},
					{coords = vector3(828.63, -2916.37, 5.9), heading = 271.49, radius = 6.0},
					{coords = vector3(828.63, -2910.95, 5.9), heading = 271.49, radius = 6.0},
					{coords = vector3(828.63, -2905.67, 5.9), heading = 271.49, radius = 6.0}
				}
			}		
			
		},

		Helicopters = {
			{
				Spawner = vector3(793.52, -2919.13, 10.27),
				InsideShop = vector3(805.73, -2915.81, 12.09),
				Marker = {type = 34, x = 1.5, y = 1.5, z = 1.5, r = 255, g = 0, b = 0, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(805.73, -2915.81, 12.09), heading = 266.67, radius = 6.0}
				}
			}
		},

		FastTravels = {
		},

		FastTravelsPrompt = {
		}

	},
	
	PaletoMedicCenter = {

		Blip = {
			coords = vector3(-249.415, 6326.200, 32.431),
			sprite = 61,
			scale  = 1.2,
			color  = 2
		},

		AmbulanceActions = {
			vector3(-269.1, 6321.2, 32.431), -- مكتب 1
			vector3(-265.03, 6324.79, 32.43), -- مكتب 2
			vector3(-249.18, 6326.75, 32.43) -- رئيسي قرب الأستقبال
		},

		Pharmacies = {
			vector3(-252.918, 6318.422, 32.431)
		},

		Vehicles = {
			{
				Spawner = vector3(-253.47, 6339.7, 32.43),
				InsideShop = vector3(-302.84, 6265.92, 37.95),
				Marker = {type = 36, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 0, b = 0, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(-244.42, 6340.16, 32.43), heading = 222.57, radius = 4.0},
					{coords = vector3(-257.74, 6343.34, 32.34), heading = 311.68, radius = 4.0},
					{coords = vector3(-265.03, 6336.02, 32.34), heading = 311.68, radius = 4.0}
				}
			}			
			
		},

		Helicopters = {
		},

		FastTravels = {
		},

		FastTravelsPrompt = {
		}

	}	
	
}

--START config vehicle and hilecopter
Config.VehiclePrice = {
    ambulance       = 70000,   --اسعاف كبير
	lvmpd11      = 200000,   -- تشارجر اسعاف
	ems5      = 400000,   --تاهو
	fd17silv      = 200000   -- سلفرادو
}

Config.HelicopterPrice = {
    supervolito       = 450000,   --اسعاف جوي
    polmav       = 450000,   --اسعاف جوي
    polmav3      = 650000   --اسعاف جوي 2
}

Config.VehicleModel = {
    ems       = { --اسعاف كبير
	    model = 'ambulance',
		label = 'إسعاف كبير',
		price = Config.VehiclePrice.ambulance
	},
	lvmpd11       = { -- تشارجر اسعاف
	    model = 'lvmpd11',
		label = 'دودج تشارجر - الطوارئ الطبية',
		price = Config.VehiclePrice.lvmpd11
	},  	
	ems5       = { --ااسعاف تاهو
	    model = 'ems5',
		label = 'تاهو - الطوارئ الطبية',
		price = Config.VehiclePrice.ems5
	},  	
    fd17silv       = { -- سلفرادو
	    model = 'fd17silv',
		label = 'سلفرادو - الطوارئ الطبية',
		price = Config.VehiclePrice.fd17silv
	},  		

} 

Config.HelicopterModel = {
	supervolito  = { --اسعاف جوي1
		model = 'supervolito',
		label = 'اسعاف جوي',
		livery = 1,
		price = Config.HelicopterPrice.supervolito
				},
} 
--END config vehicle and hilecopter

Config.AuthorizedVehicles = {
	car = {
		ambulance = { -- متدرب
			Config.VehicleModel.ems -- إسعاف كبير
		},

		doctor = { --m1
			Config.VehicleModel.ems -- إسعاف كبير
		},

		chief_doctor = { --m2
			Config.VehicleModel.ems, -- إسعاف كبير
			Config.VehicleModel.lvmpd11 -- تشارجر
		},

		chief = { --m3
			Config.VehicleModel.ems, -- إسعاف كبير
			Config.VehicleModel.lvmpd11, -- تشارجر
			Config.VehicleModel.fd17silv -- سلفرادو
		},

		bigchef = { --m4
			Config.VehicleModel.ems, -- إسعاف كبير
			Config.VehicleModel.lvmpd11, -- تشارجر
			Config.VehicleModel.ems5, -- تاهو
			Config.VehicleModel.fd17silv -- سلفرادو
		},
		
		bigchef2 = { --m5
			Config.VehicleModel.ems, -- إسعاف كبير
			Config.VehicleModel.lvmpd11, -- تشارجر
			Config.VehicleModel.ems5, -- تاهو
			Config.VehicleModel.fd17silv -- سلفرادو
		},
		
		bigchef3 = { --m6
			Config.VehicleModel.ems, -- إسعاف كبير
			Config.VehicleModel.lvmpd11, -- تشارجر
			Config.VehicleModel.ems5, -- تاهو
			Config.VehicleModel.fd17silv -- سلفرادو
		},
		
		bigchef4 = { --m7
			Config.VehicleModel.ems, -- إسعاف كبير
			Config.VehicleModel.lvmpd11, -- تشارجر
			Config.VehicleModel.ems5, -- تاهو
			Config.VehicleModel.fd17silv -- سلفرادو
		},
		
		bigchef5 = {--m8
			Config.VehicleModel.ems, -- إسعاف كبير
			Config.VehicleModel.lvmpd11, -- تشارجر
			Config.VehicleModel.ems5, -- تاهو
			Config.VehicleModel.fd17silv -- سلفرادو
		},
		
		bigchef6 = { --m9
			Config.VehicleModel.ems, -- إسعاف كبير
			Config.VehicleModel.lvmpd11, -- تشارجر
			Config.VehicleModel.ems5, -- تاهو
			Config.VehicleModel.fd17silv -- سلفرادو
		},
		
		bigchef7 = { -- m10
			Config.VehicleModel.ems, -- إسعاف كبير
			Config.VehicleModel.lvmpd11, -- تشارجر
			Config.VehicleModel.ems5, -- تاهو
			Config.VehicleModel.fd17silv -- سلفرادو
		},

 

		bosstwo = { -- نائب القائد
			Config.VehicleModel.ems, -- إسعاف كبير
			Config.VehicleModel.lvmpd11, -- تشارجر
			Config.VehicleModel.ems5, -- تاهو
			Config.VehicleModel.fd17silv -- سلفرادو
		},

		boss = { -- القائد
			Config.VehicleModel.ems, -- إسعاف كبير
			Config.VehicleModel.lvmpd11, -- تشارجر
			Config.VehicleModel.ems5, -- تاهو
			Config.VehicleModel.fd17silv -- سلفرادو
		}
	},

	helicopter = {
		ambulance = {},

		doctor = {
		    --Config.HelicopterModel.polmav,
		    --Config.HelicopterModel.polmav
		},

		chief_doctor = {
			--{model = 'polmav', label = 'هيليكوبتر - الطوارئ الطبية', props = {modLivery = 1}, price = 250000}
		},

		chief = {
			--{model = 'polmav', label = 'هيليكوبتر - الطوارئ الطبية', props = {modLivery = 1}, price = 250000}
		},

		bigchef = {
			--{model = 'polmav', label = 'هيليكوبتر - الطوارئ الطبية', props = {modLivery = 1}, price = 250000}
		},
		
		bigchef2 = {
			--{model = 'polmav', label = 'هيليكوبتر - الطوارئ الطبية', props = {modLivery = 1}, price = 250000}
			Config.HelicopterModel.supervolito
		},
		
		bigchef3 = {
			--{model = 'polmav', label = 'هيليكوبتر - الطوارئ الطبية', props = {modLivery = 1}, price = 250000}
			Config.HelicopterModel.supervolito
		},
		
		bigchef4 = {
			--{model = 'polmav', label = 'هيليكوبتر - الطوارئ الطبية', props = {modLivery = 1}, price = 250000}
			Config.HelicopterModel.supervolito
		},
		
		bigchef5 = {
			--{model = 'polmav', label = 'هيليكوبتر - الطوارئ الطبية', props = {modLivery = 1}, price = 250000}
			Config.HelicopterModel.supervolito
		},
		
		bigchef6 = {
			--{model = 'polmav', label = 'هيليكوبتر - الطوارئ الطبية', props = {modLivery = 1}, price = 250000}
			Config.HelicopterModel.supervolito
		},
		
		bigchef7 = {
			--{model = 'polmav', label = 'هيليكوبتر - الطوارئ الطبية', props = {modLivery = 1}, price = 250000}
			Config.HelicopterModel.supervolito
		},

		bosstwo = {
			--{model = 'polmav', label = 'هيليكوبتر - الطوارئ الطبية', props = {modLivery = 1}, price = 250000}
			Config.HelicopterModel.supervolito
		},

		boss = {
			--{model = 'polmav', label = 'هيليكوبتر - الطوارئ الطبية', props = {modLivery = 1}, price = 250000}
			Config.HelicopterModel.supervolito
		}
	}
}

--[[Config.Money = {
	[1] 
}--]]

--[[]]
Config.Uniform = {
	[0] = {
		m = { ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 3,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 1,
		['arms'] = 85,
		['pants_1'] = 4,   ['pants_2'] = 4,
		['shoes_1'] = 24,   ['shoes_2'] = 0,
		['helmet_1'] = 10,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['glasses_1'] = 0, 	['glasses_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['bproof_1'] = 0,  	['bproof_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0 },
		f = { ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
		['torso_1'] = 3,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 1,
		['arms'] = 93,
		['pants_1'] = 99,   ['pants_2'] = 4,
		['shoes_1'] = 29,   ['shoes_2'] = 0,
		['helmet_1'] = 121,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['glasses_1'] = 0, 	['glasses_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['bproof_1'] = 0,  	['bproof_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0 },
	},

	[1] = {
		m = { ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 3,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 1,
		['arms'] = 85,
		['pants_1'] = 4,   ['pants_2'] = 4,
		['shoes_1'] = 24,   ['shoes_2'] = 0,
		['helmet_1'] = 10,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['glasses_1'] = 0, 	['glasses_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['bproof_1'] = 0,  	['bproof_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0 },
		f = { ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
		['torso_1'] = 25,   ['torso_2'] = 1,
		['decals_1'] = 0,   ['decals_2'] = 1,
		['arms'] = 93,
		['pants_1'] = 99,   ['pants_2'] = 4,
		['shoes_1'] = 29,   ['shoes_2'] = 0,
		['helmet_1'] = 121,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['glasses_1'] = 0, 	['glasses_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['bproof_1'] = 0,  	['bproof_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0 },
	},

	[2] = {
		m = { ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 3,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 1,
		['arms'] = 85,
		['pants_1'] = 4,   ['pants_2'] = 4,
		['shoes_1'] = 24,   ['shoes_2'] = 0,
		['helmet_1'] = 10,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['glasses_1'] = 0, 	['glasses_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['bproof_1'] = 0,  	['bproof_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0 },
		f = { ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
		['torso_1'] = 25,   ['torso_2'] = 2,
		['decals_1'] = 0,   ['decals_2'] = 1,
		['arms'] = 93,
		['pants_1'] = 52,   ['pants_2'] = 2,
		['shoes_1'] = 29,   ['shoes_2'] = 0,
		['helmet_1'] = 10,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['glasses_1'] = 0, 	['glasses_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['bproof_1'] = 0,  	['bproof_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0 },
	},

	[3] = {
		m = { ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 3,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 1,
		['arms'] = 85,
		['pants_1'] = 4,   ['pants_2'] = 4,
		['shoes_1'] = 24,   ['shoes_2'] = 0,
		['helmet_1'] = 10,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['glasses_1'] = 0, 	['glasses_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['bproof_1'] = 0,  	['bproof_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0 },
		f = { ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
		['torso_1'] = 26,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 1,
		['arms'] = 93,
		['pants_1'] = 4,   ['pants_2'] = 4,
		['shoes_1'] = 29,   ['shoes_2'] = 0,
		['helmet_1'] = 10,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['glasses_1'] = 0, 	['glasses_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['bproof_1'] = 0,  	['bproof_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0 },
	},

	[4] = {
		m = { ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 3,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 1,
		['arms'] = 85,
		['pants_1'] = 4,   ['pants_2'] = 4,
		['shoes_1'] = 24,   ['shoes_2'] = 0,
		['helmet_1'] = 10,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['glasses_1'] = 0, 	['glasses_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['bproof_1'] = 0,  	['bproof_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0 },
		f = { ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
		['torso_1'] = 26,   ['torso_2'] = 1,
		['decals_1'] = 0,   ['decals_2'] = 1,
		['arms'] = 93,
		['pants_1'] = 52,   ['pants_2'] = 2,
		['shoes_1'] = 29,   ['shoes_2'] = 0,
		['helmet_1'] = 10,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['glasses_1'] = 0, 	['glasses_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['bproof_1'] = 0,  	['bproof_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0 },
	},

	[5] = {
		m = { ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 3,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 1,
		['arms'] = 85,
		['pants_1'] = 4,   ['pants_2'] = 4,
		['shoes_1'] = 24,   ['shoes_2'] = 0,
		['helmet_1'] = 10,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['glasses_1'] = 0, 	['glasses_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['bproof_1'] = 0,  	['bproof_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0 },
		f = { ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
		['torso_1'] = 25,   ['torso_2'] = 3,
		['decals_1'] = 0,   ['decals_2'] = 1,
		['arms'] = 93,
		['pants_1'] = 50,   ['pants_2'] = 4,
		['shoes_1'] = 29,   ['shoes_2'] = 0,
		['helmet_1'] = 10,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['glasses_1'] = 0, 	['glasses_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['bproof_1'] = 0,  	['bproof_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0 },
	},

	[6] = {
		m = { ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 3,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 1,
		['arms'] = 85,
		['pants_1'] = 4,   ['pants_2'] = 4,
		['shoes_1'] = 24,   ['shoes_2'] = 0,
		['helmet_1'] = 10,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['glasses_1'] = 0, 	['glasses_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['bproof_1'] = 0,  	['bproof_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0 },
		f = { ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
		['torso_1'] = 25,   ['torso_2'] = 3,
		['decals_1'] = 0,   ['decals_2'] = 1,
		['arms'] = 93,
		['pants_1'] = 50,   ['pants_2'] = 4,
		['shoes_1'] = 29,   ['shoes_2'] = 0,
		['helmet_1'] = 10,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['glasses_1'] = 0, 	['glasses_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['bproof_1'] = 0,  	['bproof_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0 },
	},


	[7] = {
		m = { ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 3,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 1,
		['arms'] = 85,
		['pants_1'] = 4,   ['pants_2'] = 4,
		['shoes_1'] = 24,   ['shoes_2'] = 0,
		['helmet_1'] = 10,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['glasses_1'] = 0, 	['glasses_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['bproof_1'] = 0,  	['bproof_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0 },
		f = { ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
		['torso_1'] = 25,   ['torso_2'] = 4,
		['decals_1'] = 0,   ['decals_2'] = 1,
		['arms'] = 93,
		['pants_1'] = 52,   ['pants_2'] = 2,
		['shoes_1'] = 29,   ['shoes_2'] = 0,
		['helmet_1'] = 10,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['glasses_1'] = 0, 	['glasses_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['bproof_1'] = 0,  	['bproof_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0 },
	},

	[8] = {
		m = { ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 3,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 1,
		['arms'] = 85,
		['pants_1'] = 48,   ['pants_2'] = 2,
		['shoes_1'] = 24,   ['shoes_2'] = 0,
		['helmet_1'] = 10,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['glasses_1'] = 0, 	['glasses_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['bproof_1'] = 0,  	['bproof_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0 },
		f = { ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
		['torso_1'] = 25,   ['torso_2'] = 5,
		['decals_1'] = 0,   ['decals_2'] = 1,
		['arms'] = 93,
		['pants_1'] = 4,   ['pants_2'] = 4,
		['shoes_1'] = 29,   ['shoes_2'] = 0,
		['helmet_1'] = 10,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['glasses_1'] = 0, 	['glasses_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['bproof_1'] = 0,  	['bproof_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0 },
	},

	[9] = {
		m = { ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 3,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 1,
		['arms'] = 85,
		['pants_1'] = 4,   ['pants_2'] = 4,
		['shoes_1'] = 24,   ['shoes_2'] = 0,
		['helmet_1'] = 10,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['glasses_1'] = 0, 	['glasses_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['bproof_1'] = 0,  	['bproof_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0 },
		f = { ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
		['torso_1'] = 25,   ['torso_2'] = 7,
		['decals_1'] = 0,   ['decals_2'] = 1,
		['arms'] = 93,
		['pants_1'] = 52,   ['pants_2'] = 2,
		['shoes_1'] = 29,   ['shoes_2'] = 0,
		['helmet_1'] = 10,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['glasses_1'] = 0, 	['glasses_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['bproof_1'] = 0,  	['bproof_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0 },
	},

	[10] = {
		m = { ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 3,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 1,
		['arms'] = 85,
		['pants_1'] = 4,   ['pants_2'] = 4,
		['shoes_1'] = 24,   ['shoes_2'] = 0,
		['helmet_1'] = 10,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['glasses_1'] = 0, 	['glasses_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['bproof_1'] = 0,  	['bproof_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0 },
		f = { ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
		['torso_1'] = 25,   ['torso_2'] = 8,
		['decals_1'] = 0,   ['decals_2'] = 1,
		['arms'] = 93,
		['pants_1'] = 52,   ['pants_2'] = 2,
		['shoes_1'] = 29,   ['shoes_2'] = 0,
		['helmet_1'] = 10,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['glasses_1'] = 0, 	['glasses_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['bproof_1'] = 0,  	['bproof_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0 },
	},

	[11] = {
		m = { ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 183,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 1,
		['arms'] = 75,
		['pants_1'] = 4,   ['pants_2'] = 4,
		['shoes_1'] = 24,   ['shoes_2'] = 0,
		['helmet_1'] = 10,  ['helmet_2'] = 33,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['glasses_1'] = 0, 	['glasses_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['mask_1'] = 0,    ['mask_2'] = 0,
		['bproof_1'] = 0,  	['bproof_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0 },
		f = { ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
		['torso_1'] = 25,   ['torso_2'] = 8,
		['decals_1'] = 0,   ['decals_2'] = 1,
		['arms'] = 93,
		['pants_1'] = 52,   ['pants_2'] = 2,
		['shoes_1'] = 29,   ['shoes_2'] = 0,
		['helmet_1'] = 10,  ['helmet_2'] = 3,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['glasses_1'] = 0, 	['glasses_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['mask_1'] = 0,    ['mask_2'] = 0,
		['bproof_1'] = 0,  	['bproof_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0 },
	},

	[12] = {
		m = { ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 183,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 1,
		['arms'] = 75,
		['pants_1'] = 4,   ['pants_2'] = 4,
		['shoes_1'] = 24,   ['shoes_2'] = 0,
		['helmet_1'] = 10,  ['helmet_2'] = 33,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['glasses_1'] = 0, 	['glasses_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['mask_1'] = 0,    ['mask_2'] = 0,
		['bproof_1'] = 0,  	['bproof_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0 },
		f = { ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
		['torso_1'] = 25,   ['torso_2'] = 8,
		['decals_1'] = 0,   ['decals_2'] = 1,
		['arms'] = 93,
		['pants_1'] = 52,   ['pants_2'] = 2,
		['shoes_1'] = 29,   ['shoes_2'] = 0,
		['helmet_1'] = 10,  ['helmet_2'] = 3,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['glasses_1'] = 0, 	['glasses_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['mask_1'] = 0,    ['mask_2'] = 0,
		['bproof_1'] = 0,  	['bproof_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0 },
	},
}

-- esx_plasticsurgery

Config.DrawDistance2 = 100.0
Config.MarkerSize2   = {x = 2.0, y = 2.0, z = 1.0}
Config.MarkerColor2  = {r = 102, g = 102, b = 204}
Config.MarkerType2 = 1

Config.BlipPlasticSurgery = {
	Sprite = 403,
	Color = 0,
	Display = 2,
	Scale = 1.0
}

Config.Price = 7000 

Config.EnableUnemployedOnly = false -- If true it will only show Blips to Unemployed Players | false shows it to Everyone.
Config.EnableBlips = false -- If true then it will show blips | false does the Opposite.
Config.EnablePeds = true -- If true then it will add Peds on Markers | false does the Opposite.

Config.Locations = {
	{ x = 326.02575683594, y = -572.96960449219, z = 43.284080505371 - 1.0, heading = 155.55 }, -- الرئيسي
	{ x = 1826.9592285156, y = 3685.1245117188, z = 34.294845581055 - 1.0, heading = 321.29 }, -- ساندي
}

Config.Zones = {}

for i=1, #Config.Locations, 1 do
	Config.Zones['Shop_' .. i] = {
		Pos   = Config.Locations[i],
		Size  = Config.MarkerSize2,
		Color = Config.MarkerColor2,
		Type  = Config.MarkerType2
	}
end
