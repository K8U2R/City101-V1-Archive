Config.Jobs.tailor = {
  BlipInfos = {
    Sprite = 366,
    Color = 4
  },
  Vehicles = {
    Truck = {
      Spawner = 1,
      Hash = "relax788",
      Trailer = "none",
      HasCaution = true
    }
  },
  Zones = {
    CloakRoom = {
      Pos   = {x = 706.735412597656, y = -960.902893066406, z = 30.3953247070313},
      Size  = {x = 1.5, y = 1.5, z = 1.5},
      Color = {r = 204, g = 204, b = 0},
      Marker= 20,
      Blip  = true,
      Name  = _U('dd_dress_locker'),
      Type  = "cloakroom",
      Hint  = _U('cloak_change'),
      GPS = {x = 740.808776855469, y = -970.066650390625, z = 23.4693908691406}
    },

    Wool = {
      Pos   = {x = 2552.85, y = 4670.9, z = 32.97},
      Size  = {x = 5.0, y = 5.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('dd_wool'),
      Type  = "work",
      Item  = {
        {
          name   = _U('dd_wool2'),
          db_name= "wool",
          time   = 1000,
          max    = 40,
          add    = 1,
          remove = 1,
          requires = "t_tool",
          requires_name = _U('tailor_kit'),
          drop   = 100
        }
      },
      Hint  = _U('dd_pickup'),
      GPS = {x = 715.954650878906, y = -959.639587402344, z = 29.3953247070313}
    },

    Fabric = {
      --Pos   = {x = 715.954650878906, y = -959.639587402344, z = 29.3953247070313},
      Pos   = {x = 717.7, y = -962.1, z = 29.40},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('dd_fabric'),
      Type  = "work",
      Item  = {
        {
          name   = _U('dd_fabric2'),
          db_name= "fabric",
          time   = 500,
          max    = 80,
          add    = 2,
          remove = 1,
          requires = "wool",
          requires_name = _U('dd_wool2'),
          drop   = 100
        }
      },
      Hint  = _U('dd_makefabric'),
      GPS = {x = 712.928283691406, y = -970.5869140625, z = 29.3953247070313}
    },

    Clothe = {
      Pos   = {x = 712.928283691406, y = -970.5869140625, z = 29.3953247070313},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('dd_clothing'),
      Type  = "work",
      Item  = {
        {
          name   = _U('dd_clothing2'),
          db_name= "clothe",
          time   = 500,
          max    = 80,
          add    = 1,
          remove = 1,
          requires = "fabric",
          requires_name = _U('dd_fabric2'),
          drop   = 100
        }
      },
      Hint  = _U('dd_makeclothing'),
      GPS = {x = 429.595855712891, y = -807.341613769531, z = 28.4911441802979}
    },

    VehicleSpawner = {
      Pos   = {x = 740.808776855469, y = -970.066650390625, z = 24.4693908691406},
      Size  = {x = 1.5, y = 1.5, z = 1.5},
      Color = {r = 204, g = 204, b = 0},
      Marker= 36,
      Blip  = false,
      Name  = _U('spawn_veh'),
      Type  = "vehspawner",
      Spawner = 1,
      Hint  = _U('spawn_veh_button'),
      Caution = 2000,
      GPS = {x = 1978.92407226563, y = 5171.70166015625, z = 46.6391181945801}
    },

    VehicleSpawnPoint = {
      Pos   = {x = 747.31396484375, y = -966.235778808594, z = 23.705005645752},
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
      Pos   = {x = 688.82409667968, y = -966.68688964844, z = 23.445974349976},
      Size  = {x = 3.0, y = 3.0, z = 3.0},
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
      [1] = {x = 1139.43, y = -3190.0, z = 4.9},
      [2] = {x = -245.58, y = -2388.21, z = 6.0},
      [3] = {x = -1360.68, y = -2514.71, z = 13.95},
      [4] = {x = 1139.43, y = -3190.0, z = 4.9},
      [11] = {x = 1097.64, y = -2914.67, z = 5.90},
      [12] = {x = 1097.64, y = -2914.67, z = 5.90},
      [13] = {x = -13.11, y = -2406.96, z = 6.00},
      [14] = {x = -13.11, y = -2406.96, z = 6.00},
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
		Name  = _U('dd_delivery_point'),
		Type  = "delivery",
		Spawner = 1,
		Item  = {
			{
			name   = _U('delivery'),
			time   = 1000,
			remove = 1,
			max    = 100, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
			price  = Config.Prices.tailor,
			xp  = Config.Xp.tailor,
			requires = "clothe",
			requires_name = _U('dd_clothing2'),
			drop   = 100
			}
		},
		Hint  = _U('dd_deliver_clothes'),
		GPS = {x = 1978.92407226563, y = 5171.70166015625, z = 46.6391181945801}
    }
  }
}
