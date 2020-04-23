---@return string script_path
---Ref: https://stackoverflow.com/a/23535333
---Ref: https://www.lua.org/manual/5.3/manual.html#lua_Debug
---Get the current script's path.
local function script_path()
  local path = debug.getinfo(2, "S").source:sub(2)
  return path:match(".*/") or "./"
end

local cmd_line_args = arg

package.path = script_path() .. "?.lua;" .. package.path
package.path = script_path() .. "../?.lua;" .. package.path
require("busted_files.assert_equal_expected.assert_equal_expected")
assert = require("luassert")
local CommandLineParse = require("command_line_parse")
local command_line_parse = CommandLineParse:new()

local function testSimpleCommandLineParse()
  command_line_parse:parse(cmd_line_args)
  assert.is_eq_expected(cmd_line_args[1], command_line_parse:get_arg(1))
  assert.is_eq_expected(cmd_line_args[2], command_line_parse:get_arg(2))
end

local function testSimpleFlag()
  command_line_parse:parse(cmd_line_args)
  assert.is_eq_expected("--exit-on-failure", command_line_parse:get_arg(1))
  assert.is_true(command_line_parse.flag_options_["--exit-on-failure"])
end

local function noArguments()
  command_line_parse:parse(cmd_line_args)
  assert.is_nil(command_line_parse:get_arg(1))
  assert.is_false(command_line_parse.flag_options_["--exit-on-failure"])
end

local function mainExecute()
  -- testSimpleCommandLineParse()
  -- testSimpleFlag()
  noArguments()
end

mainExecute()
