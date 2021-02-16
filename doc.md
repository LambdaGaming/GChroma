# GChroma Lua Documentation
 Below is the current list of Lua functions and enums available for developers to use to integrate GChroma with their addons.

&nbsp;

# Before You Start
 Before you start developing for GChroma, take note of the following:
 1. Make sure your addon doesn't interfere with other addons. GChroma has no way of knowing what addon is supposed to take priority, so it will always override the current color grid with the one that was called last. If at all possible, it is recommended you call a function from the last addon to use the grid to make sure colors are restored. You should only do this if you have a way of knowing whether or not that addon is installed, otherwise players who don't have it will get errors.
 2. Avoid running resource-intensive functions in loops, specifically `gchroma.CreateEffect()`. Failure to do so may result in the SDK taking a long time to process the changes. Looping timers or cooldowns with a time of at least 0.1 seconds should be used if you plan on rapidly changing colors.

&nbsp;

# Client Functions

# gchroma.SetDeviceColor( `number` device, `vector` color )
 ## Description
 Sets the specified device to a solid color. Individual LEDs cannot be changed with this function.

 ## Arguments
 1. `number` device - Device ID. See enums section below for available devices.

 2. `vector` color - Color to set the device. Must be a vector. Use `gchroma.ToVector()` if you need to convert an existing color table to a vector. DO NOT USE `color:ToVector()`! ALL COLORS WILL BE EXTREMELY DIM!

 ## Example 1
 Sets the color of all available devices to blue.
 ``` lua
if gchroma.Loaded then --If your addon isn't exclusively made for GChroma, add this check to avoid errors
	gchroma.SetDeviceColor( GCHROMA_DEVICE_ALL, Vector( 0, 0, 255 ) )
	gchroma.CreateEffect()
end
 ```

 ## Example 2
 Sets the color of all available devices to the color of the entity that the client has used.
 ``` lua
--Assume this function is in a shared file
function ENT:Use( activator, caller )
	if CLIENT and gchroma.Loaded then
		gchroma.SetDeviceColor( gchroma, GCHROMA_DEVICE_ALL, GChroma_ToVector( self:GetColor() ) )
		gchroma.CreateEffect( gchroma )
	end
end
 ```

&nbsp;

# gchroma.SetDeviceColorEx( `number` device, `vector` color, `number` row, `number` col )
 ## Description
 Sets the color of the specified device LED. If you are setting the color for a keyboard or mouse, you can use their respective LED enums and set the col argument to 0. If you are using a different device, see the [Chroma LED Profiles](https://developer.razer.com/works-with-chroma-v1/razer-chroma-led-profiles/) for what row and column you should use. It is recommended you use the "super" variant of each device to ensure compatibility with all devices.

 ## Arguments
 1. `number` device - Device ID. See enums section below for available devices. Note that the GCHROMA_DEVICE_ALL enum will NOT work with this function.

 2. `vector` color - Color to set the device. Must be a vector. Use `gchroma.ToVector()` if you need to convert an existing color table to a vector. DO NOT USE `color:ToVector()`! ALL COLORS WILL BE EXTREMELY DIM!

 3. `number` row - Row of the device LED. See the description above for how this argument should be handled.

 4. `number` col - Column of the device LED. See the description above for how this argument should be handled.

 ## Example 1
 Sets the mouse scroll wheel color to blue.
 ``` lua
if gchroma.Loaded then
	gchroma.SetDeviceColorEx( GCHROMA_DEVICE_MOUSE, Vector( 0, 0, 255 ), GCHROMA_MOUSE_SCROLLWHEEL, 0 )
	gchroma.CreateEffect()
end

--This does the same thing as above, but uses the grid system instead of enums
if gchroma.Loaded then
	gchroma.SetDeviceColorEx( GCHROMA_DEVICE_MOUSE, Vector( 0, 0, 255 ), 2, 3 )
	gchroma.CreateEffect()
end
 ```

 ## Example 2
 Sets the W key on the keyboard to red.
 ``` lua
if gchroma.Loaded then
	gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, Vector( 255, 0, 0 ), GCHROMA_KEY_W, 0 )
	gchroma.CreateEffect()
end
 ```

 ## Example 3
 Sets the top left corner of the mousepad to green.
 ``` lua
if gchroma.Loaded then
	gchroma.SetDeviceColorEx( GCHROMA_DEVICE_MOUSEPAD, Vector( 0, 255, 0 ), 0, 0 )
	gchroma.CreateEffect()
end
 ```

&nbsp;

# gchroma.ResetDevice( `number` device )
 ## Description
 Resets the colors of the specified device to 0, 0, 0.

 ## Arguments
 1. `number` device - Device ID. See enums section below for available devices.

&nbsp;

# gchroma.CreateEffect()
 ## Description
 Creates a new GChroma effect using the effect declared from GChroma_Start and modified with the other GChroma functions.

 ## Example 1
 Sets all 4 corners of the mouse pad to green.
 ``` lua
 if gchroma.Loaded then
	local grid = { 0, 4, 10, 14 }
	for k,v in pairs( grid ) do
	    gchroma.SetDeviceColorEx( GCHROMA_DEVICE_MOUSEPAD, GCHROMA_COLOR_GREEN, v, 0 )
	end
	gchroma.CreateEffect()
 end
 ```

&nbsp;

# gchroma.KeyConvert( `number` key )
 ## Description
 Converts a Garry's Mod key into a GChroma key. May not work for every key. Intended to be used only for letter keys.

 ## Arguments
 1. `number` key - Garry's Mod key to be converted.

 ## Example 1
 Sets the color of the key bound to voice chat to green.
 ``` lua
gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, Vector( 0, 255, 0 ), gchroma.KeyConvert( input.GetKeyCode( input.LookupBinding( "voicerecord" ) ) ), 0 )
 ```

&nbsp;

# Server Functions

# gchroma.SetDeviceColor( `number` device, `vector` color )
 ## Description
 Used along with `gchroma.SendFunctions()` to send GChroma functions from the server. See `gchroma.SendFunctions()` section for examples.

 ## Arguments
 1. `number` device - Device ID. See enums section below for available devices.

 2. `vector` color - Color to set the device. Must be a vector. Use `gchroma.ToVector()` if you need to convert an existing color table to a vector. DO NOT USE `color:ToVector()`! ALL COLORS WILL BE EXTREMELY DIM!

&nbsp;

# gchroma.SetDeviceColorEx( `number` device, `vector` color, `number` row, `number` col )
 ## Description
 Used along with `gchroma.SendFunctions()` to send GChroma functions from the server. See `gchroma.SendFunctions()` section for examples.

 ## Arguments
 1. `number` device - Device ID. See enums section below for available devices. Note that the GCHROMA_DEVICE_ALL enum will NOT work with this function.

 2. `vector` color - Color to set the device. Must be a vector. Use `gchroma.ToVector()` if you need to convert an existing color table to a vector. DO NOT USE `color:ToVector()`! ALL COLORS WILL BE EXTREMELY DIM!

 3. `number` row - Row of the device LED. See the description above for how this argument should be handled.

 4. `number` col - Column of the device LED. See the description above for how this argument should be handled.

&nbsp;

# gchroma.ResetDevice( `number` device )
 ## Description
 Used along with `gchroma.SendFunctions()` to send GChroma functions from the server. See `gchroma.SendFunctions()` section for examples.

 ## Arguments
 1. `number` device - Device ID. See enums section below for available devices.

&nbsp;

# gchroma.SendFunctions( `player` ply, `table` tbl )
 ## Description
 Sends a table of functions to a client. This function allows you to use server-side code as much as client-side code without the huge performance loss.

 ## Arguments
 1. `player` ply - Player who will receive the functions

 2. `table` tbl - Table of functions for the player to receive

## Example 1
 Sets the color of all available devices to blue.
 ``` lua
for k,v in ipairs( player.GetAll() ) do --This sends the message to all players for the example, but generally you should avoid doing this since the majority of players likely won't be able to use it
	local tbl = { gchroma.SetDeviceColor( GCHROMA_DEVICE_ALL, Vector( 0, 0, 255 ) ) } --You can also use table.insert()
	gchroma.SendFunctions( v, tbl )
end
 ```

## Example 2
 Resets all devices and sets the W key to red and S key to green.
``` lua
function ENT:Use( activator, caller )
	local tbl = {
		gchroma.ResetDevice( GCHROMA_DEVICE_ALL )
		gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_RED, GCHROMA_KEY_W, 0 ),
		gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_GREEN, GCHROMA_KEY_S, 0 )
	}
	gchroma.SendFunctions( activator, tbl )
end
```

&nbsp;

# Shared Functions

# gchroma.ToVector( `color` color )
 ## Description
 Converts a Lua color table into a vector so that it can be used in the GChroma color functions.

 ## Arguments
 1. `color` color - Color table to be converted.

&nbsp;

# Enums
 See [gchroma_enums.lua](https://github.com/LambdaGaming/GChroma_Lua_Base/blob/main/lua/autorun/gchroma_enums.lua)
