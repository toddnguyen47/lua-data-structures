local BaseClass = require("BaseClass")
local DerivedClass = require("DerivedClass")

local derivedClass1 = DerivedClass:new(1, 2)
local derivedClass2 = DerivedClass:new(100, 200)
assert(derivedClass1 ~= derivedClass2)

print("Using DerivedClass")
print(derivedClass1:getValue()) -- > 3
assert(1 + 2 == derivedClass1:getValue(),
  string.format("\nExpected:\n%d\nActual:\n%d", 1 + 2, derivedClass1:getValue()))
derivedClass1:setValue(3)
print(derivedClass1:getValue()) -- > 5
assert(3 + 2 == derivedClass1:getValue())

print()
print("Now using BaseClass")
local baseClass = BaseClass:new(2)
print(baseClass:getValue())
assert(2 == baseClass:getValue())
baseClass:setValue(100)
print(baseClass:getValue())
assert(100 == baseClass:getValue())