require "busted"
local DurstenfeldShuffle = require "DurstenfeldShuffle"

describe("Durstenfeld Shuffle | ", function()
  test("Shuffle zero element; Should Return zero element", function()
    -- Arrange
    local t1 = {}
    -- Act
    local t2 = DurstenfeldShuffle:shuffle(t1)
    -- Assert
    assert.is.same(t1, t2)
  end)

  test("Shuffle one element; Should return itself", function()
    -- Arrange
    local t1 = {1}
    -- Act
    local t2 = DurstenfeldShuffle:shuffle(t1)
    -- Assert
    assert.is.same(t1, t2)
  end)

  test("Shuffle ten elements; Should be... different", function()
    -- Arrange
    local t1 = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
    -- Act
    local t2 = DurstenfeldShuffle:shuffle(t1)
    -- Assert
    assert.is_not.same(t1, t2)
  end)
end)
