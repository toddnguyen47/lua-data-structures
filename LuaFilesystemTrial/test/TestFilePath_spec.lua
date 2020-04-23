-- Must include Config first to include the absolute directory path
package.path = package.path .. ";../?.lua"
local Config = require "Config"
-- Now we can include proper paths
require "busted"

describe("FileSystem Relative Path | ", function()
  -- test("Test if file in root directory can be accessed", function()
  --   -- Arrange
  --   -- Act
  --   Config:addRelativePath("modules/?.lua")
  --   -- Assert
  --   local rootDirectory =
  --     "/media/LinuxData/todd/usr/workspaces/lua-workspace/LuaFilesystemTrial/modules"
  --   local startIndex = 1
  --   local patternMatchingOff = true
  --   assert.is_not_nil(string.find(package.path, rootDirectory, startIndex, patternMatchingOff))
  -- end)

  -- test("Adding duplicate paths; Should NOT be present twice", function()
  --   -- Arrange
  --   local p = "YO.lua"
  --   -- Act
  --   Config:addRelativePath(p)
  --   Config:addRelativePath(p)
  --   -- Assert
  --   local iter = string.gmatch(package.path, p)
  --   local count = 0
  --   for word in iter do count = count + 1 end
  --   assert.is.equal(1, count)
  -- end)

  test("Test if Module can access root module", function()
    -- Arrange
    Config:addRelativePath("?.lua")
    local RootModule = require "RootModule"
    local rootModule = RootModule:new()
    -- Act
    Config:addRelativePath("modules/?.lua"))
    local ModuleA = require "ModuleA"
    local moduleA = ModuleA:new(rootModule)
    -- Assert
    assert.is_not_nil(moduleA._rootModule)
  end)
end)
