local RootModule = {}
RootModule.__index = RootModule

function RootModule:new()
  local newInstance = setmetatable({}, self)
  newInstance:__init__()
  return newInstance
end

function RootModule:__init__()
end

return RootModule
