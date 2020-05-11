local CommandLineParse = {}
CommandLineParse.__index = CommandLineParse

function CommandLineParse:new()
  local newInstance = setmetatable({}, CommandLineParse)
  newInstance:__init__()

  return newInstance
end

function CommandLineParse:__init__()
  self._cmd_line_args_ = nil
  self.boolean_flags_ = {}
  self:_init_boolean_flags()

  self.nonboolean_flags_ = {}
  self.number_flags_ = {}
  self:_init_nonboolean_flags()
end

---@param cmd_line_args table
function CommandLineParse:parse(cmd_line_args)
  self._cmd_line_args_ = cmd_line_args

  for index, flag in pairs(self._cmd_line_args_) do
    if index >= 1 then
      local is_boolean_option = self.boolean_flags_[flag] ~= nil
      local is_nonboolean_option = self:_is_valid_nonboolean_flag(flag)
      if is_boolean_option then
        self.boolean_flags_[flag] = true
      elseif is_nonboolean_option then
        local flag_key = flag:match("(.*)=")
        local flag_value = flag:match("=(.*)")
        if self.number_flags_[flag_key] then flag_value = tonumber(flag_value) end
        self.nonboolean_flags_[flag_key] = flag_value
      else
        print(string.format("\'%s\' is not a valid flag", flag))
        os.exit(1)
      end
    end
  end
end

---@param index integer
---@return string
---Get the command line arguments. arg[0] is how the script was called,
---arg[1] is the first command line argument, arg[2] is second, and so on.
function CommandLineParse:get_arg(index)
  return self._cmd_line_args_[index]
end

-- ########################################
-- | "PRIVATE" functions
-- ########################################

function CommandLineParse:_init_boolean_flags()
  self.boolean_flags_["--exit-on-failure"] = false
end

function CommandLineParse:_init_nonboolean_flags()
  self.nonboolean_flags_["--num-iterations"] = 1
  self.number_flags_["--num-iterations"] = true
end

---@param flag string
---@return boolean
function CommandLineParse:_is_valid_nonboolean_flag(flag)
  flag = flag:match("(.*)=")
  if flag ~= nil then
    for k, _ in pairs(self.nonboolean_flags_) do if k == flag then return true end end
  end
  return false
end

return CommandLineParse
