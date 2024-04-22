![GChroma Logo](logo.png)

# About
 NOTE: I've switched to Linux and no longer have the ability to maintain this addon in it's current state, and I do not have any interest in making it work on Linux, so it has been archived.

 GChroma is a link between Garry's Mod and Razer Synapse. It allows developers to integrate Chroma support into their addons through Lua. The module is available for Windows 10/11, and supports x86 and x64 architectures.  
 [API documentation](https://github.com/LambdaGaming/GChroma/blob/main/doc.md)  
 [GChroma Lua Base](https://steamcommunity.com/sharedfiles/filedetails/?id=2297412726)  
 [GChroma Sandbox Module](https://steamcommunity.com/sharedfiles/filedetails/?id=2297434661)

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

 ### Does this work on beta branches of the game?
 It works on the x86-64 branch. Other branches haven't been tested but they will probably work as well.

 ### Does this work with non-English keyboards?
 Probably, but I can't guarantee individual keys will light up properly since the GChroma API only uses the English key identifiers.

# Legal
 - RAZER is the trademark or registered trademark of Razer Inc. GChroma is not affiliated in any way with Razer.
