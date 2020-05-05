-- Ref: http://olivinelabs.com/busted/#asserts
local say = require("say")
-- Ref: https://stackoverflow.com/a/46358534
local assert = require("luassert")

---@param arg any
local function get_is_not_number_str(arg)
  return string.format("'%s' is not a number!", arg)
end

---Ref: https://github.com/Olivine-Labs/luassert/blob/master/src/assertions.lua#L112
---arguments[1] = smaller_number
---arguments[2] = larger_number
local function less(state, arguments, level)
  level = (level or 1) + 1
  local argcnt = arguments["n"]
  assert(argcnt > 1, say("assertion.internal.argtolittle", {"less", 2, tostring(argcnt)}), level)
  assert(argcnt == 2, "Need to supply 2 arguments:\n  smaller_number, larger_number")

  local larger_number = arguments[1]
  local smaller_number = arguments[2]
  assert(type(larger_number) == "number", get_is_not_number_str(larger_number))
  assert(type(smaller_number) == "number", get_is_not_number_str(smaller_number))

  larger_number = larger_number
  smaller_number = smaller_number

  local result = larger_number < smaller_number
  return result
end

local positive = "\nExpected arg1 to be less than arg2." .. "\n-- arg1: --\n%s" ..
                   "\n-- arg2: --\n%s"
local negative = "\nExpected arg1 to NOT be less than arg2." .. "\n-- arg1: --\n%s" ..
                   "\n-- arg2: --\n%s"

say:set("assertion.less.positive", positive)
say:set("assertion.less.negative", negative)

-- Ref: https://github.com/Olivine-Labs/luassert/blob/master/src/assert.lua#L87
assert:register("assertion", "less", less, "assertion.less.positive", "assertion.less.negative")
