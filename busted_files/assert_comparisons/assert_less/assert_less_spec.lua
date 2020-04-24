require("assert_less")

insulate("", function()
  test("Should be less than", function()
    assert.is_less(2, 5)
  end)

  test("Should NOT be greater than", function()
    assert.is_not_less(1, -2)
  end)
end)
