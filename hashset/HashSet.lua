-- HashSet implementation is based on Java's HashSet implementation
-- https://docs.oracle.com/javase/8/docs/api/java/util/HashSet.html
local HashSet = {}

function HashSet:new()
  self.__index = self
  local newInstance = setmetatable({}, self)

  newInstance.sizeOfStorage = 0
  newInstance.storage = {}

  return newInstance
end

function HashSet:add(elem)
  if false == self:contains(elem) then
    self.storage[elem] = elem
    self.sizeOfStorage = self.sizeOfStorage + 1
    return true
  end
  return false
end

function HashSet:clear()
  self.storage = {}
  self.sizeOfStorage = 0
end

function HashSet:contains(elem)
  return self.storage[elem] ~= nil
end

function HashSet:isEmpty()
  return self.sizeOfStorage == 0
end

function HashSet:iterator()
  -- Ref: https://www.lua.org/pil/7.1.html
  local keySet = {}
  for k, _ in pairs(self.storage) do table.insert(keySet, k) end
  local i = 1
  local n = #keySet

  return function()
    if i <= n then
      local val = keySet[i]
      i = i + 1
      return val
    end
  end
end

function HashSet:remove(elem)
  if self:contains(elem) then
    self.sizeOfStorage = self.sizeOfStorage - 1
    self.storage[elem] = nil
    return true
  end
  return false
end

function HashSet:size()
  return self.sizeOfStorage
end

return HashSet
