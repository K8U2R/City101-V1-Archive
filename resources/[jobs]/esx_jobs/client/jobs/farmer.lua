Config.Jobs.farmer = {
  BlipInfos = {
    Sprite = 85,
    Color = 19
  },
  Vehicles = {
    Truck = {
      Spawner = 1,
      Hash = "relax772",
      Trailer = "none",
      HasCaution = true
    }
  },
  Zones = {
    CloakRoom = {
      Pos   = {x = -1894.1, y = 2051.56, z = 140.95},
      Size  = {x = 1.5, y = 1.5, z = 1.5},
      Color = {r = 94, g = 0, b = 137},
      Marker= 20,
      Blip  = true,
      Name  = _U('ff_farmer_locker'),
      Type  = "cloakroom",
      Hint  = _U('cloak_change'),
      GPS = {x = 740.808776855469, y = -970.066650390625, z = 23.4693908691406}
    },

    Farm = {
      Pos   = {x = -1809.662, y = 2210.119, z = 89.381},
		Size  = {x = 4.0, y = 4.0, z = 3.0},
		Color = {r = 94, g = 0, b = 137},
      Marker= 1,
      Blip  = true,
      Name  = _U('ff_farm'),
      Type  = "work",
      Item  = {
        {
          name   = _U('ff_grape'),
          db_name= "grape",
          time   = 500,
          max    = 100,
          add    = 1,
          remove = 1,
          requires = "nothing",
          requires_name = _U('tailor_kit'),
          drop   = 100
        }
      },
      Hint  = _U('ff_pickup'),
      GPS = {x = 811.337, y = 2179.402, z = 51.388}
    },

    Juice = {
      --Pos   = {x = 715.954650878906, y = -959.639587402344, z = 29.3953247070313},
      Pos   = {x = 811.337, y = 2179.402, z = 51.388},
		Size  = {x = 3.5, y = 3.5, z = 2.0},
		Color = {r = 94, g = 0, b = 137},
      Marker= 1,
      Blip  = true,
      Name  = _U('ff_juice'),
      Type  = "work",
      Item  = {
        {
          name   = _U('ff_juice2'),
          db_name= "grape_juice",
          time   = 2000,
          max    = 50,
          add    = 1,
          remove = 1,
          requires = "grape",
          requires_name = _U('ff_grape'),
          drop   = 100
        }
      },
      Hint  = _U('ff_makejuice'),
      GPS = {x = 975.58, y = -2919.31, z = 4.9}
    },

    Wine = {
      --Pos   = {x = 715.954650878906, y = -959.639587402344, z = 29.3953247070313},
		Pos   = {x = 2879.43, y = 4489.71, z = 47.19},
		Size  = {x = 3.5, y = 3.5, z = 2.0},
		Color = {r = 94, g = 0, b = 137},
      Marker= 1,
      Blip  = true,
      Name  = _U('ff_wine'),
      Type  = "work",
      Item  = {
        {
          name   = _U('ff_wine2'),
          db_name= "grape_wine",
          time   = 2000,
          max    = 50,
          add    = 1,
          remove = 1,
          requires = "grape",
          requires_name = _U('ff_grape'),
          drop   = 100
        }
      },
      Hint  = _U('ff_makewine'),
      GPS = {x = 975.58, y = -2919.31, z = 4.9}
    },

    VehicleSpawner = {
      Pos   = {x = -1889.653, y = 2050.071, z = 140.985},
      Size  = {x = 1.5, y = 1.5, z = 1.5},
      Color = {r = 94, g = 0, b = 137},
      Marker= 39,
      Blip  = false,
      Name  = _U('spawn_veh'),
      Type  = "vehspawner",
      Spawner = 1,
      Hint  = _U('spawn_veh_button'),
      Caution = 2000,
      GPS = {x = 2879.43, y = 4489.71, z = 47.19}
    },

    VehicleSpawnPoint = {
      Pos   = {x = -1903.984, y = 2058.367, z = 139.722},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Marker= -1,
      Blip  = false,
      Name  = _U('service_vh'),
      Type  = "vehspawnpt",
      Spawner = 1,
      Heading = 270.1,
      GPS = 0
    },

    VehicleDeletePoint = {
      Pos   = {x = -1913.550, y = 2030.590, z = 140.738},
	  Size  = {x = 2.0, y = 2.0, z = 2.0},
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
      [1] = {x = 975.58, y = -2919.31, z = 4.9},
      [2] = {x = 16.83, y = -2425.53, z = 6.0},
      [3] = {x = -1263.6, y = -2503.83, z = 13.95},
      [4] = {x = 975.58, y = -2919.31, z = 4.9},
      [11] = {x = 975.58, y = -2919.31, z = 4.9},
      [12] = {x = 975.58, y = -2919.31, z = 4.9},
      [13] = {x = 975.58, y = -2919.31, z = 4.9},
      [14] = {x = 975.58, y = -2919.31, z = 4.9},
    },	
    Size  = {
      [1] = {x = 15.0, y = 15.0, z = 1.0},
      [2] = {x = 7.0, y = 7.0, z = 7.0},
      [3] = {x = 12.0, y = 12.0, z = 1.0},
      [4] = {x = 15.0, y = 15.0, z = 1.0},
      [11] = {x = 15.0, y = 15.0, z = 1.0},
      [12] = {x = 15.0, y = 15.0, z = 1.0},
      [13] = {x = 15.0, y = 15.0, z = 1.0},
      [14] = {x = 15.0, y = 15.0, z = 1.0},
    },
		Color = {r = 94, g = 0, b = 137},
		Marker= -1,
		Blip  = true,
		Name  = _U('ff_delivery_point'),
		Type  = "delivery",
		Spawner = 1,
		Item  = {
			{
			name   = _U('delivery'),
			time   = 1000,
			remove = 1,
			max    = 50, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
			price  = Config.Prices.farmer,
			xp  = Config.Xp.farmer,
			requires = "grape_juice",
			requires_name = _U('ff_juice2'),
			drop   = 100
			}
		},
		Hint  = _U('ff_deliver_juice'),
		GPS = {x = 2879.43, y = 4489.71, z = 47.19}
    }
  }
}
