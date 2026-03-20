local showingScalform = false

RegisterNetEvent('esx_misc:tebexStoreScaleform')
AddEventHandler('esx_misc:tebexStoreScaleform', function(productName, productStatus)
	startShowingScaleform(productName, productStatus)
end)

function startShowingScaleform(productName, productStatus)
	Citizen.CreateThread(function()	
		while showingScalform do
			Citizen.Wait(3000)
		end
		
		showingScalform = true
		local msg1 = "<FONT FACE='A9eelsh'>"..Config.product[productName].color1..Config.product[productName].msg1 --big
		local msg2
		
		if productStatus == 'give' then --start
			if isProductNameSponser(productName) then
				if productName == "dblxp6hours" then
					msg2 = "<FONT FACE='A9eelsh'>"..Config.product[productName].color2 .. ' '..Config.product[productName].msg2 --big
				else
					msg2 = "<FONT FACE='A9eelsh'>"..Config.product[productName].color2..'$'..ESX.Math.GroupDigits(Config.product[productName].rewardMoney)..' '..Config.product[productName].msg2 --big
				end
			else
				msg2 = "<FONT FACE='A9eelsh'>"..Config.product[productName].color2..Config.product[productName].msg2 --big
			end
			PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true)
		else --expire finish
			msg2 = "<FONT FACE='A9eelsh'>"..Config.product[productName].color3..Config.product[productName].msg3 --small
			PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true)
		end
		
		local temps = 0
		
		scaleform = tebexStore_InitializeScaleform("mp_big_message_freemode",msg1,msg2)
		
		while temps<Config.scalformtime do
			Citizen.Wait(0)
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
			temps = temps + 1
		end
		showingScalform = false
	end)
end


-- draw scaleform multi use
function tebexStore_InitializeScaleform(scaleform,msg,msg2)
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

function isProductNameSponser(productName)
	if Config.product[productName] then
		if Config.product[productName].ra3i then
			return true
		else
			return false
		end
	else
		return false
	end
end