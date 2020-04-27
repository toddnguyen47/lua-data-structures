require("assert_has_substring_key")

insulate("", function()
  test("table with no keys", function()
    local table1 = {}
    local key = "hi"
    assert.not_has_substring_key(table1, key)
  end)

  test("table with 1 key, can be found", function()
    local table1 = {}
    table1["   hi "] = 5
    local key = "hi"
    assert.has_substring_key(table1, key)
  end)

  test("table with 1 key, cannot be found", function()
    local table1 = {}
    table1["   hello world  "] = 5
    local key = "hi"
    assert.not_has_substring_key(table1, key)
  end)

  test("table with 1 exact key, can be found", function()
    local table1 = {}
    table1["hi"] = 5
    local key = "hi"
    assert.has_substring_key(table1, key)
  end)

  test("table with 5 keys, can be found", function()
    local table1 = {}
    table1["   hi "] = 2
    table1["  yo  "] = 4
    table1[""] = 6
    table1["hello world"] = 3
    table1["zzz"] = 6
    local key = "o wor"
    assert.has_substring_key(table1, key)
  end)

  test("table with 1 empty key, cannot be found", function()
    local table1 = {}
    table1[""] = 5
    local key = "hi"
    assert.not_has_substring_key(table1, key)
  end)
end)
