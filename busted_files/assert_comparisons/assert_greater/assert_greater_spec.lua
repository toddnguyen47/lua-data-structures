require("assert_greater")

insulate("", function()
  test("Should be greater than", function()
    assert.is_greater(-1, -2)
  end)

  test("Should NOT be greater than", function()
    assert.is_not_greater(1, 2)
  end)
end)
