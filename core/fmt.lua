local DebugFmt = {};

-- FORMATTING (FMT)
-- ----------------------------------------------

---@param value unknown
---@returns string
function DebugFmt.syntaxValue(value)
    if type(value) == "string" then
        return "\"" .. value .. "\"";
    else
        return value;
    end
end

---@return string
function DebugFmt.rowType(key, value)
    return "---@type " .. type(key) .. ", " .. type(value);
end

---@return string
function DebugFmt:rowData(key, value)
    return "[" .. self.syntaxValue(key) .. "]" ..
        " = " ..
        self.syntaxValue(value) ..
        ";";
end

---@param tabs number | nil
---@return string
function DebugFmt:rowInfo(key, value, tabs)
    local indentation = string.rep("\t", tabs or 0)
    return indentation ..
        self.rowType(key, value) ..
        "\n" .. indentation ..
        self:rowData(key, value);
end

-- ----------------------------------------------

-- ENUM DEBUG UTILITIES
-- ----------------------------------------------

---@param enum table<string, any>
---@param withTypes boolean | nil
---@return string
function DebugFmt:enum(enum, withTypes)
    withTypes = withTypes or false;

    ---@type string
    local temp = "";
    for key, value in pairs(enum) do
        local rest = withTypes and
            -- with types
            self:rowInfo(key, value, 1) or
            -- without types
            "\t" .. self:rowData(key, value);
        temp = temp .. "\n" .. rest;
    end

    return string.format("@Enum {%s\n}", temp);
end

-- ----------------------------------------------

return DebugFmt;
