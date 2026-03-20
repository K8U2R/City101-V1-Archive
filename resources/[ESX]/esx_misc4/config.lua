Config = {}


Config.Locale = 'en'




-- Players Blip


Config.jobsBlip = {
    ['police'] = 29,
    ['police2'] = 40,
    ['ambulance'] = 49,
    ['mechanic'] = 47,
}



-- انقطاع التيار الكهربائي عن السيارة

-- مقدار الوقت المستغرق للانقطاع، بالمللي ثانية
-- 2000 = 2 ثانية
Config.BlackoutTime = 2000

-- تمكين التعتيم بسبب تلف السيارة
-- إذا تعرضت المركبة لصدمة أكبر من القيمة المحددة، يتم إيقاف تشغيل اللاعب
Config.BlackoutFromDamage = true
Config.BlackoutDamageRequired = 25

-- تمكين انقطاع التيار الكهربائي بسبب تباطؤ السرعة
-- إذا تباطأت المركبة بسرعة فوق هذه العتبة، يفقد اللاعب وعيه
Config.BlackoutFromSpeed = true
Config.BlackoutSpeedRequired = 45 -- السرعة بالميل في الساعة

-- Enable the disabling of controls if the player is blacked out
Config.DisableControlsOnBlackout = true


-- HOLSTER WEAPON

Config.Weapons = {
    'weapon_pistol',
    'weapon_pistol_mk2',
    'weapon_pumpshotgun',
    'weapon_pumpshotgun_mk2',
    'weapon_stungun',
}
Config.cooldownCurrent = 2000
Config.cooldownPolice = 750


-- WEAPON Level

Config.WeaponLevel = {
    { item = 'WEAPON_PISTOL', level = 15, label = 'مسدس' },

    { item = 'WEAPON_MACHETE', level = 5, label = 'ساطور' },
    { item = 'WEAPON_SWITCHBLADE', level = 5, label = 'سكين' },
    { item = 'WEAPON_BATTLEAXE', level = 5, label = 'فأس' },

    { item = 'WEAPON_MICROSMG', level = 50, label = 'رشاش مايكرو' },
    { item = 'WEAPON_PUMPSHOTGUN', level = 30, label = 'شوزن' },
}

-- Panic

Config.panic_zones = {
    ['DUBLEXP'] = {
        state = true
    },
    
    ['peace_time'] = {
        label = 'ﺔﺣﺍﺭ ﺖﻗﻭ',
        bColor = 83,
        notification = {
            'تم الإعلان عن وقت راحة',
            'يتم تعطيل جميع الوظائف المعتمدة',
            'الرجاء التقيد بالتعليمات في وقت الراحة',
            'يمنع الإجرام في وقت الراحة',
            'تشدد العقوبة في وقت الراحة',
        },
        sendnotification = false,-- dont touch
        done = false,-- dont touch
        color = { r = 128, g = 0, b = 128},
        DrawTextY = 0,-- dont touch
        doSoundAndAnimation = true,
        Blip = nil,-- dont touch
        takexp = false,
        givexp = false,
        BlipPanic = false,
    },

    ['9eanh_time'] = {
        label = 'ﺔﻧﺎﻴﺻ ﺖﻗﻭ',
        bColor = 83,
        notification = {
            'تم الإعلان عن وقت صيانة',
            'يتم تعطيل جميع الوظائف المعتمدة',
            'الرجاء التقيد بالتعليمات في وقت الصيانة',
            'يمنع الإجرام في وقت الصيانة',
            'تشدد العقوبة في وقت الصيانة',
        },
        sendnotification = false,-- لا تلمس
        done = false,-- لا تلمس
        color = { r = 128, g = 0, b = 128},
        DrawTextY = 0,-- لا تلمس
        doSoundAndAnimation = true,
        Blip = nil,-- لا تلمس
        takexp = false,
        givexp = false,
        BlipPanic = false,
    },

    ['restart_time'] = {
        label = 'ﺕﺭﺎﺘﺳﺭ ﺖﻗﻭ',
        bColor = 1,
        notification = {
            'تم الإعلان عن وقت رستارت',
            'يتم اطفاء السيرفر بعد انتهاء الوقت',
            'يمنع عمل سيناريو جديد',
            'انهي السيناريو الحالي في أسرع وقت',
            'تشدد العقوبة في وقت رستارت',
        },
        sendnotification = false,-- dont touch
        done = false,-- dont touch
        color = { r = 128, g = 0, b = 0},
        DrawTextY = 0,-- dont touch
        doSoundAndAnimation = true,
        Blip = nil,-- dont touch
        takexp = false,
        givexp = false,
        BlipPanic = false,
    },

    ['area_port'] = {
        label = 'ﻱﺮﺤﺒﻟﺍ 101 ﺔﻨﻳﺪﻣ ﺀﺎﻨﻴﻣ',
        bColor = 72,
        notification = {
            'تم الإعلان عن إغلاق موقع التصدير',
            'يرجى مغادرة الموقع فورًا',
            'تواجدك داخل الموقع <font color=orange>يخصم</font> من خبرتك الحالية',
            'يمكنك البيع بعد إعلان الإفتتاح',
        },
        sendnotification = false, -- dont touch
        done = false, -- dont touch
        color = { r = 62, g = 63, b = 63},
        DrawTextY = 0,-- dont touch
        doSoundAndAnimation = false,
        Blip = nil,-- dont touch
        takexp = true,
        givexp = false,
        BlipPanic = false,
    },

    ['bank_los'] = {
        label = 'ﻱﺰﻛﺮﻤﻟﺍ ﻚﻨﺒﻟﺍ',
        bColor = 72,
        notification = {
            'أنت حاليًا داخل منطقة استنفار أمني',
            'يرجى مغادرة المنطقة فورًا',
            'الرجاء الإلتزام بإرشادات رجال الأمن',
        },
        sendnotification = false, -- dont touch
        done = false, -- dont touch
        color = { r = 255, g = 0, b = 0},
        DrawTextY = 0,-- dont touch
        doSoundAndAnimation = false,
        Blip = nil,-- dont touch
        takexp = false,
        givexp = true,
        BlipPanic = true, -- blip flash
    },

	['bank_7degh'] = {
        label = 'ﺔﻣﺎﻌﻟﺍ ﺔﻘﻳﺪﺤﻟﺍ ﻑﺮﺼﻣ',
        bColor = 72,
        notification = {
            'أنت حاليًا داخل منطقة استنفار أمني',
            'يرجى مغادرة المنطقة فورًا',
            'الرجاء الإلتزام بإرشادات رجال الأمن',
        },
        sendnotification = false, -- dont touch
        done = false, -- dont touch
        color = { r = 255, g = 0, b = 0},
        DrawTextY = 0,-- dont touch
        doSoundAndAnimation = false,
        Blip = nil,-- dont touch
        takexp = false,
        givexp = true,
        BlipPanic = true, -- blip flash
    },

	['bank_north_los'] = {
        label = 'ﺱﻮﻟ ﻝﺎﻤﺷ ﻑﺮﺼﻣ',
        bColor = 72,
        notification = {
            'أنت حاليًا داخل منطقة استنفار أمني',
            'يرجى مغادرة المنطقة فورًا',
            'الرجاء الإلتزام بإرشادات رجال الأمن',
        },
        sendnotification = false, -- dont touch
        done = false, -- dont touch
        color = { r = 255, g = 0, b = 0},
        DrawTextY = 0,-- dont touch
        doSoundAndAnimation = false,
        Blip = nil,-- dont touch
        takexp = false,
        givexp = true,
        BlipPanic = true, -- blip flash
    },

	['bank_sandy'] = {
        label = 'ﻱﺪﻧﺎﺳ ﻑﺮﺼﻣ',
        bColor = 72,
        notification = {
            'أنت حاليًا داخل منطقة استنفار أمني',
            'يرجى مغادرة المنطقة فورًا',
            'الرجاء الإلتزام بإرشادات رجال الأمن',
        },
        sendnotification = false, -- dont touch
        done = false, -- dont touch
        color = { r = 255, g = 0, b = 0},
        DrawTextY = 0,-- dont touch
        doSoundAndAnimation = false,
        Blip = nil,-- dont touch
        takexp = false,
        givexp = true,
        BlipPanic = true, -- blip flash
    },

	['bank_sa7l'] = {
        label = 'ﻞﺣﺎﺴﻟﺍ ﻑﺮﺼﻣ',
        bColor = 72,
        notification = {
            'أنت حاليًا داخل منطقة استنفار أمني',
            'يرجى مغادرة المنطقة فورًا',
            'الرجاء الإلتزام بإرشادات رجال الأمن',
        },
        sendnotification = false, -- dont touch
        done = false, -- dont touch
        color = { r = 255, g = 0, b = 0},
        DrawTextY = 0,-- dont touch
        doSoundAndAnimation = false,
        Blip = nil,-- dont touch
        takexp = false,
        givexp = true,
        BlipPanic = true, -- blip flash
    },

	['bank_paleto'] = {
        label = 'ﻮﺘﻴﻟﻮﺑ ﻑﺮﺼﻣ',
        bColor = 72,
        notification = {
            'أنت حاليًا داخل منطقة استنفار أمني',
            'يرجى مغادرة المنطقة فورًا',
            'الرجاء الإلتزام بإرشادات رجال الأمن',
        },
        sendnotification = false, -- dont touch
        done = false, -- dont touch
        color = { r = 255, g = 0, b = 0},
        DrawTextY = 0,-- dont touch
        doSoundAndAnimation = false,
        Blip = nil,-- dont touch
        takexp = false,
        givexp = true,
        BlipPanic = true, -- blip flash
    },

	['garage_los_cars'] = {
        label = 'ﻲﻣﻮﻤﻋ ﺱﻮﻟ ﺝﺍﺮﻛ',
        bColor = 72,
        notification = {
            'أنت حاليًا داخل منطقة استنفار أمني',
            'يرجى مغادرة المنطقة فورًا',
            'الرجاء الإلتزام بإرشادات رجال الأمن',
        },
        sendnotification = false, -- dont touch
        done = false, -- dont touch
        color = { r = 255, g = 0, b = 0},
        DrawTextY = 0,-- dont touch
        doSoundAndAnimation = false,
        Blip = nil,-- dont touch
        takexp = false,
        givexp = true,
        BlipPanic = true, -- blip flash
    },

	['garage_los_trucks'] = {
        label = 'ﺕﺎﻨﺣﺎﺷ ﺱﻮﻟ ﺝﺍﺮﻛ',
        bColor = 72,
        notification = {
            'أنت حاليًا داخل منطقة استنفار أمني',
            'يرجى مغادرة المنطقة فورًا',
            'الرجاء الإلتزام بإرشادات رجال الأمن',
        },
        sendnotification = false, -- dont touch
        done = false, -- dont touch
        color = { r = 255, g = 0, b = 0},
        DrawTextY = 0,-- dont touch
        doSoundAndAnimation = false,
        Blip = nil,-- dont touch
        takexp = false,
        givexp = true,
        BlipPanic = true, -- blip flash
    },

	['garage_sandy_cars'] = {
        label = 'ﻲﻣﻮﻤﻋ ﻱﺪﻧﺎﺳ ﺝﺍﺮﻛ',
        bColor = 72,
        notification = {
            'أنت حاليًا داخل منطقة استنفار أمني',
            'يرجى مغادرة المنطقة فورًا',
            'الرجاء الإلتزام بإرشادات رجال الأمن',
        },
        sendnotification = false, -- dont touch
        done = false, -- dont touch
        color = { r = 255, g = 0, b = 0},
        DrawTextY = 0,-- dont touch
        doSoundAndAnimation = false,
        Blip = nil,-- dont touch
        takexp = false,
        givexp = true,
        BlipPanic = true, -- blip flash
    },

	['garage_sandy_trucks'] = {
        label = 'ﺕﺎﻨﺣﺎﺷ ﻱﺪﻧﺎﺳ ﺝﺍﺮﻛ',
        bColor = 72,
        notification = {
            'أنت حاليًا داخل منطقة استنفار أمني',
            'يرجى مغادرة المنطقة فورًا',
            'الرجاء الإلتزام بإرشادات رجال الأمن',
        },
        sendnotification = false, -- dont touch
        done = false, -- dont touch
        color = { r = 255, g = 0, b = 0},
        DrawTextY = 0,-- dont touch
        doSoundAndAnimation = false,
        Blip = nil,-- dont touch
        takexp = false,
        givexp = true,
        BlipPanic = true, -- blip flash
    },

	['garage_paleto_cars'] = {
        label = 'ﻲﻣﻮﻤﻋ ﻮﺘﻴﻟﻮﺑ ﺝﺍﺮﻛ',
        bColor = 72,
        notification = {
            'أنت حاليًا داخل منطقة استنفار أمني',
            'يرجى مغادرة المنطقة فورًا',
            'الرجاء الإلتزام بإرشادات رجال الأمن',
        },
        sendnotification = false, -- dont touch
        done = false, -- dont touch
        color = { r = 255, g = 0, b = 0},
        DrawTextY = 0,-- dont touch
        doSoundAndAnimation = false,
        Blip = nil,-- dont touch
        takexp = false,
        givexp = true,
        BlipPanic = true, -- blip flash
    },

	['garage_paleto_trucks'] = {
        label = 'ﺕﺎﻨﺣﺎﺷ ﻮﺘﻴﻟﻮﺑ ﺝﺍﺮﻛ',
        bColor = 72,
        notification = {
            'أنت حاليًا داخل منطقة استنفار أمني',
            'يرجى مغادرة المنطقة فورًا',
            'الرجاء الإلتزام بإرشادات رجال الأمن',
        },
        sendnotification = false, -- dont touch
        done = false, -- dont touch
        color = { r = 255, g = 0, b = 0},
        DrawTextY = 0,-- dont touch
        doSoundAndAnimation = false,
        Blip = nil,-- dont touch
        takexp = false,
        givexp = true,
        BlipPanic = true, -- blip flash
    },

	['port_one'] = {
        label = 'ﻲﺴﻴﺋﺮﻟﺍ ﺀﺎﻨﻴﻤﻟﺍ',
        bColor = 72,
        notification = {
            'أنت حاليًا داخل منطقة استنفار أمني',
            'يرجى مغادرة المنطقة فورًا',
            'الرجاء الإلتزام بإرشادات رجال الأمن',
        },
        sendnotification = false, -- dont touch
        done = false, -- dont touch
        color = { r = 255, g = 0, b = 0},
        DrawTextY = 0,-- dont touch
        doSoundAndAnimation = false,
        Blip = nil,-- dont touch
        takexp = false,
        givexp = true,
        BlipPanic = true, -- blip flash
    },

	['port_two'] = {
        label = 'ﻲﺑﺮﻐﻟﺍ ﺀﺎﻨﻴﻤﻟﺍ',
        bColor = 72,
        notification = {
            'أنت حاليًا داخل منطقة استنفار أمني',
            'يرجى مغادرة المنطقة فورًا',
            'الرجاء الإلتزام بإرشادات رجال الأمن',
        },
        sendnotification = false, -- dont touch
        done = false, -- dont touch
        color = { r = 255, g = 0, b = 0},
        DrawTextY = 0,-- dont touch
        doSoundAndAnimation = false,
        Blip = nil,-- dont touch
        takexp = false,
        givexp = true,
        BlipPanic = true, -- blip flash
    },

	['port_tws3h_one'] = {
        label = '1 ﺔﻌﺳﻮﺗ',
        bColor = 72,
        notification = {
            'أنت حاليًا داخل منطقة استنفار أمني',
            'يرجى مغادرة المنطقة فورًا',
            'الرجاء الإلتزام بإرشادات رجال الأمن',
        },
        sendnotification = false, -- dont touch
        done = false, -- dont touch
        color = { r = 255, g = 0, b = 0},
        DrawTextY = 0,-- dont touch
        doSoundAndAnimation = false,
        Blip = nil,-- dont touch
        takexp = false,
        givexp = true,
        BlipPanic = true, -- blip flash
    },

	['port_tws3h_two'] = {
        label = '2 ﺔﻌﺳﻮﺗ',
        bColor = 72,
        notification = {
            'أنت حاليًا داخل منطقة استنفار أمني',
            'يرجى مغادرة المنطقة فورًا',
            'الرجاء الإلتزام بإرشادات رجال الأمن',
        },
        sendnotification = false, -- dont touch
        done = false, -- dont touch
        color = { r = 255, g = 0, b = 0},
        DrawTextY = 0,-- dont touch
        doSoundAndAnimation = false,
        Blip = nil,-- dont touch
        takexp = false,
        givexp = true,
        BlipPanic = true, -- blip flash
    },

	['port_tws3h_three'] = {
        label = '3 ﺔﻌﺳﻮﺗ',
        bColor = 72,
        notification = {
            'أنت حاليًا داخل منطقة استنفار أمني',
            'يرجى مغادرة المنطقة فورًا',
            'الرجاء الإلتزام بإرشادات رجال الأمن',
        },
        sendnotification = false, -- dont touch
        done = false, -- dont touch
        color = { r = 255, g = 0, b = 0},
        DrawTextY = 0,-- dont touch
        doSoundAndAnimation = false,
        Blip = nil,-- dont touch
        takexp = false,
        givexp = true,
        BlipPanic = true, -- blip flash
    },

	['port_tws3h_four'] = {
        label = '4 ﺔﻌﺳﻮﺗ',
        bColor = 72,
        notification = {
            'أنت حاليًا داخل منطقة استنفار أمني',
            'يرجى مغادرة المنطقة فورًا',
            'الرجاء الإلتزام بإرشادات رجال الأمن',
        },
        sendnotification = false, -- dont touch
        done = false, -- dont touch
        color = { r = 255, g = 0, b = 0},
        DrawTextY = 0,-- dont touch
        doSoundAndAnimation = false,
        Blip = nil,-- dont touch
        takexp = false,
        givexp = true,
        BlipPanic = true, -- blip flash
    },

	['public_7degh'] = {
        label = 'ﺔﻣﺎﻌﻟﺍ ﺔﻘﻳﺪﺤﻟﺍ',
        bColor = 72,
        notification = {
            'أنت حاليًا داخل منطقة استنفار أمني',
            'يرجى مغادرة المنطقة فورًا',
            'الرجاء الإلتزام بإرشادات رجال الأمن',
        },
        sendnotification = false, -- dont touch
        done = false, -- dont touch
        color = { r = 255, g = 0, b = 0},
        DrawTextY = 0,-- dont touch
        doSoundAndAnimation = false,
        Blip = nil,-- dont touch
        takexp = false,
        givexp = true,
        BlipPanic = true, -- blip flash
    },

    ['player_location'] = {
        label = 'ﻡﺎﻋ ﻥﺎﻜﻣ',
        bColor = 72,
        notification = {
            'أنت حاليًا داخل منطقة استنفار أمني',
            'يرجى مغادرة المنطقة فورًا',
            'الرجاء الإلتزام بإرشادات رجال الأمن',
        },
        sendnotification = false, -- dont touch
        done = false, -- dont touch
        color = { r = 255, g = 0, b = 0},
        DrawTextY = 0,-- dont touch
        doSoundAndAnimation = false,
        Blip = nil,-- dont touch
        takexp = false,
        givexp = true,
        BlipPanic = true, -- blip flash
    },

    ['help_me_police'] = {
        label = 'ﺔﺛﺎﻐﺘﺳﺇ ﺀﺍﺪﻧ',
        bColor = 72,
        notification = {
            'أنت حاليًا داخل منطقة <font color=orange>نداء استغاثة',
            'الرجاء الإبتعاد عن الموقع ومراقبة رجل الأمن',
            'وحدات الدعم قادمة في أسرع وقت',
        },
        sendnotification = false, -- dont touch
        done = false, -- dont touch
        color = { r = 250, g = 125, b = 6},
        DrawTextY = 0,-- dont touch
        doSoundAndAnimation = false,
        Blip = nil,-- dont touch
        takexp = false,
        givexp = true,
        BlipPanic = true, -- blip flash
    },

    ['help_me_police2'] = {
        label = 'ﺔﺛﺎﻐﺘﺳﺇ ﺀﺍﺪﻧ',
        bColor = 72,
        notification = {
            'أنت حاليًا داخل منطقة <font color=orange>نداء استغاثة',
            'الرجاء الإبتعاد عن الموقع ومراقبة رجل الأمن',
            'وحدات الدعم قادمة في أسرع وقت',
        },
        sendnotification = false, -- dont touch
        done = false, -- dont touch
        color = { r = 250, g = 125, b = 6},
        DrawTextY = 0,-- dont touch
        doSoundAndAnimation = false,
        Blip = nil,-- dont touch
        takexp = false,
        givexp = true,
        BlipPanic = true, -- blip flash
    },
}


----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------

--ClarkXpSystem
Config.Duble = 1

Config.time = 7 --second to wait before give xp

Config.xp = { --value of xp to get every time
	gov = 35,
	citizen = 15
}

Config.DrawDistance = 30.0
Config.Zones2ize     = {x = 1.5, y = 1.5, z = 1.5}
Config.MarkerColor  = {r = 255, g = 255, b = 255}
Config.MarkerType   = 36

Config.Zones2 = {
	vector3(431.00, -1024.4, 28.85)
}

Config.PetShop = {
	{
		pet = 'chien',
		label = 'كلب',
		price = 50000
	},

	{
		pet = 'chat',
		label = 'قطه',
		price = 15000
	},

	{
		pet = 'lapin',
		label = 'ارنب',
		price = 25000
	},

	{
		pet = 'husky',
		label = 'كلب هاسكي',
		price = 35000
	},

	--[[{ حق كفار ماينفع
		pet = 'cochon',
		label = _U('pig'),
		price = 10000
	},]]

	{
		pet = 'caniche',
		label = 'كلب بودل',
		price = 50000
	},

	{
		pet = 'carlin',
		label = 'كلب بك',
		price = 6000
	},

	{
		pet = 'retriever',
		label = 'كلب رتريفر',
		price = 10000
	},

	{
		pet = 'berger',
		label = 'كلب اللاستن',
		price = 55000
	},

	{
		pet = 'westie',
		label = 'كلب صغير وستي',
		price = 50000
	},

	{
		pet = 'chop',
		label = 'كلب جوب',
		price = 12000
	}
}

Config.Zones = {
	PetShop = {
		Pos = {x = 562.46, y = 2739.68, z = 42.57 },
		Sprite = 463,
		Display = 4,
		Scale = 1.0,
		Size  = {x = 1.5, y = 1.5, z = 1.5},
		Color = { r = 247, g = 213, b = 0 },
		Type  = 31
	}
}

--esx_outlawalert

-- Set the time (in minutes) during the player is outlaw
Config.Timer = 1

-- Set if show alert when player use gun
Config.GunshotAlert = true

-- Set if show when player do carjacking
Config.CarJackingAlert = false

-- Set if show when player fight in melee
Config.MeleeAlert = false

-- In seconds
Config.BlipGunTime = 25

-- Blip radius, in float value!
Config.BlipGunRadius = 160.0

-- In seconds
Config.BlipMeleeTime = 7

-- Blip radius, in float value!
Config.BlipMeleeRadius = 200.0

-- In seconds
Config.BlipJackingTime = 10

-- Blip radius, in float value!
Config.BlipJackingRadius = 50.0

-- Show notification when cops steal too?
Config.ShowCopsMisbehave = true

-- Jobs in this table are considered as cops
Config.WhitelistedCops = {
	'police'
}

-- LegacyFuel

-- Are you using ESX? Turn this to true if you would like fuel & jerry cans to cost something.
Config.UseESX = true

-- What should the price of jerry cans be?
Config.JerryCanCost = 250
Config.RefillCost = 100 -- If it is missing half of it capacity, this amount will be divided in half, and so on.

-- Fuel decor - No need to change this, just leave it.
Config.FuelDecor = "_FUEL_LEVEL"

-- What keys are disabled while you're fueling.
Config.DisableKeys = {0, 22, 23, 24, 29, 30, 31, 37, 44, 56, 82, 140, 166, 167, 168, 170, 288, 289, 311, 323}

-- Want to use the HUD? Turn this to true.
Config.EnableHUD = false

-- Configure blips here. Turn both to false to disable blips all together.
Config.ShowNearestGasStationOnly = true
Config.ShowAllGasStations = false

-- Modify the fuel-cost here, using a multiplier value. Setting the value to 2.0 would cause a doubled increase.
Config.CostMultiplier = 1.6

-- Configure the strings as you wish here.
Config.Strings = {
--	ExitVehicle = "ﺔﺌﺒﻌﺘﻠﻟ ﺔﺒﻛﺮﻤﻟﺍ ﻦﻣ ﺝﻭﺮﺨﻟﺍ ﻚﻴﻠﻋ ﺐﺠﻳ",
--	EToRefuel = "ﺔﺒﻛﺮﻤﻟﺍ ﺔﺌﺒﻌﺘﻟ ~r~E ~w~ﻂﻐﺿﺇ ",
--	JerryCanEmpty = "ﺔﻏﺭﺎﻓ ﺩﻮﻗﻮﻟﺍ ﺔﺒﻠﻋ",
---	FullTank = "ﺊﻠﺘﻤﻣ ﻥﺍﺰﺨﻟﺍ",
--	PurchaseJerryCan = Config.JerryCanCost .."~g~$ ~w~ﻎﻠﺒﻤﺑ ﺩﻮﻗﻮﻟﺍ ﺔﺒﻠﻋ ﺔﺌﺒﻌﺘﻟ ~r~E ~w~ ﻂﻐﺿﺇ" ,
--	CancelFuelingPump = "ﺔﺌﺒﻌﺘﻟﺍ ﺀﺎﻐﻟﻹ ~r~E ~w~ﻂﻐﺿﺇ",
--	CancelFuelingJerryCan = "ﺔﺌﺒﻌﺘﻟﺍ ﺀﺎﻐﻟﻹ ~r~E ~w~ﻂﻐﺿﺇ",
--	NotEnoughCash = "~r~ﺔﺌﺒﻌﺘﻠﻟ ﻲﻓﺎﻜﻟﺍ ﻎﻠﺒﻤﻟﺍ ﻚﻠﺘﻤﺗ ﻻ",
--	RefillJerryCan = " ﻎﻠﺒﻤﺑ ﺩﻮﻗﻮﻟﺍ ﺔﺒﻠﻋ ﺔﺌﺒﻌﺘﻟ ~r~E ~w~ﻂﻐﺿﺇ",
--	NotEnoughCashJerryCan = "~r~ﺀﺍﺮﺸﻠﻟ ﻲﻓﺎﻜﻟﺍ ﻎﻠﺒﻤﻟﺍ ﻚﻠﺘﻤﺗ ﻻ",
--	JerryCanFull = "ﺔﺌﻠﺘﻤﻣ ﺩﻮﻗﻮﻟﺍ ﺔﺒﻠﻋ",
--	TotalCost = "ﺔﻔﻠﻜﺘﻟﺍ",
}

if not Config.UseESX then
	Config.Strings.PurchaseJerryCan = "Press ~g~E ~w~to grab a jerry can"
	Config.Strings.RefillJerryCan = "Press ~g~E ~w~ to refill the jerry can"
end

Config.PumpModels = {
	[-2007231801] = true,
	[1339433404] = true,
	[1694452750] = true,
	[1933174915] = true,
	[-462817101] = true,
	[-469694731] = true,
	[-164877493] = true
}

-- Blacklist certain vehicles. Use names or hashes. https://wiki.gtanet.work/index.php?title=Vehicle_Models
Config.Blacklist = {
	--"Adder",
	--276773164
}

-- Do you want the HUD removed from showing in blacklisted vehicles?
Config.RemoveHUDForBlacklistedVehicle = true

-- Class multipliers. If you want SUVs to use less fuel, you can change it to anything under 1.0, and vise versa.
Config.Classes = {
	[0] = 1.0, -- Compacts
	[1] = 1.0, -- Sedans
	[2] = 1.0, -- SUVs
	[3] = 1.0, -- Coupes
	[4] = 1.0, -- Muscle
	[5] = 1.0, -- Sports Classics
	[6] = 1.0, -- Sports
	[7] = 1.0, -- Super
	[8] = 1.0, -- Motorcycles
	[9] = 1.0, -- Off-road
	[10] = 1.0, -- Industrial
	[11] = 1.0, -- Utility
	[12] = 1.0, -- Vans
	[13] = 0.0, -- Cycles
	[14] = 1.0, -- Boats
	[15] = 1.0, -- Helicopters
	[16] = 1.0, -- Planes
	[17] = 1.0, -- Service
	[18] = 1.0, -- Emergency
	[19] = 1.0, -- Military
	[20] = 1.0, -- Commercial
	[21] = 1.0, -- Trains
}

-- The left part is at percentage RPM, and the right is how much fuel (divided by 10) you want to remove from the tank every second
Config.FuelUsage = {
	[1.0] = 1.4,
	[0.9] = 1.2,
	[0.8] = 1.0,
	[0.7] = 0.9,
	[0.6] = 0.8,
	[0.5] = 0.7,
	[0.4] = 0.5,
	[0.3] = 0.4,
	[0.2] = 0.2,
	[0.1] = 0.1,
	[0.0] = 0.0,
}

Config.GasStations = {
	vector3(49.4187, 2778.793, 58.043),
	vector3(263.894, 2606.463, 44.983),
	vector3(1039.958, 2671.134, 39.550),
	vector3(1207.260, 2660.175, 37.899),
	vector3(2539.685, 2594.192, 37.944),
	vector3(2679.858, 3263.946, 55.240),
	vector3(2005.055, 3773.887, 32.403),
	vector3(1687.156, 4929.392, 42.078),
	vector3(1701.314, 6416.028, 32.763),
	vector3(179.857, 6602.839, 31.868),
	vector3(-94.4619, 6419.594, 31.489),
	vector3(-2554.996, 2334.40, 33.078),
	vector3(-1800.375, 803.661, 138.651),
	vector3(-1437.622, -276.747, 46.207),
	vector3(-2096.243, -320.286, 13.168),
	vector3(-724.619, -935.1631, 19.213),
	vector3(-526.019, -1211.003, 18.184),
	vector3(-70.2148, -1761.792, 29.534),
	vector3(265.648, -1261.309, 29.292),
	vector3(819.653, -1028.846, 26.403),
	vector3(1208.951, -1402.567,35.224),
	vector3(1181.381, -330.847, 69.316),
	vector3(620.843, 269.100, 103.089),
	vector3(2581.321, 362.039, 108.468),
	vector3(176.631, -1562.025, 29.263),
	vector3(176.631, -1562.025, 29.263),
	vector3(-319.292, -1471.715, 30.549),
	vector3(1784.324, 3330.55, 41.253)
}


--PanicBottom
Config.JobColors = {
    ["admin"] = "^1 الرقابة و التفتيش",
    ["police2"] = "^2 احرس الحدود 💂‍♂️ | ",
    ["police"] = "^4 الـشـرطـة 👮 | ",
	["default"] = "^8"
}

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