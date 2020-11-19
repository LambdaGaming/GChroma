#define GMMODULE

#include "Interface.h"
#include "chroma.h"

using namespace GarrysMod::Lua;
using namespace std;

/*
	GChroma_Start()
	Arguments: None
	Returns:
		UserData instance - Instance of the GChroma class created by the function
	Example: local chroma = GChroma_Start()
*/
LUA_FUNCTION( GChroma_Start )
{
	GChroma* instance;
	instance = new GChroma();
	auto init = instance->Initialize();
	LUA->PushUserType_Value( instance, Type::UserData );
	return 1;
}

/*
	GChroma_SetDeviceColor( UserData instance, Number device, Vector color )
	Arguments:
		instance - Instance of the GChroma class you want to use this function with, created with GChroma_Start()
		device - Device ID
		color - Lua RGB color table converted to a vector
	Returns: None
	Example: GChroma_SetDeviceColor( instance, GCHROMA_DEVICE_ALL, Vector( 0, 0, 255 ) )
*/
LUA_FUNCTION( GChroma_SetDeviceColor )
{
	LUA->CheckType( 1, Type::UserData );
	LUA->CheckType( 2, Type::Number );
	LUA->CheckType( 3, Type::Vector );
	GChroma* instance = LUA->GetUserType<GChroma>( 1, Type::UserData );
	int device = LUA->GetNumber( 2 );
	Vector color = LUA->GetVector( 3 );

	if ( instance->Initialized )
	{
		COLORREF convert = RGB( color.x, color.y, color.z );

		switch ( device )
		{
			case 0:
			{
				try
				{
					instance->SetMouseColor( convert );
					instance->SetKeyboardColor( convert );
					instance->SetMousepadColor( convert );
					instance->SetKeypadColor( convert );
					instance->SetHeadsetColor( convert );
				}
				catch ( exception e )
				{
					LUA->ThrowError( e.what() );
				}
				break;
			}
			case 1:
			{
				try
				{
					instance->SetKeyboardColor( convert );
				}
				catch ( exception e )
				{
					LUA->ThrowError( e.what() );
				}
				break;
			}
			case 2:
			{
				try
				{
					instance->SetMousepadColor( convert );
				}
				catch ( exception e )
				{
					LUA->ThrowError( e.what() );
				}
				break;
			}
			case 3:
			{
				try
				{
					instance->SetMouseColor( convert );
				}
				catch ( exception e )
				{
					LUA->ThrowError( e.what() );
				}
				break;
			}
			case 4:
			{
				try
				{
					instance->SetHeadsetColor( convert );
				}
				catch ( exception e )
				{
					LUA->ThrowError( e.what() );
				}
				break;
			}
			case 5:
			{
				try
				{
					instance->SetKeypadColor( convert );
				}
				catch ( exception e )
				{
					LUA->ThrowError( e.what() );
				}
				break;
			}
			default: break; // Don't do anything if a valid device wasn't input
		}
	}
	return 0;
}

/*
	GChroma_SetMouseColorEx( UserData instance, Number device, Vector color, Number row, Number col )
	Arguments:
		instance - Instance of the GChroma class you want to use this function with, created with GChroma_Start()
		device - Device ID
		color - Lua RGB color table converted to a vector
		row - LED profile row (https://developer.razer.com/works-with-chroma-v1/razer-chroma-led-profiles/)
		col - LED profile column
	Returns: None
	Example 1: GChroma_SetDeviceColorEx( instance, GCHROMA_DEVICE_MOUSE, Vector( 0, 0, 255 ), GCHROMA_MOUSE_SCROLLWHEEL, 0 ) --Sets the scroll wheel color to blue
	Example 2: GChroma_SetDeviceColorEx( instance, GCHROMA_DEVICE_KEYBOARD, Vector( 255, 0, 0 ), GCHROMA_KEY_W, 0 ) --Sets the W key color to red
	Example 3: GChroma_SetDeviceColorEx( instance, GCHROMA_DEVICE_MOUSEPAD, Vector( 0, 255, 0 ), 0, 0 ) --Sets the top left corner of the mousepad to green
*/
LUA_FUNCTION( GChroma_SetDeviceColorEx )
{
	LUA->CheckType( 1, Type::UserData );
	LUA->CheckType( 2, Type::Number );
	LUA->CheckType( 3, Type::Vector );
	LUA->CheckType( 4, Type::Number );
	LUA->CheckType( 5, Type::Number );
	GChroma* instance = LUA->GetUserType<GChroma>( 1, Type::UserData );
	int device = LUA->GetNumber( 2 );
	Vector color = LUA->GetVector( 3 );
	double row = LUA->GetNumber( 4 );
	double col = LUA->GetNumber( 5 );
	if ( instance->Initialized )
	{
		COLORREF convert = RGB( color.x, color.y, color.z );

		switch ( device )
		{
			case 1:
			{
				try
				{
					instance->SetKeyboardColorEx( row, convert );
				}
				catch ( exception e )
				{
					LUA->ThrowError( e.what() );
				}
				break;
			}
			case 2:
			{
				try
				{
					instance->SetMousepadColorEx( convert, row );
				}
				catch ( exception e )
				{
					LUA->ThrowError( e.what() );
				}
				break;
			}
			case 3:
			{
				try
				{
					instance->SetMouseColorEx( row, convert );
				}
				catch ( exception e )
				{
					LUA->ThrowError( e.what() );
				}
				break;
			}
			case 4:
			{
				try
				{
					instance->SetHeadsetColorEx( convert, row );
				}
				catch ( exception e )
				{
					LUA->ThrowError( e.what() );
				}
				break;
			}
			case 5:
			{
				try
				{
					instance->SetKeypadColorEx( convert, row, col );
				}
				catch ( exception e )
				{
					LUA->ThrowError( e.what() );
				}
				break;
			}
			default: break;
		}
	}
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
	LUA->CheckType( 1, Type::UserData );
	LUA->CheckType( 2, Type::Number );
	GChroma* instance = LUA->GetUserType<GChroma>( 1, Type::UserData );;
	int device = LUA->GetNumber( 2 );
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
	GChroma_CreateEffect( UserData instance, Bool key )
	Arguments:
		instance - Instance of the GChroma class you want to use this function with, created with GChroma_Start()
		key - Optional. Set to true if your effect edits keyboard keys with enums.
	Returns: None
	Example: GChroma_CreateEffect( chroma )
*/
LUA_FUNCTION( GChroma_CreateEffect )
{
	LUA->CheckType( 1, Type::UserData );
	GChroma* instance = LUA->GetUserType<GChroma>( 1, Type::UserData );
	bool key;

	if ( LUA->IsType( 2, Type::Bool ) )
	{
		key = LUA->GetBool( 2 );
	}
	else
	{
		key = false;
	}

	try
	{
		instance->PushColors( key );
	}
	catch ( std::exception e )
	{
		LUA->ThrowError( e.what() );
	}
	return 0;
}

GMOD_MODULE_OPEN()
{
	LUA->PushSpecial( SPECIAL_GLOB );
		LUA->PushCFunction( GChroma_Start );
		LUA->SetField( -2, "GChroma_Start" );
		LUA->PushCFunction( GChroma_SetDeviceColor );
		LUA->SetField( -2, "GChroma_SetDeviceColor" );
		LUA->PushCFunction( GChroma_SetDeviceColorEx );
		LUA->SetField( -2, "GChroma_SetDeviceColorEx" );
		LUA->PushCFunction( GChroma_ResetDevice );
		LUA->SetField( -2, "GChroma_ResetDevice" );
		LUA->PushCFunction( GChroma_CreateEffect );
		LUA->SetField( -2, "GChroma_CreateEffect" );
	LUA->Pop();
	return 0;
}

GMOD_MODULE_CLOSE()
{
	return 0;
}
