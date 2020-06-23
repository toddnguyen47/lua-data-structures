---@type SplitString
local SplitString = require("SplitString")

describe("Split String | ", function()
  test("Split on 1 whitespace", function()
    local a = "Hello World"
    local t1 = SplitString:split(a, " ")
    assert.is_same(t1, {"Hello", "World"})
  end)
end)
