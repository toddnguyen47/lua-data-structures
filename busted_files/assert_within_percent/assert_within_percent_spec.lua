require("assert_within_percent")

insulate("", function()
  randomize()

  test("Should pass lower bound", function()
    local expected = 100
    local percent_threshold = 5
    local actual = 95
    assert.is_within_percent(expected, percent_threshold, actual)
  end)

  test("Should pass upper bound", function()
    local expected = 100
    local percent_threshold = 5
    local actual = 105
    assert.is_within_percent(expected, percent_threshold, actual)
  end)

  test("Should NOT pass lower bound", function()
    local expected = 100
    local percent_threshold = 5
    local actual = 94
    assert.is_not_within_percent(expected, percent_threshold, actual)
  end)

  test("Should NOT pass upper bound", function()
    local expected = 100
    local percent_threshold = 5
    local actual = 106
    assert.is_not_within_percent(expected, percent_threshold, actual)
  end)
end)
