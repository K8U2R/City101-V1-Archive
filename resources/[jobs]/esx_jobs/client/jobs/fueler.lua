Config.Jobs.fueler = {
  BlipInfos = {
    Sprite = 436,
    Color = 5
  },
  Vehicles = {
    Truck = {
      Spawner = 1,
      Hash = "relax771",
      Trailer = "none",
      HasCaution = true
    }
  },
  Zones = {
    CloakRoom = { -- 1
      Pos   = {x = 557.933, y = -2327.9, z = 5.82896},
      Size  = {x = 1.5, y = 1.5, z = 1.5},
      Color = {r = 204, g = 204, b = 0},
      Marker= 20,
      Blip  = true,
      Name  = _U('f_oil_refiner'),
      Type  = "cloakroom",
      Hint  = _U('cloak_change'),
      GPS = {x = 554.597, y = -2314.43, z = 4.86293}
    },

	--النفط
    OilFarm = { -- A-2
	  Pos = {x = 609.58, y = 2856.74, z = 38.90},
      Size  = {x = 20.0, y = 20.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('f_drill_oil'),
      Type  = "work",
      Item  = {
        {
          name   = _U('f_petrol'),
          db_name= "petrol",
          time   = 500,
          max    = 48,
          add    = 1,
          remove = 1,
          requires = "f_tool",
          requires_name = _U('fueler_kit'),
          drop   = 100
        }
      },
      Hint  = _U('f_drillbutton'),
      GPS = {x = 2736.94, y = 1417.99, z = 23.4888}
    },

    OilRefinement = { -- A-3
      Pos   = {x = 2736.94, y = 1417.99, z = 23.4888},
      Size  = {x = 10.0, y = 10.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('f_fuel_refine'),
      Type  = "work",
      Item  = {
        {
          name   = _U('f_petrol_raffin'),
          db_name= "petrol_raffin",
          time   = 500,
          max    = 24,
          add    = 1,
          remove = 1,
          requires = "petrol",
          requires_name = _U('f_petrol'),
          drop   = 100
        }
      },
      Hint  = _U('f_refine_fuel_button'),
      GPS = {x = 265.752, y = -3013.39, z = 4.73275}
    },

    OilMix = { -- A-4
      Pos   = {x = 265.752, y = -3013.39, z = 4.73275},
      Size  = {x = 10.0, y = 10.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('f_fuel_mixture'),
      Type  = "work",
      Item  = {
        {
          name   = _U('f_essence'),
          db_name= "essence",
          time   = 500,
          max    = 48,
          add    = 2,
          remove = 1,
          requires = "petrol_raffin",
          requires_name = _U('f_petrol_raffin'),
          drop   = 100
        }
      },
      Hint  = _U('f_fuel_mixture_button'),
      GPS = {x = 491.406, y = -2163.37, z = 4.91827}
    },

--الغاز
    gasFarm = { --B-2
	  Pos = {x = 1430.63, y = -2103.13, z = 54.73},
      Size  = {x = 20.0, y = 20.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('f_drill_oil2'),
      Type  = "work",
      Item  = {
        {
          name   = _U('f_gas'),
          db_name= "gas",
          time   = 500,
          max    = 48,
          add    = 1,
          remove = 1,
          requires = "f_tool",
          requires_name = _U('fueler_kit'),
          drop   = 100
        }
      },
      Hint  = _U('f_drillbutton'),
      GPS = {x = 2736.94, y = 1417.99, z = 23.4888}
    },

    gasRefinement = { -- B-3
      Pos   = {x = 2786.1, y = 1581.65, z = 23.4888},
      Size  = {x = 10.0, y = 10.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('f_fuel_refine2'),
      Type  = "work",
      Item  = {
        {
          name   = _U('f_gas_refine'),
          db_name= "gas_raffin",
          time   = 500,
          max    = 24,
          add    = 1,
          remove = 1,
          requires = "gas",
          requires_name = _U('f_gas'),
          drop   = 100
        }
      },
      Hint  = _U('f_refine_fuel_button'),
      GPS = {x = 265.752, y = -3013.39, z = 4.73275}
    },

    gasMix = { -- B-4
      Pos   = {x = 1734.9, y = -1537.29, z = 111.7},
      Size  = {x = 10.0, y = 10.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('f_fuel_mixture2'),
      Type  = "work",
      Item  = {
        {
          name   = _U('f_gazbottle'),
          db_name= "gazbottle",
          time   = 500,
          max    = 48,
          add    = 2,
          remove = 1,
          requires = "gas_raffin",
          requires_name = _U('f_gas_refine'),
          drop   = 100
        }
      },
      Hint  = _U('f_fuel_mixture_button'),
      GPS = {x = 491.406, y = -2163.37, z = 4.91827}
    },

--رسبن الشاحنة
    VehicleSpawner = { 
      Pos   = {x = 554.597, y = -2314.43, z = 5.86293},
      Size  = {x = 1.5, y = 1.5, z = 1.5},
      Color = {r = 204, g = 204, b = 0},
      Marker= 36,
      Blip  = false,
      Name  = _U('spawn_veh'),
      Type  = "vehspawner",
      Spawner = 1,
      Hint  = _U('spawn_truck_button'),
      Caution = 2000,
      GPS = {x = 602.254, y = 2926.62, z = 39.6898}
    },

    VehicleSpawnPoint = {
      Pos   = {x = 540.35, y = -2303.28, z = 4.90915},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Marker= -1,
      Blip  = false,
      Name  = _U('service_vh'),
      Type  = "vehspawnpt",
      Spawner = 1,
      GPS = 0,
      Heading = 359.7
    },

    VehicleDeletePoint = {
      --Pos   = {x = 520.684, y = -2124.21, z = 4.98635},
      Pos   = {x = 570.16, y = -2344.1, z = 5.92},
      Size  = {x = 4.0, y = 4.0, z = 4.0},
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


--النفط
    DeliveryOil = { --
		Pos   = {
			[1] = {x = 1210.64, y = -2991.07, z = 4.87},
			[2] = {x = 16.83, y = -2425.53, z = 6.0},
			[3] = {x = -1263.6, y = -2503.83, z = 14.61}, --ok
			[4] = {x = 1210.64, y = -2991.07, z = 4.87},
      [11] = {x = 500.75, y = -2632.3798828125, z = 6.1599998474121},
      [12] = {x = 500.75, y = -2632.3798828125, z = 6.1599998474121},
      [13] = {x = 500.75, y = -2632.3798828125, z = 6.1599998474121},
      [14] = {x = 500.75, y = -2632.3798828125, z = 6.1599998474121},
		},
		Color = {r = 204, g = 204, b = 0},
		Size  = {
			[1] = {x = 17.0, y = 17.0, z = 1.0},
			[2] = {x = 7.0, y = 7.0, z = 7.0},
			[3] = {x = 12.0, y = 12.0, z = 1.0}, --ok
			[4] = {x = 17.0, y = 17.0, z = 1.0},
      [11] = {x = 17.0, y = 17.0, z = 1.0},
      [12] = {x = 17.0, y = 17.0, z = 1.0},
      [13] = {x = 17.0, y = 17.0, z = 1.0},
      [14] = {x = 17.0, y = 17.0, z = 1.0},
		},	
		Marker= -1,
		Blip  = true,
		Name  = _U('f_deliver_gas'),
		Type  = "delivery",
		Spawner = 1,
		Item  = {
			{
			name   = _U('delivery'),
			time   = 1000,
			remove = 1,
			max    = 100, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
			price  = Config.Prices.fueler,
			xp  = Config.Xp.fueler,
			requires = "essence",
			requires_name = _U('f_essence'),
			drop   = 100
			}
		},
		--Hint  = _U('f_deliver_gas'),
		Hint = _U("f_deliver_gas_button"),
		GPS = {x = 609.589, y = 2856.74, z = 39.4958}
		},

--الغاز
    DeliveryGas = { -- B-5
		Pos   = {
			[1] = {x = 1094.84, y = -2919.19, z = 4.9},
			[2] = {x = -171.73, y = -2388.47, z = 6.0},
			[3] = {x = -1360.68, y = -2514.71, z = 13.95}, --ok
			[4] = {x = 1094.84, y = -2919.19, z = 4.9},
      [11] = {x = 1094.84, y = -2919.19, z = 4.9},
      [12] = {x = 310.16, y = -2833.77, z = 6.00},
      [13] = {x = 310.16, y = -2833.77, z = 6.00},
      [14] = {x = 310.16, y = -2833.77, z = 6.00},
		},	
		Size  = {
			[1] = {x = 23.0, y = 23.0, z = 1.0},
			[2] = {x = 7.0, y = 7.0, z = 7.0},
			[3] = {x = 12.0, y = 12.0, z = 1.0}, --ok
			[4] = {x = 23.0, y = 23.0, z = 1.0},
      [11] = {x = 23.0, y = 23.0, z = 1.0},
      [12] = {x = 23.0, y = 23.0, z = 1.0},
      [13] = {x = 23.0, y = 23.0, z = 1.0},
      [14] = {x = 23.0, y = 23.0, z = 1.0},
		},
		Color = {r = 204, g = 204, b = 0},
		Marker= -1,
		Blip  = true,
		Name  = _U('f_deliver_gas2'),
		Type  = "delivery",
		Spawner = 1,
		Item  = {
			{
			name   = _U('delivery'),
			time   = 1000,
			remove = 1,
			max    = 100, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
			price  = Config.Prices.gas,
			xp  = Config.Xp.gas,
			requires = "gazbottle",
			requires_name = _U('f_gazbottle'),
			drop   = 100
			}
		},
		--Hint  = _U('f_deliver_gas'),
		Hint = _U("f_deliver_gas_button"),
		GPS = {x = 609.589, y = 2856.74, z = 39.4958}
    }

  }
}
