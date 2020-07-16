require("assert_greater_equal")

insulate("", function()
  test("Should be greater or equal to", function()
    assert.is_greater_equal(-1, -2)
  end)

  test("Should be equal to", function()
    assert.is_greater_equal(2, 2)
  end)

  test("Should NOT be greater or equal to", function()
    assert.is_not_greater_equal(1, 2)
  end)
end)
