#define GMMODULE

#include "Interface.h"
#include "chroma.h"

using namespace GarrysMod::Lua;

/*
	GChroma_SetDeviceColor( Number device, Vector color )
	Arguments:
		device - Device ID
		color - Lua RGB color table converted to a vector
	Returns: None
	Example: GChroma_SetDeviceColor( GCHROMA_DEVICE_ALL, Vector( 0, 0, 255 ) )
*/
LUA_FUNCTION( GChroma_SetDeviceColor )
{
	GChroma* chromainit;
	chromainit = new GChroma();
	auto init = chromainit->Initialize();
	LUA->CheckType( 1, GarrysMod::Lua::Type::Number );
	LUA->CheckType( 2, GarrysMod::Lua::Type::Vector );
	int device = LUA->GetNumber( 1 );
	Vector color = LUA->GetVector( 2 );
	if ( init )
	{
		COLORREF convert = RGB( color.x, color.y, color.z );

		switch ( device )
		{
			case 0:
			{
				auto mouse = chromainit->SetMouseColor( convert );
				auto keyboard = chromainit->SetKeyboardColor( convert );
				//auto mousepad = chromainit->SetMousepadColor( convert );
				//auto keypad = chromainit->SetKeypadColor( convert );
				//auto headset = chromainit->SetHeadsetColor( convert );
				break;
			}
			case 1:
			{
				auto mouse = chromainit->SetMouseColor( convert );
				break;
			}
			case 2:
			{
				auto keyboard = chromainit->SetKeyboardColor( convert );
				break;
			}
			case 3:
			{
				// TODO: Mousepad support
				//auto mousepad = chromainit->SetMousepadColor( convert );
				break;
			}
			case 4:
			{
				// TODO: Keypad support
				//auto keypad = chromainit->SetKeypadColor( convert );
				break;
			}
			case 5:
			{
				// TODO: Headset support
				//auto headset = chromainit->SetHeadsetColor( convert );
				break;
			}
			default: break; // Don't do anything if a valid device wasn't input
		}
	}
	delete chromainit;
	return 0;
}

/*
	GChroma_SetMouseColorEx( Number device, Vector color, Number row, Number col )
	Arguments:
		color - Lua RGB color table converted to a vector
		row - LED profile row (https://developer.razer.com/works-with-chroma-v1/razer-chroma-led-profiles/)
		col - LED profile column
	Returns: None
	Example: GChroma_SetDeviceColorEx( GCHROMA_DEVICE_MOUSE, Vector( 0, 0, 255 ), 2, 3 ) // Sets the scroll wheel color to blue
*/
LUA_FUNCTION( GChroma_SetDeviceColorEx )
{
	GChroma* chromainit;
	chromainit = new GChroma();
	auto init = chromainit->Initialize();
	LUA->CheckType( 1, GarrysMod::Lua::Type::Number );
	LUA->CheckType( 2, GarrysMod::Lua::Type::Vector );
	LUA->CheckType( 3, GarrysMod::Lua::Type::Number );
	LUA->CheckType( 4, GarrysMod::Lua::Type::Number );
	int device = LUA->GetNumber( 1 );
	Vector color = LUA->GetVector( 2 );
	double row = LUA->GetNumber( 3 );
	double col = LUA->GetNumber( 4 );
	if ( init )
	{
		COLORREF convert = RGB( color.x, color.y, color.z );

		switch ( device )
		{
			case 1:
			{
				auto mouse = chromainit->SetMouseColorEx( convert, row, col );
				break;
			}
			case 2:
			{
				auto keyboard = chromainit->SetKeyboardColorEx( convert, row, col );
				break;
			}
			case 3:
			{
				// TODO: Mousepad support
				//auto mousepad = chromainit->SetMousepadColorEx( convert, row, col );
				break;
			}
			case 4:
			{
				// TODO: Keypad support
				//auto keypad = chromainit->SetKeypadColorEx( convert, row, col );
				break;
			}
			case 5:
			{
				// TODO: Headset support
				//auto headset = chromainit->SetHeadsetColorEx( convert, row, col );
				break;
			}
			default: break;
		}
	}
	delete chromainit;
	return 0;
}

/*
	GChroma_ResetAll()
	Arguments: None
	Returns: None
*/
LUA_FUNCTION( GChroma_ResetAll )
{
	GChroma* chromainit;
	chromainit = new GChroma();
	auto init = chromainit->Initialize();
	if ( init )
	{
		chromainit->ResetEffects( ALL_DEVICES );
	}
	delete chromainit;
	return 0;
}

GMOD_MODULE_OPEN()
{
	LUA->PushSpecial( GarrysMod::Lua::SPECIAL_GLOB );
		LUA->PushCFunction( GChroma_SetDeviceColor );
		LUA->SetField( -2, "GChroma_SetDeviceColor" );
	LUA->Pop();

	LUA->PushSpecial( GarrysMod::Lua::SPECIAL_GLOB );
		LUA->PushCFunction( GChroma_SetDeviceColorEx );
		LUA->SetField( -2, "GChroma_SetDeviceColorEx" );
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
