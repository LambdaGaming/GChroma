#define GMMODULE

#include "Interface.h"
#include "chroma.h"

using namespace GarrysMod::Lua;

GChroma* chromainit;
auto init = chromainit->Initialize();

/*
	GChroma_SetMouseColor( Vector color )
	Arguments:
		color - Lua RGB color table converted to a vector
	Returns: boolean success
	Example: GChroma_SetMouseColor( Color( 0, 0, 255 ):ToVector() )
*/
LUA_FUNCTION( GChroma_SetMouseColor )
{
	LUA->CheckType( 1, GarrysMod::Lua::Type::Vector );
	Vector color = LUA->GetVector( 1 );
	if ( init )
	{
		COLORREF convert = RGB( color.x, color.y, color.z );
		auto mouse = chromainit->SetMouseColor( convert );
		LUA->PushBool( mouse );
		return 1;
	}
	else
	{
		LUA->PushBool( false );
		return 1;
	}
	LUA->PushBool( true );
	return 1;
}

/*
	GChroma_ResetAll()
	Arguments: None
	Returns: boolean success
*/
LUA_FUNCTION( GChroma_ResetAll )
{
	if ( init )
	{
		chromainit->ResetEffects( ALL_DEVICES );
		LUA->PushBool( true );
		return 1;
	}
	LUA->PushBool( false );
	return 1;
}

GMOD_MODULE_OPEN()
{
	LUA->PushSpecial( GarrysMod::Lua::SPECIAL_GLOB );
		LUA->PushCFunction( GChroma_SetMouseColor );
		LUA->SetField( -2, "GChroma_SetMouseColor" );
	LUA->Pop();

	LUA->PushSpecial( GarrysMod::Lua::SPECIAL_GLOB );
		LUA->PushCFunction( GChroma_ResetAll );
		LUA->SetField( -2, "GChroma_ResetAll" );
	LUA->Pop();
	return 0;
}

GMOD_MODULE_CLOSE()
{
	return 0;
}
