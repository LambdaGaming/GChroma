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

net.Receive( "GChromaPlayerInit", function()
	local ply = LocalPlayer()
	if gchroma.Loaded then
		if IsValid( ply ) then
			local plyColor = ply:GetPlayerColor():ToColor()
			local keys = {
				gchroma.KeyConvert( "noclip" ),
				gchroma.KeyConvert( "messagemode" ),
				gchroma.KeyConvert( "messagemode2" ),
				gchroma.KeyConvert( "menu" ),
				gchroma.KeyConvert( "menu_context" ),
				gchroma.KeyConvert( "impulse 100" ),
				gchroma.KeyConvert( "voicerecord" )
			}

			gchroma.SetDeviceColor( gchroma.DeviceType.All, color_darkgray )
			for k,v in pairs( keys ) do
				gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, v, plyColor )
			end
			timer.Simple( 0.1, function()
				for k,v in pairs( GetEmptySlots( ply ) ) do
					local color = v[2] == -1 and Color( 145, 80, 0 ) or plyColor
					gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, color, gchroma.Key[v[1] + 1] )
				end
			end )
		end
	end
end )

hook.Add( "StartChat", "GChromaOpenChat", function( teamChat )
	if gchroma.Loaded then
		local normalChat = gchroma.KeyConvert( "messagemode" )
		local chatTeam = gchroma.KeyConvert( "messagemode2" )
		if teamChat then
			gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, chatTeam, color_white )
		else
			gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, normalChat, color_white )
		end
	end
end )

hook.Add( "FinishChat", "GChromaCloseChat", function()
	local ply = LocalPlayer()
	if gchroma.Loaded and IsValid( ply ) then
		local plyColor = ply:GetPlayerColor():ToColor()
		local normalChat = gchroma.KeyConvert( "messagemode" )
		local teamChat = gchroma.KeyConvert( "messagemode2" )
		gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, normalChat, plyColor )
		gchroma.SetLEDColor(  gchroma.DeviceType.Keyboard, teamChat, plyColor )
	end
end )

net.Receive( "GChromaNoclip", function()
	local ply = LocalPlayer()
	if gchroma.Loaded and IsValid( ply ) then
		local enable = net.ReadBool()
		local convert = gchroma.KeyConvert( "noclip" )
		if enable then
			gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, convert, color_white )
		else
			local plyColor = ply:GetPlayerColor():ToColor()
			gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, convert, plyColor )
		end
	end
end )

hook.Add( "OnSpawnMenuOpen", "GChromaOpenSpawnMenu", function()
	if gchroma.Loaded then
		local convert = gchroma.KeyConvert( "menu" )
		gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, convert, color_white )
	end
end )

hook.Add( "OnSpawnMenuClose", "GChromaCloseSpawnMenu", function()
	local ply = LocalPlayer()
	if gchroma.Loaded and IsValid( ply ) then
		local plyColor = ply:GetPlayerColor():ToColor()
		local convert = gchroma.KeyConvert( "menu" )
		gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, convert, plyColor )
	end
end )

hook.Add( "OnContextMenuOpen", "GChromaOpenContextMenu", function()
	if gchroma.Loaded then
		local convert = gchroma.KeyConvert( "menu_context" )
		gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, convert, color_white )
	end
end )

hook.Add( "OnContextMenuClose", "GChromaCloseContextMenu", function()
	local ply = LocalPlayer()
	if gchroma.Loaded and IsValid( ply ) then
		local plyColor = ply:GetPlayerColor():ToColor()
		local convert = gchroma.KeyConvert( "menu_context" )
		gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, convert, plyColor )
	end
end )

net.Receive( "GChromaFlashlight", function()
	local ply = LocalPlayer()
	if gchroma.Loaded and IsValid( ply ) then
		local enabled = net.ReadBool()
		local convert = gchroma.KeyConvert( "impulse 100" )
		if enabled then
			gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, convert, color_white )
		else
			local plyColor = ply:GetPlayerColor():ToColor()
			gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, convert, plyColor )
		end
	end
end )

hook.Add( "PlayerStartVoice", "GChromaStartVoice", function()
	if gchroma.Loaded then
		local convert = gchroma.KeyConvert( "voicerecord" )
		gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, convert, color_white )
	end
end )

hook.Add( "PlayerEndVoice", "GChromaEndVoice", function()
	local ply = LocalPlayer()
	if gchroma.Loaded and IsValid( ply ) then
		local plyColor = ply:GetPlayerColor():ToColor()
		local convert = gchroma.KeyConvert( "voicerecord" )
		gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, convert, plyColor )
	end
end )

net.Receive( "GChromaUpdateSlots", function()
	local ply = LocalPlayer()
	if gchroma.Loaded and IsValid( ply ) then
		local plyColor = ply:GetPlayerColor():ToColor()
		for k,v in pairs( GetEmptySlots( ply ) ) do
			local color = v[2] == -1 and Color( 145, 80, 0 ) or plyColor
			gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, Vector( 145, 80, 0 ), gchroma.Key[v[1] + 1] )
		end
	end
end )

if DarkRP then
	hook.Add( "OnPlayerChangedTeam", "GChromaDarkRPChangedTeam", function()
		if gchroma.Loaded then
			GChromaPlayerInit()
		end
	end )
end
