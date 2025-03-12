local PATH = string.sub(..., 1, string.len(...) - string.len("typing.enum"));

---@module "core.performer"
local TypeChecker = require(PATH .. "performer");

---@class Enum
local Enum = {};

---@type string
Enum.prefix = "Enum";

-- ENUM UTILITIES
-- ----------------------------------------------

---@param table table
---@return table<string, number>
local function arrayToPairs(table)
    local proxy = {};

    for index, value in ipairs(table) do
        proxy[value] = index;
    end

    return proxy;
end

---@param message string
function Enum:newError(message)
    error("[" .. self.prefix .. "] " .. message, 1);
end

function Enum.count(enum)
    local length = 0;

    for _ in pairs(enum) do
        length = length + 1;
    end

    return length
end

-- ----------------------------------------------

-- ENUM TYPING
-- ----------------------------------------------

---@alias EnumMiddleware fun(value: any): boolean

---@param enum table
---@param checker EnumMiddleware | nil
---@param keyType "string" | "number" | nil
function Enum.internalTypeCheck(enum, keyType, checker)
    TypeChecker:perform(enum, function(key, value)
        -- check if the key type is the expected one
        if keyType and type(key) ~= keyType then
            return false, 1;
        end

        -- run internal checker
        if checker and not checker(value) then
            return false, 2;
        end

        return true;
    end);
end

---@vararg string
---@param enum table<string, any>
---@param t "one" | "all"
---@return boolean
function Enum.has(enum, t, ...)
    ---Return type
    ---@type boolean
    local rt = t == "one" and true or false

    for n = 1, select("#", ...) do
        local key = select(n, ...);
        if enum[key] ~= nil then
            return rt;
        end
    end

    return not rt;
end

---Returns error if key is not inside of enum else value
---@generic T
---@param enum table<string, T>
---@return T
function Enum.get(enum, key)
    if not enum[key] then
        Enum:newError("key: " .. key .. " not found inside of enum!")
    end
    return enum[key];
end

-- ----------------------------------------------

-- CONSTRUCTORS
-- ----------------------------------------------

---@param enum table<string, any>
local function sealAndDebug(enum)
    local enumLength = Enum.count(enum);
    return setmetatable({}, {
        __index = enum,
        __newindex = function(_, key, value)
            Enum:newError(
                " Attempted to create a new index: " ..
                "{ " .. key .. " = " .. value .. " }"
            );
        end,
        __pairs = function()
            return pairs(enum);
        end,
        __len = function()
            return enumLength;
        end,
    });
end

---@generic T
---@param enum table<string, T>
---@param t type | EnumMiddleware | nil
---@return table<string, T>
function Enum.complex(enum, t)
    -- Ensure enum structure validity
    -- ----------------------------------------------
    t = t or "number";

    ---@type EnumMiddleware
    local checker = type(t) == "function" and t or function(b)
        return type(b) == t;
    end

    Enum.internalTypeCheck(enum, "string", checker);
    -- ----------------------------------------------

    return sealAndDebug(enum);
end

---@param enum table
---@return table<string, number>
function Enum.new(enum)
    Enum.internalTypeCheck(enum, "number");
    return sealAndDebug(arrayToPairs(enum));
end

-- ----------------------------------------------

return Enum;
