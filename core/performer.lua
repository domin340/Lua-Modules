local PATH = string.sub(..., 1, string.len(...) - string.len("performer"));

---@module "fmt"
local Fmt = require(PATH .. "fmt");

local Checker = {}

---@type string
Checker.prefix = "Typing(Debug)";

---@param message string
function Checker:newError(message)
    error("[" .. self.prefix .. "] " .. message);
end

-- UTILITIES
-- ----------------------------------------------

---Middleware is being used each iteration through pairs, it has to return
---(1) success - whenever pair passed the test or not,
---(2) code - if 1 that means the key is invalid if 2 then value else default message will be printed,
---if middleware success is false function exists with an error!
---@param table table
---@param checker fun(key: string, value: string): boolean, (number | nil)
function Checker:perform(table, checker)
    for key, value in pairs(table) do
        local success, code = checker(key, value);

        if not success then
            local what = code == 1 and "Key" or code == 2 and "Value" or "Pairs";

            local errorMessage = what .. " did not pass type checker test!";

            self:newError(
                string.format(
                    "Pair: {\n%s\n}.\n%s",
                    Fmt:rowInfo(key, value, 1),
                    errorMessage
                )
            );
        end
    end
end

-- ----------------------------------------------

return Checker;
