if util.IsBinaryModuleInstalled( "gchroma" ) then
	require( "gchroma" )
else
	MsgC( Color( 255, 0, 0 ), "WARNING! GChroma binary module failed to load. Verify that you downloaded the correct version and that it's installed correctly." )
end

CreateClientConVar( "gchroma_ip", "127.0.0.1", true, false, "IP address of the OpenRGB server. Requires restart after changing." )
CreateClientConVar( "gchroma_port", 6742, true, false, "Port number of the OpenRGB server. Requires restart after changing." )

concommand.Add( "gchroma_test", function()
	if !gchroma.Loaded then return end
	local i = 1
	local colors = {
		color_red,
		color_green,
		color_blue
	}
	timer.Create( "GChroma_Init", 0.5, 4, function()
		if i == 4 then
			gchroma.SetDeviceColor( gchroma.DeviceType.All, color_black )
			return
		end
		gchroma.SetDeviceColor( gchroma.DeviceType.All, colors[i] )
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
	gchroma.SetDeviceColor( gchroma.DeviceType.All, color_darkgray )
	hook.Run( "GChromaInitialized" )
end )

net.Receive( "GChroma_SendFunctions", function()
	if !gchroma.Loaded then return end
	local tbl = net.ReadTable()
	for _,v in ipairs( tbl ) do
		if v[1] == gchroma.FuncType.DeviceColor then
			gchroma.SetDeviceColor( v[2], v[3] )
		elseif v[1] == gchroma.FuncType.LEDColor then
			gchroma.SetLEDColor( v[2], v[3], v[4] )
		end
	end
end )

--Utility functions
function gchroma.KeyConvert( key )
	if type( key ) == "string" then
		key = input.GetKeyCode( input.LookupBinding( key ) )
	end
	local convert = gchroma.Key[input.GetKeyName( key ):upper()]
	return convert or ""
end
