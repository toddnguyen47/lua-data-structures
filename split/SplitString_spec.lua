---@type SplitString
local SplitString = require("SplitString")

describe("Split String | ", function()
  describe("Regular Split", function()
    randomize()

    test("Split on 1 whitespace", function()
      local a = "Hello World"
      local t1 = SplitString:split(a, " ")
      assert.is_same(t1, {"Hello", "World"})
    end)

    test("Split on 3 whitespace", function()
      local a = "Hello   World"
      local t1 = SplitString:split(a, " ")
      assert.is_same({"Hello", "", "", "World"}, t1)
    end)

    test("Split on empty string", function()
      local a = ""
      local t1 = SplitString:split(a)
      assert.is_same({""}, t1)
    end)

    test("Split on newline", function()
      local a = "hello\n\nworld"
      local t1 = SplitString:split(a)
      assert.is_same({"hello", "", "world"}, t1)
    end)

    test("Split on Pipe", function()
      local a = "HELLO|HARMFUL|FILTER"
      local t1 = SplitString:split(a, "|")
      assert.is_same({"HELLO", "HARMFUL", "FILTER"}, t1)
    end)

    test("Last character is delimiter", function()
      local a = "134110255152035304043431340055"
      local t1 = SplitString:split(a, "5")
      assert.is_same({"1341102", "", "1", "203", "3040434313400", ""}, t1)
    end)
  end)

  describe("Split ignore empty", function()
    randomize()

    test("Split on 1 whitespace ignore empty", function()
      local a = "Hello World"
      local t1 = SplitString:splitIgnoreEmpty(a, " ")
      assert.is_same({"Hello", "World"}, t1)
    end)

    test("Split on 3 whitespace ignore empty", function()
      local a = "Hello   World"
      local t1 = SplitString:splitIgnoreEmpty(a, " ")
      assert.is_same({"Hello", "World"}, t1)
    end)

    test("Split on empty string ignore empty", function()
      local a = ""
      local t1 = SplitString:splitIgnoreEmpty(a)
      assert.is_same({""}, t1)
    end)

    test("Split on newline ignore empty", function()
      local a = "hello\n\nworld"
      local t1 = SplitString:splitIgnoreEmpty(a)
      assert.is_same({"hello", "world"}, t1)
    end)

    test("Split on Pipe", function()
      local a = "HELLO|HARMFUL|FILTER"
      local t1 = SplitString:splitIgnoreEmpty(a, "|")
      assert.is_same({"HELLO", "HARMFUL", "FILTER"}, t1)
    end)

    test("Last character is delimiter", function()
      local a = "134110255152035304043431340055"
      local t1 = SplitString:splitIgnoreEmpty(a, "5")
      assert.is_same({"1341102", "1", "203", "3040434313400"}, t1)
    end)
  end)
end)
