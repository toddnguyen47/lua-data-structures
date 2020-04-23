local ModuleA = {}
ModuleA.__index = ModuleA

function ModuleA:new(rootModule)
  local newInstance = setmetatable({}, self)
  newInstance:__init__(rootModule)
  return newInstance
end

function ModuleA:__init__(rootModule)
  self._rootModule = rootModule
end

return ModuleA
