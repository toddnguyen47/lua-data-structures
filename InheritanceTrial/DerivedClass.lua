-- Good documentation:
-- https://www.quora.com/What-does-the-line-self-__index-self-do-in-OOP-in-Lua
-- https://www.lua.org/pil/16.2.html
-- https://www.lua.org/pil/13.4.1.html
-- "include" statements
local BaseClass = require("BaseClass")

-- "Class" declaration
local DerivedClass = {}
DerivedClass.__index = DerivedClass
-- Make sure there is a return statement at the end of this file!
-- e.g. return BaseClass

function DerivedClass:new(val1, val2)
  local parentClass = BaseClass
  setmetatable(self, {__index = parentClass:new(val1)})

  local o = setmetatable({}, {__index = self})
  o.value2 = val2
  return o
end

function DerivedClass:get_value()
  return self.value + self.value2
end

local i = DerivedClass:new(1, 2)
print(i:get_value()) -- > 3
assert(3, i:get_value())
i:set_value(3)
print(i:get_value()) -- > 5
assert(5, i:get_value())

print("Now using BaseClass")
local baseClass = BaseClass:new(2)
print(baseClass:get_value())
assert(2, baseClass:get_value())
baseClass:set_value(100)
print(baseClass:get_value())
assert(100, baseClass:get_value())
