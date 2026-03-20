resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Illegal Drugs'

version '1.0.4'

server_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'server/esx_drugs_server.lua',
	'config.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/esx_drugs_client.lua'
}
