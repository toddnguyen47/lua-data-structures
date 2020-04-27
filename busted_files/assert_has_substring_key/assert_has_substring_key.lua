-- Ref: http://olivinelabs.com/busted/#asserts
local say = require("say")
-- Ref: https://stackoverflow.com/a/46358534
local assert = require("luassert")

---Ref: https://github.com/Olivine-Labs/luassert/blob/master/src/assertions.lua#L112
---arguments[1] = table
---arguments[2] = substring of key
local function has_substring_key(state, arguments, level)
  level = (level or 1) + 1
  local argcnt = arguments["n"]
  assert(argcnt > 1,
    say("assertion.internal.argtolittle", {"has_substring_key", 2, tostring(argcnt)}), level)
  assert(argcnt == 2, "Need to supply 2 arguments:\n  key, table")

  local table1 = arguments[1]
  local substr_key = arguments[2]

  assert(type(table1) == "table", "Need to supply a table.")

  local result = false
  for k, _ in pairs(table1) do
    if k:find(substr_key) then
      result = true
      break
    end
  end

  return result
end

local positive = "\nExpected table:\n%s\nto have a key that contains the substring:\n%s"
local negative = "\nExpected table:\n%s\nto NOT have a key that contains the substring:\n%s"

say:set("assertion.has_substring_key.positive", positive)
say:set("assertion.has_substring_key.negative", negative)

-- Ref: https://github.com/Olivine-Labs/luassert/blob/master/src/assert.lua#L87
assert:register("assertion", "has_substring_key", has_substring_key,
  "assertion.has_substring_key.positive", "assertion.has_substring_key.negative")
