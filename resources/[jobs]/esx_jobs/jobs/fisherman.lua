Config.Jobs.fisherman = {
  BlipInfos = {
    Sprite = 68,
    Color = 26
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
      Pos   = {x = 868.37, y = -1639.76, z = 30.34},
      Size  = {x = 1.0, y = 1.0, z = 1.0},
      Color = {r = 97, g = 183, b = 227},
      Marker= 20,
      Blip  = true,
      Name  = _U('fm_fish_locker'),
      Type  = "cloakroom",
      Hint  = _U('cloak_change'),
      GPS = {x = 875.4, y = -1669.13, z = 30.44}
    },

    VehicleSpawner = {
      Pos   = {x = 875.4, y = -1669.13, z = 30.44},
      Size  = {x = 1.5, y = 1.5, z = 1.5},
      Color = {r = 204, g = 204, b = 0},
      Marker= 36,
      Blip  = false,
      Name  = _U('spawn_veh'),
      Type  = "vehspawner",
      Spawner = 1,
      Hint  = _U('spawn_veh_button'),
      Caution = 2000,
      GPS = {x = 227.38, y = 7057.05, z = 2.28}
    },

    VehicleSpawnPoint = {
      Pos   = {x = 863.89, y = -1666.94, z = 29.72},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Marker= -1,
      Blip  = false,
      Name  = _U('service_vh'),
      Type  = "vehspawnpt",
      Spawner = 1,
      Heading = 358.16,
      GPS = 0
    },

    VehicleDeletePoint = {
      Pos   = {x = 873.77, y = -1658.17, z = 30.32},
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
			[1] = {x = 1157.46, y = -2919.26, z = 5.90},
			[2] = {x = -171.73, y = -2388.47, z = 6.0},
			[3] = {x = -1408.03, y = -2573.41, z = 13.95},
			[4] = {x = 1139.22, y = -3190.63, z = 5.9},
			[11] = {x = 1157.46, y = -2919.26, z = 5.90},
			[12] = {x = 1157.46, y = -2919.26, z = 5.90},
			[13] = {x = 1157.46, y = -2919.26, z = 5.90},
			[14] = {x = 1157.46, y = -2919.26, z = 5.90},
		},	
		Size  = {
			[1] = {x=10.0,y=10.0,z=1.0},
			[2] = {x = 7.0, y = 7.0, z = 7.0},
			[3] = {x=10.0,y=10.0,z=1.0},
			[4] = {x=10.0,y=10.0,z=1.0},
			[11] = {x=10.0,y=10.0,z=1.0},
			[12] = {x=10.0,y=10.0,z=1.0},
			[13] = {x=10.0,y=10.0,z=1.0},
			[14] = {x=10.0,y=10.0,z=1.0},
		},	
		Color = {r = 204, g = 204, b = 0},
		Marker= -1,
		Blip  = true,
		Name  = _U('fm_delivery_point'),
		Type  = "delivery",
		Spawner = 1,
		Item  = {
			{
			name   = _U('delivery'),
			time   = 1000,
			remove = 1,
			max    = 100, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
			price  = Config.Prices.fisherman,
			xp  = Config.Xp.fisherman,
			requires = "fish",
			requires_name = _U('fm_fish'),
			drop   = 100
			}
		},
		Hint  = _U('fm_deliver_fish'),
		GPS = {x = 1139.22, y = -3190.63, z = 5.9}
    },
	
    --[[TurtleDelivery = {
		Pos   = {
			[1] = {x = 1135.52, y = -3034.26, z = 5.9},
			[2] = {x = 9.22, y = -2456.61, z = 6.01},
			[3] = {x = -1246.74, y = -2252.22, z = 13.94},
			[4] = {x = 1135.52, y = -3034.26, z = 5.9},
		},	
		Size  = {
			[1] = {x=1.0,y=1.0,z=1.0},
			[2] = {x=1.0,y=1.0,z=1.0},
			[3] = {x=1.0,y=1.0,z=1.0},
			[4] = {x=1.0,y=1.0,z=1.0},
		},
		Color = {r = 204, g = 204, b = 0},
		Marker= -1,
		Blip  = true,
		Name  = _U('fm_delivery_point_turtle'),
		Type  = "delivery",
		Spawner = 1,
		Item  = {
			{
			name   = _U('delivery'),
			time   = 3000,
			remove = 1,
			max    = 10, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
			price  = Config.Prices.turtle,
			xp  = Config.Xp.turtle,
			requires = "turtle",
			requires_name = _U('fm_turtle'),
			drop   = 100
			}
		},
		Hint  = _U('fm_deliver_turtle'),
		GPS = {x = 1135.52, y = -3034.26, z = 5.9}
    },	

    SharkDelivery = {
		Pos   = {
			[1] = {x = 1034.44, y = -3088.13, z = 5.9},
			[2] = {x = -127.56, y = -2463.39, z = 6.01},
			[3] = {x = -1202.77, y = -2710.48, z = 13.94},
			[4] = {x = 1034.44, y = -3088.13, z = 5.9},
		},	
		Size  = {
			[1] = {x=1.0,y=1.0,z=1.0},		
			[2] = {x=1.0,y=1.0,z=1.0},		
			[3] = {x=1.0,y=1.0,z=1.0},		
			[4] = {x=1.0,y=1.0,z=1.0},
		},	
		Color = {r = 204, g = 204, b = 0},
		Marker= -1,
		Blip  = true,
		Name  = _U('fm_delivery_point_shark'),
		Type  = "delivery",
		Spawner = 1,
		Item  = {
			{
			name   = _U('delivery'),
			time   = 3000,
			remove = 1,
			max    = 10, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
			price  = Config.Prices.shark,
			xp  = Config.Xp.shark,
			requires = "shark",
			requires_name = _U('fm_shark'),
			drop   = 100
			}
		},
		Hint  = _U('fm_deliver_shark'),
		GPS = {x = 1135.52, y = -3034.26, z = 5.9}
    }--]]
	
  }
}
