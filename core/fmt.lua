local DebugFmt = {};

-- FORMATTING (FMT)
-- ----------------------------------------------

---@param value unknown
---@returns string
function DebugFmt.syntaxValue(value)
    if type(value) == "string" then
        return "\"" .. value .. "\"";
    elseif type(value) == "number" then
        return value;
    else
        return "<" .. tostring(value) .. ">";
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
        self.syntaxValue(value);
end

---@param tbl table
---@param tabs number | nil
---@param withTypes boolean | nil
---@return string
function DebugFmt:resolveTable(tbl, tabs, withTypes)
    local repetitions = tabs or 0;
    withTypes = withTypes or false;

    local tab = string.rep("\t", repetitions);
    local nl = repetitions ~= 0 and "\n" or "";

    ---@type table<string>
    local temp = {};
    for key, value in pairs(tbl) do
        local data = self:rowData(key, value)
        local typeInfo = withTypes and tab .. self.rowType(key, value) .. "\n" or "";
        table.insert(temp, typeInfo .. tab .. data);
    end

    local start = "{ " .. nl;
    local body = table.concat(temp, ", " .. nl)
    local ending = nl .. "}";

    -- starting brackets
    return start .. body .. ending;
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

return DebugFmt;
