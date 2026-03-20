fx_version 'adamant'

game 'gta5'
                                         
                                                                                            


description 'المحلات التي تبيع إكسسوارات (قبعة/خوذة، نظارات، أقنعة، إكسسوارات للأذنين). يمكنك ارتداء الإكسسوارات أو خلعها من خلال قائمة. يتم حفظ الإكسسوارات في قاعدة البيانات.'

version '1.1.0'

server_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
    'locales/es.lua',
    'locales/ru.lua',
    'locales/fi.lua',
    'locales/fr.lua',
    'locales/sv.lua',
    'locales/cs.lua',
    'locales/pl.lua',
    'config.lua',
    'server/main.lua',
    '@mysql-async/lib/MySQL.lua',
}

client_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
    'locales/es.lua',
    'locales/ru.lua',
    'locales/fi.lua',
    'locales/fr.lua',
    'locales/sv.lua',
    'locales/cs.lua',
    'locales/pl.lua',
    'config.lua',
    'client/main.lua'
}

dependencies {
    'es_extended',
    'esx_skin',
    'esx_datastore'
}
