gchroma = { Pending = {} }

function gchroma.SetDeviceColor( device, color )
	assert( device and color, "Missing one or more arguments for gchroma.SetDeviceColor" )
	table.insert( gchroma.Pending, { GCHROMA_FUNC_DEVICECOLOR, device, color } )
end

function gchroma.SetLEDColor( device, name, color )
	assert( device and name and color, "Missing one or more arguments for gchroma.SetLEDColor" )
	table.insert( gchroma.Pending, { GCHROMA_FUNC_LEDCOLOR, device, name, color } )
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
