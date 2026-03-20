ESX = nil

local CopsConnected = 0
local PlayersHarvestingCoke, PlayersTransformingCoke, PlayersSellingCoke, PlayersHarvestingMeth, PlayersTransformingMeth, PlayersSellingMeth, PlayersHarvestingWeed, PlayersTransformingWeed, PlayersSellingWeed, PlayersHarvestingOpium, PlayersTransformingOpium, PlayersSellingOpium = {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

function CountCops()
	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i = 1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'agent' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

CountCops()

function DiscordLog (name, title, message, color)
	local DiscordWebHook = "https://discord.com/api/weddoks/1027342911504924672/L-2unvD0_ZeKgkY6pnRQml_xPe8JbJcWodYEtpU1ifawUWcU36-9yq1mcfb1qbK49xj4"
	
	local embeds = {
		{
			["title"]=title,
			["type"]="rich",
            ["description"] = message,
			["color"] =color,
			["footer"]=  { ["text"]= "سجل بيع الممنوعات", 
            ["icon_url"] = "https://cdn.discordapp.com/attachments/931300530393874482/931302251513909348/7fd04efde345f231.png"},
		}
	}
	
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = "",
        fivem = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
		elseif string.find(id, "fivem") then
            identifiers.fivem = id
        end
    end

    return identifiers
end

RegisterServerEvent('esx_drugs:threb')
AddEventHandler('esx_drugs:threb', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("esx_misc:updatePromotionStatus", source, 'threb', Config.threb)
end)

-- Weed
local function HarvestWeed(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if CopsConnected < Config.RequiredCopsWeed then
		xPlayer.showNotification(_U('act_imp_police', CopsConnected, Config.RequiredCopsWeed))
		return
	end

	SetTimeout(Config.TimeToFarmWeed, function()
		if PlayersHarvestingWeed[source] == true then
			local weed = xPlayer.getInventoryItem('weed')

			if not xPlayer.canCarryItem('weed', weed.weight) then
				xPlayer.showNotification(_U('inv_full_weed'))
			else
				xPlayer.addInventoryItem('weed', 1)
				HarvestWeed(source)
			end

		end
	end)
end

local function TransformWeed(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if CopsConnected < Config.RequiredCopsWeed then
		xPlayer.showNotification(_U('act_imp_police', CopsConnected, Config.RequiredCopsWeed))
		return
	end

	SetTimeout(Config.TimeToProcessWeed, function()
		if PlayersTransformingWeed[source] == true then
			local weedQuantity = xPlayer.getInventoryItem('weed').count
			local poochQuantity = xPlayer.getInventoryItem('weed_pooch').count

			if poochQuantity > 5 then
				xPlayer.showNotification(_U('too_many_pouches'))
			elseif weedQuantity < 5 then
				xPlayer.showNotification(_U('not_enough_weed'))
			else
				xPlayer.removeInventoryItem('weed', 5)
				xPlayer.addInventoryItem('weed_pooch', 1)
				
				TransformWeed(source)
			end
		end
	end)
end


RegisterServerEvent("esx_drugs:true") -- ضعف الأجر
AddEventHandler("esx_drugs:true",function()
	Config.threb = true 
	print(Config.threb)
end,false)
RegisterServerEvent("esx_drugs:false") -- ضعف الأجر
AddEventHandler("esx_drugs:false", function()
	Config.threb = false 
	print(Config.threb)
end,false)

local function SellWeed(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
  	local Money = 0
	
	if CopsConnected < Config.RequiredCopsWeed then
		xPlayer.showNotification(_U('act_imp_police', CopsConnected, Config.RequiredCopsWeed))
		return
	end

	SetTimeout(Config.TimeToSellWeed, function()
		if PlayersSellingWeed[source] == true then
			local poochQuantity = xPlayer.getInventoryItem('weed_pooch').count
			if poochQuantity == 0 then
				xPlayer.showNotification(_U('no_pouches_weed_sale'))
			else
				xPlayer.removeInventoryItem('weed_pooch', 1)
				if CopsConnected == 0 then
					Money = 1750
				elseif CopsConnected == 1 then
					Money = 1800
				elseif CopsConnected == 2 then
					Money = 1950
				elseif CopsConnected == 3 then
					Money = 2000
				elseif CopsConnected >= 4 then
					Money = 2050
				elseif CopsConnected >= 5 then
					Money = 2100
                elseif CopsConnected >= 6 then
					Money = 2150
                elseif CopsConnected >= 7 then
					Money = 2200
                elseif CopsConnected >= 8 then
					Money = 2250
                elseif CopsConnected >= 9 then
					Money = 2300
                elseif CopsConnected >= 10 then
					Money = 2350		
				end 
				if Config.threb then 
					xPlayer.addAccountMoney('black_money', Money * 2)
				else
					xPlayer.addAccountMoney('black_money', Money)
				end
				xPlayer.showNotification(_U('sold_one_weed'))
				
				local ids = ExtractIdentifiers(source)
				_discordID ="<@" ..ids.discord:gsub("discord:", "")..">"
				_identifierID ="**identifier:  ** " ..xPlayer.identifier..""
				DiscordLog ('بيع الممنوعات', 'بيع شدة حشيش', ''..xPlayer.getName()..'\n'.._discordID..'\n'.._identifierID..'\nكسب أموال قذرة: $'..Money)
				TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', source, 'add', Config.weedgivexp, ' تهريب ممنوعات ')
				SellWeed(source)
			end
		end
	end)
end

-- Weed

-- Opium
local function HarvestOpium(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
		
	if CopsConnected < Config.RequiredCopsOpium then
		xPlayer.showNotification(_U('act_imp_police', CopsConnected, Config.RequiredCopsOpium))
		return
	end

	SetTimeout(Config.TimeToFarmOpium, function()
		if PlayersHarvestingOpium[source] == true then
			local opium = xPlayer.getInventoryItem('opium')

			if not xPlayer.canCarryItem('opium', opium.weight) then
				xPlayer.showNotification(_U('inv_full_opium'))
			else
				xPlayer.addInventoryItem('opium', 1)
				HarvestOpium(source)
			end
		end
	end)
end

local function TransformOpium(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
		
	if CopsConnected < Config.RequiredCopsOpium then
		xPlayer.showNotification(_U('act_imp_police', CopsConnected, Config.RequiredCopsOpium))
		return
	end

	SetTimeout(Config.TimeToProcessOpium, function()
		if PlayersTransformingOpium[source] == true then
			local opiumQuantity = xPlayer.getInventoryItem('opium').count
			local poochQuantity = xPlayer.getInventoryItem('opium_pooch').count

			if poochQuantity > 5 then
				xPlayer.showNotification(_U('too_many_pouches'))
			elseif opiumQuantity < 5 then
				xPlayer.showNotification(_U('not_enough_opium'))
			else
				xPlayer.removeInventoryItem('opium', 5)
				xPlayer.addInventoryItem('opium_pooch', 1)
			
				TransformOpium(source)
			end
		end
	end)
end

local function SellOpium(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
		
	if CopsConnected < Config.RequiredCopsOpium then
		xPlayer.showNotification(_U('act_imp_police', CopsConnected, Config.RequiredCopsOpium))
		return
	end

	SetTimeout(Config.TimeToSellOpium, function()
		if PlayersSellingOpium[source] == true then
			local poochQuantity = xPlayer.getInventoryItem('opium_pooch').count
			if poochQuantity == 0 then
				xPlayer.showNotification(_U('no_pouches_opium_sale'))
			else
				xPlayer.removeInventoryItem('opium_pooch', 1)
						
				if CopsConnected == 0 then
					Money = 2000
				elseif CopsConnected == 1 then
					Money = 2100
				elseif CopsConnected == 2 then
					Money = 2200
				elseif CopsConnected == 3 then
					Money = 2300
				elseif CopsConnected == 4 then
					Money = 2400
				elseif CopsConnected >= 5 then
					Money = 2500
                elseif CopsConnected >= 6 then
					Money = 2600
                elseif CopsConnected >= 7 then
					Money = 2700
                elseif CopsConnected >= 8 then
					Money = 2800
                elseif CopsConnected >= 9 then
					Money = 2900
                elseif CopsConnected >= 10 then
					Money = 3200		
				end
				if Config.threb then 
					xPlayer.addAccountMoney('black_money', Money * 2)
				else
					xPlayer.addAccountMoney('black_money', Money)
				end
				xPlayer.showNotification(_U('sold_one_opium'))	
				
				local ids = ExtractIdentifiers(source)
				_discordID ="<@" ..ids.discord:gsub("discord:", "")..">"
				_identifierID ="**identifier:  ** " ..xPlayer.identifier..""
				DiscordLog ('بيع الممنوعات', 'بيع شدة أفيون', ''..xPlayer.getName()..'\n'.._discordID..'\n'.._identifierID..'\nكسب أموال قذرة: $'..Money)
				TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', source, 'add', Config.Opiumgivexp, ' تهريب ممنوعات ')

				SellOpium(source)
			end
		end
	end)
end

-- Opium

-- Coke
local function HarvestCoke(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
		
	if CopsConnected < Config.RequiredCopsCoke then
		xPlayer.showNotification(_U('act_imp_police', CopsConnected, Config.RequiredCopsCoke))
		return
	end

	SetTimeout(Config.TimeToFarmCoke, function()
		if PlayersHarvestingCoke[source] == true then
			local coke = xPlayer.getInventoryItem('coke')

			if not xPlayer.canCarryItem('coke', coke.weight) then
				xPlayer.showNotification(_U('inv_full_coke'))
			else
				xPlayer.addInventoryItem('coke', 1)
				HarvestCoke(source)
			end
		end
	end)
end

local function TransformCoke(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
		
	if CopsConnected < Config.RequiredCopsCoke then
		xPlayer.showNotification(_U('act_imp_police', CopsConnected, Config.RequiredCopsCoke))
		return
	end

	SetTimeout(Config.TimeToProcessCoke, function()
		if PlayersTransformingCoke[source] == true then
			local cokeQuantity = xPlayer.getInventoryItem('coke').count
			local poochQuantity = xPlayer.getInventoryItem('coke_pooch').count

			if poochQuantity > 5 then
				xPlayer.showNotification(_U('too_many_pouches'))
			elseif cokeQuantity < 5 then
				xPlayer.showNotification(_U('not_enough_coke'))
			else
				xPlayer.removeInventoryItem('coke', 5)
				xPlayer.addInventoryItem('coke_pooch', 1)
			
				TransformCoke(source)
			end
		end
	end)
end

local function SellCoke(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
		
	if CopsConnected < Config.RequiredCopsCoke then
		xPlayer.showNotification(_U('act_imp_police', CopsConnected, Config.RequiredCopsCoke))
		return
	end

	SetTimeout(Config.TimeToSellCoke, function()
		if PlayersSellingCoke[source] == true then
			local poochQuantity = xPlayer.getInventoryItem('coke_pooch').count
			if poochQuantity == 0 then
				xPlayer.showNotification(_U('no_pouches_coke_sale'))
			else
				xPlayer.removeInventoryItem('coke_pooch', 1)
						
				if CopsConnected == 0 then
					Money = 1800
				elseif CopsConnected == 1 then
					Money = 1850
				elseif CopsConnected == 2 then
					Money = 1900
				elseif CopsConnected == 3 then
					Money = 1950
				elseif CopsConnected == 4 then
					Money = 2000
				elseif CopsConnected >= 5 then
					Money = 2050
                elseif CopsConnected >= 6 then
					Money = 2100
                elseif CopsConnected >= 7 then
					Money = 2150
                elseif CopsConnected >= 8 then
					Money = 2200
                elseif CopsConnected >= 9 then
					Money = 2250
                elseif CopsConnected >= 10 then
					Money = 2300
				end
				if Config.threb then 
					xPlayer.addAccountMoney('black_money', Money * 2)
				else
					xPlayer.addAccountMoney('black_money', Money)
				end
				xPlayer.showNotification(_U('sold_one_coke'))	
				
				local ids = ExtractIdentifiers(source)
				_discordID ="<@" ..ids.discord:gsub("discord:", "")..">"
				_identifierID ="**identifier:  ** " ..xPlayer.identifier..""
				DiscordLog ('بيع الممنوعات', 'بيع شدة كوكايين', ''..xPlayer.getName()..'\n'.._discordID..'\n'.._identifierID..'\nكسب أموال قذرة: $'..Money)
				TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', source, 'add', Config.Cokegivexp, ' تهريب ممنوعات ')
				SellCoke(source)
			end
		end
	end)
end

-- Coke

-- Meth
local function HarvestMeth(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
		
	if CopsConnected < Config.RequiredCopsMeth then
		xPlayer.showNotification(_U('act_imp_police', CopsConnected, Config.RequiredCopsMeth))
		return
	end
	
	SetTimeout(Config.TimeToFarmMeth, function()
		if PlayersHarvestingMeth[source] == true then
			local meth = xPlayer.getInventoryItem('meth')

			if not xPlayer.canCarryItem('meth', meth.weight) then
				xPlayer.showNotification(_U('inv_full_meth'))
			else
				xPlayer.addInventoryItem('meth', 1)
				HarvestMeth(source)
			end
		end
	end)
end

local function TransformMeth(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
		
	if CopsConnected < Config.RequiredCopsMeth then
		xPlayer.showNotification(_U('act_imp_police', CopsConnected, Config.RequiredCopsMeth))
		return
	end

	SetTimeout(Config.TimeToProcessMeth, function()
		if PlayersTransformingMeth[source] == true then
			local methQuantity = xPlayer.getInventoryItem('meth').count
			local poochQuantity = xPlayer.getInventoryItem('meth_pooch').count

			if poochQuantity > 5 then
				xPlayer.showNotification(_U('too_many_pouches'))
			elseif methQuantity < 5 then
				xPlayer.showNotification(_U('not_enough_meth'))
			else
				xPlayer.removeInventoryItem('meth', 5)
				xPlayer.addInventoryItem('meth_pooch', 1)
				
				TransformMeth(source)
			end
		end
	end)
end

local function SellMeth(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
		
	if CopsConnected < Config.RequiredCopsMeth then
		xPlayer.showNotification(_U('act_imp_police', CopsConnected, Config.RequiredCopsMeth))
		return
	end

	SetTimeout(Config.TimeToSellMeth, function()
		if PlayersSellingMeth[source] == true then
			local poochQuantity = xPlayer.getInventoryItem('meth_pooch').count
			if poochQuantity == 0 then
				xPlayer.showNotification(_U('no_pouches_meth_sale'))
			else
				xPlayer.removeInventoryItem('meth_pooch', 1)
					
				if CopsConnected == 0 then
					Money = 1500
				elseif CopsConnected == 1 then
					Money = 1550
				elseif CopsConnected == 2 then
					Money = 1600
				elseif CopsConnected == 3 then
					Money = 1650
				elseif CopsConnected == 4 then
					Money = 1700
				elseif CopsConnected == 5 then
					Money = 1750
				elseif CopsConnected >= 6 then
					Money = 1800
                elseif CopsConnected >= 7 then
					Money = 1850
                elseif CopsConnected >= 8 then
					Money = 1900
                elseif CopsConnected >= 9 then
					Money = 1950
                elseif CopsConnected >= 10 then
					Money = 2000	
				end
				if Config.threb then 
					xPlayer.addAccountMoney('black_money', Money * 2)
				else
					xPlayer.addAccountMoney('black_money', Money)
				end
				xPlayer.showNotification(_U('sold_one_meth'))	
				
				local ids = ExtractIdentifiers(source)
				_discordID ="<@" ..ids.discord:gsub("discord:", "")..">"
				_identifierID ="**identifier:  ** " ..xPlayer.identifier..""
				DiscordLog ('بيع الممنوعات', 'بيع شدة شبو', ''..xPlayer.getName()..'\n'.._discordID..'\n'.._identifierID..'\nكسب أموال قذرة: $'..Money)
				TriggerEvent('SystemXpLevel:updateCurrentPlayerXP', source, 'add', Config.Methgivexp, ' تهريب ممنوعات ')
				SellMeth(source)
			end
		end
	end)
end

RegisterServerEvent('esx_K6dr2H2ugs:Server') -- esx_drugs:Server
AddEventHandler('esx_K6dr2H2ugs:Server', function(Action, drug)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	--# start Harvest The drug
	if Action == 'startHarvest' then
    if drug == 'Weed' then
	PlayersHarvestingWeed[_source] = true
	HarvestWeed(_source)
	elseif drug == 'Opium' then
	PlayersHarvestingOpium[_source] = true
	HarvestOpium(_source)
	elseif drug == 'Coke' then
	PlayersHarvestingCoke[_source] = true
	HarvestCoke(_source)
	elseif drug == 'Meth' then
	PlayersHarvestingMeth[_source] = true
	HarvestMeth(_source)
	end
	xPlayer.showNotification(_U('pickup_in_prog'))
	--# start Trans From drug
	elseif Action == 'startTransFromDrug' then
	if drug == 'Weed' then
	PlayersTransformingWeed[_source] = true
	TransformWeed(_source)
	elseif drug == 'Opium' then
	PlayersTransformingOpium[_source] = true
	TransformOpium(_source)
	elseif drug == 'Coke' then
	PlayersTransformingCoke[_source] = true
	TransformCoke(_source)
	elseif drug == 'Meth' then
	PlayersTransformingMeth[_source] = true
	TransformMeth(_source)
	end
	xPlayer.showNotification(_U('packing_in_prog'))
	--# start Sell The drug
	elseif Action == 'startSell' then
	if drug == 'Weed' then
	PlayersSellingWeed[_source] = true
	SellWeed(_source)
	elseif drug == 'Opium' then
	PlayersSellingOpium[_source] = true
	SellOpium(_source)
	elseif drug == 'Coke' then
	PlayersSellingCoke[_source] = true
	SellCoke(_source)
	elseif drug == 'Meth' then
	PlayersSellingMeth[_source] = true
	SellMeth(_source)
	end
	xPlayer.showNotification(_U('sale_in_prog'))
	--# Stop All
	elseif Action == 'Stop' then
	PlayersHarvestingWeed[_source] = false
	PlayersHarvestingOpium[_source] = false
	PlayersHarvestingCoke[_source] = false
	PlayersHarvestingMeth[_source] = false
	
	PlayersTransformingWeed[_source] = false
	PlayersTransformingOpium[_source] = false
	PlayersTransformingCoke[_source] = false
	PlayersTransformingMeth[_source] = false
	
	PlayersSellingWeed[_source] = false
	PlayersSellingOpium[_source] = false
	PlayersSellingCoke[_source] = false
	PlayersSellingMeth[_source] = false
	end
end)

-- Meth
RegisterServerEvent('esx_K20drugs:GetUserInventory_H') -- esx_drugs:GetUserInventory
AddEventHandler('esx_K20drugs:GetUserInventory_H', function(currentZone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
		
	TriggerClientEvent('esx_drugs:ReturnInventory', _source, xPlayer.getInventoryItem('coke').count, xPlayer.getInventoryItem('coke_pooch').count,xPlayer.getInventoryItem('meth').count, xPlayer.getInventoryItem('meth_pooch').count, xPlayer.getInventoryItem('weed').count, xPlayer.getInventoryItem('weed_pooch').count, xPlayer.getInventoryItem('opium').count, xPlayer.getInventoryItem('opium_pooch').count,xPlayer.job.name, currentZone)
end)

ESX.RegisterUsableItem('weed', function(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('weed', 1)

	TriggerClientEvent('esx_drugs:onPot', _source)
	xPlayer.showNotification(_U('used_one_weed'))
end)

ESX.RegisterUsableItem('meth', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('meth', 1)

	TriggerClientEvent('esx_drugs:onMeth', _source)
	xPlayer.showNotification(_U('used_one_meth'))
end)

ESX.RegisterUsableItem('opium', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('opium', 1)

	TriggerClientEvent('esx_drugs:onOpium', _source)
	xPlayer.showNotification(_U('used_one_opium'))
end)

ESX.RegisterUsableItem('coke', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('coke', 1)

	TriggerClientEvent('esx_drugs:onCoke', _source)
	xPlayer.showNotification(_U('used_one_coke'))
end)
