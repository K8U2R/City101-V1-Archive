fx_version 'adamant'

game 'gta5'
                                             
                                                                                            


shared_script '@esx_misc3/init.lua'

description 'ESX misc'

ui_page 'html/ui.html'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/*.lua'
}

client_scripts {
	'config.lua',
	'client/*.lua'
}

files {
	--esx_hud
	
	--visualsettings
	'files/visualsettings.dat',
}

dependencies {
	'es_extended',
}

exports {
	'GetFuel',
	'SetFuel',
	'Exp_XNL_GetCurrentPlayerXP',
	'Exp_XNL_GetLevelFromXP',
	'ESXP_GetRank',
	-- Port State
	'panicstate',
}
