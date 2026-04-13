gchroma = { Pending = {} }

local function GChroma_Init()
	MsgC( Color( 0, 255, 0 ), "\nGChroma server-side API loaded successfully.\n" )
end
hook.Add( "InitPostEntity", "Chroma_Init", GChroma_Init )

function gchroma.SetDeviceColor( device, color )
	assert( device and color, "Missing one or more arguments for gchroma.SetDeviceColor" )
	table.insert( gchroma.Pending, { GCHROMA_FUNC_DEVICECOLOR, device, color } )
end

function gchroma.ToVector( color )
	return Vector( color.r, color.g, color.b )
end

util.AddNetworkString( "GChroma_SendFunctions" )
function gchroma.SendFunctions( ply )
	net.Start( "GChroma_SendFunctions" )
	net.WriteTable( gchroma.Pending )
	net.Send( ply )
	gchroma.Pending = {}
end
