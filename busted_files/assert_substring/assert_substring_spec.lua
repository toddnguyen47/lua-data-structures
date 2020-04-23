require("assert_substring")

test("Testing case sensitive, expect is", function()
  local str1 = "Hello LeBlanc"
  assert.is_substring(str1, "LeBlanc")
end)

test("Testing case sensitive, expect is_not", function()
  local str1 = "Hello LeBlanc"
  assert.is_not_substring(str1, "Leblanc")
end)
