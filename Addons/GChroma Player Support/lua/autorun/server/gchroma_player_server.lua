GChroma_PlayerModule_Loaded = true

util.AddNetworkString( "GChromaPlayerInit" )
local function GChromaPlayerSpawn( ply )
	if GChroma_Loaded then
		net.Start( "GChromaPlayerInit" )
		net.Send( ply )
	end
end
hook.Add( "PlayerSpawn", "GChromaPlayerSpawn", GChromaPlayerSpawn )

local function GChromaPlayerDeath( ply )
	if GChroma_Loaded then
		GChroma_ResetDevice( ply, GCHROMA_DEVICE_ALL )
		GChroma_SetDeviceColor( ply, GCHROMA_DEVICE_ALL, GCHROMA_COLOR_RED )
	end
end
hook.Add( "PostPlayerDeath", "GChromaPlayerDeath", GChromaPlayerDeath )

util.AddNetworkString( "GChromaNoclip" )
local function GChromaPlayerNoclip( ply, enable )
	if GChroma_Loaded and IsFirstTimePredicted() then --This hook is predicted so it needs to be run server-side in order to work in singleplayer
		net.Start( "GChromaNoclip" )
		net.WriteBool( enable )
		net.Send( ply )
	end
end
hook.Add( "PlayerNoClip", "GChromaPlayerNoclip", GChromaPlayerNoclip )

util.AddNetworkString( "GChromaFlashlight" )
local function GChromaFlashlight( ply, enabled )
	if GChroma_Loaded then
		net.Start( "GChromaFlashlight" )
		net.WriteBool( enabled )
		net.Send( ply )
	end
end
hook.Add( "PlayerSwitchFlashlight", "GChromaFlashlight", GChromaFlashlight )
