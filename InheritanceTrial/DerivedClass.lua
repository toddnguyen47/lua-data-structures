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

function DerivedClass:new(value1, value2)
  setmetatable(self, BaseClass)
  local newInstance = setmetatable({}, self)
  newInstance:setValue(value1)
  newInstance.value2 = value2
  return newInstance
end

function DerivedClass:getValue()
  return self.value + self.value2
end

return DerivedClass
