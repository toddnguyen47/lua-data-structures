-- Ref: https://stackoverflow.com/a/23535333
local function script_path()
  local str = debug.getinfo(2, "S").source:sub(2)
  return str:match("(.*/)") or "./"
end

local path = script_path()

package.path = package.path .. string.format(";%slib/?.lua", path)
local LuaCppTime = require("lua_cpp_time")

local execute_timed_command
local sleep1
local sleep2

local function main()
  local sleep_time_seconds = 2
  local lua_cpp_time = LuaCppTime:new()

  local start_end_table = execute_timed_command(lua_cpp_time, sleep_time_seconds)
  local start_time_obj = start_end_table[1]
  local end_time_obj = start_end_table[2]

  print(string.format("Start time since epoch in milliseconds: %d",
          lua_cpp_time:convert_to_ms_since_epoch(start_time_obj)))
  print(string.format("End time since epoch in milliseconds: %d",
          lua_cpp_time:convert_to_ms_since_epoch(end_time_obj)))

  assert(start_time_obj ~= end_time_obj)

  local time_elapsed = lua_cpp_time:difftime(end_time_obj, start_time_obj)
  print("Time elapsed in milliseconds: " .. time_elapsed)
end

---@param lua_cpp_time table
---@param sleep_time_seconds integer
---@return table start_end_table
function execute_timed_command(lua_cpp_time, sleep_time_seconds)
  print("Sleeping for " .. sleep_time_seconds .. " seconds")
  local start_time_obj = lua_cpp_time:get_current_time_object()
  sleep1(sleep_time_seconds)
  local end_time_obj = lua_cpp_time:get_current_time_object()
  return {start_time_obj, end_time_obj}
end

-- Ref: http://lua-users.org/wiki/SleepFunction
function sleep1(seconds)
  os.execute("sleep " .. seconds)
end

main()
