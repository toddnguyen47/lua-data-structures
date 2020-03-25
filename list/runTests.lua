local gTestOutput = true

local function executeCommandSaveOutput(command)
  local currentOutput = os.execute(command)
  if currentOutput == nil then currentOutput = false end
  gTestOutput = gTestOutput and currentOutput
end

local command = "busted --config-file=bustedConfig --repeat=5 -- ."
executeCommandSaveOutput(command)

os.exit(gTestOutput)
