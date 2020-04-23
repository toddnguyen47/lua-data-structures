require("assert_equal_expected")

insulate("", function()
  test("Expected to be equal", function()
    local expected = 1
    local actual = 1
    assert.is_eq_expected(expected, actual)
  end)

  test("Expected to NOT be equal", function()
    local expected = 1
    local actual = 1
    assert.is_not_eq_expected(expected, actual)
  end)
end)
