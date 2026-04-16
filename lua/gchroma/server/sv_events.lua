util.AddNetworkString( "GChromaPlayerInit" )
hook.Add( "PlayerSpawn", "GChromaPlayerSpawn", function( ply )
	net.Start( "GChromaPlayerInit" )
	net.Send( ply )
end )

hook.Add( "PostPlayerDeath", "GChromaPlayerDeath", function( ply )
	gchroma.SetDeviceColor( gchroma.DeviceType.All, color_red )
	gchroma.SendFunctions( ply )
end )

util.AddNetworkString( "GChromaNoclip" )
hook.Add( "PlayerNoClip", "GChromaPlayerNoclip", function( ply, enable )
	--This hook is predicted so it needs to be run server-side in order to work in singleplayer
	if IsFirstTimePredicted() then
		net.Start( "GChromaNoclip" )
		net.WriteBool( enable )
		net.Send( ply )
	end
end )

util.AddNetworkString( "GChromaFlashlight" )
hook.Add( "PlayerSwitchFlashlight", "GChromaFlashlight", function( ply, enabled )
	net.Start( "GChromaFlashlight" )
	net.WriteBool( enabled )
	net.Send( ply )
end )
