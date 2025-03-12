local PATH = string.sub(..., 1, string.len(...) - string.len("performer"));

---@module "fmt"
local Fmt = require(PATH .. "fmt");

local Performer = {}

---@type string
Performer.prefix = "Typing(Debug)";

---@param message string
function Performer:newError(message)
    error("[" .. self.prefix .. "] " .. message);
end

---@param errorMessage string
function Performer:errorFromPair(key, value, errorMessage)
    self:newError(
        string.format(
            "Pair: {\n%s\n}.\n%s",
            Fmt:rowInfo(key, value, 1),
            errorMessage
        )
    );
end

-- UTILITIES
-- ----------------------------------------------

---Middleware is being used each iteration through pairs, it has to return
---(1) success - whenever pair passed the test or not,
---(2) code - if 1 that means the key is invalid if 2 then value else default message will be printed,
---if middleware success is false function exists with an error!
---@param table table
---@param checker fun(key: string, value: string): boolean, (number | nil)
function Performer:perform(table, checker)
    for key, value in pairs(table) do
        local success, code = checker(key, value);

        if not success then
            local what = code == 1 and "Key" or code == 2 and "Value" or "Pairs";

            local errorMessage = what .. " did not pass type checker test!";

            self:errorFromPair(key, value, errorMessage);
        end
    end
end

---checks whenever pair is desired type and exists else returns an error
---@param rules table<string | number, type>
---@param table table
function Performer:ruleValidity(table, rules)
    for ruleKey, ruleType in pairs(rules) do
        local value = table[ruleKey];
        if not value or type(value) ~= ruleType then
            local expected = "Rules has been trespassed." ..
                "\nRule pair: { " .. Fmt:rowData(ruleKey, ruleType) .. " }"

            local got = value and
                "Gotten value: " .. value .. " of type " .. type(value) or
                "Key does not exist";

            self:newError(expected .. "\n" .. got);
        end
    end
end

-- ----------------------------------------------

return Performer;
