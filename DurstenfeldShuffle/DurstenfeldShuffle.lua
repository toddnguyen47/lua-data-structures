local DurstenfeldShuffle = {}
DurstenfeldShuffle.__index = DurstenfeldShuffle

function DurstenfeldShuffle.new(self)
  local newInstance = setmetatable({}, self)
  newInstance.__init__()
  return newInstance
end

function DurstenfeldShuffle.__init__(self)
end

---@param tableInput table
---@return table tableCopy
---Ref: https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle#The_modern_algorithm
function DurstenfeldShuffle.shuffle(self, tableInput)
  math.randomseed(os.time())
  local len1 = #tableInput
  local tableCopy = self._deepCopy(self, tableInput)
  for i = len1, 1, -1 do
    local random = math.random(1, i)
    self._swap(self, tableCopy, random, i)
  end
  return tableCopy
end

---@param tableInput table
---@param key1 any
---@param key2 any
---Swap in place.
function DurstenfeldShuffle._swap(self, tableInput, key1, key2)
  local temp = tableInput[key1]
  tableInput[key1] = tableInput[key2]
  tableInput[key2] = temp
end

---@param tableInput table
---@return table t1 A copy of the table.
---Make a deep copy of table 'tableInput'
function DurstenfeldShuffle._deepCopy(self, tableInput)
  local t1 = {}
  for key, val in pairs(tableInput) do t1[key] = val end
  return t1
end

return DurstenfeldShuffle
