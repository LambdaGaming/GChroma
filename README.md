![GChroma Logo](logo.png)

# About
 GChroma is a link between Garry's Mod and Razer Synapse. It allows developers to integrate Chroma support into their addons through Lua. The module is available for Windows 10/11, and supports x86 and x64 architectures.  
 [API documentation](https://github.com/LambdaGaming/GChroma/blob/main/doc.md)  
 [GChroma Lua Base](https://github.com/LambdaGaming/GChroma_Lua_Base)  
 [GChroma Sandbox Module](https://github.com/LambdaGaming/GChroma_Sandbox_Module)

# Installing
 1. Make sure you have Razer Synapse 3 installed and running with the Chroma Connect module installed as well, and obviously make sure you're using a device that's supported by Razer Synapse 3. (Older Synapse versions are unsupported and will likely not work.)
 2. Download the [GChroma base addon.](https://steamcommunity.com/sharedfiles/filedetails/?id=2297412726)
 3. Download the latest [GChroma binary module.](https://github.com/LambdaGaming/GChroma/releases) Make sure you download the 32-bit version unless you're using the x86-64 beta branch.
 4. Move the downloaded binary module to `[Steam directory]/garrysmod/garrysmod/lua/bin`. You might have to create the bin folder since it doesn't exist by default.
 5. Download GChroma-supported addons or start developing your own. Enjoy!

# Contributing
- If you want to contribute by making an issue or pull request, please read the [contributing guidelines](https://lambdagaming.github.io/contributing.html) first.
- The project files for Visual Studio are included. The required header files are linked in this repo as submodules.

# FAQs
 ### Does this work on servers?
 Yes, but the server needs the Lua base for it to work on your end. Servers do not need the binary module.

 ### Is support for Linux/Mac planned?
 No. Razer Synapse only supports Windows, and there are currently no plans to support other RGB software.

 ### Does this work on beta branches of the game?
 It works on the x86-64 branch. Other branches haven't been tested but they will probably work as well.

 ### Is animation support planned?
 Eventually, yes.

 ### Does this work with 3rd party devices?
 If your RGB software is detected by Razer Synapse as a device, there's a good chance it will work. For example, MSI MysticLight works as long as the Game Sync setting is turned on.

 ### Does this work with non-English keyboards?
 Probably, but I can't guarantee individual keys will light up properly since both the GChroma API and the Razer Synapse SDK use English letters.

# Legal
 - RAZER is the trademark or registered trademark of Razer Inc. GChroma is not affiliated in any way with Razer.
