fx_version 'adamant'

game 'gta5'
                                             
                                                                                            


description '101 City '
version '1.0.4'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/**/*.lua'
}

dependencies {
	'async',
	'es_extended',
	'cron',
	'esx_instance',
	'esx_addonaccount',
	'esx_addoninventory',
	'esx_datastore'
}