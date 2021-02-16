#define GMMODULE

#include "Interface.h"
#include "chroma.h"

using namespace GarrysMod::Lua;
using namespace std;

GChroma* instance;
int GChromaTable;

void GChromaInit()
{
	instance = new GChroma();
	instance->Initialize();
}

/*
	gchroma.SetDeviceColor( Number device, Vector color )
	Arguments:
		device - Device ID
		color - Lua RGB color table converted to a vector
	Returns: None
	Example: gchroma.SetDeviceColor( GCHROMA_DEVICE_ALL, Vector( 0, 0, 255 ) )
*/
LUA_FUNCTION( GChroma_SetDeviceColor )
{
	LUA->CheckType( 1, Type::Number );
	LUA->CheckType( 2, Type::Vector );
	int device = LUA->GetNumber( 1 );
	const auto& color = LUA->GetVector( 2 );

	if ( instance->Initialized )
	{
		COLORREF convert = RGB( color.x, color.y, color.z );

		try
		{
			switch ( device )
			{
				case 0:
					instance->SetMouseColor( convert );
					instance->SetKeyboardColor( convert );
					instance->SetMousepadColor( convert );
					instance->SetKeypadColor( convert );
					instance->SetHeadsetColor( convert );
					instance->SetLinkColor( convert );
					break;
				case 1:
					instance->SetKeyboardColor( convert );
					break;
				case 2:
					instance->SetMousepadColor( convert );
					break;
				case 3:
					instance->SetMouseColor( convert );
					break;
				case 4:
					instance->SetHeadsetColor( convert );
					break;
				case 5:
					instance->SetKeypadColor( convert );
					break;
				case 6:
					instance->SetLinkColor( convert );
					break;
				default: break; // Don't do anything if a valid device wasn't input
			}
		}
		catch ( exception e )
		{
			LUA->ThrowError( e.what() );
		}
	}
	return 0;
}

/*
	gchroma.SetMouseColorEx( Number device, Vector color, Number row, Number col )
	Arguments:
		device - Device ID
		color - Lua RGB color table converted to a vector
		row - LED profile row (https://developer.razer.com/works-with-chroma-v1/razer-chroma-led-profiles/)
		col - LED profile column
	Returns: None
	Example 1: gchroma.SetDeviceColorEx( GCHROMA_DEVICE_MOUSE, Vector( 0, 0, 255 ), GCHROMA_MOUSE_SCROLLWHEEL, 0 ) --Sets the scroll wheel color to blue
	Example 2: gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, Vector( 255, 0, 0 ), GCHROMA_KEY_W, 0 ) --Sets the W key color to red
	Example 3: gchroma.SetDeviceColorEx( GCHROMA_DEVICE_MOUSEPAD, Vector( 0, 255, 0 ), 0, 0 ) --Sets the top left corner of the mousepad to green
*/
LUA_FUNCTION( GChroma_SetDeviceColorEx )
{
	LUA->CheckType( 1, Type::Number );
	LUA->CheckType( 2, Type::Vector );
	LUA->CheckType( 3, Type::Number );
	LUA->CheckType( 4, Type::Number );
	int device = LUA->GetNumber( 1 );
	const auto& color = LUA->GetVector( 2 );
	auto row = LUA->GetNumber( 3 );
	auto col = LUA->GetNumber( 4 );
	if ( instance->Initialized )
	{
		COLORREF convert = RGB( color.x, color.y, color.z );

		try
		{
			switch ( device )
			{
				case 1:
					instance->SetKeyboardColorEx( row, convert );
					break;
				case 2:
					instance->SetMousepadColorEx( convert, row );
					break;
				case 3:
					instance->SetMouseColorEx( row, convert );
					break;
				case 4:
					instance->SetHeadsetColorEx( convert, row );
					break;
				case 5:
					instance->SetKeypadColorEx( convert, row, col );
					break;
				case 6:
					instance->SetLinkColor( convert );
					break;
				default: break;
			}
		}
		catch ( exception e )
		{
			LUA->ThrowError( e.what() );
		}
		
	}
	return 0;
}

/*
	gchroma.ResetDevice( Number device )
	Arguments:
		device - Device ID
	Returns: None
*/
LUA_FUNCTION( GChroma_ResetDevice )
{
	LUA->CheckType( 1, Type::Number );
	int device = LUA->GetNumber( 1 );
	if ( instance->Initialized )
	{
		if ( device >= 0 && device <= 5 )
		{
			instance->ResetEffects( device );
		}
		else
		{
			LUA->ThrowError( "ResetDevice failed. The device number you entered does not exist." );
		}
	}
	return 0;
}

/*
	gchroma.CreateEffect( Bool key )
	Arguments:
		key - Optional. Set to true if your effect edits keyboard keys with enums.
	Returns: None
	Example: gchroma.CreateEffect( true )
*/
LUA_FUNCTION( GChroma_CreateEffect )
{
	try
	{
		instance->PushColors();
	}
	catch ( std::exception e )
	{
		LUA->ThrowError( e.what() );
	}
	return 0;
}

GMOD_MODULE_OPEN()
{
	GChromaInit();
	LUA->PushSpecial( SPECIAL_GLOB );
		LUA->CreateTable();
			LUA->PushCFunction( GChroma_SetDeviceColor );
			LUA->SetField( -2, "SetDeviceColor" );
			LUA->PushCFunction( GChroma_SetDeviceColorEx );
			LUA->SetField( -2, "SetDeviceColorEx" );
			LUA->PushCFunction( GChroma_ResetDevice );
			LUA->SetField( -2, "ResetDevice" );
			LUA->PushCFunction( GChroma_CreateEffect );
			LUA->SetField( -2, "CreateEffect" );
		LUA->SetField( -2, "gchroma" );
	LUA->Pop();
	return 0;
}

GMOD_MODULE_CLOSE()
{
	return 0;
}
