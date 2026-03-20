-- https://wiki.fivem.net/wiki/Resource_manifest

fx_version 'adamant'

game 'gta5'                                              
                                                                                            


description 'An series of scripts 2'

version '2.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'config.lua',
	'server.lua',
	'other/esx_sit_lists_seat.lua', -- esx_sit list
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'config.lua',
	'other/esx_sit_lists_seat.lua', -- esx_sit list
	'client/esx_sit_cl.lua', -- esx_sit client
	'client/carwash_cl.lua', -- غسيل السيارات
	'client/PoliceVehiclesWeaponDeleter.lua',
}

ui_page "html/Slapping/index.html" -- الكف ALT + G 

files {
    'html/Slapping/index.html', -- الكف ALT + G
    'html/Slapping/Giffle.ogg' -- الكف ALT + G
}