local PATH = string.sub(..., 1, string.len(...) - string.len("core"));

---@module "core.typing"
Typing = require(PATH .. "core.typing");

---@module "performer"
Performer = require(PATH .. "core.performer");

---@module "fmt"
Fmt = require(PATH .. "core.fmt");
