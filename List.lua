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
    index(itemToFind)
    insert(index, itemToInsert)
    pop([index])
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

---@param itemToFind any Item to find
---@return integer index Index of `itemToFind`
---Find the index of `itemToFind`, returning nil if `itemToFind` cannot be found
function List:index(itemToFind)
  local index = nil
  for k, v in ipairs(self._innerTable) do
    if v == itemToFind then
      index = k - 1
      break
    end
  end
  return index
end

---@param index integer The desired index, 0th base
---@param itemToInsert any Any item to insert at desired index
---Insert into the desired index.
function List:insert(index, itemToInsert)
  self._size = self._size + 1
  table.insert(self._innerTable, index + 1, itemToInsert)
end

---From Python's documentation:
---Remove the item at the given position in the list, and return it.
---If no index is specified, a.pop() removes and returns the last item in the list.
---(The square brackets around the i in the method signature denote that the
---parameter is optional, not that you should type square brackets at that position.
---@param index integer OPTIONAL: Index to pop the element at, 0th based.
---@return integer item The item that was popped at `index`, or the last item in the list.
---Pop an element at `index`, or the last element if no index is given
function List:pop(index)
  local indexToPop = self._size
  if index ~= nil then indexToPop = index + 1 end
  if indexToPop > self._size then return nil end
  self._size = self._size - 1
  return table.remove(self._innerTable, indexToPop)
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
      break
    end
  end
  return itemRemoved
end

---@return integer size The size of our current list
function List:size()
  return self._size
end

return List
