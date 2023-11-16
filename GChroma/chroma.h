#pragma once

#include <iostream>
#include <tchar.h>
#include <assert.h>
#include <wtypes.h>

#include "RzChromaSDKDefines.h"
#include "RzChromaSDKTypes.h"
#include "RzErrors.h"

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
	#define LINK_DEVICES		6

	class GChroma
	{
		public:
			GChroma();
			~GChroma();
			BOOL Initialize();
			BOOL Initialized;

			void ResetEffects( size_t DeviceType );
			void SetMouseColor( COLORREF color );
			void SetMouseColorEx( size_t key, COLORREF color );
			void SetKeyboardColor( COLORREF color );
			void SetKeyboardColorEx( size_t key, COLORREF color );
			void SetMousepadColor( COLORREF color );
			void SetMousepadColorEx( COLORREF color, size_t num );
			void SetHeadsetColor( COLORREF color );
			void SetHeadsetColorEx( COLORREF color, size_t num );
			void SetKeypadColor( COLORREF color );
			void SetKeypadColorEx( COLORREF color, size_t row, size_t col );
			void SetLinkColor( COLORREF color );
			void PushColors();

		private:
			HMODULE m_ChromaSDKModule;
	};
#endif
