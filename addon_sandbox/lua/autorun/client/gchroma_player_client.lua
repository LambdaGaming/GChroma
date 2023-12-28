local function GetEmptySlots( ply )
	local slots = {
		{ 0, -1 },
		{ 1, -1 },
		{ 2, -1 },
		{ 3, -1 },
		{ 4, -1 },
		{ 5, -1 }
	}
	for k,v in pairs( ply:GetWeapons() ) do
		local slot = v:GetSlot()
		slots[slot + 1][2] = slot
	end
	return slots
end

local function GChromaPlayerInit()
	local ply = LocalPlayer()
	local initial = net.ReadBool()
	if gchroma.Loaded then
		if IsValid( ply ) then
			local plycolor = gchroma.ToVector( ply:GetPlayerColor():ToColor() )
			gchroma.ResetDevice( GCHROMA_DEVICE_ALL )

			local keys = {
				gchroma.KeyConvert( input.GetKeyCode( input.LookupBinding( "noclip" ) ) ),
				gchroma.KeyConvert( input.GetKeyCode( input.LookupBinding( "messagemode" ) ) ),
				gchroma.KeyConvert( input.GetKeyCode( input.LookupBinding( "messagemode2" ) ) ),
				gchroma.KeyConvert( input.GetKeyCode( input.LookupBinding( "menu" ) ) ),
				gchroma.KeyConvert( input.GetKeyCode( input.LookupBinding( "menu_context" ) ) ),
				gchroma.KeyConvert( input.GetKeyCode( input.LookupBinding( "impulse 100" ) ) ),
				gchroma.KeyConvert( input.GetKeyCode( input.LookupBinding( "voicerecord" ) ) )
			}

			gchroma.SetDeviceColor( GCHROMA_DEVICE_ALL, Vector( 25, 25, 25 ) )

			for k,v in pairs( keys ) do
				gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, plycolor, v, 0 )
			end
			
			timer.Simple( 0.1, function()
				for k,v in pairs( GetEmptySlots( ply ) ) do
					if v[2] == -1 then
						gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, Vector( 145, 80, 0 ), _G["GCHROMA_KEY_"..v[1] + 1], 0 )
					else
						gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, plycolor, _G["GCHROMA_KEY_"..v[1] + 1], 0 )
					end
				end
				gchroma.CreateEffect()
			end )
			
			gchroma.PlayerModuleLoaded = true
		end
	end
	if !gchroma.Loaded and initial then
		chat.AddText( Color( 0, 255, 0 ), "WARNING! GChroma is not loaded! Please follow the install instructions: https://steamcommunity.com/sharedfiles/filedetails/?id=2297412726" )
	end
end
net.Receive( "GChromaPlayerInit", GChromaPlayerInit )

local function GChromaOpenChat( teamchat )
	if gchroma.Loaded then
		local normalchat = gchroma.KeyConvert( input.GetKeyCode( input.LookupBinding( "messagemode" ) ) )
		local chatteam = gchroma.KeyConvert( input.GetKeyCode( input.LookupBinding( "messagemode2" ) ) )
		if teamchat then
			gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, chatteam, 0 )
		else
			gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, normalchat, 0 )
		end
		gchroma.CreateEffect()
	end
end
hook.Add( "StartChat", "GChromaOpenChat", GChromaOpenChat )

local function GChromaCloseChat()
	local ply = LocalPlayer()
	if gchroma.Loaded and IsValid( ply ) then
		local plycolor = gchroma.ToVector( ply:GetPlayerColor():ToColor() )
		local normalchat = gchroma.KeyConvert( input.GetKeyCode( input.LookupBinding( "messagemode" ) ) )
		local teamchat = gchroma.KeyConvert( input.GetKeyCode( input.LookupBinding( "messagemode2" ) ) )
		gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, plycolor, normalchat, 0 )
		gchroma.SetDeviceColorEx(  GCHROMA_DEVICE_KEYBOARD, plycolor, teamchat, 0 )
		gchroma.CreateEffect()
	end
end
hook.Add( "FinishChat", "GChromaCloseChat", GChromaCloseChat )

local function GChromaNoclip()
	local ply = LocalPlayer()
	if gchroma.Loaded and IsValid( ply ) then
		local enable = net.ReadBool()
		local convert = gchroma.KeyConvert( input.GetKeyCode( input.LookupBinding( "noclip" ) ) )
		if enable then
			gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, convert, 0 )
		else
			local plycolor = gchroma.ToVector( ply:GetPlayerColor():ToColor() )
			gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, plycolor, convert, 0 )
		end
		gchroma.CreateEffect()
	end
end
net.Receive( "GChromaNoclip", GChromaNoclip )

local function GChromaOpenSpawnMenu()
	if gchroma.Loaded then
		local convert = gchroma.KeyConvert( input.GetKeyCode( input.LookupBinding( "menu" ) ) )
		gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, convert, 0 )
		gchroma.CreateEffect()
	end
end
hook.Add( "OnSpawnMenuOpen", "GChromaOpenSpawnMenu", GChromaOpenSpawnMenu )

local function GChromaCloseSpawnMenu()
	local ply = LocalPlayer()
	if gchroma.Loaded and IsValid( ply ) then
		local plycolor = gchroma.ToVector( ply:GetPlayerColor():ToColor() )
		local convert = gchroma.KeyConvert( input.GetKeyCode( input.LookupBinding( "menu" ) ) )
		gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, plycolor, convert, 0 )
		gchroma.CreateEffect()
	end
end
hook.Add( "OnSpawnMenuClose", "GChromaCloseSpawnMenu", GChromaCloseSpawnMenu )

local function GChromaOpenContextMenu()
	if gchroma.Loaded then
		local convert = gchroma.KeyConvert( input.GetKeyCode( input.LookupBinding( "menu_context" ) ) )
		gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, convert, 0 )
		gchroma.CreateEffect()
	end
end
hook.Add( "OnContextMenuOpen", "GChromaOpenContextMenu", GChromaOpenContextMenu )

local function GChromaCloseContextMenu()
	local ply = LocalPlayer()
	if gchroma.Loaded and IsValid( ply ) then
		local plycolor = gchroma.ToVector( ply:GetPlayerColor():ToColor() )
		local convert = gchroma.KeyConvert( input.GetKeyCode( input.LookupBinding( "menu_context" ) ) )
		gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, plycolor, convert, 0 )
		gchroma.CreateEffect()
	end
end
hook.Add( "OnContextMenuClose", "GChromaCloseContextMenu", GChromaCloseContextMenu )

local function GChromaFlashlight()
	local ply = LocalPlayer()
	if gchroma.Loaded and IsValid( ply ) then
		local enabled = net.ReadBool()
		local convert = gchroma.KeyConvert( input.GetKeyCode( input.LookupBinding( "impulse 100" ) ) )
		if enabled then
			gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, convert, 0 )
		else
			local plycolor = gchroma.ToVector( ply:GetPlayerColor():ToColor() )
			gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, plycolor, convert, 0 )
		end
		gchroma.CreateEffect()
	end
end
net.Receive( "GChromaFlashlight", GChromaFlashlight )

local function GChromaStartVoice()
	if gchroma.Loaded then
		local convert = gchroma.KeyConvert( input.GetKeyCode( input.LookupBinding( "voicerecord" ) ) )
		gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, convert, 0 )
		gchroma.CreateEffect()
	end
end
hook.Add( "PlayerStartVoice", "GChromaStartVoice", GChromaStartVoice )

local function GChromaEndVoice()
	local ply = LocalPlayer()
	if gchroma.Loaded and IsValid( ply ) then
		local plycolor = gchroma.ToVector( ply:GetPlayerColor():ToColor() )
		local convert = gchroma.KeyConvert( input.GetKeyCode( input.LookupBinding( "voicerecord" ) ) )
		gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, plycolor, convert, 0 )
		gchroma.CreateEffect()
	end
end
hook.Add( "PlayerEndVoice", "GChromaEndVoice", GChromaEndVoice )

local function GChromaUpdateSlots()
	local ply = LocalPlayer()
	if gchroma.Loaded and IsValid( ply ) then
		local plycolor = gchroma.ToVector( ply:GetPlayerColor():ToColor() )
		for k,v in pairs( GetEmptySlots( ply ) ) do
			if v[2] == -1 then
				gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, Vector( 145, 80, 0 ), _G["GCHROMA_KEY_"..v[1] + 1], 0 )
			else
				gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, plycolor, _G["GCHROMA_KEY_"..v[1] + 1], 0 )
			end
		end
		gchroma.CreateEffect()
	end
end
net.Receive( "GChromaUpdateSlots", GChromaUpdateSlots )

if DarkRP then
	local function GChromaDarkRPChangedTeam( ply )
		if gchroma.Loaded then
			GChromaPlayerInit()
		end
	end
	hook.Add( "OnPlayerChangedTeam", "GChromaDarkRPChangedTeam", GChromaDarkRPChangedTeam )
end
