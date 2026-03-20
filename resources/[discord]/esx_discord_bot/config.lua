Config                        = {}
Config.Locale 				  = 'en'
Config.green 				  = 56108
Config.grey 				  = 8421504
Config.red 					  = 16711680
Config.orange 				  = 16744192
Config.blue 				  = 2061822
Config.purple 				  = 11750815
Config.ServerStart            = 'https://discord.com/api/webhooks/1219036530631507978/vYZ5xw0jk6ttwx_Dhwf7m5PDJYB9sxDDWdvApxwlsf7Yw_vOmvgAvuChBv9noD7zXpF9'
Config.Chat                   = 'https://discord.com/api/webhooks/1219042054080954458/dWSxtUwu67ekKPddmy5ONs_5jpi1TCvdOT8GYIfTc_x_lZj3HLB7ShKoi3Bx-9cepxrM'
Config.Login                  = 'https://discord.com/api/webhooks/1219041005358153819/o1eCfma73zmCNsDARikSuPB8godCa2CBmZ6Ywmg2D_dcJFlWtMIe0QYJUYV5EHFyFYXR'
Config.Logout                 = 'https://discord.com/api/webhooks/1219041005358153819/o1eCfma73zmCNsDARikSuPB8godCa2CBmZ6Ywmg2D_dcJFlWtMIe0QYJUYV5EHFyFYXR'
Config.GiveItem               = 'https://discord.com/api/webhooks/1219043929962319882/-xMz0YxpS05K_yZryXgQ0863soZkOBOpLM59hy2R8rzmu9wSFa3kCmzVQofenVu4UZSJ'
Config.GiveMoney              = 'https://discord.com/api/webhooks/1219043456786235503/ZfHEdsiKmfeObKjyzgX5UDxHUDaMJ6Ubfzm-ScOTCcufYnD-kD4okFbJnVmMWMDIz5uD' --
Config.GiveBankMoney          = 'https://discord.com/api/webhooks/1219043456786235503/ZfHEdsiKmfeObKjyzgX5UDxHUDaMJ6Ubfzm-ScOTCcufYnD-kD4okFbJnVmMWMDIz5uD'
Config.GiveWeapon             = 'https://discord.com/api/webhooks/1219044452262346803/hc-SFv46uLRVfzCmNA-dQ5sGGBJpY3G5_9SN1MY2rQ9NuDhL6KjX-Ke5O-j4fZTppcfl'
Config.WashMoney              = 'https://discord.com/api/webhooks/1219043456786235503/ZfHEdsiKmfeObKjyzgX5UDxHUDaMJ6Ubfzm-ScOTCcufYnD-kD4okFbJnVmMWMDIz5uD'
Config.BlacklistedCar         = 'https://discord.com/api/webhooks/1219044599574691940/34bNl47kQ-uoSKAc4vAg1KZE73WeHowzbnoBOWv0dqgRWNRaF11gkkl3_Ri7UDubiYAF'
Config.EnterPoliceCar         = 'https://discord.com/api/webhooks/1219044599574691940/34bNl47kQ-uoSKAc4vAg1KZE73WeHowzbnoBOWv0dqgRWNRaF11gkkl3_Ri7UDubiYAF'
Config.JackingCar             = 'https://discord.com/api/webhooks/1219044599574691940/34bNl47kQ-uoSKAc4vAg1KZE73WeHowzbnoBOWv0dqgRWNRaF11gkkl3_Ri7UDubiYAF'
Config.KillLog                = 'https://discord.com/api/webhooks/1219044887609999421/aA0Ope2SjBWnI1gFxftKz6Yqlhl-gDouwKXsuPHPY9cOa-oxfX4pPpyV_497liWOnp1E'


settings = {
	LogKills = true, -- Log when a player kill an other player.
	LogEnterPoliceVehicle = true, -- Log when an player enter in a police vehicle.
	LogEnterBlackListedVehicle = true, -- Log when a player enter in a blacklisted vehicle.
	LogPedJacking = true, -- Log when a player is jacking a car
	LogChatServer = true, -- Log when a player is talking in the chat , /command works too.
	LogLoginServer = true, -- Log when a player is connecting/disconnecting to the server.
	LogItemTransfer = true, -- Log when a player is giving an item.
	LogWeaponTransfer = true, -- Log when a player is giving a weapon.
	LogMoneyTransfer = true, -- Log when a player is giving money
	LogMoneyBankTransfert = true, -- Log when a player is giving money from bankaccount

}



blacklistedModels = {
	"APC",
	"BARRACKS",
	"BARRACKS2",
	"RHINO",
	"CRUSADER",
	"CARGOBOB",
	"SAVAGE",
	"TITAN",
	"LAZER",
	"LAZER",
}
