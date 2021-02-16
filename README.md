![GChroma Logo](logo.png)

# About
 GChroma is a link between Garry's Mod and Razer Synapse. It allows developers to integrate Chroma support into their addons through Lua. The module is available for Windows x86 and Windows x64. The Lua documentation can be found [here](https://github.com/LambdaGaming/GChroma/blob/main/doc.md) and some examples can be found [here](https://github.com/LambdaGaming/GChroma_Player_Module) and [here.](https://github.com/LambdaGaming/GChroma_Lua_Base)

&nbsp;

# Installing
 1. Make sure you have Razer Synapse 3 installed and running with the Chroma Connect module installed as well, and obviously make sure you have a device that supports Razer Synapse 3. (Legacy Synapse versions might work but are unsupported by me.)
 2. Download the GChroma base addon from [here.](https://steamcommunity.com/sharedfiles/filedetails/?id=2297412726)
 3. Download the latest GChroma binary module from [here.](https://github.com/LambdaGaming/GChroma/releases) Make sure you download the 32-bit version unless you're running the x86-64 branch.
 4. Move the downloaded binary module to `steamapps/common/garrysmod/garrysmod/lua/bin`. You may have to create the bin folder yourself.
 5. Download GChroma-supported addons from [here](https://steamcommunity.com/workshop/filedetails/?id=2297418480), or start developing your own. Enjoy!

&nbsp;

# Contributing/Compiling
- If you want to contribute, please read the [contributing guidelines](https://lambdagaming.github.io/contributing.html) before making a pull request.
- The project files for Visual Studio 2019 are included. You will need to download and add the [Garry's Mod binary module headers](https://github.com/Facepunch/gmod-module-base/tree/development) as well as add the Razer Chroma SDK headers, which should automatically download with [Razer Synapse](https://www.razer.com/synapse-3).

&nbsp;

# FAQs
 ## Does this work on servers?
 Yes, but the server needs to have the base addon for it to work on your end.

 ## Is support for Linux/Mac planned?
 Currently, no. This is partly due to Razer Synapse only natively supporting Windows.

 ## Does this work on beta branches of the game?
 It works on the x86-64 branch. Other branches haven't been tested.

 ## Is animation support planned?
 No. While it may be possible, it would require rewriting a significant portion of the module. On top of that, animations require special .chroma files to work, which are currently not allowed by the workshop publishing tool.

 ## Does this work with 3rd party devices?
 If your RGB software is picked up by Razer Synapse as a device there's a good chance it will work. MSI MysticLight seems to work as long as you turn on Game Sync.

&nbsp;

# Legal
 - All GChroma content made by me, [Source 2 Gman](https://steamcommunity.com/profiles/76561198136556075), AKA [LambdaGaming](https://github.com/LambdaGaming) is licensed under the [MIT license.](https://github.com/LambdaGaming/GChroma/blob/main/LICENSE)
 - RAZER is the trademark or registered trademark of Razer Inc. Razer has no affiliation whatsoever with me or my addons.
