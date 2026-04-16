# GChroma Developer Documentation
 Below is the current list of Lua functions, hooks, and more available for developers to use to integrate GChroma with their addons.

# Before You Start
 Before you start developing for GChroma, take note of the following:
 1. If GChroma is optional for your addon, you should write checks to see if the `gchroma` global table exists prior to calling any GChroma functions. This will prevent players who don't have GChroma installed from getting errors.
 2. GChroma has no way of knowing what addon is supposed to take priority, so it will always override whatever colors are currently set. Be careful about where and when you set colors to avoid conflicts with other GChroma-compatible addons.
 3. Making several calls to `gchroma.SetDeviceColor` or `gchroma.SetLEDColor` in rapid succession should be avoided whenever possible. Every time you call either of these functions, a request is sent to your OpenRGB server, which causes noticeable lag.

# Functions
## gchroma.Connect( `string` ip, `number` port )
### Scope: Client
### Description
 Used internally to initialize a new connection to the OpenRGB server. You should only use this if you plan on overriding GChroma's default initialization behavior. Only one connection can be active at once. Returns true if the connection was successful.
### Arguments
 1. `string` ip - IP address or domain name of the OpenRGB server.
 2. `number` port - Port number for the server.

## gchroma.IsConnected()
### Scope: Client
### Description
 Returns true if the addon is currently connected to an OpenRGB server, otherwise false.

## gchroma.KeyConvert( `number` key OR `string` binding )
### Scope: Client
### Description
 Converts a Garry's Mod key into a GChroma key. Returns an empty string if the conversion fails. Does not support non-English keys.
### Arguments
 1. `number` key - Key code to be converted.  
 OR  
 1. `string` binding - Binding name for the input.
### Example 1
 Sets the color of the key bound to voice chat to orange.
``` lua
gchroma.SetDeviceColor( gchroma.DeviceType.Keyboard, gchroma.KeyConvert( "voicerecord" ), color_orange )
```

## gchroma.GetDeviceInfo( `number` deviceType )
### Scope: Client
### Description
 Returns a table containing info about the specified device. Intended to be used for debugging.
### Arguments
 1. `number` device - Device ID.
### Example 1
``` lua
PrintTable( gchroma.GetDeviceInfo( gchroma.DeviceType.Keyboard ) )
```

## gchroma.SetDeviceColor( `number` deviceType, `color` color )
### Scope: Shared
### Description
 Sets the specified device to a solid color. Individual LEDs cannot be changed with this function. On the server, this function will add data to a queue that will need to be sent using `gchroma.SendFunctions()`.  
### Arguments
 1. `number` device - Device ID. See enums section below for available devices.  
 2. `color` color - Color to set the device. Also accepts a table as long as it has 3 number values.
### Example 1
 Sets the color of all available devices to blue.
 ``` lua
if !gchroma then return end --If your addon isn't exclusively made for GChroma, add this check to avoid errors
gchroma.SetDeviceColor( gchroma.DeviceType.All, color_blue )
 ```
### Example 2
 Sets the color of all available devices to the color of the entity that the client has used.
 ``` lua
--Assume this function is server-side only
function SetColors( ply )
    gchroma.SetDeviceColor( gchroma.DeviceType.Keyboard, color_red )
    gchroma.SetDeviceColor( gchroma.DeviceType.Mouse, color_blue )
    gchroma.SendFunctions( ply )
end
 ```

## gchroma.SetLEDColor( `number` deviceType, `string` name, `color` color )
### Scope: Shared
### Description
 Sets the color of a single LED for the specified device. On the server, this function will add data to a queue that will need to be sent using `gchroma.SendFunctions()`.  
### Arguments
 1. `number` device - Device ID. See enums section below for available devices.  
 2. `string` name - Name of the LED. See [enums](lua/gchroma/sh_enums.lua) for a list of popular ones. You can also see what names are available for your devices with `gchroma.GetDeviceInfo()`.
 2. `color` color - Color to set the device. Also accepts a table as long as it has 3 number values.
### Example 1
 Sets a dark gray background color then sets the 1 and M keys to red.
 ``` lua
gchroma.SetDeviceColor( gchroma.DeviceType.All, color_darkgray )
gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, gchroma.Key["1"], color_red )
gchroma.SetLEDColor( gchroma.DeviceType.Keyboard, gchroma.Key.M, color_red )
 ```

## gchroma.SendFunctions( `player` ply )
### Scope: Server
### Description
 Sends a net message to the player to apply the changes made using the server-side versions of SetDeviceColor and SetLEDColor.
### Arguments
 1. `player` ply - Player who will receive the effects

# Hooks
 All hooks are client-side only and return the values of the functions associated with them.
## GChromaInitialized
### Description
  Gets called when the module is first loaded. Does not get called if the module fails to load.

# Enums
 See [gchroma_enums.lua](lua/gchroma/sh_enums.lua)
