![GChroma Logo](logo.png)

# About
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

 ### Are there plans to support other operating systems or RGB apps?
 There are no plans to support Linux or Mac. It's not worth the effort since most people with RGB peripherals are running Windows, and Razer Synapse only officially supports Windows anyway.  
 Other apps may be supported if they are detected as a device by Razer Synapse. At some point I may add support for Windows 11's new dynamic lighting system. I'm currently waiting to see how popular it gets and how easy it is to develop for. Ideally, it would allow GChroma to support a wide range of devices with minimal effort, but we'll see if that ends up being the case.

 ### Does this work on beta branches of the game?
 It works on the x86-64 branch. Other branches haven't been tested but they will probably work as well.

 ### Is animation support planned?
 Eventually, yes.

 ### Does this work with non-English keyboards?
 Probably, but I can't guarantee individual keys will light up properly since both the GChroma API and the Razer Synapse SDK use English letters.

# Legal
 - RAZER is the trademark or registered trademark of Razer Inc. GChroma is not affiliated in any way with Razer.
