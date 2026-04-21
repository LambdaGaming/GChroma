if util.IsBinaryModuleInstalled( "gchroma" ) then
	require( "gchroma" )
end

CreateClientConVar( "gchroma_ip", "127.0.0.1", true, false, "IP address of the OpenRGB server. Requires restart after changing." )
CreateClientConVar( "gchroma_port", 6742, true, false, "Port number of the OpenRGB server. Requires restart after changing." )

concommand.Add( "gchroma_test", function()
	if !gchroma.Ready() then return end
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

concommand.Add( "gchroma_reconnect", function()
	if gchroma.Ready() then
		print( "[GChroma] Already connected to a server!" )
		return
	end
	if !gchroma.Loaded then
		print( "[GChroma] Reconnect failed. The binary module was never initialized." )
		return
	end
	local ip = cvars.String( "gchroma_ip" )
	local port = cvars.Number( "gchroma_port" )
	local success = gchroma.Connect( ip, port )
	if success then
		gchroma.SetDeviceColor( gchroma.DeviceType.All, color_darkgray )
		hook.Run( "GChroma_OnInitialized" )
	end
end )

hook.Add( "InitPostEntity", "Chroma_Init", function()
	if !gchroma.Loaded then
		MsgC( color_red, "WARNING! GChroma failed to initialize. Make sure the binary module is up to date and properly installed.\n" )
		return
	end
	if gchroma.BinaryVersion != gchroma.Version then
		MsgC( color_red, "WARNING! The GChroma binary module is out of date. Please update to the latest version to avoid bugs and/or crashes.\n" )
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
	if !gchroma.Ready() then return end
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

function gchroma.Ready()
	return gchroma.Loaded and gchroma.IsConnected and gchroma.IsConnected()
end
