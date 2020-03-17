---Structured after Python's lists. Ref: https://docs.python.org/3.8/tutorial/datastructures.html
local List = {}
List.__index = List

function List:new()
  local newInstance = setmetatable({}, self)
  newInstance:__init__()

  return newInstance
end

function List:__init__()
  self._innerTable = {}
  self._size = 0
end

---@param itemToAppend any Item to append to our List
function List:append(itemToAppend)
  self._size = self._size + 1
  table.insert(self._innerTable, itemToAppend)
end

---@return integer size The size of our current list
function List:size()
  return self._size
end

---We will use 0th base index.
---@param index integer The index to get
---@return any item Item to get at index `index`
function List:get(index)
  if (index > self._size) then return nil end
  return self._innerTable[index + 1]
end

return List
