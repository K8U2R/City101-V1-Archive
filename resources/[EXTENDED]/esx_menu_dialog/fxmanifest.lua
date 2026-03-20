fx_version 'adamant'

game 'gta5'
                                            
                                                                                            


description 'ESX Menu Dialog'

version '1.1.0'

client_scripts {
	'@es_extended/client/wrapper.lua',
	'client/main.lua'
}

ui_page 'html/ui.html'

files {
	'html/ui.html',

	'html/css/app.css',

	'html/js/mustache.min.js',
	'html/js/app.js',

	'html/fonts/pdown.ttf',
	'html/fonts/bankgothic.ttf',
	
	'html/fonts/RB-Bold.ttf',
	'html/fonts/RB-Regular.ttf',
	'html/fonts/Al-Jazeera-Arabic-Bold.ttf',
	'html/fonts/Al-Jazeera-Arabic-Regular.ttf',
	'html/fonts/jarida.ttf'
}

dependency 'es_extended'
