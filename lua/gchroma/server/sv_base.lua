gchroma = { Pending = {} }

function gchroma.SetDeviceColor( device, color )
	assert( device and color, "Missing one or more arguments for gchroma.SetDeviceColor" )
	table.insert( gchroma.Pending, { gchroma.FuncType.DeviceColor, device, color } )
end

function gchroma.SetLEDColor( device, name, color )
	assert( device and name and color, "Missing one or more arguments for gchroma.SetLEDColor" )
	table.insert( gchroma.Pending, { gchroma.FuncType.LEDColor, device, name, color } )
end

util.AddNetworkString( "GChroma_SendFunctions" )
function gchroma.SendFunctions( ply )
	net.Start( "GChroma_SendFunctions" )
	net.WriteTable( gchroma.Pending )
	net.Send( ply )
	gchroma.Pending = {}
end
