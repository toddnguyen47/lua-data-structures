-- Ref: http://olivinelabs.com/busted/#asserts
local say = require("say")
-- Ref: https://stackoverflow.com/a/46358534
local assert = require("luassert")

---@param list table
local function make_set(list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

---@param str_input string
---@return string
local function escape_magic_characters(str_input)
  -- Ref for magic chars: https://www.lua.org/manual/5.3/manual.html#6.4.1
  local magic_chars = make_set({"^", "$", "(", ")", "%", ".", "[", "]", "*", "+", "-", "?"})
  local new_str = ""
  str_input:gsub(".", function(char)
    if magic_chars[char] then new_str = new_str .. "%" end
    new_str = new_str .. char
  end)
  return new_str
end

---Example usage:
---assert.is_substring("LeBlanc is my favorite League champion", "LeBlanc") # will pass
---assert.is_substring("LeBlanc is my favorite League champion", "Kassadin") # will FAIL
---@param state any
---@param arguments table
---arguments[1] is the full string, arguments[2] is the substring to look for
---@return boolean
---Ref: https://github.com/Olivine-Labs/luassert/blob/master/src/assertions.lua#L112
local function substring(state, arguments, level)
  level = (level or 1) + 1
  local argcnt = arguments["n"]
  assert(argcnt > 1, say("assertion.internal.argtolittle", {"substring", 2, tostring(argcnt)}),
    level)

  local str = arguments[1]
  local substr = arguments[2]
  substr = escape_magic_characters(substr)

  return string.find(str, substr) ~= nil
end

local positive = "\nExpected: \n%s \nto have a substring of\n%s"
local negative = "\nExpected: \n%s \nto NOT have a substring of\n%s"

say:set("assertion.substring.positive", positive)
say:set("assertion.substring.negative", negative)

-- Ref: https://github.com/Olivine-Labs/luassert/blob/master/src/assert.lua#L87
assert:register("assertion", "substring", substring, "assertion.substring.positive",
  "assertion.substring.negative")

