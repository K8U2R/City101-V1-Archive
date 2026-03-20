Config = {}

Config.AllLogs = true											-- Enable/Disable All Logs Channel
Config.postal = true  											-- set to false if you want to disable nerest postal (https://forum.cfx.re/t/release-postal-code-map-minimap-new-improved-v1-2/147458)
Config.username = "" 							-- Bot Username
Config.avatar = "https://via.placeholder.com/30x30"				-- Bot Avatar
Config.communtiyName = "Califonia"					-- Icon top of the Embed
Config.communtiyLogo = "https://via.placeholder.com/30x30"		-- Icon top of the Embed


Config.weaponLog = true  			-- set to false to disable the shooting weapon logs

Config.playerID = true				-- set to false to disable Player ID in the logs
Config.steamID = true				-- set to false to disable Steam ID in the logs
Config.steamURL = true				-- set to false to disable Steam URL in the logs
Config.discordID = true				-- set to false to disable Discord ID in the logs
Config.license = true				-- set to false to disable license in the logs
Config.IP = true					-- set to false to disable IP in the logs


-- Change color of the default embeds here
-- It used Decimal or Hex color codes. They will both work.
Config.joinColor = "#3AF241" 	 	-- Player Connecting
Config.leaveColor = "#F23A3A"		-- Player Disconnected
Config.chatColor = "#A1A1A1"		-- Chat Message
Config.shootingColor = "#2E66F2"	-- Shooting a weapon
Config.deathColor = "#000000"		-- Player Died
Config.resourceColor = "#EBEE3F"	-- Resource Stopped/Started



Config.webhooks = {
	all = "https://discord.com/api/webhooks/1219071119890452593/fEPOEsUL2n9DKTMODUAzkJ_n21EFrMA2W67I6wKNLM78OO1hEfGvzMdhWcXTWlQA_nQ2",
    chat = "https://discord.com/api/webhooks/1219042054080954458/dWSxtUwu67ekKPddmy5ONs_5jpi1TCvdOT8GYIfTc_x_lZj3HLB7ShKoi3Bx-9cepxrM",
    joins = "https://discord.com/api/webhooks/1219041005358153819/o1eCfma73zmCNsDARikSuPB8godCa2CBmZ6Ywmg2D_dcJFlWtMIe0QYJUYV5EHFyFYXR",
    leaving = "https://discord.com/api/webhooks/1219041005358153819/o1eCfma73zmCNsDARikSuPB8godCa2CBmZ6Ywmg2D_dcJFlWtMIe0QYJUYV5EHFyFYXR",
    deaths = "https://discord.com/api/webhooks/1219044887609999421/aA0Ope2SjBWnI1gFxftKz6Yqlhl-gDouwKXsuPHPY9cOa-oxfX4pPpyV_497liWOnp1E",
    shooting = "https://discord.com/api/webhooks/1219071119890452593/fEPOEsUL2n9DKTMODUAzkJ_n21EFrMA2W67I6wKNLM78OO1hEfGvzMdhWcXTWlQA_nQ2",
    resources = "https://discord.com/api/webhooks/1219036530631507978/vYZ5xw0jk6ttwx_Dhwf7m5PDJYB9sxDDWdvApxwlsf7Yw_vOmvgAvuChBv9noD7zXpF9",
    shopstore = "https://discord.com/api/webhooks/1219058748715175957/zMxSlGXcuB_HQFEgRTtqE8zuUiLRN1kxsUs-IKJUgzAVV_moOd6RAkk9RHzbPtu5XM0l",
    shopbuy = "https://discord.com/api/webhooks/1219058748715175957/zMxSlGXcuB_HQFEgRTtqE8zuUiLRN1kxsUs-IKJUgzAVV_moOd6RAkk9RHzbPtu5XM0l",
    shopmoney = "https://discord.com/api/webhooks/1219058748715175957/zMxSlGXcuB_HQFEgRTtqE8zuUiLRN1kxsUs-IKJUgzAVV_moOd6RAkk9RHzbPtu5XM0l",
    vehiclebuy = "https://discord.com/api/webhooks/1219053887793795135/EOKbW2Psjw58BG3CchvO1iBMfRautimeMP-tj8Q7ooY7baNNTWtqlULCMkTOpwrKfg4G",
    weaponbuy = "https://discord.com/api/webhooks/1219069738991222824/PHiP8D7lqmIdw8K4CcebUl_AYgNJqN3nWXVp87YiPQsDjmITbKwTO6Sakx_2-C-ardsT",
    depositbank = "https://discord.com/api/webhooks/1219071907241136189/r6RrLSbotE_PMGCviFMc4a1CSh9zyd-b4Swf8LqBBikRYFkKWX3rgZD9dPb4KxuMDVrr",
    withdrawbank = "https://discord.com/api/webhooks/1219071907241136189/r6RrLSbotE_PMGCviFMc4a1CSh9zyd-b4Swf8LqBBikRYFkKWX3rgZD9dPb4KxuMDVrr",
    drugsell = "https://discord.com/api/webhooks/1219052188047900773/cE8Qo99-DAH_P-6wDq6XCpyKb4p-jgoJInxYpOHOfVpSfprvJxWsxd7In87_2sYR0sF1",
    jailperson = "https://discord.com/api/webhooks/1219070752326946887/-IxgcuiH13c0YwLFiYiNRfp3bDpZOJeOq7wT6gyOHbddCv8OWUllYSWPcT9FxSovIn0P",
    unjailperson = "https://discord.com/api/webhooks/1219070752326946887/-IxgcuiH13c0YwLFiYiNRfp3bDpZOJeOq7wT6gyOHbddCv8OWUllYSWPcT9FxSovIn0P",
    moneywash = "https://discord.com/api/webhooks/1219050571366006914/KApSQ0XJ4ucJLFPdXmnwk2iP2oeHU6AmoDpyAsRrcredB4maLTusw4svkwibpqYLRzVR",
    jobssell = "https://discord.com/api/webhooks/1219052188047900773/cE8Qo99-DAH_P-6wDq6XCpyKb4p-jgoJInxYpOHOfVpSfprvJxWsxd7In87_2sYR0sF1",
    jobsoc = "https://discord.com/api/webhooks/1219071119890452593/fEPOEsUL2n9DKTMODUAzkJ_n21EFrMA2W67I6wKNLM78OO1hEfGvzMdhWcXTWlQA_nQ2",
    radio = "https://discord.com/api/webhooks/1219071119890452593/fEPOEsUL2n9DKTMODUAzkJ_n21EFrMA2W67I6wKNLM78OO1hEfGvzMdhWcXTWlQA_nQ2",
    threwitem = "https://discord.com/api/webhooks/1219051009108873246/L_0qVAYrEoPee2DxZTT8O_WIw7Q1y-7lsUw0kUNTtzRaQ1xxpSssOjmHpDsUv1_LL921",
}


 --Debug shizzels :D
Config.debug = false
Config.versionCheck = "1.1.3"
