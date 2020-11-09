# GChroma Lua Documentation
 Below is the current list of Lua functions and enums available for developers to use to integrate GChroma with their addons.

# GChroma_SetDeviceColor( `number` device, `vector` color )
 ## Description
 Sets the specified device to a solid color. Individual LEDs cannot be changed with this function.

 ## Arguments
 1. `number` device - Device ID. See enums section below for available devices.

 2. `vector` color - Color to set the device. Must be a vector. Use `GChroma_ToVector()` if you need to convert an existing color table to a vector. DO NOT USE `color:ToVector()`! THINGS WILL BREAK!

 ## Example 1
 Sets the color of all available devices to blue.
 ``` lua
	if GChroma_Loaded then --If your addon isn't exclusively made for GChroma, add this check to avoid errors
	    GChroma_SetDeviceColor( GCHROMA_DEVICE_ALL, Vector( 0, 0, 255 ) )
	end
 ```

 ## Example 2
 Sets the color of all available devices to the color of the entity that the client has used.
 ``` lua
	--Assume this function is in a shared file
	function ENT:Use( activator, caller )
	    if CLIENT and GChroma_Loaded then
		    GChroma_SetDeviceColor( GCHROMA_DEVICE_ALL, GChroma_ToVector( self:GetColor() ) )
	    end
	end
 ```

# GChroma_SetDeviceColorEx( `number` device, `vector` color, `number` row, `number` col )
 ## Description
 Sets the color of the specified device LED. If you are setting the color for a keyboard or mouse, you can use their respective LED enums and set the col argument to 0. If you are using a different device, see the [Chroma LED Profiles](https://developer.razer.com/works-with-chroma-v1/razer-chroma-led-profiles/) for what row and column you should use. It is recommended you use the "super" variant of each device to ensure compatibility with all devices.

 ## Arguments
 1. `number` device - Device ID. See enums section below for available devices. Note that the GCHROMA_DEVICE_ALL enum will NOT work with this function.

 2. `vector` color - Color to set the device. Must be a vector. Use `GChroma_ToVector()` if you need to convert an existing color table to a vector. DO NOT USE `color:ToVector()`! THINGS WILL BREAK!

 3. `number` row - Row of the device LED. See the description above for how this argument should be handled.

 4. `number` col - Column of the device LED. See the description above for how this argument should be handled.

 ## Example 1
 Sets the mouse scroll wheel color to blue.
 ``` lua
	if GChroma_Loaded then
	    GChroma_SetDeviceColorEx( GCHROMA_DEVICE_MOUSE, Vector( 0, 0, 255 ), GCHROMA_MOUSE_SCROLLWHEEL, 0 )
	end

	--This does the same thing as above, but uses the grid system instead of enums
	if GChroma_Loaded then
	    GChroma_SetDeviceColorEx( GCHROMA_DEVICE_MOUSE, Vector( 0, 0, 255 ), 2, 3 )
	end
 ```

 ## Example 2
 Sets the W key on the keyboard to red.
 ``` lua
	if GChroma_Loaded then
	    GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, Vector( 255, 0, 0 ), GCHROMA_KEY_W, 0 )
	end
 ```

 ## Example 3
 Sets the top left corner of the mousepad to green.
 ``` lua
	if GChroma_Loaded then
	    GChroma_SetDeviceColorEx( GCHROMA_DEVICE_MOUSEPAD, Vector( 0, 255, 0 ), 0, 0 )
	end
 ```

# GChroma_ResetDevice( `number` device )
 ## Description
 Resets the colors of the specified device to 0, 0, 0.

 ## Arguments
 1. `number` device - Device ID. See enums section below for available devices.

# GChroma_ToVector( `color` color )
 ## Description
 Converts a Lua color table into a vector so that it can be used in the GChroma color functions.

 ## Arguments
 1. `color` color - Color table to be converted.

# Enums
 ## Device IDs
 - GCHROMA_DEVICE_ALL
 - GCHROMA_DEVICE_KEYBOARD
 - GCHROMA_DEVICE_MOUSEPAD
 - GCHROMA_DEVICE_MOUSE
 - GCHROMA_DEVICE_HEADSET
 - GCHROMA_DEVICE_KEYPAD

 ## Mouse LEDs
 - GCHROMA_MOUSE_SCROLLWHEEL
 - GCHROMA_MOUSE_LOGO
 - GCHROMA_MOUSE_BACKLIGHT
 - GCHROMA_MOUSE_LEFT_SIDE1
 - GCHROMA_MOUSE_LEFT_SIDE2
 - GCHROMA_MOUSE_LEFT_SIDE3
 - GCHROMA_MOUSE_LEFT_SIDE4
 - GCHROMA_MOUSE_LEFT_SIDE5
 - GCHROMA_MOUSE_LEFT_SIDE6
 - GCHROMA_MOUSE_LEFT_SIDE7
 - GCHROMA_MOUSE_BOTTOM1
 - GCHROMA_MOUSE_BOTTOM2
 - GCHROMA_MOUSE_BOTTOM3
 - GCHROMA_MOUSE_BOTTOM4
 - GCHROMA_MOUSE_BOTTOM5
 - GCHROMA_MOUSE_RIGHT_SIDE1
 - GCHROMA_MOUSE_RIGHT_SIDE2
 - GCHROMA_MOUSE_RIGHT_SIDE3
 - GCHROMA_MOUSE_RIGHT_SIDE4
 - GCHROMA_MOUSE_RIGHT_SIDE5
 - GCHROMA_MOUSE_RIGHT_SIDE6
 - GCHROMA_MOUSE_RIGHT_SIDE7

## Keyboard LEDs
- GCHROMA_KEY_ESC
- GCHROMA_KEY_F1
- GCHROMA_KEY_F2
- GCHROMA_KEY_F3
- GCHROMA_KEY_F4
- GCHROMA_KEY_F5
- GCHROMA_KEY_F6
- GCHROMA_KEY_F7
- GCHROMA_KEY_F8
- GCHROMA_KEY_F9
- GCHROMA_KEY_F10
- GCHROMA_KEY_F11
- GCHROMA_KEY_F12
- GCHROMA_KEY_1
- GCHROMA_KEY_2
- GCHROMA_KEY_3
- GCHROMA_KEY_4
- GCHROMA_KEY_5
- GCHROMA_KEY_6
- GCHROMA_KEY_7
- GCHROMA_KEY_8
- GCHROMA_KEY_9
- GCHROMA_KEY_0
- GCHROMA_KEY_A
- GCHROMA_KEY_B
- GCHROMA_KEY_C
- GCHROMA_KEY_D
- GCHROMA_KEY_E
- GCHROMA_KEY_F
- GCHROMA_KEY_G
- GCHROMA_KEY_H
- GCHROMA_KEY_I
- GCHROMA_KEY_J
- GCHROMA_KEY_K
- GCHROMA_KEY_L
- GCHROMA_KEY_M
- GCHROMA_KEY_N
- GCHROMA_KEY_O
- GCHROMA_KEY_P
- GCHROMA_KEY_Q
- GCHROMA_KEY_R
- GCHROMA_KEY_S
- GCHROMA_KEY_T
- GCHROMA_KEY_U
- GCHROMA_KEY_V
- GCHROMA_KEY_W
- GCHROMA_KEY_X
- GCHROMA_KEY_Y
- GCHROMA_KEY_Z
- GCHROMA_KEY_NUMLOCK
- GCHROMA_KEY_NUMPAD0
- GCHROMA_KEY_NUMPAD1
- GCHROMA_KEY_NUMPAD2
- GCHROMA_KEY_NUMPAD3
- GCHROMA_KEY_NUMPAD4
- GCHROMA_KEY_NUMPAD5
- GCHROMA_KEY_NUMPAD6
- GCHROMA_KEY_NUMPAD7
- GCHROMA_KEY_NUMPAD8
- GCHROMA_KEY_NUMPAD9
- GCHROMA_KEY_NUMPAD_DIVIDE
- GCHROMA_KEY_NUMPAD_MULTIPLY
- GCHROMA_KEY_NUMPAD_SUBTRACT
- GCHROMA_KEY_NUMPAD_ADD
- GCHROMA_KEY_NUMPAD_ENTER
- GCHROMA_KEY_NUMPAD_DECIMAL
- GCHROMA_KEY_PRINTSCREEN
- GCHROMA_KEY_SCROLL
- GCHROMA_KEY_PAUSE
- GCHROMA_KEY_INSERT
- GCHROMA_KEY_HOME
- GCHROMA_KEY_PAGEUP
- GCHROMA_KEY_DELETE
- GCHROMA_KEY_END
- GCHROMA_KEY_PAGEDOWN
- GCHROMA_KEY_UP
- GCHROMA_KEY_LEFT
- GCHROMA_KEY_DOWN
- GCHROMA_KEY_RIGHT
- GCHROMA_KEY_TAB
- GCHROMA_KEY_CAPSLOCK
- GCHROMA_KEY_BACKSPACE
- GCHROMA_KEY_ENTER
- GCHROMA_KEY_LCTRL
- GCHROMA_KEY_LWIN
- GCHROMA_KEY_LALT
- GCHROMA_KEY_SPACE
- GCHROMA_KEY_RALT
- GCHROMA_KEY_FN
- GCHROMA_KEY_RMENU
- GCHROMA_KEY_RCTRL
- GCHROMA_KEY_LSHIFT
- GCHROMA_KEY_RSHIFT
- GCHROMA_KEY_MACRO1
- GCHROMA_KEY_MACRO2
- GCHROMA_KEY_MACRO3
- GCHROMA_KEY_MACRO4
- GCHROMA_KEY_MACRO5
- GCHROMA_KEY_OEM_1
- GCHROMA_KEY_OEM_2
- GCHROMA_KEY_OEM_3
- GCHROMA_KEY_OEM_4
- GCHROMA_KEY_OEM_5
- GCHROMA_KEY_OEM_6
- GCHROMA_KEY_OEM_7
- GCHROMA_KEY_OEM_8
- GCHROMA_KEY_OEM_9
- GCHROMA_KEY_OEM_10
- GCHROMA_KEY_OEM_11
- GCHROMA_KEY_EUR_1
- GCHROMA_KEY_EUR_2
- GCHROMA_KEY_JPN_1
- GCHROMA_KEY_JPN_2
- GCHROMA_KEY_JPN_3
- GCHROMA_KEY_JPN_4
- GCHROMA_KEY_JPN_5
- GCHROMA_KEY_KOR_1
- GCHROMA_KEY_KOR_2
- GCHROMA_KEY_KOR_3
- GCHROMA_KEY_KOR_4
- GCHROMA_KEY_KOR_5
- GCHROMA_KEY_KOR_6
- GCHROMA_KEY_KOR_7
- GCHROMA_KEY_INVALID