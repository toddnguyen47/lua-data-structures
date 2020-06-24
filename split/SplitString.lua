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
  local startIndex = 1
  local endIndex = 0
  local strCount = 0
  for char1 in strInput:gmatch(".") do
    strCount = strCount + 1
    if char1 == delimiter then
      local s1 = string.sub(strInput, startIndex, endIndex)
      table.insert(t1, s1)
      startIndex = endIndex + 2
    end
    endIndex = endIndex + 1
  end

  if startIndex ~= 1 and startIndex <= strCount and endIndex <= strCount then
    table.insert(t1, string.sub(strInput, startIndex, endIndex))
  elseif endIndex == 0 then
    table.insert(t1, "")
  end
  return t1
end

---@param strInput string
---@param delimiter string
---@return table
function SplitString:split2(strInput, delimiter)
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
  local startIndex = 1
  local endIndex = 0
  local strCount = 0
  for char1 in strInput:gmatch(".") do
    strCount = strCount + 1
    if char1 == delimiter then
      local s1 = string.sub(strInput, startIndex, endIndex)
      if s1 ~= "" then table.insert(t1, s1) end
      startIndex = endIndex + 2
    end
    endIndex = endIndex + 1
  end

  if startIndex ~= 1 and startIndex <= strCount and endIndex <= strCount then
    table.insert(t1, string.sub(strInput, startIndex, endIndex))
  elseif endIndex == 0 then
    table.insert(t1, "")
  end
  return t1
end

return SplitString
