-- Ref: http://olivinelabs.com/busted/#asserts
local say = require("say")
-- Ref: https://stackoverflow.com/a/46358534
local assert = require("luassert")

---@param arg any
local function get_is_not_number_str(arg)
  return string.format("'%s' is not a number!", arg)
end

---Ref: https://github.com/Olivine-Labs/luassert/blob/master/src/assertions.lua#L112
---arguments[1] = expected_value
---arguments[2] = percent_threshold (if you want 5%, pass in the integer `5`)
---arguments[3] = actual_value
local function within_percent(state, arguments, level)
  level = (level or 1) + 1
  local argcnt = arguments["n"]
  assert(argcnt > 1, say("assertion.internal.argtolittle", {"within_percent", 2, tostring(argcnt)}),
    level)
  assert(argcnt == 3,
    "Need to supply 3 arguments:\n  expected_value, percent_threshold, actual_value")
  local expected_value = arguments[1]
  local percent_threshold = arguments[2]
  local actual_value = arguments[3]
  assert(type(expected_value) == "number", get_is_not_number_str(expected_value))
  assert(type(percent_threshold) == "number", get_is_not_number_str(percent_threshold))
  assert(type(actual_value) == "number", get_is_not_number_str(actual_value))

  expected_value = tonumber(expected_value)
  percent_threshold = tonumber(percent_threshold)
  actual_value = tonumber(actual_value)

  local threshold = expected_value * percent_threshold / 100.0
  local lower_bound = expected_value - threshold
  local upper_bound = expected_value + threshold
  local result = (lower_bound <= actual_value) and (actual_value <= upper_bound)
  return result
end

local positive =
  "\nExpected the Actual Value to be within a Percent Threshold of the Expected Value." ..
    "\n-- Expected Value: --\n%s" .. "\n-- Percent Threshold: --\n%s" .. "\n-- Actual value: --\n%s"
local negative =
  "\nExpected the Actual Value to NOT be within a Percent Threshold of the Expected Value." ..
    "\n-- Expected Value: --\n%s" .. "\n-- Percent Threshold: --\n%s" .. "\n-- Actual value: --\n%s"

say:set("assertion.within_percent.positive", positive)
say:set("assertion.within_percent.negative", negative)

-- Ref: https://github.com/Olivine-Labs/luassert/blob/master/src/assert.lua#L87
assert:register("assertion", "within_percent", within_percent, "assertion.within_percent.positive",
  "assertion.within_percent.negative")
