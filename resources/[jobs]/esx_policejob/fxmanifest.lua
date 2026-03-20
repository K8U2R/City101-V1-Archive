shared_script '@FiveEye/FiveEye.lua'

fx_version 'adamant'

game 'gta5'
--[[
  ______ ___ ______    _____ _                                                              
 |____  / _ \____  |  / ____| |                                                             
     / / | | |  / /  | (___ | |_ ___  _ __ ___   ______  __      _____  ___  __ _ _ __ ___  
    / /| | | | / /    \___ \| __/ _ \| '__/ _ \ |______| \ \ /\ / / _ \/ __|/ _` | '_ ` _ \ 
   / / | |_| |/ /     ____) | || (_) | | |  __/           \ V  V /  __/\__ \ (_| | | | | | |
  /_/   \___//_/     |_____/ \__\___/|_|  \___|            \_/\_/ \___||___/\__,_|_| |_| |_|
  شكرا لشرائك ملفات  1 من متجر 707             
thx for buying files v1 from 707 store 
شكرا لثقتك بنا / Thank you for trusting us.                   
--]]                                                  
                                                                                            


description 'ESX Police Job'

version '1.3.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/de.lua',
	'locales/en.lua',
	'locales/pl.lua',
	'locales/fr.lua',
	'locales/fi.lua',
	'locales/es.lua',
	'locales/sv.lua',
	'locales/ko.lua',
	'locales/cs.lua',
	'locales/nl.lua',
	'locales/tr.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/de.lua',
	'locales/en.lua',
	'locales/pl.lua',
	'locales/fr.lua',
	'locales/fi.lua',
	'locales/es.lua',
	'locales/sv.lua',
	'locales/ko.lua',
	'locales/cs.lua',
	'locales/nl.lua',
	'locales/tr.lua',
	'config.lua',
	'client/main.lua',
	'client/vehicle.lua'
}

dependencies {
	'es_extended',
	'esx_billing'
}
