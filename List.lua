--[[
  Structured after Python's lists. Ref: https://docs.python.org/3.8/tutorial/datastructures.html

  The implemented functions, in alphabetical order, are:
  Constructors:
    new()
    __init__()

  Functions:
    append(itemToAppend)
    clear()
    get(index)
    insert(index, itemToInsert)
    print()
    remove(itemToRemove)
    size()
]] local List = {}
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

function List:clear()
  self._size = 0
  self._innerTable = {}
end

---We will use 0th base index.
---@param index integer The index to get
---@return any item Item to get at index `index`
function List:get(index)
  local newIndex = index + 1
  if (newIndex > self._size) then return nil end
  return self._innerTable[newIndex]
end

---@param index integer The desired index, 0th base
---@param itemToInsert any Any item to insert at desired index
function List:insert(index, itemToInsert)
  self._size = self._size + 1
  table.insert(self._innerTable, index + 1, itemToInsert)
end

function List:print()
  for k, v in ipairs(self._innerTable) do print("[" .. (k - 1) .. "] -> " .. v) end
end

---@param itemToRemove any Removing an item that matches `itemToRemove`, otherwise nil
function List:remove(itemToRemove)
  local itemRemoved = nil
  for k, v in ipairs(self._innerTable) do
    if v == itemToRemove then
      itemRemoved = v
      table.remove(self._innerTable, k)
      self._size = self._size - 1
    end
  end
  return itemRemoved
end

---@return integer size The size of our current list
function List:size()
  return self._size
end

return List
