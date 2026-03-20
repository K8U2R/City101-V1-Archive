local ESX = nil
-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Open ID card
RegisterServerEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function(ID, targetID, type, data, sponser)
	local identifier = ESX.GetPlayerFromId(ID).identifier
	local _source 	 = ESX.GetPlayerFromId(targetID).source
	local xPlayer = ESX.GetPlayerFromId(ID)
	local show       = false

	MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = @identifier', {['@identifier'] = identifier},
	function (user)
		if (user[1] ~= nil) then
			MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier', {['@identifier'] = identifier},
			function (licenses)
				if type ~= nil then
					for i=1, #licenses, 1 do
						if type == 'driver' then
							if licenses[i].type == 'drive' or licenses[i].type == 'drive_bike' or licenses[i].type == 'drive_truck' then
								show = true
							end	
						elseif type =='market' then
							if licenses[i].type == 'market' then
								show = true
							end	
						elseif type =='gold' then
							
								show = true
								
							elseif type =='plat' then
							
								show = true


						elseif type =='sponserStrategy' then
							
								show = true
								
							elseif type =='diamond' then
							
								show = true
								

						elseif type =='sponserSilver' then
							
								show = true


							elseif type =='bht' then
							
								show = true
								


						elseif type =='sponserOfficial' then
							
								show = true
								

						elseif type =='weapon' then
							if licenses[i].type == 'weapon' then
								show = true
							end
						elseif type =='sponser' then
							
								show = true
							
						end
					end
				else
					show = true
				end
				
				if show then
					user[1].job = xPlayer.job.name
					local array = {user = user, licenses = licenses}
					TriggerClientEvent('jsfour-idcard:open', _source, array, type)
					
				else
					TriggerClientEvent('pNotify:SendNotification', _source, {
						text = '<font color=red><center><p style=><font size=5.5> لاتمتلك هذا النوع من الرخص ', 
						type = "error", 
						timeout = 10000, 
						layout = "centerLeft"
					})					
				end
			end)
		end
	end)
end)
