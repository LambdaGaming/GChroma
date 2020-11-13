GChroma_PlayerModule_Loaded = true

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
	if GChroma_Loaded then
		local ply = LocalPlayer()
		require( "gchroma" )
		GChroma_ResetDevice( GCHROMA_DEVICE_ALL )

		local keys = {
			GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "noclip" ) ) ),
			GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "messagemode" ) ) ),
			GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "messagemode2" ) ) ),
			GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "menu" ) ) ),
			GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "menu_context" ) ) ),
			GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "impulse 100" ) ) )
		}

		timer.Simple( 0.1, function()
			for k,v in pairs( GetEmptySlots( ply ) ) do
				if v[2] == -1 then
					GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, Vector( 145, 80, 0 ), _G["GCHROMA_KEY_"..v[1] + 1], 0 )
				else
					GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, _G["GCHROMA_KEY_"..v[1] + 1], 0 )
				end
			end
		end )

		for k,v in pairs( keys ) do
			GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, v, 0 )
		end
	end
end
net.Receive( "GChromaPlayerInit", GChromaPlayerInit )

local function GChromaOpenChat( teamchat )
	if GChroma_Loaded then
		local plycolor = GChroma_ToVector( LocalPlayer():GetPlayerColor():ToColor() )
		if teamchat then
			GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, plycolor, GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "messagemode2" ) ) ), 0 )
		else
			GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, plycolor, GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "messagemode" ) ) ), 0 )
		end
	end
end
hook.Add( "StartChat", "GChromaOpenChat", GChromaOpenChat )

local function GChromaCloseChat()
	if GChroma_Loaded then
		GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "messagemode" ) ) ), 0 )
		GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "messagemode2" ) ) ), 0 )
	end
end
hook.Add( "FinishChat", "GChromaCloseChat", GChromaCloseChat )

local function GChromaNoclip()
	if GChroma_Loaded then
		local enable = net.ReadBool()
		local convert = GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "noclip" ) ) )
		if enable then
			local plycolor = GChroma_ToVector( LocalPlayer():GetPlayerColor():ToColor() )
			GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, plycolor, convert, 0 )
		else
			GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, convert, 0 )
		end
	end
end
net.Receive( "GChromaNoclip", GChromaNoclip )

local function GChromaOpenSpawnMenu()
	if GChroma_Loaded then
		local plycolor = GChroma_ToVector( LocalPlayer():GetPlayerColor():ToColor() )
		GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, plycolor, GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "menu" ) ) ), 0 )
	end
end
hook.Add( "OnSpawnMenuOpen", "GChromaOpenSpawnMenu", GChromaOpenSpawnMenu )

local function GChromaCloseSpawnMenu()
	if GChroma_Loaded then
		GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "menu" ) ) ), 0 )
	end
end
hook.Add( "OnSpawnMenuClose", "GChromaCloseSpawnMenu", GChromaCloseSpawnMenu )

local function GChromaOpenContextMenu()
	if GChroma_Loaded then
		local plycolor = GChroma_ToVector( LocalPlayer():GetPlayerColor():ToColor() )
		GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, plycolor, GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "menu_context" ) ) ), 0 )
	end
end
hook.Add( "OnContextMenuOpen", "GChromaOpenContextMenu", GChromaOpenContextMenu )

local function GChromaCloseContextMenu()
	if GChroma_Loaded then
		GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "menu_context" ) ) ), 0 )
	end
end
hook.Add( "OnContextMenuClose", "GChromaCloseContextMenu", GChromaCloseContextMenu )

local function GChromaFlashlight()
	if GChroma_Loaded then
		local enabled = net.ReadBool()
		local convert = GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "impulse 100" ) ) )
		if enabled then
			local plycolor = GChroma_ToVector( LocalPlayer():GetPlayerColor():ToColor() )
			GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, plycolor, convert, 0 )
		else
			GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, convert, 0 )
		end
	end
end
net.Receive( "GChromaFlashlight", GChromaFlashlight )
