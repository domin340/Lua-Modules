require("core");

local Colors = Typing.Enum.complex({
    Red = "FF0000",
    Green = "00FF00",
    Blue = "0000FF",
}, "string");

--[[
@Enum {
    ["Green"] = "00FF00";
    ["Red"] = "FF0000";
    ["Blue"] = "0000FF";
}
]]
print(Fmt:enum(Colors));

local Vector2 = Typing.Class.new():setClassName("Vector2"):property("x", 0, true, true);
local Vector3 = Typing.Class.new():setClassName("Vector3"):inherit(Vector2);

Performer:ruleValidity(Vector3, {
    x = "string",
    setX = "function",
    getX = "function",
});
