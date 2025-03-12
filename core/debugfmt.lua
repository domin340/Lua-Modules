local DebugFmt = {};

-- FORMATTING (FMT)
-- ----------------------------------------------

---@return string
function DebugFmt.rowType(key, value)
    return "---@type " .. type(key) .. ", " .. type(value);
end

---@return string
function DebugFmt.rowData(key, value)
    return "['" .. key .. "'] = " .. value .. ';';
end

---@param tabs number | nil
---@return string
function DebugFmt:rowInfo(key, value, tabs)
    local indentation = string.rep("\t", tabs or 0)
    return indentation ..
        self.rowType(key, value) ..
        "\n" .. indentation ..
        self.rowData(key, value);
end

-- ----------------------------------------------

-- CLASS DEBUG UTILITIES
-- ----------------------------------------------

---@param cls Class
---@param tabs number | nil
---@return string
function DebugFmt:classInfo(cls, tabs)
    -- formatting
    tabs = tabs or 1;
    local indentation = string.rep("\t", tabs);

    -- info
    local inherits = cls.base and self:classInfo(cls.base, tabs + 1) or "Nothing";

    local info = {
        -- Name
        string.format("@%s {", cls.className),
        -- Stringified version
        string.format("%sStringified: %s", indentation, tostring(cls)),
        -- Inherits
        string.format("%sInherits: %s", indentation, inherits),
    };

    -- close brackets
    table.insert(info, string.rep("\t", tabs - 1) .. "}");

    return table.concat(info, "\n");
end

-- ----------------------------------------------


-- ENUM DEBUG UTILITIES
-- ----------------------------------------------

---@param enum table<string, any>
---@return string
function DebugFmt:enum(enum)
    ---@type string
    local temp = "";
    for key, value in pairs(enum) do
        temp = temp .. "\n" .. self:rowInfo(key, value, 1) .. "\n";
    end
    return string.format("@Enum {%s}", temp);
end

-- ----------------------------------------------

return DebugFmt;
