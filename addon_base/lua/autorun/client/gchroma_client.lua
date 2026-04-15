if util.IsBinaryModuleInstalled( "gchroma" ) then
	require( "gchroma" )
else
	MsgC( Color( 255, 0, 0 ), "WARNING! GChroma binary module failed to load. Verify that you downloaded the correct version and that it's installed correctly." )
end

gchroma = gchroma or {}

CreateClientConVar( "gchroma_ip", "127.0.0.1", true, false, "IP address of the OpenRGB server. Requires restart after changing." )
CreateClientConVar( "gchroma_port", 6742, true, false, "Port number of the OpenRGB server. Requires restart after changing." )

concommand.Add( "gchroma_test", function()
	if !gchroma.Loaded then return end
	local i = 1
	local colors = {
		GCHROMA_COLOR_RED,
		GCHROMA_COLOR_GREEN,
		GCHROMA_COLOR_BLUE
	}
	timer.Create( "GChroma_Init", 0.5, 4, function()
		if i == 4 then
			gchroma.SetDeviceColor( GCHROMA_DEVICE_ALL, GCHROMA_COLOR_BLACK )
			return
		end
		gchroma.SetDeviceColor( GCHROMA_DEVICE_ALL, colors[i] )
		i = i + 1
	end )
end )

hook.Add( "InitPostEntity", "Chroma_Init", function()
	if !gchroma.Loaded then
		MsgC( Color( 255, 0, 0 ), "WARNING! GChroma failed to initialize. Make sure the binary module is up to date and properly installed." )
		return
	end
	local ip = GetConVar( "gchroma_ip" ):GetString()
	local port = GetConVar( "gchroma_port" ):GetInt()
	local success = gchroma.Connect( ip, port )
	if !success then
		return
	end
	gchroma.SetDeviceColor( GCHROMA_DEVICE_ALL, GCHROMA_COLOR_DARKGRAY )
	MsgC( Color( 0, 255, 0 ), "\nGChroma client-side API loaded successfully.\n" )
	hook.Run( "GChromaInitialized" )
end )

net.Receive( "GChroma_SendFunctions", function()
	if !gchroma.Loaded then return end
	local tbl = net.ReadTable()
	for _,v in ipairs( tbl ) do
		if v[1] == GCHROMA_FUNC_DEVICECOLOR then
			gchroma.SetDeviceColor( v[2], v[3] )
		elseif v[1] == GCHROMA_FUNC_LEDCOLOR then
			gchroma.SetLEDColor( v[2], v[3], v[4] )
		end
	end
end )

--Utility functions
function gchroma.KeyConvert( key )
	local convert = _G["GCHROMA_KEY_"..input.GetKeyName( key ):upper()]
	if convert == nil then
		return GCHROMA_KEY_INVALID
	end
	return convert
end

function gchroma.ToVector( color )
	return Vector( color.r, color.g, color.b )
end
