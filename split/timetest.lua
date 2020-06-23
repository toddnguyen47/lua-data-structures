local f = io.open("samplestring.txt", "r")
local a = f:read()
f:close()
local delim = "5"

local t1 = {}
local StringSplit = require("SplitString")

if #arg <= 0 then
  print("Please supply either `1` or `2` as a command line argument")
  os.exit(-1)
end

local arg1 = string.lower(arg[1])

if arg1 == "index" then
  t1 = StringSplit:split(a, delim)
elseif arg1 == "strconcat" then
  t1 = StringSplit:split2(a, delim)
end

print("Table Length: " .. tostring(#t1))
