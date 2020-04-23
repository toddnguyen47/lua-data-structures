local SampleInterface = {}

function SampleInterface:new()
  self.__index = self
  local newInstance = setmetatable({}, self)

  return newInstance
end

function SampleInterface:returnOne()
  error("Has not been implemented")
end

function SampleInterface:returnTwo()
  return 2
end

return SampleInterface
