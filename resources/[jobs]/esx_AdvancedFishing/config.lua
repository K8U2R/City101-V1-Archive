Config = {}
	---------------------------------------------------------------
	--=====How long should it take for player to catch a fish=======--
	---------------------------------------------------------------
	--Time in miliseconds
	Config.FishTime = {a = 18000, b = 27000}
	
	--------------------------------------------------------
	--=====Prices of the items players can sell==========--
	--------------------------------------------------------
	--First amount minimum price second maximum amount (the amount player will get is random between those two numbers)
	Config.FishPrice = {a = 58, b = 60} --Will get clean money THIS PRICE IS FOR EVERY 5 FISH ITEMS (5 kg)
	Config.TurtlePrice = {a = 900, b = 1400} --Will get dirty money
	Config.SharkPrice = {a = 1000, b = 3200} --Will get dirty money

	--------------------------------------------------------
	--=====Locations where players can sell stuff========--
	--------------------------------------------------------

	Config.SellFish = {x = 1238.49, y = -2923.2, z = 8.32} --Place where players can sell their fish
	Config.SellTurtle = {x = 3804.0, y = 4443.3, z = 2.2} --Place where players can sell their turtles 
	Config.SellShark = {x = 2517.6 , y = 4218.0, z = 38.05} --Place where players can sell their sharks

	--------------------------------------------------------
	--=====Locations where players can rent boats========--
	--------------------------------------------------------

Config.MarkerZones = { 
	{
		Marker = vec3(23.37, -2778.49, 4.7), -- Rental Marker
		Spawn = vec3(15.1,-2839.17, 2.62), -- Boat Spawn Point
		SpawnHeading = 174.9, -- Boat Heading
		Return = vec3(59.12,-2776.01,-0.46) -- Boat Return Point
	},
}

Config.RentalBoats = {
	{model = "tug", price = 2500},
	{model = "dinghy4", price = 5000},
	{model = "TORO", price = 15000},
	{model = "MARQUIS", price = 6000},
	{model = "jetmax", price = 7000},
	{model = "suntrap", price = 5000},
}