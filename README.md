# About
 GChroma is a link between Garry's Mod and Razer Synapse. It allows developers to integrate Chroma support into their addons through Lua. The module is available for Windows x86 and Windows x64. The Lua documentation can be found [here](https://github.com/LambdaGaming/GChroma/blob/main/doc.md) and some examples can be found [here.](https://github.com/LambdaGaming/GChroma/tree/main/Addons)

&nbsp;

# Note
 This module is still in early development, so expect bugs, crashes, performance issues, all that jazz.

&nbsp;

# Note to Developers
 When adding support to your addon, make sure it doesn't interfere with other addons. GChroma currently has no way of knowing what addon is supposed to take priority.

&nbsp;

# Planned Features
- Some way of creating instances of the GChroma C++ class through Lua so developers can assign all of the colors they want before anything is sent over to Synapse, which should help with performance.
- Support for patterns so developers don't have to use loops on the existing functions, which should also help with performance.
- Possible support for 3rd party, non-razer devices that support Synapse such as LED strips.

&nbsp;

# FAQs
 ## Does this work on servers?
 Yes, but the server needs to have the base addon for it to work on your end.

 ## Is support for Linux/Mac planned?
 Currently, no. This is partly due to Razer Synapse only natively supporting Windows.

 ## Does this work on beta branches of the game?
 It works on the x86-64 branch. Other branches haven't been tested.
