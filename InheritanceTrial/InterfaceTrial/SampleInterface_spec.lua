-- '#include' statements
local SampleInterface = require("SampleInterface")
local SampleInterfaceImplementation = require("SampleInterfaceImplementation")

insulate("Insulated Interface Test | ", function()
  local sampleInterface = nil

  setup(function()
    sampleInterface = SampleInterface:new()
  end)

  test("Should throw an error", function()
    assert.has_error(sampleInterface.returnOne)
  end)

  test("Should NOT throw an error", function()
    assert.has_no.errors(sampleInterface.returnTwo)
  end)

  test("Should NOT throw an error for implementation", function()
    assert.has_error(sampleInterface.returnOne)
    sampleInterface = SampleInterfaceImplementation:new()
    assert.has_no.errors(sampleInterface.returnOne)
    assert.is.equal(1, sampleInterface:returnOne())
    assert.has_no.errors(sampleInterface.returnTwo)
  end)
end)
