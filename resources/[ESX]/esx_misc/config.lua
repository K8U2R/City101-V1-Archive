Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


--shared
LeoJobs = {'police','agent','admin','ambulance'}


--Other
Config        = {}
Config.done = false
Config.Locale = "en"
Config.MarkerSize = {x = 1.5, y = 1.5, z = 0.5}
Config.colaprice = 15 -- سعر الكوكاكولا ب المكينة

Config.EnableConnectOptions = false -- تفعيل/إلغاء خيارات دخول ديسكورد او متجر او دخول السيرفر بعد الضغط على دخول السيرفر

Config.Duble = 1 -- خبرة

Config.dev_mod = false

Config.jobsBlip = {
    ['police'] = 29,
    ['agent'] = 2,
    ['ambulance'] = 47,
    ['mechanic'] = 40,
}

--support 128+ players
Config.OnesyncInfinty = true

blipColor = {
	red = 1,
	blue = 63,
	green = 25,
	purple = 58,
	black = 72,
	gold = 46,
}

Config_car_job = {}

Config_car_job = {
    carsblacklisted = { -- put here the vehicles that you want only emergency services to be able to get in
        "doreat1",
        "shrqpolice2",
        "shrqpolice3",
        "shrqpolice4",
        "shrqpolice5",
        "shrqpolice6",
        "shrqpolice7",
        "shrqpolice8",
        "doreat8",
        "doreat9",
        "doreat3",
        "doreat4",
        "doreat5",
        "doreat10",
        "doreat7",
        "cv1",
        "azr815",
        "mror16",
        "doreat15",
        "cv2",
        "cv3",
        "cv4",
        "cv5",
        "dg1",
        "dg2",
        "dg3",
        "dodgedoreat",
        "dodgemror",
        "amn6r814",
        "amnmhmat14",
        "azr814",
        "doreat14",
        "mror15",
        "amn6r813",
        "amnmhmat13",
        "doreat13",
        "mror14",
		"amnmhmat15",
		"max99sry",
		"avalonsry",
		"camry19sry",
		"bcso2sry",
		"taurus23sry",
		"landsry",
		"landsry2",
		"camrypolice",
		"camrysre2013",
		"corollapolice",
		"caprice1",
		"ford1",
		"fjsre",
		"hilux99sre",
		"dodgesry",
		"rb3police",
		"tahoepolice",
		"patrolpolice",
		"tsry",
		"sk1",
		"sk2",
		"sk3",
		"sk4",
		"sk5",
		"sh16",
		"sh4",
		"sh6",
		"sh8",
		"sh10",
		"sh14",
		"sh18",
		"sh18",
		"hlal7",
		"hlal8",
		"hlal1",
		"hlal2",
		"hlal3",
		"hlal4",
		"hlal5",
		"hlal6",
		"njRATs67h",
		"c3f350rollback",
		"c3navistar",
		"c3pwrollback",
		"c3rollback",
		"c3silvrollback",
		"c320silvwrecker",
		"flatbed3",
		"Gtow",
		"tooltruck",
		"code3cvpi",
		"code3fpis",
		"code316fpiu",
		"code320exp",
		"code318charg",
		"code318tahoe",
		
    },
    pNotify = false, -- if you have pnotify you can turn it on for a different message
    EsxNotify = true, -- Turn this on for the default ESX notification
    CheckTime = 1000, -- Check time in car, please don't go onder 1000ms if you want a good and stable server
    NotifyMessage = 'لايمكنك ركوب المركبة هذه',
}

--panic button
Config.panicButton = {}
Config.panicButton.giveXPvalue = 100 --how many xp to give for leo inside xp zones
Config.panicButton.giveXPtime = 3 --how many to sec to wait befor give xp to leo inside xp zones
Config.panicButton.noXPzones = { --zones if leo go inside will not take xp
	'sea_port_close',
	'internationa_close',
	'seaport_west_close',
	'sea_port_friday',
	'hacker',
	'my_location_safezone',
	'peace_time',
	'9eanh_time',
	'blaine_meeting',
	'event_start',
	'event_location',
	'event_registration',
	'event_end',
	'restart_time',
	'war_time_paleto',
	'war_time_sandy',
	'war_time_ls',
}

Config.time = 7

Config.panicButton.takeXPvalue = 20 --how many xp to give for leo inside xp zones
Config.panicButton.takeXPtime = 2 --how many to sec to wait befor give xp to leo inside xp zones
Config.panicButton.takeXPzones = { --zones if leo go inside will not take xp
	'sea_port_close',
	'restricted_area',
	'internationa_close',
	'seaport_west_close',
}

Config.panicButton.godmodLocations = {
	'hacker',
	'my_location_safezone',
	'peace_time',
	'restart_time',
	'9eanh_time'
}

Config.panicButton.noSirenZone = {
	'my_location_safezone',
	'peace_time',
	'9eanh_time',
	'helpme',
	'sea_port_close',
	'sea_port_friday',
	'blaine_meeting',
	'event_start',
	'event_location',
	'event_registration',
	'event_end',
	'restricted_area',
	'restart_time',
	'internationa_close',
	'seaport_west_close',
}

Config.panicButton.noCrimeZone = {
	'peace_time',
	'9eanh_time',
	'event_location',
	'sea_port_close',
	'restart_time',
	'internationa_close',
	'seaport_west_close',
}

Config.panicButton.noCrimeTime2 = {
	'NoCrimetime',
	'NewScenario',
	'MainBank',
	'SmallBanks',
	'Stores',
	'SellDrugs',
	'MainBankHave',
	'deleteallcars',
	'SandyAndPeleto',
	'SmallBanksHave',
	'StoresHave',
	'threb',
}

Config.panicButton.skyTransitionLocations = {
	'peace_time',
	'9eanh_time',
	'restart_time',
	'war_time_paleto',
	'war_time_sandy',
	'war_time_ls',
}

Config.panicButton.deleteAllAlarms = {
	'peace_time',
	'9eanh_time',
	'restart_time',
	'war_time_paleto',
	'war_time_sandy',
	'war_time_ls',
}

Config.panicButton.alarmTIMER = {
	'peace_time',
	'9eanh_time',
	'restart_time',
	'war_time_paleto',
	'war_time_sandy',
	'war_time_ls',
}

Config.panicButton.locationsData ={
	['hacker'] = {
		location = 'hacker',
		blipColor = nil, --nil = red and blue
		citizen = {
			--draw = 'ﺪﺟﻮﻳ ..ﻪﻳﻮﻨﺗ',--تنويه.. يوجد
			draw = '',--تنويه.. يوجد
			color = {r=200,g=0,b=0,a=255},
			notification = {
				'<font color=red>تم اطلاق صافرة الانذار لمكافحة ',
				'الهكر هو مخلوق نشأ على التخريب والخداع',
				'لاداعي للخروج من السيرفر انت محمي من الرقابة و التفتيش',
				'يمنع النشاط الاجرامي اثناء مكافحة الهكر',
				'لاتستعمل الأسلحة والمتفجرات حتى لاتتعرض للبان',
				'تعاونك مع الرقابة و التفتيش وقت الازمات يبعد عنك الشبهات',
			}
		},
		leo = {
			--draw = 'ﻢﻴﻈﻨﺘﻟﺍ و ﻖﻴﻘﺤﺘﻟﺍ ﺔﺌﻴﻫ', --تنويه من الرقابة و التفتيش
			draw = '', --تنويه من الرقابة و التفتيش
			color = {r=200,g=0,b=0,a=255},
			notification = {
				'<font color=red>تم اطلاق صافرة الانذار ل',
				'الهكر هو مخلوق نشأ على التخريب والخداع',
				'لاداعي للخروج من السيرفر انت محمي من الرقابة و التفتيش',
				'يمنع النشاط الاجرامي اثناء مكافحة الهكر',
				'يمكنك استيقاف اي شخص مشتبه به والتحقيق معه بشرط توافر حالة اشتباه خكر',
				'تعاونك مع الرقابة و التفتيش وقت الازمات يبعد عنك الشبهات',
			}
		}
	},
	['my_location_safezone'] = {
		location = 'my_location_safezone',
		blipColor = blipColor.green,
		citizen = {
			--draw = '<FONT FACE="A9eelsh">ﻢﻴﻈﻨﺘﻟﺍ و ﻖﻴﻘﺤﺘﻟﺍ ﺔﺌﻴﻫ', --الرقابة و التفتيش
			draw = '', --الرقابة و التفتيش
			color = {r=0,g=255,b=0,a=255},
			notification = {
				'<font color=00E121>تم اعلان حالة ',
				'يمنع القتل او استعمال السلاح هذه المنطقة',
				'اتبع ارشادات المراقب ولا تحاول التخريب',
				'عدم الانصياع للأوامر يعرضك للاعتقال فورا او عقوبات مشددة',
			}
		},
		leo = {
			--draw = 'ﻢﻴﻈﻨﺘﻟﺍ و ﻖﻴﻘﺤﺘﻟﺍ ﺔﺌﻴﻫ', --تنويه من الرقابة و التفتيش
			draw = '', --تنويه من الرقابة و التفتيش
			color = {r=0,g=255,b=0,a=255},
			notification = {
				'<font color=00E121>تم اعلان حالة ',
				'يمنع القتل او استعمال السلاح هذه المنطقة',
				'اتبع ارشادات المراقب ولا تحاول التخريب',
				'عدم الانصياع للأوامر يعرضك للاعتقال فورا او عقوبات مشددة',
			}
		}
	},
	['peace_time'] = {
		location = 'peace_time',
		blipColor = blipColor.purple,
		DrawText = '<FONT FACE="A9eelsh">ﺔﺣﺍﺭ ﺖﻗﻭ', --الكلام الي داخل الأقواس بوسط الشاشة (اذا عربي مقلوب و التعريب)
		citizen = {	
			draw = '', --'ﻢﻴﻈﻨﺘﻟﺍ و ﻖﻴﻘﺤﺘﻟﺍ ﺔﺌﻴﻫ', --الرقابة و التفتيش
			color = {r=138,g=0,b=198,a=255},
			notification = {
				'<font color=B748E2>تم اعلان ',
				'يمنع النشاط الاجرامي منعا باتا اثناء <font color=B748E2>وقت الراحة',
				'تعطل جميع الوظائف المعتمدة والعامة',
				'اتبع ارشادات المراقبين والتزم بالقوانين',
				'التخريب في وقت الراحة يعرضك لعقوبات مشددة',
			}
		},
		leo = {
			draw = '', --'ﻢﻴﻈﻨﺘﻟﺍ و ﻖﻴﻘﺤﺘﻟﺍ ﺔﺌﻴﻫ', --تنويه من الرقابة و التفتيش
			color = {r=138,g=0,b=198,a=255},
			notification = {
				'<font color=B748E2>تم اعلان ',
				'يمنع النشاط الاجرامي منعا باتا اثناء <font color=B748E2>وقت الراحة',
				'تعطل جميع الوظائف المعتمدة والعامة',
				'يمكن تغيير وظيفتك اذا كان وقت الراحة كافي للعمل',
				'يجب اخذ موافقة تغيير الوظيفة من الاعلى رتبة في الخدمة',
				'اتبع ارشادات المراقبين والتزم بالقوانين',
				'التخريب في وقت الراحة يعرضك لعقوبات مشددة',
			}
		},
		chat = {
			[0] = 'تم إعلان '..'^6',
			[1] = '^7'..' لمدة '..'^6%s^7'..' دقيقة.'..'  يبدأ بعد '..'^3%s^7'..' دقيقة',
			[2] = '^7'..' لمدة '..'^6%s^7'..' دقيقة '..'^7'..' يمنع العمل الاجرامي وتعطل جميع الدوائر الحكومية والخاصة حتى انقضاء المدة',
			[3] = 'تم إعلان انتهاء '..'^6',
		}
	},
	['9eanh_time'] = {
		location = '9eanh_time',
		blipColor = blipColor.purple,
		DrawText = '<FONT FACE="A9eelsh">ﺔﻧﺎﻴﺻ ﺖﻗﻭ', --الكلام الي داخل الأقواس بوسط الشاشة (اذا عربي مقلوب و التعريب)
		citizen = {	
			draw = '', --'ﻢﻴﻈﻨﺘﻟﺍ و ﻖﻴﻘﺤﺘﻟﺍ ﺔﺌﻴﻫ', --الرقابة و التفتيش
			color = {r=138,g=0,b=198,a=255},
			notification = {
				'<font color=B748E2>تم اعلان ',
				'يمنع النشاط الاجرامي منعا باتا اثناء <font color=B748E2>وقت صيانة',
				'تعطل جميع الوظائف المعتمدة والعامة',
				'اتبع ارشادات المراقبين والتزم بالقوانين',
				'التخريب في وقت صيانة يعرضك لعقوبات مشددة',
			}
		},
		leo = {
			draw = '', --'ﻢﻴﻈﻨﺘﻟﺍ و ﻖﻴﻘﺤﺘﻟﺍ ﺔﺌﻴﻫ', --تنويه من الرقابة و التفتيش
			color = {r=138,g=0,b=198,a=255},
			notification = {
				'<font color=B748E2>تم اعلان ',
				'يمنع النشاط الاجرامي منعا باتا اثناء <font color=B748E2>وقت صيانة',
				'تعطل جميع الوظائف المعتمدة والعامة',
				'يمكن تغيير وظيفتك اذا كان وقت صيانة كافي للعمل',
				'يجب اخذ موافقة تغيير الوظيفة من الاعلى رتبة في الخدمة',
				'اتبع ارشادات المراقبين والتزم بالقوانين',
				'التخريب في وقت صيانة يعرضك لعقوبات مشددة',
			}
		},
		chat = {
			[0] = 'تم إعلان '..'^6',
			[1] = '^7'..' لمدة '..'^6%s^7'..' دقيقة.'..'  يبدأ بعد '..'^3%s^7'..' دقيقة',
			[2] = '^7'..' لمدة '..'^6%s^7'..' دقيقة '..'^7'..' يمنع العمل الاجرامي وتعطل جميع الدوائر الحكومية والخاصة حتى انقضاء المدة',
			[3] = 'تم إعلان انتهاء '..'^6',
		}
	},
	[1] = {
		location = 'helpme',
		blipColor = nil, --nil = red and blue
		citizen = {
			--draw = 'ﺐﻠﻃ ﻦﻣﺍ ﻞﺟﺭ ﻪﺒﺘﻧﺍ', --انتبه رجل امن طلب 
			draw = '', --انتبه رجل امن طلب 
			color = {r=226,g=139,b=0,a=255},
			notification = {
			'<font color=red>انتبه تم إرسال ',
			'يوجد رجل امن بحاجة إلى مساعدة في منطقتك',
			'حاول الابتعاد عن الخطر ان وجد في مكان الاستغاثه',
			'حاول متابعة رجل الامن الذي طلب المساعدة من بعيد',
			'يتم الآن توجيه قوة امنية لمكان الاستغاثة',
			}
		},
		leo = {
			--draw = '..ﻪﻳﻮﻨﺗ', --تنويه
			draw = '', --تنويه
			color = {r=226,g=139,b=0,a=255},
			notification = {
			'<font color=red>انتبه تم إرسال ',
			'يوجد رجل امن بحاجة إلى مساعدة',
			}
		}
	},
	[2] = {
		location = 'helpme_2',
		blipColor = nil, --nil = red and blue
		citizen = {
			--draw = 'ﺐﻠﻃ ﻦﻣﺍ ﻞﺟﺭ ﻪﺒﺘﻧﺍ', --انتبه رجل امن طلب 
			draw = '', --انتبه رجل امن طلب 
			color = {r=226,g=139,b=0,a=255},
			notification = {
			'<font color=red>انتبه تم إرسال ',
			'يوجد رجل امن بحاجة إلى مساعدة في منطقتك',
			'حاول الابتعاد عن الخطر ان وجد في مكان الاستغاثه',
			'حاول متابعة رجل الامن الذي طلب المساعدة من بعيد',
			'يتم الآن توجيه قوة امنية لمكان الاستغاثة',
			}
		},
		leo = {
			--draw = '..ﻪﻳﻮﻨﺗ', --تنويه
			draw = '', --تنويه
			color = {r=226,g=139,b=0,a=255},
			notification = {
			'<font color=red>انتبه تم إرسال ',
			'يوجد رجل امن بحاجة إلى مساعدة',
			}
		}
	},
	[3] = {
		location = 'helpme_3',
		blipColor = nil, --nil = red and blue
		citizen = {
			--draw = 'ﺐﻠﻃ ﻦﻣﺍ ﻞﺟﺭ ﻪﺒﺘﻧﺍ', --انتبه رجل امن طلب 
			draw = '', --انتبه رجل امن طلب 
			color = {r=226,g=139,b=0,a=255},
			notification = {
			'<font color=red>انتبه تم إرسال ',
			'يوجد رجل امن بحاجة إلى مساعدة في منطقتك',
			'حاول الابتعاد عن الخطر ان وجد في مكان الاستغاثه',
			'حاول متابعة رجل الامن الذي طلب المساعدة من بعيد',
			'يتم الآن توجيه قوة امنية لمكان الاستغاثة',
			}
		},
		leo = {
			--draw = '..ﻪﻳﻮﻨﺗ', --تنويه
			draw = '', --تنويه
			color = {r=226,g=139,b=0,a=255},
			notification = {
			'<font color=red>انتبه تم إرسال ',
			'يوجد رجل امن بحاجة إلى مساعدة',
			}
		}
	},
	[4] = {
		location = 'helpme_4',
		blipColor = nil, --nil = red and blue
		citizen = {
			--draw = 'ﺐﻠﻃ ﻦﻣﺍ ﻞﺟﺭ ﻪﺒﺘﻧﺍ', --انتبه رجل امن طلب 
			draw = '', --انتبه رجل امن طلب 
			color = {r=226,g=139,b=0,a=255},
			notification = {
			'<font color=red>انتبه تم إرسال ',
			'يوجد رجل امن بحاجة إلى مساعدة في منطقتك',
			'حاول الابتعاد عن الخطر ان وجد في مكان الاستغاثه',
			'حاول متابعة رجل الامن الذي طلب المساعدة من بعيد',
			'يتم الآن توجيه قوة امنية لمكان الاستغاثة',
			}
		},
		leo = {
			--draw = '..ﻪﻳﻮﻨﺗ', --تنويه
			draw = '', --تنويه
			color = {r=226,g=139,b=0,a=255},
			notification = {
			'<font color=red>انتبه تم إرسال ',
			'يوجد رجل امن بحاجة إلى مساعدة',
			}
		}
	},
	[5] = {
		location = 'helpme_5',
		blipColor = nil, --nil = red and blue
		citizen = {
			--draw = 'ﺐﻠﻃ ﻦﻣﺍ ﻞﺟﺭ ﻪﺒﺘﻧﺍ', --انتبه رجل امن طلب 
			draw = '', --انتبه رجل امن طلب 
			color = {r=226,g=139,b=0,a=255},
			notification = {
			'<font color=red>انتبه تم إرسال ',
			'يوجد رجل امن بحاجة إلى مساعدة في منطقتك',
			'حاول الابتعاد عن الخطر ان وجد في مكان الاستغاثه',
			'حاول متابعة رجل الامن الذي طلب المساعدة من بعيد',
			'يتم الآن توجيه قوة امنية لمكان الاستغاثة',
			}
		},
		leo = {
			--draw = '..ﻪﻳﻮﻨﺗ', --تنويه
			draw = '', --تنويه
			color = {r=226,g=139,b=0,a=255},
			notification = {
			'<font color=red>انتبه تم إرسال ',
			'يوجد رجل امن بحاجة إلى مساعدة',
			}
		}
	},
	[6] = {
		location = 'helpme_6',
		blipColor = nil, --nil = red and blue
		citizen = {
			--draw = 'ﺐﻠﻃ ﻦﻣﺍ ﻞﺟﺭ ﻪﺒﺘﻧﺍ', --انتبه رجل امن طلب 
			draw = '', --انتبه رجل امن طلب 
			color = {r=226,g=139,b=0,a=255},
			notification = {
			'<font color=red>انتبه تم إرسال ',
			'يوجد رجل امن بحاجة إلى مساعدة في منطقتك',
			'حاول الابتعاد عن الخطر ان وجد في مكان الاستغاثه',
			'حاول متابعة رجل الامن الذي طلب المساعدة من بعيد',
			'يتم الآن توجيه قوة امنية لمكان الاستغاثة',
			}
		},
		leo = {
			--draw = '..ﻪﻳﻮﻨﺗ', --تنويه
			draw = '', --تنويه
			color = {r=226,g=139,b=0,a=255},
			notification = {
			'<font color=red>انتبه تم إرسال ',
			'يوجد رجل امن بحاجة إلى مساعدة',
			}
		}
	},
	[7] = {
		location = 'helpme_7',
		blipColor = nil, --nil = red and blue
		citizen = {
			--draw = 'ﺐﻠﻃ ﻦﻣﺍ ﻞﺟﺭ ﻪﺒﺘﻧﺍ', --انتبه رجل امن طلب 
			draw = '', --انتبه رجل امن طلب 
			color = {r=226,g=139,b=0,a=255},
			notification = {
			'<font color=red>انتبه تم إرسال ',
			'يوجد رجل امن بحاجة إلى مساعدة في منطقتك',
			'حاول الابتعاد عن الخطر ان وجد في مكان الاستغاثه',
			'حاول متابعة رجل الامن الذي طلب المساعدة من بعيد',
			'يتم الآن توجيه قوة امنية لمكان الاستغاثة',
			}
		},
		leo = {
			--draw = '..ﻪﻳﻮﻨﺗ', --تنويه
			draw = '', --تنويه
			color = {r=226,g=139,b=0,a=255},
			notification = {
			'<font color=red>انتبه تم إرسال ',
			'يوجد رجل امن بحاجة إلى مساعدة',
			}
		}
	},
	[8] = {
		location = 'helpme_8',
		blipColor = nil, --nil = red and blue
		citizen = {
			--draw = 'ﺐﻠﻃ ﻦﻣﺍ ﻞﺟﺭ ﻪﺒﺘﻧﺍ', --انتبه رجل امن طلب 
			draw = '', --انتبه رجل امن طلب 
			color = {r=226,g=139,b=0,a=255},
			notification = {
			'<font color=red>انتبه تم إرسال ',
			'يوجد رجل امن بحاجة إلى مساعدة في منطقتك',
			'حاول الابتعاد عن الخطر ان وجد في مكان الاستغاثه',
			'حاول متابعة رجل الامن الذي طلب المساعدة من بعيد',
			'يتم الآن توجيه قوة امنية لمكان الاستغاثة',
			}
		},
		leo = {
			--draw = '..ﻪﻳﻮﻨﺗ', --تنويه
			draw = '', --تنويه
			color = {r=226,g=139,b=0,a=255},
			notification = {
			'<font color=red>انتبه تم إرسال ',
			'يوجد رجل امن بحاجة إلى مساعدة',
			}
		}
	},
	[9] = {
		location = 'helpme_9',
		blipColor = nil, --nil = red and blue
		citizen = {
			--draw = 'ﺐﻠﻃ ﻦﻣﺍ ﻞﺟﺭ ﻪﺒﺘﻧﺍ', --انتبه رجل امن طلب 
			draw = '', --انتبه رجل امن طلب 
			color = {r=226,g=139,b=0,a=255},
			notification = {
			'<font color=red>انتبه تم إرسال ',
			'يوجد رجل امن بحاجة إلى مساعدة في منطقتك',
			'حاول الابتعاد عن الخطر ان وجد في مكان الاستغاثه',
			'حاول متابعة رجل الامن الذي طلب المساعدة من بعيد',
			'يتم الآن توجيه قوة امنية لمكان الاستغاثة',
			}
		},
		leo = {
			--draw = '..ﻪﻳﻮﻨﺗ', --تنويه
			draw = '', --تنويه
			color = {r=226,g=139,b=0,a=255},
			notification = {
			'<font color=red>انتبه تم إرسال ',
			'يوجد رجل امن بحاجة إلى مساعدة',
			}
		}
	},
	[10] = {
		location = 'helpme_10',
		blipColor = nil, --nil = red and blue
		citizen = {
			--draw = 'ﺐﻠﻃ ﻦﻣﺍ ﻞﺟﺭ ﻪﺒﺘﻧﺍ', --انتبه رجل امن طلب 
			draw = '', --انتبه رجل امن طلب 
			color = {r=226,g=139,b=0,a=255},
			notification = {
			'<font color=red>انتبه تم إرسال ',
			'يوجد رجل امن بحاجة إلى مساعدة في منطقتك',
			'حاول الابتعاد عن الخطر ان وجد في مكان الاستغاثه',
			'حاول متابعة رجل الامن الذي طلب المساعدة من بعيد',
			'يتم الآن توجيه قوة امنية لمكان الاستغاثة',
			}
		},
		leo = {
			--draw = '..ﻪﻳﻮﻨﺗ', --تنويه
			draw = '', --تنويه
			color = {r=226,g=139,b=0,a=255},
			notification = {
			'<font color=red>انتبه تم إرسال ',
			'يوجد رجل امن بحاجة إلى مساعدة',
			}
		}
	},
	['sea_port_close'] = {
		location = 'sea_port_close',
		blipColor = blipColor.black,
		DrawText = '<FONT FACE="A9eelsh">ﻖﻠﻐﻣ ﻱﺮﺤﺒﻟﺍ 101 ﺔﻨﻳﺪﻣ ﺀﺎﻨﻴﻣ ', --الكلام الي داخل الأقواس بوسط الشاشة (اذا عربي مقلوب و التعريب)
		citizen = {	
			draw = '', --مغلق
			color = {r=70,g=70,b=70,a=255},
			notification = {
				'<font color=orange>تم اغلاق ',
				'يمنع الدخول منعا باتا ويعتبر مخالف للنظام العام',
				'يحق لرجال الامن اعتقالك فورا او قتلك في حال ضبط داخل الموقع',
				'يتم الاعلان لاحقا عند الافتتاح',
				'تواجدك داخل الميناء الآن يخصم من خبرتك',
			}
		},
		leo = {
			draw = '', --مغلق
			color = {r=70,g=70,b=70,a=255},
			notification = {
				'<font color=orange>تم اغلاق ',
				'يمنع دخول الموطنين منعا باتا ويعتبر مخالف للنظام العام',
				'يحق لرجال الامن احالة المخالفين للسجن مدة 60 شهر كحد اقصى</br><font color=red>عن أمر الرقابة و التفتيش',
				'يتم افتتاح الميناء وفقا للتعاميم والقوانين',
				'يسمح لرجال الامن دخول الميناء للضرورة فقط في حالة اشتباه تسلل مواطن',
				'اغلاق الميناء لا يعني وقت راحة وهروبك من العمل يعرضك لعقوبات مشددة',
			}
		}
	},
	['internationa_close'] = {
		location = 'internationa_close',
		blipColor = blipColor.black,
		DrawText = '<FONT FACE="A9eelsh">ﻖﻠﻐﻣ ﻲﻟﻭﺪﻟﺍ ﺰﻳﺰﻌﻟﺍﺪﺒﻋ ﻚﻠﻤﻟﺍ رﺎﻄﻣ', --الكلام الي داخل الأقواس بوسط الشاشة (اذا عربي مقلوب و التعريب)
		citizen = {	
			draw = '', --مغلق
			color = {r=70,g=70,b=70,a=255},
			notification = {
				'<font color=orange>تم اغلاق ',
				'يمنع الدخول منعا باتا ويعتبر مخالف للنظام العام',
				'يحق لرجال الامن اعتقالك فورا او قتلك في حال ضبط داخل الموقع',
				'يتم الاعلان لاحقا عند الافتتاح',
				'تواجدك داخل الميناء الآن يخصم من خبرتك',
			}
		},
		leo = {
			draw = '', --مغلق
			color = {r=70,g=70,b=70,a=255},
			notification = {
				'<font color=orange>تم اغلاق ',
				'يمنع دخول الموطنين منعا باتا ويعتبر مخالف للنظام العام',
				'يحق لرجال الامن احالة المخالفين للسجن مدة 60 شهر كحد اقصى</br><font color=red>عن أمر الرقابة و التفتيش',
				'يتم افتتاح الميناء وفقا للتعاميم والقوانين',
				'يسمح لرجال الامن دخول الميناء للضرورة فقط في حالة اشتباه تسلل مواطن',
				'اغلاق الميناء لا يعني وقت راحة وهروبك من العمل يعرضك لعقوبات مشددة',
			}
		}
	},
	['seaport_west_close'] = {
		location = 'seaport_west_close',
		blipColor = blipColor.black,
		DrawText = '<FONT FACE="A9eelsh"> ﻖﻠﻐﻣ ﻲﺑﺮﻐﻟﺍ 101 ﺔﻨﻳﺪﻣ ﺀﺎﻨﻴﻣ ', --الكلام الي داخل الأقواس بوسط الشاشة (اذا عربي مقلوب و التعريب)
		citizen = {	
			draw = '', --مغلق
			color = {r=70,g=70,b=70,a=255},
			notification = {
				'<font color=orange>تم اغلاق ',
				'يمنع الدخول منعا باتا ويعتبر مخالف للنظام العام',
				'يحق لرجال الامن اعتقالك فورا او قتلك في حال ضبط داخل الموقع',
				'يتم الاعلان لاحقا عند الافتتاح',
				'تواجدك داخل الميناء الآن يخصم من خبرتك',
			}
		},
		leo = {
			draw = '', --مغلق
			color = {r=70,g=70,b=70,a=255},
			notification = {
				'<font color=orange>تم اغلاق ',
				'يمنع دخول الموطنين منعا باتا ويعتبر مخالف للنظام العام',
				'يحق لرجال الامن احالة المخالفين للسجن مدة 60 شهر كحد اقصى</br><font color=red>عن أمر الرقابة و التفتيش',
				'يتم افتتاح الميناء وفقا للتعاميم والقوانين',
				'يسمح لرجال الامن دخول الميناء للضرورة فقط في حالة اشتباه تسلل مواطن',
				'اغلاق الميناء لا يعني وقت راحة وهروبك من العمل يعرضك لعقوبات مشددة',
			}
		}
	},
	['sea_port_friday'] = {
		location = 'sea_port_friday',
		blipColor = blipColor.black,
		DrawText = '<FONT FACE="A9eelsh">ﻖﻠﻐﻣ 101 ﺔﻨﻳﺪﻣ ﺀﺎﻨﻴﻣ', --الكلام الي داخل الأقواس بوسط الشاشة (اذا عربي مقلوب و التعريب)
		citizen = {	
			draw = '', --مغلق
			color = {r=70,g=70,b=70,a=255},
			notification = {
				'<font color=orange>تم اغلاق ',
				'السبب. يوم الجمعة إجازة للعاملين في ميناء مدينة 101 البحري',
				'يمنع الدخول منعا باتا ويعتبر مخالف للنظام العام',
				'يحق لرجال الامن اعتقالك فورا او قتلك في حال ضبط داخل الموقع',
				'يتم الاعلان لاحقا عند الافتتاح',
			}
		},
		leo = {
			draw = '', --مغلق
			color = {r=70,g=70,b=70,a=255}
		}
	},
	['blaine_meeting'] = {
		location = 'blaine_meeting',
		blipColor = blipColor.gold,
		citizen = {	
			draw = '',
			color = {r=255,g=216,b=0,a=255},
			notification = {
				'تم افتتاح<font color=orange> ',
				'<font color=red>يمنع التخريب اوالقتل داخل الديوان',
				'<font color=red>يمنع الحديث خارج التمثيل',
				'<font color=red>يمنع الحديث عن الشكاوى او الامور البرمجية',
				'حياكم في ديوان مدينة 101 الدعوة عامة',
			}
		},
		leo = {
			draw = '',
			color = {r=255,g=216,b=0,a=255},
			notification = {
				'تم افتتاح<font color=orange> ',
				'<font color=red>يمنع التخريب اوالقتل داخل الديوان',
				'<font color=red>يمنع الحديث خارج التمثيل',
				'<font color=red>يمنع الحديث عن الشكاوى او الامور البرمجية',
				'حياكم في ديوان مدينة 101 الدعوة عامة',
				'يجب اخذ الاذن من العمليات لزيارة الديوان خلال وقت العمل',
			}
		}
	},
	['event_start'] = {
		location = 'event_start',
		blipColor = blipColor.purple,
		DrawText = '<FONT FACE="A9eelsh">ﺔﻴﻟﺎﻌﻔﻟﺍ ﺔﻳﺍﺪﺑ ﺔﻄﻘﻧ', --الكلام الي داخل الأقواس بوسط الشاشة (اذا عربي مقلوب و التعريب)
		citizen = {	
			draw = '',
			color = {r=138,g=0,b=198,a=255},
			notification = {
				'نقطة بداية الفعالية',
			}
		},
		leo = {
			draw = '',
			color = {r=138,g=0,b=198,a=255},
			notification = {
				'نقطة بداية الفعالية',
			}
		}
	},
	['event_location'] = {
		location = 'event_location',
		blipColor = blipColor.purple,
		citizen = {	
			draw = '',
			color = {r=138,g=0,b=198,a=255},
			notification = {
				'موقع الفعالية',
			}
		},
		leo = {
			draw = '',
			color = {r=138,g=0,b=198,a=255},
			notification = {
				'موقع الفعالية',
			}
		}
	},
	['event_registration'] = {
		location = 'event_registration',
		blipColor = blipColor.purple,
		DrawText = '<FONT FACE="A9eelsh">ﺔﻴﻟﺎﻌﻔﻟﺍ ﻞﻴﺠﺴﺗ ﻊﻗﻮﻣ', --الكلام الي داخل الأقواس بوسط الشاشة (اذا عربي مقلوب و التعريب)
		citizen = {	
			draw = '',
			color = {r=138,g=0,b=198,a=255},
			notification = {
				'موقع تسجيل الفعالية',
			}
		},
		leo = {
			draw = '',
			color = {r=138,g=0,b=198,a=255},
			notification = {
				'موقع تسجيل الفعالية',
			}
		}
	},
	['event_end'] = {
		location = 'event_end',
		blipColor = blipColor.purple,
		DrawText = '<FONT FACE="A9eelsh">ﺔﻴﻟﺎﻌﻔﻟﺍ ﺔﻳﺎﻬﻧ ﺔﻄﻘﻧ', --الكلام الي داخل الأقواس بوسط الشاشة (اذا عربي مقلوب و التعريب)
		citizen = {	
			draw = '',
			color = {r=138,g=0,b=198,a=255},
			notification = {
				'نقطة نهاية الفعالية',
			}
		},
		leo = {
			draw = '',
			color = {r=138,g=0,b=198,a=255},
			notification = {
				'نقطة نهاية الفعالية',
			}
		}
	},
	['restricted_area'] = {
		location = 'restricted_area',
		blipColor = blipColor.black,
		citizen = {	
			draw = '',
			color = {r=70,g=70,b=70,a=255},
			notification = {
				'<font color=red>انتبه انت في</br><font color=gray>',
				'<font color=red>عليك مغادرة المنطقة المحظورة فورا',
				'<font color=red>تواجدك في المنطقة المحظورة يخصم من خبرتك',
			}
		},
		leo = {
			draw = '',
			color = {r=70,g=70,b=70,a=255},
			notification = {
				'<font color=red>تم اعلان حالة</br><font color=gray>',
				'<font color=red>يمنع تواجد المواطنين في المنطقة المحظورة',
				'<font color=red>المنطقة المحظورة تخصم من خبرة المواطن',
				'<font color=red>يجب توجيه المواطنين خارج المنطقة المحظورة',
				'<font color=red>يمنع التحقيق مع المتهمين داخل هذه المنطقة ويجب اقتيادهم إلى مكان آخر',
			}
		}
	},
	['restart_time'] = {
		location = 'restart_time',
		blipColor = blipColor.red,
		citizen = {	
			draw = '',
			color = {r=255,g=0,b=0,a=255},
			notification = {
				'<font color=red>تم اعلان حالة</br>',
				'يتم إطفاء السيرفر بعد انقضاء الوقت المحدد',
				'من الافضل لك ان تفصل من السيرفر قبل انتهاء الوقت',
				'يستمر التمثيل مالم يتم اعلان غير ذلك من الرقابة و التفتيش',
			}
		},
		leo = {
			draw = '',
			color = {r=255,g=0,b=0,a=255},
			notification = {
				'<font color=red>تم اعلان حالة</br>',
				'يتم إطفاء السيرفر بعد انقضاء الوقت المحدد',
				'من الافضل لك ان تفصل من السيرفر قبل انتهاء الوقت',
				'يستمر التمثيل مالم يتم اعلان غير ذلك من الرقابة و التفتيش',
			}
		},
		chat = {
			[0] = 'تم إعلان '..'^1',
			[1] = '^7'..' بعد '..'^1%s^7'..' دقيقة.'..'  يبدأ بعد '..'^3%s^7'..' دقيقة',
			[2] = '^7'..' بعد '..'^1%s^7'..' دقيقة '..'^7'..'يستمر التمثيل مالم يتم اعلان غير ذلك. افصل قبل انقضاء الوقت المحدد افضل لك',
			[3] = 'تم إعلان انتهاء '..'^1',
		}
	},	
	['other'] = { --other = استنفار
		location = 'other',
		blipColor = nil, --nil = red and blue
		citizen = {	
			draw = 'ﻲﻨﻣﺍ ﺭﺎﻔﻨﺘﺳﺍ', --استنفار امني في
			color = {r=200,g=0,b=0,a=255},
			notification = {
				'<font color=red>تم اطلاق صافرة الانذار في</br><font color=orange> ',
				'عليك المغادرة فورا وعدم محاولة الدخول حتى زوال الخطر',
				'اتبع ارشادات رجال الأمن ولا تحاول المقاومة',
				'عدم الانصياع للأوامر يعرضك للاعتقال فورا او تعريض حياتك للخطر',
				'رجال الأمن لهم حق</br><font color=red>اطلاق النار</br><font color=white>دون تنبيه في حالة <font color=orange>الاستنفار الأمني',
			}
		},
		leo = {
			draw = 'ﻲﻨﻣﺍ ﺭﺎﻔﻨﺘﺳﺍ', --استنفار امني في
			color = {r=200,g=0,b=0,a=255},
			notification = {
				'<font color=red>تم اطلاق صافرة الانذار في</br><font color=orange> ',
				'عليك الاستعانة بغرفة العمليات لأخذ الاوامر والتوجيه',
				'حافظ على حياتك وحياة المواطنين العزل في منطقة الاستنفار',
				'رجال الأمن لهم حق</br><font color=red>استعمال القوة الجبرية واطلاق النار عند الضرورة</br><font color=white>في منطقة <font color=orange>الاستنفار الأمني',
			}
		}
	}
}

--handcuff
Config.ArrestDistance = 3.0
Config.EnableHandcuffTimer = true
Config.HandcuffTimer = 10 * 60000 -- 10 mins

-- _holsterweapon
Config.UseESX 		  	= true
Config.cooldownPolice 	= 500 -- Will work with ESX only
Config.cooldownCitizen 	= 2000
Config.cooldownCurrent 	= 0

-- _holsterweapon
-- Add/remove weapon hashes here to be added for holster checks.
Config.Weapons = {
	"WEAPON_PISTOL",
	"WEAPON_COMBATPISTOL",
	"WEAPON_APPISTOL",
	"WEAPON_PISTOL50",
	"WEAPON_SNSPISTOL",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_VINTAGEPISTOL",
	--"WEAPON_MARKSMANPISTOL",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_FLAREGUN",
	"WEAPON_STUNGUN",
	"WEAPON_REVOLVER",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_KNIFE",
	"WEAPON_MICROSMG",
}
Config.DrawDistance  = 20
Config.LicenseEnable = true -- only turn this on if you are using esx_license
Config.LicensePrice  = 10000
Config.Color         = { r = 102, g = 0, b = 0 }
Config.Type          = 1
Config.Size          = { x = 1.5, y = 1.5, z = 0.5 }
Config.Zones = {
	BlackWeashop = {
		Legal = false,
		Items = {},
		Locations = {			
			vector3(1693.991, 3759.587, 34.6886),
		}
	}
}

--ktackle Shift + G 
Config.TackleDistance	= 3.0

-----------------------------------------------------------------
-----------------------------------------------------------------
---------------------------Street Label--------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------

-- Use the following variable(s) to adjust the position.
-- adjust the x-axis (left/right)
x = 1.000
-- adjust the y-axis (top/bottom)
y = 0.965
-- If you do not see the HUD after restarting script you adjusted the x/y axis too far.
	
-- Use the following variable(s) to adjust the color(s) of each element.
-- Use the following variables to adjust the color of the border around direction.
border_r = 255
border_g = 255
border_b = 255
border_a = 100

-- Use the following variables to adjust the color of the direction user is facing.
dir_r = 50
dir_g = 100
dir_b = 255
dir_a = 255

-- Use the following variables to adjust the color of the street user is currently on.
curr_street_r = 240
curr_street_g = 200
curr_street_b = 80
curr_street_a = 255

-- Use the following variables to adjust the color of the street around the player. (this will also change the town the user is in)
str_around_r = 255
str_around_g = 255 
str_around_b = 255
str_around_a = 255

-- Use the following variables to adjust the color of the city the player is in (without there being a street around them)
town_r = 255
town_g = 255
town_b = 255
town_a = 255

-----------------------------------------------------------------
-----------------------------------------------------------------
---------------------------tebext store--------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------

--cars.type= truck - car - boat - aircraft  h3
Config.product = {
	['5681200'] = {label='ضعف خبرة 6 ساعات', ra3i=false, timer=21600, rewardMoney=0, name=nil, registerInRecord=true, rewardXp=0, rewardBlackMoney=0, cars=false, weapons=false, chat='', msg1='ةﺮﺒﺧ ﻒﻌﺿ', msg2='تﺎﻋﺎﺳ 6 ةﺮﺒﺧ ﻒﻌﺿ ﺔﻗﺎﺑ ﺖﻤﻠﺘﺳﺍ', msg3='', color1='~w~', color2='~g~', color3='~r~'},
	['5681202'] = {label='ضعف خبرة 12 ساعة', ra3i=false, timer=43200, rewardMoney=0, name=nil, registerInRecord=true, rewardXp=0, rewardBlackMoney=0, cars=false, weapons=false, chat='', msg1='ةﺮﺒﺧ ﻒﻌﺿ', msg2='ﺔﻋﺎﺳ 12 ةﺮﺒﺧ ﻒﻌﺿ ﺔﻗﺎﺑ مﻼﺘﺳﺍ', msg3='', color1='~w~', color2='~g~', color3='~r~'},
	['5681203'] = {label='ضعف خبرة 24 ساعة', ra3i=false, timer=86400, rewardMoney=0, name=nil, registerInRecord=true, rewardXp=0, rewardBlackMoney=0, cars=false, weapons=false, chat='', msg1='ةﺮﺒﺧ ﻒﻌﺿ', msg2='ﺔﻋﺎﺳ 24 ةﺮﺒﺧ ﻒﻌﺿ ﺔﻗﺎﺑ مﻼﺘﺳﺍ', msg3='', color1='~w~', color2='~g~', color3='~r~'},
	['5681213'] = {label='راعي برونزي', ra3i=true, timer=false, name="bronze", rewardMoney=250000, registerInRecord=true, rewardXp=10000, rewardBlackMoney=0, cars=false, weapons=false, chat='', msg1='ﻲﻋﺍﺮﻟﺍ ﺔﻗﺎﻄﺑ', msg2='مﻮﻳ 14 ةﺪﻤﻟ يﺰﻧﻭﺮﺑ ﻲﻋﺍﺭ ﺔﻗﺎﻄﺑ مﻼﺘﺳﺍ', msg3='', color1='~w~', color2='~g~', color3='~r~'},
	['5681214'] = {label='راعي فضي', ra3i=true, timer=false, name="silver", rewardMoney=500000, registerInRecord=true, rewardXp=12000, rewardBlackMoney=0, cars=false, weapons=false, chat='', msg1='ﻲﻋﺍﺮﻟﺍ ﺔﻗﺎﻄﺑ', msg2='مﻮﻳ 14 ةﺪﻤﻟ يﺰﻧﻭﺮﺑ ﻲﻋﺍﺭ ﺔﻗﺎﻄﺑ مﻼﺘﺳﺍ', msg3='', color1='~w~', color2='~g~', color3='~r~'},
	['5681215'] = {label='راعي ذهبي ', ra3i=true, timer=false, name="gold", rewardMoney=1000000, registerInRecord=true, rewardXp=15000, rewardBlackMoney=0, cars=false, weapons=false, chat='', msg1='ﻲﻋﺍﺮﻟﺍ ﺔﻗﺎﻄﺑ', msg2='مﻮﻳ 14 ةﺪﻤﻟ يﺰﻧﻭﺮﺑ ﻲﻋﺍﺭ ﺔﻗﺎﻄﺑ مﻼﺘﺳﺍ', msg3='', color1='~w~', color2='~g~', color3='~r~'},
	['5681216'] = {label='راعي بلاتيني ', ra3i=true, timer=false, name="plat", rewardMoney=1500000, registerInRecord=true, rewardXp=18000, rewardBlackMoney=0, cars=false, weapons=false, chat='', msg1='ﻲﻋﺍﺮﻟﺍ ﺔﻗﺎﻄﺑ', msg2='مﻮﻳ 14 ةﺪﻤﻟ يﺰﻧﻭﺮﺑ ﻲﻋﺍﺭ ﺔﻗﺎﻄﺑ مﻼﺘﺳﺍ', msg3='', color1='~w~', color2='~g~', color3='~r~'},
	['5681217'] = {label='راعي الماسي ', ra3i=true, timer=false, name="diamond", rewardMoney=1750000, registerInRecord=true, rewardXp=25000, rewardBlackMoney=0, cars=false, weapons=false, chat='', msg1='ﻲﻋﺍﺮﻟﺍ ﺔﻗﺎﻄﺑ', msg2='مﻮﻳ 14 ةﺪﻤﻟ يﺰﻧﻭﺮﺑ ﻲﻋﺍﺭ ﺔﻗﺎﻄﺑ مﻼﺘﺳﺍ', msg3='', color1='~w~', color2='~g~', color3='~r~'},
	['5681219'] = {label='راعي رسمي ', ra3i=true, timer=false, name="official", rewardMoney=2000000, registerInRecord=true, rewardXp=35000, rewardBlackMoney=0, cars=false, weapons=false, chat='', msg1='ﻲﻋﺍﺮﻟﺍ ﺔﻗﺎﻄﺑ', msg2='مﻮﻳ 14 ةﺪﻤﻟ يﺰﻧﻭﺮﺑ ﻲﻋﺍﺭ ﺔﻗﺎﻄﺑ مﻼﺘﺳﺍ', msg3='', color1='~w~', color2='~g~', color3='~r~'},
	['5681220'] = {label='راعي إستراتيجي', ra3i=true, timer=false, name="strategy", rewardMoney=2800000, registerInRecord=true, rewardXp=65000, rewardBlackMoney=0, cars=false, weapons=false, chat='', msg1='ﻲﻋﺍﺮﻟﺍ ﺔﻗﺎﻄﺑ', msg2='مﻮﻳ 14 ةﺪﻤﻟ يﺰﻧﻭﺮﺑ ﻲﻋﺍﺭ ﺔﻗﺎﻄﺑ مﻼﺘﺳﺍ', msg3='', color1='~w~', color2='~g~', color3='~r~'},
}

Config.scalformtime = 800

Config.webhookmtgr	= 'https://discord.com/api/webhooks/1219052979424985189/51pvfibISgVYulwjOM-1abZ-mubEtvubIVKp4lB3y9wNrv1EvUkGFdRbxVhBc_9cl3-1'

-----------------------------------------------------------------
-----------------------------------------------------------------
--------------------------control system-------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------

Config.controlSystem = {
	['visa'] = {label='سحب تأشيرة', msg1='', msg2='', msg3='', color1='~w~', color2='~g~', color3='~r~'},
	['warn'] = {label='انذار', msg1='', msg2='', msg3='', color1='~w~', color2='~g~', color3='~r~'},
}


Config.controlSystem.scalformtime = 800
