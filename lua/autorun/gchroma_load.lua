AddCSLuaFile()

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

for _,v in pairs( file.Find( "gchroma/*", "LUA" ) ) do
	include( "gchroma/"..v )
	AddCSLuaFile( "gchroma/"..v )
end

gchroma.Version = "2.1"

MsgC( color_red, "GC", color_green, "hro", color_blue, "ma", color_white, " v", gchroma.Version, " by OPGman successfully loaded.\n" )
