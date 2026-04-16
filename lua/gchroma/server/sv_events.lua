util.AddNetworkString( "GChromaPlayerInit" )
hook.Add( "PlayerSpawn", "GChromaPlayerSpawn", function( ply )
	if gchroma then
		net.Start( "GChromaPlayerInit" )
		net.Send( ply )
	end
end )

local loadQueue = {}
hook.Add( "PlayerInitialSpawn", "GChromaPlayerInitSpawn", function( ply )
	loadQueue[ply] = true
end )

hook.Add( "StartCommand", "GChromaFullyLoaded", function( ply, cmd )
	if loadQueue[ply] and !cmd:IsForced() then
		if gchroma then
			net.Start( "GChromaPlayerInit" )
			net.Send( ply )
		end
		loadQueue[ply] = nil
	end
end )

hook.Add( "PostPlayerDeath", "GChromaPlayerDeath", function( ply )
	if gchroma then
		gchroma.SetDeviceColor( gchroma.DeviceType.All, color_red )
		gchroma.SendFunctions( ply )
	end
end )

util.AddNetworkString( "GChromaNoclip" )
hook.Add( "PlayerNoClip", "GChromaPlayerNoclip", function( ply, enable )
	--This hook is predicted so it needs to be run server-side in order to work in singleplayer
	if gchroma and IsFirstTimePredicted() then
		net.Start( "GChromaNoclip" )
		net.WriteBool( enable )
		net.Send( ply )
	end
end )

util.AddNetworkString( "GChromaFlashlight" )
hook.Add( "PlayerSwitchFlashlight", "GChromaFlashlight", function( ply, enabled )
	if gchroma then
		net.Start( "GChromaFlashlight" )
		net.WriteBool( enabled )
		net.Send( ply )
	end
end )

util.AddNetworkString( "GChromaUpdateSlots" )
hook.Add( "WeaponEquip", "GChromaPickupWeapon", function( weapon, ply )
	if gchroma and ply:IsPlayer() then
		timer.Simple( 0.1, function()
			net.Start( "GChromaUpdateSlots" )
			net.Send( ply )
		end )
	end
end )

hook.Add( "PlayerDroppedWeapon", "GChromaPickupWeapon", function( ply, weapon )
	if gchroma and ply:IsPlayer() then
		timer.Simple( 0.1, function()
			net.Start( "GChromaUpdateSlots" )
			net.Send( ply )
		end )
	end
end )
