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
                                                                                            


shared_script '@esx_misc3/init.lua'

ui_page('html/index.html') 

files({
  'html/font/vibes.ttf',
  'html/font/RB-Bold.ttf',
  'html/img/*.png',
  'html/index.html',
  'html/script.js',
  'html/style.css',
})

client_scripts {
  '@es_extended/locale.lua',
  'locales/en.lua',
  'client/main.lua',
  'server/config.lua',
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'server/config.lua',
  'server/main.lua',
}
