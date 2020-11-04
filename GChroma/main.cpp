#define GMMODULE

#include "Interface.h"
#include "chroma.h"

using namespace GarrysMod::Lua;

/*
	GChroma_SetMouseColor( Vector color )
	Arguments:
		color - Lua RGB color table converted to a vector
	Returns: Boolean success
	Example: GChroma_SetMouseColor( Vector( 0, 0, 255 ) )
*/
LUA_FUNCTION( GChroma_SetMouseColor )
{
	GChroma* chromainit;
	chromainit = new GChroma();
	auto init = chromainit->Initialize();
	LUA->CheckType( 1, GarrysMod::Lua::Type::Vector );
	Vector color = LUA->GetVector( 1 );
	if ( init )
	{
		COLORREF convert = RGB( color.x, color.y, color.z );
		auto mouse = chromainit->SetMouseColor( convert );
		delete chromainit;
		LUA->PushBool( mouse );
		return 1;
	}
	else
	{
		delete chromainit;
		LUA->PushBool( false );
		return 1;
	}
	delete chromainit;
	LUA->PushBool( true );
	return 1;
}

/*
	GChroma_SetMouseColorEx( Vector color, Number row, Number col )
	Arguments:
		color - Lua RGB color table converted to a vector
		row - LED profile row (https://developer.razer.com/works-with-chroma-v1/razer-chroma-led-profiles/)
		col - LED profile column
	Returns: Boolean success
	Example: GChroma_SetMouseColorEx( Vector( 0, 0, 255 ), 2, 3 ) // Sets the scroll wheel color to blue
*/
LUA_FUNCTION( GChroma_SetMouseColorEx )
{
	GChroma* chromainit;
	chromainit = new GChroma();
	auto init = chromainit->Initialize();
	LUA->CheckType( 1, GarrysMod::Lua::Type::Vector );
	LUA->CheckType( 2, GarrysMod::Lua::Type::Number );
	LUA->CheckType( 3, GarrysMod::Lua::Type::Number );
	Vector color = LUA->GetVector( 1 );
	double row = LUA->GetNumber( 2 );
	double col = LUA->GetNumber( 3 );
	if ( init )
	{
		COLORREF convert = RGB( color.x, color.y, color.z );
		auto mouse = chromainit->SetMouseColorEx( convert, row, col );
		delete chromainit;
		LUA->PushBool( mouse );
		return 1;
	}
	else
	{
		delete chromainit;
		LUA->PushBool( false );
		return 1;
	}
	delete chromainit;
	LUA->PushBool( true );
	return 1;
}

/*
	GChroma_ResetAll()
	Arguments: None
	Returns: Boolean success
*/
LUA_FUNCTION( GChroma_ResetAll )
{
	GChroma* chromainit;
	chromainit = new GChroma();
	auto init = chromainit->Initialize();
	if ( init )
	{
		chromainit->ResetEffects( ALL_DEVICES );
		delete chromainit;
		LUA->PushBool( true );
		return 1;
	}
	delete chromainit;
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
		LUA->PushCFunction( GChroma_SetMouseColorEx );
		LUA->SetField( -2, "GChroma_SetMouseColorEx" );
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
