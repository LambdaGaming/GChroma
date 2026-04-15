AddCSLuaFile()

gchroma = { Version = "2.0", Pending = {} }

for _,v in pairs( file.Find( "gchroma/*", "LUA" ) ) do
	include( "gchroma/"..v )
	AddCSLuaFile( "gchroma/"..v )
end

for _,v in pairs( file.Find( "gchroma/client/*", "LUA" ) ) do
	AddCSLuaFile( "gchroma/client/"..v )
	if CLIENT then
		include( "gchroma/client/"..v )
	end
end

if SERVER then
	for _,v in pairs( file.Find( "gchroma/server/*", "LUA" ) ) do
		include( "gchroma/server/"..v )
	end
end

local r = Color( 255, 0, 0 )
local g = Color( 0, 255, 0 )
local b = Color( 0, 0, 255 )
MsgC( r, "GC", g, "hro", b, "ma", color_white, " v", gchroma.Version, " by OPGman successfully loaded.\n" )
