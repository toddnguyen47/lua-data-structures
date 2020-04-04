require "trim"

function PrintTrimmedString(str1)
  print("[" .. trim(str1) .. "]")
end

PrintTrimmedString("  asdfasd  a  asdf  ")
PrintTrimmedString("     [hello]    w   orld   ")
