local SampleInterfaceImplementation = {}

function SampleInterfaceImplementation:new()
  self.__index = self
  -- Inherit
  local parentClass = require("SampleInterface")
  setmetatable(self, {__index = parentClass:new()})

  -- Make a new instance of this current object
  local newInstance = setmetatable({}, self)

  return newInstance
end

function SampleInterfaceImplementation:returnOne()
  return 1
end

return SampleInterfaceImplementation
