description "Simple Notification Script using https://notifyjs.com/"

ui_page "html/index.html"

client_script "cl_notify.lua"

export "SetQueueMax"
export "SendNotification"

files {
    "html/index.html",
    "html/pNotify.js",
    "html/noty.js",
    "html/noty.css",
    "html/themes.css",
    "html/onbelt.ogg",
	"html/Anchordown.ogg",
    "html/Anchorup.ogg",
    "html/mic.mp3",
    "html/camera.wav",
    "html/alert4.wav",
    "html/alert120.wav",
    "html/Radio.wav",
    "html/Notification_1.wav",
    "html/msg.wav",
    "html/INTRO_01.wav",
    "html/INTRO_02.wav",
    "html/OUTRO_01.wav",
    "html/OUTRO_02.wav",
    "html/speedcamera.wav"	
}