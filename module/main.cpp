#include "GarrysMod/Lua/Interface.h"
#include "OpenRGB/Client.hpp"

#ifdef linux
#include <cstring>
#endif

#define GMMODULE
#define PRINT( STRING ) \
	LUA->PushSpecial( SPECIAL_GLOB ); \
	LUA->GetField( -1, "print" ); \
	LUA->PushString( STRING ); \
	LUA->Call( 1, 0 ); \
	LUA->Pop();

using namespace GarrysMod::Lua;
using namespace orgb;
using namespace std;

Client* client;

Color ColorConvert( ILuaBase* LUA, int stackPos )
{
	LUA->PushNil();
	Color color = Color::White;
	while ( LUA->Next( stackPos ) != 0 )
	{
		// The keys can be out of order so I'm checking them this way as a fail safe
		auto key = LUA->GetString( -2 );
		auto value = LUA->GetNumber( -1 );
		if ( strcmp( key, "r" ) == 0 )
			color.r = value;
		else if ( strcmp( key, "g" ) == 0 )
			color.g = value;
		else if ( strcmp( key, "b" ) == 0 )
			color.b = value;
		LUA->Pop( 1 );
	}
	return color;
}

LUA_FUNCTION( GChroma_Connect )
{
	LUA->CheckType( 1, Type::String );
	LUA->CheckType( 2, Type::Number );
	auto ip = LUA->GetString( 1 );
	auto port = LUA->GetNumber( 2 );

	if ( client != nullptr )
	{
		PRINT( "[GChroma] The client has already been initialized!" );
		LUA->PushBool( false );
		return 1;
	}

	client = new Client( "GChroma Client" );
	ConnectStatus status = client->connect( ip, port );
	if ( status != ConnectStatus::Success )
	{
		PRINT( "[GChroma] Error connecting to the server." );
		LUA->PushBool( false );
		return 1;
	}

	DeviceListResult list = client->requestDeviceList();
	if ( list.status != RequestStatus::Success )
	{
		PRINT( "[GChroma] Error fetching device list." );
		LUA->PushBool( false );
		return 1;
	}
	for ( Device& device : list.devices )
	{
		const Mode* direct = device.findMode( "Direct" );
		if ( direct )
			client->changeMode( device, *direct );
	}
	PRINT( "[GChroma] Successfully established connection and initialized devices." );
	LUA->PushBool( true );
	return 1;
}

LUA_FUNCTION( GChroma_IsConnected )
{
	bool connected = client != nullptr && client->isConnected();
	LUA->PushBool( connected );
	return 1;
}

LUA_FUNCTION( GChroma_SetDeviceColor )
{
	LUA->CheckType( 1, Type::Number );
	LUA->CheckType( 2, Type::Table );
	int type = ( int ) LUA->GetNumber( 1 );
	
	DeviceListResult list = client->requestDeviceList();
	if ( list.status != RequestStatus::Success )
	{
		PRINT( "[GChroma] Error fetching device list." );
		LUA->PushBool( false );
		return 1;
	}

	if ( type == -1 )
	{
		bool success = true;
		for ( const Device& device : list.devices )
		{
			RequestStatus status = client->setDeviceColor( device, ColorConvert( LUA, 2 ) );
			success = status == RequestStatus::Success;
		}
		LUA->PushBool( success );
	}
	else
	{
		DeviceType realType = static_cast<DeviceType>( type );
		const Device* device = list.devices.find( realType );
		if ( device == nullptr )
		{
			PRINT( "[GChroma] Device doesn't exist." );
			LUA->PushBool( false );
			return 1;
		}
		RequestStatus status = client->setDeviceColor( *device, ColorConvert( LUA, 2 ) );
		LUA->PushBool( status == RequestStatus::Success );
	}
	return 1;
}

LUA_FUNCTION( GChroma_SetLEDColor )
{
	LUA->CheckType( 1, Type::Number );
	LUA->CheckType( 2, Type::String );
	LUA->CheckType( 3, Type::Table );
	int type = ( int ) LUA->GetNumber( 1 );
	auto name = LUA->GetString( 2 );

	DeviceListResult list = client->requestDeviceList();
	if ( list.status != RequestStatus::Success )
	{
		PRINT( "[GChroma] Error fetching device list." );
		LUA->PushBool( false );
		return 1;
	}

	DeviceType realType = static_cast<DeviceType>( type );
	const Device* device = list.devices.find( realType );
	const LED* led = device->findLED( name );
	if ( device == nullptr || led == nullptr )
	{
		PRINT( "[GChroma] Device or LED doesn't exist." );
		LUA->PushBool( false );
		return 1;
	}

	RequestStatus status = client->setLEDColor( *led, ColorConvert( LUA, 3 ) );
	LUA->PushBool( status == RequestStatus::Success );
	return 1;
}

LUA_FUNCTION( GChroma_GetDeviceInfo )
{
	LUA->CheckType( 1, Type::Number );
	int type = ( int ) LUA->GetNumber( 1 );

	DeviceListResult list = client->requestDeviceList();
	if ( list.status != RequestStatus::Success )
	{
		PRINT( "[GChroma] Error fetching device list." );
		LUA->PushNil();
		return 1;
	}

	DeviceType realType = static_cast<DeviceType>( type );
	const Device* device = list.devices.find( realType );
	if ( device == nullptr )
	{
		PRINT( "[GChroma] Device doesn't exist." );
		LUA->PushBool( false );
		return 1;
	}

	LUA->CreateTable();
	LUA->PushString( device->name.c_str() );
	LUA->SetField( -2, "name" );
	LUA->PushString( device->description.c_str() );
	LUA->SetField( -2, "description" );
	LUA->PushNumber( ( int ) device->type );
	LUA->SetField( -2, "type" );
	LUA->CreateTable();
	for ( const LED& led : device->leds )
	{
		LUA->CreateTable();
		LUA->PushNumber( led.idx );
		LUA->SetField( -2, "index" );
		LUA->PushNumber( led.value );
		LUA->SetField( -2, "value" );
		LUA->SetField( -2, led.name.c_str() );
	}
	LUA->SetField( -2, "leds" );
	return 1;
}

GMOD_MODULE_OPEN()
{
	LUA->PushSpecial( SPECIAL_GLOB );
		LUA->CreateTable();
			LUA->PushCFunction( GChroma_Connect );
			LUA->SetField( -2, "Connect" );
			LUA->PushCFunction( GChroma_IsConnected );
			LUA->SetField( -2, "IsConnected" );
			LUA->PushCFunction( GChroma_SetDeviceColor );
			LUA->SetField( -2, "SetDeviceColor" );
			LUA->PushCFunction( GChroma_SetLEDColor );
			LUA->SetField( -2, "SetLEDColor" );
			LUA->PushCFunction( GChroma_GetDeviceInfo );
			LUA->SetField( -2, "GetDeviceInfo" );
			LUA->PushBool( true );
			LUA->SetField( -2, "Loaded" );
			LUA->PushString( "2.0" );
			LUA->SetField( -2, "BinaryVersion" );
		LUA->SetField( -2, "gchroma" );
	LUA->Pop();
	return 0;
}

GMOD_MODULE_CLOSE()
{
	client->loadProfile( "Default" );
	client->disconnect();
	delete client;
	return 0;
}
