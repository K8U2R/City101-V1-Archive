
RegisterNetEvent('esx_misc:RewardRemainingtime') -- Reward 
AddEventHandler('esx_misc:RewardRemainingtime', function(amount)
   -----------------------
   ESX.TriggerServerCallback('esx_misc:GetRewardRemainingtime', function(Time)
      ESX.ShowNotification('الوقت المتبقي للمكافأة <font color=orange>'..Time..'</font> دقيقة')
   end)
   -----------------------
end)

RegisterNetEvent('esx_misc:receiveGift') -- Reward 
AddEventHandler('esx_misc:receiveGift', function(amount)
   TriggerEvent("pNotify:SendNotification", {
		text = "<font size=5 color=orange><center><b>أستلام المكافأة التلقائية"..
		"<font size=5 color=white><center><b>المبلغ: <font color=green>$"..amount.."</font>"..
		"<font size=5 color=white><center><b>شكرا لتواجدك لمدة ساعة بالسيرفر",
		type = 'alert',
		queue = left,
		timeout = 10000,
		killer = false,
		theme = "gta",
		layout = "CenterLeft",
		sounds = {
		sources = {"Reward.wav"},
		volume = 0.2,
		conditions = {"docVisible"}
		},
	})
end)