local function GChroma_Test()
	if GChroma_Loaded then
		local i = 1
		timer.Create( "GChroma_Init", 0.5, 4, function()
			local colors = {
				Vector( 255, 0, 0 ),
				Vector( 0, 255, 0 ),
				Vector( 0, 0, 255 )
			}
			if i == 4 then
				GChroma_ResetDevice( GCHROMA_DEVICE_ALL )
				return
			end
			GChroma_SetDeviceColor( GCHROMA_DEVICE_ALL, colors[i] )
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
