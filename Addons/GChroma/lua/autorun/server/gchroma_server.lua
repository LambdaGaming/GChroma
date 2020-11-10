local function GChroma_Init()
	GChroma_Loaded = true
	MsgC( Color( 0, 255, 0 ), "\nGChroma server-side API loaded successfully.\n" )
end
hook.Add( "InitPostEntity", "Chroma_Init", GChroma_Init )

util.AddNetworkString( "GChroma_SetDeviceColor" )
function GChroma_SetDeviceColor( ply, device, color )
	net.Start( "GChroma_SetDeviceColor" )
	net.WriteInt( device, 32 )
	net.WriteVector( color )
	net.Send( ply )
end

util.AddNetworkString( "GChroma_SetDeviceColorEx" )
function GChroma_SetDeviceColorEx( ply, device, color, row, col )
	net.Start( "GChroma_SetDeviceColorEx" )
	net.WriteInt( device, 32 )
	net.WriteVector( color )
	net.WriteInt( row, 32 )
	net.WriteInt( col, 32 )
	net.Send( ply )
end

util.AddNetworkString( "GChroma_ResetDevice" )
function GChroma_ResetDevice( ply, device )
	net.Start( "GChroma_ResetDevice" )
	net.WriteInt( device, 32 )
	net.Send( ply )
end
