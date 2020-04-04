cstrlib = require "cstrlib"

function PrintTrimmedString(str1)
  print("[" .. cstrlib.trim(str1) .. "]")
end

PrintTrimmedString("  asdfasd  a  asdf  ")
PrintTrimmedString("     [hello]    w   orld   ")
