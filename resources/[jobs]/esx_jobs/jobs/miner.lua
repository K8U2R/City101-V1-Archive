Config.Jobs.miner = {
  BlipInfos = {
    Sprite = 318,
    Color = 5
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
      Pos   = {x = 892.35333251953, y = -2172.7705078125, z = 32.286273956299},
      Size  = {x = 1.5, y = 1.5, z = 1.5},
      Color = {r = 204, g = 204, b = 0},
      Marker= 20,
      Blip  = true,
      Name  = _U('m_miner_locker'),
      Type  = "cloakroom",
      Hint  = _U('cloak_change'),
      GPS = {x = 884.86889648438, y = -2176.5102539063, z = 29.519346237183}
    },

    Mine = {
      Pos   = {x = 2962.4, y = 2746.2, z = 42.398},
      Size  = {x = 5.0, y = 5.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('m_rock'),
      Type  = "work",
      Item  = {
        {
          name   = _U('m_rock2'),
          db_name= "stone",
          time   = 700,
          max    = 7,
          add    = 1,
          remove = 1,
          requires = "m_tool",
          requires_name = _U('miner_kit'),
          drop   = 100
        }
      },
      Hint  = _U('m_pickrocks'),
      GPS = {x = 289.244, y = 2862.9, z = 42.6424}
    },

    StoneWash = {
      Pos   = {x = 289.244, y = 2862.9, z = 42.6424},
      Size  = {x = 5.0, y = 5.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('m_washrock'),
      Type  = "work",
      Item  = {
        {
          name   = _U('m_washrock2'),
          db_name= "washed_stone",
          time   = 600,
          max    = 7,
          add    = 1,
          remove = 1,
          requires = "stone",
          requires_name = _U('m_rock2'),
          drop   = 100
        }
      },
      Hint  = _U('m_rock_button'),
      GPS = {x = 1109.14, y = -2007.87, z = 30.0188}
    },

    Foundry = {
      Pos   = {x = 1109.14, y = -2007.87, z = 30.0188},
      Size  = {x = 5.0, y = 5.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('m_rock_smelting'),
      Type  = "work",
      Item  = {
        {
          name   = _U('m_copper'),
          db_name= "copper",
          time   = 500,
          max    = 56,
          add    = 8,
          remove = 1,
          requires = "washed_stone",
          requires_name = _U('m_washrock2'),
          drop   = 100
        },
        {
          name   = _U('m_iron'),
          db_name= "iron",
          max    = 42,
          add    = 6,
          drop   = 100
        },
        {
          name   = _U('m_gold'),
          db_name= "gold",
          max    = 21,
          add    = 3,
          drop   = 100
        },
        {
          name   = _U('m_diamond'),
          db_name= "diamond",
          max    = 50,
          add    = 1,
          drop   = 5
        }
      },
      Hint  = _U('m_melt_button'),
      GPS = {x = -169.481, y = -2659.16, z = 5.00103}
    },

    VehicleSpawner = {
      Pos   = {x = 884.86889648438, y = -2176.5102539063, z = 30.519346237183},
      Size  = {x = 1.5, y = 1.5, z = 1.5},
      Color = {r = 204, g = 204, b = 0},
      Marker= 39,
      Blip  = false,
      Name  = _U('spawn_veh'),
      Type  = "vehspawner",
      Spawner = 1,
      Hint  = _U('spawn_veh_button'),
      Caution = 2000,
      GPS = {x = 2962.4, y = 2746.2, z = 42.398}
    },

    VehicleSpawnPoint = {
      Pos   = {x = 879.55700683594, y = -2189.7995605469, z = 29.519348144531},
      Size  = {x = 5.0, y = 5.0, z = 5.0},
      Marker= -1,
      Blip  = false,
      Name  = _U('service_vh'),
      Type  = "vehspawnpt",
      Spawner = 1,
      Heading = 90.1,
      GPS = 0
    },

    VehicleDeletePoint = {
      Pos   = {x = 874.3115234375, y = -2176.8791503906, z = 30.959351959228},
      Size  = {x = 5.0, y = 5.0, z = 5.0},
      Color = {r = 255, g = 0, b = 0},
      Marker= 39,
      Blip  = false,
      Name  = _U('return_vh'),
      Type  = "vehdelete",
      Hint  = _U('return_vh_button'),
      Spawner = 1,
      Caution = 2000,
      GPS = 0,
      Teleport = 0
    },

    CopperDelivery = {
    Pos   = {
      [1] = {x = 975.58, y = -2919.31, z = 4.9},
      [2] = {x = 16.83, y = -2425.53, z = 6.0},
      [3] = {x = -1263.6, y = -2503.83, z = 13.95},
      [4] = {x = 975.58, y = -2919.31, z = 4.9},
      [11] = {x = 591.4000244140625, y = -2810.7099609375, z = 6.05999994277954},
      [12] = {x = 240.61, y = -2997.76, z = 5.74},
      [13] = {x = 240.61, y = -2997.76, z = 5.74},
      [14] = {x = 240.61, y = -2997.76, z = 5.74},
    },	
    Color = {r = 204, g = 204, b = 0},
    Size  = {
      [1] = {x = 23.0, y = 23.0, z = 1.0},
      [2] = {x = 7.0, y = 7.0, z = 7.0},
      [3] = {x = 12.0, y = 12.0, z = 1.0},
      [4] = {x = 23.0, y = 23.0, z = 1.0},
      [11] = {x = 23.0, y = 23.0, z = 1.0},
      [12] = {x = 23.0, y = 23.0, z = 1.0},
      [13] = {x = 23.0, y = 23.0, z = 1.0},
      [14] = {x = 23.0, y = 23.0, z = 1.0},
    },
		Marker= -1,
		Blip  = true,
		Name  = _U('m_sell_copper'),
		Type  = "delivery",
		Spawner = -1,
		Item  = {
			{
			name   = _U('delivery'),
			time   = 1000,
			remove = 1,
			max    = 56, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
			price  = Config.Prices.miner.copper,
			xp = Config.Xp.miner.copper,
			requires = "copper",
			requires_name = _U('m_copper'),
			drop   = 100
			}
		},
		Hint  = _U('m_deliver_copper'),
		GPS = {x = -148.782, y = -1040.38, z = 26.2736}
    },

    IronDelivery = {
    Pos   = {
      [1] = {x = 1094.84, y = -2919.19, z = 4.9},
      [2] = {x = -171.73, y = -2388.47, z = 6.0},
      [3] = {x = -1360.68, y = -2514.71, z = 13.95},
      [4] = {x = 1094.84, y = -2919.19, z = 4.9},
      [11] = {x = 633.75, y = -2846.72998046875, z = 5.53999996185302},
      [12] = {x = 633.75, y = -2846.72998046875, z = 5.53999996185302},
      [13] = {x = -171.35, y = -2389.18, z = 6.00},
      [14] = {x = -171.35, y = -2389.18, z = 6.00},
    },	
    Size  = {
      [1] = {x = 23.0, y = 23.0, z = 1.0},
      [2] = {x = 7.0, y = 7.0, z = 7.0},
      [3] = {x = 12.0, y = 12.0, z = 1.0},
      [4] = {x = 23.0, y = 23.0, z = 1.0},
      [11] = {x = 23.0, y = 23.0, z = 1.0},
      [12] = {x = 23.0, y = 23.0, z = 1.0},
      [13] = {x = 23.0, y = 23.0, z = 1.0},
      [14] = {x = 23.0, y = 23.0, z = 1.0},
    },
		Color = {r = 204, g = 204, b = 0},
		Marker= -1,
		Blip  = true,
		Name  = _U('m_sell_iron'),
		Type  = "delivery",
		Spawner = 1,
		Item  = {
			{
			name   = _U('delivery'),
			time   = 1000,
			remove = 1,
			max    = 42, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
			price  = Config.Prices.miner.iron,
			xp = Config.Xp.miner.iron,
			requires = "iron",
			requires_name = _U('m_iron'),
			drop   = 100
			}
		},
		Hint  = _U('m_deliver_iron'),
		GPS = {x = 261.487, y = 207.354, z = 109.287}
    },

    GoldDelivery = {
    Pos   = {
      [1] = {x = 1139.43, y = -3190.0, z = 4.9},
      [2] = {x = -245.58, y = -2388.21, z = 6.0},
      [3] = {x = -1408.03, y = -2573.41, z = 13.95},
      [4] = {x = 1139.43, y = -3190.0, z = 4.9},
      [11] = {x = 1139.43, y = -3190.0, z = 4.9},
      [12] = {x = 588.81, y = -2811.31, z = 6.06},
      [13] = {x = 588.81, y = -2811.31, z = 6.06},
      [14] = {x = 588.81, y = -2811.31, z = 6.06},
    },	
    Size  = {
      [1] = {x = 16.0, y = 16.0, z = 1.0},
      [2] = {x = 7.0, y = 7.0, z = 7.0},
      [3] = {x = 12.0, y = 12.0, z = 1.0},
      [4] = {x = 16.0, y = 16.0, z = 1.0},
      [11] = {x = 16.0, y = 16.0, z = 1.0},
      [12] = {x = 16.0, y = 16.0, z = 1.0},
      [13] = {x = 16.0, y = 16.0, z = 1.0},
      [14] = {x = 16.0, y = 16.0, z = 1.0},
    },
		Color = {r = 204, g = 204, b = 0},
		Marker= -1,
		Blip  = true,
		Name  = _U('m_sell_gold'),
		Type  = "delivery",
		Spawner = 1,
		Item  = {
			{
			name   = _U('delivery'),
			time   = 1000,
			remove = 1,
			max    = 21, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
			price  = Config.Prices.miner.gold,
			xp = Config.Xp.miner.gold,
			requires = "gold",
			requires_name = _U('m_gold'),
			drop   = 100
			}
		},
		Hint  = _U('m_deliver_gold'),
		GPS = {x = -621.046, y = -228.532, z = 37.0571}
    },

    DiamondDelivery = {
    Pos   = {
      [1] = {x = -621.046, y = -228.532, z = 37.0571},
      [2] = {x = -621.046, y = -228.532, z = 37.0571},
      [3] = {x = -621.046, y = -228.532, z = 37.0571},
      [4] = {x = -621.046, y = -228.532, z = 37.0571},
      [11] = {x = -621.046, y = -228.532, z = 37.0571},
      [12] = {x = -621.046, y = -228.532, z = 37.0571},
      [13] = {x = -621.046, y = -228.532, z = 37.0571},
      [14] = {x = -621.046, y = -228.532, z = 37.0571},
    },	
    Color = {r = 204, g = 204, b = 0},
    Size  = {
      [1] = {x = 5.0, y = 5.0, z = 3.0},
      [2] = {x = 5.0, y = 5.0, z = 3.0},
      [3] = {x = 5.0, y = 5.0, z = 3.0},
      [4] = {x = 5.0, y = 5.0, z = 3.0},
      [11] = {x = 5.0, y = 5.0, z = 3.0},
      [12] = {x = 5.0, y = 5.0, z = 3.0},
      [13] = {x = 5.0, y = 5.0, z = 3.0},
      [14] = {x = 5.0, y = 5.0, z = 3.0},
    },
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Blip  = true,
		Name  = _U('m_sell_diamond'),
		Type  = "delivery",
		Spawner = 1,
		Item  = {
			{
			name   = _U('delivery'),
			time   = 3000,
			remove = 1,
			max    = 50, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
			price  = Config.Prices.miner.diamond,
			xp = Config.Xp.miner.diamond,
			requires = "diamond",
			requires_name = _U('m_diamond'),
			drop   = 100
			}
		},
		Hint  = _U('m_deliver_diamond'),
		GPS = {x = 2962.4, y = 2746.2, z = 42.398}
    }
  }
}
