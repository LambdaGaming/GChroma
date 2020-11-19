# GChroma Lua Documentation
 Below is the current list of Lua functions and enums available for developers to use to integrate GChroma with their addons.

&nbsp;

# Before You Start
 Before you start developing for GChroma, take note of the following:
 1. Make sure your addon doesn't interfere with other addons. GChroma has no way of knowing what addon is supposed to take priority, so it will always override the current color grid with the one that was called last. If possible, it is recommended you give priority back to whatever addon was using GChroma last after your addon no longer needs that priority.
 2. Avoid running resource-intensive functions in loops, specifically `GChroma_Start()` and `GChroma_CreateEffect()`. Failure to do so may result in the SDK taking a long time to process the changes. Looping timers or cooldowns with a time of at least 0.1 seconds should be used if you plan on rapidly changing colors.
 3. Avoid using `GChroma_SetDeviceColor()`, `GChroma_SetDeviceColorEx()`, and `GChroma_ResetDevice()` in server-side code whenever possible. The client-side functions are designed to allow developers to change colors across multiple devices while only requiring `GChroma_CreateEffect()` to be called once, which helps immensely with performance. The server-side functions have no way of doing this.

&nbsp;

# GChroma_Start()
 ## Scope
 Client

 ## Description
 Initializes a new GChroma effect. Needs to be called before using any other GChroma function, similar to net.Start().

 ## Returns
 1. `userdata` instance - Instance of the GChroma class created by the function. This data cannot be manipulated directly through Lua. It only exists to be passed as an argument for the other functions.

 ## Example 1
 Shows how this function works with the other functions.
 ``` lua
 if GChroma_Loaded then
	local chroma = GChroma_Start()
	GChroma_SetDeviceColor( chroma, GCHROMA_DEVICE_ALL, GCHROMA_COLOR_RED )
	GChroma_CreateEffect( chroma )
 end
 ```

&nbsp;

# GChroma_SetDeviceColor( `userdata` instance, `number` device, `vector` color )
 ## Scope
 Shared (For server, add the target player as the first argument. Avoid using server function whenever possible. Client function is more optimized.)

 ## Description
 Sets the specified device to a solid color. Individual LEDs cannot be changed with this function.

 ## Arguments
 1. `userdata` instance - Instance of the GChroma effect created with GChroma_Start().
   
 2. `number` device - Device ID. See enums section below for available devices.

 3. `vector` color - Color to set the device. Must be a vector. Use `GChroma_ToVector()` if you need to convert an existing color table to a vector. DO NOT USE `color:ToVector()`! THINGS WILL BREAK!

 ## Example 1
 Sets the color of all available devices to blue.
 ``` lua
if GChroma_Loaded then --If your addon isn't exclusively made for GChroma, add this check to avoid errors
	local chroma = GChroma_Start()
	GChroma_SetDeviceColor( GCHROMA_DEVICE_ALL, Vector( 0, 0, 255 ) )
	GChroma_CreateEffect( chroma )
end
 ```

 ## Example 2
 Sets the color of all available devices to the color of the entity that the client has used.
 ``` lua
--Assume this function is in a shared file
function ENT:Use( activator, caller )
	if CLIENT and GChroma_Loaded then
		local chroma = GChroma_Start()
		GChroma_SetDeviceColor( gchroma, GCHROMA_DEVICE_ALL, GChroma_ToVector( self:GetColor() ) )
		GChroma_CreateEffect( gchroma )
	end
end
 ```

&nbsp;

# GChroma_SetDeviceColorEx( `userdata` instance, `number` device, `vector` color, `number` row, `number` col )
 ## Scope
 Shared (For server, add the target player as the first argument. Avoid using server function whenever possible. Client function is more optimized.)

 ## Description
 Sets the color of the specified device LED. If you are setting the color for a keyboard or mouse, you can use their respective LED enums and set the col argument to 0. If you are using a different device, see the [Chroma LED Profiles](https://developer.razer.com/works-with-chroma-v1/razer-chroma-led-profiles/) for what row and column you should use. It is recommended you use the "super" variant of each device to ensure compatibility with all devices.

 ## Arguments
 1. `userdata` instance - Instance of the GChroma effect created with GChroma_Start().

 2. `number` device - Device ID. See enums section below for available devices. Note that the GCHROMA_DEVICE_ALL enum will NOT work with this function.

 3. `vector` color - Color to set the device. Must be a vector. Use `GChroma_ToVector()` if you need to convert an existing color table to a vector. DO NOT USE `color:ToVector()`! THINGS WILL BREAK!

 4. `number` row - Row of the device LED. See the description above for how this argument should be handled.

 5. `number` col - Column of the device LED. See the description above for how this argument should be handled.

 ## Example 1
 Sets the mouse scroll wheel color to blue.
 ``` lua
if GChroma_Loaded then
	local chroma = GChroma_Start()
	GChroma_SetDeviceColorEx( GCHROMA_DEVICE_MOUSE, Vector( 0, 0, 255 ), GCHROMA_MOUSE_SCROLLWHEEL, 0 )
	GChroma_CreateEffect( chroma )
end

--This does the same thing as above, but uses the grid system instead of enums
if GChroma_Loaded then
	local chroma = GChroma_Start()
	GChroma_SetDeviceColorEx( GCHROMA_DEVICE_MOUSE, Vector( 0, 0, 255 ), 2, 3 )
	GChroma_CreateEffect( chroma )
end
 ```

 ## Example 2
 Sets the W key on the keyboard to red.
 ``` lua
if GChroma_Loaded then
	local chroma = GChroma_Start()
	GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, Vector( 255, 0, 0 ), GCHROMA_KEY_W, 0 )
	GChroma_CreateEffect( chroma, true )
end
 ```

 ## Example 3
 Sets the top left corner of the mousepad to green.
 ``` lua
if GChroma_Loaded then
	local chroma = GChroma_Start()
	GChroma_SetDeviceColorEx( GCHROMA_DEVICE_MOUSEPAD, Vector( 0, 255, 0 ), 0, 0 )
	GChroma_CreateEffect( chroma )
end
 ```

&nbsp;

# GChroma_ResetDevice( `number` device )
 ## Scope
 Shared (For server, add the target player as the first argument. Avoid using server function whenever possible. Client function is more optimized.)

 ## Description
 Resets the colors of the specified device to 0, 0, 0.

 ## Arguments
 1. `number` device - Device ID. See enums section below for available devices.

&nbsp;

# GChroma_CreateEffect( `userdata` instance, `bool` key )
 ## Scope
 Client

 ## Description
 Creates a new GChroma effect using the effect declared from GChroma_Start and modified with the other GChroma functions.

 ## Arguments
 1. `userdata` instance - Instance of the GChroma effect created with GChroma_Start().

 2. `bool` key - Optional. Set to true if your effect modifies keyboard keys using the GCHROMA_KEY_* enums listed at the bottom of the page.

 ## Example 1
 Sets all 4 corners of the mouse pad to green.
 ``` lua
 if GChroma_Loaded then
	local chroma = GChroma_Start()
	local grid = { 0, 4, 10, 14 }
	for k,v in pairs( grid ) do
	    GChroma_SetDeviceColorEx( chroma, GCHROMA_DEVICE_MOUSEPAD, GCHROMA_COLOR_GREEN, v, 0 )
	end
	GChroma_CreateEffect( chroma, false )
 end
 ```

&nbsp;

# GChroma_ToVector( `color` color )
 ## Scope
 Shared

 ## Description
 Converts a Lua color table into a vector so that it can be used in the GChroma color functions.

 ## Arguments
 1. `color` color - Color table to be converted.

&nbsp;

# GChroma_KeyConvert( `number` key )
 ## Scope
 Client

 ## Description
 Converts a Garry's Mod key into a GChroma key. May not work for every key. Intended to be used only for letter keys.

 ## Arguments
 1. `number` key - Garry's Mod key to be converted.

 ## Example 1
 Sets the color of the key bound to voice chat to green.
 ``` lua
GChroma_SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, Vector( 0, 255, 0 ), GChroma_KeyConvert( input.GetKeyCode( input.LookupBinding( "voicerecord" ) ) ), 0 )
 ```

&nbsp;

# Enums
 See [gchroma_enums.lua](https://github.com/LambdaGaming/GChroma_Lua_Base/blob/main/lua/autorun/gchroma_enums.lua)
