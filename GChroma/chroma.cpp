
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

BOOL GChroma::IsDeviceConnected( RZDEVICEID DeviceId )
{
	if ( QueryDevice != nullptr )
	{
		ChromaSDK::DEVICE_INFO_TYPE DeviceInfo = {};
		auto Result = QueryDevice( DeviceId, DeviceInfo );

		return DeviceInfo.Connected;
	}

	return FALSE;
}


GChroma::GChroma() :m_ChromaSDKModule( nullptr )
{
}
GChroma::~GChroma()
{
}

BOOL GChroma::Initialize()
{
	if ( m_ChromaSDKModule == nullptr )
	{
		m_ChromaSDKModule = LoadLibrary( CHROMASDKDLL );
		if ( m_ChromaSDKModule == nullptr )
		{
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
					return TRUE;
				}
				else
				{
					return FALSE;
				}
			}
		}
	}

	return TRUE;
}

void GChroma::ResetEffects( size_t DeviceType )
{
	switch ( DeviceType )
	{
		case 0:
			if ( CreateKeyboardEffect )
			{
				CreateKeyboardEffect( ChromaSDK::Keyboard::CHROMA_NONE, nullptr, nullptr );
			}

			if ( CreateMousepadEffect )
			{
				CreateMousepadEffect( ChromaSDK::Mousepad::CHROMA_NONE, nullptr, nullptr );
			}

			if ( CreateMouseEffect )
			{
				CreateMouseEffect( ChromaSDK::Mouse::CHROMA_NONE, nullptr, nullptr );
			}

			if ( CreateHeadsetEffect )
			{
				CreateHeadsetEffect( ChromaSDK::Headset::CHROMA_NONE, nullptr, nullptr );
			}

			if ( CreateKeypadEffect )
			{
				CreateKeypadEffect( ChromaSDK::Keypad::CHROMA_NONE, nullptr, nullptr );
			}
			break;
		case 1:
			if ( CreateKeyboardEffect )
			{
				CreateKeyboardEffect( ChromaSDK::Keyboard::CHROMA_NONE, nullptr, nullptr );
			}
			break;
		case 2:
			if ( CreateMousepadEffect )
			{
				CreateMousepadEffect( ChromaSDK::Mousepad::CHROMA_NONE, nullptr, nullptr );
			}
			break;
		case 3:
			if ( CreateMouseEffect )
			{
				CreateMouseEffect( ChromaSDK::Mouse::CHROMA_NONE, nullptr, nullptr );
			}
			break;
		case 4:
			if ( CreateHeadsetEffect )
			{
				CreateHeadsetEffect( ChromaSDK::Headset::CHROMA_NONE, nullptr, nullptr );
			}
			break;
		case 5:
			if ( CreateKeypadEffect )
			{
				CreateKeypadEffect( ChromaSDK::Keypad::CHROMA_NONE, nullptr, nullptr );
			}
			break;
	}
}

//----
//All the code above is provided by the developer example, you can try to understand it or just use it

//Let's start with a Keyboard effect

BOOL GChroma::example_keyboard() {

	//Choose one of the following methods by just deleting the first and last line :)



	/* For matrix-based-effect delete this line
	ChromaSDK::Keyboard::CUSTOM_EFFECT_TYPE Example_keyboard_effect = {}; //Initialize
	//The keyboard effect is initialized as a 2 dimensional matrix/array
	//e.g. the ESC-key is [0][1]
	// Source: http://developer.razerzone.com/chroma/razer-chroma-led-profiles/
	// Take the super keyboard as standard, so your programm will work with every keyboard out of the box
	for (size_t row = 0; row < ChromaSDK::Keyboard::MAX_ROW; row++) {
		for (size_t col = 0; col < ChromaSDK::Keyboard::MAX_COLUMN; col++) {
			Example_keyboard_effect.Color[row][col] = ORANGE;   //Filling the whole matrix with the color orange == Setting background to orange
		}
	}
	Example_keyboard_effect.Color[0][1] = RED; //The colormatrix can be overwritten, until you finally apply the effect to the keyboard
	Example_keyboard_effect.Color[0][1] = BLUE; // Only the last state of the key will be applied. So the ESC-key will be blue, not red and not orange

	//Now we apply the effect to the keyboard
	RZRESULT Result_Keyboard = CreateKeyboardEffect(ChromaSDK::Keyboard::CHROMA_CUSTOM, &Example_keyboard_effect, nullptr);
	//You can work with the Result as well, e.g. checking if everythings ok
	return Result_Keyboard;
	For matrix-based-effect delete this line*/




	/*For key-based-effect delete this line
	Keyboard::CUSTOM_KEY_EFFECT_TYPE Example_keyboard_effect_key = {};  //Initialize key-based Effect
	//The keyboard key effect is initialized as a 2 dimensional matrix/array, but this time called by the HIBYTE and the LOBYTE of the key itself
	//e.g. the ESC-key is [HIBYTE(RZKEY_ESC)][LOBYTE(RZKEY_ESC)]
	//Use this if you want to light up specific keys
	//The whole naming scheme can be found in Keyboard::RZKEY of the RzChromaSDKTypes.h
	//Important! Don't forget the 0x01000000 | before the used COLORREF, otherwise it won't work
	Example_keyboard_effect_key.Key[HIBYTE(RZKEY_ESC)][LOBYTE(RZKEY_ESC)] = 0x01000000 | BLUE; // ESC-key will light up blue
	Example_keyboard_effect_key.Key[HIBYTE(RZKEY_1)][LOBYTE(RZKEY_1)] = 0x01000000 | RED; // 1-key will light up red
	Example_keyboard_effect_key.Key[HIBYTE(RZKEY_NUMPAD3)][LOBYTE(RZKEY_NUMPAD3)] = 0x01000000 | GREEN; // Numpad-3-key will light up green
	//Now we apply the effect to the keyboard
	RZRESULT Result_Keyboard = CreateKeyboardEffect(Keyboard::CHROMA_CUSTOM_KEY, &Example_keyboard_effect_key, NULL);
	//You can work with the Result as well, e.g. checking if everythings ok
	return Result_Keyboard;
	For key-based-effect delete this line*/


	return FALSE;
}

BOOL GChroma::SetMouseColor( COLORREF color )
{
	ChromaSDK::Mouse::CUSTOM_EFFECT_TYPE2 MouseEffect = {}; // Initialize

	for ( size_t row = 0; row < ChromaSDK::Mouse::MAX_ROW; row++ ) {
		for ( size_t col = 0; col < ChromaSDK::Mouse::MAX_COLUMN; col++ ) {
			MouseEffect.Color[row][col] = color; // Filling the whole matrix with the color orange == Setting background to orange
		}
	}

	auto Result_Mouse = CreateMouseEffect( ChromaSDK::Mouse::CHROMA_CUSTOM2, &MouseEffect, nullptr );
	return Result_Mouse;
}

BOOL GChroma::SetMouseColorEx( COLORREF color, size_t row, size_t col )
{
	//The mouse effect is initialized as a 2 dimensional matrix/array
	//e.g. the scroll wheel is [2][3]
	// Source: http://developer.razerzone.com/chroma/razer-chroma-led-profiles/
	// Take the super mouse as standard, so your program will work with every mouse out of the box 

	ChromaSDK::Mouse::CUSTOM_EFFECT_TYPE2 MouseEffect = {};
	MouseEffect.Color[row][col] = color;
	auto Result_Mouse = CreateMouseEffect( ChromaSDK::Mouse::CHROMA_CUSTOM2, &MouseEffect, nullptr );
	return Result_Mouse;
}

BOOL GChroma::example_mousemat()
{

	ChromaSDK::Mousepad::CUSTOM_EFFECT_TYPE Example_mousemat_effect = {}; // Initialize

	//The mousepad effect is initialized as a 1 dimensional matrix/array
	//e.g. the Razer logo is [14]
	// Source: http://developer.razerzone.com/chroma/razer-chroma-led-profiles/

	for ( size_t count = 0; count < ChromaSDK::Mousepad::MAX_LEDS; count++ ) {
		Example_mousemat_effect.Color[count] = ORANGE;  //Filling the whole matrix with the color orange == Setting background to orange
	}

	//a little bit advancec ;-)
	//creating a simple(!) loading animation
	RZRESULT Result_Mousemat = 0;
	for ( size_t count = 0; count < ChromaSDK::Mousepad::MAX_LEDS; count++ )
	{
		Example_mousemat_effect.Color[count] = BLUE;
		Sleep( 500 );
		Result_Mousemat = CreateMousepadEffect( ChromaSDK::Mousepad::CHROMA_CUSTOM, &Example_mousemat_effect, nullptr );

	} //if you want to work with animation, take a look at the frames that the ChromaSDK provides :)

	return Result_Mousemat;
}

// Every effects for other devices can be coded as seen above. Only be sure to use the right CreateXXXXXXEffect function and you are ready to go ;-)
//If you want to code for the Blade keyboard and a normal one at the same time, take a look at the offcial FAQ  http://developer.razerzone.com/chroma/chroma-faq/
