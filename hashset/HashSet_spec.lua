insulate("HashSet Test | ", function()
  local hashSet = nil

  setup(function()
    hashSet = require("HashSet"):new()
  end)

  before_each(function()
    hashSet:clear()
  end)

  randomize()

  test("isEmpty()", function()
    assert.is_true(hashSet:isEmpty())
  end)

  test("clear(); checking size is 0", function()
    hashSet:clear()
    assert.is_true(hashSet:isEmpty())
  end)

  test("size(); check if empty HashSet is 0", function()
    hashSet:clear()
    assert.is_true(hashSet:size() == 0)
  end)

  test("add 1; size should be 1, isEmpty should be false", function()
    hashSet:add("elem1")
    assert.is.equal(1, hashSet:size())
    assert.is_false(hashSet:isEmpty())
  end)

  test("add element then see if the hashset contains it", function()
    local e = "elem1"
    assert.is_false(hashSet:contains(e))
    hashSet:add(e)
    assert.is_true(hashSet:contains(e))
  end)

  test("add multiple DUPLICATES; size should be 1, isEmpty should be false", function()
    math.randomseed(os.time())
    local numTimes = math.random(10, 20)

    for _ = 1, numTimes do hashSet:add("elem") end
    assert.is.equal(1, hashSet:size())
    assert.is_false(hashSet:isEmpty())
  end)

  test("add multiple non-duplicates; size should be 1, isEmpty should be false", function()
    math.randomseed(os.time())
    local numTimes = math.random(10, 20)

    for i = 1, numTimes do hashSet:add("elem" .. i) end
    assert.is.equal(numTimes, hashSet:size())
    assert.is_false(hashSet:isEmpty())
  end)

  test("Add 5 elements then return an iterator", function()
    local expectedSet = {
      elem1 = "elem1",
      elem2 = "elem2",
      elem3 = "elem3",
      elem4 = "elem4",
      elem5 = "elem5"
    }

    for key, _ in pairs(expectedSet) do hashSet:add(key) end

    local iter = hashSet:iterator()
    local i = 1
    for elem in iter do
      assert.is_true(expectedSet[elem] ~= nil)
      i = i + 1
    end
  end)

  test("add 1 then remove 1, size == 0 and hashset should be empty", function()
    hashSet:add("elem1")
    hashSet:remove("elem1")
    assert.is_true(hashSet:isEmpty())
    assert.is.equal(0, hashSet:size())
  end)

  test("add 1 then remove 1 then readd it, size == 1 and hashset should not be empty", function()
    hashSet:add("elem1")
    hashSet:remove("elem1")
    hashSet:add("elem1")
    hashSet:add("elem1")
    assert.is_false(hashSet:isEmpty())
    assert.is.equal(1, hashSet:size())
  end)

  test("Remove from empty list; Size should still be 0, list should still be empty", function()
    hashSet:remove("elem1")
    assert.is_true(hashSet:isEmpty())
    assert.is.equal(0, hashSet:size())
  end)

  test("Add 1, remove it, then try to remove again", function()
    assert.is_true(hashSet:add("elem1"))
    assert.is_true(hashSet:remove("elem1"))
    assert.is_true(hashSet:isEmpty())
    assert.is.equal(0, hashSet:size())

    assert.is_false(hashSet:remove("elem1"))
    assert.is_true(hashSet:isEmpty())
    assert.is.equal(0, hashSet:size())
  end)

  test("Add 3, remove 1, size should be 2", function()
    assert.is_true(hashSet:add("elem1"))
    assert.is_false(hashSet:add("elem1"))
    assert.is_true(hashSet:add("elem2"))
    assert.is_true(hashSet:add("elem3"))
    assert.is_true(hashSet:remove("elem2"))
    assert.is.equal(2, hashSet:size())
  end)
end)
