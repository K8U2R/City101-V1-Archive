Config.Jobs.vegetables  = {
  BlipInfos = {
    Sprite = 444,
    Color = 69
  },
  Vehicles = {
    Truck = {
      Spawner = 1,
      Hash = "Burrito2",
      Trailer = "none",
      HasCaution = true
    }
  },
  Zones = {
    CloakRoom = {
      --Pos   = {x = -1071.1319580078, y = -2003.7891845703, z = 15.78551197052},
      Pos   = {x = 1557.88, y = 2162.29, z = 78.67},
      Size  = {x = 1.5, y = 1.5, z = 1.5},
      Color = {r = 46, g = 204, b = 113},
      Marker= 20,
      Blip  = false,
      Name  = _U('v_vegetables_locker'),
      Type  = "cloakroom",
      Hint  = _U('cloak_change'),
    },

    ready = {
      Pos   = {x = 1564.129, y = 2193.102, z = 78.06},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Color = {r = 46, g = 204, b = 113},
      Marker= 1,
      Blip  = false,
      Name  = _U('v_hen'),
      Type  = "work",
      Item  = {
        {
          name   = _U('v__ready'),
          db_name= "v_ready",
          time   = 500,
          max    = 40,
          add    = 2,
          remove = 1,
          requires = "v_tool",
          requires_name = _U('vegetables_kit'),
          drop   = 100
        }
      },
      Hint  = _U('v_catch_ready')
    },

    VehicleSpawner = {
      Pos   = {x = 1557.75, y = 2191.52, z = 78.89},
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
      Pos   = {x = 1551.47, y = 2193.76, z = 78.87},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Marker= -1,
      Blip  = false,
      Name  = _U('service_vh'),
      Type  = "vehspawnpt",
      Spawner = 1,
      Heading = 3.95
    },

    VehicleDeletePoint = {
      Pos   = {x = 1543.13, y = 2194.72, z = 78.84},
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
		Name  = _U('v_delivery_point'),
		Type  = "delivery",
		Spawner = 1,
		Item  = {
			{
			name   = _U('delivery'),
			time   = 500,
			remove = 1,
			max    = 40, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
			price  = Config.Prices.vegetables,
			xp  = Config.Xp.vegetables,
			requires = "v_ready",
			requires_name = _U('v__ready'),
			drop   = 100
			}
		},
		Hint  = _U('v_deliver')
    }
  }
}
