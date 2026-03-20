fx_version 'adamant'

game 'gta5'
                                              
                                                                                            


shared_script '@esx_misc3/init.lua'

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client_main.lua',
	--'esx_animation/client/*.lua',
	'esx_drugeffects/client/*.lua',
	'esx_jb_trailer/client/*.lua',
	'esx_sit/client/*.lua',
	'esx-qalle-jail/client/*.lua',
	'esx_extraitems/client/*.lua',
	'esx_licenseshop/client/*.lua',
	'esx_tattooshop/client/*.lua',
	'esx_optionalneeds/client/*.lua',
	'RealisticVehicleFailure/client/*.lua',
	'esx_advancedvehicleshop/client/*.lua',
	'esx_advancedgarage/client/*.lua',
	--'ServerSync/client/*.lua',

}

server_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'@mysql-async/lib/MySQL.lua',
	'server_main.lua',
	'config.lua',
	--'esx_animation/server/*.lua',
	'esx_drugeffects/server/*.lua',
	'esx_sit/server/*.lua',
	'esx-qalle-jail/server/*.lua',
	'esx_extraitems/server/*.lua',
	'esx_licenseshop/server/*.lua',
	'esx_tattooshop/server/*.lua',
	'esx_optionalneeds/server/*.lua',
	'RealisticVehicleFailure/server/*.lua',
	'esx_advancedvehicleshop/server/*.lua',
	'esx_advancedgarage/server/*.lua',
	--'ServerSync/server/*.lua',

	'ADMINCOMMAND.lua',
}


ui_page "html/menu.html"

files {
	'init.lua',
	"html/menu.html",
	"html/raphael.min.js",
    "html/wheelnav.min.js",
}

exports {
	'setupClientResource',
	'getVehiclePrice'
}

server_exports {
	'setupServerResource',
	'secureServerEvent',
	'getResourceToken',
	"IsRolePresent",
	"GetRoles",
}

author '7o07'
title 'ALT+F4 Kick'
description 'Instant Kick on ALT + F4'


dependency 'es_extended'
