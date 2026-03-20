Config = {

-- IMPORTANT! To configure report text navigate to /html/script.js and find the text you want to replace

EvidenceReportInformationBullet = "firstname, lastname, job, sex", -- The information displayd from users table in mysql in the evidence report (ONLY CHANGE IF YOU KNOW WHAT ARE YOU DOING)
EvidenceReportInformationFingerprint = "firstname, lastname, job, sex", -- The information displayd from users table in mysql in the evidence report (ONLY CHANGE IF YOU KNOW WHAT ARE YOU DOING)
EvidenceReportInformationBlood = "firstname, lastname, job, sex", -- The information displayd from users table in mysql in the evidence report (ONLY CHANGE IF YOU KNOW WHAT ARE YOU DOING)

ShowBloodSplatsOnGround = true, -- Show blood on the ground when player is shot
PlayClipboardAnimation = true, -- Play clipboard animation when reading report

JobRequired = 'police', -- The job needed to use evidence system
JobGradeRequired = 0, -- The MINIMUM job grade required to use evidence system (If you use 0 all job grades can use the system)

CloseReportKey = 'BACKSPACE', -- The key used to close the report
PickupEvidenceKey = 'E', -- The key used to pick up evidence

EvidenceAlanysisLocation = vector3(485.1869, -986.2665, 30.6896), -- The place where the evidence will be analyzed and report generated
TimeToAnalyze = 10000, -- Time in miliseconds to analyze the given evidence
TimeToFindFingerprints = 3000, -- Time in miliseconds to find fingerprints in a car

--UPDATE V2
RainRemovesEvidence = true, -- Removes evidence when it starts raining!
TimeBeforeCrimsCanDestory = 300, -- Seconds before Criminals can destroy evidence (300 is the time when evidence coolsdown and shows up as WARM)
EvidenceStorageLocation = vector3(471.7699890136719, -1006.9000244140624, 34.22000122070312), -- The place where all evidence are being archived! You can view old evidence or delete it
--

Text = {

	--UPDATE V2
	['not_in_vehicle'] = 'لاستخدام هذا يجب ان تكون بسيارتك',
	['remove_evidence'] = "<FONT FACE='A9eelsh'>E ﻂﻐﺿﺍ ﻞﻴﻟﺪﻟﺍ ﺔﻟﺍﺯﻻ",
	['cooldown_before_pickup'] = "<FONT FACE='A9eelsh'>ﺓﺮﻴﻣﺪﺗ ﻊﻴﻄﺘﺴﺗﻻ ﻦﺧﺎﺳ/ﺝﺯﺎﻃ ﻝﺍﺯﺎﻣ ﻞﻴﻟﺪﻟﺍ",
	['evidence_removed'] = "<FONT FACE='A9eelsh'>! ﺮﻣﺪﺗ ﻞﻴﻟﺪﻟﺍ",
	['open_evidence_archive'] = "<FONT FACE='A9eelsh'>ﻒﻴﺷﺭﻻﺍ ﻲﻓ ﺚﺤﺒﻠﻟ e ﻂﻐﺿﺍ",
	['evidence_archive'] = 'ارشيف الادلة',
	['view'] = 'اظهار',
	['delete'] = 'حذف | ممنوع للقادة فقط',
	['report_list'] = 'قضية #',
	['evidence_deleted_from_archive'] = "<FONT FACE='A9eelsh'>ﻒﻴﺷﺭﻻﺍ ﻦﻣ ﻞﻴﻟﺪﻟﺍ ﻑﺬﺣ ﻢﺗ",
	--

	['evidence_colleted'] = "<FONT FACE='A9eelsh'> #{number}ﻢﻗﺭ ﻞﻴﻟﺩ ﺕﺬﺧﺍ",
	['no_more_space'] = 'Not enough space for evidence 3/3!',
	['analyze_evidence'] = "<FONT FACE='A9eelsh'>ﻞﻴﻟﺪﻟﺍ ﺔﻌﺟﺍﺮﻤﻟ [~b~E~w~] ﻂﻐﺿﺍ",
	['evidence_being_analyzed'] = "<FONT FACE='A9eelsh'>ﺭﺎﻈﺘﻧﻻﺍ ﺀﺎﺟﺮﺑ ﻲﻋﺮﺸﻟﺍ ﺐﻄﻟﺍ ﺭﺍﺮﻗ ﺮﻴﻀﺤﺗ ﻱﺭﺎﺟ",
	['evidence_being_analyzed_hologram'] = "<FONT FACE='A9eelsh'>ﺭﺎﻈﺘﻧﻻﺍ ﺀﺎﺟﺮﺑ ﻲﻋﺮﺸﻟﺍ ﺐﻄﻟﺍ ﺭﺍﺮﻗ ﺮﻴﻀﺤﺗ ﻱﺭﺎﺟ",
	['read_evidence_report'] = "<FONT FACE='A9eelsh'>[~b~E~w~] ﻂﻐﺿﺍ ﺔﻟﺩﻻﺍ ﺮﻳﺮﻘﺗ ةءاﺮﻘﻟ",
	['analyzing_car'] = 'The car is being analyzed! Please wait',
	['pick_up_evidence_text'] = "<FONT FACE='A9eelsh'>ﻞﻴﻟﺪﻟﺍ ﺬﺧﻻ [~r~E~w~] ﻂﻐﺿﺍ",
	['no_fingerprints_found'] = "<FONT FACE='A9eelsh'>ﻊﻗﻮﻤﻟﺎﻓ ﺕﺎﻤﺼﺑ ﺪﺟﻮﻳﻻ",
	['no_evidence_to_analyze'] = "<FONT FACE='A9eelsh'>ﺔﺘﻌﺟﺍﺮﻤﻟ ﻞﻴﻟﺩ ﺪﺟﻮﻳﻻ",
	['shell_hologram'] = "<FONT FACE='A9eelsh'>~b~ {guncategory} ~w~ ﺔﻳﺭﺎﻧ ﺔﻘﻠﻃ",
	['blood_hologram'] = "<FONT FACE='A9eelsh'>~r~ﻡﺩ ﺔﻌﻘﺑ",

	['blood_after_0_minutes'] = "<FONT FACE='A9eelsh'>ﺝﺯﺎﻃ ~r~ :ﺔﻟﺎﺤﻟﺍ",
	['blood_after_5_minutes'] = "<FONT FACE='A9eelsh'>ﻂﺳﻮﺘﻣ ~y~ :ﺔﻟﺎﺤﻟﺍ",
	['blood_after_10_minutes'] = "<FONT FACE='A9eelsh'>ﻢﻳﺪﻗ ~b~ :ﺔﻟﺎﺤﻟﺍ",

	['shell_after_0_minutes'] = "<FONT FACE='A9eelsh'>ﻦﺧﺎﺳ ~r~ :ﺔﻟﺎﺤﻟﺍ",
	['shell_after_5_minutes'] = "<FONT FACE='A9eelsh'>ﻱﺩﺎﻋ ~y~ :ﺔﻟﺎﺤﻟﺍ",
	['shell_after_10_minutes'] = "<FONT FACE='A9eelsh'>ﺩﺭﺎﺑ ~b~ :ﺔﻟﺎﺤﻟﺍ",


	['submachine_category'] = 'Submachine',
	['pistol_category'] = 'Pistol',
	['shotgun_category'] = 'Shotgun',
	['assault_category'] = 'Assault Rifle',
	['lightmachine_category'] = 'Light Machine Gun',
	['sniper_category'] = 'Sniper',
	['heavy_category'] = 'Heavy Weapon'


}
	

}

-- Only change if you know what are you doing!
function SendTextMessage(msg)

		SetNotificationTextEntry('STRING')
		AddTextComponentString(msg)
		DrawNotification(0,1)

		--EXAMPLE USED IN VIDEO
		--exports['mythic_notify']:SendAlert('inform', msg)

end
