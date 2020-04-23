local CommandLineParse = {}
CommandLineParse.__index = CommandLineParse

function CommandLineParse:new()
  local newInstance = setmetatable({}, CommandLineParse)
  newInstance:__init__()

  return newInstance
end

function CommandLineParse:__init__()
  self._cmd_line_args_ = nil

  self.flag_options_ = {}
  self.flag_options_["--exit-on-failure"] = false
end

---@param cmd_line_args table
function CommandLineParse:parse(cmd_line_args)
  self._cmd_line_args_ = cmd_line_args

  for index, flag in pairs(self._cmd_line_args_) do
    if index >= 1 then
      if self.flag_options_[flag] == nil then
        print(string.format("\'%s\' is not a valid flag", flag))
        os.exit(1)
      end
      self.flag_options_[flag] = true
    end
  end
end

---@param index integer
---Get the command line arguments. arg[0] is how the script was called,
---arg[1] is the first command line argument, arg[2] is second, and so on.
function CommandLineParse:get_arg(index)
  return self._cmd_line_args_[index]
end

-- ########################################
-- | "PRIVATE" functions
-- ########################################

return CommandLineParse
