local List = require("List")

insulate("List Unit Tests", function()
  local list = List:new()

  before_each(function()
    list:clear()
  end)

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

  test("Append 5 items to a list", function()
    -- Arrange
    local inputs = {5, 4, "adsf", 1, "hi"}
    -- Act
    for i = 1, #inputs do list:append(inputs[i]) end
    -- Assert
    for i = 1, #inputs do assert.is_equal(inputs[i], list:get(i - 1)) end
    assert.is_equal(#inputs, list:size())
  end)

  local assertInsertAtIndex = function(desiredIndex)
    -- Arrange
    local inputs = {5, 4, "adsf", 1, "hi"}
    for i = 1, #inputs do list:append(inputs[i]) end
    local newItem = "hello world"
    -- Act
    list:insert(desiredIndex, newItem)
    -- Assert
    assert.is_equal(#inputs + 1, list:size())
    assert.is_equal(newItem, list:get(desiredIndex))
  end

  test("Insert at index 3 (0th) in a 5 item table", function()
    assertInsertAtIndex(3)
  end)

  test("Insert at 0th index", function()
    assertInsertAtIndex(0)
  end)

  test("Insert at last element", function()
    assertInsertAtIndex(4)
  end)
end)
