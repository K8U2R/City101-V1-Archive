if IsDuplicityVersion() then
	AddEventHandler('Roma_security:serverReady', function()
		exports['esx_misc3']:setupServerResource(GetCurrentResourceName())
	end)
else
	securityToken = nil
	AddEventHandler('Roma_security:clientReady', function()
		securityToken = exports['esx_misc3']:setupClientResource(GetCurrentResourceName())
	end)
end