-- This implementation will try to imitate Python's split() function written in C.
---@class SplitString
local SplitString = {}
SplitString.__index = SplitString

---@param strInput string
---@param delimiter string
---@return table
function SplitString:split(strInput, delimiter)
  delimiter = delimiter or "\n"
  local t1 = {}
  local s1 = ""
  for char1 in strInput:gmatch(".") do
    if char1 == delimiter then
      table.insert(t1, s1)
      s1 = ""
    else
      s1 = s1 .. char1
    end
  end

  if s1 ~= "" or next(t1) == nil then table.insert(t1, s1) end
  return t1
end

---@param strInput string
---@param delimiter string
---@return table
function SplitString:splitIgnoreEmpty(strInput, delimiter)
  delimiter = delimiter or "\n"
  local t1 = {}
  local s1 = ""
  for char1 in strInput:gmatch(".") do
    if char1 == delimiter then
      if s1 ~= "" then
        table.insert(t1, s1)
        s1 = ""
      end
    else
      s1 = s1 .. char1
    end
  end

  if s1 ~= "" or next(t1) == nil then table.insert(t1, s1) end
  return t1
end

return SplitString
