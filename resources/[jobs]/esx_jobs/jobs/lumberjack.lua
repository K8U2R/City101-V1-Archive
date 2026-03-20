Config.Jobs.lumberjack = {
  BlipInfos = {
    Sprite = 237,
    Color = 4
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
      Pos   = {x = 1200.63, y = -1276.875, z = 35.38},
      Size  = {x = 1.5, y = 1.5, z = 1.5},
      Color = {r = 204, g = 204, b = 0},
      Marker= 20,
      Blip  = true,
      Name  = _U('lj_locker_room'),
      Type  = "cloakroom",
      Hint  = _U('cloak_change'),
    },

    Wood = {
      Pos   = {x = -534.323669433594, y = 5373.794921875, z = 69.503059387207},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('lj_mapblip'),
      Type  = "work",
      Item  = {
        {
          name   = _U('lj_wood'),
          db_name= "wood",
          time   = 800,
          max    = 20,
          add    = 1,
          remove = 1,
          requires = "l_tool",
          requires_name = "Lumberjack kit",
          drop   = 100
        }
      },
      Hint  = _U('lj_pickup')
    },

    CuttedWood = {
      Pos   = {x = -552.214660644531, y = 5326.90966796875, z = 72.5996017456055},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('lj_cutwood'),
      Type  = "work",
      Item  = {
        {
          name   = _U('lj_cutwood2'),
          db_name= "cutted_wood",
          time   = 800,
          max    = 20,
          add    = 1,
          remove = 1,
          requires = "wood",
          requires_name = _U('lj_wood'),
          drop   = 100
        }
      },
      Hint  = _U('lj_cutwood_button')
    },

    Planks = {
      Pos   = {x = -501.386596679688, y = 5280.53076171875, z = 79.6187744140625},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('lj_board'),
      Type  = "work",
      Item  = {
        {
          name   = _U('lj_planks'),
          db_name= "packaged_plank",
          time   = 800,
          max    = 100,
          add    = 5,
          remove = 1,
          requires = "cutted_wood",
          requires_name = _U('lj_cutwood2'),
          drop   = 100
        }
      },
      Hint  = _U('lj_pick_boards')
    },

    VehicleSpawner = {
      --Pos   = {x = 1191.9681396484, y = -1261.7775878906, z = 35.170627593994},
      Pos   = {x = 1211.61, y = -1279.21, z = 35.22},
      Size  = {x = 1.5, y = 1.5, z = 1.5},
      Color = {r = 204, g = 204, b = 0},
      Marker= 36,
      Blip  = false,
      Name  = _U('spawn_veh'),
      Type  = "vehspawner",
      Spawner = 1,
      Hint  = _U('spawn_veh_button'),
      Caution = 2000
    },

    VehicleSpawnPoint = {
      Pos   = {x = 1194.6257324219, y = -1286.955078125, z = 34.121524810791},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Marker= -1,
      Blip  = false,
      Name  = _U('service_vh'),
      Type  = "vehspawnpt",
      Spawner = 1,
      Heading = 285.1
    },

    VehicleDeletePoint = {
      Pos   = {x = 1216.8983154297, y = -1229.2396240234, z = 35.403507232666},
      Size  = {x = 5.0, y = 5.0, z = 5.0},
      Color = {r = 255, g = 0, b = 0},
      Marker= 36,
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
      [1] = {x = 1094.84, y = -2919.19, z = 4.9},
      [2] = {x = -109.73, y = -2388.31, z = 6.0},
      [3] = {x = -1408.03, y = -2573.41, z = 13.95},
      [4] = {x = 1094.84, y = -2919.19, z = 4.9},
      [11] = {x = 460.38, y = -3030.57, z = 6.07},
      [12] = {x = 460.38, y = -3030.57, z = 6.07},
      [13] = {x = 460.38, y = -3030.57, z = 6.07},
      [14] = {x = 460.38, y = -3030.57, z = 6.07},
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
		Name  = _U('lj_delivery_point'),
		Type  = "delivery",
		Spawner = 1,
		Item  = {
			{
			name   = _U('delivery'),
			time   = 800,
			remove = 1,
			max    = 100, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
			price  = Config.Prices.lumberjack,
			xp  = Config.Xp.lumberjack,
			requires = "packaged_plank",
			requires_name = _U('lj_planks'),
			drop   = 100
			}
		},
		Hint  = _U('lj_deliver_button')
    }
  }
}
