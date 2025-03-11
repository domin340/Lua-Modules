require("core");

local Colors = Typing.Enum.complex({
    Red = "FF0000",
    Green = "00FF00",
    Blue = "0000FF",
}, "string");

--[[
@Enum {
    ---@type string, string
    ['Blue'] = 0000FF;

    ---@type string, string
    ['Green'] = 00FF00;

    ---@type string, string
    ['Red'] = FF0000;
}
]]
print(DebugFmt:enum(Colors));

local Vector2 = Typing.Class.new():setClassName("Vector2");
local Vector3 = Typing.Class.new():setClassName("Vector3"):inherit(Vector2);

--[[
@Vector3 {
    Stringified: @Vector3(@Vector2(nil))
    Inherits: @Vector2 {
        Stringified: @Vector2(nil)
        Inherits: Nothing
    }
}
]]
print(DebugFmt:classInfo(Vector3));
