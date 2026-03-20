-- CONFIG --
local playersOnline = 0
local id, name = GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId())
local idoffset,idoffset2,idoffset3
local playerset = 0
local hRect = 0.025
local Hours = 0
local Minutes = 0
local wRect = 0.3
local h = 0.01 --spirit high
local Period = nil
local w = 0.017 --spirit width
-- rect color

local rectWhite = {r=220,g=220,b=220,a=70}

local rectBlack = {r=0,g=0,b=0,a=150}

local rectBlue = {r=0,g=100,b=255,a=100}
local _barTexture = 'all_black_bg'
local _barTextureDict = 'timerbars'

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

local promotion = {

	['doubleXP'] = {status=false,label='ضعف الخبرة',msg1='ﺓﺮﺒﺨﻟﺍ ﻒﻌﺿ',msg2='ﺽﺮﻌﻟﺍ ﺃﺪﺑ',msg3='ﺽﺮﻌﻟﺍ ﻰﻬﺘﻧﺍ',DrawTextY=0, timer=false, time = 0,Sprite = true,dict = "mprpsymbol",Spritename = "rp"},

	['lumberjack'] = {status=false,label='ضعف الأجر أخشاب',msg1='ﺏﺎﺸﺧﺃ ﺮﺟﻷﺍ ﻒﻌﺿ',msg2='ﺽﺮﻌﻟﺍ ﺃﺪﺑ',msg3='ﺽﺮﻌﻟﺍ ﻰﻬﺘﻧﺍ',DrawTextY=0, timer=false, time = 0,Sprite = true,dict = "mpleaderboard",Spritename = "leaderboard_cash_icon"},

	['miner'] = {status=false,label='ضعف الأجر معادن',msg1='ﻥﺩﺎﻌﻣ ﺮﺟﻷﺍ ﻒﻌﺿ',msg2='ﺽﺮﻌﻟﺍ ﺃﺪﺑ',msg3='ﺽﺮﻌﻟﺍ ﻰﻬﺘﻧﺍ',DrawTextY=0,timer=false, time = 0,Sprite = true,dict = "mpleaderboard",Spritename = "leaderboard_cash_icon"},

	['9ndo8_almtagr'] = {status=false,label='ضعف صندوق المتاجر',msg1='ﺮﺟﺎﺘﻤﻟﺍ قﻭﺪﻨﺻ ﻒﻌﺿ',msg2='ﺽﺮﻌﻟﺍ ﺃﺪﺑ',msg3='ﺽﺮﻌﻟﺍ ﻰﻬﺘﻧﺍ',DrawTextY=0, timer=false},

	['slaughterer'] = {status=false,label='ضعف الأجر دواجن',msg1='ﻦﺟﺍﻭﺩ ﺮﺟﻷﺍ ﻒﻌﺿ',msg2='ﺽﺮﻌﻟﺍ ﺃﺪﺑ',msg3='ﺽﺮﻌﻟﺍ ﻰﻬﺘﻧﺍ',DrawTextY=0, timer=false, time = 0,Sprite = true,dict = "mpleaderboard",Spritename = "leaderboard_cash_icon"},

	['tailor'] = {status=false,label='ضعف الأجر أقمشة',msg1='ﺔﺸﻤﻗﺃ ﺮﺟﻷﺍ ﻒﻌﺿ',msg2='ﺽﺮﻌﻟﺍ ﺃﺪﺑ',msg3='ﺽﺮﻌﻟﺍ ﻰﻬﺘﻧﺍ',DrawTextY=0, timer=false, time = 0,Sprite = true,dict = "mpleaderboard",Spritename = "leaderboard_cash_icon"},

	['fueler'] = {status=false,label='ضعف الأجر نفط وغاز',msg1='ﺯﺎﻏﻭ ﻂﻔﻧ ﺮﺟﻷﺍ ﻒﻌﺿ',msg2='ﺽﺮﻌﻟﺍ ﺃﺪﺑ',msg3='ﺽﺮﻌﻟﺍ ﻰﻬﺘﻧﺍ',DrawTextY=0, timer=false, time = 0,Sprite = true,dict = "mpleaderboard",Spritename = "leaderboard_cash_icon"},

	['farmer'] = {status=false,label='ضعف الأجر العنب',msg1='ﺐﻨﻌﻟﺍ ﺮﺟﻷﺍ ﻒﻌﺿ',msg2='ﺽﺮﻌﻟﺍ ﺃﺪﺑ',msg3='ﺽﺮﻌﻟﺍ ﻰﻬﺘﻧﺍ',DrawTextY=0, timer=false, time = 0,Sprite = true,dict = "mpleaderboard",Spritename = "leaderboard_cash_icon"},

	['police_level'] = {status=false,label='ضعف الخبره للوظايف المعتمدة',msg1='ةﺪﻤﺘﻌﻤﻟﺍ ﻒﻳﺎﻇﻮﻠﻟ هﺮﺒﺨﻟﺍ ﻒﻌﺿ',msg2='ﺽﺮﻌﻟﺍ ﺃﺪﺑ',msg3='ﺽﺮﻌﻟﺍ ﻰﻬﺘﻧﺍ',DrawTextY=0, timer=false, time = 0,Sprite = true,dict = "mprpsymbol",Spritename = "rp"},

	['fork'] = {status=false,label='ضعف الأجر خدمات الموانئ',msg1='ﺊﻧﺍﻮﻤﻟﺍ ﺕﺎﻣﺪﺧ ﺮﺟﻷﺍ ﻒﻌﺿ',msg2='ﺽﺮﻌﻟﺍ ﺃﺪﺑ',msg3='ﺽﺮﻌﻟﺍ ﻰﻬﺘﻧﺍ',DrawTextY=0, timer=false, time = 0,Sprite = true,dict = "mpleaderboard",Spritename = "leaderboard_cash_icon"},

	['fisherman'] = {status=false,label='ضعف الأجر الأسماك',msg1='ﻙﺎﻤﺳﻷﺍ ﺮﺟﻷﺍ ﻒﻌﺿ',msg2='ﺽﺮﻌﻟﺍ ﺃﺪﺑ',msg3='ﺽﺮﻌﻟﺍ ﻰﻬﺘﻧﺍ',DrawTextY=0, timer=false, time = 0,Sprite = true,dict = "mpleaderboard",Spritename = "leaderboard_cash_icon"},

	['vegetables'] = {status=false,label='ضعف الأجر الخضروات',msg1='ﺕﺍﻭﺮﻀﺨﻟﺍ ﺮﺟﻷﺍ ﻒﻌﺿ',msg2='ﺽﺮﻌﻟﺍ ﺃﺪﺑ',msg3='ﺽﺮﻌﻟﺍ ﻰﻬﺘﻧﺍ',DrawTextY=0, timer=false, time = 0,Sprite = true,dict = "mpleaderboard",Spritename = "leaderboard_cash_icon"},
	
	['all'] = {status=false,label='ضعف الأجر جميع الوظائف',msg1='ﻒﺋﺎﻇﻮﻟﺍ ﻊﻴﻤﺟ ﺮﺟﻷﺍ ﻒﻌﺿ',msg2='ﺽﺮﻌﻟﺍ ﺃﺪﺑ',msg3='ﺽﺮﻌﻟﺍ ﻰﻬﺘﻧﺍ',DrawTextY=0, Color={r=204,g=255,b=51},timer=false, time = 0},


	['NoCrimetime'] = {status=false,label='ممنوع الأجرام',msg1='مﺍﺮﺟﻷﺍ عﻮﻨﻤﻣ',msg2='ﻉﻮﻨﻤﻣ',msg3='ﺡﻮﻤﺴﻣ',DrawTextY=0,Color={r=255,g=0,b=0},timer=false, time = 0,Sprite = true,dict = "commonmenutu",Spritename = "team_deathmatch"},

	['LosSantonNoCrime'] = {status=false,label='ممنوع الأجرام في لوس',msg1='سﻮﻟ ﻲﻓ مﺍﺮﺟﻷﺍ عﻮﻨﻤﻣ',msg2='ﻉﻮﻨﻤﻣ',msg3='ﺡﻮﻤﺴﻣ',DrawTextY=0,Color={r=255,g=0,b=0},timer=false, time = 0,dict = "commonmenutu",Spritename = "team_deathmatch"},

	['SandyNoCrime'] = {status=false,label='ممنوع الأجرام في ساندي',msg1='يﺪﻧﺎﺳ ﻲﻓ مﺍﺮﺟﻷﺍ عﻮﻨﻤﻣ',msg2='ﻉﻮﻨﻤﻣ',msg3='ﺡﻮﻤﺴﻣ',DrawTextY=0,Color={r=255,g=0,b=0},timer=false, time = 0,dict = "commonmenutu",Spritename = "team_deathmatch"},
	
	['PoletoNoCrime'] = {status=false,label='ممنوع الأجرام في بوليتو',msg1='ﻮﺘﻴﻟﻮﺑ ﻲﻓ مﺍﺮﺟﻷﺍ عﻮﻨﻤﻣ',msg2='ﻉﻮﻨﻤﻣ',msg3='ﺡﻮﻤﺴﻣ',DrawTextY=0,Color={r=255,g=0,b=0},timer=false, time = 0,dict = "commonmenutu",Spritename = "team_deathmatch"},

	['NoCrimetimeToAll'] = {status=false,label='ممنوع الأجرام للجميع',msg1='ﻊﻴﻤﺠﻠﻟ مﺍﺮﺟﻷﺍ عﻮﻨﻤﻣ',msg2='ﻉﻮﻨﻤﻣ',msg3='ﺡﻮﻤﺴﻣ',DrawTextY=0,Color={r=255,g=0,b=0},timer=false, time = 0,dict = "commonmenutu",Spritename = "team_deathmatch"},

	['SandyAndPoleto'] = {status=false,label='ممنوع الأجرام في ساندي و بوليتو',msg1='ﻮﺘﻴﻟﻮﺑ و يﺪﻧﺎﺳ ﻲﻓ مﺍﺮﺟﻷﺍ عﻮﻨﻤﻣ',msg2='ﻉﻮﻨﻤﻣ',msg3='ﺡﻮﻤﺴﻣ',DrawTextY=0,Color={r=255,g=0,b=0},timer=false, time = 0,dict = "commonmenutu",Spritename = "team_deathmatch"},

	['NewScenario'] = {status=false,label='ممنوع بدأ سيناريو جديد',msg1='ﺪﻳﺪﺟ ﻮﻳﺭﺎﻨﻴﺳ ﺃﺪﺑ ﻉﻮﻨﻤﻣ',msg2='ﻉﻮﻨﻤﻣ',msg3='ﺡﻮﻤﺴﻣ',DrawTextY=0,Color={r=255,g=0,b=0},timer=false, time = 0,Sprite = true,dict = "commonmenu",Spritename = "mp_specitem_cash"},
	
	['MainBank'] = {status=false,label='ممنوع سرقة البنك المركزي',msg1='ﻱﺰﻛﺮﻤﻟﺍ ﻚﻨﺒﻟﺍ ﺔﻗﺮﺳ ﻉﻮﻨﻤﻣ',msg2='ﻉﻮﻨﻤﻣ',msg3='ﺡﻮﻤﺴﻣ',DrawTextY=0,Color={r=255,g=0,b=0},timer=false, time = 0},
	
	['MainBankHave'] = {status=false,label='لايمكنك سرقة البنك المركزي لوجود سرقة حاليا',msg1='يﺰﻛﺮﻣ ﻚﻨﺑ ﺔﻗﺮﺳ ﺎﻴﻟﺎﺣ ﺪﺟﻮﻳ',msg2='ﻉﻮﻨﻤﻣ',msg3='ﺡﻮﻤﺴﻣ',DrawTextY=0,Color={r=255,g=255,b=0},timer=false, time = 0},

	['SmallBanks'] = {status=false,label='ممنوع سرقة البنوك الصغيرة',msg1='ﺓﺮﻴﻐﺼﻟﺍ ﻙﻮﻨﺒﻟﺍ ﺔﻗﺮﺳ ﻉﻮﻨﻤﻣ',msg2='ﻉﻮﻨﻤﻣ',msg3='ﺡﻮﻤﺴﻣ',DrawTextY=0,Color={r=255,g=0,b=0},timer=false, time = 0},

	['SmallBanksHave'] = {status=false,label='لايمكنك سرقة البنوك الصغيرة لوجود سرقة حاليا',msg1='ﺮﻴﻐﺻ ﻚﻨﺑ ﺔﻗﺮﺳ ﺎﻴﻟﺎﺣ ﺪﺟﻮﻳ',msg2='ﻉﻮﻨﻤﻣ',msg3='ﺡﻮﻤﺴﻣ',DrawTextY=0,Color={r=255,g=255,b=0},timer=false, time = 0},

	['Stores'] = {status=false,label='ممنوع سرقة المتاجر',msg1='ﺮﺟﺎﺘﻤﻟﺍ ﺔﻗﺮﺳ ﻉﻮﻨﻤﻣ',msg2='ﻉﻮﻨﻤﻣ',msg3='ﺡﻮﻤﺴﻣ',DrawTextY=0,Color={r=255,g=0,b=0},timer=false, time = 0},

	['StoresHave'] = {status=false,label='لايمكنك سرقة المتاجر لوجود سرقة حاليا',msg1='ﺮﺠﺘﻣ ﺔﻗﺮﺳ ﺎﻴﻟﺎﺣ ﺪﺟﻮﻳ',msg2='ﻉﻮﻨﻤﻣ',msg3='ﺡﻮﻤﺴﻣ',DrawTextY=0,Color={r=255,g=255,b=0},timer=false, time = 0},

	['SellDrugs'] = {status=false,label='ممنوع تهريب الممنوعات',msg1='ﺕﺎﻋﻮﻨﻤﻤﻟﺍ ﺐﻳﺮﻬﺗ ﻉﻮﻨﻤﻣ',msg2='ﻉﻮﻨﻤﻣ',msg3='ﺡﻮﻤﺴﻣ',DrawTextY=0,Color={r=255,g=0,b=0},timer=false, time = 0,Sprite = true,dict = "commonmenu",Spritename = "mp_specitem_cash"},

	['alfnon'] = {status=false,label='ممنوع سرقة معرض الفنون',msg1='نﻮﻨﻔﻟﺍ ضﺮﻌﻣ ﺔﻗﺮﺳ عﻮﻨﻤﻣ',msg2='ﻉﻮﻨﻤﻣ',msg3='ﺡﻮﻤﺴﻣ',DrawTextY=0,Color={r=255,g=0,b=0},timer=false, time = 0,Sprite = true,dict = "commonmenu",Spritename = "mp_specitem_cash"},

	['alfnon_have'] = {status=false,label='لايمكنك سرقة معرض الفنون لوجود سرقة حاليا',msg1='نﻮﻨﻔﻟﺍ ضﺮﻌﻣ ﺔﻗﺮﺳ ﺎﻴﻟﺎﺣ ﺪﺟﻮﻳ',msg2='ﻉﻮﻨﻤﻣ',msg3='ﺡﻮﻤﺴﻣ',DrawTextY=0,Color={r=255,g=255,b=0},timer=false, time = 0},

	['707Store_store'] = {status=false,label='ضعف الخبرة متجر مدينة 101 ',msg1='101 ﺔﻨﻳﺪﻣ ﺮﺠﺘﻣ ﺓﺮﺒﺨﻟﺍ ﻒﻌﺿ',msg2='ﺽﺮﻌﻟﺍ ﺃﺪﺑ',msg3='ﺽﺮﻌﻟﺍ ﻰﻬﺘﻧﺍ',DrawTextY=0,Color={r=255,g=217,b=0}, timer=false, doubleStore=false,time=0, displayTime=""},

	['HjzCar'] = {status=false,label='انت داخل منطقة حجز المركبات',msg1='تﺎﺒﻛﺮﻤﻟﺍ ﺰﺠﺣ ﺔﻘﻄﻨﻣ ﻞﺧﺍﺩ ﺖﻧﺍ',msg2='',msg3='',DrawTextY=0,Color={r=218,g=165,b=32}, timer=false},

	['SafeZone'] = {status=false,label='منطقة آمنة',msg1='ﺔﻨﻣﺁ ﺔﻘﻄﻨﻣ',msg2='',msg3='',DrawTextY=0,Color={r=46,g=204,b=113}, timer=false},

	["location_sell_drugs_1"] = {status=false,label='تهريب 1',msg1='1 ﻊﻗﻮﻣ نﻻﺍ ﺐﻳﺮﻬﺘﻟﺍ ﺔﻘﻄﻨﻣ',msg2='ﻥﻵﺍ ﺐﻳﺮﻬﺘﻟﺍ ﺔﻘﻄﻨﻣ',msg3='ﺐﻳﺮﻬﺘﻟﺍ ﻒﻗﻭ',DrawTextY=0, Color={r=255,g=0,b=0}, timer=false, time = 0},

	["location_sell_drugs_2"] = {status=false,label='تهريب 2',msg1='2 ﻊﻗﻮﻣ نﻻﺍ ﺐﻳﺮﻬﺘﻟﺍ ﺔﻘﻄﻨﻣ',msg2='ﻥﻵﺍ ﺐﻳﺮﻬﺘﻟﺍ ﺔﻘﻄﻨﻣ',msg3='ﺐﻳﺮﻬﺘﻟﺍ ﻒﻗﻭ',DrawTextY=0, Color={r=255,g=0,b=0}, timer=false, time = 0},

	["location_sell_drugs_3"] = {status=false,label='تهريب 3',msg1='3 ﻊﻗﻮﻣ نﻻﺍ ﺐﻳﺮﻬﺘﻟﺍ ﺔﻘﻄﻨﻣ',msg2='ﻥﻵﺍ ﺐﻳﺮﻬﺘﻟﺍ ﺔﻘﻄﻨﻣ',msg3='ﺐﻳﺮﻬﺘﻟﺍ ﻒﻗﻭ',DrawTextY=0, Color={r=255,g=0,b=0}, timer=false, time = 0},

	['TimerSellDrugs'] = {status=false,label='تهريب ممنوعات',msg1='تﺎﻋﻮﻨﻤﻣ ﺐﻳﺮﻬﺗ',msg2='ﺐﻳﺮﻬﺘﻟﺍ ﺖﻗﻭ ءاﺪﺑ',msg3='ﺐﻳﺮﻬﺘﻟﺍ ﺖﻗﻭ ءﺎﻬﺘﻧﺍ',DrawTextY=0,Color={r=218,g=165,b=32}, timer=false, started=false,time=0, displayTime=""},

	['deleteallcars'] = {status=false,label='وقت حذف جميع المركبات',msg1='تﺎﺒﻛﺮﻤﻟﺍ ﻊﻴﻤﺟ فﺬﺣ ﺖﻗﻭ',msg2='ءﺪﺑ',msg3='ءﺎﻬﺘﻧﺍ',DrawTextY=0,Color={r=160,g=32,b=240},timer=false, time = 0},

	['TpAutoMatic'] = {status=false,label='انتقال تلقائي عند دخول السيرفر',msg1='ﺮﻓﺮﻴﺴﻟﺍ لﻮﺧﺩ ﺪﻨﻋ ﻲﺋﺎﻘﻠﺗ لﺎﻘﺘﻧﺍ',msg2='ءﺪﺑ',msg3='ءﺎﻬﺘﻧﺍ',DrawTextY=0,Color={r=218,g=165,b=32},timer=false, time = 0},
	
	['TimerSellDrugs'] = {status=false,label='تهريب ممنوعات',msg1='تﺎﻋﻮﻨﻤﻣ ﺐﻳﺮﻬﺗ',msg2='ﺐﻳﺮﻬﺘﻟﺍ ﺖﻗﻭ ءاﺪﺑ',msg3='ﺐﻳﺮﻬﺘﻟﺍ ﺖﻗﻭ ءﺎﻬﺘﻧﺍ',DrawTextY=0,Color={r=218,g=165,b=32}, timer=false, started=false,time=0, displayTime=""},

}

local portsControl = {

	[1] = {status=true,label='ميناء مدينة 101 البحري',msg1='ﻱﺮﺤﺒﻟﺍ 101 ﺔﻨﻳﺪﻣ ﺀﺎﻨﻴﻣ',msg2='ﻥﻵﺍ ﺮﻳﺪﺼﺘﻟﺍ ﻊﻗﻮﻣ',msg3='ﺮﻳﺪﺼﺘﻟﺍ ﻒﻗﻭ',DrawTextY=0},

	[2] = {status=false,label='ميناء مدينة 101 الغربي',msg1='ﻲﺑﺮﻐﻟﺍ 101 ﺔﻨﻳﺪﻣ ﺀﺎﻨﻴﻣ',msg2='ﻥﻵﺍ ﺮﻳﺪﺼﺘﻟﺍ ﻊﻗﻮﻣ',msg3='ﺮﻳﺪﺼﺘﻟﺍ ﻒﻗﻭ',DrawTextY=0},

	[3] = {status=false,label='مطار الملك عبدالعزيز الدولي',msg1='ﻲﻟﻭﺪﻟﺍ ﺰﻳﺰﻌﻟﺍﺪﺒﻋ ﻚﻠﻤﻟﺍ رﺎﻄﻣ',msg2='ﻥﻵﺍ ﺮﻳﺪﺼﺘﻟﺍ ﻊﻗﻮﻣ',msg3='ﺮﻳﺪﺼﺘﻟﺍ ﻒﻗﻭ',DrawTextY=0},

	[4] = {status=false,label='القاعدة العسكرية',msg1='ﺔﻳﺮﻜﺴﻌﻟﺍ ﺓﺪﻋﺎﻘﻟﺍ',msg2='ﻥﻵﺍ ﺮﻳﺪﺼﺘﻟﺍ ﻊﻗﻮﻣ',msg3='ﺮﻳﺪﺼﺘﻟﺍ ﻒﻗﻭ',DrawTextY=0},

	[11] = {status=false,label='ميناء مدينة 101 توسعة 1',msg1='1 ﺔﻌﺳﻮﺗ 101 ﺔﻨﻳﺪﻣ ﺀﺎﻨﻴﻣ',msg2='ﻥﻵﺍ ﺮﻳﺪﺼﺘﻟﺍ ﻊﻗﻮﻣ',msg3='ﺮﻳﺪﺼﺘﻟﺍ ﻒﻗﻭ',DrawTextY=0},

	[12] = {status=false,label='ميناء مدينة 101 توسعة 2',msg1='2 ﺔﻌﺳﻮﺗ 101 ﺔﻨﻳﺪﻣ ﺀﺎﻨﻴﻣ',msg2='ﻥﻵﺍ ﺮﻳﺪﺼﺘﻟﺍ ﻊﻗﻮﻣ',msg3='ﺮﻳﺪﺼﺘﻟﺍ ﻒﻗﻭ',DrawTextY=0},

	[13] = {status=false,label='ميناء مدينة 101 توسعة 3',msg1='3 ﺔﻌﺳﻮﺗ 101 ﺔﻨﻳﺪﻣ ﺀﺎﻨﻴﻣ',msg2='ﻥﻵﺍ ﺮﻳﺪﺼﺘﻟﺍ ﻊﻗﻮﻣ',msg3='ﺮﻳﺪﺼﺘﻟﺍ ﻒﻗﻭ',DrawTextY=0},

	[14] = {status=false,label='ميناء مدينة 101 توسعة 4',msg1='4 ﺔﻌﺳﻮﺗ 101 ﺔﻨﻳﺪﻣ ﺀﺎﻨﻴﻣ',msg2='ﻥﻵﺍ ﺮﻳﺪﺼﺘﻟﺍ ﻊﻗﻮﻣ',msg3='ﺮﻳﺪﺼﺘﻟﺍ ﻒﻗﻭ',DrawTextY=0},

}

local offset = {x = 0.174, y = 0.955}

-- Text RGB Color --
-- Default: 64, 64, 64 (gray)
local rgb = {r = 100, g = 100, b = 100}

-- Text transparency --
-- Default: 255
local alpha = 255

-- Text scale
-- Default: 0.4
-- NOTE: Number needs to be a float (so instead of 1 do 1.0)
local scale = 0.31

-- Text Font --
-- 0 - 5 possible
-- Default: 1
--1 ok italic
--4 ok normal
local font = 4

-- Rainbow Text --
-- false: Turn off
-- true: Activate rainbow text (overrides color)
local bringontherainbows = true


-- CODE --

-- By ash
function RGBRainbow(frequency)
    local result = {}
    local curtime = GetGameTimer() / 1000

    result.r = math.floor(math.sin(curtime * frequency + 0) * 127 + 128)
    result.g = math.floor(math.sin(curtime * frequency + 2) * 127 + 128)
    result.b = math.floor(math.sin(curtime * frequency + 4) * 127 + 128)

    return result
end

function getPromotions()
	data = {}
	for k,v in pairs(promotion) do
		table.insert(data, {name = k, status = v.status, label = v.label})
	end
	return data
end

function getPorts()
	data = {}
	for k,v in pairs(portsControl) do
		table.insert(data, {name = k, status = v.status, label = v.label})
	end
	return data
end

RegisterNetEvent('esx_misc:update_abo_7mid')
AddEventHandler('esx_misc:update_abo_7mid', function(player_set_what)
	playerset = player_set_what
	TriggerServerEvent('esx_status_server:player_counter', playerset)
end)

RegisterNetEvent('esx_misc:updatePromotionStatus')
AddEventHandler('esx_misc:updatePromotionStatus', function(job, data)
	if job ~= 'jobs' then
		if job == "NoCrimetimeToAll" and data then
			TriggerServerEvent('esx_misc:setNoCrimeTo')
		elseif job == "NoCrimeTime" and data then
			TriggerServerEvent('esx_misc:setNoCrimeTo2')
		end
		promotion[job].status = data	
	else
		for k,v in pairs(data) do
			promotion[k].status = v
		end
	end
	watermarkResetDrawTextY()
end)

RegisterNetEvent('esx_misc:updatePromotionTimer')
AddEventHandler('esx_misc:updatePromotionTimer', function(_Promotion, timerStatus, time)
    P = _Promotion
    if timerStatus then
		promotion[P].timer = true
		promotion[P].time = time
	else
		promotion[P].timer = false
		promotion[P].time = 0
	end
end)

RegisterNetEvent('esx_misc:set_original_player')
AddEventHandler('esx_misc:set_original_player', function(counter_original_player)
	playerset = counter_original_player
end)

RegisterNetEvent('esx_misc:set_new_player')
AddEventHandler('esx_misc:set_new_player', function(type_what, too_match_s)
	if type_what == "new" then
		if playerset <= 0 then
			playerset = 1
			TriggerServerEvent('esx_status_server:player_counter', playerset)
		elseif playerset >= 1 then
			playerset = playerset + 1
			TriggerServerEvent('esx_status_server:player_counter', playerset)
		end
	elseif type_what == "too_match" then
		if playerset <= 0 then
			playerset = too_match_s
			TriggerServerEvent('esx_status_server:player_counter', playerset)
		elseif playerset >= 1 then
			playerset = playerset + too_match_s
			TriggerServerEvent('esx_status_server:player_counter', playerset)
		end
	elseif type_what == "leave" then
		if playerset <= 0 then
			playerset = 0
			TriggerServerEvent('esx_status_server:player_counter', playerset)
		elseif playerset >= 1 then
			playerset = playerset - 1
			TriggerServerEvent('esx_status_server:player_counter', playerset)
		end
	elseif type_what == "after_join" then
		if playerset <= 0 then
			playerset = too_match_s
			TriggerServerEvent('esx_status_server:player_counter', playerset)
		elseif playerset >= 1 then
			playerset = playerset + too_match_s
			TriggerServerEvent('esx_status_server:player_counter', playerset)
		end
	end
end)

RegisterNetEvent('esx_misc:UpdateListStolen')
AddEventHandler('esx_misc:UpdateListStolen', function(player_name)
    if statusselldrugs then
		promotion["TimerSellDrugs"].started = true
		promotion["TimerSellDrugs"].time = tonumber(timeselldrugs)
		TimerSellDrugsStarted()
	else
		promotion["TimerSellDrugs"].started = false
	end
end)

RegisterNetEvent('esx_misc:UpdateTimerCrime')
AddEventHandler('esx_misc:UpdateTimerCrime', function(statusselldrugs, timeselldrugs)
    if statusselldrugs then
		promotion["TimerSellDrugs"].started = true
		promotion["TimerSellDrugs"].time = tonumber(timeselldrugs)
		TimerSellDrugsStarted()
	else
		promotion["TimerSellDrugs"].started = false
	end
end)

function TimerSellDrugsStarted()
	if promotion["TimerSellDrugs"].time <= 0 then
       	if promotion["TimerSellDrugs"].started then
			TriggerServerEvent('esx_threb:wesam', "end", GetPlayerServerId(PlayerId()))
			TriggerServerEvent('esx_threb:wesam', "next", GetPlayerServerId(PlayerId()))
	   	end
	   	return
	end
    promotion["TimerSellDrugs"].time = promotion["TimerSellDrugs"].time-1
	ConvertTimetoDisplaySellDrugs(promotion["TimerSellDrugs"].time)
	Wait(1000)
	TimerSellDrugsStarted()
end

function TimerConvertWaterMark(time)

	local TimerS = time

	local remainingseconds = TimerS/ 60

	local seconds = string.format("%02.f", math.floor(TimerS) % 60 )

	local remainingminutes = remainingseconds / 60

	local minutes = string.format("%02.f", math.floor(remainingseconds) % 60 )

	local remaininghours = remainingminutes / 24

	local hours = string.format("%02.f", math.floor(remainingminutes) % 24 )

	local remainingdays = remaininghours / 365

	local days = string.format("%02.f", math.floor(remaininghours) % 365 )

	if days == "00" then

		if hours == "00" then

			if minutes == "00" then

				if seconds == "00" then

					--print()

				else

					return seconds

				end
			
			else

				return minutes .. ':' .. seconds

			end

		else

			return hours .. ':' .. minutes .. ':' .. seconds

		end

	else

		return days .. ':' .. hours .. ':' .. minutes .. ':' .. seconds

	end

end

function ConvertTimetoDisplay(time)
	local timer = time
	local remainingseconds = timer/ 60
	local seconds = string.format("%02.f", math.floor(timer) % 60 )
	local remainingminutes = remainingseconds / 60
	local minutes = string.format("%02.f", math.floor(remainingseconds) % 60)
	local remaininghours = remainingminutes / 24
	local hours = string.format("%02.f", math.floor(remainingminutes) % 24)
	local remainingdays = remaininghours / 365
	local days = string.format("%02.f", math.floor(remaininghours) % 365)
	promotion["wesam_do_store"].displayTime = days.. ':' .. hours .. ':' ..minutes.. ':' ..seconds
end

RegisterNetEvent('esx_misc:currentPortNum')
AddEventHandler('esx_misc:currentPortNum', function(port)
	for k,v in pairs(portsControl) do
		if k ~= port then
			v.status = false
		end
	end
	portsControl[port].status = true
	watermarkResetDrawTextY()
end)

Citizen.CreateThread(function()
	while true do
		CheckClock()
		Citizen.Wait(1000)
	end
end)

function CheckClock()
    Hours = GetClockHours()
    if Hours > 12 then
        Hours = Hours - 12
        Period = "PM"
    else
        Period = "AM"
    end
    if Hours < 10 then
		Hours = "0" .. Hours
	end
    Minutes = GetClockMinutes()
    if Minutes < 10 then
		Minutes = "0" .. Minutes
	end
    for k,v in pairs(dir)do
        heading = GetEntityHeading(PlayerPedId())
        if(math.abs(heading - k) < 45)then
            heading = v
            break
        end
    end
end

Citizen.CreateThread(function()
	while not switchstate do
		Citizen.Wait(500)
	end
	
	local blueColor = {r=61,g=174,b=255}
	local white = {r=255,g=255,b=255}
	
	watermarkResetDrawTextY()
	
	while true do
		Citizen.Wait(0)
		
		if bringontherainbows then
			rgb = RGBRainbow(1)
		end
		
		if not hidehud then

			SetTextColour(white.r, white.g, white.b, alpha)
			SetTextFont(fontId)
			SetTextScale(scale, scale)
			SetTextWrap(0.0, 1.0)
			SetTextCentre(false)
			SetTextDropshadow(2, 2, 0, 0, 0)
			SetTextEdge(1, 0, 0, 0, 205)
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString(playersOnline)
			DrawText(0.215, 0.920)
			
			SetTextColour(white.r, white.g, white.b, alpha)
			SetTextFont(fontId)
			SetTextScale(scale, scale)
			SetTextWrap(0.0, 1.0)
			SetTextCentre(false)
			SetTextDropshadow(2, 2, 0, 0, 0)
			SetTextEdge(1, 0, 0, 0, 205)
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString('<FONT FACE = "A9eelsh"> : ﻦﻴﺒﻋﻼﻟﺍ ﺩﺪﻋ')
			DrawText(idoffset, 0.920)
			
			--id
			--[[SetTextColour(rgb.r, rgb.g, rgb.b, alpha)
			SetTextFont(fontId)
			SetTextScale(scale, scale)
			SetTextWrap(0.0, 1.0)
			SetTextCentre(false)
			SetTextDropshadow(2, 2, 0, 0, 0)
			SetTextEdge(1, 0, 0, 0, 205)
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString('<FONT FACE = "A9eelsh">'..id..' :ﺮﻓﺮﻴﺴﻟﺎﺑ ﻚﻤﻗﺭ')
			DrawText(0.245, 0.930)--]]
			
			--[[SetTextFont(fontId)
			SetTextScale(scale, scale)
			SetTextWrap(0.0, 1.0)
			SetTextCentre(false)
			SetTextDropshadow(2, 2, 0, 0, 0)
			SetTextEdge(1, 0, 0, 0, 205)
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString('<FONT FACE = "A9eelsh">~w~ : ~y~ﺔﻬﺠﻟﺍ')
			DrawText(0.280 , 0.960)--]]
			
			for k,v in pairs(promotion) do
				RequestStreamedTextureDict(_barTextureDict)
				if v.status then
					if v.Color then
						SetTextColour(v.Color.r, v.Color.g, v.Color.b, alpha)
					else
						SetTextColour(blueColor.r, blueColor.g, blueColor.b, alpha)
					end
					SetTextFont(fontId)
					SetTextScale(scale, scale)
					SetTextWrap(0.0, 1.0)
					SetTextRightJustify(true)
					SetTextDropshadow(2, 2, 0, 0, 255)
					SetTextEdge(1, 0, 0, 0, 205)
					SetTextOutline()
					SetTextEntry("STRING")
					if v.timer then
						AddTextComponentString(('%s %s'):format(TimerConvertWaterMark(v.time), v.msg1))
					elseif v.doubleStore then
						AddTextComponentString(('%s %s'):format(v.displayTime, v.msg1))
					elseif v.started then
						AddTextComponentString(('%s %s'):format(v.displayTime, v.msg1))
					else
						AddTextComponentString(('%s'):format(v.msg1))
					end
					DrawText(0.90, v.DrawTextY)
					DrawSprite(_barTextureDict, _barTexture, 0.99, v.DrawTextY+0.009, wRect, hRect, 0.0, 255, 255, 255, 160)
					if v.Sprite then
						RequestStreamedTextureDict(v.dict)
						DrawSprite(v.dict,v.Spritename,0.85,v.DrawTextY+0.009,h,w,0.0,255, 255, 255,255 )
					end
				end
			end
			
			for k,v in pairs(portsControl) do
				if v.status then
					SetTextColour(white.r, white.g, white.b, alpha)
					SetTextFont(fontId)
					SetTextScale(scale, scale)
					SetTextWrap(0.0, 1.0)
					SetTextCentre(false)
					SetTextDropshadow(2, 2, 0, 0, 255)
					SetTextEdge(1, 0, 0, 0, 205)
					SetTextOutline()
					SetTextEntry("STRING")
					AddTextComponentString(v.msg1..' :ﺮﻳﺪﺼﺘﻟﺍ ﻊﻗﻮﻣ')
					DrawText(0.180, 0.950)
				end
			end
		end
	end
end)


Citizen.CreateThread(function()
	local sleep = 0
	
	if Config.OnesyncInfinty then

		sleep = 1000

	else

		sleep = 30000

	end
	
	while true do

		Citizen.Wait(30000)

		TriggerServerEvent("esx_misc:onlineplayersserver")
		
		if playersOnline >= 100 then
			idoffset = 0.230
		elseif playersOnline >= 10 then
			idoffset = 0.225
		else
			idoffset = 0.220
		end

	end

end)

RegisterNetEvent('esx_misc:onlineplayers')
AddEventHandler('esx_misc:onlineplayers', function(count)
	for _, playerId in ipairs(count) do
		if playerset == 0 then
			playersOnline = #count
		else
			playersOnline = #count
			playersOnline = playersOnline + playerset
		end
	end
end)

RegisterNetEvent('esx_misc:watermark_promotion')
AddEventHandler('esx_misc:watermark_promotion', function(promotionName, promotionStatus, mode)
	promotion[promotionName].status = promotionStatus
	watermarkResetDrawTextY()
		
	local msg1 = "<FONT FACE='A9eelsh'>~w~"..promotion[promotionName].msg1 --big
	local msg2
	if promotionName == 'threb' then
		if promotionStatus then
			msg1 = "<FONT FACE='A9eelsh'>~w~"..promotion[promotionName].msg1 --big
			msg2 = "<FONT FACE='A9eelsh'>~g~"..promotion[promotionName].msg2 --small
			PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
		else
			msg1 = "<FONT FACE='A9eelsh'>~w~"..promotion[promotionName].msg1 --big
			msg2 = "<FONT FACE='A9eelsh'>~g~"..promotion[promotionName].msg3 --small
			PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
		end
	end
	if promotionName == 'deleteallcars' then
		if promotionStatus then
			msg1 = "<FONT FACE='A9eelsh'>~w~"..promotion[promotionName].msg1 --big
			msg2 = "<FONT FACE='A9eelsh'>~g~"..promotion[promotionName].msg2 --small
			PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
		else
			msg1 = "<FONT FACE='A9eelsh'>~w~"..promotion[promotionName].msg1 --big
			msg2 = "<FONT FACE='A9eelsh'>~g~"..promotion[promotionName].msg3 --small
			PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
		end
	else
		if mode ~= 2 then
			if promotionStatus then --promotion start
				msg2 = "<FONT FACE='A9eelsh'>~g~"..promotion[promotionName].msg2 --small
				PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
			else --promotion finish
				msg2 = "<FONT FACE='A9eelsh'>~r~"..promotion[promotionName].msg3 --small
				PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
			end
		else
			if promotionStatus then --promotion start
				if promotionName == "doubleXP" then
					msg1 = "<FONT FACE='A9eelsh'>~w~"..promotion[promotionName].msg2 --big
					msg2 = "<FONT FACE='A9eelsh'>~g~"..promotion[promotionName].msg1 --small
					PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
				else
					msg1 = "<FONT FACE='A9eelsh'>~w~"..promotion[promotionName].msg2 --big
					msg2 = "<FONT FACE='A9eelsh'>~r~"..promotion[promotionName].msg1 --small
					PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
				end
			else --promotion finish
				if promotionName == "doubleXP" then
					msg1 = "<FONT FACE='A9eelsh'>~w~"..promotion[promotionName].msg3 --big
					msg2 = "<FONT FACE='A9eelsh'>~r~"..promotion[promotionName].msg1 --small
					PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
				else
					msg1 = "<FONT FACE='A9eelsh'>~w~"..promotion[promotionName].msg3 --big
					msg2 = "<FONT FACE='A9eelsh'>~g~"..promotion[promotionName].msg1 --small
					PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
				end
			end
		end
	end
	local temps = 0
	
	scaleform = InitializeScaleform("mp_big_message_freemode",msg1,msg2)
	
	while temps<200 do
		Citizen.Wait(0)
		DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		temps = temps + 1
	end
end)


RegisterNetEvent('esx_misc:watermark_port')
AddEventHandler('esx_misc:watermark_port', function(portNum, data)
	
	watermarkResetDrawTextY()
		
	local msg1 = "<FONT FACE='A9eelsh'>~w~"..portsControl[portNum].msg1 --big
	local msg2
	
	if portsControl[portNum].status then --portsControl start
		msg2 = "<FONT FACE='A9eelsh'>~g~"..portsControl[portNum].msg2 --small
		PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
	else --portsControl finish
		msg2 = "<FONT FACE='A9eelsh'>~r~"..portsControl[portNum].msg3 --small
		PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
	end
	
	local temps = 0
	
	scaleform = InitializeScaleform("mp_big_message_freemode",msg1,msg2)
	
	while temps<200 do
		Citizen.Wait(0)
		DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		temps = temps + 1
	end
end)

-- draw scaleform multi use
function InitializeScaleform(scaleform,msg,msg2)
	local scaleform = RequestScaleformMovie(scaleform)

	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end
	
	PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
	PushScaleformMovieFunctionParameterString(msg)
	PushScaleformMovieFunctionParameterString(msg2)
	PopScaleformMovieFunctionVoid()
	
	return scaleform
end

function watermarkResetDrawTextY2()
	local DrawTextYbase = 0.870
	local count = 1
	local k = 0
	local y
	for k,v in pairs(portsControl) do
		if v.status then
			if count == 1 then
				v.DrawTextY = DrawTextYbase
				y = DrawTextYbase
			else
				y = y - 0.025
				v.DrawTextY = y
			end
			count = count + 1
		end
	end	
	for k,v in pairs(promotion) do
		if v.status then
			if count == 1 then
				v.DrawTextY = DrawTextYbase
				y = DrawTextYbase
			else
				y = y - 0.025
				v.DrawTextY = y
			end
			count = count + 1
		end
	end
end

function watermarkResetDrawTextY()
	local DrawTextYbase = 0.940
	local count = 1
	local k = 0
	local y
	for k,v in pairs(portsControl) do
		if v.status then
			if count == 1 then
				v.DrawTextY = DrawTextYbase
				y = DrawTextYbase
			else
				y = y - 0.025
				v.DrawTextY = y
			end
			count = count + 1
		end
	end	
	for k,v in pairs(promotion) do
		if v.status then
			if count == 1 then
				v.DrawTextY = DrawTextYbase
				y = DrawTextYbase
			else
				y = y - 0.025
				v.DrawTextY = y
			end
			count = count + 1
		end
	end
end