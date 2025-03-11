local PATH = string.sub(..., 1, string.len(...) - string.len("core"));

---@module "core.typing"
Typing = require(PATH .. "core.typing");

---@module "core.debugfmt"
DebugFmt = require(PATH .. "core.debugfmt");
