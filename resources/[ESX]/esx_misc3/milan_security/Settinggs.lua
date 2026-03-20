Settinggs = {}

--[[
	Enable verbose output on the console
	VerboseClient should be disable in production since it exposed tokens
]]
Settinggs.VerboseClient = false
Settinggs.VerboseServer = false

--[[
	Define the length of the generated token
--]]
Settinggs.TokenLength = 24

--[[
	Define the character set to be used in generation
	%a%d = all capital and lowercase letters and digits
	Syntax:
		.	all characters
		%a	letters
		%c	control characters
		%d	digits
		%l	lower case letters
		%p	punctuation characters
		%s	space characters
		%u	upper case letters
		%w	alphanumeric characters
		%x	hexadecimal digits
		%z	the character with representation 0
--]]
Settinggs.TokenCharset = "%a%d"

--[[
	Adjust the delay between when the client deploys the listeners and
	when the server sends the information.
	250 seems like a sweet spot here, but it can be reduced or increased if desired.
]]

Settinggs.ClientDelay = 1

--[[
	Define the message given to users with an invalid token
--]]
Settinggs.KickMessage = "لقد تم حظرك من المدينة لمحاولة إستخدام ثغرات برمجية .. أحفظ آخر 10 دقائق وتوجه الدعم الفني"

--[[
	Define a custom function to trigger when a player is kicked
	If Settinggs.CustomAction is false, the player will be dropped
]]
Settinggs.CustomAction = false
Settinggs.CustomActionFunction = function(source)
	print("Custom action executing for: " .. source)
	DropPlayer(source, Settinggs.KickMessage)
end
