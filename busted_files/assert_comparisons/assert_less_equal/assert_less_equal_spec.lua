require("assert_less_equal")

insulate("", function()
  test("Should be less than or equal to", function()
    assert.is_less_equal(1, 2)
  end)

  test("Should be equal to", function()
    assert.is_less_equal(2, 2)
  end)

  test("Should NOT be greater or equal to", function()
    assert.is_not_less_equal(1, -2)
  end)
end)
