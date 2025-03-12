# Lua-Modules

A pack of handy free to use Lua files consisting of for instance easy to use Enum or Class table.

## Included modules

All modules are meant to placed inside of core direction to stay consistent unless you import a singular one.
In examples we will assume core.init is imported like that!

```lua
require("core");

-- do your thing!
```

### Typing

Module devoted for strict and safe typing for your application.
This module consists of:

#### Enum

Works just like in other languagues with exception for possible custom type checking.

```lua
local Colors = Typing.Enum.complex({
    Red = "FF0000",
    Green = "00FF00",
    Blue = "0000FF",
    -- Yellow = 3; -- this will error, expected type is string
}, "string"); -- you can also give here your custom method of type fun(key, value): boolean

Colors.Red = "AA00AA" -- you are not allowed to change property of an enum, this errors
print(Colors.Red) -- "FF0000"

-- this checks whenever Enum has at least one of these.
-- if you want it to check whenever enum has all of these use "all" instead of "one" in given parameters
print(Typing.Enum.has(Colors, "one", "Red", "Green"))

print(Typing.Enum.Yellow) -- nil
print(Typing.Enum.get(Colors, "Yellow")) -- this errors, no Yellow key found

-- you want to define just simple string-number enum? alrighty!
local Directions = Typing.Enum.new({ "Left", "Right", --[[ and so on]] }) -- if you give a number as a key it will error
```

#### Class

Just as you expect this type allows you to create a class

```lua
---@class Vector2 : Class
---@field x number
---and so on.. Add your setter and getter if you need to it is a great way to keep type safety tight, add this if you used property
-- setClassName can be skipped but it allows you to stringify class better!
local Vector2 = Typing.Class.new():setClassName("Vector2")

-- don't feel like writting getters and setters? no problem!
-- key, defaultValue, getter?, setter?
Vector2:property("x", 0, true, true);

print(tostring(Vector2) --[[[ or Class:stringify() ]]) -- @Vector2(nil)

-- modify class again for type safety if you need to
-- chaining is possible too!
-- after you inherit the class, you gain a new property called base if it already exist method will raise an error
-- in a case when you still need to merge tables you ought to use Class:extend instead
Vector2:inherit(Typing.Class.new():setClassName("newClass"):property("age", 18, true, false));

print(tostring(Vector2) --[[[ or Class:stringify() ]]) -- @Vector2(@newClass(nil))

print(Vector2:super()) -- if base does not exist it will error unlike if you did Vector2.base

```

### Fmt

Simple formatting module.
Recommended to play around with, frequently used with tables or formatting rows.
You can also format your enum using this via resolveTable method.

### Performer

Goes in handy if you need to check whenever a class is writtin in specific rules.

In case when you need to iterate through keys and values use perform method.
In case when you need to check whenever all properties are defined as you imaged use ruleValidity.

## Planned new modules

1. EventManager and Group (allows you to emit signals and listen for them)
2. Container (similar to javascript's array)
