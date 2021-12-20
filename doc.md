# GChroma Lua Documentation
 Below is the current list of Lua functions and enums available for developers to use to integrate GChroma with their addons.

&nbsp;

# Before You Start
 Before you start developing for GChroma, take note of the following:
 1. Make sure your addon doesn't interfere with other addons. GChroma has no way of knowing what addon is supposed to take priority, so it will always override the current color grid with the one that was called last. If at all possible, it is recommended you call a function from the last addon to use the grid to make sure colors are restored. You should only do this if you have a way of knowing whether or not that addon is installed, otherwise players who don't have it will get errors.
 2. Avoid running resource-intensive functions in loops, specifically `gchroma.CreateEffect()` and `gchroma.SendFunctions()`. Failure to do so may result in the SDK taking a long time to process the changes. Looping timers or cooldowns with a time of at least 0.1 seconds should be used if you plan on rapidly changing colors.

&nbsp;

# Shared Functions
 These functions are available on both the client and server, though for best performance it's recommended that you use the them client-side whenever possible.

## gchroma.SetDeviceColor( `number` device, `vector` color )
 ### Description
 Sets the specified device to a solid color. Individual LEDs cannot be changed with this function.

 ### Arguments
 1. `number` device - Device ID. See enums section below for available devices.

 2. `vector` color - Color to set the device. Must be a vector. Use `gchroma.ToVector()` if you need to convert an existing color table to a vector. Using `color:ToVector()` will cause the LEDs to be extremely dim since it uses a range of 0-1 instead of 0-255.

 ### Example 1
 Sets the color of all available devices to blue.
 ``` lua
if gchroma then --If your addon isn't exclusively made for GChroma, add this check to avoid errors
	gchroma.SetDeviceColor( GCHROMA_DEVICE_ALL, Vector( 0, 0, 255 ) )
	gchroma.CreateEffect()
end
 ```

 ### Example 2
 Sets the color of all available devices to the color of the entity that the client has used.
 ``` lua
--Assume this function is in a shared file
function ENT:Use( ply )
	if CLIENT and gchroma then
		gchroma.SetDeviceColor( gchroma, GCHROMA_DEVICE_ALL, gchroma.ToVector( self:GetColor() ) )
		gchroma.CreateEffect( gchroma )
	end
end
 ```

&nbsp;

## gchroma.SetDeviceColorEx( `number` device, `vector` color, `number` row, `number` col )
 ### Description
 Sets the color of the specified device LED. If you are setting the color for a keyboard or mouse, you can use their respective LED enums and set the col argument to 0. If you are using a different device, see the [Chroma LED Profiles](https://developer.razer.com/works-with-chroma/razer-chroma-led-profiles/) for what row and column you should use.

 ### Arguments
 1. `number` device - Device ID. See enums section below for available devices. Note that the GCHROMA_DEVICE_ALL enum will NOT work with this function.

 2. `vector` color - Color to set the device. Must be a vector. Use `gchroma.ToVector()` if you need to convert an existing color table to a vector. Using `color:ToVector()` will cause the LEDs to be extremely dim since it uses a range of 0-1 instead of 0-255.

 3. `number` row - Row of the device LED.

 4. `number` col - Column of the device LED.

 ### Example 1
 Sets the mouse scroll wheel color to blue.
 ``` lua
if gchroma then
	gchroma.SetDeviceColorEx( GCHROMA_DEVICE_MOUSE, Vector( 0, 0, 255 ), GCHROMA_MOUSE_SCROLLWHEEL, 0 )
	gchroma.CreateEffect()
end

--This does the same thing as above, but uses the grid system instead of enums
if gchroma then
	gchroma.SetDeviceColorEx( GCHROMA_DEVICE_MOUSE, Vector( 0, 0, 255 ), 2, 3 )
	gchroma.CreateEffect()
end
 ```

 ### Example 2
 Sets the W key on the keyboard to red.
 ``` lua
if gchroma then
	gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, Vector( 255, 0, 0 ), GCHROMA_KEY_W, 0 )
	gchroma.CreateEffect()
end
 ```

 ### Example 3
 Sets the top left corner of the mousepad to green.
 ``` lua
if gchroma then
	gchroma.SetDeviceColorEx( GCHROMA_DEVICE_MOUSEPAD, Vector( 0, 255, 0 ), 0, 0 )
	gchroma.CreateEffect()
end
 ```

&nbsp;

## gchroma.ResetDevice( `number` device )
 ### Description
 Resets the colors of the specified device to 0, 0, 0.

 ### Arguments
 1. `number` device - Device ID. See enums section below for available devices.

&nbsp;

## gchroma.ToVector( `color` color )
 ### Description
 Converts a Lua color table into a vector so that it can be used in the GChroma color functions.

 ### Arguments
 1. `color` color - Color table to be converted.

&nbsp;

# Client Functions

## gchroma.CreateEffect()
 ### Description
 Creates a new effect by applying the changes made using the other functions. This is always required when you are finished modifying colors.

 ### Example 1
 Sets all 4 corners of the mouse pad to green.
 ``` lua
 if gchroma then
	local grid = { 0, 4, 10, 14 }
	for k,v in pairs( grid ) do
	    gchroma.SetDeviceColorEx( GCHROMA_DEVICE_MOUSEPAD, GCHROMA_COLOR_GREEN, v, 0 )
	end
	gchroma.CreateEffect()
 end
 ```

&nbsp;

## gchroma.KeyConvert( `number` key )
 ### Description
 Converts a Garry's Mod key into a GChroma key. May not work for every key.

 ### Arguments
 1. `number` key - Garry's Mod key to be converted.

 ### Example 1
 Sets the color of the key bound to voice chat to green.
 ``` lua
gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, Vector( 0, 255, 0 ), gchroma.KeyConvert( input.GetKeyCode( input.LookupBinding( "voicerecord" ) ) ), 0 )
 ```

&nbsp;

# Server Functions

## gchroma.SendFunctions( `player` ply )
 ### Description
 Server-side version of `gchroma.CreateEffect()`. Sends a net message to the player to apply the changes made using the other functions.

 ### Arguments
 1. `player` ply - Player who will receive the effects

 ### Example 1
 Sets the color of all available devices to blue.
 ``` lua
for k,v in ipairs( player.GetAll() ) do --This sends the message to all players for the example, but generally you should avoid doing this since the majority of players likely won't be able to use it
	gchroma.SetDeviceColor( GCHROMA_DEVICE_ALL, Vector( 0, 0, 255 ) )
	gchroma.SendFunctions( v )
end
 ```

 ### Example 2
 Resets all devices and sets the W key to red and S key to green.
``` lua
function ENT:Use( activator, caller )
	gchroma.ResetDevice( GCHROMA_DEVICE_ALL )
	gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_RED, GCHROMA_KEY_W, 0 )
	gchroma.SetDeviceColorEx( GCHROMA_DEVICE_KEYBOARD, GCHROMA_COLOR_GREEN, GCHROMA_KEY_S, 0 )
	gchroma.SendFunctions( activator )
end
```

&nbsp;

# Enums
 See [gchroma_enums.lua](https://github.com/LambdaGaming/GChroma_Lua_Base/blob/main/lua/autorun/gchroma_enums.lua)
