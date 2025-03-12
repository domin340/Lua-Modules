local PATH = string.sub(..., 1, string.len(...) - string.len("typing"));

---@class TypingModule
return {
    ---@module "typing.class"
    Class = require(PATH .. "typing.class"),

    ---@module "typing.enum"
    Enum = require(PATH .. "typing.enum"),
};
