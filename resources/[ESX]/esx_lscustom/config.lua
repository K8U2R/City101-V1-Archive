Config                   = {}
Config.DrawDistance      = 100.0
Config.Locale            = 'en'
Config.IsMechanicJobOnly = true

Config.Upgradesxp = 20 -- يعني كل مستوى من تعديلات المكينة وغيرها يعطيك 25 مثلا مكينة مستوى 1 تعطيك 25 إكس بي مكينة لفل 2 تعطيك 50 
Config.Turboxp = 25 -- الإكس بي الي يجي من تعديل التربو
Config.Wheelsxp = 10 -- الإكس بي الي يجي من تركيب عجلات
Config.Otherxp = 10 -- باقي التعديلات

Config.buyMod_DiscordLog = "https://discord.com/api/webhooks/1219051852172099725/baoYZpesT-wT2Qqmz9HMtrOqAomYYdAEtD38im5nmYYvEaRQSzJiukQ3G0DeqInCBPrE" -- لوق تعديل مركبة ميكانيكي

Config.VehiclesShop = {
	{ model = 'bmwx6', name = 'بي ام دبليو', price = 1300000, level = 45, category = '2' },
	{ model = 'expmax20', name = 'فورد اكسبدشن - 2020', price = 650000, level = 25, category = '2' },
	{ model = 'cherokee1', name = 'جيب شيروكي 1984', price = 54000, level = 25, category = '2' },
	{ model = 'g5004x4', name = 'مرسيدس جي كلاس اوف رود - 2019 ', price = 1950000, level = 50, category = '2' },
	{ model = 'g632019', name = 'مرسيدس جي كلاس - 2019', price = 1750000, level = 45, category = '2' },
	{ model = 'g65amg', name = 'مرسيدس جي كلاس - 2013', price = 100, level = 40, category = '2' },
	{ model = 'gclass', name = 'مرسيدس جي كلاس - اوف رود', price = 1750000, level = 45, category = '2' },
	{ model = 'gmcyd', name = 'جمس يوكن دينالي 2015', price = 750000, level = 30, category = '2' },
	{ model = 'granger', name = 'جيمس يوكن أكس-ألـ 2003', price = 180000, level = 22, category = '2' },
	{ model = 'jeep2012', name = 'جيب رانجلر 2012', price = 450000, level = 25, category = '2' },
	{ model = 'lex570', name = 'لكزس أل-أكس-570', price = 2000000, level = 50, category = '2' },
	{ model = 'q820', name = 'اودي - Q8 2020', price = 950000, level = 40, category = '2' },
	{ model = 'qx80', name = 'انفنتي - 2019', price = 799999, level = 30, category = '2' },
	{ model = 'rb3_2006', name = 'لاند كروزر ربع - 2006', price = 380000, level = 20, category = '2' },
	{ model = 'rb3_2017', name = 'لاند كروزر ربع - 2017', price = 550000, level = 25, category = '2' },
	{ model = 'rrst', name = 'رنج روفر فوج 2020', price = 5000000, level = 50, category = '2' },
	{ model = 'subn', name = 'شيفرولية سوبربان - 2010', price = 80000, level = 10, category = '2' },
	{ model = 'taho89', name = 'شيفرولية سوبربان - 1989', price = 80000, level = 5, category = '2' },
	{ model = 'tahoe', name = 'شيفرولية تاهو 2013', price = 450000, level = 20, category = '2' },
	{ model = 'tahoe21', name = 'شيفرولية تاهو - 2021', price = 650000, level = 25, category = '2' },
	
--			{ model = 'bcfabjeep', name = 'جيب رانجلر معدلة ', price = 520000, level = 30, category = '2' },

	{ model = '16challenger', name = ' دوج تشالنجر - 2016 ', price = 650000, level = 20, category = '3' },
	{ model = '16charger2', name = 'دوج تشارجر - SRT', price = 520000, level = 25, category = '3' },
	{ model = '16ss', name = ' كمارو SS 2017', price = 950000, level = 30, category = '3' },
	{ model = '19dbs', name = 'استون مارتن', price = 100, level = 40, category = '3' },
	{ model = '2013rs7', name = 'اودي - rs7 2013', price = 800000, level = 30, category = '3' },
	{ model = 'a6', name = 'اودي a6 - 2019', price = 850000, level = 35, category = '3' },
	{ model = 'amggt63s', name = 'مرسيدس amg63', price = 2200000, level = 50, category = '3' },
	{ model = 'c8', name = 'كورفيت سي-8 2020', price = 000, level = 60, category = '4' },
	{ model = 'cls63s', name = 'مرسيدس - s63', price = 180000, level = 45, category = '3' },
	--{ model = 'ctsv16', name = 'كديلاك - 16', price = 1350000, level = 40, category = '3' },
	--{ model = 'rmode63s', name = '2019 برابس E63S مرسيدس', price = 3850000, level = 50, category = '3' },
	{ model = 'e63b', name = '2014 برابس E63 مرسيدس', price = 2000000, level = 40, category = '3' },
	{ model = 'c7z06', name = 'كورفيت C7 ZO6', price = 2000000, level = 50, category = '3' },
	{ model = 'gamea45', name = 'مرسيدس A45 AMG ', price = 1400000, level = 25, category = '3' },
	{ model = 'caprice89', name = 'كابرس 1985', price = 10, level = 5, category = '6' },
	
	
	
	{ model = 'gcm992targa', name = 'بورش نسخة كلاسك - 911', price = 1650000, level = 40, category = '3' },
	{ model = 'gtr', name = 'GTR 35 - جيتي ار', price = 550000, level = 25, category = '3' },
	{ model = 'm3e30', name = 'بي ام ام ثري - Bmw m3', price = 430000, level = 22, category = '3' },
	{ model = 'm3e46', name = 'بي ام دبليو M3 e46 2005', price = 999000, level = 37, category = '3' },
	{ model = 'm3f80', name = 'بي ام - M3 2015', price = 1200000, level = 30, category = '3' },
	{ model = 'mach1', name = 'موستنق ماتش - 2018', price = 1100000, level = 25, category = '3' },
	
	{ model = 'macr820h1', name = 'موستنق ماتش - 2018', price = 1100000, level = 25, category = '3' },
	{ model = 'r820', name = 'أودي R8', price = 650000, level = 25, category = '3' },
	{ model = 'S63W222', name = 'مرسيدس أس-63 2014', price = 750000, level = 21, category = '3' },
	
	{ model = 'zn20', name = 'زينفو srs - 2020', price = 2800000, level = 65, category = '4' },
	{ model = 'mansc8', name = 'كورفت c8', price = 3500000, level = 15, category = '3' },
	{ model = 'czr1', name = 'كورفت zr1', price = 1300000, level = 35, category = '3' }, 
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
	{ model = 'demon', name = 'دوج ديمون', price = 999999, level = 40, category = '3' },
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

	{ model = '650s', name = 'ماكلارين 650 اس اصدار خاص', price = 5500000, level = 90, category = '4' },
	--{ model = 'aventadors', name = 'لمبرجيني  افنتدور', price = 4100000, level = 70, category = '4' },
	
	{ model = 'c8r', name = '2020 اصدار  حلبة سباق C8 شيفروليه كورفت', price = 3800000, level = 75, category = '4' },
	{ model = 'f430s', name = 'فيراري اف-430-اس سكودريا', price = 3300000, level = 70, category = '4' },
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
	{ model = 'ie', name = 'أبولو إنتنزا إموزيوني', price = 5000000, level = 90, category = '4' },
	--{ model = 'mcgt20', name = '2020 ماكلارين جي تي', price = 4500000, level = 85, category = '4' },
	--{ model = 'rmodpagani', name = 'باقاني هيارا رودستر 2018', price = 3800000, level = 65, category = '4' },
	{ model = 's650', name = 'ماكلارين حلبات اصدار خاص', price = 3200000, level = 70, category = '4' },

	{ model = 'ben17', name = ' بنتلي سبورت - 2017', price = 9000000, level = 70, category = '5' },		
	{ model = 'rrphantom', name = 'رولز رايز فانتوم 2018', price = 9000000, level = 70, category = '5' },	

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
	{ model = 'ldsv', name = '1995 لامبورجيني ديابلو اس في', price = 2800000, level = 70, category = '4' },
	{ model = 'mb300sl', name = 'مرسيدس - Sl300', price = 330000, level = 28, category = '6' },
	{ model = 'mercw126', name = ' مرسيدس بنز - SEL 560', price = 144000, level = 30, category = '6' },
	{ model = 'mustang68', name = 'موستنق - fastback 1968', price = 113000, level = 25, category = '6' },
	{ model = 'silver67', name = 'روز رايز - 1967', price = 316000, level = 27, category = '6' },
	{ model = 'towncar91', name = 'تاون لنكون - Town Lingcoln 1995', price = 64000, level = 15, category = '6' },
	{ model = 'trans69', name = 'بونتياق ترانزام - 1969', price = 112000, level = 28, category = '6' },
	{ model = 'vigero', name = 'تشالنجر 69 RT', price = 123000, level = 30, category = '6' },
	{ model = 'z2879', name = 'شوفرليت كمارو - z28', price = 118000, level = 20, category = '6' },

	

	{ model = '10ram', name = 'ونيت دودج رام 3500 2010 - يحمل مقطورة ابو رقبة', price = 1500000, level = 45, category = '8' },
	{ model = '18f350d', name = 'وانيت فورد اف-350 2019 - يحمل مقطورة ابو رقبة', price = 850000, level = 50, category = '8' },
	{ model = '19tundra', name = 'تيوتا تندرا غمارتين 2020', price = 800000, level = 49, category = '8' },
--	{ model = '20denalihd', name = 'وانيت  دينالي غمارتين - سحب مقطورة ', price = 900000, level = 65, category = '8' },
	{ model = 'gmcat42', name = 'غمارتين 1500 2020 AT4 جمس سيرا', price = 999000, level = 45, category = '8' },
	{ model = 'gmcr20120', name = 'وانيت  دينالي غمارتين', price = 816000, level = 54, category = '8' },
	

	{ model = 'aborgbh', name = 'فورد350 ابورقبه ', price = 1100000, level = 42, category = '8' },
	{ model = '20denalihd', name = 'جمس دينالي HD ', price = 1200000, level = 40, category = '8' },
	{ model = 'bad250', name = 'فوردf250  ', price = 1300000, level = 46, category = '8' },
	--------------{ model = 'bc20kodiak', name = 'شاحنة شفر  RR ابورقبه ', price = 1600000, level = 45, category = '10' }, ما ترسبن
	{ model = 'bcal450', name = 'فورد فيول ', price = 1300000, level = 45, category = '8' },
	{ model = 'silv2500hd', name = 'سلفرادو z71 ', price = 1200000, level = 43, category = '8' },
	--------------------------------{ model = 'ram10', name = 'ونيت دودج رام 2010 ', price = 1200000, level = 35, category = '10' },
	--------------------------------{{ model = 'sprinter211', name = 'فان مرسيدس سبرينتر ', price = 890000, level = 25, category = '10' },
	{ model = 'e15082', name = 'فان فورد كلاسيك ', price = 1100000, level = 42, category = '8' },
	{ model = 'youga', name = 'فان فولكس واجين كرافتر ', price = 1300000, level = 40, category = '8' },
	{ model = 'transformer', name = 'فورد سوبر ديوتي ', price = 1200000, level = 41, category = '8' },
	{ model = 'speedo', name = 'فان فيتو ', price = 700000, level = 43, category = '8' },
	------------{ model = 'f350d18', name = 'وانيت فورد اف-350 2019', price = 1390000, level = 40, category = '10' },
	{ model = 'g63amg6x6', name = 'مرسيدس - AMG 6x6', price = 1600000, level = 45, category = '8' },
	{ model = 'silvr20120', name = 'وانيت سلفرادو غمارتين ', price = 1300000, level = 40, category = '8' },
	{ model = 'type262', name = 'فولكس فاجن فان - 1962', price = 1200000, level = 43, category = '8' },

	{ model = '20f250', name = 'فورد وانيت - 2020', price = 350000, level = 30, category = '9' },
	{ model = 'gmc9080', name = 'جمس سيرا - GMC 1990', price = 450000, level = 35, category = '9' },
	{ model = 'sierra06', name = 'سييرا 2006م ', price = 720000, level = 30, category = '9' },
	{ model = 'denali18', name = 'دينالي 2018م ', price = 800000, level = 33, category = '9' },
	-------------{ model = 'sdgmc', name = 'دينالي غمارتين 2021م ', price = 8900000, level = 25, category = '11' },
	{ model = 'nissantitan17', name = 'نيسان تايتن 17م ', price = 750000, level = 30, category = '9' },
	{ model = 'landv62', name = 'تيوتا لاند كروزر شاص', price = 350000, level = 39, category = '9' },
	{ model = 'silv2080', name = 'وانيت شيفرولية سيلفرادو ', price = 350000, level = 30, category = '9' },
	{ model = 'silv6580', name = 'سييرا 2006م ', price = 00, level = 30, category = '9' },
	{ model = 'silv86', name = 'شيفروليه سلفرادو - 1965  ', price = 200000, level = 40, category = '9' },

	--{ model = 'h2010', name = 'هايلوكس 2010م ', price = 260000, level = 12, category = '10' },
	{ model = 'ddsn15', name = 'نيسان ددسن 2015', price = 92000, level = 15, category = '10' },
	{ model = 'toyotahilux', name = 'وانيت هيلوكس 2015 - يحمل عليه القلص ', price = 130000, level = 15, category = '10' },
	--{ model = 'nissantitan17', name = 'نيسان تيتان 2017 - يحمل عليه القلص ', price = 260000, level = 25, category = '10' },
	{ model = '20f250', name = 'وانيت فورد اف-250 2020 - يحمل عليه القلص ', price = 150000, level = 25, category = '10' },
	{ model = 'silv1560', name = 'سلفرادو 2015م ', price = 144000, level = 20, category = '10' },
	{ model = 'silv5860', name = 'شيفروليه سلفرادو - 1958 ', price = 105000, level = 20, category = '10' },
	{ model = 'nissanditsun', name = 'ددسن 1985', price = 100000, level = 5, category = '11' },
	{ model = 'vwcaddy', name = 'فلكس واجن', price = 80000, level = 15, category = '11' },
	{ model = 'czr2', name = '2020 ZR2 شيفروليه كولورادو', price = 72000, level = 10, category = '11' },
	{ model = 'hilux1', name = 'هايلوكس عمل - 2010', price = 100000, level = 10, category = '11' },
	
	{ model = 'Burrito', name = 'ددسن بيك اب 1972 ', price = 100000, level = 5, category = '11' },

	--{ model = 'Burrito', name = 'هايلوكس عمل - 2010', price = 100000, level = 10, category = '11' },
	{ name = 'فورد بوليسي شامل ', model = 'doreat1', price = 25000, level = 1, category = '6', grade = {"sergeant", "recruit", "officer", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'ربع شامل', model = 'shrqpolice2', price = 25000, level = 1, category = '6', grade = {"sergeant", "recruit", "officer", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'تاهو شامل', model = 'shrqpolice3', price = 25000, level = 1, category = '6', grade = {"mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'فورد شامل 1', model = 'shrqpolice4', price = 25000, level = 1, category = '6', grade = {"sergeant", "recruit", "officer", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'تورس شامل', model = 'shrqpolice5', price = 25000, level = 1, category = '6', grade = {"sergeant", "recruit", "officer", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'اكسبلور شامل', model = 'shrqpolice6', price = 25000, level = 1, category = '6', grade = {"sergeant", "recruit", "officer", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'لاند شامل', model = 'shrqpolice7', price = 25000, level = 1, category = '6', grade = {"mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'اف جي شامل', model = 'shrqpolice8', price = 25000, level = 1, category = '6', grade = {"sergeant", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'ربع الامن العام', model = 'doreat8', price = 25000, level = 1, category = '1', grade = {"sergeant", "recruit", "officer", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'اف جي الامن العام', model = 'doreat9', price = 25000, level = 1, category = '1', grade = {"sergeant", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'تورس الامن العام ', model = 'doreat3', price = 25000, level = 1, category = '1', grade = {"sergeant", "recruit", "officer", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'تاهو الامن العام ', model = 'doreat4', price = 25000, level = 1, category = '1', grade = {"mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'دوج درانقو الامن العام ', model = 'doreat10', price = 25000, level = 1, category = '1', grade = {"inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'باص الأمن العام', model = 'pbus', price =  25000, level =  1, category = '1', grade = {"mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss",} },
	{ name = 'دوج تشارجر شامل 1', model = 'doreat7', price = 25000, level = 1, category = '1', grade = {"mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'فورد شامل 2', model = 'cv1', price = 25000, level = 1, category = '6', grade = {"sergeant", "recruit", "officer", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'كامري 11 امن المحافظات', model = 'azr815', price = 25000, level = 1, category = '1', grade = {"sergeant", "recruit", "officer", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'كامري 11 المرور', model = 'mror16', price = 25000, level = 1, category = '2', grade = {"sergeant", "recruit", "officer", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'كامري 11 الامن العام', model = 'doreat15', price = 25000, level = 1, category = '1', grade = {"sergeant", "recruit", "officer", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'فورد المرور' , model = 'cv2', price = 25000, level = 1, category = '2', grade = {"sergeant", "recruit", "officer", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'فورد المهمات و الواجبات الخاصة' , model = 'cv3', price = 25000, level = 1, category = '1', grade = {"sergeant", "recruit", "officer", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'فورد امن المحافظات' , model = 'cv4', price = 25000, level = 1, category = '1', grade = {"sergeant", "recruit", "officer", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'فورد الامن العام' , model = 'cv5', price = 25000, level = 1, category = '1', grade = {"sergeant", "recruit", "officer", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'فورد الامن العام' , model = 'cv5', price = 25000, level = 1, category = '1', grade = {"sergeant", "recruit", "officer", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'دوج تشارجر شامل 2' , model = 'dg1', price = 25000, level = 1, category = '6', grade = {"mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'دوج تشارجر امن المحافظات' , model = 'dg2', price = 25000, level = 1, category = '1', grade = {"mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'دوج تشارجر حرس الحدود و المهمات و الواجبات الخاصة' , model = 'dg3', price = 25000, level = 1, category = '1', grade = {"mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'دوج تشارجر شامل 3' , model = 'dodgedoreat', price = 25000, level = 1, category = '6', grade = {"mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'دوج تشارجر المرور' , model = 'dodgemror', price = 25000, level = 1, category = '2', grade = {"mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'لاند امن الطرق' , model = 'amn6r814', price = 25000, level = 1, category = '4', grade = {"mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'لاند المهمات و الواجبات الخاصة' , model = 'amnmhmat14', price = 25000, level = 1, category = '1', grade = {"mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'لاند امن المحافظات' , model = 'azr814', price = 25000, level = 1, category = '1', grade = {"mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'لاند الامن العام' , model = 'doreat14', price = 25000, level = 1, category = '1', grade = {"mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'لاند المرور' , model = 'mror15', price = 25000, level = 1, category = '2', grade = {"mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'مرسيدس امن الطرق' , model = 'amn6r813', price = 25000, level = 1, category = '4', grade = {"mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'مرسيدس المهمات و الواجبات الخاصة' , model = 'amnmhmat13', price = 25000, level = 1, category = '1', grade = {"mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'مرسيدس الامن العام' , model = 'doreat13', price = 25000, level = 1, category = '1', grade = {"mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'مرسيدس المرور' , model = 'mror14', price = 25000, level = 1, category = '2', grade = {"mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'كامري 11 المهمات و الواجبات الخاصة' , model = 'amnmhmat15', price = 25000, level = 1, category = '1', grade = {"sergeant", "recruit", "officer", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'كامري 2020 سري' , model = 'camrypolice', price = 25000, level = 1, category = '7', grade = {"sergeant", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'كامري 2013 سري' , model = 'camrysre2013', price = 25000, level = 1, category = '7', grade = {"sergeant", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'كورولا سري' , model = 'corollapolice', price = 25000, level = 1, category = '7', grade = {"sergeant", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'كابرس سري' , model = 'caprice1', price = 25000, level = 1, category = '7', grade = {"sergeant", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'فورد سري' , model = 'ford1', price = 25000, level = 1, category = '7', grade = {"sergeant", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss", "m8dmrkn", "akedrkn", "amedrkn", "lwarkn", "fre8rkn", "fre8awlrkn"} },
	{ name = 'اف جي سري', model = 'fjsre', price = 25000, level = 1, category = '7', grade = {"sergeant", "recruit", "officer", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss",} },
	{ name = 'هيلكس سري', model = 'hilux99sre', price = 25000, level = 1, category = '7', grade = {"sergeant", "recruit", "officer", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss",} },
	{ name = 'دوج سري', model = 'dodgesry', price = 25000, level = 1, category = '7', grade = {"sergeant", "recruit", "officer", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss",} },
	{ name = 'ربع سري', model = 'rb3police', price = 25000, level = 1, category = '7', grade = {"sergeant", "recruit", "officer", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss",} },
	{ name = 'تاهو السري', model = 'tahoepolice', price = 25000, level = 1, category = '7', grade = {"sergeant", "recruit", "officer", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss",} },
	{ name = 'باترول', model = 'patrolpolice', price = 25000, level = 1, category = '7', grade = {"sergeant", "recruit", "officer", "intendent","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss",} },
	{ name = 'لاند كروزر سري', model = 'tsry', price = 25000, level = 1, category = '7', grade = {"sergeant", "intendent", "recruit", "officer","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss",} },
	{ name = 'ربع الشرطة العسكرية', model = 'sk1', price = 25000, level = 1, category = '8', grade = {"sergeant", "intendent", "recruit", "officer","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss",} },
	{ name = 'تاهو الشرطة العسكرية', model = 'sk2', price = 25000, level = 1, category = '8', grade = {"sergeant", "intendent", "recruit", "officer","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss",} },
	{ name = 'تورس الشرطة العسكرية', model = 'sk3', price = 25000, level = 1, category = '8', grade = {"sergeant", "intendent", "recruit", "officer","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss",} },
	{ name = 'فورد فكتوريا بوليسي الشرطة العسكرية', model = 'sk4', price = 25000, level = 1, category = '8', grade = {"sergeant", "intendent", "recruit", "officer","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss",} },
	{ name = 'دوج تشارجر الشرطة العسكرية', model = 'sk5', price = 25000, level = 1, category = '8', grade = {"sergeant", "intendent", "recruit", "officer","lieutenant", "chef","inspector", "mola","captain", "deputy","sandy2", "fbi0","fbi1", "fbi2","agent","special", "supervisor","fbi3","fbi4", "fbi5","assistant", "sandy0","sandy02", "bosstwo","boss",} },
	{ name = 'فورد امن المنشات', model = 'sh2', price = 100000, level = 1, category = '1', grade={"recruit","officer","sergeant","intendent","lieutenant","chef","inspector","bigboss","sany","sany1","sany2","sany3","sany4","high","bosstwo","boss",} },
	{ name = 'اكسبلور امن المنشات', model = 'sh4', price = 150000, level = 1, category = '1', grade={"officer","sergeant","intendent","lieutenant","chef","inspector","bigboss","sany","sany1","sany2","sany3","sany4","high","bosstwo","boss",} },
	{ name = 'فورد تورس امن المنشات ', model = 'sh6', price = 350000, level = 1, category = '1', grade={"chef","inspector","bigboss","sany","sany1","sany2","sany3","sany4","high","bosstwo","boss",} },
	{ name = 'تاهو امن المنشات ', model = 'sh8', price = 450000, level = 1, category = '1', grade={"bigboss","sany","sany1","sany2","sany3","sany4","high","bosstwo","boss",} },
	{ name = 'يوكن امن المنشات ', model = 'sh10', price = 500000, level = 1, category = '1', grade={"sany","sany1","sany2","sany3","sany4","high","bosstwo","boss",} },
	{ name = 'كابرس امن المنشات', model = 'sh12', price = 600000, level = 1, category = '1', grade={"sany2","sany3","sany4","high","bosstwo","boss",} },
	{ name = 'تشارجر امن المنشات', model = 'sh14', price = 200000, level = 1, category = '1', grade={"officer","sergeant","intendent","lieutenant","chef","inspector","bigboss","sany","sany1","sany2","sany3","sany4","high","bosstwo","boss",} },
	{ name = 'ربع امن المنشات', model = 'sh16', price = 250000, level = 1, category = '1', grade={"officer","sergeant","intendent","lieutenant","chef","inspector","bigboss","sany","sany1","sany2","sany3","sany4","high","bosstwo","boss",} },
	{ name = 'اف جي امن المنشات', model = 'sh18', price = 950000, level = 1, category = '1', grade={"chef","inspector","bigboss","sany","sany1","sany2","sany3","sany4","high","bosstwo","boss",} },
	{ name = 'فان الدفاع المدني', model = 'hlal7', price = 25000, level = 1, category = '1',grade = {"ambulance", "doctor","chief_doctor", "chief","bigchef", "bigchef2","bigchef3", "bigchef4","bigchef5", "bigchef6","bigchef7", "bosstwo","boss"}},
	{ name = 'فان 2 الدفاع المدني', model = 'hlal8', price = 25000, level = 1, category = '1',grade = {"ambulance", "doctor","chief_doctor", "chief","bigchef", "bigchef2","bigchef3", "bigchef4","bigchef5", "bigchef6","bigchef7", "bosstwo","boss"}},
	{ name = 'دوج الدفاع المدني', model = 'hlal1', price = 25000, level = 1, category = '1', grade = {"chief","bigchef", "bigchef2","bigchef3", "bigchef4","bigchef5", "bigchef6","bigchef7", "bosstwo","boss"}},
	{ name = 'اف جي الدفاع المدني', model = 'hlal2', price = 25000, level = 1, category = '1', grade = {"chief","bigchef", "bigchef2","bigchef3", "bigchef4","bigchef5", "bigchef6","bigchef7", "bosstwo","boss"}},
	{ name = 'يوكن الدفاع المدني', model = 'hlal3', price = 25000, level = 1, category = '1', grade = {"chief","bigchef", "bigchef2","bigchef3", "bigchef4","bigchef5", "bigchef6","bigchef7", "bosstwo","boss"}},
	{ name = 'تاهو الدفاع المدني', model = 'hlal4', price = 25000, level = 1, category = '1', grade = {"chief","bigchef", "bigchef2","bigchef3", "bigchef4","bigchef5", "bigchef6","bigchef7", "bosstwo","boss"}},
	{ name = 'تورس الدفاع المدني', model = 'hlal5', price = 25000, level = 1, category = '1', grade = {"chief","bigchef", "bigchef2","bigchef3", "bigchef4","bigchef5", "bigchef6","bigchef7", "bosstwo","boss"}},
	{ name = 'تاهو 2014 الدفاع المدني', model = 'hlal6', price = 25000, level = 1, category = '1', grade = {"chief","bigchef", "bigchef2","bigchef3", "bigchef4","bigchef5", "bigchef6","bigchef7", "bosstwo","boss"}},
	{ name = 'تاهو 2014 الدفاع المدني', model = 'hlal6', price = 25000, level = 1, category = '1', grade = {"chief","bigchef", "bigchef2","bigchef3", "bigchef4","bigchef5", "bigchef6","bigchef7", "bosstwo","boss"}},
	{ name = 'ميكانيكي 1', model = 'njRATs67h', price = 25000, level = 1, category = '1', grade = {"mechanic0", "mechanic1", "mechanic2", "mechanic3", "mechanic4", "mechanic5", "mechanic6", "mechanic7", "mechanic8", "mechanic9", "mechanic10", "bosstwo","boss"} },
	{ name = 'ميكانيكي 2', model = 'c3f350rollback', price = 25000, level = 1, category = '1', grade = {"mechanic3", "mechanic4", "mechanic5", "mechanic6", "mechanic7", "mechanic8", "mechanic9", "mechanic10", "bosstwo","boss"} },
	{ name = 'ميكانيكي 3', model = 'c3navistar', price = 25000, level = 1, category = '1', grade = {"mechanic3", "mechanic4", "mechanic5", "mechanic6", "mechanic7", "mechanic8", "mechanic9", "mechanic10", "bosstwo","boss"} },
	{ name = 'ميكانيكي 4', model = 'c3pwrollback', price = 25000, level = 1, category = '1', grade = {"mechanic3", "mechanic4", "mechanic5", "mechanic6", "mechanic7", "mechanic8", "mechanic9", "mechanic10", "bosstwo","boss"} },
	{ name = 'ميكانيكي 5', model = 'c3rollback', price = 25000, level = 1, category = '1', grade = {"mechanic3", "mechanic4", "mechanic5", "mechanic6", "mechanic7", "mechanic8", "mechanic9", "mechanic10", "bosstwo","boss"} },
	{ name = 'ميكانيكي 6', model = 'c3silvrollback', price = 25000, level = 1, category = '1', grade = {"mechanic3", "mechanic4", "mechanic5", "mechanic6", "mechanic7", "mechanic8", "mechanic9", "mechanic10", "bosstwo","boss"} },
	{ name = 'ميكانيكي 7', model = 'c320silvwrecker', price = 25000, level = 1, category = '1', grade = {"mechanic3", "mechanic4", "mechanic5", "mechanic6", "mechanic7", "mechanic8", "mechanic9", "mechanic10", "bosstwo","boss"} },
	{ name = 'ميكانيكي 8', model = 'flatbed3', price = 25000, level = 1, category = '1', grade = {"mechanic3", "mechanic4", "mechanic5", "mechanic6", "mechanic7", "mechanic8", "mechanic9", "mechanic10", "bosstwo","boss"} },
	{ name = 'ميكانيكي 9', model = 'Gtow', price = 25000, level = 1, category = '1', grade = {"mechanic3", "mechanic4", "mechanic5", "mechanic6", "mechanic7", "mechanic8", "mechanic9", "mechanic10", "bosstwo","boss"} },
	{ name = 'شاحنة تزويد', model = 'tooltruck', price = 45000, level = 1, category = '1', grade = {"mechanic3", "mechanic4", "mechanic5", "mechanic6", "mechanic7", "mechanic8", "mechanic9", "mechanic10", "bosstwo","boss"} },
}

Config.Zones = {

	ls1 = { --- Los Santos
		Pos   = { x = -614.6699829101562, y = -1159.02001953125, z = 22.32999992370605},
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Name  = _U('blip_name'),
		Hint  = _U('press_custom')
	},

	ls3 = {  -- Sandy Shores
		Pos   = { x = -603.0700073242188, y = -1159.030029296875, z = 22.32999992370605},
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Name  = _U('blip_name'),
		Hint  = _U('press_custom')
	},

	ls3 = {  -- Sandy Shores
		Pos   = {x = 2231.55, y = 2919.53, z = 48.04},
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Name  = _U('blip_name'),
		Hint  = _U('press_custom')
	},
	
	ls3 = {  -- Sandy Shores
	Pos   = {	x = 2213.13, y = 2948.28, z = 48.04
},
	Size  = {x = 3.0, y = 3.0, z = 0.2},
	Color = {r = 204, g = 204, b = 0},
	Marker= 1,
	Name  = _U('blip_name'),
	Hint  = _U('press_custom')
},
	ls6 = {  -- Sandy Shores
		Pos   = { x = 2221.81, y = 2948.59, z = 48.04},
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Name  = _U('blip_name'),
		Hint  = _U('press_custom')
	},

	ls7 = {  -- Sandy Shores
		Pos   = { x = 2230.49, y = 2948.87, z = 48.04},
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Name  = _U('blip_name'),
		Hint  = _U('press_custom')
	},

	ls9 = {  -- شكل التزويد الي يطلع في الخريطة الي موجود عنكراج التعديل الي فبوليتو
		Pos   = {x = 67.8429, y = 6521.2666, z = 31.2560},
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Name  = _U('blip_name'),
		Hint  = _U('press_custom')
	},
	ls10 = {  -- شكل التزويد الي يطلع في الخريطة الي موجود عنكراج التعديل الي فبوليتو
		Pos   = { x = 63.2359, y = 6516.2114, z = 31.2561},
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Name  = _U('blip_name'),
		Hint  = _U('press_custom')
	},
	ls11 = {  -- شكل التزويد الي يطلع في الخريطة الي موجود عنكراج التعديل الي فبوليتو
		Pos   = { x = 58.1794, y = 6511.6387, z = 31.2562},
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Name  = _U('blip_name'),
		Hint  = _U('press_custom')
	},
	ls12 = { -- شكل التزويد الي يطلع في الخريطة الي موجود عنكراج التعديل الي فبوليتو
		Pos   = {x = 73.7959, y = 6504.3438, z = 31.2572},
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Name  = _U('blip_name'),
		Hint  = _U('press_custom')
	},
	ls13 = { -- شكل التزويد الي يطلع في الخريطة الي موجود عنكراج التعديل الي فبوليتو
		Pos   = {x = 78.5328, y = 6509.2178, z = 31.2553},
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Name  = _U('blip_name'),
		Hint  = _U('press_custom')
	},
	ls14 = {  -- شكل التزويد الي يطلع في الخريطة الي موجود عنكراج التعديل الي فساندي
		Pos   = {x = 2214.3071289063, y = 2920.0397949219, z = 48.113750457764},
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Name  = _U('blip_name'),
		Hint  = _U('press_custom')
	},
	ls15 = {  -- شكل التزويد الي يطلع في الخريطة الي موجود عنكراج التعديل الي فساندي
		Pos   = {x = 2222.9509277344, y = 2920.3752441406, z = 48.114650726318},
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Name  = _U('blip_name'),
		Hint  = _U('press_custom')
	},
	ls16 = { -- شكل التزويد الي يطلع في الخريطة الي موجود عنكراج التعديل الي فساندي
		Pos   = {x = 2231.5275878906, y = 2920.453125, z = 48.104888916016},
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Name  = _U('blip_name'),
		Hint  = _U('press_custom')
	},
	ls17 = {  -- شكل التزويد الي يطلع في الخريطة الي موجود عنكراج التعديل الي فساندي
		Pos   = {x = 2230.5356445313, y = 2948.0908203125, z = 48.108779907227},
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Name  = _U('blip_name'),
		Hint  = _U('press_custom')
	},
	ls18 = {  -- شكل التزويد الي يطلع في الخريطة الي موجود عنكراج التعديل الي فساندي
		Pos   = {x = 2221.9343261719, y = 2947.9272460938, z = 48.108882904053},
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Name  = _U('blip_name'),
		Hint  = _U('press_custom')
	},
	ls19 = { -- شكل التزويد الي يطلع في الخريطة الي موجود عنكراج التعديل الي فساندي
		Pos   = {x = 2213.0876464844, y = 2947.4807128906, z = 48.109008789063},
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Name  = _U('blip_name'),
		Hint  = _U('press_custom')
	},
	ls20 = {  -- شكل التزويد الي يطلع في الخريطة الي موجود عنكراج التعديل الي في لوس
		Pos   = {x = 822.69573974609, y = -957.34448242188, z = 26.038112640381},
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Name  = _U('blip_name'),
		Hint  = _U('press_custom')
	},
	ls21 = {  -- شكل التزويد الي يطلع في الخريطة الي موجود عنكراج التعديل الي في لوس
		Pos   = {x = 836.69879150391, y = -969.98229980469, z = 26.034826278687},
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Name  = _U('blip_name'),
		Hint  = _U('press_custom')
	},
	ls22 = {  -- شكل التزويد الي يطلع في الخريطة الي موجود عنكراج التعديل الي في لوس
		Pos   = {x = 836.61199951172, y = -960.24432373047, z = 26.119499206543},
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Name  = _U('blip_name'),
		Hint  = _U('press_custom')
	},
	ls23 = {  -- شكل التزويد الي يطلع في الخريطة الي موجود عنكراج التعديل الي في لوس
		Pos   = {x = 836.43585205078, y = -950.80419921875, z = 26.012687683105},
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Name  = _U('blip_name'),
		Hint  = _U('press_custom')
	},
	ls24 = {  -- شكل التزويد الي يطلع في الخريطة الي موجود عنكراج التعديل الي في لوس
		Pos   = {x = 837.33660888672, y = -941.01440429688, z = 26.004512786865},
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Name  = _U('blip_name'),
		Hint  = _U('press_custom')
	},
	ls25 = {  -- شكل التزويد الي يطلع في الخريطة الي موجود عنكراج التعديل الي في لوس
		Pos   = {x = 836.60015869141, y = -931.06719970703, z = 26.077032089233},
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Name  = _U('blip_name'),
		Hint  = _U('press_custom')
	},
	ls26 = {  -- شكل التزويد الي يطلع في الخريطة الي موجود عنكراج التعديل الي في لوس
		Pos   = {x = 806.60913085938, y = -931.22338867188, z = 26.034202575684},
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Name  = _U('blip_name'),
		Hint  = _U('press_custom')
	},
}

Config.Colors = {
	{label = _U('black'), value = 'black'},
	{label = _U('white'), value = 'white'},
	{label = _U('grey'), value = 'grey'},
	{label = _U('red'), value = 'red'},
	{label = _U('pink'), value = 'pink'},
	{label = _U('blue'), value = 'blue'},
	{label = _U('yellow'), value = 'yellow'},
	{label = _U('green'), value = 'green'},
	{label = _U('orange'), value = 'orange'},
	{label = _U('brown'), value = 'brown'},
	{label = _U('purple'), value = 'purple'},
	{label = _U('chrome'), value = 'chrome'},
	{label = _U('gold'), value = 'gold'}
}

function GetColors(color)
	local colors = {}
	if color == 'black' then
		colors = {
			{ index = 0, label = _U('black')},
			{ index = 1, label = _U('graphite')},
			{ index = 2, label = _U('black_metallic')},
			{ index = 3, label = _U('caststeel')},
			{ index = 11, label = _U('black_anth')},
			{ index = 12, label = _U('matteblack')},
			{ index = 15, label = _U('darknight')},
			{ index = 16, label = _U('deepblack')},
			{ index = 21, label = _U('oil')},
			{ index = 147, label = _U('carbon')}
		}
	elseif color == 'white' then
		colors = {
			{ index = 106, label = _U('vanilla')},
			{ index = 107, label = _U('creme')},
			{ index = 111, label = _U('white')},
			{ index = 112, label = _U('polarwhite')},
			{ index = 113, label = _U('beige')},
			{ index = 121, label = _U('mattewhite')},
			{ index = 122, label = _U('snow')},
			{ index = 131, label = _U('cotton')},
			{ index = 132, label = _U('alabaster')},
			{ index = 134, label = _U('purewhite')}
		}
	elseif color == 'grey' then
		colors = {
			{ index = 4, label = _U('silver')},
			{ index = 5, label = _U('metallicgrey')},
			{ index = 6, label = _U('laminatedsteel')},
			{ index = 7, label = _U('darkgray')},
			{ index = 8, label = _U('rockygray')},
			{ index = 9, label = _U('graynight')},
			{ index = 10, label = _U('aluminum')},
			{ index = 13, label = _U('graymat')},
			{ index = 14, label = _U('lightgrey')},
			{ index = 17, label = _U('asphaltgray')},
			{ index = 18, label = _U('grayconcrete')},
			{ index = 19, label = _U('darksilver')},
			{ index = 20, label = _U('magnesite')},
			{ index = 22, label = _U('nickel')},
			{ index = 23, label = _U('zinc')},
			{ index = 24, label = _U('dolomite')},
			{ index = 25, label = _U('bluesilver')},
			{ index = 26, label = _U('titanium')},
			{ index = 66, label = _U('steelblue')},
			{ index = 93, label = _U('champagne')},
			{ index = 144, label = _U('grayhunter')},
			{ index = 156, label = _U('grey')}
		}
	elseif color == 'red' then
		colors = {
			{ index = 27, label = _U('red')},
			{ index = 28, label = _U('torino_red')},
			{ index = 29, label = _U('poppy')},
			{ index = 30, label = _U('copper_red')},
			{ index = 31, label = _U('cardinal')},
			{ index = 32, label = _U('brick')},
			{ index = 33, label = _U('garnet')},
			{ index = 34, label = _U('cabernet')},
			{ index = 35, label = _U('candy')},
			{ index = 39, label = _U('matte_red')},
			{ index = 40, label = _U('dark_red')},
			{ index = 43, label = _U('red_pulp')},
			{ index = 44, label = _U('bril_red')},
			{ index = 46, label = _U('pale_red')},
			{ index = 143, label = _U('wine_red')},
			{ index = 150, label = _U('volcano')}
		}
	elseif color == 'pink' then
		colors = {
			{ index = 135, label = _U('electricpink')},
			{ index = 136, label = _U('salmon')},
			{ index = 137, label = _U('sugarplum')}
		}
	elseif color == 'blue' then
		colors = {
			{ index = 54, label = _U('topaz')},
			{ index = 60, label = _U('light_blue')},
			{ index = 61, label = _U('galaxy_blue')},
			{ index = 62, label = _U('dark_blue')},
			{ index = 63, label = _U('azure')},
			{ index = 64, label = _U('navy_blue')},
			{ index = 65, label = _U('lapis')},
			{ index = 67, label = _U('blue_diamond')},
			{ index = 68, label = _U('surfer')},
			{ index = 69, label = _U('pastel_blue')},
			{ index = 70, label = _U('celeste_blue')},
			{ index = 73, label = _U('rally_blue')},
			{ index = 74, label = _U('blue_paradise')},
			{ index = 75, label = _U('blue_night')},
			{ index = 77, label = _U('cyan_blue')},
			{ index = 78, label = _U('cobalt')},
			{ index = 79, label = _U('electric_blue')},
			{ index = 80, label = _U('horizon_blue')},
			{ index = 82, label = _U('metallic_blue')},
			{ index = 83, label = _U('aquamarine')},
			{ index = 84, label = _U('blue_agathe')},
			{ index = 85, label = _U('zirconium')},
			{ index = 86, label = _U('spinel')},
			{ index = 87, label = _U('tourmaline')},
			{ index = 127, label = _U('paradise')},
			{ index = 140, label = _U('bubble_gum')},
			{ index = 141, label = _U('midnight_blue')},
			{ index = 146, label = _U('forbidden_blue')},
			{ index = 157, label = _U('glacier_blue')}
		}
	elseif color == 'yellow' then
		colors = {
			{ index = 42, label = _U('yellow')},
			{ index = 88, label = _U('wheat')},
			{ index = 89, label = _U('raceyellow')},
			{ index = 91, label = _U('paleyellow')},
			{ index = 126, label = _U('lightyellow')}
		}
	elseif color == 'green' then
		colors = {
			{ index = 49, label = _U('met_dark_green')},
			{ index = 50, label = _U('rally_green')},
			{ index = 51, label = _U('pine_green')},
			{ index = 52, label = _U('olive_green')},
			{ index = 53, label = _U('light_green')},
			{ index = 55, label = _U('lime_green')},
			{ index = 56, label = _U('forest_green')},
			{ index = 57, label = _U('lawn_green')},
			{ index = 58, label = _U('imperial_green')},
			{ index = 59, label = _U('green_bottle')},
			{ index = 92, label = _U('citrus_green')},
			{ index = 125, label = _U('green_anis')},
			{ index = 128, label = _U('khaki')},
			{ index = 133, label = _U('army_green')},
			{ index = 151, label = _U('dark_green')},
			{ index = 152, label = _U('hunter_green')},
			{ index = 155, label = _U('matte_foilage_green')}
		}
	elseif color == 'orange' then
		colors = {
			{ index = 36, label = _U('tangerine')},
			{ index = 38, label = _U('orange')},
			{ index = 41, label = _U('matteorange')},
			{ index = 123, label = _U('lightorange')},
			{ index = 124, label = _U('peach')},
			{ index = 130, label = _U('pumpkin')},
			{ index = 138, label = _U('orangelambo')}
		}
	elseif color == 'brown' then
		colors = {
			{ index = 45, label = _U('copper')},
			{ index = 47, label = _U('lightbrown')},
			{ index = 48, label = _U('darkbrown')},
			{ index = 90, label = _U('bronze')},
			{ index = 94, label = _U('brownmetallic')},
			{ index = 95, label = _U('Expresso')},
			{ index = 96, label = _U('chocolate')},
			{ index = 97, label = _U('terracotta')},
			{ index = 98, label = _U('marble')},
			{ index = 99, label = _U('sand')},
			{ index = 100, label = _U('sepia')},
			{ index = 101, label = _U('bison')},
			{ index = 102, label = _U('palm')},
			{ index = 103, label = _U('caramel')},
			{ index = 104, label = _U('rust')},
			{ index = 105, label = _U('chestnut')},
			{ index = 108, label = _U('brown')},
			{ index = 109, label = _U('hazelnut')},
			{ index = 110, label = _U('shell')},
			{ index = 114, label = _U('mahogany')},
			{ index = 115, label = _U('cauldron')},
			{ index = 116, label = _U('blond')},
			{ index = 129, label = _U('gravel')},
			{ index = 153, label = _U('darkearth')},
			{ index = 154, label = _U('desert')}
		}
	elseif color == 'purple' then
		colors = {
			{ index = 71, label = _U('indigo')},
			{ index = 72, label = _U('deeppurple')},
			{ index = 76, label = _U('darkviolet')},
			{ index = 81, label = _U('amethyst')},
			{ index = 142, label = _U('mysticalviolet')},
			{ index = 145, label = _U('purplemetallic')},
			{ index = 148, label = _U('matteviolet')},
			{ index = 149, label = _U('mattedeeppurple')}
		}
	elseif color == 'chrome' then
		colors = {
			{ index = 117, label = _U('brushedchrome')},
			{ index = 118, label = _U('blackchrome')},
			{ index = 119, label = _U('brushedaluminum')},
			{ index = 120, label = _U('chrome')}
		}
	elseif color == 'gold' then
		colors = {
			{ index = 37, label = _U('gold')},
			{ index = 158, label = _U('puregold')},
			{ index = 159, label = _U('brushedgold')},
			{ index = 160, label = _U('lightgold')}
		}
	end
	return colors
end

function GetWindowName(index)
	if (index == 1) then
		return "Pure Black"
	elseif (index == 2) then
		return "Darksmoke"
	elseif (index == 3) then
		return "Lightsmoke"
	elseif (index == 4) then
		return "Limo"
	elseif (index == 5) then
		return "Green"
	else
		return "Unknown"
	end
end

function GetHornName(index)
	if (index == 0) then
		return "Truck Horn"
	elseif (index == 1) then
		return "Cop Horn"
	elseif (index == 2) then
		return "Clown Horn"
	elseif (index == 3) then
		return "Musical Horn 1"
	elseif (index == 4) then
		return "Musical Horn 2"
	elseif (index == 5) then
		return "Musical Horn 3"
	elseif (index == 6) then
		return "Musical Horn 4"
	elseif (index == 7) then
		return "Musical Horn 5"
	elseif (index == 8) then
		return "Sad Trombone"
	elseif (index == 9) then
		return "Classical Horn 1"
	elseif (index == 10) then
		return "Classical Horn 2"
	elseif (index == 11) then
		return "Classical Horn 3"
	elseif (index == 12) then
		return "Classical Horn 4"
	elseif (index == 13) then
		return "Classical Horn 5"
	elseif (index == 14) then
		return "Classical Horn 6"
	elseif (index == 15) then
		return "Classical Horn 7"
	elseif (index == 16) then
		return "Scale - Do"
	elseif (index == 17) then
		return "Scale - Re"
	elseif (index == 18) then
		return "Scale - Mi"
	elseif (index == 19) then
		return "Scale - Fa"
	elseif (index == 20) then
		return "Scale - Sol"
	elseif (index == 21) then
		return "Scale - La"
	elseif (index == 22) then
		return "Scale - Ti"
	elseif (index == 23) then
		return "Scale - Do"
	elseif (index == 24) then
		return "Jazz Horn 1"
	elseif (index == 25) then
		return "Jazz Horn 2"
	elseif (index == 26) then
		return "Jazz Horn 3"
	elseif (index == 27) then
		return "Jazz Horn Loop"
	elseif (index == 28) then
		return "Star Spangled Banner 1"
	elseif (index == 29) then
		return "Star Spangled Banner 2"
	elseif (index == 30) then
		return "Star Spangled Banner 3"
	elseif (index == 31) then
		return "Star Spangled Banner 4"
	elseif (index == 32) then
		return "Classical Horn 8 Loop"
	elseif (index == 33) then
		return "Classical Horn 9 Loop"
	elseif (index == 34) then
		return "Classical Horn 10 Loop"
	elseif (index == 35) then
		return "Classical Horn 8"
	elseif (index == 36) then
		return "Classical Horn 9"
	elseif (index == 37) then
		return "Classical Horn 10"
	elseif (index == 38) then
		return "Funeral Loop"
	elseif (index == 39) then
		return "Funeral"
	elseif (index == 40) then
		return "Spooky Loop"
	elseif (index == 41) then
		return "Spooky"
	elseif (index == 42) then
		return "San Andreas Loop"
	elseif (index == 43) then
		return "San Andreas"
	elseif (index == 44) then
		return "Liberty City Loop"
	elseif (index == 45) then
		return "Liberty City"
	elseif (index == 46) then
		return "Festive 1 Loop"
	elseif (index == 47) then
		return "Festive 1"
	elseif (index == 48) then
		return "Festive 2 Loop"
	elseif (index == 49) then
		return "Festive 2"
	elseif (index == 50) then
		return "Festive 3 Loop"
	elseif (index == 51) then
		return "Festive 3"
	else
		return "Unknown Horn"
	end
end

function GetNeons()
	local neons = {
		{label = _U('white'),		r = 255, 	g = 255, 	b = 255},
		{label = "Slate Gray",		r = 112, 	g = 128, 	b = 144},
		{label = "Blue",			r = 0, 		g = 0, 		b = 255},
		{label = "Light Blue",		r = 0, 		g = 150, 	b = 255},
		{label = "Navy Blue", 		r = 0, 		g = 0, 		b = 128},
		{label = "Sky Blue", 		r = 135, 	g = 206, 	b = 235},
		{label = "Turquoise", 		r = 0, 		g = 245, 	b = 255},
		{label = "Mint Green", 	r = 50, 	g = 255, 	b = 155},
		{label = "Lime Green", 	r = 0, 		g = 255, 	b = 0},
		{label = "Olive", 			r = 128, 	g = 128, 	b = 0},
		{label = _U('yellow'), 	r = 255, 	g = 255, 	b = 0},
		{label = _U('gold'), 		r = 255, 	g = 215, 	b = 0},
		{label = _U('orange'), 	r = 255, 	g = 165, 	b = 0},
		{label = _U('wheat'), 		r = 245, 	g = 222, 	b = 179},
		{label = _U('red'), 		r = 255, 	g = 0, 		b = 0},
		{label = _U('pink'), 		r = 255, 	g = 161, 	b = 211},
		{label = _U('brightpink'),	r = 255, 	g = 0, 		b = 255},
		{label = _U('purple'), 	r = 153, 	g = 0, 		b = 153},
		{label = "Ivory", 			r = 41, 	g = 36, 	b = 33}
	}

	return neons
end

function GetPlatesName(index)
	if (index == 0) then
		return _U('blue_on_white_1')
	elseif (index == 1) then
		return _U('yellow_on_black')
	elseif (index == 2) then
		return _U('yellow_blue')
	elseif (index == 3) then
		return _U('blue_on_white_2')
	elseif (index == 4) then
		return _U('blue_on_white_3')
	end
end

Config.Menus = {
	main = {
		label		= 'ورشة التزويد',
		parent		= nil,
		upgrades	= _U('upgrades'),
		cosmetics	= _U('cosmetics')
	},
	upgrades = {
		label			= _U('upgrades'),
		parent			= 'main',
		modEngine		= _U('engine'),
		modBrakes		= _U('brakes'),
		modTransmission	= _U('transmission'),
		modSuspension	= _U('suspension'),
		modArmor		= _U('armor'),
		modTurbo		= _U('turbo')
	},
	modEngine = {
		label = _U('engine'),
		parent = 'upgrades',
		modType = 11,
		price = {13.95, 32.56, 65.12, 139.53}
	},
	modBrakes = {
		label = _U('brakes'),
		parent = 'upgrades',
		modType = 12,
		price = {4.65, 9.3, 18.6, 13.95}
	},
	modTransmission = {
		label = _U('transmission'),
		parent = 'upgrades',
		modType = 13,
		price = {13.95, 20.93, 46.51}
	},
	modSuspension = {
		label = _U('suspension'),
		parent = 'upgrades',
		modType = 15,
		price = {3.72, 7.44, 14.88, 29.77, 40.2}
	},
	modArmor = {
		label = _U('armor'),
		parent = 'upgrades',
		modType = 16,
		price = {69.77, 116.28, 130.00, 150.00, 180.00, 190.00}
	},
	modTurbo = {
		label = _U('turbo'),
		parent = 'upgrades',
		modType = 17,
		price = {55.81}
	},
	cosmetics = {
		label				= _U('cosmetics'),
		parent				= 'main',
		bodyparts			= _U('bodyparts'),
		windowTint			= _U('windowtint'),
		modHorns			= _U('horns'),
		neonColor			= _U('neons'),
		resprays			= _U('respray'),
		modXenon			= _U('headlights'),
		plateIndex			= _U('licenseplates'),
		wheels				= _U('wheels'),
		modPlateHolder		= _U('modplateholder'),
		modVanityPlate		= _U('modvanityplate'),
		modTrimA			= _U('interior'),
		modOrnaments		= _U('trim'),
		modDashboard		= _U('dashboard'),
		modDial				= _U('speedometer'),
		modDoorSpeaker		= _U('door_speakers'),
		modSeats			= _U('seats'),
		modSteeringWheel	= _U('steering_wheel'),
		modShifterLeavers	= _U('gear_lever'),
		modAPlate			= _U('quarter_deck'),
		modSpeakers			= _U('speakers'),
		modTrunk			= _U('trunk'),
		modHydrolic			= _U('hydraulic'),
		modEngineBlock		= _U('engine_block'),
		modAirFilter		= _U('air_filter'),
		modStruts			= _U('struts'),
		modArchCover		= _U('arch_cover'),
		modAerials			= _U('aerials'),
		modTrimB			= _U('wings'),
		modTank				= _U('fuel_tank'),
		modWindows			= _U('windows'),
		modLivery			= _U('stickers')
	},

	modPlateHolder = {
		label = _U('modplateholder'),
		parent = 'cosmetics',
		modType = 25,
		price = 3.49
	},
	modVanityPlate = {
		label = _U('modvanityplate'),
		parent = 'cosmetics',
		modType = 26,
		price = 1.1
	},
	modTrimA = {
		label = _U('interior'),
		parent = 'cosmetics',
		modType = 27,
		price = 6.98
	},
	modOrnaments = {
		label = _U('trim'),
		parent = 'cosmetics',
		modType = 28,
		price = 0.9
	},
	modDashboard = {
		label = _U('dashboard'),
		parent = 'cosmetics',
		modType = 29,
		price = 4.65
	},
	modDial = {
		label = _U('speedometer'),
		parent = 'cosmetics',
		modType = 30,
		price = 4.19
	},
	modDoorSpeaker = {
		label = _U('door_speakers'),
		parent = 'cosmetics',
		modType = 31,
		price = 5.58
	},
	modSeats = {
		label = _U('seats'),
		parent = 'cosmetics',
		modType = 32,
		price = 4.65
	},
	modSteeringWheel = {
		label = _U('steering_wheel'),
		parent = 'cosmetics',
		modType = 33,
		price = 4.19
	},
	modShifterLeavers = {
		label = _U('gear_lever'),
		parent = 'cosmetics',
		modType = 34,
		price = 3.26
	},
	modAPlate = {
		label = _U('quarter_deck'),
		parent = 'cosmetics',
		modType = 35,
		price = 4.19
	},
	modSpeakers = {
		label = _U('speakers'),
		parent = 'cosmetics',
		modType = 36,
		price = 6.98
	},
	modTrunk = {
		label = _U('trunk'),
		parent = 'cosmetics',
		modType = 37,
		price = 5.58
	},
	modHydrolic = {
		label = _U('hydraulic'),
		parent = 'cosmetics',
		modType = 38,
		price = 5.12
	},
	modEngineBlock = {
		label = _U('engine_block'),
		parent = 'cosmetics',
		modType = 39,
		price = 5.12
	},
	modAirFilter = {
		label = _U('air_filter'),
		parent = 'cosmetics',
		modType = 40,
		price = 3.72
	},
	modStruts = {
		label = _U('struts'),
		parent = 'cosmetics',
		modType = 41,
		price = 6.51
	},
	modArchCover = {
		label = _U('arch_cover'),
		parent = 'cosmetics',
		modType = 42,
		price = 4.19
	},
	modAerials = {
		label = _U('aerials'),
		parent = 'cosmetics',
		modType = 43,
		price = 1.12
	},
	modTrimB = {
		label = _U('wings'),
		parent = 'cosmetics',
		modType = 44,
		price = 6.05
	},
	modTank = {
		label = _U('fuel_tank'),
		parent = 'cosmetics',
		modType = 45,
		price = 4.19
	},
	modWindows = {
		label = _U('windows'),
		parent = 'cosmetics',
		modType = 46,
		price = 4.19
	},
	modLivery = {
		label = _U('stickers'),
		parent = 'cosmetics',
		modType = 48,
		price = 9.3
	},

	wheels = {
		label = _U('wheels'),
		parent = 'cosmetics',
		modFrontWheelsTypes = _U('wheel_type'),
		modFrontWheelsColor = _U('wheel_color'),
		tyreSmokeColor = _U('tiresmoke')
	},
	modFrontWheelsTypes = {
		label				= _U('wheel_type'),
		parent				= 'wheels',
		modFrontWheelsType0	= _U('sport'),
		modFrontWheelsType1	= _U('muscle'),
		modFrontWheelsType2	= _U('lowrider'),
		modFrontWheelsType3	= _U('suv'),
		modFrontWheelsType4	= _U('allterrain'),
		modFrontWheelsType5	= _U('tuning'),
		modFrontWheelsType6	= _U('motorcycle'),
		modFrontWheelsType7	= _U('highend')
	},
	modFrontWheelsType0 = {
		label = _U('sport'),
		parent = 'modFrontWheelsTypes',
		modType = 23,
		wheelType = 0,
		price = 4.65
	},
	modFrontWheelsType1 = {
		label = _U('muscle'),
		parent = 'modFrontWheelsTypes',
		modType = 23,
		wheelType = 1,
		price = 4.19
	},
	modFrontWheelsType2 = {
		label = _U('lowrider'),
		parent = 'modFrontWheelsTypes',
		modType = 23,
		wheelType = 2,
		price = 4.65
	},
	modFrontWheelsType3 = {
		label = _U('suv'),
		parent = 'modFrontWheelsTypes',
		modType = 23,
		wheelType = 3,
		price = 4.19
	},
	modFrontWheelsType4 = {
		label = _U('allterrain'),
		parent = 'modFrontWheelsTypes',
		modType = 23,
		wheelType = 4,
		price = 4.19
	},
	modFrontWheelsType5 = {
		label = _U('tuning'),
		parent = 'modFrontWheelsTypes',
		modType = 23,
		wheelType = 5,
		price = 5.12
	},
	modFrontWheelsType6 = {
		label = _U('motorcycle'),
		parent = 'modFrontWheelsTypes',
		modType = 23,
		wheelType = 6,
		price = 3.26
	},
	modFrontWheelsType7 = {
		label = _U('highend'),
		parent = 'modFrontWheelsTypes',
		modType = 23,
		wheelType = 7,
		price = 5.12
	},
	modFrontWheelsColor = {
		label = _U('wheel_color'),
		parent = 'wheels'
	},
	wheelColor = {
		label = _U('wheel_color'),
		parent = 'modFrontWheelsColor',
		modType = 'wheelColor',
		price = 0.66
	},
	plateIndex = {
		label = _U('licenseplates'),
		parent = 'cosmetics',
		modType = 'plateIndex',
		price = 1.1
	},
	resprays = {
		label = _U('respray'),
		parent = 'cosmetics',
		primaryRespray = _U('primary'),
		secondaryRespray = _U('secondary'),
		pearlescentRespray = _U('pearlescent'),
	},
	primaryRespray = {
		label = _U('primary'),
		parent = 'resprays',
	},
	secondaryRespray = {
		label = _U('secondary'),
		parent = 'resprays',
	},
	pearlescentRespray = {
		label = _U('pearlescent'),
		parent = 'resprays',
	},
	color1 = {
		label = _U('primary'),
		parent = 'primaryRespray',
		modType = 'color1',
		price = 1.12
	},
	color2 = {
		label = _U('secondary'),
		parent = 'secondaryRespray',
		modType = 'color2',
		price = 0.66
	},
	pearlescentColor = {
		label = _U('pearlescent'),
		parent = 'pearlescentRespray',
		modType = 'pearlescentColor',
		price = 0.88
	},
	modXenon = {
		label = _U('headlights'),
		parent = 'cosmetics',
		modType = 22,
		price = 3.72
	},
	bodyparts = {
		label = _U('bodyparts'),
		parent = 'cosmetics',
		modFender = _U('leftfender'),
		modRightFender = _U('rightfender'),
		modSpoilers = _U('spoilers'),
		modSideSkirt = _U('sideskirt'),
		modFrame = _U('cage'),
		modHood = _U('hood'),
		modGrille = _U('grille'),
		modRearBumper = _U('rearbumper'),
		modFrontBumper = _U('frontbumper'),
		modExhaust = _U('exhaust'),
		modRoof = _U('roof')
	},
	modSpoilers = {
		label = _U('spoilers'),
		parent = 'bodyparts',
		modType = 0,
		price = 4.65
	},
	modFrontBumper = {
		label = _U('frontbumper'),
		parent = 'bodyparts',
		modType = 1,
		price = 5.12
	},
	modRearBumper = {
		label = _U('rearbumper'),
		parent = 'bodyparts',
		modType = 2,
		price = 5.12
	},
	modSideSkirt = {
		label = _U('sideskirt'),
		parent = 'bodyparts',
		modType = 3,
		price = 4.65
	},
	modExhaust = {
		label = _U('exhaust'),
		parent = 'bodyparts',
		modType = 4,
		price = 5.12
	},
	modFrame = {
		label = _U('cage'),
		parent = 'bodyparts',
		modType = 5,
		price = 5.12
	},
	modGrille = {
		label = _U('grille'),
		parent = 'bodyparts',
		modType = 6,
		price = 3.72
	},
	modHood = {
		label = _U('hood'),
		parent = 'bodyparts',
		modType = 7,
		price = 4.88
	},
	modFender = {
		label = _U('leftfender'),
		parent = 'bodyparts',
		modType = 8,
		price = 5.12
	},
	modRightFender = {
		label = _U('rightfender'),
		parent = 'bodyparts',
		modType = 9,
		price = 5.12
	},
	modRoof = {
		label = _U('roof'),
		parent = 'bodyparts',
		modType = 10,
		price = 5.58
	},
	windowTint = {
		label = _U('windowtint'),
		parent = 'cosmetics',
		modType = 'windowTint',
		price = 1.12
	},
	modHorns = {
		label = _U('horns'),
		parent = 'cosmetics',
		modType = 14,
		price = 1.12
	},
	neonColor = {
		label = _U('neons'),
		parent = 'cosmetics',
		modType = 'neonColor',
		price = 1.12
	},
	tyreSmokeColor = {
		label = _U('tiresmoke'),
		parent = 'wheels',
		modType = 'tyreSmokeColor',
		price = 1.12
	}

}
