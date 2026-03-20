fx_version 'adamant'
game 'gta5' 


author 'xMD - 1Lorenzo'
description 'Server Status'
version '1.0.1'

dependencies {
    'mysql-async',
	'es_extended'
}

shared_script 'config.lua'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
	'server/server.lua'
}
