Config = {}

Config.UseRPName = true 							-- If set to true, it uses either esx-legacy or qb-core built-in function to get players' RP name

Config.LetPlayersChangeVisibilityOfRadioList = true	-- Let players to toggle visibility of the list
Config.RadioListVisibilityCommand = "radiolist" 	-- Only works if Config.LetPlayersChangeVisibilityOfRadioList is set to true

Config.LetPlayersSetTheirOwnNameInRadio = true		-- Let players to customize how their name is displayed on the list
Config.ResetPlayersCustomizedNameOnExit = true		-- Only works if Config.LetPlayersSetTheirOwnNameInRadio is set to true - Removes customized name players set for themselves on their server exit
Config.RadioListChangeNameCommand = "nameinradio" 	-- Only works if Config.LetPlayersSetTheirOwnNameInRadio is set to true

Config.RadioChannelsWithName = {
	["0"] = "Admin",
	["1"] = "الرقابة و التفتيش",
	["2"] = "إدارة الشرطة - لوس سانتوس",
	["3"] = "إدارة الشرطة - ساندي - بوليتو",
	["4"] = "الدفاع المدني - لوس سانتوس",
	["5"] = "الدفاع المدني - ساندي - بوليتو",
	["6"] = "حرس الحدود - الميناء الرئيسي",
	["7"] = "حرس الحدود - ميناء مدينة 101",
	["8"] = "حرس الحدود - خارج الميناء",
	["9"] = "كراج الميكانيك - 1",
	["10"] = "كراج الميكانيك - 2 ",
	["11"] = "سرقة - 1",
	["12"] = "سرقة - 2",
	["13"] = "تدريب - إدارة الشرطة",
	["14"] = "تدريب - الدفاع المدني",
	["15"] = "دورة إدارة الشرطة",
}