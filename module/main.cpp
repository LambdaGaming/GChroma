#include "GarrysMod/Lua/Interface.h"
#include "OpenRGB-cppSDK/include/OpenRGB/Client.hpp"

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

/*
	gchroma.Connect( String name, String ip, Number port )
	Description:
		Initializes a new connection to the specified OpenRGB server
	Arguments:
		name - Name of the client; can be anything
		ip - IP address or domain name of the OpenRGB server (typically 127.0.0.1)
		port - Optional port number for the server; defaults to 6742
	Returns: Bool success
*/
LUA_FUNCTION( GChroma_Connect )
{
	LUA->CheckType( 1, Type::String );
	LUA->CheckType( 2, Type::String );
	auto name = LUA->GetString( 1 );
	auto ip = LUA->GetString( 2 );
	auto port = LUA->GetNumber( 3 );

	if ( client != nullptr )
	{
		PRINT( "[GChroma] The client has already been initialized!" );
		LUA->PushBool( false );
		return 1;
	}

	client = new Client( name );
	ConnectStatus status = client->connect( ip, port > 0 && port || 6742 );
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
		if ( !direct )
			continue;
		client->changeMode( device, *direct );
	}
	PRINT( "[GChroma] Successfully established connection and initialized devices." );
	LUA->PushBool( true );
	return 1;
}

/*
	gchroma.IsConnected()
	Description:
		Returns whether or not the client is currently connected to an OpenRGB server
	Arguments: None
	Returns: Bool connected
*/
LUA_FUNCTION( GChroma_IsConnected )
{
	LUA->PushBool( client->isConnected() );
	return 1;
}

LUA_FUNCTION( GChroma_SetDeviceColor )
{
	LUA->CheckType( 1, Type::Number );
	LUA->CheckType( 2, Type::Vector );
	int type = ( int ) LUA->GetNumber( 1 );
	auto color = LUA->GetVector( 2 );
	DeviceType realType = static_cast<DeviceType>( type );
	
	DeviceListResult list = client->requestDeviceList();
	if ( list.status != RequestStatus::Success )
	{
		PRINT( "[GChroma] Error fetching device list." );
		LUA->PushBool( false );
		return 1;
	}

	const Device* device = list.devices.find( realType );
	client->setDeviceColor( *device, Color( color.x, color.y, color.z ) );
	return 0;
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
			LUA->PushBool( true );
			LUA->SetField( -2, "Loaded" );
		LUA->SetField( -2, "gchroma" );
	LUA->Pop();
	return 0;
}

GMOD_MODULE_CLOSE()
{
	client->disconnect();
	delete client;
	return 0;
}
