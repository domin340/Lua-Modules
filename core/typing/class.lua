---@class Class
local Class = {}

---@type Class | nil
Class.base = nil;

---@type string | nil
Class.className = nil;

-- GETTERS AND SETTERS
-- ----------------------------------------------

function Class:stringify()
    return string.format(
        "@%s(%s)",
        self.className or "Class",
        tostring(self.base)
    );
end

---@return Class
function Class:super()
    if not self.base then
        self:newError("class is not inherited yet!");
    end
    return self.base;
end

---@param name string | nil
function Class:setClassName(name)
    if name ~= nil and self.className ~= name then
        self.className = name;
    end
    return self;
end

-- ----------------------------------------------

-- UTILITIES
-- ----------------------------------------------

---@param message string
function Class:newError(message)
    error("[" .. self.className .. "] " .. message);
end

---@generic T : Class
---@param other T
---@param absolute boolean | nil
---@return self | T
function Class:extend(other, absolute)
    for key, value in pairs(other) do
        if not self[key] or absolute then
            rawset(self, key, value);
        end
    end

    return self;
end

---@generic T : Class
---@param other T
---@param absolute boolean | nil
---@return T
function Class:inherit(other, absolute)
    if self.base then
        self:newError("class is already inherited!");
    end

    self:extend(other, absolute);
    self.base = other;

    return self
end

---@param name string
---@param value any
---@param getter boolean | nil
---@param setter boolean | nil
---@return self
function Class:property(name, value, getter, setter)
    rawset(self, name, value);

    local titleized = name:gsub("^%l", string.upper);

    if getter then
        rawset(self, "get" .. titleized, function(table)
            return rawget(table, name)
        end);
    end

    if setter then
        rawset(self, "set" .. titleized, function(table, newValue)
            rawset(table, name, newValue);
            return table;
        end);
    end

    return self;
end

-- ----------------------------------------------

-- CONSTRUCTORS
-- ----------------------------------------------

---@return self
function Class.new()
    return setmetatable({}, Class);
end

-- ----------------------------------------------

-- META METHODS
-- ----------------------------------------------

Class.__index = Class;

Class.__tostring = Class.stringify;

-- ----------------------------------------------

return Class
