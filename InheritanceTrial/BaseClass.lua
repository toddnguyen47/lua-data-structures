-- "include" statements
-- "Class" declaration
local BaseClass = {}
BaseClass.__index = BaseClass
-- Make sure there is a return statement at the end of this file!
-- e.g. return BaseClass

function BaseClass:new(value)
  local newInstance = setmetatable({}, self)
  newInstance.value = value
  return newInstance
end

function BaseClass:setValue(newval)
  print("In BaseClass")
  print("Setting `value` to: " .. newval)
  self.value = newval
end

function BaseClass:getValue()
  return self.value
end

return BaseClass
