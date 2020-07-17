describe("Extra Spec", function()
  test("Assert true", function()
    assert.is_true(true)
    --FAIL_ME_HERE
  end)

  local function printFileName(strInput)
    print(strInput.filename)
  end

  test("Assert false", function()
    assert.is_false(false)
    --printFileName()
  end)
end)

