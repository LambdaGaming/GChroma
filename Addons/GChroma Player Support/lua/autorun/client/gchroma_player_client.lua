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
		require( "gchroma" )
		local ply = LocalPlayer()
		local chroma = GChroma_Start()
		GChroma_ResetDevice( chroma, GCHROMA_DEVICE_ALL )

		local keys = {
			GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "noclip" ) ) ),
			GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "messagemode" ) ) ),
			GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "messagemode2" ) ) ),
			GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "menu" ) ) ),
			GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "menu_context" ) ) ),
			GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "impulse 100" ) ) )
		}

		for k,v in pairs( keys ) do
			GChroma_SetDeviceColorEx( chroma, GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, v, 0 )
		end
		
		timer.Simple( 0.1, function()
			for k,v in pairs( GetEmptySlots( ply ) ) do
				if v[2] == -1 then
					GChroma_SetDeviceColorEx( chroma, GCHROMA_DEVICE_KEYBOARD, Vector( 145, 80, 0 ), _G["GCHROMA_KEY_"..v[1] + 1], 0 )
				else
					GChroma_SetDeviceColorEx( chroma, GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, _G["GCHROMA_KEY_"..v[1] + 1], 0 )
				end
			end
			GChroma_CreateEffect( chroma, false, true )
		end )
	end
end
net.Receive( "GChromaPlayerInit", GChromaPlayerInit )

local function GChromaOpenChat( teamchat )
	if GChroma_Loaded then
		local chroma = GChroma_Start()
		local plycolor = GChroma_ToVector( LocalPlayer():GetPlayerColor():ToColor() )
		local normalchat = GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "messagemode" ) ) )
		local chatteam = GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "messagemode2" ) ) )
		if teamchat then
			GChroma_SetDeviceColorEx( chroma, GCHROMA_DEVICE_KEYBOARD, plycolor, chatteam, 0 )
		else
			GChroma_SetDeviceColorEx( chroma, GCHROMA_DEVICE_KEYBOARD, plycolor, normalchat, 0 )
		end
		GChroma_CreateEffect( chroma, false, true )
	end
end
hook.Add( "StartChat", "GChromaOpenChat", GChromaOpenChat )

local function GChromaCloseChat()
	if GChroma_Loaded then
		local chroma = GChroma_Start()
		local normalchat = GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "messagemode" ) ) )
		local teamchat = GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "messagemode2" ) ) )
		GChroma_SetDeviceColorEx( chroma, GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, normalchat, 0 )
		GChroma_SetDeviceColorEx( chroma, GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, teamchat, 0 )
		GChroma_CreateEffect( chroma, false, true )
	end
end
hook.Add( "FinishChat", "GChromaCloseChat", GChromaCloseChat )

local function GChromaNoclip()
	if GChroma_Loaded then
		local chroma = GChroma_Start()
		local enable = net.ReadBool()
		local convert = GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "noclip" ) ) )
		if enable then
			local plycolor = GChroma_ToVector( LocalPlayer():GetPlayerColor():ToColor() )
			GChroma_SetDeviceColorEx( chroma, GCHROMA_DEVICE_KEYBOARD, plycolor, convert, 0 )
		else
			GChroma_SetDeviceColorEx( chroma, GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, convert, 0 )
		end
		GChroma_CreateEffect( chroma, false, true )
	end
end
net.Receive( "GChromaNoclip", GChromaNoclip )

local function GChromaOpenSpawnMenu()
	if GChroma_Loaded then
		local chroma = GChroma_Start()
		local plycolor = GChroma_ToVector( LocalPlayer():GetPlayerColor():ToColor() )
		local convert = GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "menu" ) ) )
		GChroma_SetDeviceColorEx( chroma, GCHROMA_DEVICE_KEYBOARD, plycolor, convert, 0 )
		GChroma_CreateEffect( chroma, false, true )
	end
end
hook.Add( "OnSpawnMenuOpen", "GChromaOpenSpawnMenu", GChromaOpenSpawnMenu )

local function GChromaCloseSpawnMenu()
	if GChroma_Loaded then
		local chroma = GChroma_Start()
		local convert = GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "menu" ) ) )
		GChroma_SetDeviceColorEx( chroma, GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, convert, 0 )
		GChroma_CreateEffect( chroma, false, true )
	end
end
hook.Add( "OnSpawnMenuClose", "GChromaCloseSpawnMenu", GChromaCloseSpawnMenu )

local function GChromaOpenContextMenu()
	if GChroma_Loaded then
		local chroma = GChroma_Start()
		local plycolor = GChroma_ToVector( LocalPlayer():GetPlayerColor():ToColor() )
		local convert = GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "menu_context" ) ) )
		GChroma_SetDeviceColorEx( chroma, GCHROMA_DEVICE_KEYBOARD, plycolor, convert, 0 )
		GChroma_CreateEffect( chroma, false, true )
	end
end
hook.Add( "OnContextMenuOpen", "GChromaOpenContextMenu", GChromaOpenContextMenu )

local function GChromaCloseContextMenu()
	if GChroma_Loaded then
		local chroma = GChroma_Start()
		local convert = GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "menu_context" ) ) )
		GChroma_SetDeviceColorEx( chroma, GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, convert, 0 )
		GChroma_CreateEffect( chroma, false, true )
	end
end
hook.Add( "OnContextMenuClose", "GChromaCloseContextMenu", GChromaCloseContextMenu )

local function GChromaFlashlight()
	if GChroma_Loaded then
		local chroma = GChroma_Start()
		local enabled = net.ReadBool()
		local convert = GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "impulse 100" ) ) )
		if enabled then
			local plycolor = GChroma_ToVector( LocalPlayer():GetPlayerColor():ToColor() )
			GChroma_SetDeviceColorEx( chroma, GCHROMA_DEVICE_KEYBOARD, plycolor, convert, 0 )
		else
			GChroma_SetDeviceColorEx( chroma, GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_WHITE, convert, 0 )
		end
		GChroma_CreateEffect( chroma, false, true )
	end
end
net.Receive( "GChromaFlashlight", GChromaFlashlight )
