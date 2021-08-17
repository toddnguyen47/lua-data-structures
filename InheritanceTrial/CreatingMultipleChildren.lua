ParentTable = {}
-- Metatables must have __index
ParentTable.__index = ParentTable

function ParentTable:ReturnTwo()
  return 2
end

ChildTable = {}
-- Metatables must have __index
ChildTable.__index = ChildTable

function ChildTable:__init__()
  print("I am in init()")
end

function ChildTable:New()
  setmetatable(ChildTable, ParentTable)

  local newInstance = {}
  setmetatable(newInstance, ChildTable)
  newInstance:__init__()
  return newInstance
end

child1 = ChildTable:New()
assert (2 == child1:ReturnTwo())

child2 = ChildTable:New()
assert (2 == child2:ReturnTwo())

assert(child1 ~= child2) -- child1 and child2 are different entities
