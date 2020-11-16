# About
 GChroma is a link between Garry's Mod and Razer Synapse. It allows developers to integrate Chroma support into their addons through Lua. The module is available for Windows x86 and Windows x64. The Lua documentation can be found [here](https://github.com/LambdaGaming/GChroma/blob/main/doc.md) and some examples can be found [here.](https://github.com/LambdaGaming/GChroma/tree/main/Addons)

&nbsp;

# Note
 This module is still in early development, so expect bugs, crashes, performance issues, all that jazz.

&nbsp;

# Installing
 1. Make sure you have Razer Synapse 3 installed and running with the Chroma Connect module installed as well, and obviously make sure you have a device that supports Razer Synapse 3. (Legacy Synapse versions might work but are unsupported by me.)
 2. Download the GChroma base addon from [here.]()
 3. Download the latest GChroma binary module from [here.](https://github.com/LambdaGaming/GChroma/releases) Make sure you download the 32-bit version unless you're running the x86-64 branch.
 4. Move the downloaded binary module to `steamapps/common/garrysmod/garrysmod/lua/bin`. You may have to create the bin folder yourself.
 5. Download GChroma-supported addons from [here](), or start developing your own. Enjoy!

&nbsp;

# Planned Features
- Support for patterns so developers don't have to use loops on the existing functions, which should help with performance.
- Possible support for 3rd party, non-razer devices that support Synapse such as LED strips and computer hardware.
- Better Lua enums so more keys obtained with `input.LookupBinding()` are supported.

&nbsp;

# FAQs
 ## Does this work on servers?
 Yes, but the server needs to have the base addon for it to work on your end.

 ## Is support for Linux/Mac planned?
 Currently, no. This is partly due to Razer Synapse only natively supporting Windows.

 ## Does this work on beta branches of the game?
 It works on the x86-64 branch. Other branches haven't been tested.
