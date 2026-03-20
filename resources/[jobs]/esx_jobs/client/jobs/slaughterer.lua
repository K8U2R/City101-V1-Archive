Config.Jobs.slaughterer = {
  BlipInfos = {
    Sprite = 256,
    Color = 5
  },
  Vehicles = {
    Truck = {
      Spawner = 1,
      Hash = "relax778",
      Trailer = "none",
      HasCaution = true
    }
  },
  Zones = {
    CloakRoom = {
      --Pos   = {x = -1071.1319580078, y = -2003.7891845703, z = 15.78551197052},
      Pos   = {x = -143.91, y = 6306.12, z = 31.56},
      Size  = {x = 1.5, y = 1.5, z = 1.5},
      Color = {r = 204, g = 204, b = 0},
      Marker= 21,
      Blip  = true,
      Name  = _U('s_slaughter_locker'),
      Type  = "cloakroom",
      Hint  = _U('cloak_change'),
    },

    AliveChicken = {
      Pos   = {x = -62.9018, y = 6241.46, z = 30.09},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('s_hen'),
      Type  = "work",
      Item  = {
        {
          name   = _U('s_alive_chicken'),
          db_name= "alive_chicken",
          time   = 800,
          max    = 20,
          add    = 1,
          remove = 1,
          requires = "s_tool",
          requires_name = _U('slaughterer_kit'),
          drop   = 100
        }
      },
      Hint  = _U('s_catch_hen')
    },

    SlaughterHouse = {
      Pos   = {x = -77.991, y = 6229.063, z = 30.091},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('s_slaughtered'),
      Type  = "work",
      Item  = {
        {
          name   = _U('s_slaughtered_chicken'),
          db_name= "slaughtered_chicken",
          time   = 800,
          max    = 20,
          add    = 1,
          remove = 1,
          requires = "alive_chicken",
          requires_name = _U('s_alive_chicken'),
          drop   = 100
        }
      },
      Hint  = _U('s_chop_animal')
    },

    Packaging = {
      Pos   = {x = -101.978, y = 6208.799, z = 30.025},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('s_package'),
      Type  = "work",
      Item  = {
        {
          name   = _U('s_packagechicken'),
          db_name= "packaged_chicken",
          time   = 800,
          max    = 100,
          add    = 5,
          remove = 1,
          requires = "slaughtered_chicken",
          requires_name = _U('s_unpackaged'),
          drop   = 100
        }
      },
      Hint  = _U('s_unpackaged_button')
    },

    VehicleSpawner = {
      Pos   = {x = -121.06, y = 6284.27, z = 31.48},
      Size  = {x = 1.5, y = 1.5, z = 1.5},
      Color = {r = 204, g = 204, b = 0},
      Marker= 39,
      Blip  = false,
      Name  = _U('spawn_veh'),
      Type  = "vehspawner",
      Spawner = 1,
      Hint  = _U('spawn_veh_button'),
      Caution = 2000
    },

    VehicleSpawnPoint = {
      Pos   = {x = -125.46, y = 6288.1, z = 31.38},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Marker= -1,
      Blip  = false,
      Name  = _U('service_vh'),
      Type  = "vehspawnpt",
      Spawner = 1,
      Heading = 316.49
    },

    VehicleDeletePoint = {
      Pos   = {x = -125.13, y = 6280.53, z = 31.34},
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

    Delivery = {
    Pos   = {
      [1] = {x = 1139.43, y = -3190.0, z = 4.9},
      [2] = {x = -171.73, y = -2388.47, z = 6.0},
      [3] = {x = -1408.03, y = -2573.41, z = 13.95},
      [4] = {x = 1139.43, y = -3190.0, z = 4.9},
      [11] = {x = 1139.43, y = -3190.0, z = 4.9},
      [12] = {x = 1139.43, y = -3190.0, z = 4.9},
      [13] = {x = 1139.43, y = -3190.0, z = 4.9},
      [14] = {x = 1139.43, y = -3190.0, z = 4.9},
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
		Name  = _U('s_delivery_point'),
		Type  = "delivery",
		Spawner = 1,
		Item  = {
			{
			name   = _U('delivery'),
			time   = 800,
			remove = 1,
			max    = 100, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
			price  = Config.Prices.slaughterer,
			xp  = Config.Xp.slaughterer,
			requires = "packaged_chicken",
			requires_name = _U('s_packagechicken'),
			drop   = 100
			}
		},
		Hint  = _U('s_deliver')
    }
  }
}
