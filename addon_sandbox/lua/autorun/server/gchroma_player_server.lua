GChroma_PlayerModuleLoaded = true

util.AddNetworkString( "GChromaPlayerInit" )
local function GChromaPlayerSpawn( ply )
	if gchroma then
		net.Start( "GChromaPlayerInit" )
		net.WriteBool( false )
		net.Send( ply )
	end
end
hook.Add( "PlayerSpawn", "GChromaPlayerSpawn", GChromaPlayerSpawn )

local function GChromaPlayerInitSpawn( ply )
	hook.Add( "SetupMove", ply, function( self, ply, _, cmd )
		if self == ply and !cmd:IsForced() then
			hook.Run( "PlayerFullLoad", self )
			hook.Remove( "SetupMove", self )
		end
	end )
end
hook.Add( "PlayerInitialSpawn", "GChromaPlayerInitSpawn", GChromaPlayerInitSpawn )

local function GChromaFullyLoaded( ply )
	if gchroma then
		net.Start( "GChromaPlayerInit" )
		net.WriteBool( true )
		net.Send( ply )
	end
end
hook.Add( "PlayerFullLoad", "GChromaFullyLoaded", GChromaFullyLoaded )

local function GChromaPlayerDeath( ply )
	if gchroma then
		gchroma.ResetDevice( GCHROMA_DEVICE_ALL )
		gchroma.SetDeviceColor( GCHROMA_DEVICE_ALL, GCHROMA_COLOR_RED )
		gchroma.SendFunctions( ply )
	end
end
hook.Add( "PostPlayerDeath", "GChromaPlayerDeath", GChromaPlayerDeath )

util.AddNetworkString( "GChromaNoclip" )
local function GChromaPlayerNoclip( ply, enable )
	if gchroma and IsFirstTimePredicted() then --This hook is predicted so it needs to be run server-side in order to work in singleplayer
		net.Start( "GChromaNoclip" )
		net.WriteBool( enable )
		net.Send( ply )
	end
end
hook.Add( "PlayerNoClip", "GChromaPlayerNoclip", GChromaPlayerNoclip )

util.AddNetworkString( "GChromaFlashlight" )
local function GChromaFlashlight( ply, enabled )
	if gchroma then
		net.Start( "GChromaFlashlight" )
		net.WriteBool( enabled )
		net.Send( ply )
	end
end
hook.Add( "PlayerSwitchFlashlight", "GChromaFlashlight", GChromaFlashlight )

util.AddNetworkString( "GChromaUpdateSlots" )
local function GChromaPickupWeapon( weapon, ply )
	if gchroma and ply:IsPlayer() then
		timer.Simple( 0.1, function()
			net.Start( "GChromaUpdateSlots" )
			net.Send( ply )
		end )
	end
end
hook.Add( "WeaponEquip", "GChromaPickupWeapon", GChromaPickupWeapon )

local function GChromaDropWeapon( ply, weapon )
	if gchroma and ply:IsPlayer() then
		timer.Simple( 0.1, function()
			net.Start( "GChromaUpdateSlots" )
			net.Send( ply )
		end )
	end
end
hook.Add( "PlayerDroppedWeapon", "GChromaPickupWeapon", GChromaPickupWeapon )
