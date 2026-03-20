Config = {}

Config.M3rdName = " ﻞﻤﻌﺘﺴﻣ "

Config.SellPosition = {
    ["x"] = 647.42,
    ["y"] = 642.48,
    ["z"] = 129.91,
}


Config.VehiclesShop1 = {

	---------------
	['Cars'] = {
		Categories = {
			{ name = '1', label = 'سيدان' },
			--{name = '1', label = 'فئة سعودية'},
			{name = '2', label = 'كبيرة'},
			{name = '3', label = 'سبورت'},
			{name = '4', label = 'سوبر'},
			{name = '5', label = 'فخمة'},
			{name = '6', label = 'كلاسيك'},
			{name = '8', label = 'حمولة 120 كيلو'},
			{name = '9', label = 'حمولة 80 كيلو'},
			{name = '10', label = 'حمولة 60 كيلو'},
			{name = '11', label = 'حمولة 40 كيلو'},
			{name = '12', label = 'فان نقل 120 كيلو'},
		},
	
		Vehicles = {
			--[[{ model = '12charger', name = 'دوج تشارجر 2012', price = 1150000, level = 15, category = '1' },
			{ model = '79mudrunner', name = 'شاص مطور', price = 700000, level = 15, category = '1' },
			{ model = 'gle22', name = 'كامري 2022', price = 1000000, level = 15, category = '1' },
			{ model = 'dre300cat', name = 'كلايزر', price = 1200000, level = 15, category = '1' },
			{ model = 'drehellcatdurango', name = 'دوج درانجو', price = 100, level = 15, category = '1' },
			{ model = 'sierra06', name = 'جمس سييرا 2006', price = 750000, level = 15, category = '1' },
			{ model = 'cavalcade2', name = 'لاند 2007', price = 500000, level = 15, category = '1' },
			{ model = 'lc300gr', name = 'لاند كروزر 2021', price = 800000, level = 15, category = '1' },
			{ model = 'bodhi2', name = 'شاص 2022', price = 800000, level = 15, category = '1' },
			{ model = 'landstalker', name = 'لاند vxr 2018', price = 600000, level = 15, category = '1' },
			{ model = 'max99s', name = 'مكسيما 1999', price = 1300000, level = 15, category = '1' },
			{ model = 'relaxgmc', name = 'سييرا 2017', price = 700000, level = 15, category = '1' },
			{ model = 'sierra2020', name = 'سييرا 2020', price = 1000000, level = 15, category = '1' },
			{ model = 'lg81hcredeye', name = 'دوج تشارجر srt', price = 1500000, level = 15, category = '1' },
			{ model = 'oracle2', name = 'صني 2018', price = 300000, level = 15, category = '1' },
			{ model = 'rebel2', name = 'هايلكس 1998', price = 120000, level = 5, category = '1' },
			{ model = 'btype2', name = 'جمس بهبهاني 1979', price = 350000, level = 30, category = '9' },
			{ model = 'gmcklo25', name = 'جمس بهبهاني 1978', price = 150000, level = 10, category = '2' },--]]
			--{ model = 'hdd', name = 'تايوتا لاند كروزر - GX', price = 390000, level = 15, category = '2' },
			{ model = 'felon', name = 'هيونداي جينس جي-380 2016', price = 350000, level = 5, category = '1' },
			{ model = 'camry55', name = 'تويوتا كـامـري 2016', price = 500000, level = 10, category = '1' },
			{ model = 'nisaltima', name = 'نيسان التيما 3.5 SE', price = 200000, level = 5, category = '1' },
			{ model = 'caprice13', name = 'شيفرولية كابريس 2013', price = 250000, level = 10, category = '1' },
			{ model = 'camry18', name = 'تيوتا كامري 2018', price = 500000, level = 20, category = '1' },
			{ model = '96impala', name = 'شيفروليه امبالا 1996', price = 120000, level = 5, category = '1' },
			{ model = 'gs350', name = 'ليكزس جي-اس-350', price = 800000, level = 25, category = '1' },

			{ model = 'fjcruiser', name = 'جيب تيوتا اف جي 2014', price = 1300000, level = 45, category = '2' },
			{ model = 'bentayga17', name = 'جيب بنتلي', price = 2000000, level = 40, category = '2' },
			{ model = 'srt8', name = 'جيب شروكي اس ار تي 8 2016', price = 2000000, level = 60, category = '2' },
			{ model = 'wagoneer', name = 'جيب واقونير 1963', price = 500000, level = 20, category = '2' },
			{ model = 'bc21bronco', name = 'فورد برونكو 2021 - مرفع', price = 1000000, level = 40, category = '2' },
			{ model = 'x5e53', name = 'بي ام دبليو X5', price = 450000, level = 20, category = '2' },
			{ model = 'cayenne', name = 'بورش كـايـن تيربو-أس 2016', price = 900000, level = 25, category = '2' },
			{ model = 'x6m', name = 'بي ام دبليو أكس-6 2016', price = 1900000, level = 35, category = '2' },
			{ model = 'patrol', name = '2016 نيسان باترول نسمو', price = 1500000, level = 40, category = '2' },
			{ model = 'suburban', name = '1973 شيفروليه سوبربان', price = 650000, level = 20, category = '2' },
			{ model = 'expmax20', name = 'فورد اكسبدشن - 2020', price = 650000, level = 25, category = '2' },
			{ model = 'cherokee1', name = 'جيب شيروكي 1984', price = 54000, level = 25, category = '2' },
			{ model = '4444', name = '2021 G-Class AMG مرسيدس ', price = 3000000, level = 80, category = '2' },
			{ model = 'gmcyd', name = 'جمس يوكن دينالي 2015', price = 750000, level = 30, category = '2' },
			{ model = 'granger', name = 'جيمس يوكن أكس-ألـ 2003', price = 180000, level = 22, category = '2' },
			{ model = 'jeep2012', name = 'جيب رانجلر 2012', price = 450000, level = 25, category = '2' },
			{ model = 'lex570', name = 'لكزس أل-أكس-570', price = 2000000, level = 40, category = '2' },
			{ model = 'qx80', name = 'انفنتي - 2019', price = 799999, level = 30, category = '2' },
			{ model = 'rb3_2006', name = 'لاند كروزر ربع - 2006', price = 380000, level = 20, category = '2' },
			{ model = 'rb3_2017', name = 'لاند كروزر ربع - 2017', price = 550000, level = 25, category = '2' },
			{ model = 'rrst', name = 'رنج روفر فوج 2020', price = 5000000, level = 50, category = '2' },
			{ model = 'tahoe', name = 'شيفرولية تاهو 2013', price = 450000, level = 20, category = '2' },
			{ model = 'benzsl63', name = 'مرسيدس AMG SL 63', price = 700000, level = 25, category = '3' },
			{ model = 'game718', name = 'بورش 718 كايمن كاريرا أس', price = 800000, level = 30, category = '3' },
			{ model = 'rm3e36', name = 'بي ام دبيلو M3 e36', price = 750000, level = 30, category = '3' },
			{ model = 'rmodfordgt', name = 'فورد موستنق GT 2011', price = 350000, level = 25, category = '3' },
			{ model = 'rmodm4', name = 'بي ام دبيلو M4', price = 1500000, level = 50, category = '3' },
			{ model = 'kuruma', name = 'ميتسوبيشي لانسر', price = 500000, level = 30, category = '3' },
			{ model = 'ast', name = 'استون مارتن', price = 950000, level = 30, category = '3' },
			{ model = 'zl12017', name = 'كمارو SS 2017', price = 400000, level = 20, category = '3' },
			{ model = '911r', name = 'بورشه 911 ار جي تي 3 2017', price = 1500000, level = 50, category = '3' },
			{ model = 'ninef', name = 'أودي R8', price = 400000, level = 15, category = '3' },
			{ model = 'stiwrc', name = '2001 WRX STI سوبارو', price = 550000, level = 15, category = '3' },
			{ model = '2019M5', name = '2020 M5 بي ام دبليو', price = 2000000, level = 50, category = '3' },
			{ model = '19dbs', name = 'استون مارتن', price = 100, level = 40, category = '3' },
			{ model = '2013rs7', name = 'اودي - rs7 2013', price = 800000, level = 30, category = '3' },
			{ model = 'a6', name = 'اودي a6 - 2019', price = 850000, level = 35, category = '3' },
			{ model = 'amggt63s', name = 'مرسيدس amg63', price = 2200000, level = 50, category = '3' },
			{ model = 'c7', name = 'كورفيت C7R', price = 1650000, level = 40, category = '3' },
			{ model = 'cls63s', name = 'مرسيدس - s63', price = 180000, level = 45, category = '3' },
			{ model = 'c6z06', name = 'كورفيت ZO6', price = 1200000, level = 30, category = '3' },
			{ model = 'rmodmustang', name = 'فورد موستنق GT 2015', price = 180000, level = 45, category = '3' },

			--{ model = 'ctsv16', name = 'كديلاك - 16', price = 1350000, level = 40, category = '3' },
			--{ model = 'rmode63s', name = '2019 برابس E63S مرسيدس', price = 3850000, level = 50, category = '3' },
			{ model = 'e63b', name = '2014 برابس E63 مرسيدس', price = 2000000, level = 40, category = '3' },
			{ model = 'c7z06', name = 'كورفيت C7 ZO6', price = 2000000, level = 50, category = '3' },
			{ model = 'gamea45', name = 'مرسيدس A45 AMG ', price = 800000, level = 25, category = '3' },
			{ model = 'caprice89', name = 'كابرس 1985', price = 200000, level = 5, category = '6' },
			
			
			
			{ model = 'gcm992targa', name = 'بورش نسخة كلاسك - 911', price = 1650000, level = 40, category = '3' },
			{ model = 'gtr', name = 'GTR 35 - جيتي ار', price = 550000, level = 25, category = '3' },
			{ model = 'm3e30', name = 'بي ام ام ثري - Bmw m3', price = 430000, level = 22, category = '3' },
			{ model = 'm3e46', name = 'بي ام دبليو M3 e46 2005', price = 999000, level = 35, category = '3' },
			{ model = 'm3f80', name = 'بي ام - M3 2015', price = 1200000, level = 30, category = '3' },
			{ model = 'mach1', name = 'موستنق ماتش - 2018', price = 1100000, level = 25, category = '3' },
			
			{ model = 'macr820h1', name = 'موستنق ماتش - 2018', price = 1100000, level = 25, category = '3' },
			{ model = 'r820', name = 'أودي R8', price = 650000, level = 25, category = '3' },
			{ model = 'S63W222', name = 'مرسيدس أس-63 2014', price = 750000, level = 21, category = '3' },
			
			{ model = 'mansc8', name = 'كورفت c8', price = 3500000, level = 15, category = '3' },
			{ model = 'czr1', name = 'كورفت zr1', price = 4000000, level = 60, category = '3' }, 
			--{ model = 'rmodgtr50', name = 'نيسان gtr', price = 2320000, level = 55, category = '5' }, مزاد
			{ model = 'rmodsuprapandem', name = 'تايوتا سوبرا gt', price = 1400000, level = 25, category = '3' },
			{ model = 'rmodzl1', name = 'كومارو zl1', price = 2550000, level = 35, category = '3' },
			{ model = 'mansm2', name = 'بي إم دبليو M2', price = 1500000, level = 30, category = '3' },
			{ model = 'hellcatlb', name = 'تشالنجر هيل كات', price = 3000000, level = 40, category = '3' },
			{ model = 'rmodrs7', name = 'اودي rs7', price = 1100000, level = 35, category = '3' },
			{ model = 'gencoupe', name = 'هونداي جينيسيس كوبيه', price = 00, level = 10, category = '3' },
			{ model = 'b800', name = 'مرسيدس E63S برابس موديل 2019', price = 3500000, level = 50, category = '3' },
			{ model = 'challenger16', name = 'دوج تشالنجر - 2016', price = 430000, level = 20, category = '3' },
			--{ model = 'ct5v', name = '2021 CT5-V كاديلاك', price = 5000000, level = 55, category = '5' },
			--{ model = 'demon', name = 'دوج ديمون', price = 999999, level = 40, category = '3' },
			{ model = 'dtd_c63s', name = 'مرسيدس خاص - s63', price = 1650000, level = 35, category = '3' },
			{ model = '13fmb302', name = 'موستنق بوس - 2013', price = 650000, level = 25, category = '3' },
			{ model = 'furoregt', name = 'نيسان زد 370 2016', price = 700000, level = 20, category = '3' },
			{ model = 'gcm992gt3', name = 'بورش - GT3', price = 1900000, level = 45, category = '3' },
			-------- { model = 'm3e30', name = 'بي ام ام ثري - Bmw m3', price = 170000, level = 5, category = '5' },
			--{ model = 'موستنق ماتش - 2018', name = 'mach1', price = 1000000, level = 35, category = '5' },
			{ model = 'mbc63', name = 'مرسيدس - C63 AMG', price = 890000, level = 25, category = '3' },
			{ model = 'mustang19', name = 'موستنق - GT', price = 100, level = 40, category = '3' },
			{ model = 'rmodbmwi8', name = 'بي ام دبليو i8', price = 000, level = 50, category = '3' },
			{ model = 'rs72013', name = 'اودي - rs7 2013', price = 1000000, level = 30, category = '3' },
			{ model = 'ss16', name = 'كمارو SS 2017', price = 1790000, level = 40, category = '3' },
			{ model = 'supra2', name = 'تيوتا سوبرا', price = 750000, level = 20, category = '3' },

			{ model = '650s', name = 'ماكلارين 650 اس اصدار خاص', price = 5500000, level = 70, category = '4' },
			--{ model = 'aventadors', name = 'لمبرجيني  افنتدور', price = 4100000, level = 70, category = '4' },
			{ model = 'ldsv', name = '1995 لامبورجيني ديابلو اس في', price = 5000000, level = 90, category = '4' },
			{ model = 'ie', name = 'أبولو إنتنزا إموزيوني', price = 5000000, level = 70, category = '4' },
			{ model = 'c8', name = 'كورفيت سي-8 2020', price = 000, level = 50, category = '4' },

			{ model = 'c8r', name = '2020 اصدار  حلبة سباق C8 شيفروليه كورفت', price = 5000000, level = 80, category = '4' },
			{ model = 'f430s', name = 'فيراري اف-430-اس سكودريا', price = 600000, level = 80, category = '4' },
			--{ model = 'fxxkevo', name = 'فيراري دراج ريس', price = 4000000, level = 85, category = '4' },

			
			
			--{ model = 'bdivo', name = 'بوقاتي ديفو', price = 100000000, level = 90, category = '6' }, غير محدد
			--{ model = 'bcps', name = 'بوقاتي ', price = 9000000, level = 100, category = '4' },
			--{ model = 'superleggera', name = 'استون مارتن', price = 9000000, level = 80, category = '6' }, مزاد
			--{ model = 'CABRERA', name = 'لمبرجيني كابريرا', price = 7500000, level = 75	, category = '4' },
			--{ model = 'rmodsianr', name = 'لمبرجيني سيان رودستر', price = 12000000, level = 100, category = '4' },
			--{ model = 'rmodlp670', name = 'لمبرجيني مورسيلاغو', price = 8500000, level = 85	, category = '4' },
			--{ model = '720nlargo', name = 'مكلارين 720', price = 8900000, level = 90, category = '4' },
			--{ model = '918', name = 'بورش سبايدر', price = 100000000, level = 90, category = '6' }, مزاد
			--{ model = 'fstradale', name = 'فيراري ستراديل', price = 5000000, level = 65, category = '4' },
			--{ model = 'f40', name = 'فيراري كلاسك - f40', price = 2900000, level = 70, category = '4' },
			--{ model = 'fxxkevo', name = 'فيراري FXX K هايبر كار', price = 89, level = 6900000, category = '6' }, مزاد
			--{ model = 'mcgt20', name = '2020 ماكلارين جي تي', price = 4500000, level = 85, category = '4' },
			--{ model = 'rmodpagani', name = 'باقاني هيارا رودستر 2018', price = 3800000, level = 65, category = '4' },
			{ model = 's650', name = 'ماكلارين حلبات اصدار خاص', price = 3200000, level = 70, category = '4' },

			{ model = 'ben17', name = ' بنتلي سبورت - 2017', price = 9000000, level = 90, category = '5' },		
			{ model = 'rrphantom', name = 'رولز رايز فانتوم 2018', price = 20000000, level = 100, category = '5' },	

			{ model = '560sec87', name = ' مرسيدس كوبية - SEC 560', price = 166000, level = 30, category = '6' },
			{ model = '750il', name = 'بي ام دبليو - BMW 750 iL', price = 133000, level = 20, category = '6' },
			{ model = 'Benz300SEL', name = 'مرسيدس - SEL 300', price = 129000, level = 35, category = '6' },
			{ model = 'boss302', name = 'موستنق شلبي', price = 243000, level = 25, category = '6' },
			{ model = 'camaro68', name = 'كمارو - Ss68', price = 990000, level = 30, category = '6' },
			{ model = 'camaro69', name = 'كمارو - Ss 69', price = 108000, level = 30, category = '6' },
			{ model = 'caprice93', name = 'كابرس صابونة - 1993', price = 56000, level = 15, category = '6' },
			{ model = 'caprice91', name = 'كابرس صابونة - 1991', price = 48000, level = 15, category = '6' },
			{ model = 'caprs', name = 'كابرس - 1989', price = 38000, level = 15, category = '6' },
			{ model = 'casco', name = 'جاكور إي-تايب', price = 82000, level = 25, category = '6' },
			{ model = 'chall70', name = 'تشالنجر - RT 1970', price = 88000, level = 26, category = '6' },
			{ model = 'corvette63', name = 'كورفت - SbltWindow 63', price = 155000, level = 23, category = '6' },
			
			{ model = 'firebird', name = 'بونتياق - FireBird', price = 176000, level = 30, category = '6' },
			{ model = 'firebird77', name = 'بونتياق ترانزان - 1977', price = 150000, level = 35, category = '6' },
			{ model = 'impala672', name = 'شوفرليت امبالا - 1967', price = 710000, level = 35, category = '6' },
			{ model = 'gsxb', name = '1970م gsx بيوك', price = 120000, level = 33, category = '6' },
			{ model = 'impala96', name = 'شوفرليت امبالا - 1996', price = 90000, level = 15, category = '6' },
			{ model = 'mb300sl', name = 'مرسيدس - Sl300', price = 330000, level = 28, category = '6' },
			{ model = 'mercw126', name = ' مرسيدس بنز - SEL 560', price = 144000, level = 30, category = '6' },
			{ model = 'mustang68', name = 'موستنق - fastback 1968', price = 113000, level = 25, category = '6' },
			{ model = 'silver67', name = 'روز رايز - 1967', price = 316000, level = 27, category = '6' },
			{ model = 'towncar91', name = 'تاون لنكون - Town Lingcoln 1995', price = 64000, level = 15, category = '6' },
			{ model = 'trans69', name = 'بونتياق ترانزام - 1969', price = 112000, level = 28, category = '6' },
			{ model = 'vigero', name = 'تشالنجر 69 RT', price = 123000, level = 30, category = '6' },
			{ model = 'z2879', name = 'شوفرليت كمارو - z28', price = 118000, level = 20, category = '6' },
	
			{ model = '20denalihd', name = 'وانيت  دينالي قمارتين 3500 2020', price = 1000000, level = 40, category = '8' },
			{ model = 'bad250', name = '2020 فورد سوبر قمارتين مرفع', price = 950000, level = 40, category = '8' },
			{ model = 'bcal450', name = 'فوررد اف-450 2019 - مرفع هيدروليك', price = 1300000, level = 40, category = '8' },
			{ model = 'silv2500hd', name = 'شيفروليه سلفرادو 2500 2020', price = 1200000, level = 43, category = '8' },
			{ model = 'transformer', name = '2020 F-250 فورد قمارتين ديزل', price = 1200000, level = 40, category = '8' },
			{ model = 'denali18', name = 'جمس سيرا دينالي 1500 2018', price = 800000, level = 30, category = '8' },
			{ model = 'g63amg6x6', name = 'مرسيدس - AMG 6x6', price = 3000000, level = 70, category = '8' },

	
			{ model = '20f250', name = 'فورد وانيت - 2020', price = 900000, level = 20, category = '9' },
			--{ model = 'sierra06', name = 'سييرا 2006م ', price = 720000, level = 30, category = '9' },مزاد
			{ model = 'nissantitan17', name = 'نيسان تايتن 17م ', price = 750000, level = 20, category = '9' },
			{ model = 'bcss', name = '2021 سوبر سنيك F-150 فورد', price = 1000000, level = 20, category = '9' },
			{ model = 'sierra88', name = 'جمس سيرا قمارة 1500 1988', price = 850000, level = 20, category = '9' },
			{ model = 'sadler', name = 'وانيت فورد أف-350', price = 1600000, level = 20, category = '9' },
			{ model = 'f150', name = 'وانيت فورد رابتر أف-150', price = 600000, level = 20, category = '9' },
			{ model = 'silv2500hd', name = 'شيفروليه سلفرادو 2500 2020', price = 700000, level = 20, category = '9' },

			{ model = 'toyotahilux', name = 'وانيت هيلوكس 2015 - يحمل عليه القلص ', price = 150000, level = 15, category = '10' },
			{ model = '2020silv', name = 'وانيت سلفرادو قمارتين 1500 2020 - مرفع ', price = 150000, level = 15, category = '10' },
			{ model = 'silv86', name = 'شيفروليه سلفرادو - 1965  ', price = 150000, level = 15, category = '10' },
			{ model = 'landv6', name = 'تيوتا لاند كروزر شاص ', price = 150000, level = 15, category = '10' },
			{ model = 'gmcs', name = 'وانيت جمس سييرا 2017 ', price = 150000, level = 15, category = '10' },

			{ model = 'nissanditsun', name = 'ددسن 1985', price = 100000, level = 5, category = '11' },
			{ model = 'h3', name = 'هـمـر H2 وانيت', price = 100000, level = 5, category = '11' },
			{ model = 'vwcaddy', name = 'فلكس واجن', price = 80000, level = 5, category = '11' },
			{ model = 'c10', name = '1965 C10 شيفروليه', price = 80000, level = 5, category = '11' },
			{ model = 'czr2', name = '2020 ZR2 شيفروليه كولورادو', price = 120000, level = 10, category = '11' },			
			{ model = 'amarok', name = '2020 فولكس واجن اماروك', price = 120000, level = 5, category = '11' },	

			{ model = 'youga', name = 'فان فولكس واجين كرافتر', price = 600000, level = 30, category = '12' },
			{ model = 'speedo', name = 'فان فيتو', price = 600000, level = 30, category = '12' },
			{ model = 'e15082', name = 'فان فورد كلاسيك', price = 600000, level = 30, category = '12' },
			{ model = 'Burrito', name = 'فان نقل بضائع', price = 600000, level = 30, category = '12' },
			{ model = 'speedo5', name = 'فان نقل - صندوق', price = 900000, level = 30, category = '12' },
			{ model = 'moonbeam', name = 'فان نقل بضائع', price = 500000, level = 30, category = '12' },

		},
	},
}

Config.VehicleExperience ={
    ["10ram"] = 30,
    ["13fmb302"] = 30, 
    ["16challenger"] = 40, 
    ["16charger2"] = 50,
    ["16ss"] = 40,
    ["18f350d"] = 35,
    ["19dbs"] = 35,
    ["19tundra"] = 35,
    ["2013rs7"] = 20,
    ["20denalihd"] = 35,
    ["20f250"] = 25,
    ["20r1"] = 20,
    ["560sec87"] = 25,
    ["650s"] = 60,
    ["745le"] = 50,
    ["750il"] = 20,
    ["a6"] = 60,
    ["aeroxdrag"] = 15,
    ["aeroxr"] = 5,
    ["amggt63s"] = 60,
    ["avalon"] = 30,
    ["aventadors"] = 65,
    ["bbentayga"] = 45,
    ["bcps"] = 100,
    ["ben17"] = 70,
    ["Benz300SEL"] = 25,
    ["benzs600"] = 25,
    ["bfs14"] = 60,
    ["binkshf"] = 70,
    ["bmm"] = 70,
    ["bmwx6"] = 40,
    ["boss302"] = 40,
    ["c7"] = 30,
    ["c8"] = 60,
    ["c8r"] = 75,
    ["camaro68"] = 20,
    ["camaro69"] = 30,
    ["Camry11"] = 20,
    ["caprice13"] = 25,
    ["caprice17"] = 50,
    ["caprice91"] = 20,
    ["caprice93"] = 25,
    ["caprs"] = 10,
    ["casco"] = 20,
    ["chall70"] = 35,
    ["charger69"] = 35,
    ["cherokee1"] = 20,
    ["cls63s"] = 20,
    ["corvette63"] = 50,
    ["ct5v"] = 50,
    ["ctsv16"] = 45,
    ["cullinan"] = 80,
    ["czr2"] = 5,
    ["dawnonyx"] = 80,
    ["ddsn15"] = 10,
    ["demon"] = 60,
    ["dtd_c63s"] = 20,
    ["expmax20"] = 25,
    ["f40"] = 70,
    ["f430s"] = 65,
    ["firebird"] = 5,
    ["firebird77"] = 60,
    ["flhxs_streetglide_special18"] = 10,
    ["furoregt"] = 20,
    ["fxxkevo"] = 60,
    ["g5004x4"] = 50,
    ["g632019"] = 40,
    ["g63amg6x6"] = 50,
    ["g65amg"] = 30,
    ["gclass"] = 30,
    ["gcm992gt3"] = 45,
    ["gcm992targa"] = 35,
    ["gcmaccent15"] = 5,
    ["gcmelantra19"] = 20,
    ["gcmpassat12"] = 15,
    ["genesisg90"] = 65,
    ["ghostewb1"] = 90,
    ["gmc9080"] = 20,
    ["gmcat42"] = 35,
    ["gmcr20120"] = 40,
    ["gmcyd"] = 20,
    ["goldwing"] = 10,
    ["granger"] = 15,
    ["gsxb"] = 20,
    ["gtr"] = 20,
    ["hakuchou2"] = 15,
    ["hayabusa"] = 20,
    ["hdd"] = 20,
    ["hilux1"] = 1,
    ["ie"] = 75,
    ["impala672"] = 25,
    ["impala96"] = 30,
    ["jeep2012"] = 15,
    ["landv62"] = 25,
    ["ldsv"] = 75,
    ["lex350"] = 30,
    ["lex500"] = 30,
    ["lex570"] = 40,
    ["lex57015"] = 25,
    ["lxs"] = 30,
    ["lxs_2019"] = 35,
    ["m3e46"] = 30,
    ["m3f80"] = 20,
    ["mach1"] = 40,
    ["mb300sl"] = 50,
    ["mbc63"] = 50,
    ["mcgt20"] = 60,
    ["mercw126"] = 20,
    ["mustang19"] = 65,
    ["mustang68"] = 30,
    ["nightblade"] = 15,
    ["ninjah2"] = 35,
    ["optima"] = 20,
    ["panamera17turbo"] = 45,
    ["q820"] = 25,
    ["qx80"] = 30,
    ["r820"] = 30,
    ["rb3_2006"] = 5,
    ["rb3_2017"] = 15,
    ["rmodbmwi8"] = 55,
    ["rmodpagani"] = 60,
    ["rmz85cc"] = 5,
    ["rrst"] = 45,
    ["s500w222"] = 50,
    ["s600w220"] = 10,
    ["S63W222"] = 35,
    ["sanchez2"] = 10,
    ["sierra88"] = 10,
    ["silv1560"] = 15,
    ["silv2080"] = 25,
    ["silv5860"] = 15,
    ["silv6580"] = 20,
    ["silv86"] = 20,
    ["silver67"] = 15,
    ["silvr20120"] = 40,
    ["sonata20"] = 25,
    ["soso18"] = 30,
    ["subn"] = 15,
    ["supra2"] = 35,
    ["taho89"] = 5,
    ["tahoe"] = 10,
    ["tahoe21"] = 20,
    ["tmax"] = 20,
    ["towncar2010"] = 20,
    ["towncar91"] = 15,
    ["trans69"] = 30,
    ["type262"] = 1,
    ["vigero"] = 35,
    ["vxr_2020"] = 30,
    ["w463a"] = 65,
    ["wraithb"] = 85,
    ["z2879"] = 65,
    ["zn20"] = 50,
}

Config.VehiclePositions = {
    {
        ["x"] = 639.36, 
        ["y"] = 635.78, 
        ["z"] = 128.72, 
        ["h"] = 251.88
    },

    {
        ["x"] = 638.5, 
        ["y"] = 632.22, 
        ["z"] = 128.35, 
        ["h"] = 251.99
    },

    {
        ["x"] = 637.15, 
        ["y"] = 629.07, 
        ["z"] = 128.03, 
        ["h"] = 251.75
    },

    {
        ["x"] = 636.04, 
        ["y"] = 625.7, 
        ["z"] = 128.37, 
        ["h"] = 249.66
    },

    {
        ["x"] = 634.84, 
        ["y"] = 622.43, 
        ["z"] = 128.37, 
        ["h"] = 251.21
    },
	
    {
        ["x"] = 633.44, 
        ["y"] = 619.03, 
        ["z"] = 128.37, 
        ["h"] = 250.54
    },	
	
    {
        ["x"] = 632.23, 
        ["y"] = 615.86, 
        ["z"] = 128.37, 
        ["h"] = 251.37
    },

    {
        ["x"] = 631.15, 
        ["y"] = 612.45, 
        ["z"] = 128.37, 
        ["h"] = 250.11
    },	

    {
        ["x"] = 630.0, 
        ["y"] = 609.18, 
        ["z"] = 128.37, 
        ["h"] = 250.66
    },	

    {
        ["x"] = 628.89, 
        ["y"] = 605.83, 
        ["z"] = 128.37, 
        ["h"] = 251.12
    },

    {
        ["x"] = 648.18, 
        ["y"] = 632.45, 
        ["z"] = 128.37, 
        ["h"] = 70.55
    },

    {
        ["x"] = 646.59, 
        ["y"] = 629.24, 
        ["z"] = 128.37, 
        ["h"] = 68.59
    },

    {
        ["x"] = 645.88, 
        ["y"] = 625.95, 
        ["z"] = 128.37, 
        ["h"] = 70.12
    },

    {
        ["x"] = 644.85, 
        ["y"] = 622.61, 
        ["z"] = 128.37, 
        ["h"] = 70.99
    },

    {
        ["x"] = 643.2309,
        ["y"] = 619.3602, 
        ["z"] = 128.5499, 
        ["h"] = 70.1
    },
    {
        ["x"] = 642.1355,
        ["y"] = 615.9948, 
        ["z"] = 128.5501, 
        ["h"] = 70.1
    },
    {
        ["x"] = 640.9974,
        ["y"] = 612.7062, 
        ["z"] = 128.5500, 
        ["h"] = 70.1
    },
    {
        ["x"] = 639.7239,
        ["y"] = 609.3239, 
        ["z"] = 128.5499, 
        ["h"] = 70.1
    },
    {
        ["x"] = 638.7468,
        ["y"] = 606.0288, 
        ["z"] = 128.550, 
        ["h"] = 70.1
    },
    {
        ["x"] = 637.4659,
        ["y"] = 602.764, 
        ["z"] = 128.550, 
        ["h"] = 70.1
    },
    {
        ["x"] = 613.8895,
        ["y"] = 611.3858, 
        ["z"] = 128.302, 
        ["h"] = 70.0
    },
	{
        ["x"] = 615.2949,
        ["y"] = 614.598, 
        ["z"] = 128.3038, 
        ["h"] = 70.0
    },
	{
        ["x"] = 616.3694,
        ["y"] = 617.9, 
        ["z"] = 128.30, 
        ["h"] = 70.0
    },
	{
        ["x"] = 617.7957,
        ["y"] = 621.1454, 
        ["z"] = 128.304, 
        ["h"] = 70.0
    },
	{
        ["x"] = 619.0154,
        ["y"] = 624.3810, 
        ["z"] = 128.3038, 
        ["h"] = 70.0
    },
	{
        ["x"] = 620.0061,
        ["y"] = 627.866, 
        ["z"] = 128.303, 
        ["h"] = 70.0
    },
	{
        ["x"] = 621.2046,
        ["y"] = 631.1935, 
        ["z"] = 128.304, 
        ["h"] = 70.0
    },
	{
        ["x"] = 622.4628,
        ["y"] = 634.3196, 
        ["z"] = 128.3040, 
        ["h"] = 70.0
    },
	{
        ["x"] = 623.8847,
        ["y"] = 637.6929, 
        ["z"] = 128.304, 
        ["h"] = 70.0
    },
	{
        ["x"] = 614.9324,
        ["y"] = 640.762, 
        ["z"] = 128.304, 
        ["h"] = 250.0
    },
	{
        ["x"] = 613.5143,
        ["y"] = 637.6305, 
        ["z"] = 128.304, 
        ["h"] = 250.0
    },
	{
        ["x"] = 612.3127,
        ["y"] = 634.3030, 
        ["z"] = 128.304, 
        ["h"] = 250.0
    },
	{
        ["x"] = 610.8863,
        ["y"] = 631.1074, 
        ["z"] = 128.304, 
        ["h"] = 250.0
    },
	{
        ["x"] = 610.0948,
        ["y"] = 627.69, 
        ["z"] = 128.304, 
        ["h"] = 250.0
    },
	{
        ["x"] = 608.8491,
        ["y"] = 624.445, 
        ["z"] = 128.304, 
        ["h"] = 250.0
    },
	{
        ["x"] = 607.6419,
        ["y"] = 621.0914, 
        ["z"] = 128.304, 
        ["h"] = 250.0
    },
	{
        ["x"] = 606.2867,
        ["y"] = 617.8625, 
        ["z"] = 128.304, 
        ["h"] = 250.0
    },
	{
        ["x"] = 605.1954,
        ["y"] = 614.710, 
        ["z"] = 128.304, 
        ["h"] = 250.0
    }
	
}
