#pragma once
#include "include.h"
#ifndef _CHROMASDKIMPL_H_
	#define _CHROMASDKIMPL_H_
	#pragma once
	#ifndef DLL_COMPILED
		#define DLL_INTERNAL __declspec( dllexport )
	#endif

	#define ALL_DEVICES         0
	#define KEYBOARD_DEVICES    1
	#define MOUSEMAT_DEVICES    2
	#define MOUSE_DEVICES       3
	#define HEADSET_DEVICES     4
	#define KEYPAD_DEVICES      5

	//Class of your Chroma Implementation
	class GChroma
	{
		public:
			GChroma();
			~GChroma();
			BOOL Initialize();

			void ResetEffects( size_t DeviceType );

			BOOL SetMouseColor( COLORREF color );
			BOOL SetMouseColorEx( COLORREF color, size_t row, size_t col );
			BOOL SetKeyboardColor( COLORREF color );
			BOOL SetKeyboardColorEx( size_t key, COLORREF color );

			BOOL IsDeviceConnected( RZDEVICEID DeviceId );

		private:
			HMODULE m_ChromaSDKModule;

	};
#endif
