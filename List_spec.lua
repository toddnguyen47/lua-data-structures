local List = require("List")

insulate("List Unit Tests", function()
  local list = List:new()

  randomize()

  test("Test Append to empty list", function()
    -- Arrange
    local itemToInsert = 5
    -- Act
    list:append(itemToInsert)
    -- Assert
    assert.is_equal(1, list:size())
    assert.is_equal(itemToInsert, list:get(0))
  end)
end)
