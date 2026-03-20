ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:checkpre', function(source, cb, plate_new, name_car, carjobb, typeindata, model, category, typee)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT identifier FROM sha WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier,
	}, function(result)
		if result[1] then
			cb({status = true, generatedPlate = plate_new, name = name_car, carjobb = carjobb, typeindata = typeindata, model = model, category = category, typee = typee})
		else
			cb({status = false, generatedPlate = plate_new, name = name_car, carjobb = carjobb, typeindata = typeindata, model = model, category = category, typee = typee})
		end
	end)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:buyVehicleC', function(source, cb, model, plate, category, name, typee, typeindata, joobbb,carprice,carlevel)
	local xPlayer = ESX.GetPlayerFromId(source)
	local modelPrice

	for k,v in ipairs(Config.VehiclesShop[typee].Vehicles) do
		if model == v.model then
			modelPrice = v.price
			break
		end
	end

	if modelPrice and xPlayer.getMoney() >= modelPrice then
		xPlayer.removeMoney(modelPrice)

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, job, category, name,priceold,levelold, modelname) VALUES (@owner, @plate, @vehicle, @type, @job, @category, @name,@priceold,@levelold, @modelname)', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate,
			['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate, engineHealth = 1000.0, bodyHealth = 1000.0}),
			['@type'] = typeindata,
			['@job'] = joobbb,
			['@category'] = category,
			['@name'] = name,
			['@priceold'] = carprice,
			['@levelold'] = carlevel,
			['@modelname'] = model,
		}, function(rowsChanged)
			xPlayer.showNotification(_U('car_belongs', plate))
			cb(true)
		end)
	else
		cb(false)
	end
end)

RegisterNetEvent('esx_advancedvehicleshop:addsha')
AddEventHandler('esx_advancedvehicleshop:addsha', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.execute('INSERT INTO sha (identifier) VALUES (@identifier)', {
		['@identifier'] = xPlayer.identifier,
	}, function(rowsChanged)
		--prit()
	end)
end)

RegisterNetEvent('esx_misc3:buyveh')
AddEventHandler('esx_misc3:buyveh', function(plate_car, name_car, job_car, type_car)
	local xPlayer = ESX.GetPlayerFromId(source)
	local message = "**لقد قام الاعب** : \n" .. xPlayer.getName() .. "\n\n**رقم الأستيم :** \n" .. xPlayer.identifier .. "\n\n**اسم الأستيم :** \n" .. GetPlayerName(source) .. "\n\n**الوظيفة :** \n" .. xPlayer.job.label .. " - " .. xPlayer.job.grade_label .. "\n\n**ب شراء المركبة : **\n" .. name_car .. "\n\n**لوحة المركبة : **\n" .. plate_car .. "\n\nنوع وظيفة المركبة : **\n" .. job_car .. "\n\n**نوع المركبة : **\n" .. type_car
	local DiscordWebHook = "https://discord.com/api/webhooks/1219053887793795135/EOKbW2Psjw58BG3CchvO1iBMfRautimeMP-tj8Q7ooY7baNNTWtqlULCMkTOpwrKfg4G"
  
  	local embeds = {
	  	{
		  	["title"]=  message,
		  	["type"]="rich",
		  	["color"] = 0000,
		  	["footer"]=  {
			  	["text"]= "شراء سيارة",
		 	},
	  	}
  	}
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = "شراء سيارة",embeds = embeds}), { ['Content-Type'] = 'application/json' })
end)
-- Shared
ESX.RegisterServerCallback('esx_advancedvehicleshop:isPlateTaken', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		cb(result[1] ~= nil)
	end)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:retrieveJobVehicles', function(source, cb, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT owner, plate, name, vehicle, type, job, stored, priceold, levelold, category, modelname, lasthouse, carseller FROM owned_vehicles WHERE owner = @owner AND type = @type AND job = @job', {
		['@owner'] = xPlayer.identifier,
		['@type'] = type,
		['@job'] = xPlayer.job.name
	}, function(result)
		cb(result)
	end)
end)

RegisterNetEvent('esx_advancedvehicleshop:setJobVehicleState')
AddEventHandler('esx_advancedvehicleshop:setJobVehicleState', function(plate, state, token)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = @stored WHERE plate = @plate AND job = @job', {
		['@stored'] = state,
		['@plate'] = plate,
		['@job'] = xPlayer.job.name
	}, function(rowsChanged)
		if rowsChanged == 0 then
			print(('[esx_advancedvehicleshop] [^3WARNING^7] %s exploited the garage!'):format(xPlayer.identifier))
		end
	end)
end)
