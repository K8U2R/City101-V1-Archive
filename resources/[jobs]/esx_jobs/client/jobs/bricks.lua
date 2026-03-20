Config.Jobs.bricks = {

    BlipInfos = {
        Sprite = 501,
        Color = 6
    },

    Vehicles = {

        Truck = {
            Spawner = 1,
            Hash = "nissanditsun",
            Trailer = "none",
            HasCaution = true
        }

    },

    Zones = {

        CloakRoom = {
            Pos = {x = 141.21, y = -379.59, z = 43.26},
            Size = {x = 3.0, y = 3.0, z = 1.0},
            Color = {r = 102, g = 0, b = 0},
            Marker = 21,
            Blip = true,
            Name = ("<FONT FACE='A9eelsh'>1 - ﻝﻮﺧﺩ ﻞﻴﺠﺴﺗ<"),
            Type = "cloakroom",
            Hint = _U("cloak_change")
        },
		
        brickwork = {
            Pos = {x = 976.71, y = -1919.35, z = 30.18},
            Size = {x = 4.5, y = 4.5, z = 1.5},
            Color = {r = 102, g = 0, b = 0},
            Marker = 1,
            Blip = true,
            Name = ("<FONT FACE='A9eelsh'>2 - ﻰﻟﻭﻻﺍ ﻩﻮﻄﺨﻟﺍ<"),
            Type = "work",
            Item = {
                {
                    name = "أسمنت",
                    db_name = "cement",
                    time = 1300,
                    max = 20,
                    add = 1,
                    remove = 1,
                    requires = "brickworkkit",
                    requires_name = "عدة عمل طوب",
                    drop = 100
                }
            },
            Hint = _U("bs_pickup")
        },

        concrete_mix = {
            Pos = {x = 990.52, y = 2363.68, z = 50.50},
            Size = {x = 4.5, y = 4.5, z = 1.0},
            Color = {r = 102, g = 0, b = 0},
            Marker = 1,
            Blip = true,
            Name = ("<FONT FACE='A9eelsh'>3 - ﺔﻴﻧﺎﺜﻟﺍ ﻩﻮﻄﺨﻟﺍ<"),
            Type = "work",
            Item = {
                {
                    name = "خلطة خرأسانية",
                    db_name = "concretemix",
                    time = 1300,
                    max = 20,
                    add = 1,
                    remove = 1,
                    requires = "cement",
                    requires_name = "أسمنت",
                    drop = 100
                }
            },
            Hint = _U("bs_cutwood_button")
        },

        Bricks_1 = {
            Pos = {x = 2709.26, y = 1514.76, z = 23.25},
            Size = {x = 4.5, y = 4.5, z = 1.0},
            Color = {r = 102, g = 0, b = 0},
            Marker = 1,
            Blip = true,
            Name = ("<FONT FACE='A9eelsh'>4 - ﺔﺜﻟﺎﺜﻟﺍ ﻩﻮﻄﺨﻟﺍ<"),
            Type = "work",
            Item = {
                {
                    name = "طوب",
                    db_name = "bricks",
                    time = 1300,
                    max = 100,
                    add = 5,
                    remove = 1,
                    requires = "concretemix",
                    requires_name = "خلطة خرأسانية",
                    drop = 100
                }
            },
            Hint = _U("bs_pick_boards")
        },

        VehicleSpawner = {
            Pos = {x = 147.59, y = -371.63, z = 43.50},
            Size = {x = 3.0, y = 3.0, z = 2.5},
            Color = {r = 148, g = 238, b = 44},
            Marker = 39,
            Blip = false,
            Name = ("<FONT FACE='A9eelsh'>ﺔﺒﻛﺮﻤﻟﺍ ﺝﺍﺮﺨﺘﺳﺍ<"),
            Type = "vehspawner",
            Spawner = 1,
            Hint = _U("spawn_veh_button"),
            Caution = 2000
        },

        VehicleSpawnPoint = {
            Pos = {x = 147.73, y = -351.93, z = 43.47},
            Size = {x = 3.0, y = 3.0, z = 1.0},
            Marker = -1,
            Blip = false,
            Name = ("<FONT FACE='A9eelsh'>ﺔﺒﻛﺮﻤﻟﺍ ﻡﻼﺘﺳﺍ<"),
            Type = "vehspawnpt",
            Spawner = 1,
            Heading = 264.40
        },

        VehicleDeletePoint = {
            Pos = {x = 133.13, y = -382.59, z = 43.50},
            Size = {x = 3.0, y = 3.0, z = 2.5},
            Color = {r = 102, g = 0, b = 0},
            Marker = 39,
            Blip = false,
            Name = ("<FONT FACE='A9eelsh'>ﺔﺒﻛﺮﻤﻟﺍ ﻢﻴﻠﺴﺗ<"),
            Type = "vehdelete",
            Hint = _U("return_vh_button"),
            Spawner = 1,
            Caution = 2000,
            GPS = 0,
            Teleport = 0
        },

        bricks_del1 = {
            Pos = {x = -92.32, y = -2389.13, z = 6.0},
            Size = {x = 5.5, y = 5.5, z = 1.0},
            Color = {r = 102, g = 0, b = 0},
            Marker = -1,
            Blip = true,
            Name = ("<FONT FACE='A9eelsh'>5 - ﺏﻮﻄﻟﺍ ﻊﻴﺑ<"),
            Type = "delivery",
            Spawner = 1,
            Item = {
                {
                    name = _U("delivery"),
                    time = 1200,
                    remove = 1,
                    max = 100, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
                    price = 180,
                    xp = 11,
                    requires = "bricks",
                    requires_name = "طوب",
                    drop = 100
                }
            },
            Hint = _U("bs_pick_bay")
        },

        bricks_del2 = {
            Pos = {x = 980.07, y = -2919.83, z = 5.9},
            Size = {x = 5.5, y = 5.5, z = 1.0},
            Color = {r = 102, g = 0, b = 0},
            Marker = -1,
            Blip = true,
            Name = ("<FONT FACE='A9eelsh'>5 - ﺏﻮﻄﻟﺍ ﻊﻴﺑ<"),
            Type = "delivery",
            Spawner = 1,
            Item = {
                {
                    name = _U("delivery"),
                    time = 1500,
                    remove = 1,
                    max = 100, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
                    price = 180,
                    xp = 11,
                    requires = "bricks",
                    requires_name = "طوب",
					drop = 100
				}
			},
			Hint = _U('bs_pick_bay')
		}
	}
}