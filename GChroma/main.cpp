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
				chromainit->SetMouseColor( convert );
				chromainit->SetKeyboardColor( convert );
				chromainit->SetMousepadColor( convert );
				chromainit->SetKeypadColor( convert );
				chromainit->SetHeadsetColor( convert );
				break;
			}
			case 1:
			{
				chromainit->SetKeyboardColor( convert );
				break;
			}
			case 2:
			{
				chromainit->SetMousepadColor( convert );
				break;
			}
			case 3:
			{
				chromainit->SetMouseColor( convert );
				break;
			}
			case 4:
			{
				chromainit->SetHeadsetColor( convert );
				break;
			}
			case 5:
			{
				chromainit->SetKeypadColor( convert );
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
		device - Device ID
		color - Lua RGB color table converted to a vector
		row - LED profile row (https://developer.razer.com/works-with-chroma-v1/razer-chroma-led-profiles/)
		col - LED profile column
	Returns: None
	Example 1: GChroma_SetDeviceColorEx( GCHROMA_DEVICE_MOUSE, Vector( 0, 0, 255 ), GCHROMA_MOUSE_SCROLLWHEEL, 0 ) --Sets the scroll wheel color to blue
	Example 2: GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, Vector( 255, 0, 0 ), GCHROMA_KEY_W, 0 ) --Sets the W key color to red
	Example 3: GChroma_SetDeviceColorEx( GCHROMA_DEVICE_MOUSEPAD, Vector( 0, 255, 0 ), 0, 0 ) --Sets the top left corner of the mousepad to green
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
				chromainit->SetKeyboardColorEx( row, convert );
				break;
			}
			case 2:
			{
				chromainit->SetMousepadColorEx( convert, row );
				break;
			}
			case 3:
			{
				chromainit->SetMouseColorEx( row, convert );
				break;
			}
			case 4:
			{
				chromainit->SetHeadsetColorEx( convert, row );
				break;
			}
			case 5:
			{
				chromainit->SetKeypadColorEx( convert, row, col );
				break;
			}
			default: break;
		}
	}
	delete chromainit;
	return 0;
}

/*
	GChroma_ResetDevice( Number device )
	Arguments:
		device - Device ID
	Returns: None
*/
LUA_FUNCTION( GChroma_ResetDevice )
{
	GChroma* chromainit;
	chromainit = new GChroma();
	auto init = chromainit->Initialize();
	LUA->CheckType( 1, GarrysMod::Lua::Type::Number );
	int device = LUA->GetNumber( 1 );
	if ( init && device >= 0 && device <= 5 )
	{
		chromainit->ResetEffects( device );
	}
	delete chromainit;
	return 0;
}

GMOD_MODULE_OPEN()
{
	LUA->PushSpecial( GarrysMod::Lua::SPECIAL_GLOB );
		LUA->PushCFunction( GChroma_SetDeviceColor );
		LUA->SetField( -2, "GChroma_SetDeviceColor" );
		LUA->PushCFunction( GChroma_SetDeviceColorEx );
		LUA->SetField( -2, "GChroma_SetDeviceColorEx" );
		LUA->PushCFunction( GChroma_ResetDevice );
		LUA->SetField( -2, "GChroma_ResetDevice" );
	LUA->Pop();
	return 0;
}

GMOD_MODULE_CLOSE()
{
	return 0;
}
