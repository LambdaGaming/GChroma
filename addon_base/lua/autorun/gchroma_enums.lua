AddCSLuaFile()

gchroma = gchroma or {}
gchroma.Pending = {}

--Colors
color_red = Color( 255, 0, 0 )
color_green = Color( 0, 255, 0 )
color_blue = Color( 0, 0, 255 )
color_magenta = Color( 255, 0, 255 )
color_yellow = Color( 255, 255, 0 )
color_cyan = Color( 0, 255, 255 )
color_orange = Color( 255, 89, 0 )
color_lightgray = Color( 170, 170, 170 )
color_darkgray = Color( 25, 25, 25 )
color_pink = Color( 255, 0, 89 )
color_purple = Color( 89, 0, 255 )

--Device types
gchroma.DeviceType = {
    All = -1,
    Motherboard = 0,
    RAM = 1,
    GPU = 2,
    Cooler = 3,
    LEDStrip = 4,
    Keyboard = 5,
    Mouse = 6,
    MouseMat = 7,
    Headset = 8,
    HeadsetStand = 9,
    Gamepad = 10,
    Light = 11,
    Speaker = 12,
    Virtual = 13,
    Unknown = 14
}

--Function types
gchroma.FuncType = {
    DeviceColor = 1,
    LEDColor = 2
}

--Key names
--Names are based on Gmod's key names
--Values are based on https://github.com/CalcProgrammer1/OpenRGB/blob/master/RGBController/RGBControllerKeyNames.cpp
gchroma.Key = {
    ESCAPE = "Key: Escape",
    F1 = "Key: F1",
    F2 = "Key: F2",
    F3 = "Key: F3",
    F4 = "Key: F4",
    F5 = "Key: F5",
    F6 = "Key: F6",
    F7 = "Key: F7",
    F8 = "Key: F8",
    F9 = "Key: F9",
    F10 = "Key: F10",
    F11 = "Key: F11",
    F12 = "Key: F12",
    ["1"] = "Key: 1",
    ["2"] = "Key: 2",
    ["3"] = "Key: 3",
    ["4"] = "Key: 4",
    ["5"] = "Key: 5",
    ["6"] = "Key: 6",
    ["7"] = "Key: 7",
    ["8"] = "Key: 8",
    ["9"] = "Key: 9",
    ["0"] = "Key: 0",
    A = "Key: A",
    B = "Key: B",
    C = "Key: C",
    D = "Key: D",
    E = "Key: E",
    F = "Key: F",
    G = "Key: G",
    H = "Key: H",
    I = "Key: I",
    J = "Key: J",
    K = "Key: K",
    L = "Key: L",
    M = "Key: M",
    N = "Key: N",
    O = "Key: O",
    P = "Key: P",
    Q = "Key: Q",
    R = "Key: R",
    S = "Key: S",
    T = "Key: T",
    U = "Key: U",
    V = "Key: V",
    W = "Key: W",
    X = "Key: X",
    Y = "Key: Y",
    Z = "Key: Z",
    NUMLOCK = "Key: Num Lock",
    KP_INS = "Key: Number Pad 0",
    KP_END = "Key: Number Pad 1",
    KP_DOWNARROW = "Key: Number Pad 2",
    KP_PGDN = "Key: Number Pad 3",
    KP_LEFTARROW = "Key: Number Pad 4",
    KP_5 = "Key: Number Pad 5",
    KP_RIGHTARROW = "Key: Number Pad 6",
    KP_HOME = "Key: Number Pad 7",
    KP_UPARROW = "Key: Number Pad 8",
    KP_PGUP = "Key: Number Pad 9",
    KP_SLASH = "Key: Number Pad /",
    KP_MULTIPLY = "Key: Number Pad *",
    KP_MINUS = "Key: Number Pad -",
    KP_PLUS = "Key: Number Pad +",
    KP_ENTER = "Key: Number Pad Enter",
    KP_DEL = "Key: Number Pad .",
    PRINTSCREEN = "Key: Print Screen",
    SCROLLLOCK = "Key: Scroll Lock",
    PAUSE = "Key: Pause/Break",
    INS = "Key: Insert",
    HOME = "Key: Home",
    PGUP = "Key: Page Up",
    DELETE = "Key: Delete",
    END = "Key: End",
    PGDN = "Key: Page Down",
    UPARROW = "Key: Up Arrow",
    LEFTARROW = "Key: Left Arrow",
    DOWNARROW = "Key: Down Arrow",
    RIGHTARROW = "Key: Right Arrow",
    TAB = "Key: Tab",
    CAPSLOCK = "Key: Caps Lock",
    BACKSPACE = "Key: Backspace",
    ENTER = "Key: Enter",
    CTRL = "Key: Left Control",
    LWIN = "Key: Left Windows",
    ALT = "Key: Left Alt",
    SPACE = "Key: Space",
    RALT = "Key: Right Alt",
    FN = "Key: Left Fn", --Not sure if this is supposed to be right or left
    RMENU = "Key: Menu",
    RCTRL = "Key: Right Control",
    SHIFT = "Key: Left Shift",
    RSHIFT = "Key: Right Shift"
}

local r = Color( 255, 0, 0 )
local g = Color( 0, 255, 0 )
local b = Color( 0, 0, 255 )
MsgC( r, "GC", g, "hro", b, "ma", color_white, " v2.0 by OPGman successfully loaded.\n" )
