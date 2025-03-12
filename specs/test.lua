require("core");

local Colors = Typing.Enum.complex({
    Red = "FF0000",
    Green = "00FF00",
    Blue = "0000FF",
}, "string");

--[[
{
    ["Green"] = "00FF00";
    ["Red"] = "FF0000";
    ["Blue"] = "0000FF";
}
]]
print(Fmt:resolveTable(Colors, 1));

local Vector2 = Typing.Class.new():setClassName("Vector2"):property("x", 0, true, true);
local Vector3 = Typing.Class.new():setClassName("Vector3"):inherit(Vector2);

Performer:ruleValidity(Vector3, {
    x = "number",
    setX = "function",
    getX = "function",
});

--[[
{
    ---@type string, function
    ["setX"] = <function: 0000000000e93b00>,
    ---@type string, string
    ["className"] = "Vector2",
    ---@type string, number
    ["x"] = 0,
    ---@type string, function
    ["getX"] = <function: 0000000000e93600>
}
]]
print(Fmt:resolveTable(Vector2, 1, true));
