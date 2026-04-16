![GChroma Logo](logo.png)

# About
 GChroma is a link between Garry's Mod and OpenRGB. It allows addons to interact with client RGB hardware through a Lua API. The module is available for the 64-bit version of Garry's Mod on Windows 10/11 and Linux.  
 [API documentation](dev.md)  
 [Steam Workshop addon](https://steamcommunity.com/sharedfiles/filedetails/?id=2297412726)  
 [Old Razer Synapse version](https://github.com/LambdaGaming/GChroma/releases/tag/v1.4)

# How to Use
 1. Make sure you're running the x86-64 beta branch for Garry's Mod, and that the game is set to launch in 64-bit mode. GChroma does not support 32-bit mode.
 2. Install [OpenRGB](https://openrgb.org/), launch it, and start the SDK server. If needed, you can change the IP and port that GChroma uses through the `gchroma_ip` and `gchroma_port` client-side ConVars.
 3. Download the [GChroma base addon](https://steamcommunity.com/sharedfiles/filedetails/?id=2297412726) and the latest [GChroma binary module.](https://github.com/LambdaGaming/GChroma/releases) If you're running Garry's Mod through Proton on Linux, you will need to download the Windows version of the module.
 4. Move the downloaded binary module to `[Steam installation]/steamapps/common/GarrysMod/garrysmod/lua/bin`. You might have to create the bin folder since it doesn't exist by default.
 5. Download GChroma-supported addons or start developing your own. Enjoy!

# Default Lighting Events
 The base addon comes with default lighting events that light up keys or devices at specific times. The following events are currently implemented:
 - When spawning, certain sandbox keybinds will light up on your keyboard in your player color. These keybinds include the weapon slot number keys, noclip, regular and team text chats, spawn menu, context menu, flashlight, and voice chat.
 - When pressing the aforementioned keys, they will light up white until the action you're performing with them ends.
 - When you die, all devices will light up red until you respawn.

# Building
1. Clone this repo with git. Don't download the zip because the submodules won't be included.
2. Install CMake.
3. Run `build_linux.sh` if you're on Linux and `build_windows.bat` if you're on Windows. The dll files will be copied to the modules folder and the build scripts will automatically clean up all other generated files.

# FAQs
 ### Does this work on servers?
 Yes, but the server needs the Lua base for all features to work. Servers do not need the binary module.

 ### Will this work with my device?
 That depends entirely on whether or not your device is supported by OpenRGB. There's a good chance it will work, but if it doesn't it's out of my control.

 ### Why did you switch to OpenRGB? What was wrong with Razer Synapse?
 The main reason is because I don't use Windows regularly anymore, so if I wanted to keep this project going I had to switch to something that supports Linux. OpenRGB also has the benefit of supporting a much wider range of devices and allowing for more simplistic code.
