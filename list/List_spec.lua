local List = require("List")

insulate("List Unit Tests | ", function()
  local list = List:new()

  before_each(function()
    list:clear()
  end)

  ---@return table inputTable
  local getInputTableToTest = function()
    return {5, 4, "adsf", 1, "hi"}
  end

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
    local inputs = getInputTableToTest()
    -- Act
    for i = 1, #inputs do list:append(inputs[i]) end
    -- Assert
    for i = 1, #inputs do assert.is_equal(inputs[i], list:get(i - 1)) end
    assert.is_equal(#inputs, list:size())
  end)

  local assertInsertAtIndex = function(desiredIndex)
    -- Arrange
    local inputs = getInputTableToTest()
    for i = 1, #inputs do list:append(inputs[i]) end
    local newItem = "hello world"
    -- Act
    list:insert(desiredIndex, newItem)
    -- Assert
    assert.is_equal(#inputs + 1, list:size())
    assert.is_equal(newItem, list:get(desiredIndex))
  end

  test("Insert at index 3 (0-based) in a 5 item table", function()
    assertInsertAtIndex(3)
  end)

  test("Insert at 0th index", function()
    assertInsertAtIndex(0)
  end)

  test("Insert at last element", function()
    assertInsertAtIndex(4)
  end)

  test("Removing a specified value", function()
    -- Arrange
    local input = getInputTableToTest()
    for _, v in ipairs(input) do list:append(v) end
    local itemToRemove = input[2]
    -- Act
    local itemRemoved = list:remove(itemToRemove)
    -- Assert
    assert.is_equal(#input - 1, list:size())
    assert.is_equal(itemRemoved, itemToRemove)
  end)

  test("Removing a value that is not present", function()
    -- Arrange
    local input = getInputTableToTest()
    for _, v in ipairs(input) do list:append(v) end
    local itemToRemove = -1
    -- Act
    local itemRemoved = list:remove(itemToRemove)
    -- Assert
    assert.is_equal(#input, list:size())
    assert.is_equal(itemRemoved, nil)
  end)

  test("Removing a value at 0th index", function()
    -- Arrange
    local input = getInputTableToTest()
    for _, v in ipairs(input) do list:append(v) end
    local itemToRemove = input[#input]
    -- Act
    local itemRemoved = list:remove(itemToRemove)
    -- Assert
    assert.is_equal(#input - 1, list:size())
    assert.is_equal(itemRemoved, itemToRemove)
  end)

  describe("pop() tests", function()
    randomize()

    test("Popping an item out of index range", function()
      -- Arrange
      local input = getInputTableToTest()
      for _, v in ipairs(input) do list:append(v) end
      local desiredIndex = #input + 1
      -- Act
      local itemPopped = list:pop(desiredIndex)
      -- Assert
      assert.is_equal(#input, list:size())
      assert.is_nil(itemPopped)
    end)

    test("Popping with no parameter", function()
      -- Arrange
      local input = getInputTableToTest()
      for _, v in ipairs(input) do list:append(v) end
      -- Act
      local itemPopped = list:pop()
      -- Assert
      assert.is_equal(#input - 1, list:size())
      assert.is_equal(itemPopped, input[#input])
      assert.is_equal(list:get(list:size() - 1), input[#input - 1])
    end)

    test("Popping a specified index", function()
      -- Arrange
      local input = getInputTableToTest()
      for _, v in ipairs(input) do list:append(v) end
      local desiredIndex = 2
      -- Act
      local itemPopped = list:pop(desiredIndex)
      -- Assert
      assert.is_equal(#input - 1, list:size())
      assert.is_equal(itemPopped, input[desiredIndex + 1])
      assert.is_equal(list:get(desiredIndex), input[desiredIndex + 2])
    end)
  end)

  describe("Test 0-based index(itemToFind) | ", function()
    local input = {8, 3, 4, 8, "hi", 3, 8, 20}

    ---@param expectedIndex integer Index to find
    local function assertIndexingAtIndex(expectedIndex)
      -- Arrange
      local itemToFind = input[expectedIndex + 1]
      -- Act
      local actualIndex = list:index(itemToFind)
      -- Assert
      assert.is_equal(expectedIndex, actualIndex)
      assert.is_equal(#input, list:size())
    end

    before_each(function()
      list:clear()
      for _, v in ipairs(input) do list:append(v) end
    end)

    test("Get [1] item, 0-based", function()
      assertIndexingAtIndex(1)
    end)

    test("Get item that is NOT in the list", function()
      -- Arrange
      -- Act
      local actualIndex = list:index("hello world2")
      -- Assert
      assert.is_nil(actualIndex)
    end)

    test("Get [0] item", function()
      assertIndexingAtIndex(0)
    end)

    test("Get last item", function()
      assertIndexingAtIndex(#input - 1)
    end)

    test("If item appears more than once, return the first index found", function()
      -- Arrange
      -- Act
      -- Assert
      assert.is_equal(0, list:index(8))
      assert.is_equal(1, list:index(3))
      assert.is_equal(4, list:index("hi"))
    end)
  end)

  describe("count() | ", function()
    local input = {8, 3, 4, 8, "hi", 3, 8, 20}

    before_each(function()
      list:clear()
      for _, v in ipairs(input) do list:append(v) end
    end)

    test("Item not in list", function()
      -- Arrange
      -- Act
      local countNumber = list:count("hello world2")
      -- Assert
      assert.is_equal(0, countNumber)
    end)

    test("Item appears once at the end", function()
      -- Arrange
      -- Act
      local countNumber = list:count(20)
      -- Assert
      assert.is_equal(1, countNumber)
    end)

    test("Item appears 3 times", function()
      -- Arrange
      -- Act
      local countNumber = list:count(8)
      -- Assert
      assert.is_equal(3, countNumber)
    end)
  end)

  describe("find() tests | ", function()
    local input = {8, 3, 4, 8, "hi", 3, 8, 20}

    before_each(function()
      list:clear()
      for _, v in ipairs(input) do list:append(v) end
    end)

    test("If not in list", function()
      -- Arrange
      local noElem = 1000
      -- Act
      -- Assert
      assert.is_false(list:find(noElem))
    end)

    test("If in list once", function()
      -- Arrange
      local elem = "hi"
      -- Act
      -- Assert
      assert.is_true(list:find(elem))
    end)

    test("If item is in list more than once, return true anyway", function()
      -- Arrange
      local elem = "hi"
      -- Act
      -- Assert
      assert.is_true(list:find(elem))
    end)

    test("If item is in list 3x, return true anyway", function()
      -- Arrange
      local elem = 8
      -- Act
      -- Assert
      assert.is_true(list:find(elem))
    end)
  end)
end)
