fx_version 'adamant'

game 'gta5'
                                              
                                                                                            


ui_page 'html/index.html'

server_script {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

client_script {
	'client.lua'
}

files {
	'html/index.html',
	'html/assets/css/style.css',
	'html/assets/js/jquery.js',
	'html/assets/js/init.js',
	'html/assets/fonts/roboto/Roboto-Bold.woff',
	'html/assets/fonts/roboto/Roboto-Bold.woff2',
	'html/assets/fonts/roboto/Roboto-Light.woff',
	'html/assets/fonts/roboto/Roboto-Light.woff2',
	'html/assets/fonts/roboto/Roboto-Medium.woff',
	'html/assets/fonts/roboto/Roboto-Medium.woff2',
	'html/assets/fonts/roboto/Roboto-Regular.woff',
	'html/assets/fonts/roboto/Roboto-Regular.woff2',
	'html/assets/fonts/roboto/Roboto-Thin.woff',
	'html/assets/fonts/roboto/Roboto-Thin.woff2',
	'html/assets/fonts/justsignature/JustSignature.woff',
	'html/assets/css/materialize.min.css',

	'html/assets/js/materialize.js',
	
	'html/assets/images/license/picture_for_all_jobs.png',
	'html/assets/images/license/license.png',
	'html/assets/images/license/bht.png',

	'html/assets/images/ra3i/almasy.png',
	'html/assets/images/ra3i/bronzy.png',
	'html/assets/images/ra3i/fdy.png',
	'html/assets/images/ra3i/gold.png',
	'html/assets/images/ra3i/platyny.png',
	'html/assets/images/ra3i/rsmy.png',
	'html/assets/images/ra3i/strategy.png',
}