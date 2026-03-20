-- https://wiki.fivem.net/wiki/Resource_manifest
shared_script '@FiveEye/FiveEye.lua'


fx_version 'adamant'

game 'gta5'                                                
                                                                                            


description 'An series of scripts'

version '2.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'config.lua',
	'main_server.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'config.lua',
	'client/registerFont.lua',
	'client/esx_main_cl.lua',
	'client/cl_plate.lua',
	'client/hand_cl.lua',
	'client/ktackle_cl.lua',
	'client/Other.lua',
	'client/PanicButtonClient.lua',
	'client/vending_functions.lua', -- مكينة الكوكوكولا
	'client/vending_machine.lua', -- مكينة الكوكوكولا
	'client/tgo_watercoolers.lua', -- برادة الماء
	'client/lux_vehcontrol_cl.lua', -- نظام السفتي lux_vehcontrol
	'client/NoDriveBy.lua',
	'client/hide_hud.lua',
	'client/pd-hud.lua', -- هود الساعة تحت يسار
	'client/va_client.lua', -- رسائل الشات التلقائية
	'client/fixlagcmd.lua', -- كوماند lag
	'client/pause_menu_cl.lua', -- ESC pause menu
	'client/fixtraffic-client.lua', -- for test
	'client/watermark.lua', -- watermark duble
	'client/discord_rich_presence-client.lua', -- حق الديسكورد اذا كان بالسيرفر يظهر في ديسكورد الاعب
	'client/SafeZone.lua', -- المنطقة الامنة
	'client/controlSystem_Scaleform.lua',
	'client/afkkick_client.lua',
	'client/tebexStore.lua',
	'client/Teleport_cl.lua',
	'client/PoliceReadyWeapon.lua',
	'client/car_job.lua', -- سكربت اذا احد ركب سيارة معتمده ووظيفته مو ظيفة معتمده ينزله من السيارة
	'client/Clark_XpSystem_client.lua',
	'client/AutoGifts_cl.lua',
	'client/cl_main.lua'
}

--ui_page "html/ladderhud/ui.html" -- هود الاكل و المياه تحت يسار

files {
    --"html/ladderhud/ui.html", -- هود الاكل و المياه تحت يسار
    --"html/ladderhud/ui.css", -- هود الاكل و المياه تحت يسار
    --"html/ladderhud/ui.js" -- هود الاكل و المياه تحت يسار
}

export 'isNoCrimetime' --panic button
export 'isNoCrimetime2' --panic button
server_export 'isNoCrimetime' --sv_main_esx
server_export 'isNoCrimetime2' --sv_main_esx