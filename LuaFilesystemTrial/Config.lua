local Config = {}
local _ABSOLUTE_ROOT_DIRECTORY =
  "/media/LinuxData/todd/usr/Github/PersonalUtilityFiles/utility-files/Lua/LuaFilesystemTrial/"

function Config:addRelativePath(relativePath)
  local absolutePath = _ABSOLUTE_ROOT_DIRECTORY .. "/" .. relativePath
  absolutePath = string.gsub(absolutePath, "//", "/")
  if (not self:_isAbsolutePathPresent(absolutePath)) then
    package.path = package.path .. ";" .. absolutePath
  end
end

function Config:_isAbsolutePathPresent(absolutePath)
  local startIndex = 1
  local patternMatchingOff = true
  return string.find(package.path, absolutePath, startIndex, patternMatchingOff) ~= nil
end

return Config
