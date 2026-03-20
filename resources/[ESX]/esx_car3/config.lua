-- Menu configuration, array of menus to display
menuConfigs = {
    --[[['emotes'] = {                                  -- Example menu for emotes when player is on foot
        enableMenu = function()                     -- Function to enable/disable menu handling
            local player = GetPlayerPed(-1)
            return IsPedOnFoot(player)
        end,
        data = {                                    -- Data that is passed to Javascript
            keybind = "~",                         -- Wheel keybind to use
            style = {                               -- Wheel style settings
                sizePx = 600,                       -- Wheel size in pixels
                slices = {                          -- Slice style settings
                    default = { ['fill'] = '#1f1f1f', 	['stroke'] = '#aaaaaa', 	['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover 	= { ['fill'] = '#0094FF', 	['stroke'] = '#aaaaaa', 	['stroke-width'] = 2, ['opacity'] = 0.75 },
                    selected = { ['fill'] = '#1f1f1f', 	['stroke'] = '#aaaaaa', 	['stroke-width'] = 2, ['opacity'] = 0.60 }
                },
                titles = {                          -- Text style settings
                    default = { ['fill'] = '#ffffff', 	['stroke'] = 'none', 	['font'] = 'Verdana', ['font-size'] = 20 },
                    hover 	= { ['fill'] = '#ffffff', 	['stroke'] = 'none', 	['font'] = 'Verdana', ['font-size'] = 20 },
                    selected = { ['fill'] = '#ffffff', 	['stroke'] = 'none', 	['font'] = 'Verdana', ['font-size'] = 20 }
                }
            },
            wheels = {                              -- Array of wheels to display
                {
                    navAngle = 270,                 -- Oritentation of wheel
                    minRadiusPercent = 0.3,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.6,         -- Maximum radius of wheel in percentage
                    labels = {"إلغاء", "لا", "تشجيع", "تصفيق", "ضم اليد", "انتظر على الجدار", "نوم سرير اسعاف"},
                    commands = {"e cancel", "e no", "e cheer", "e slowclap", "e foldarms", "e leanwall", "getintostr"}
                },
                {
                    navAngle = 285,                 -- Oritentation of wheel
                    minRadiusPercent = 0.6,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.9,         -- Maximum radius of wheel in percentage
                    labels = {"استسلام كامل", "تحية", "حبتين", "ضرب الوجه", "اللعنة", "مرهق", "سيجار", "ميت", "حارس","سحب سلاح", "تنظيم جمهور", "حمل ع ظهرك", "حمل على كتفك", "تهديد رهينة"},
                    commands = {"k", "e salute", "e peace", "e palm", "e damn", "e fail",'e cigar',"e dead", "e copidle", "e holster", "e copcrowd2", "ᖵ∀IS∀⅂", "Ͻ∀ꓤꓤ⅄", "𝓣𝓐𝓚𝓔𝓗𝓞𝓢𝓣𝓐𝓖𝓔"}
                }
            }
        }
    },--]]

    ['vehicles'] = {                                -- Example menu for emotes when player is in a vehicle
        enableMenu = function()                     -- Function to enable/disable menu handling
            local player = GetPlayerPed(-1)
            return IsPedInAnyVehicle(player, false)
        end,
        data = {                                    -- Data that is passed to Javascript
            keybind = "~",                         -- Wheel keybind to use
            style = {                               -- Wheel style settings
                sizePx = 400,                       -- Wheel size in pixels
                slices = {                          -- Slice style settings
                    default = { ['fill'] = '#1f1f1f', 	['stroke'] = '#aaaaaa', ['stroke-width'] = 3, ['opacity'] = 0.60 },
                    hover 	= { ['fill'] = '#0094FF', 	['stroke'] = '#aaaaaa', ['stroke-width'] = 3, ['opacity'] = 0.75 },
                    selected = { ['fill'] = '#1f1f1f', 	['stroke'] = '#aaaaaa', ['stroke-width'] = 3, ['opacity'] = 0.60 }
                },
                titles = {                          -- Text style settings
                    default = { ['fill'] = '#ffffff', 	['stroke'] = 'none', ['font'] = 'Verdana', ['font-size'] = 20 },
                    hover 	= { ['fill'] = '#ffffff', 	['stroke'] = 'none', ['font'] = 'Verdana', ['font-size'] = 20 },
                    selected = { ['fill'] = '#ffffff', 	['stroke'] = 'none', ['font'] = 'Verdana', ['font-size'] = 20 }
                }
            },
            wheels = {                              -- Array of wheels to display
                {
                    navAngle = 270,                 -- Oritentation of wheel
                    minRadiusPercent = 0.4,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.8,         -- Maximum radius of wheel in percentage
                    labels = {"سائق","راكب امام","راكب يسار","راكب يمين", "شنطة", "كبوت", "سبوت لايت", "مقعد السائق"},
                    commands = {"door 1","door 2","door 3","door 4", "trunk", "hood", "spotlight", "shuff"}
                }
            }
        }
    }
}

--LeoJobs = {'police','banksecurity','admin','army'}

Config = {}

-- _holsterweapon
Config.UseESX 		  	= true
Config.cooldownPolice 	= 500 -- Will work with ESX only
Config.cooldownCitizen 	= 2000
Config.cooldownCurrent 	= 0

Config.Weapons = {
    "WEAPON_PISTOL",
}

--hide trunk
Config.hidetrunk = {
	blacklisted_model = {
		[1951180813] = 'taco',
		[904750859] = 'mule',
		[-74027062] = 'newsvan',
		[79613282] = 'newsvan2',
		[-956048545] = 'taxi',
		[1208856469] = 'taxi2',
		[444583674] = 'forklift3_docker',
		--trailers
		[-1955694234] = 'trailerswb', 
		[-1889702270] = 'trailerswb2',
	}
}
