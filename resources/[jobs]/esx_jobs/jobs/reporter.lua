Config.Jobs.reporter = {
  
  BlipInfos = {
    Sprite = 184,
    Color = 38
  },
  
  Vehicles = {
    Truck = {
      Spawner = 1,
      Hash = "nissanditsun",
      Trailer = "none",
	  Livery = 0,
      HasCaution = true
    }
  },
  
  Zones = {
    CloakRoom = { -- 1
      Pos   = {x = -138.98, y = -634.19, z = 168.82},
      Size  = {x = 1.5, y = 1.5, z = 1.5},
      Color = {r = 0, g = 0, b = 255},
      Marker= 20,
      Blip  = false,
      Name  = _U('reporter_cloakroom'),
      Type  = "cloakroom",
      Hint  = _U('cloak_change'),
      GPS = {x = -138.98, y = -634.19, z = 168.82},
    },
	
	VehicleSpawner = {
      Pos   = { x = -105.79, y = -595.76, z = 36.28 },
      Size  = {x = 1.0, y = 1.0, z = 1.0},
      Color = {r = 0, g = 0, b = 255},
      Marker= 39,
      Blip  = true,
      Name  = _U('reporter_name'),
      Type  = "vehspawner",
      Spawner = 1,
      Hint  = _U('reporter_garage'),
      Caution = 2000
    },

    VehicleSpawnPoint = {
      Pos   = { x = -101.93, y = -595.64, z = 35.86 },
      Size  = {x = 1.0, y = 1.0, z = 1.0},
      Marker= -1,
      Blip  = false,
      Name  = _U('service_vh'),
      Type  = "vehspawnpt",
      Spawner = 1,
      Heading = 160.42
    },

    VehicleDeletePoint = {
      Pos   = { x = -112.95,  y = -627.82, z = 36.05 },
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
      Teleport = { x = -115.48, y = -626.05, z = 36.26 }
    }
  }
}
