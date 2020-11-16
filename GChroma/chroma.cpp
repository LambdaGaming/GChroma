
#include "chroma.h"

#ifdef _WIN64
	#define CHROMASDKDLL _T( "RzChromaSDK64.dll" )
#else
	#define CHROMASDKDLL _T( "RzChromaSDK.dll" )
#endif

using namespace ChromaSDK;
using namespace ChromaSDK::Keyboard;
using namespace ChromaSDK::Keypad;
using namespace ChromaSDK::Mouse;
using namespace ChromaSDK::Mousepad;
using namespace ChromaSDK::Headset;
using namespace std;

typedef RZRESULT( *INIT )( void );
typedef RZRESULT( *UNINIT )( void );
typedef RZRESULT( *CREATEEFFECT )( RZDEVICEID DeviceId, ChromaSDK::EFFECT_TYPE Effect, PRZPARAM pParam, RZEFFECTID* pEffectId );
typedef RZRESULT( *CREATEKEYBOARDEFFECT )( ChromaSDK::Keyboard::EFFECT_TYPE Effect, PRZPARAM pParam, RZEFFECTID* pEffectId );
typedef RZRESULT( *CREATEHEADSETEFFECT )( ChromaSDK::Headset::EFFECT_TYPE Effect, PRZPARAM pParam, RZEFFECTID* pEffectId );
typedef RZRESULT( *CREATEMOUSEPADEFFECT )( ChromaSDK::Mousepad::EFFECT_TYPE Effect, PRZPARAM pParam, RZEFFECTID* pEffectId );
typedef RZRESULT( *CREATEMOUSEEFFECT )( ChromaSDK::Mouse::EFFECT_TYPE Effect, PRZPARAM pParam, RZEFFECTID* pEffectId );
typedef RZRESULT( *CREATEKEYPADEFFECT )( ChromaSDK::Keypad::EFFECT_TYPE Effect, PRZPARAM pParam, RZEFFECTID* pEffectId );
typedef RZRESULT( *SETEFFECT )( RZEFFECTID EffectId );
typedef RZRESULT( *DELETEEFFECT )( RZEFFECTID EffectId );
typedef RZRESULT( *REGISTEREVENTNOTIFICATION )( HWND hWnd );
typedef RZRESULT( *UNREGISTEREVENTNOTIFICATION )( void );
typedef RZRESULT( *QUERYDEVICE )( RZDEVICEID DeviceId, ChromaSDK::DEVICE_INFO_TYPE& DeviceInfo );

INIT Init = nullptr;
UNINIT UnInit = nullptr;
CREATEEFFECT CreateEffect = nullptr;
CREATEKEYBOARDEFFECT CreateKeyboardEffect = nullptr;
CREATEMOUSEEFFECT CreateMouseEffect = nullptr;
CREATEHEADSETEFFECT CreateHeadsetEffect = nullptr;
CREATEMOUSEPADEFFECT CreateMousepadEffect = nullptr;
CREATEKEYPADEFFECT CreateKeypadEffect = nullptr;
SETEFFECT SetEffect = nullptr;
DELETEEFFECT DeleteEffect = nullptr;
QUERYDEVICE QueryDevice = nullptr;

Keyboard::CUSTOM_KEY_EFFECT_TYPE KeyboardEffect = {};
Mouse::CUSTOM_EFFECT_TYPE2 MouseEffect = {};
Mousepad::CUSTOM_EFFECT_TYPE MousepadEffect = {};
Headset::CUSTOM_EFFECT_TYPE HeadsetEffect = {};
Keypad::CUSTOM_EFFECT_TYPE KeypadEffect = {};

GChroma::GChroma() :m_ChromaSDKModule( nullptr ) {}
GChroma::~GChroma() {}

BOOL GChroma::Initialize()
{
	if ( m_ChromaSDKModule == nullptr )
	{
		m_ChromaSDKModule = LoadLibrary( CHROMASDKDLL );
		if ( m_ChromaSDKModule == nullptr )
		{
			Initialized = false;
			return FALSE;
		}
	}

	if ( Init == nullptr )
	{
		auto Result = RZRESULT_INVALID;
		Init = reinterpret_cast< INIT >( GetProcAddress( m_ChromaSDKModule, "Init" ) );
		if ( Init )
		{
			Result = Init();
			if ( Result == RZRESULT_SUCCESS )
			{
				CreateEffect = reinterpret_cast< CREATEEFFECT >( GetProcAddress( m_ChromaSDKModule, "CreateEffect" ) );
				CreateKeyboardEffect = reinterpret_cast< CREATEKEYBOARDEFFECT >( GetProcAddress( m_ChromaSDKModule, "CreateKeyboardEffect" ) );
				CreateMouseEffect = reinterpret_cast< CREATEMOUSEEFFECT >( GetProcAddress( m_ChromaSDKModule, "CreateMouseEffect" ) );
				CreateHeadsetEffect = reinterpret_cast< CREATEHEADSETEFFECT >( GetProcAddress( m_ChromaSDKModule, "CreateHeadsetEffect" ) );
				CreateMousepadEffect = reinterpret_cast< CREATEMOUSEPADEFFECT >( GetProcAddress( m_ChromaSDKModule, "CreateMousepadEffect" ) );
				CreateKeypadEffect = reinterpret_cast< CREATEKEYPADEFFECT >( GetProcAddress( m_ChromaSDKModule, "CreateKeypadEffect" ) );
				SetEffect = reinterpret_cast< SETEFFECT >( GetProcAddress( m_ChromaSDKModule, "SetEffect" ) );
				DeleteEffect = reinterpret_cast< DELETEEFFECT >( GetProcAddress( m_ChromaSDKModule, "DeleteEffect" ) );
				QueryDevice = reinterpret_cast< QUERYDEVICE >( GetProcAddress( m_ChromaSDKModule, "QueryDevice" ) );

				if ( CreateEffect &&
					CreateKeyboardEffect &&
					CreateMouseEffect &&
					CreateHeadsetEffect &&
					CreateMousepadEffect &&
					CreateKeypadEffect &&
					SetEffect &&
					DeleteEffect &&
					QueryDevice )
				{
					Initialized = true;
					return TRUE;
				}
				else
				{
					Initialized = false;
					return FALSE;
				}
			}
		}
	}
	Initialized = true;
	return TRUE;
}

void GChroma::ResetEffects( size_t DeviceType )
{
	switch ( DeviceType )
	{
		case 0:
			if ( CreateKeyboardEffect )
			{
				CreateKeyboardEffect( Keyboard::CHROMA_NONE, nullptr, nullptr );
				KeyboardEffect = {};
			}

			if ( CreateMousepadEffect )
			{
				CreateMousepadEffect( Mousepad::CHROMA_NONE, nullptr, nullptr );
				MousepadEffect = {};
			}

			if ( CreateMouseEffect )
			{
				CreateMouseEffect( Mouse::CHROMA_NONE, nullptr, nullptr );
				MouseEffect = {};
			}

			if ( CreateHeadsetEffect )
			{
				CreateHeadsetEffect( Headset::CHROMA_NONE, nullptr, nullptr );
				HeadsetEffect = {};
			}

			if ( CreateKeypadEffect )
			{
				CreateKeypadEffect( Keypad::CHROMA_NONE, nullptr, nullptr );
				KeypadEffect = {};
			}
			break;
		case 1:
			if ( CreateKeyboardEffect )
			{
				CreateKeyboardEffect( Keyboard::CHROMA_NONE, nullptr, nullptr );
				KeyboardEffect = {};
			}
			break;
		case 2:
			if ( CreateMousepadEffect )
			{
				CreateMousepadEffect( Mousepad::CHROMA_NONE, nullptr, nullptr );
				MousepadEffect = {};
			}
			break;
		case 3:
			if ( CreateMouseEffect )
			{
				CreateMouseEffect( Mouse::CHROMA_NONE, nullptr, nullptr );
				MouseEffect = {};
			}
			break;
		case 4:
			if ( CreateHeadsetEffect )
			{
				CreateHeadsetEffect( Headset::CHROMA_NONE, nullptr, nullptr );
				HeadsetEffect = {};
			}
			break;
		case 5:
			if ( CreateKeypadEffect )
			{
				CreateKeypadEffect( Keypad::CHROMA_NONE, nullptr, nullptr );
				KeypadEffect = {};
			}
			break;
	}
}

void GChroma::SetMouseColor( COLORREF color )
{
	for ( size_t row = 0; row < Mouse::MAX_ROW; row++ )
	{
		for ( size_t col = 0; col < Mouse::MAX_COLUMN; col++ )
		{
			MouseEffect.Color[row][col] = color; // Fill in the entire grid with the same color
		}
	}
}

void GChroma::SetMouseColorEx( size_t key, COLORREF color )
{
	MouseEffect.Color[HIBYTE( key )][LOBYTE( key )] = color;
}

void GChroma::SetKeyboardColor( COLORREF color )
{
	for ( size_t row = 0; row < Keyboard::MAX_ROW; row++ )
	{
		for ( size_t col = 0; col < Keyboard::MAX_COLUMN; col++ )
		{
			KeyboardEffect.Color[row][col] = color;
		}
	}
}

void GChroma::SetKeyboardColorEx( size_t key, COLORREF color )
{
	KeyboardEffect.Key[HIBYTE( key )][LOBYTE( key )] = 0x01000000 | color;
}

void GChroma::SetMousepadColor( COLORREF color )
{
	for ( size_t i = 0; i < Mousepad::MAX_LEDS; i++ )
	{
		MousepadEffect.Color[i] = color;
	}
}

void GChroma::SetMousepadColorEx( COLORREF color, size_t num )
{
	MousepadEffect.Color[num] = color;
}

void GChroma::SetHeadsetColor( COLORREF color )
{
	for ( size_t i = 0; i < Headset::MAX_LEDS; i++ )
	{
		HeadsetEffect.Color[i] = color;
	}
}

void GChroma::SetHeadsetColorEx( COLORREF color, size_t num )
{
	HeadsetEffect.Color[num] = color;
}

void GChroma::SetKeypadColor( COLORREF color )
{
	for ( size_t row = 0; row < Keypad::MAX_ROW; row++ )
	{
		for ( size_t col = 0; col < Keypad::MAX_COLUMN; col++ )
		{
			KeypadEffect.Color[row][col] = color;
		}
	}
}

void GChroma::SetKeypadColorEx( COLORREF color, size_t row, size_t col )
{
	KeypadEffect.Color[row][col] = color;
}

void GChroma::PushColors( bool pattern, bool keys )
{
	if ( pattern )
	{
		// TODO: Add pattern support
	}
	else
	{
		if ( keys )
		{
			CreateKeyboardEffect( Keyboard::CHROMA_CUSTOM_KEY, &KeyboardEffect, NULL );
		}
		else
		{
			CreateKeyboardEffect( Keyboard::CHROMA_CUSTOM, &KeyboardEffect, nullptr );
		}
		CreateMouseEffect( Mouse::CHROMA_CUSTOM2, &MouseEffect, nullptr );
		CreateMousepadEffect( Mousepad::CHROMA_CUSTOM, &MousepadEffect, nullptr );
		CreateHeadsetEffect( Headset::CHROMA_CUSTOM, &HeadsetEffect, nullptr );
		CreateKeypadEffect( Keypad::CHROMA_CUSTOM, &KeypadEffect, nullptr );
	}
}
