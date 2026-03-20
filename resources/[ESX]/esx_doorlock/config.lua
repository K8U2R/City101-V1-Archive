Config = {}
Config.Locale = 'en'
LeoJobs = {'police','agent','admin', 'ambulance'}

Config.DoorList = {

	--
	-- Mission Row First Floor
	--

	-- Entrance Doors


	{
		objName = 'hei_prop_ss1_mpint_door_l',
		objCoords  = {x= 659.92, y= 6461.17, z= 33.49},
		textCoords = {x= 659.92, y= 6461.17, z= 33.49},
		authorizedJobs = {'all'},
		locked = false,
		distance = 2.5,
		doorKey = 'E'
	},
	

	{
		objName = 'prop_facgate_07',
		objCoords  = {x= -1635.13, y= -878.62, z= 9.13},
		textCoords = {x= -1635.13, y= -878.62, z= 9.13},
		authorizedJobs = {'all'},
		locked = false,
		distance = 2.5,
		doorKey = 'E'
	},
	
	
	
	{
		objName = 'prop_facgate_07',
		objCoords  = {x= -1568.58, y= -854.59, z= 10.18},
		textCoords = {x= -1568.58, y= -854.59, z= 10.18},
		authorizedJobs = {'all'},
		locked = false,
		distance = 2.5,
		doorKey = 'E'
	},



	{
		objName = 'v_ilev_bk_vaultdoor',
		objCoords  = vector3(255.2283, 223.976, 102.3932),
		textCoords = vector3(255.2283, 223.976, 102.3932),
		authorizedJobs = { 'all' },
		locked = true,
		distance = 2.5,
		doorKey = 'H'
	},

	

	-- To locker room & roof
	{
		objName = 'v_ilev_ph_gendoor004',
		objCoords  = {x = 449.698, y = -986.469, z = 30.689},
		textCoords = {x = 450.104, y = -986.388, z = 31.739},
		authorizedJobs = {'all'},
		locked = true,
		doorKey = 'E'
	},

	-- Rooftop
	{
		objName = 'v_ilev_gtdoor02',
		objCoords = {x = 464.361, y = -984.678, z = 43.834},
		textCoords = {x = 464.361, y = -984.050, z = 44.834},
		authorizedJobs = {'all'},
		locked = true,
		doorKey = 'E'
	},


	{
		objName = 'prop_ld_jail_door',
		objCoords  = {x = 752.2177, y = -2793.581, z = 7.178009},
		textCoords = {x = 752.2177, y = -2793.581, z = 7.178009},
		authorizedJobs = {'all'},
		locked = true,
		doorKey = 'E'
	},



	-- Hallway to roof
	{
		objName = 'v_ilev_arm_secdoor',
		objCoords  = {x = 461.286, y = -985.320, z = 30.839},
		textCoords = {x = 461.50, y = -986.00, z = 31.50},
		authorizedJobs = {'all'},
		locked = true,
		doorKey = 'E'
	},

	-- Armory
	{
		objName = 'v_ilev_arm_secdoor',
		objCoords  = {x = 452.618, y = -982.702, z = 30.689},
		textCoords = {x = 453.079, y = -982.600, z = 31.739},
		authorizedJobs = {'all'},
		locked = true,
		doorKey = 'E'
	},

	-- Captain Office
	{
		objName = 'v_ilev_ph_gendoor002',
		objCoords  = {x = 451.9421, y = -1001.66, z = 25.818},
		textCoords = {x = 431.3575, y = -1001.29, z = 25.770},
		authorizedJobs = {'all'},
		locked = true,
		doorKey = 'E'
	},

	-- To downstairs (double doors)
	

	
	
	
	{
		objName = 'v_ilev_ph_gendoor006',
		objCoords  = {x = 469.46, y = -987.2479, z = 25.0866},
		textCoords = {x = 470.59, y = -987.4352, z = 25.1775},
		authorizedJobs = {'all'},
		locked = true,
		distance = 4,
		doorKey = 'E'
	},
	

	-- 
	-- Mission Row Cells
	--

	--main jail interior--
	{
		objName = 'prop_ld_jail_door',
		objCoords  = {x= 1795.28, y=2479.2, z=-118.92},
		textCoords = {x= 1795.28, y=2479.2, z=-118.92},
		authorizedJobs = {'all'},
		locked = false,
		distance = 1.5,
		size = 1.0,
		doorKey = 'E'
	},
	{
		objName = 'prop_ld_jail_door',
		objCoords  = {x=1792.13, y=2479.21, z=-118.92 },
		textCoords = {x=1792.13, y=2479.21, z=-118.92},
		authorizedJobs = {'all'},
		locked = false,
		distance = 1.5,
		size = 1.0,
		doorKey = 'E'
	},
	{
		objName = 'prop_ld_jail_door',
		objCoords  = {x=1788.95, y=2479.18, z=-118.92 },
		textCoords = {x=1788.95, y=2479.18, z=-118.92},
		authorizedJobs = {'all'},
		locked = false,
		distance = 1.5,
		size = 1.0,
		doorKey = 'E'
	},
	{
		objName = 'prop_ld_jail_door',
		objCoords  = {x=1785.79, y=2479.21, z=-118.92 },
		textCoords = {x=1785.79, y=2479.21, z=-118.92},
		authorizedJobs = {'all'},
		locked = false,
		distance = 1.5,
		size = 1.0,
		doorKey = 'E'
	},
	{
		objName = 'prop_ld_jail_door',
		objCoords  = {x=1798.45, y=2487.12, z=-118.92 },
		textCoords = {x=1798.45, y=2487.12, z=-118.92},
		authorizedJobs = {'all'},
		locked = false,
		distance = 1.5,
		size = 1.0,
		doorKey = 'E'
	},
	{
		objName = 'prop_ld_jail_door',
		objCoords  = {x=1795.3, y=2487.12, z=-118.92 },
		textCoords = {x=1795.3, y=2487.12, z=-118.92},
		authorizedJobs = {'all'},
		locked = false,
		distance = 1.5,
		size = 1.0,
		doorKey = 'E'
	},
	{
		objName = 'prop_ld_jail_door',
		objCoords  = {x=1792.13, y=2487.12, z=-118.92 },
		textCoords = {x=1792.13, y=2487.12, z=-118.92},
		authorizedJobs = {'all'},
		locked = false,
		distance = 1.5,
		size = 1.0,
		doorKey = 'E'
	},
	{
		objName = 'prop_ld_jail_door',
		objCoords  = {x=1788.96, y=2487.12, z=-118.92 },
		textCoords = {x=1788.96, y=2487.12, z=-118.92},
		authorizedJobs = {'all'},
		locked = false,
		distance = 1.5,
		size = 1.0,
		doorKey = 'E'
	},
	{
		objName = 'prop_ld_jail_door',
		objCoords  = {x=1798.44, y=2479.21, z=-118.92 },
		textCoords = {x=1798.44, y=2479.21, z=-118.92},
		authorizedJobs = {'all'},
		locked = false,
		distance = 1.5,
		size = 1.0,
		doorKey = 'E'
	},
	{
		objName = 'prop_ld_jail_door',
		objCoords  = {x=1798.45, y=2487.14, z=-122.54},
		textCoords = {x=1798.45, y=2487.14, z=-122.54},
		authorizedJobs = {'all'},
		locked = false,
		distance = 1.5,
		size = 1.0,
		doorKey = 'E'
	},
	{
		objName = 'prop_ld_jail_door',
		objCoords  = {x=1795.29, y=2487.12, z=-122.54},
		textCoords = {x=1795.29, y=2487.12, z=-122.54},
		authorizedJobs = {'all'},
		locked = false,
		distance = 1.5,
		size = 1.0,
		doorKey = 'E'
	},
	{
		objName = 'prop_ld_jail_door',
		objCoords  = {x=1792.13, y=2487.1, z=-122.54},
		textCoords = {x=1792.13, y=2487.1, z=-122.54},
		authorizedJobs = {'all'},
		locked = false,
		distance = 1.5,
		size = 1.0,
		doorKey = 'E'
	},
	{
		objName = 'prop_ld_jail_door',
		objCoords  = {x=1788.96, y=2487.11, z=-122.54},
		textCoords = {x=1788.96, y=2487.11, z=-122.54},
		authorizedJobs = {'all'},
		locked = false,
		distance = 1.5,
		size = 1.0,
		doorKey = 'E'
	},
	{
		objName = 'prop_ld_jail_door',
		objCoords  = {x=1785.79, y=2479.21, z=-122.54},
		textCoords = {x=1785.79, y=2479.21, z=-122.54},
		authorizedJobs = {'all'},
		locked = false,
		distance = 1.5,
		size = 1.0,
		doorKey = 'E'
	},
	{
		objName = 'prop_ld_jail_door',
		objCoords  = {x=1788.95, y=2479.18, z=-122.54},
		textCoords = {x=1788.95, y=2479.18, z=-122.54},
		authorizedJobs = {'all'},
		locked = false,
		distance = 1.5,
		size = 1.0,
		doorKey = 'E'
	},
	{
		objName = 'prop_ld_jail_door',
		objCoords  = {x=1792.13, y=2479.21, z=-122.54},
		textCoords = {x=1792.13, y=2479.21, z=-122.54},
		authorizedJobs = {'all'},
		locked = false,
		distance = 1.5,
		size = 1.0,
		doorKey = 'E'
	},
	{
		objName = 'prop_ld_jail_door',
		objCoords  = {x=1795.29, y=2479.18, z=-122.54},
		textCoords = {x=1795.29, y=2479.18, z=-122.54},
		authorizedJobs = {'all'},
		locked = false,
		distance = 1.5,
		size = 1.0,
		doorKey = 'E'
	},
	{
		objName = 'prop_ld_jail_door',
		objCoords  = {x=1798.45, y=2479.15, z=-122.54},
		textCoords = {x=1798.45, y=2479.15, z=-122.54},
		authorizedJobs = {'all'},
		locked = false,
		distance = 1.5,
		size = 1.0,
		doorKey = 'E'
	},
	{
		objName = 'prop_ld_jail_door',
		objCoords  = {x=1691.0, y=2579.78, z=-69.29},
		textCoords = {x=1691.0, y=2579.78, z=-69.29},
		authorizedJobs = {'all'},
		locked = true,
		distance = 1.5,
		size = 1.0,
		doorKey = 'E'
	},
	{
		objName = 'v_ilev_cd_entrydoor',
		objCoords  = {x=1693.57, y=2581.39, z=-69.29},
		textCoords = {x=1693.57, y=2581.39, z=-69.29},
		authorizedJobs = {'all'},
		locked = true,
		distance = 1.5,
		size = 1.0,
		doorKey = 'E'
	},
	{
		objName = 'v_ilev_cd_entrydoor',
		objCoords  = {x=1702.59, y=2577.39, z=-69.29},
		textCoords = {x=1702.59, y=2577.39, z=-69.29},
		authorizedJobs = {'all'},
		locked = true,
		distance = 1.5,
		size = 1.0,
		doorKey = 'E'
	},
	{
		objName = 'v_ilev_cd_entrydoor',
		objCoords  = {x=1708.88, y=2570.69, z=-69.29},
		textCoords = {x=1708.88, y=2570.69, z=-69.29},
		authorizedJobs = {'all'},
		locked = true,
		distance = 1.5,
		size = 1.0,
		doorKey = 'E'
	},
	{
		objName = 'v_ilev_cd_entrydoor',
		objCoords  = {x=1693.18, y=2577.34, z=-69.29},
		textCoords = {x=1693.18, y=2577.34, z=-69.29},
		authorizedJobs = {'all'},
		locked = true,
		distance = 1.5,
		size = 1.0,
		doorKey = 'E'
	},
	{
		objName = 'prop_ld_jail_door',
		objCoords  = {x=1700.85, y=2576.34, z=-69.29},
		textCoords = {x=1700.85, y=2576.34, z=-69.29},
		authorizedJobs = {'all'},
		locked = true,
		distance = 1.5,
		size = 1.0,
		doorKey = 'E'
	},
	

	-- Main Cells
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 463.815, y = -992.686, z = 24.9149},
		textCoords = {x = 463.30, y = -992.686, z = 25.10},
		authorizedJobs = {'all'},
		locked = true,
		doorKey = 'E'
	},

	-- Cell 1
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 462.381, y = -993.651, z = 24.914},
		textCoords = {x = 461.806, y = -993.308, z = 25.064},
		authorizedJobs = {'all'},
		locked = true,
		doorKey = 'K'
	},

	-- Cell 2
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 462.331, y = -998.152, z = 24.914},
		textCoords = {x = 461.806, y = -998.800, z = 25.064},
		authorizedJobs = {'all'},
		locked = true,
		doorKey = 'E'
	},

	-- Cell 3
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 462.704, y = -1001.92, z = 24.9149},
		textCoords = {x = 461.806, y = -1002.450, z = 25.064},
		authorizedJobs = {'all'},
		locked = true,
		doorKey = 'K'
	},

	-- To Back
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 463.478, y = -1003.538, z = 25.005},
		textCoords = {x = 464.00, y = -1003.50, z = 25.50},
		authorizedJobs = {'all'},
		locked = true,
		doorKey = 'E'
	},

	--
	-- Mission Row Back
	--

	-- Back (double doors)
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = 467.371, y = -1014.452, z = 26.536},
		textCoords = {x = 468.09, y = -1014.452, z = 27.1362},
		authorizedJobs = {'all'},
		locked = true,
		distance = 4,
		doorKey = 'E'
	},

	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = 469.967, y = -1014.452, z = 26.536},
		textCoords = {x = 469.35, y = -1014.452, z = 27.136},
		authorizedJobs = {'all'},
		locked = true,
		distance = 4,
		doorKey = 'E'
	},

	-- Back Gate
	{
		objName = 'hei_prop_station_gate',
		objCoords  = {x = 488.894, y = -1017.210, z = 27.146},
		textCoords = {x = 488.894, y = -1020.210, z = 30.00},
		authorizedJobs = {'all'},
		locked = true,
		distance = 14,
		size = 2,
		doorKey = 'E'
	},
	
	--
	-- ساندي شورز
	--

	-- Entrance
	{
		objName = 'v_ilev_shrfdoor',
		objCoords  = {x = 1855.105, y = 3683.516, z = 34.266},
		textCoords = {x = 1855.105, y = 3683.516, z = 35.00},
		authorizedJobs = {'all'},
		locked = false,
		doorKey = 'E'
	},

	-- Cell 1
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 1848.02, y = 3682.5, z = 34.20},
		textCoords = {x = 1847.69, y = 3682.5, z = 34.50},
		authorizedJobs = {'all'},
		locked = true,
		doorKey = 'E'
	},
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 1846.34, y = 3685.5, z = 34.20},
		textCoords = {x = 1845.8, y = 3685.4, z = 34.4},
		authorizedJobs = {'all'},
		locked = true,
		doorKey = 'E'
	},
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 1844.90, y = 3688.01, z = 34.20},
		textCoords = {x = 1844.60, y = 3687.46, z = 34.4},
		authorizedJobs = {'all'},
		locked = true,
		doorKey = 'E'
	},
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = 1857.21, y = 3689.77, z = 34.20},
		textCoords = {x = 1857.21, y = 3690.19, z = 34.50},
		authorizedJobs = {'all'},
		locked = true,
		doorKey = 'E'
	},
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = 1859.63, y = 3691.64, z = 34.23},
		textCoords = {x = 1859.76, y = 3691.68, z = 34.45},
		authorizedJobs = {'all'},
		locked = true,
		doorKey = 'E'
	},
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = 1847.16, y = 3689.91, z = 34.42},
		textCoords = {x = 1848.32, y = 3690.53, z = 34.42},
		authorizedJobs = {'all'},
		locked = true,
		distance = 2.5,
		doorKey = 'E'
	},
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = 1849.41, y = 3691.21, z = 34.42},
		textCoords = {x = 1848.32, y = 3690.53, z = 34.42},
		authorizedJobs = {'all'},
		locked = true,
		distance = 2.5,
		doorKey = 'E'
	},
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = 1849.99, y = 3684.14, z = 34.42},
		textCoords = {x = 1850.58, y = 3683.01, z = 34.40},
		authorizedJobs = {'all'},
		locked = true,
		distance = 2,
		doorKey = 'K'
	},
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = 1851.26, y = 3681.87, z = 34.42},
		textCoords = {x = 1850.58, y = 3683.01, z = 34.40},
		authorizedJobs = {'all'},
		locked = true,
		distance = 2,
		doorKey = 'K'
	},

	-- Cell
	
	--loker room
	{
		objName = 'v_ilev_ct_door03',
		objCoords  = {x = 1833.2, y = 3672.4, z = -118.6},
		textCoords = {x = 1833.2, y = 3672.4, z = -118.6},
		authorizedJobs = {'all'},
		locked = true,
		doorKey = 'E'
	},
	
	--Office
	{
		objName = '	v_ilev_cd_entrydoor',
		objCoords  = {x = 1847.8, y = 3681.0, z = -118.6},
		textCoords = {x = 1847.8, y = 3681.0, z = -118.6},
		authorizedJobs = {'all'},
		locked = true,
		doorKey = 'E'
	},
	--
	-- بليتو
	--

	-- Entrance (double doors)
	{
		objName = 'v_ilev_shrf2door',
		objCoords  = {x = -443.14, y = 6015.685, z = 31.716},
		textCoords = {x = -443.14, y = 6015.685, z = 32.00},
		authorizedJobs = {'all'},
		locked = false,
		distance = 2.5,
		doorKey = 'E'
	},

	{
		objName = 'v_ilev_shrf2door',
		objCoords  = {x = -443.951, y = 6016.622, z = 31.716},
		textCoords = {x = -443.951, y = 6016.622, z = 32.00},
		authorizedJobs = {'all'},
		locked = false,
		distance = 2.5,
		doorKey = 'E'
	},
	
	-- Cell 1
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = -433.2, y = 5992.4, z = 31.71},
		textCoords = {x = -432.9, y = 5992.9, z = 31.91},
		authorizedJobs = {'all'},
		locked = true,
		doorKey = 'E'
	},

	-- Cell 2
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = -429.11, y = 5997.0, z = 31.71},
		textCoords = {x = -428.8, y = 5997.6, z = 31.91},
		authorizedJobs = {'all'},
		locked = true,
		doorKey = 'E'
	},

	--Cell 3
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = -432.2, y = 6000.1, z = 31.71},
		textCoords = {x = -431.8, y = 6000.6, z = 31.91},
		authorizedJobs = {'all'},
		locked = true,
		doorKey = 'E'
	},
		--Cell 3
	{
		objName = 'v_ilev_fingate',
		objCoords  = {x = -437.6, y = 5992.8, z = 31.93},
		textCoords = {x = -436.6, y = 5991.8, z = 31.93},
		authorizedJobs = {'all'},
		locked = true,
		distance = 2,
		doorKey = 'E'
	},
	    --المدخل الداخلي
	{
		objName = 'v_ilev_bk_door2',
		objCoords  = {x = -442.8, y = 6010.9, z = 31.86},
		textCoords = {x = -441.87, y = 6011.7, z = 31.71},
		authorizedJobs = {'all'},
		locked = true,
		distance = 2,
		doorKey = 'E'
	},
		    --المدخل الداخلي
	{
		objName = 'v_ilev_bk_door2',
		objCoords  = {x = -440.98, y = 6012.7, z = 31.86},
		textCoords = {x = -441.87, y = 6011.7, z = 31.71},
		authorizedJobs = {'all'},
		locked = true,
		distance = 2,
		doorKey = 'E'
	},
			    --المدخل الداخلي
	{
		objName = 'v_ilev_ss_door7',
		objCoords  = {x = -448.55, y = 6007.78, z = 31.71},
		textCoords = {x = -448.55, y = 6007.78, z = 31.81},
		authorizedJobs = {'all'},
		locked = true,
		distance = 2,
		doorKey = 'E'
	},
			    --المدخل الداخلي
	{
		objName = 'v_ilev_ss_door8',
		objCoords  = {x = -447.70, y = 6006.70, z = 31.80},
		textCoords = {x = -448.55, y = 6007.78, z = 31.81},
		authorizedJobs = {'all'},
		locked = true,
		distance = 2,
		doorKey = 'E'
	},
			    --مدخل الهيليكوبتر
	{
		objName = 'v_ilev_gc_door01',
		objCoords  = {x = -450.97, y = 6006.07, z = 31.99},
		textCoords = {x = -451.65, y = 6006.97, z = 31.99},
		authorizedJobs = {'all'},
		locked = true,
		distance = 2,
		doorKey = 'E'
	},
				    --مدخل الهيليكوبتر
	
					    --غرفة التحقيق
	{
		objName = 'v_ilev_cd_entrydoor',
		objCoords  = {x = -454.53, y = 6011.25, z = 31.99},
		textCoords = {x = -453.32, y = 6011.51, z = 31.99},
		authorizedJobs = {'all'},
		locked = true,
		distance = 2,
		doorKey = 'E'
	},


	{
		objName = 'prop_facgate_07',
		objCoords  = {x = -433.1, y = 6036.9, z = 30.5},
		textCoords ={x = -434.6, y = 6040.5, z = 32.3},
		authorizedJobs = {'all'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'E'
	},


	--
	-- Bolingbroke Penitentiary
	--

	

	{
		objName = 'prop_gate_prison_01',
		objCoords  = {x = 1818.542, y = 2604.812, z = 44.611},
		textCoords = {x = 1818.542, y = 2608.40, z = 48.00},
		authorizedJobs = {'all'},
		locked = true,
		distance = 12,
		size = 2,
		doorKey = 'E'
	},
	--كراج سيارات الشرطة
	{
		objName = 'prop_facgate_07',
		objCoords  = {x = 1877.2, y = 3687.4, z = 32.7},
		textCoords = {x = 1873.2, y = 3685.4, z = 33.7},
		authorizedJobs = {'all'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'E'
	},
		--كراج سيارات الشرطة
	{
		objName = 'prop_facgate_07',
		objCoords  = {x = 1858.04, y = 3719.9, z = 32.1},
		textCoords ={x = 1855.04, y = 3718.2, z = 33.7},
		authorizedJobs = {'all'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'E'
	},

	{
		objName = 'prop_gate_docks_ld',
		objCoords  = {x = 264.30, y = -2690.24, z= 6.02}, --724.09, -2614.78, 16.9119
		textCoords = {x = 264.30, y = -2690.24, z= 6.02},
		authorizedJobs = {'agent', 'admin', 'police'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'K'
	},

	{
		objName = 'prop_gate_docks_ld',
		objCoords  = {x = 346.57, y = -2238.12, z= 10.31}, --724.09, -2614.78, 16.9119
		textCoords = {x = 346.57, y = -2238.12, z= 10.31},
		authorizedJobs = {'agent', 'admin', 'police'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'K'
	},


	{
		objName = 'prop_gate_docks_ld',
		objCoords  = {x = 359.59, y = -2238.41, z = 10.30}, --724.09, -2614.78, 16.9119
		textCoords = {x = 359.59, y = -2238.41, z = 10.30},
		authorizedJobs = {'agent', 'admin', 'police'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'E'
	},



	{
		objName = 'prop_gate_docks_ld',
		objCoords  = {x = 275.09, y = -2691.37, z= 6.02}, --724.09, -2614.78, 16.9119
		textCoords = {x = 275.09, y = -2691.37, z= 6.02},
		authorizedJobs = {'agent', 'admin', 'police'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'E'
	},

	{
		objName = 'prop_gate_docks_ld',
		objCoords  = {x = 189.29, y = -2767.31, z = 6.00}, --724.09, -2614.78, 16.9119
		textCoords = {x = 189.29, y = -2767.31, z = 6.00},
		authorizedJobs = {'agent', 'admin', 'police'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'E'
	},

	{
		objName = 'prop_gate_docks_ld',
		objCoords  = {x = 260.50, y = -2676.23, z = 18.35}, --724.09, -2614.78, 16.9119
		textCoords = {x = 260.50, y = -2676.23, z = 18.35},
		authorizedJobs = {'agent', 'admin', 'police'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'E'
	},

	{
		objName = 'prop_gate_docks_ld',
		objCoords  = {x = 247.16, y = -2676.07, z=  18.37}, --724.09, -2614.78, 16.9119
		textCoords = {x = -212.12, y = -2616.55, z= 6.05},
		authorizedJobs = {'agent', 'admin', 'police'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'K'
	},

	{
		objName = 'prop_gate_docks_ld',
		objCoords  = {x = -205.32, y = -2539.77, z = 6.00}, --724.09, -2614.78, 16.9119
		textCoords = {x = -205.32, y = -2539.77, z = 6.00},
		authorizedJobs = {'agent', 'admin', 'police'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'K'
	},

	{
		objName = 'prop_gate_docks_ld',
		objCoords  = {x = -184.23, y = -2565.99, z = 6.00}, --724.09, -2614.78, 16.9119
		textCoords = {x = -184.23, y = -2565.99, z = 6.00},
		authorizedJobs = {'agent', 'admin', 'police'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'K'
	},

	{
		objName = 'prop_gate_docks_ld',
		objCoords  = {x = -212.22, y = -2628.05, z = 6.05}, --724.09, -2614.78, 16.9119
		textCoords = {x = -212.22, y = -2628.05, z = 6.05},
		authorizedJobs = {'agent', 'admin', 'police'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'E'
	},

	{
		objName = 'prop_gate_docks_ld',
		objCoords  = {x = -212.12, y = -2616.55, z= 6.05}, --724.09, -2614.78, 16.9119
		textCoords = {x = -212.12, y = -2616.55, z= 6.05},
		authorizedJobs = {'agent', 'admin', 'police'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'K'
	},

	{
		objName = 'prop_gate_docks_ld',
		objCoords  = {x = -200.39, y = -2613.11, z = 6.00}, --724.09, -2614.78, 16.9119
		textCoords = {x = -200.39, y = -2613.11, z = 6.00},
		authorizedJobs = {'agent', 'admin', 'police'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'K'
	},

	{
		objName = 'prop_gate_docks_ld',
		objCoords  = {x = -189.73, y = -2613.32, z = 6.00}, --724.09, -2614.78, 16.9119
		textCoords = {x = -189.73, y = -2613.32, z = 6.00},
		authorizedJobs = {'agent', 'admin', 'police'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'E'
	},

	{
		objName = 'prop_gate_docks_ld',
		objCoords  = {x = 700.79, y = -2797.53, z = 6.17}, --724.09, -2614.78, 16.9119
		textCoords = {x = 700.79, y = -2797.53, z = 6.17},
		authorizedJobs = {'agent', 'admin', 'police'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'E'
	},

	{
		objName = 'prop_gate_docks_ld',
		objCoords  = {x = 700.14, y = -2776.38, z = 6.18}, --724.09, -2614.78, 16.9119
		textCoords = {x = 700.14, y = -2776.38, z = 6.18},
		authorizedJobs = {'agent', 'admin', 'police'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'K'
	},

	{
		objName = 'prop_gate_docks_ld',
		objCoords  = {x = 564.94, y = -2574.32, z = 6.50}, --724.09, -2614.78, 16.9119
		textCoords = {x = 564.94, y = -2574.32, z = 6.50},
		authorizedJobs = {'agent', 'admin', 'police'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'K'
	},

	{
		objName = 'prop_gate_docks_ld',
		objCoords  = {x = 575.38, y = -2562.59, z = 6.49}, --724.09, -2614.78, 16.9119
		textCoords = {x = 575.38, y = -2562.59, z = 6.49},
		authorizedJobs = {'agent', 'admin', 'police'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'E'
	},

	{
		objName = 'prop_gate_docks_ld',
		objCoords  = {x = 150.44, y = -2557.24, z = 6.00}, --724.09, -2614.78, 16.9119
		textCoords = {x = 150.44, y = -2557.24, z = 6.00},
		authorizedJobs = {'agent', 'admin', 'police'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'K'
	},

	{
		objName = 'prop_gate_docks_ld',
		objCoords  = {x = 150.78, y = -2546.51, z = 6.00}, --724.09, -2614.78, 16.9119
		textCoords = {x = 150.78, y = -2546.51, z = 6.00},
		authorizedJobs = {'agent', 'admin', 'police'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'E'
	},

	{
		objName = 'prop_gate_docks_ld',
		objCoords  = {x = 634.39, y = -2506.36, z = 17.39}, --724.09, -2614.78, 16.9119
		textCoords = {x = 634.39, y = -2506.36, z = 17.39},
		authorizedJobs = {'agent', 'admin', 'police'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'K'
	},

	{
		objName = 'prop_gate_docks_ld',
		objCoords  = {x = 634.56, y = -2492.04, z = 17.40}, --724.09, -2614.78, 16.9119
		textCoords = {x = 634.56, y = -2492.04, z = 17.40},
		authorizedJobs = {'agent', 'admin', 'police'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'E'
	},
						     --الميناء الرئيسي بوابة 1
	 	{
		objName = 'prop_gate_docks_ld',
		objCoords  = {x = 724.09, y = -2614.78, z = 16.9119}, --724.09, -2614.78, 16.9119
		textCoords = {x = 724.09, y = -2614.78, z = 16.9119},
		authorizedJobs = {'agent', 'admin', 'police'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'E'
	},

							     --الميناء الرئيسي بوابة 2
	 	{
		objName = 'prop_gate_docks_ld',
		objCoords  = {x = 738.87, y = -2614.92, z = 16.8868}, --738.87, -2614.92, 16.8868
		textCoords = {x = 738.87, y = -2614.92, z = 16.8868},
		authorizedJobs = {'agent', 'admin', 'police'},
		locked = false,
		distance = 12,
		size = 2.5,
		doorKey = 'H'
	},

	{ -- +الميناء
		objName = 'prop_gate_military_01',
		objCoords  = {x = 825.48, y = -2945.872, z = 4.905876}, --825.48, -2945.872, 4.905876
		textCoords = {x = 825.48, y = -2945.872, z = 4.905876},
		authorizedJobs = {'agent', 'admin', 'police'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'K'
	},


	{ -- الميناء
		objName = 'prop_gate_military_01',
		objCoords  = {x = 825.2298, y = -3035.842, z = 4.738614}, --825.2298, -3035.842, 4.738614
		textCoords = {x = 825.2298, y = -3035.842, z = 4.738614},
		authorizedJobs = {'agent', 'admin', 'police'},
		locked = true,
		distance = 12,
		size = 2.5,
		doorKey = 'E'
	},

	{ -- الرقابة والتفتيش
	objName = 'apa_prop_ss1_mpint_door_r',
	objCoords  = {x = 241.94, y = -1149.91, z = 31.56}, --241.94, -1149.91, 31.56
	textCoords = {x = 241.94, y = -1149.91, z = 31.56},
	authorizedJobs = {'admin'},
	locked = true,
	distance = 5,
	size = 1.5,
	doorKey = 'E'
},

	{ --  2الرقابة والتفتيش
	objName = 'apa_prop_ss1_mpint_door_l',
	objCoords  = {x = 241.97, y = -1147.76, z = 31.56006}, --241.97, -1147.76, 31.56006
	textCoords = {x = 241.97, y = -1147.76, z = 31.56006},
	authorizedJobs = {'admin'},
	locked = true,
	distance = 5,
	size = 1.5,
	doorKey = 'H'
},

{ --  سجن1الرقابة والتفتيش
objName = 'prop_ld_jail_door',
objCoords  = {x = 259.1, y = -1165.79, z = 31.34}, --259.1, -1165.79, 31.34
textCoords = {x = 259.1, y = -1165.79, z = 31.34},
authorizedJobs = {'admin'},
locked = true,
distance = 5,
size = 1.5,
doorKey = 'E'
},


{ --  سجن2الرقابة والتفتيش
objName = 'prop_ld_jail_door',
objCoords  = {x = 259.2699, y = -1171.153, z = 31.27}, --259.2699, -1171.153, 31.27
textCoords = {x = 259.2699, y = -1171.153, z = 31.27},
authorizedJobs = {'admin'},
locked = true,
distance = 5,
size = 1.5,
doorKey = 'H'
},


{ --  سجن3الرقابة والتفتيش
objName = 'prop_ld_jail_door',
objCoords  = {x = 264.9015, y = -1171.065, z = 31.31}, --264.9015, -1171.065, 31.31
textCoords = {x = 264.9015, y = -1171.065, z = 31.31},
authorizedJobs = {'admin'},
locked = true,
distance = 5,
size = 1.5,
doorKey = 'K'
},

{ --  الميكانيكة
objName = 'apa_prop_ss1_mpint_door_r',
objCoords  = {x = 201.94, y = 3165.87, z = 47.16}, --201.94, 3165.87, 47.16
textCoords = {x = 201.94, y = 3165.87, z = 47.16},
authorizedJobs = {'mechanic'},
locked = true,
distance = 5,
size = 1.5,
doorKey = 'K'
},

{ --  الميكانيكة
objName = 'apa_prop_ss1_mpint_door_r',
objCoords  = {x = 201.95, y = 3177.21, z = 47.16}, --201.95, 3177.21, 47.16
textCoords = {x = 201.95, y = 3177.21, z = 47.16},
authorizedJobs = {'mechanic'},
locked = true,
distance = 5,
size = 1.5,
doorKey = 'H'
},

{ --  الميكانيكة
objName = 'apa_prop_ss1_mpint_door_r',
objCoords  = {x = 201.94, y = 3190.54, z = 47.16}, --201.94, 3190.54, 47.16
textCoords = {x = 201.94, y = 3190.54, z = 47.16},
authorizedJobs = {'mechanic'},
locked = true,
distance = 5,
size = 1.5,
doorKey = 'E'
},

{ --  الميكانيكة
objName = 'apa_prop_ss1_mpint_door_r',
objCoords  = {x = 201.98, y = 3197.82, z = 47.16}, --201.98, 3197.82, 47.16
textCoords = {x = 201.98, y = 3197.82, z = 47.16},
authorizedJobs = {'mechanic'},
locked = true,
distance = 5,
size = 1.5,
doorKey = 'K'
},

{ --  الميكانيكة
objName = 'apa_prop_ss1_mpint_garage2',
objCoords  = {x = 190.2905, y = 3154.301, z = 44.20981}, --190.2905, 3154.301, 44.20981
textCoords = {x = 190.2905, y = 3154.301, z = 44.20981},
authorizedJobs = {'mechanic'},
locked = true,
distance = 5,
size = 1.5,
doorKey = 'E'
},

{ --  الميكانيكة
objName = 'apa_prop_ss1_mpint_garage2',
objCoords  = {x = 186.8795, y = 3203.917, z = 44.45578}, --186.8795, 3203.917, 44.45578
textCoords = {x = 186.8795, y = 3203.917, z = 44.45578},
authorizedJobs = {'mechanic'},
locked = true,
distance = 5,
size = 1.5,
doorKey = 'K'
},


{ --  الميكانيكة
objName = 'apa_prop_ss1_mpint_door_l',
objCoords  = {x = 196.5979, y = 3156.971, z = 43.66962}, --196.5979, 3156.971, 43.66962
textCoords = {x = 196.5979, y = 3156.971, z = 43.66962},
authorizedJobs = {'mechanic'},
locked = true,
distance = 5,
size = 1.5,
doorKey = 'H'
},





	 
	
	--main jail interior--
	
	--[[
	-- Entrance Gate (Mission Row mod) https://www.gta5-mods.com/maps/mission-row-pd-ymap-fivem-v1
	{
		objName = 'prop_gate_airport_01',
		objCoords  = {x = 420.133, y = -1017.301, z = 28.086},
		textCoords = {x = 420.133, y = -1021.00, z = 32.00},
		authorizedJobs = {'police','admin'},
		locked = true,
		distance = 14,
		size = 2
	}
	--]]
}