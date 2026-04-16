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
	if !gchroma.IsConnected() or !IsValid( ply ) then return end
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
			gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, gchroma.Key[tostring( v[1] + 1 )], color )
		end
	end )
end )

hook.Add( "StartChat", "GChromaOpenChat", function( teamChat )
	if !gchroma.IsConnected() then return end
	local normalChat = gchroma.KeyConvert( "messagemode" )
	local chatTeam = gchroma.KeyConvert( "messagemode2" )
	if teamChat then
		gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, chatTeam, color_white )
	else
		gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, normalChat, color_white )
	end
end )

hook.Add( "FinishChat", "GChromaCloseChat", function()
	local ply = LocalPlayer()
	if !gchroma.IsConnected() or !IsValid( ply ) then return end
	local plyColor = ply:GetPlayerColor():ToColor()
	local normalChat = gchroma.KeyConvert( "messagemode" )
	local teamChat = gchroma.KeyConvert( "messagemode2" )
	gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, normalChat, plyColor )
	gchroma.SetLEDColor(  gchroma.DeviceType.Keyboard, teamChat, plyColor )
end )

net.Receive( "GChromaNoclip", function()
	local ply = LocalPlayer()
	if !gchroma.IsConnected() or !IsValid( ply ) then return end
	local enable = net.ReadBool()
	local convert = gchroma.KeyConvert( "noclip" )
	if enable then
		gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, convert, color_white )
	else
		local plyColor = ply:GetPlayerColor():ToColor()
		gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, convert, plyColor )
	end
end )

hook.Add( "OnSpawnMenuOpen", "GChromaOpenSpawnMenu", function()
	if !gchroma.IsConnected() then return end
	local convert = gchroma.KeyConvert( "menu" )
	gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, convert, color_white )
end )

hook.Add( "OnSpawnMenuClose", "GChromaCloseSpawnMenu", function()
	local ply = LocalPlayer()
	if !gchroma.IsConnected() or !IsValid( ply ) then return end
	local plyColor = ply:GetPlayerColor():ToColor()
	local convert = gchroma.KeyConvert( "menu" )
	gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, convert, plyColor )
end )

hook.Add( "OnContextMenuOpen", "GChromaOpenContextMenu", function()
	if !gchroma.IsConnected() then return end
	local convert = gchroma.KeyConvert( "menu_context" )
	gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, convert, color_white )
end )

hook.Add( "OnContextMenuClose", "GChromaCloseContextMenu", function()
	local ply = LocalPlayer()
	if !gchroma.IsConnected() or !IsValid( ply ) then return end
	local plyColor = ply:GetPlayerColor():ToColor()
	local convert = gchroma.KeyConvert( "menu_context" )
	gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, convert, plyColor )
end )

net.Receive( "GChromaFlashlight", function()
	local ply = LocalPlayer()
	if !gchroma.IsConnected() or !IsValid( ply ) then return end
	local enabled = net.ReadBool()
	local convert = gchroma.KeyConvert( "impulse 100" )
	if enabled then
		gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, convert, color_white )
	else
		local plyColor = ply:GetPlayerColor():ToColor()
		gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, convert, plyColor )
	end
end )

hook.Add( "PlayerStartVoice", "GChromaStartVoice", function()
	if !gchroma.IsConnected() then return end
	local convert = gchroma.KeyConvert( "voicerecord" )
	gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, convert, color_white )
end )

hook.Add( "PlayerEndVoice", "GChromaEndVoice", function()
	local ply = LocalPlayer()
	if gchroma.IsConnected() or !IsValid( ply ) then return end
	local plyColor = ply:GetPlayerColor():ToColor()
	local convert = gchroma.KeyConvert( "voicerecord" )
	gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, convert, plyColor )
end )

net.Receive( "GChromaUpdateSlots", function()
	local ply = LocalPlayer()
	if !gchroma.IsConnected() or !IsValid( ply ) then return end
	local plyColor = ply:GetPlayerColor():ToColor()
	for k,v in pairs( GetEmptySlots( ply ) ) do
		local color = v[2] == -1 and Color( 145, 80, 0 ) or plyColor
		gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, gchroma.Key[tostring( v[1] + 1 )], color )
	end
end )

hook.Add( "PlayerChangedTeam", "GChromaDarkRPChangedTeam", function()
	if gchroma.IsConnected() then
		GChromaPlayerInit()
	end
end )
