local function GChroma_Test()
	if GChroma_Loaded then
		local i = 1
		local chroma = GChroma_Start()
		timer.Create( "GChroma_Init", 0.5, 4, function()
			local colors = {
				GCHROMA_COLOR_RED,
				GCHROMA_COLOR_GREEN,
				GCHROMA_COLOR_BLUE
			}
			if i == 4 then
				GChroma_ResetDevice( chroma, GCHROMA_DEVICE_ALL )
				GChroma_CreateEffect( chroma )
				return
			end
			GChroma_SetDeviceColor( chroma, GCHROMA_DEVICE_ALL, colors[i] )
			GChroma_CreateEffect( chroma )
			i = i + 1
		end )
	end
end
concommand.Add( "gchroma_test", GChroma_Test )

local function GChroma_Init()
	if pcall( require, "gchroma" ) then --Make sure the client actually has the dll
		local chroma = GChroma_Start()
		GChroma_ResetDevice( chroma, GCHROMA_DEVICE_ALL ) --Doesn't do anything here but tell the SDK to wake up
		GChroma_CreateEffect( chroma )
		GChroma_Loaded = true
		MsgC( Color( 0, 255, 0 ), "\nGChroma client-side API loaded successfully.\n" )
	end
end
hook.Add( "InitPostEntity", "Chroma_Init", GChroma_Init )

local function SetDeviceColor()
	local device = net.ReadInt( 32 )
	local color = net.ReadVector()
	if GChroma_Loaded then
		local chroma = GChroma_Start()
		GChroma_SetDeviceColor( chroma, device, color )
		GChroma_CreateEffect( chroma )
	end
end
net.Receive( "GChroma_SetDeviceColor", SetDeviceColor )

local function SetDeviceColorEx()
	local device = net.ReadInt( 32 )
	local color = net.ReadVector()
	local row = net.ReadInt( 32 )
	local col = net.ReadInt( 32 )
	if GChroma_Loaded then
		local chroma = GChroma_Start()
		GChroma_SetDeviceColorEx( chroma, device, color, row, col )
		GChroma_CreateEffect( chroma )
	end
end
net.Receive( "GChroma_SetDeviceColorEx", SetDeviceColorEx )

local function ResetDevice()
	local device = net.ReadInt( 32 )
	if GChroma_Loaded then
		local chroma = GChroma_Start()
		GChroma_ResetDevice( chroma, device )
		GChroma_CreateEffect( chroma )
	end
end
net.Receive( "GChroma_ResetDevice", ResetDevice )

function GChroma_KeyConvert( key )
	local convert = _G["GCHROMA_KEY_"..input.GetKeyName( key ):upper()]
	if convert == nil then
		return GCHROMA_KEY_INVALID
	end
	return convert
end
