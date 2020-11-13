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
	local ply = LocalPlayer()
	if GChroma_Loaded then
		require( "gchroma" )
		GChroma_ResetDevice( GCHROMA_DEVICE_ALL )
		timer.Simple( 0, function()
			for k,v in pairs( GetEmptySlots( ply ) ) do
				if v[2] == -1 then
					GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, Vector( 145, 80, 0 ), _G["GCHROMA_KEY_"..v[1] + 1], 0 )
				else
					GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, _G["GCHROMA_KEY_"..v[1] + 1], 0 )
				end
			end
		end )
		GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "noclip" ) ) ), 0 )
		GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "messagemode" ) ) ), 0 )
		GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "messagemode2" ) ) ), 0 )
		GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "menu" ) ) ), 0 )
		GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "menu_context" ) ) ), 0 )
		GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "impulse 100" ) ) ), 0 )
	end
end
net.Receive( "GChromaPlayerInit", GChromaPlayerInit )

local function GChromaOpenChat( teamchat )
	if teamchat then
		GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_GREEN, GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "messagemode2" ) ) ), 0 )
	else
		GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_GREEN, GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "messagemode" ) ) ), 0 )
	end
end
hook.Add( "StartChat", "GChromaOpenChat", GChromaOpenChat )

local function GChromaCloseChat()
	GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "messagemode" ) ) ), 0 )
	GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "messagemode2" ) ) ), 0 )
end
hook.Add( "StartChat", "GChromaCloseChat", GChromaCloseChat )

local function GChromaNoclip()
	local enable = net.ReadBool()
	local convert = GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "noclip" ) ) )
	if enable then
		GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_GREEN, convert, 0 )
	else
		GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, convert, 0 )
	end
end
net.Receive( "GChromaNoclip", GChromaNoclip )

local function GChromaOpenSpawnMenu()
	GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_GREEN, GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "menu" ) ) ), 0 )
end
hook.Add( "OnSpawnMenuOpen", "GChromaOpenSpawnMenu", GChromaOpenSpawnMenu )

local function GChromaCloseSpawnMenu()
	GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "menu" ) ) ), 0 )
end
hook.Add( "OnSpawnMenuClose", "GChromaCloseSpawnMenu", GChromaCloseSpawnMenu )

local function GChromaOpenContextMenu()
	GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_GREEN, GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "menu_context" ) ) ), 0 )
end
hook.Add( "OnContextMenuOpen", "GChromaOpenContextMenu", GChromaOpenContextMenu )

local function GChromaCloseContextMenu()
	GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "menu_context" ) ) ), 0 )
end
hook.Add( "OnContextMenuClose", "GChromaCloseContextMenu", GChromaCloseContextMenu )

local function GChromaFlashlight()
	local enabled = net.ReadBool()
	local convert = GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "impulse 100" ) ) )
	if enabled then
		GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_GREEN, convert, 0 )
	else
		GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, convert, 0 )
	end
end
net.Receive( "GChromaFlashlight", GChromaFlashlight )
