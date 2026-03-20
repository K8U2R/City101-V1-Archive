fx_version 'adamant'

game 'gta5'
                                            
                                                                                            


description 'مدينة 101'

client_script {
	"config.lua",
	"radialmenu.lua",
    "animations.lua",
	"main.lua",
	'client/**/*.lua'
}

server_script {

	"server/sv_piggyback.lua",

	"server/sv_carry.lua",

	"server/va_server.lua",

	"server/sv_ast.lua",

	"server/sv_slap.lua",

	'server/sv_sarer.lua',


	"server/sv_takehostage.lua",


	"server/sv_heli.lua",
}

ui_page "html/menu.html"

files {
	"html/menu.html",
	"html/raphael.min.js",
	"html/wheelnav.js",
	"html/wheelnav.min.js",
	"html/RB-Bold.ttf",
}

export 'isPlayerDoingAnimation2'