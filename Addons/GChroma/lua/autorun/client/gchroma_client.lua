function GChroma_Test()
	if GChroma_Loaded then
		local i = 0
		timer.Create( "GChroma_Init", 0.5, 4, function()
			if i == 0 then
				GChroma_SetDeviceColor( GCHROMA_DEVICE_ALL, Vector( 255, 0, 0 ) )
			elseif i == 1 then
				GChroma_SetDeviceColor( GCHROMA_DEVICE_ALL, Vector( 0, 255, 0 ) )
			elseif i == 2 then
				GChroma_SetDeviceColor( GCHROMA_DEVICE_ALL, Vector( 0, 0, 255 ) )
			else
				GChroma_ResetDevice( GCHROMA_DEVICE_ALL )
			end
			i = i + 1
		end )
	end
end
concommand.Add( "gchroma_test", GChroma_Test )

function GChroma_ToVector( color )
	return Vector( color.r, color.g, color.b )
end

local function GChroma_Init()
	if pcall( require, "gchroma" ) then --Make sure the client actually has the dll
		GChroma_ResetDevice( GCHROMA_DEVICE_ALL ) --Doesn't do anything here but tell the SDK to wake up
		GChroma_Loaded = true
		MsgC( Color( 0, 255, 0 ), "\nGChroma client-side API loaded successfully.\n" )
	end
end
hook.Add( "InitPostEntity", "Chroma_Init", GChroma_Init )
