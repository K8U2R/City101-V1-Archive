Config                            = {}
Config.DrawDistance               = 20.0
Config.Locale = 'en'
Config.DeliveryTime = 0 -- IN SECOUNDS DEFAULT (18000) IS 5 HOURS / 300 MINUTES
Config.TimeBetweenRobberies = 0.5 -- 30 m
Config.CutOnRobbery = 10 -- IN PERCENTAGE FROM THE TARGET SHOP
Config.RequiredPolices = 0 -- 4
Config.SellValue = 2 -- This is the shops value divided by 2
Config.ChangeNamePrice = 0 -- In $ - how much you can change the shops name for
Config.stopstore = true -- تفعيل نضام الانذارات والسحب التلقائي
Config.maxthder = 3 -- الحد للانذارات

Config.locations = {
  vector3(106.0715, -1280.166, 29.2335),
  vector3(131.7034, -1509.935, 29.14164),
  vector3(-17.08891, -1491.955, 30.28965),
  vector3(-148.4049, -1687.734, 32.87242),
  vector3(43.86791, -1866.915, 22.8245),
  vector3(464.2408, -1894.422, 25.75427),
  vector3(420.3332, -1924.1, 25.63384),
  vector3(232.1122, -1753.374, 29.00237),
  vector3(-962.6316, -2071.461, 9.405881),
  vector3(890.4621, 2855.145, 57.00044),
  vector3(648.5906, 2720.45, 41.85254),
  vector3(591.2153, 2744.16, 42.04297),
  vector3(499.296, 2606.489, 43.69963),
  vector3(556.2795, 2674.616, 42.16859),
  vector3(579.1119, 2678.379, 41.82915),
  vector3(733.7108, 2523.449, 73.22375),
  vector3(739.6578, 2578.498, 75.44101),
  vector3(359.8317, 2975.907, 40.91095),
  vector3(191.822, 3082.239, 43.47281),
  vector3(346.1288, 3406.707, 36.52541),
  vector3(387.5431, 3585.119, 33.29222),
  vector3(97.80875, 3682.489, 39.73381),
  vector3(104.2435, 3727.734, 39.71243),
  vector3(30.44943, 3735.558, 40.62846),
  vector3(12.10054, 3718.616, 39.60349),
  vector3(15.69191, 3687.667, 39.56992),
  vector3(-310.6467, 2793.116, 59.47501),
  vector3(-284.7846, 2535.675, 74.66635),
  vector3(-263.4924, 2196.11, 130.3988),
  vector3(-279.5565, 2206.421, 129.8355),
  vector3(-231.813, 6235.344, 31.49593),
  vector3(-228.7169, 6332.874, 32.40902),
  vector3(-167.7092, 6311.686, 31.45635),
  vector3(-153.6667, 6311.798, 31.48643),
  vector3(-89.45082, 6356.647, 31.57617),
  vector3(-58.41589, 6441.761, 32.68615),
  vector3(-79.68376, 6501.741, 31.49087),
  vector3(-95.5651, 6474.233, 31.42159),
  vector3(-60.45369, 6450.782, 31.49446),
  vector3(-31.04029, 6480.889, 31.4994),
  vector3(-25.0883, 6472.44, 31.48423),
  vector3(413.0643, 6539.474, 27.7308)
}

Config.WeaponCraftTime = 0 * 0

Config.BoxMax = {
  ['market'] = 40,
  ['foodtruck'] = 15,
  ['bar'] = 15,
  ['pharmacie'] = 15,
  ['rts'] = 15,
  ['weapons'] = 15,
  ['SodaMachine'] = 10,
}

Config.addXpForBoxDelivery = 100

Config.Mazad = {
  xp = 35,
  H = 700000, -- حد اعلى
  L = 100000, -- حد ادنى
}
Config.MaxFoodTrucksItems = 200 
Config.is_set_duple = false
Config.Images = {
  [1] = {item = "water",   src = "img/water.png"},
  [2] = {item = "bread",   src = "img/bread.png"},
  [3] = {item = "chocolate",   src = "img/chocolate.png"}, 
  [4] = {item = "cocacola",   src = "img/cocacola.png"},  
  [5] = {item = "cupcake",   src = "img/cupcake.png"},  
  [6] = {item = "phone",   src = "img/phone.png"}, 
  [7] = {item = "m_tool",   src = "img/m_tool.png"}, 
  [8] = {item = "l_tool",   src = "img/l_tool.png"},   
  [9] = {item = "t_tool",   src = "img/t_tool.png"},
  [10] = {item = "s_tool",   src = "img/s_tool.png"}, 
  [11] = {item = "f_tool",   src = "img/jerry.png"}, 
  [12] = {item = "opona",   src = "img/opona.png"}, 
  [13] = {item = "fixtool",   src = "img/fixtool.png"}, 
  [14] = {item = "cigarett",   src = "img/cigarett.png"}, 
  [15] = {item = "lighter",   src = "img/lighter.png"},
  [16] = {item = "croquettes",   src = "img/croquettes.png"},  
  [17] = {item = "grape",   src = "img/grappe.png"},   
  [18] = {item = "sciroppo",   src = "img/sciroppo.png"},
  [19] = {item = "antibiotico",   src = "img/antibiotico.png"},  
  [20] = {item = "antibioticorosacea",   src = "img/antibioticorosacea.png"},
  [21] = {item = "cigarettbox",   src = "img/cigarettbox.png"},
  [22] = {item = "fishbait",   src = "img/fishbait.png"}, 
  [23] = {item = "turtlebait",   src = "img/turtlebait.png"},  
  [24] = {item = "fishingrod",   src = "img/fishingrod.png"},
  [25] = {item = "boxsmall",   src = "img/boxsmall.png"},
  [26] = {item = "boxbig",   src = "img/boxbig.png"},
  [29] = {item = "radio",   src = "img/radio.png"},
  [30] = {item = "bulletproof",   src = "img/bulletproof.png"},
  [31] = {item = "breadbox",   src = "img/burger.png"},
}
Config.LimitPriceFoodTruck = {
  ["water"] = {down = 150, up = 400},
  ["bread"] = {down = 150, up = 400},
  ["chocolate"] = {down = 150, up = 400},
  ["cocacola"] = {down = 150, up = 400},
  ["cupcake"] = {down = 150, up = 400},
  ["speedcamera_detector"] = {down = 7500, up = 10000},
  ["drill"] = {down = 15000, up = 40000},
  ["oxygen_mask"] = {down = 150, up = 400},
  ["m_tool"] = {down = 750, up = 1299},
  ["s_tool"] = {down = 180, up = 350},
  ["f_tool"] = {down = 290, up = 650},
  ["l_tool"] = {down = 220, up = 400},
  ["t_tool"] = {down = 300, up = 600},
  ["t_tool"] = {down = 300, up = 600},
  ["fishingrod"] = {down = 700, up = 1100},
  ["turtlebait"] = {down = 1399, up = 2100},
  ["fishbait"] = {down = 150, up = 250},
  ["laptop_h"] = {down = 15000, up = 25000},
  ["radio"] = {down = 15000, up = 35000},
  ["fixkit"] = {down = 800, up = 1199},
  ["cigarette"] = {down = 20, up = 40},
  ["cheps"] = {down = 150, up = 400},
  ["boxbig"] = {down = 5000, up = 10000},
  ["id_card_f"] = {down = 15000, up = 25000},
  ["id_card"] = {down = 55000, up = 80000},
  ["bulletproof"] = {down = 8000, up = 15000},
}
Config.LimitPriceStores = {
  ["water"] = {down = 150, up = 400},
  ["bread"] = {down = 150, up = 400},
  ["chocolate"] = {down = 150, up = 400},
  ["cocacola"] = {down = 150, up = 400},
  ["cupcake"] = {down = 150, up = 400},
  ["speedcamera_detector"] = {down = 7500, up = 10000},
  ["drill"] = {down = 15000, up = 40000},
  ["oxygen_mask"] = {down = 150, up = 400},
  ["m_tool"] = {down = 750, up = 1299},
  ["s_tool"] = {down = 180, up = 350},
  ["f_tool"] = {down = 290, up = 650},
  ["l_tool"] = {down = 220, up = 400},
  ["t_tool"] = {down = 300, up = 600},
  ["t_tool"] = {down = 300, up = 600},
  ["fishingrod"] = {down = 700, up = 1100},
  ["turtlebait"] = {down = 1399, up = 2100},
  ["fishbait"] = {down = 150, up = 250},
  ["laptop_h"] = {down = 15000, up = 25000},
  ["radio"] = {down = 15000, up = 35000},
  ["fixkit"] = {down = 800, up = 1199},
  ["cigarette"] = {down = 20, up = 40},
  ["cheps"] = {down = 150, up = 400},
  ["boxbig"] = {down = 5000, up = 10000},
  ["id_card_f"] = {down = 15000, up = 25000},
  ["id_card"] = {down = 55000, up = 80000},
  ["bulletproof"] = {down = 8000, up = 15000},
}

Config.limit_can_inv = {
  ['s_tool'] = {limit = 20},
  ['m_tool'] = {limit = 20},
  ['t_tool'] = {limit = 20},
  ['l_tool'] = {limit = 20},
  ['f_tool'] = {limit = 20},
}

Config.Items = {
  ['market'] = { -- 30 متجر
    [1] = {label = "صندوق مياه معدنية", item = "waterbox", price = 1000, itemConvert = 'water', count = 20, max = 1000},
    [2] = {label = "صندوق برجر", item = "breadbox", price = 400, itemConvert = 'bread', count = 20, max = 1000},
    [3] = {label = "صندوق شوكلاتة", item = "chocolatebox", price = 500, itemConvert = 'chocolate', count =  30, max = 2000},
    [4] = {label = "صندوق كولا", item = "cocacolabox", price = 500, itemConvert = 'cocacola', count = 15, max = 2000},
    [5] = {label = "صندوق فطيرة", item = "cupcakebox", price = 700, itemConvert = 'cupcake', count = 25, max = 2000},
    [6] = {label = 'صندوق كاشف رادار', item = "speedcamera_detectorbox", price = 35000, itemConvert = 'speedcamera_detector', count = 10, max = 500},
    [7] = {label = 'صندوق دريل', item = "drill", price = 40000, itemConvert = 'drill', count = 4, max = 200},
    [8] = {label = 'صندوق قناع أكسجين', item = "oxygen_mask", price = 10000, itemConvert = 'oxygen_mask', count = 10, max = 500},
    [22] = {label = 'صندوق طعام حيوانات أليفة', item = "croquettes_box", price = 1000, itemConvert = 'croquettes', count = 10, max = 500},
    [9] =  {label = 'صندوق عدة معادن', item = "minerToolbox", price = 2500, itemConvert = 'm_tool', count = 7, max = 1500},
    [10] = {label = 'صندوق عدة دواجن', item = "slaughtererToolbox", price = 600, itemConvert = 's_tool', count = 7, max = 1500},
    [11] = {label = 'صندوق عدة غاز', item = "f_tool", price = 3500, itemConvert = 'f_tool', count = 50, max = 500},
    [12] = {label = 'صندوق عدة أخشاب', item = "lumberjackToolbox", price = 650, itemConvert = 'l_tool', count = 20, max = 1500},
    [13] = {label = 'صندوق عدة خضروات', item = "boxv_tool", price = 500, itemConvert = 'v_tool', count = 20, max = 1500},
    [14] = {label = 'صندوق عدة أقمشة', item = "tailorToolbox", price = 500, itemConvert = 't_tool', count = 10, max = 1500},
    [15] = {label = 'صندوق خيشة', item = "headbagbox", price = 1500, itemConvert = 'headbag', count = 4, max = 200},
    [16] = {label = 'صندوق سنارة صيد سمك', item = "fishbaitboxX", price = 3500, itemConvert = 'fishingrod', count = 10, max = 500},
    [17] = {label = 'صندوق طعم سلاحف بحرية', item = "turtlebaitbox", price = 2000, itemConvert = 'turtlebait', count = 20, max = 500},
    [18] = {label = 'صندوق طعم اسماك', item = "fishbaitbox", price = 1200, itemConvert = 'fishbait', count = 25, max = 500},
    [19] = {label = 'صندوق لاب توب', item = "laptop_h", price = 160000, itemConvert = 'laptop_h', count = 4, max = 200},
    [20] = {label = 'صندوق راديو', item = "radiobox", price = 40000, itemConvert = 'radio', count = 4, max = 50},
    [21] = {label = 'صندوق عدة تصليح', item = "fixkit", price = 700, itemConvert = 'fixkit', count = 4, max = 150},
    [22] = {label = "صندوق سجائر", item = "cigarette_box", price = 150, itemConvert = 'cigarette', count = 20, max = 500},
    [23] = {label = "صندوق ولاعات", item = "lighter_box", price = 300, itemConvert = 'lighter', count = 20, max = 500},
    [24] = {label = "كرتون شيبس", item = "chepsbox", price = 400, itemConvert = 'cheps', count = 25, max = 2000},
    [25] = {label = "جوال", item = "phonebox", price = 10000, itemConvert = 'phone', count = 25, max = 2000},
    [26] = {label = "شحنات حرارية", item = "thermal_charge_box", price = 2500, itemConvert = 'thermal_charge', count = 25, max = 2000},
    [27] = {label = 'صندوق تعبئة طلقات', item = "boxbig_box", price = 4000, itemConvert = 'boxbig', count = 8, max = 200},
    [28] = {label = "جهاز تهكير بنك صغير", item = "id_card_f_box", price = 1000, itemConvert = 'id_card_f', count = 25, max = 2000},
    [29] = {label = "جهاز تهكير بنك مركزي", item = "id_card_box", price = 1000, itemConvert = 'id_card', count = 25, max = 2000},
    [30] = {label = 'صندوق سترة مضادة للرصاص', item = "bulletproof_box", price = 8000, itemConvert = 'bulletproof', count = 4, max = 200},
  },
  ['foodtruck'] = {
    [1] = {label = "صندوق مياه معدنية", item = "waterbox", price = 1000, itemConvert = 'water', count = 20, max = 1000},
    --[[[2] = {label = "صندوق برجر", item = "breadbox", price = 400, itemConvert = 'bread', count = 20, max = 1000},
    [3] = {label = "صندوق شوكلاتة", item = "chocolatebox", price = 500, itemConvert = 'chocolate', count =  30, max = 2000},
    [4] = {label = "صندوق كولا", item = "cocacolabox", price = 500, itemConvert = 'cocacola', count = 15, max = 2000},
    [5] = {label = "صندوق فطيرة", item = "cupcakebox", price = 700, itemConvert = 'cupcake', count = 25, max = 2000},
    [6] = {label = 'صندوق كاشف رادار', item = "speedcamera_detectorbox", price = 35000, itemConvert = 'speedcamera_detector', count = 10, max = 500},
    [7] = {label = 'صندوق دريل', item = "drill", price = 40000, itemConvert = 'drill', count = 4, max = 200},
    [8] = {label = 'صندوق قناع أكسجين', item = "oxygen_mask", price = 800, itemConvert = 'oxygen_mask', count = 10, max = 500},
    [22] = {label = 'صندوق طعام حيوانات أليفة', item = "croquettes_box", price = 1000, itemConvert = 'croquettes', count = 10, max = 500},
    [9] =  {label = 'صندوق عدة معادن', item = "minerToolbox", price = 2500, itemConvert = 'm_tool', count = 7, max = 1500},
    [10] = {label = 'صندوق عدة دواجن', item = "slaughtererToolbox", price = 600, itemConvert = 's_tool', count = 7, max = 1500},
    [11] = {label = 'صندوق عدة غاز', item = "f_tool", price = 3500, itemConvert = 'f_tool', count = 50, max = 500},
    [12] = {label = 'صندوق عدة أخشاب', item = "lumberjackToolbox", price = 650, itemConvert = 'l_tool', count = 20, max = 1500},
    [13] = {label = 'صندوق عدة خضروات', item = "boxv_tool", price = 500, itemConvert = 'v_tool', count = 20, max = 1500},
    [14] = {label = 'صندوق عدة أقمشة', item = "tailorToolbox", price = 500, itemConvert = 't_tool', count = 10, max = 1500},
    [15] = {label = 'صندوق خيشة', item = "headbagbox", price = 1500, itemConvert = 'headbag', count = 4, max = 200},
    [16] = {label = 'صندوق سنارة صيد سمك', item = "fishbaitboxX", price = 3500, itemConvert = 'fishingrod', count = 10, max = 500},
    [17] = {label = 'صندوق طعم سلاحف بحرية', item = "turtlebaitbox", price = 2000, itemConvert = 'turtlebait', count = 20, max = 500},
    [18] = {label = 'صندوق طعم اسماك', item = "fishbaitbox", price = 1200, itemConvert = 'fishbait', count = 25, max = 500},
    [19] = {label = 'صندوق لاب توب', item = "laptop_h", price = 160000, itemConvert = 'laptop_h', count = 4, max = 200},
    [20] = {label = 'صندوق راديو', item = "radiobox", price = 40000, itemConvert = 'radio', count = 4, max = 50},
    [21] = {label = 'صندوق عدة تصليح', item = "fixkit", price = 700, itemConvert = 'fixkit', count = 4, max = 150},
    [22] = {label = "صندوق سجائر", item = "cigarette_box", price = 150, itemConvert = 'cigarette', count = 20, max = 500},
    [23] = {label = "صندوق ولاعات", item = "lighter_box", price = 300, itemConvert = 'lighter', count = 20, max = 500},
    [24] = {label = "كرتون شيبس", item = "chepsbox", price = 400, itemConvert = 'cheps', count = 25, max = 2000},
    [25] = {label = "جوال", item = "chepsbox", price = 10000, itemConvert = 'phone', count = 25, max = 2000},
    [26] = {label = "شحنات حرارية", item = "chepsbox", price = 2500, itemConvert = 'thermal_charge', count = 25, max = 2000},
    [27] = {label = 'صندوق تعبئة طلقات', item = "boxbig_box", price = 4000, itemConvert = 'boxbig', count = 8, max = 200},
    [28] = {label = "جهاز تهكير بنك صغير", item = "id_card_fbox", price = 1000, itemConvert = 'id_card_f', count = 25, max = 2000},
    [29] = {label = "جهاز تهكير بنك مركزي", item = "id_card", price = 1000, itemConvert = 'id_card', count = 25, max = 2000},
    [30] = {label = 'صندوق سترة مضادة للرصاص', item = "bulletproof_box", price = 8000, itemConvert = 'bulletproof', count = 4, max = 200},--]]
  },
  ['bar'] = { -- 4 بارات
    [1] = {label = "صندوق مياه معدنية", item = "waterbox", price = 900, itemConvert = 'water', count = 20, max = 1000},
   -- [2] = {label = "صندوق برجر", item = "breadbox", price = 150, itemConvert = 'bread', count = 20, max = 1000},
    [2] = {label = "صندوق سجائر", item = "cigarette_box", price = 150, itemConvert = 'cigarette', count = 20, max = 500},
   -- [4] = {label = "صندوق ولاعات", item = "lighter_box", price = 300, itemConvert = 'lighter', count = 20, max = 500},
    [3] = {label = "خمر", item = "beer", itemConvert = 'beer', count = 1, max = 500, Storge = false},
    [4] = {label = "خمر فاخر", item = "grand_cru", itemConvert = 'grand_cru', count = 1, max = 500, Storge = false},
    [5] = {label = "عنب", item = "grape", itemConvert = 'grape', count = 1, max = 1000, Storge = false},
    [6] = {label = "عصير عنب", item = "grape_juice", itemConvert = 'grape_juice', count = 1, max = 1000, Storge = false},
  },
  ['pharmacie'] = { -- 3 صيدليات
    [1] = {label = "صندوق دواء زانكس", item = "xanax_box", price = 3000, itemConvert = 'xanax', count = 25, max = 500},
    [2] = {label = "صندوق ضمادات جروح", item = "bandage_box", price = 2800, itemConvert = 'bandage', count = 15, max = 500},
    [3] = {label = "صندوق إسعافات أولية", item = "medikit_box", price = 15000, itemConvert = 'medikit', count = 15, max = 1000},
  },
  ['rts'] = { -- 3 مطاعم
    [1] = {label = "صندوق مياه معدنية", item = "waterbox", price = 900, itemConvert = 'water', count = 20, max = 1000},
    [2] = {label = "صندوق برجر", item = "breadbox", price = 150, itemConvert = 'bread', count = 20, max = 1000},
    [3] = {label = "صندوق كولا", item = "cocacolabox", price = 500, itemConvert = 'cocacola', count = 15, max = 2000},
    [4] = {label = "صندوق فطيرة", item = "cupcakebox", price = 700, itemConvert = 'cupcake', count = 25, max = 2000},
    [5] = {label = "أكياس بطاطس", item = "batatobox", price = 900, itemConvert = 'batato', count = 25, max = 2000},
    [6] = {label = "كرتون بيبسي", item = "pepsibox", price = 1200, itemConvert = 'pepsi', count = 16, max = 2000},
    [7] = {label = "كرتون سوشي", item = "coshebox", price = 2000, itemConvert = 'coshe', count = 10, max = 2000},
    [8] = {label = "صندوق برجر وسط", item = "bergrulbox", price = 6000, itemConvert = 'bergrul', count = 15, max = 2000},
    [9] = {label = "صندوق وجبة برجر كبير", item = "bergrkbbox", price = 8000, itemConvert = 'bergrkb', count = 15, max = 2000},
  },
  ['weapons'] = { -- 4 محلات اسلحة
    [1] = {label = 'صندوق سترة مضادة للرصاص', item = "bulletproof_box", price = 8000, itemConvert = 'bulletproof', count = 4, max = 200},
    [2] = {label = 'صندوق تعبئة طلقات', item = "boxbig_box", price = 4000, itemConvert = 'boxbig', count = 8, max = 200},
    [3] = {label = 'صندوق منظار يدوي', item = "binoculars_box", price = 20000, itemConvert = 'binoculars', count = 2, max = 100},
    [4] = {label = 'صندوق أدوات أسلحة', item = "weakit_box", price = 72000, itemConvert = 'weakit', count = 6, max = 100},

    [5] = {label = 'عدة تصنيع سلاح', item = "weaponcrafting", price = 160000, itemConvert = 'weaponcrafting', count = 1, instore = false}, -- for crafting

    --weapons
    [6] = {label = 'صندوق مسدس', weapon_label = "مسدس", item = "WEAPON_PISTOL_box", price = 20000, itemConvert = 'WEAPON_PISTOL', type = 'weapon', info = { price = 15000, xp = 10, lisence = "weapon"}, count = 2, max = 100},
    [7] = {label = 'صندوق كشاف', weapon_label = "صندوق", item = "WEAPON_FLASHLIGHT_box", price = 8000, itemConvert = 'WEAPON_FLASHLIGHT', type = 'weapon', info = { price = 3000, xp = 1, lisence = "weapon" }, count = 8, max = 100},
    
    [8] = {label = 'صندوق ساطور', weapon_label = "ساطور", item = "WEAPON_MACHETE_box", price = 12000, itemConvert = 'WEAPON_MACHETE', count = 6, type = 'weapon', info = { price = 5000, xp = 5 , lisence = "weapon" }, black = true, max = 50},
    [9] = {label = 'صندوق سكين', weapon_label = "سكين", item = "WEAPON_SWITCHBLADE_box", price = 6000, itemConvert = 'WEAPON_SWITCHBLADE', count = 6, type = 'weapon', info = { price = 4000, xp = 5, lisence = "weapon" }, black = true, max = 50},
    [10] = {label = 'صندوق فأس', weapon_label = "فأس", item = "WEAPON_BATTLEAXE_box", price = 12000, itemConvert = 'WEAPON_BATTLEAXE', count = 6, type = 'weapon', info = { price = 5000, xp = 5,  lisence = "weapon" }, black = true, max = 50},
    --crafting
    [11] = {label = 'صندوق شوزن', weapon_label = "شوزن", item = 'WEAPON_PUMPSHOTGUN_box', itemConvert = 'WEAPON_PUMPSHOTGUN', count = 2, Storge = false, type = 'weapon', info = { price = 175000, xp = 15, lisence = "weapon"}, black = true, max = 25},
    [12] = {label = 'صندوق مايكرو', weapon_label = "مايكرو", item = 'WEAPON_MICROSMG_box', itemConvert = 'WEAPON_MICROSMG', count = 2, Storge = false, type = 'weapon', info = { price = 150000, xp = 25, lisence = "weapon" }, black = true, max = 25},
    [13] = {label = 'جهاز تهكير البنك المركزي', item = 'id_card_box', itemConvert = 'id_card', count = 2, max = 25},
    [14] = {label = 'جهاز تهكير بنك صغير', item = 'id_card_f_box', itemConvert = 'id_card_f', count = 2, max = 25},
    [15] = {label = 'لابتوب', item = 'laptop_h_box', itemConvert = 'laptop_h', count = 2, max = 25},
    [16] = {label = 'شحنات حرارية', item = 'thermal_charge_box', itemConvert = 'thermal_charge', count = 2, max = 25},
    [17] = {label = 'حبل اسود', item = 'winch', itemConvert = 'winch', count = 2, max = 25},
    [18] = {label = 'دريل ليزر', item = 'laser_drill', itemConvert = 'laser_drill', count = 2, max = 25},
  },
  ['SodaMachine'] = { -- 15 براد
    [1] = {label = "صندوق مياه معدنية", item = "waterbox", price = 1000, itemConvert = 'water', count = 20, max = 1000},
    [3] = {label = "صندوق شوكلاتة", item = "chocolatebox", price = 500, itemConvert = 'chocolate', count =  30, max = 2000},
    [4] = {label = "صندوق كولا", item = "cocacolabox", price = 500, itemConvert = 'cocacola', count = 15, max = 2000},
    [5] = {label = "صندوق فطيرة", item = "cupcakebox", price = 700, itemConvert = 'cupcake', count = 25, max = 2000},
    [6] = {label = "كرتون شيبس", item = "chepsbox", price = 400, itemConvert = 'cheps', count = 25, max = 2000},
  }
}

Config.Storge = {
  [1] = {
    pos = {x = 765.27429199219, y = -3202.6884765625, z = 6.0137372016907 }
  },
  [2] = {
    pos = {x = 765.14129638672, y = -3187.5368652344, z = 6.0254745483398}
  },
  [3] = {
    pos = {x = 819.32800292969, y = -3194.39453125, z = 5.900815486908 }
  },
  [4] = {
    pos = {x = 827.39227294922, y = -3208.3137207031, z = 5.9008197784424}
  },
  [5] = {
    pos = {x = 834.77355957031, y = -3207.8352050781, z = 5.9008164405823}
  },
  [6] = {
    pos = {x = 849.1083984375, y = -3207.359375, z = 5.9007439613342}
  },
  [7] = {
    pos = {x = 854.970703125, y = -3206.9436035156, z = 5.9007487297058}
  },
  [8] = {
    pos = {x = 865.91473388672, y = -3206.6291503906, z = 5.9006609916687}
  },
  [9] = {
    pos = {x = -130.5231, y = -2495.921, z = 5.993408}
  },
}

Config.Storge2 = {
  [1] = {
    pos = {x = -127.93429199219, y = -2535.0184765625, z = 6.0037372016907 }
  },
  [2] = {
    pos = {x = -110.000703125, y = -2509.8136035156, z = 4.8507487297058}
  },
  [3] = {
    pos = {x = -106.070703125, y = -2503.7936035156, z = 4.8507487297058}
  },
  [4] = {
    pos = {x = -122.830703125, y = -2491.9436035156, z = 6.0107487297058}
  },
  [5] = {
    pos = {x = -126.980703125, y = -2497.6536035156, z = 6.0107487297058}
  },
  [6] = {
    pos = {x = -135.220703125, y = -2509.7136035156, z = 6.107487297058}
  },
  [7] = {
    pos = {x = -138.540703125, y = -2514.6636035156, z = 6.1007487297058}
  },
  [8] = {
    pos = {x = -144.90703125, y = -2523.2236035156, z = 6.0007487297058}
  },
}

Config.Zones = {
  ShopCenter = {
    Pos   = {x = -587.7099,   y = -338.4923,  z = 35.14355 - 1.0, number = 'center'},
  },

  crafting = {
    Pos   = {x = 1758.475, y = -1646.36, z = 112.6359 - 1.0, number = 'crafting', craft = true},
  },

  --BAR
  -- [1] = {Type = 'bar', Pos = { x = -116.09439086914, y = 6389.92578125, z = 32.180107116699 - 1.0, number = 1}, Object = { x = -114.68257141113, y = 6384.7504882812, z = 32.180126190186 - 1.0, h = 76.57}},
  -- [101] = {Type = 'bar', Pos = { x = -110.47467803955, y = 6382.4794921875, z = 32.192867279053 - 1.0, number = 101 , red = true}},

  [2] = {Type = 'bar', Pos = { x = 1985.4293212891, y = 3052.6533203125, z = 47.215160369873 - 1.0, number = 2}, Object = { x = 1993.3206787109, y = 3050.5913085938, z = 47.215274810791 - 1.0, h = 4.86}},
  [102] = {Type = 'bar', Pos = { x = 1995.4069824219, y = 3048.7434082031, z = 47.215259552002 - 1.0, number = 102 , red = true}},
  
  [3] = {Type = 'bar', Pos = { x = -1393.7664794922, y = -606.80535888672, z = 30.319547653198 - 1.0, number = 3}, Object = { x = -1382.2415771484, y = -632.43048095703, z = 30.819561004639 - 1.0, h = 222.47}},
  [103] = {Type = 'bar', Pos = { x = -1383.6768798828, y = -629.28344726562, z = 30.819566726685 - 1.0, number = 103 , red = true}},

  --WEAPONS
  [4] = {Type = 'weapons', Pos = { x = 22.060087203979, y = -1107.2180175781, z = 29.797023773193 - 1.0, number = 4}, Object = { x = 6.0188431739807, y = -1103.9655761719, z = 29.797023773193 - 1.0, h = 93.14}},
  [104] = {Type = 'weapons', Pos = { x = 8.6099014282227, y = -1104.1544189453, z = 193.734, number = 104 , red = true}},

  [5] = {Type = 'weapons', Pos = { x = 1693.6502685547, y = 3759.7641601562, z = 34.705310821533 - 1.0, number = 5}, Object = { x = 1699.5583496094, y = 3755.8117675781, z = 34.705368041992 - 1.0, h = 227.04}},
  [105] = {Type = 'weapons', Pos = { x = 1697.7174072266, y = 3758.1162109375, z = 34.705375671387 - 1.0, number = 105 , red = true}},
  
  [6] = {Type = 'weapons', Pos = { x = -330.28884887695, y = 6083.5375976562, z = 31.454761505127 - 1.0, number = 6}, Object = { x = -324.5280456543, y = 6079.5380859375, z = 31.454759597778 - 1.0, h = 220.97}},
  [106] = {Type = 'weapons', Pos = { x = -326.65054321289, y = 6082.021484375, z = 31.45477104187 - 1.0, number = 106 , red = true}},

  --PHARMACIE
  [7] = {Type = 'pharmacie', Pos = { x = 317.83837890625, y = -1076.7145996094, z = 29.478578567505 - 1.0, number = 7}, Object = { x = 326.73440551758, y = -1078.0108642578, z = 29.481616973877 - 1.0, h = 184.52}},
  [107] = {Type = 'pharmacie', Pos = { x = 326.19342041016, y = -1075.9624023438, z = 29.489372253418 - 1.0, number = 107 , red = true}},

  [8] = {Type = 'pharmacie', Pos = {x = -176.140, y = 6383.541, z = 31.495 - 1.0, number = 8}, Object = { x = -175.389, y = 6387.351, z = 31.495 - 1.0, h = 229.28}},
  [108] = {Type = 'pharmacie', Pos = { x = -173.356, y = 6389.105, z = 31.495 - 1.0, number = 108 , red = true}},
  --rts

  --SODAMACHINE
  --[9] = {Type = 'SodaMachine', Pos = { x = 408.91928100586, y = -1613.4937744141, z = 29.291561126709 - 1.0, number = 9}},
  --[10] = {Type = 'SodaMachine', Pos = { x = 1673.8820800781, y = 3834.626953125, z = 34.898639678955 - 1.0, number = 10}},
  --[12] = {Type = 'SodaMachine', Pos = { x = -563.73876953125, y = 5383.263671875, z = 69.544052124023 - 1.0, number = 12}},
  --[13] = {Type = 'SodaMachine', Pos = { x = 815.1201171875, y = -2972.072265625, z = 6.0206570625305 - 1.0, number = 13}},
  --[14] = {Type = 'SodaMachine', Pos = { x = 717.84405517578, y = -2553.4470214844, z = 19.814624786377 - 1.0, number = 14}},
  --[15] = {Type = 'SodaMachine', Pos = { x = 35.372180938721, y = -2537.4694824219, z = 6.1557121276855 - 1.0, number = 15}},
  --[16] = {Type = 'SodaMachine', Pos = { x = 433.52359008789, y = -657.95819091797, z = 28.783494949341 - 1.0, number = 16}},
  --[17] = {Type = 'SodaMachine', Pos = { x = 1147.1302490234, y = -1521.2679443359, z = 34.843738555908 - 1.0, number = 17}},
  --[18] = {Type = 'SodaMachine', Pos = { x = 1847.9249267578, y = 3677.1435546875, z = 34.272296905518 - 1.0, number = 18}},
  --[19] = {Type = 'SodaMachine', Pos = { x = -235.73170471191, y = 6315.9340820312, z = 31.481941223145 - 1.0, number = 19}},
  --[20] = {Type = 'SodaMachine', Pos = { x = 417.98495483398, y = -985.43151855469, z = 29.408435821533 - 1.0, number = 20}},
  --[21] = {Type = 'SodaMachine', Pos = { x = -444.69448852539, y = 6024.0493164062, z = 31.490100860596 - 1.0, number = 21}},
  --[22] = {Type = 'SodaMachine', Pos = { x = 1846.9528808594, y = 2587.4880371094, z = 45.672374725342 - 1.0, number = 22}},

  --Market
  [23] = {Type = 'market', Pos = { x = 268.510009765625, y = -980.1799926757812, z = 29.3700008392334 - 1.0, number = 23}, Object = { x = -173.76063537598, y = 6389.4594726562, z = 31.49561882019 - 1.0, h = 229.28}},
  [123] = {Type = 'market', Pos = {x = 274.6900024414063, y = -983.9199829101564, z = 29.3700008392334 - 1.0, number = 123 , red = true}},

  [24] = {Type = 'market', Pos = { x = -160.308, y = 6322.577, z = 30.595, - 1.0, number = 24}, Object = {x = -167.302, y = 6316.715, z = 30.595 - 1.0, h = 225.4}},
  [124] = {Type = 'market', Pos = {x = -166.542, y = 6317.205, z = 30.595 - 1.0, number = 124 , red = true}},

  [25] = {Type = 'market', Pos = {x = 1961.4779052734, y = 3740.7106933594, z = 32.343734741211 - 1.0, number = 25}, Object = {x = 1960.7133789063, y = 3748.8032226563, z = 32.343734741211 - 1.0, h = 283.32}},
  [125] = {Type = 'market', Pos = {x = 1957.4331054688, y = 3746.9916992188, z = 32.343734741211 - 1.0, number = 125 , red = true}},

  [26] = {Type = 'market', Pos = {x = -1487.4417724609, y = -379.48852539063, z = 40.163387298584 - 1.0, number = 26}, Object = {x = -1479.2185058594, y = -374.1755065918, z = 39.163261413574 - 1.0, h = 219.62}},
  [126] = {Type = 'market', Pos = {x = -1480.2697753906, y = -373.16152954102, z = 39.163249969482 - 1.0, number = 126 , red = true}},

  [30] = {Type = 'market', Pos = { x = 161.48846435547, y = 6640.427734375, z = 31.710620880127 - 1.0, number = 30}, Object = {x = 169.06771850586, y = 6643.439453125, z = 31.710647583008 - 1.0, h = 226.37}},
  [130] = {Type = 'market', Pos = { x = 167.04598999023, y = 6645.6953125, z = 31.710622787476 - 1.0, number = 130 , red = true}},
  
  [28] = {Type = 'market', Pos = { x = -48.471775054932, y = -1757.2221679688, z = 29.421014785767 - 1.0, number = 28}, Object = {x = -42.472969055176, y = -1749.3958740234, z = 29.421016693115 - 1.0, h = 328.88}},
  [128] = {Type = 'market', Pos = { x = -43.516532897949, y = -1750.6414794922, z = 29.421020507813 - 1.0, number = 128 , red = true}},

  [29] = {Type = 'market', Pos = { x = -707.4066, y = -913.8461, z = 19.20361 - 1.0, number = 29}, Object = {x = -708.7912, y = -904.2593, z = 19.20361 - 1.0, h = 84.75}}, 
  [129] = {Type = 'market', Pos = { x = -708.6989, y = -906.2769, z = 19.20361 - 1.0, number = 129 , red = true}},

  [33] = {Type = 'market', Pos = { x = 26.4, y = -1347.152, z = 29.48206 - 1.0, number = 33}, Object = { x = 29.6044, y = -1340.07, z = 29.48206 - 1.0, h = 84.89}},
  [133] = {Type = 'market', Pos = { x = 26.3077, y = -1339.886, z = 29.48206 - 1.0, number = 133 , red = true}},

  [31] = {Type = 'market', Pos = { x = 2678.626, y = 3280.536, z = 55.214114 - 1.0, number = 31}, Object = { x = 2678.626, y = 3280.536, z = 55.214114 - 1.0, h = 84.89}},
  [131] = {Type = 'market', Pos = { x = 2673.357, y = 3285.845, z = 55.24115 - 1.0, number = 131 , red = true}},


  [32] = {Type = 'market', Pos = { x = 292.7000122070313, y = -1271.0899658203125, z = 29.52000045776367 - 1.0, number = 32}, Object = { x = 2678.626, y = 3280.536, z = 55.214114 - 1.0, h = 84.89}},
  [132] = {Type = 'market', Pos = { x =  300.6700134277344, y = -1270.25, z = 29.52000045776367 - 1.0, number = 132 , red = true}},

  --[36] = {Type = 'market', Pos = { x = 26.4, y = -1347.152, z = 29.48206 - 1.0, number = 34}, Object = { x = 29.6044, y = -1340.07, z = 29.48206 - 1.0, h = 84.89}},
  --[136] = {Type = 'market', Pos = { x = 26.3077, y = -1339.886, z = 29.48206 - 1.0, number = 134 , red = true}},
  
  --[[[31] = {Type = 'rts', Pos = { x = 167.62446, y = -1057.5743, z = 29.3274 - 1.0, number = 31}, Object = { x = 172.373, y = -1065.7564, z = 29.3274 - 1.0, h = 196.71}},
  [131] = {Type = 'rts', Pos = { x = 172.01446, y = -1063.1243, z = 29.3274 - 1.0, number = 131 , red = true}},--]]

  --[[[32] = {Type = 'rts', Pos = { x = -169.7446, y = 295.1643, z = 93.7674 - 1.0, number = 32}, Object = { x = -178.233, y = 301.7864, z = 100.9274 - 1.0, h = 129.5}},
  [132] = {Type = 'rts', Pos = { x = -175.3446, y = 304.1343, z = 100.9274 - 1.0, number = 132 , red = true}},--]]
  
  
  --[[[29] = {Type = 'rts', Pos = { x = -439.30, y = -36.96, z = 46.20 - 1.0, number = 29}, Object = { x = -442.47, y = -32.53, z = 40.90 - 1.0, h = 157.88}},
  [129] = {Type = 'rts', Pos = { x = -445.08, y = -36.72, z = 40.90 - 1.0, number = 129 , red = true}},--]]
}