Config = {

}

Config.MarkerType   = 1 -- Marker visible or not. -1 = hiden  Set to 1 for a visible marker. To have a list of avaible marker go to https://docs.fivem.net/game-references/markers/
Config.DrawDistance = 100.0 --Distance where the marker be visible from
Config.ZoneSize     = {x = 5.0, y = 5.0, z = 1.0} -- Size of the marker
Config.MarkerColor  = {r = 0, g = 255, b = 0} --Color of the marker


Config.ShowBlips   = true  --markers visible on the map? (false to hide the markers on the map)

Config.RequiredCopsCoke  = 0 --Ammount of cop that need to be online to be able to harvest/process/sell coke
Config.RequiredCopsMeth  = 0 --Ammount of cop that need to be online to be able to harvest/process/sell meth
Config.RequiredCopsWeed  = 0 --Ammount of cop that need to be online to be able to harvest/process/sell weed
Config.RequiredCopsOpium = 0 --Ammount of cop that need to be online to be able to harvest/process/sell opium

Config.TimeToFarmWeed     = 1  * 1000 -- Ammount of time to harvest weed
Config.TimeToProcessWeed  = 2  * 1000 -- Ammount of time to process weed
Config.TimeToSellWeed     = 2  * 1000 -- Ammount of time to sell weed

Config.TimeToFarmOpium    = 2  * 1000 -- Ammount of time to harvest coke
Config.TimeToProcessOpium = 2  * 1000 -- Ammount of time to process coke
Config.TimeToSellOpium    = 2  * 1000 -- Ammount of time to sell coke

Config.TimeToFarmCoke     = 1  * 1000 -- Ammount of time to harvest coke
Config.TimeToProcessCoke  = 2  * 1000 -- Ammount of time to process coke
Config.TimeToSellCoke     = 2  * 1000 -- Ammount of time to sell coke

Config.TimeToFarmMeth     = 1  * 1000 -- Ammount of time to harvest meth
Config.TimeToProcessMeth  = 2 * 1000 -- Ammount of time to process meth
Config.TimeToSellMeth     = 2  * 1000 -- Ammount of time to sell meth


Config.threb = false -- ضعف الخبرة الاحترافي لاتعدل شي فيه
Config.Methxp = 10  -- الخبرة المطلوبة لجمع الشبو
Config.weedxp = 10  -- الخبرة المطلوبة لجمع الحشيش
Config.Opiumxp = 10 -- الخبرة المطلوبة لجمع الافيون
Config.Cokexp = 10 -- الخبرة المطلوبة لجمع الكوكاين
-- Config
Config.Locale = 'en'
Config.Methgivexp = 70  -- كم يعطي خبرة لبيع شدة الشبو
Config.weedgivexp = 60  -- كم يعطي خبرة لبيع شدة الحشيش
Config.Opiumgivexp = 30 -- كم يعطي خبرة لبيع شدة الافيون
Config.Cokegivexp = 40 -- كم يعطي خبرة لبيع شدة الكوكاين



Config.Prices = {
	weed_pooch 	= 1750,
	coke_pooch 	= 1800,
	opium_pooch = 2000,
	meth_pooch 	= 1500
}

Config.Xp = {
	weed_pooch 	= 60,
	coke_pooch 	= 40,
	opium_pooch = 30,
	meth_pooch 	= 70
}

Config.Zones = {
	[1]	 = {
		WeedField = {x = 2094.31,	y = 4918.51,	z = 40.04,	name = _U('weed_field'),		sprite = 496,	color = 52,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		--[[ 1 ]]WeedProcessing =	{x = -1366.43,	y = -317.46,	z = 38.56,	name = _U('weed_processing'),	sprite = 496,	color = 52,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		WeedDealer = {x = 1028.107,	y = -3037.205,	z = 8.686399,	name = _U('weed_dealer'),		sprite = 496,	color = 75,   MarkerType = 29,  ZoneSize = {x = 1.0, y = 1.0, z = 1.0},   MarkerColor = {r = 255, g = 0, b = 0},       Opacity = 100,   Rotate = true},
		
		CokeField = {x = -1742.93,	y = 2377.3,  	z = 46.01,	name = _U('coke_field'),		sprite = 501,	color = 40,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		--[[ 2 ]] CokeProcessing =	{x = 1953.26,	y = 5179.97,	z = 46.98,	name = _U('coke_processing'),	sprite = 501,	color = 40,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		CokeDealer = {x = 1128.537,	y = -2989.71,	z = 8.686371,		name = _U('coke_dealer'),		sprite = 501,	color = 75,   MarkerType = 29,  ZoneSize = {x = 1.0, y = 1.0, z = 1.0},   MarkerColor = {r = 255, g = 0, b = 0},       Opacity = 100,   Rotate = true},	
		
		MethField = {x = -92.52,	y = 1910.05,	z = 195.82,	name = _U('meth_field'),		sprite = 499,	color = 26,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		--[[ 3 ]] MethProcessing =	{x = 1390.66,	y = 3605.13,	z = 38.00,	name = _U('meth_processing'),	sprite = 499,	color = 26,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		MethDealer = {x = 851.6,		y = -3097.54,	z = 5.9,	name = _U('meth_dealer'),		sprite = 499,	color = 75,   MarkerType = 29,  ZoneSize = {x = 1.0, y = 1.0, z = 1.0},   MarkerColor = {r = 255, g = 0, b = 0},       Opacity = 100,   Rotate = true},
		
		OpiumField = {x = 383.88,	y = 6645.83,	z = 27.72,	name = _U('opium_field'),		sprite = 51,	color = 60,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		--[[ 4 ]] OpiumProcessing =	{x = -331.27,	y = -2445.47,	z = 6.17,	name = _U('opium_processing'),	sprite = 51,	color = 60,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		OpiumDealer = {x = 930.4673,	y = -3042.238,	z = 5.902035,	name = _U('opium_dealer'),		sprite = 51,	color = 75,   MarkerType = 29,  ZoneSize = {x = 1.0, y = 1.0, z = 1.0},   MarkerColor = {r = 255, g = 0, b = 0},       Opacity = 100,   Rotate = true}
	},
	
	[2]	 = {
		WeedField = {x = 2094.31,	y = 4918.51,	z = 40.04,	name = _U('weed_field'),		sprite = 496,	color = 52,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		--[[ 1 ]]WeedProcessing =	{x = -1366.43,	y = -317.46,	z = 38.56,	name = _U('weed_processing'),	sprite = 496,	color = 52,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		WeedDealer = {x = 59.6, y = -2491.91, z = 6.01,	name = _U('weed_dealer'),		sprite = 496,	color = 75,   MarkerType = 29,  ZoneSize = {x = 1.0, y = 1.0, z = 1.0},   MarkerColor = {r = 255, g = 0, b = 0},       Opacity = 100,   Rotate = true},
		
		CokeField = {x = -1742.93,	y = 2377.3,  	z = 46.01,	name = _U('coke_field'),		sprite = 501,	color = 40,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		--[[ 2 ]] CokeProcessing =	{x = 1953.26,	y = 5179.97,	z = 46.98,	name = _U('coke_processing'),	sprite = 478,	color = 40,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		CokeDealer = {x = -23.36, y = -2479.07, z = 6.01,		name = _U('coke_dealer'),		sprite = 478,	color = 75,   MarkerType = 29,  ZoneSize = {x = 1.0, y = 1.0, z = 1.0},   MarkerColor = {r = 255, g = 0, b = 0},       Opacity = 100,   Rotate = true},	
		
		MethField = {x = -92.52,	y = 1910.05,	z = 195.82,	name = _U('meth_field'),		sprite = 499,	color = 26,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		--[[ 3 ]] MethProcessing =	{x = 891.17,	y = -959.84,	z = 38.28,	name = _U('meth_processing'),	sprite = 499,	color = 26,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		MethDealer = {x = -93.82, y = -2488.47, z = 6.01,	name = _U('meth_dealer'),		sprite = 499,	color = 75,   MarkerType = 29,  ZoneSize = {x = 1.0, y = 1.0, z = 1.0},   MarkerColor = {r = 255, g = 0, b = 0},       Opacity = 100,   Rotate = true},
		
		OpiumField = {x = 383.88,	y = 6645.83,	z = 27.72,	name = _U('opium_field'),		sprite = 51,	color = 60,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		--[[ 4 ]] OpiumProcessing =	{x = 1390.32, y = 3606.92, z = 38.94,	name = _U('opium_processing'),	sprite = 51,	color = 60,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		OpiumDealer = {x = -163.55, y = -2374.02, z = 9.32,	name = _U('opium_dealer'),		sprite = 51,	color = 75,   MarkerType = 29,  ZoneSize = {x = 1.0, y = 1.0, z = 1.0},   MarkerColor = {r = 255, g = 0, b = 0},       Opacity = 100,   Rotate = true}
	},
	
	[3]	 = {
		WeedField = {x = 2094.31,	y = 4918.51,	z = 40.04,	name = _U('weed_field'),		sprite = 496,	color = 52,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		--[[ 1 ]]WeedProcessing =	{x = -1366.43,	y = -317.46,	z = 38.56,	name = _U('weed_processing'),	sprite = 496,	color = 52,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		WeedDealer = {x = -1238.31, y = -2239.78, z = 13.94,	name = _U('weed_dealer'),		sprite = 496,	color = 75,   MarkerType = 29,  ZoneSize = {x = 1.0, y = 1.0, z = 1.0},   MarkerColor = {r = 255, g = 0, b = 0},       Opacity = 100,   Rotate = true},
		
		CokeField = {x = -1742.93,	y = 2377.3,  	z = 46.01,	name = _U('coke_field'),		sprite = 501,	color = 40,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		--[[ 2 ]] CokeProcessing =	{x = 1953.26,	y = 5179.97,	z = 46.98,	name = _U('coke_processing'),	sprite = 478,	color = 40,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		CokeDealer = {x = -1156.27, y = -2571.55, z = 13.94,		name = _U('coke_dealer'),		sprite = 478,	color = 75,   MarkerType = 29,  ZoneSize = {x = 1.0, y = 1.0, z = 1.0},   MarkerColor = {r = 255, g = 0, b = 0},       Opacity = 100,   Rotate = true},	
		
		MethField = {x = -92.52,	y = 1910.05,	z = 195.82,	name = _U('meth_field'),		sprite = 499,	color = 26,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		--[[ 3 ]] MethProcessing =	{x = 891.17,	y = -959.84,	z = 38.28,	name = _U('meth_processing'),	sprite = 499,	color = 26,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		MethDealer = {x = -1184.34, y = -2658.43, z = 13.94,	name = _U('meth_dealer'),		sprite = 499,	color = 75,   MarkerType = 29,  ZoneSize = {x = 1.0, y = 1.0, z = 1.0},   MarkerColor = {r = 255, g = 0, b = 0},       Opacity = 100,   Rotate = true},
		
		OpiumField = {x = 383.88,	y = 6645.83,	z = 27.72,	name = _U('opium_field'),		sprite = 51,	color = 60,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		--[[ 4 ]] OpiumProcessing =	{x = -331.27,	y = -2445.47,	z = 6.17,	name = _U('opium_processing'),	sprite = 51,	color = 60,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		OpiumDealer = {x = -1337.52, y = -2619.07, z = 13.94,	name = _U('opium_dealer'),		sprite = 51,	color = 75,   MarkerType = 29,  ZoneSize = {x = 1.0, y = 1.0, z = 1.0},   MarkerColor = {r = 255, g = 0, b = 0},       Opacity = 100,   Rotate = true}
	},
	
	[4]	 = {
		WeedField = {x = 2094.31,	y = 4918.51,	z = 40.04,	name = _U('weed_field'),		sprite = 496,	color = 52,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		--[[ 1 ]]WeedProcessing =	{x = -1366.43,	y = -317.46,	z = 38.56,	name = _U('weed_processing'),	sprite = 496,	color = 52,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		WeedDealer = {x = 1028.107,	y = -3037.205,	z = 8.686399,	name = _U('weed_dealer'),		sprite = 496,	color = 75,   MarkerType = 29,  ZoneSize = {x = 1.0, y = 1.0, z = 1.0},   MarkerColor = {r = 255, g = 0, b = 0},       Opacity = 100,   Rotate = true},
		
		CokeField = {x = -1742.93,	y = 2377.3,  	z = 46.01,	name = _U('coke_field'),		sprite = 501,	color = 40,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		--[[ 2 ]] CokeProcessing =	{x = 1953.26,	y = 5179.97,	z = 46.98,	name = _U('coke_processing'),	sprite = 478,	color = 40,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		CokeDealer = {x = 1128.537,	y = -2989.71,	z = 8.686371,		name = _U('coke_dealer'),		sprite = 478,	color = 75,   MarkerType = 29,  ZoneSize = {x = 1.0, y = 1.0, z = 1.0},   MarkerColor = {r = 255, g = 0, b = 0},       Opacity = 100,   Rotate = true},	
		
		MethField = {x = -92.52,	y = 1910.05,	z = 195.82,	name = _U('meth_field'),		sprite = 499,	color = 26,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		--[[ 3 ]] MethProcessing =	{x = 891.17,	y = -959.84,	z = 38.28,	name = _U('meth_processing'),	sprite = 499,	color = 26,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		MethDealer = {x = 851.6,		y = -3097.54,	z = 5.9,	name = _U('meth_dealer'),		sprite = 499,	color = 75,   MarkerType = 29,  ZoneSize = {x = 1.0, y = 1.0, z = 1.0},   MarkerColor = {r = 255, g = 0, b = 0},       Opacity = 100,   Rotate = true},
		
		OpiumField = {x = 383.88,	y = 6645.83,	z = 27.72,	name = _U('opium_field'),		sprite = 51,	color = 60,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		--[[ 4 ]] OpiumProcessing =	{x = -331.27,	y = -2445.47,	z = 6.17,	name = _U('opium_processing'),	sprite = 51,	color = 60,   MarkerType = 1,   ZoneSize = {x = 5.0, y = 5.0, z = 1.0},   MarkerColor = {r = 100, g = 204, b = 100},   Opacity = 100,   Rotate = false},
		OpiumDealer = {x = 930.4673,	y = -3042.238,	z = 5.902035,	name = _U('opium_dealer'),		sprite = 51,	color = 75,   MarkerType = 29,  ZoneSize = {x = 1.0, y = 1.0, z = 1.0},   MarkerColor = {r = 255, g = 0, b = 0},       Opacity = 100,   Rotate = true}
	},
	
}

Config.DisableBlip = false -- Set to true to disable blips. False to enable them.
Config.Map = {

  {name="Coke Farm Entrance",    color=4, scale=0.8, id=501, x=47.842,     y=3701.961,   z=40.722},
  {name="Coke Farm",             color=4, scale=0.8, id=501, x=1093.139,   y=-3195.673,  z=-39.131},
  {name="Coke Processing",       color=4, scale=0.8, id=501, x=1101.837,   y=-3193.732,  z=-38.993},
  {name="Coke Sales",            color=3, scale=0.8, id=501, x=959.117,    y=-121.055,   z=74.963},
  {name="Meth Farm Entrance",    color=6, scale=0.8, id=499, x=1386.659,   y=3622.805,   z=35.012},
  {name="Meth Farm",             color=6, scale=0.8, id=499, x=1005.721,   y=-3200.301,  z=-38.519},
  {name="Meth Processing",       color=6, scale=0.8, id=499, x=1014.878,   y=-3194.871,  z=-38.993},
  {name="Meth Sales",            color=3, scale=0.8, id=499, x=7.981,      y=6469.067,   z=31.528},
  {name="Opium Farm Entrance",   color=6, scale=0.8, id=403, x=2433.804,   y=4969.196,   z=42.348},
  {name="Opium Farm",            color=6, scale=0.8, id=403, x=2433.804,   y=4969.196,   z=42.348},
  {name="Opium Processing",      color=6, scale=0.8, id=403, x=2434.43,    y=4964.18,    z=42.348},
  {name="Opium Sales",           color=3, scale=0.8, id=403, x=-3155.608,  y=1125.368,   z=20.858},
 -- {name="Weed Farm Entrance",    color=2, scale=0.8, id=140, x=2221.858,   y=5614.81,    z=54.902},
  {name="ﺶﻴﺸﺤﻟﺍ ﺔﻋﺭﺰﻣ",             color=2, scale=0.8, id=140, x = 2094.31,	y = 4918.51,	z = 40.04},
  {name="ﺶﻴﺸﺤﻟﺍ ﻊﻴﻨﺼﺗ",       color=2, scale=0.8, id=140, x = -1366.43,	y = -317.46,	z = 38.56},
  {name="ﺶﻴﺸﺤﻟﺍ ﺮﺟﺎﺗ",            color=3, scale=0.8, id=140, x = 1028.107,	y = -3037.205,	z = 8.686399}

}