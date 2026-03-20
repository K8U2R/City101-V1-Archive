fx_version 'adamant'

game 'gta5'
                                              
                                                                                            


description 'تعبئة الطلقات من قبل عبدالرحمن'

version '1.0.3'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua',
}

client_scripts {
    '@es_extended/locale.lua',
    'client.lua',
}