-- IMPORTANT:
-- For use in other resources, you will need to use: 
--     exports.Badger_Discord_API:<function>
--
-- For example:
--		exports.Badger_Discord_API:GetRoleIdFromRoleName("roleName")

RegisterCommand('testResource', function(source, args, rawCommand)
	local user = source; -- The user 



-- function GetRoleIdFromRoleName(name)
-- Returns nil if not found
-- Returns Discord Role ID if found
-- Usage:
	local roleName = "ادمن +"; -- Change this to an existing role name on your Discord server 

	local roleID = GetRoleIdFromRoleName(roleName);

-- function IsDiscordEmailVerified(user)
-- Returns false if not found
-- Returns true if verified 
-- Usage:
	local isVerified = IsDiscordEmailVerified(user);

-- function GetDiscordEmail(user)
-- Returns nil if not found
-- Returns Email if found 
-- Usage:
	local emailAddr = GetDiscordEmail(user);

-- function GetDiscordName(user)
-- Returns nil if not found
-- Returns Discord name if found 
-- Usage:
	local name = GetDiscordName(user);

-- function GetGuildIcon()
-- Returns nil if not found
-- Returns URL if found 
-- Usage:
	local icon_URL = GetGuildIcon();

-- function GetGuildSplash()
-- Returns nil if not found
-- Returns URL if found 
-- Usage:
	local splash_URL = GetGuildSplash();

-- function GetGuildName()
-- Returns nil if not found
-- Returns name if found 
-- Usage:
	local guildName = GetGuildName();

-- function GetGuildDescription()
-- Returns nil if not found
-- Returns description if found 
-- Usage:
	local guildDesc = GetGuildDescription();

-- function GetGuildMemberCount()
-- Returns nil if not found
-- Returns member count if found 
-- Usage:
	local guildMemCount = GetGuildMemberCount();

-- function GetGuildOnlineMemberCount()
-- Returns nil if not found
-- Returns description if found 
-- Usage:
	local onlineMemCount = GetGuildOnlineMemberCount();

-- function GetDiscordAvatar(user)
-- Returns nil if not found
-- Returns URL if found 
-- Usage:
	local avatar = GetDiscordAvatar(user);

-- function GetDiscordNickname(user)
-- Returns nil if not found
-- Returns nickname if found 
-- Usage:
	local nickname = GetDiscordNickname(user);

-- function GetGuildRoleList()
-- Returns nil if not found
-- Returns associative array if found 
-- Usage:
	local roles = GetGuildRoleList();
	for roleName, roleID in pairs(roles) do 
		--print(roleName .. " === " .. roleID);
	end

-- function GetDiscordRoles(user)
-- Returns nil if not found
-- Returns array if found 
-- Usage:
	local roles = GetDiscordRoles(user)
	for i = 1, #roles do  
		--print(roles[i]);
	end

-- function CheckEqual(role1, role2)
-- Returns false if not equal
-- Returns true if equal 
-- Usage:
	local isRolesEqual = CheckEqual("ادمن +", 1214434072311373905);
	local isRolesEqual2 = CheckEqual("FounderRef", "Founder"); -- Refer to config.lua file, this is basically checking if FounderRef in the config is 
	-- equal to the Founder role's ID 
end)
