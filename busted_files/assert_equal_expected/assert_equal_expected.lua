-- Ref: http://olivinelabs.com/busted/#asserts
local say = require("say")
-- Ref: https://stackoverflow.com/a/46358534
local assert = require("luassert")

---@param state table
---@param arguments table
---@param level integer
---Ref: https://github.com/Olivine-Labs/luassert/blob/master/src/assertions.lua#L112
local function eq_expected(state, arguments, level)
  level = (level or 1) + 1
  local argcnt = arguments["n"]
  assert(argcnt > 1, say("assertion.internal.argtolittle", {"eq_expected", 2, tostring(argcnt)}),
    level)
  local result = arguments[1] == arguments[2]
  return result
end

say:set("assertion.eq_expected.positive", "\nExpected: \n%s \nto be equal to (Actual): \n%s")
say:set("assertion.eq_expected.negative", "\nExpected: \n%s \nto NOT be equal to (Actual):\n%s")

-- Ref: https://github.com/Olivine-Labs/luassert/blob/master/src/assert.lua#L87
assert:register("assertion", "eq_expected", eq_expected, "assertion.eq_expected.positive",
  "assertion.eq_expected.negative")
