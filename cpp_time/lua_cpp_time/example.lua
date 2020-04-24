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

local function main()
  local sleep_time_milliseconds = 1500
  local lua_cpp_time = LuaCppTime:new()

  local start_end_table = execute_timed_command(lua_cpp_time, sleep_time_milliseconds)
  local start_time_obj = start_end_table[1]
  local end_time_obj_1 = start_end_table[2]
  local end_time_obj_2 = start_end_table[3]

  print(string.format("Start time since epoch in milliseconds: %d",
          lua_cpp_time:convert_to_ms_since_epoch(start_time_obj)))
  print(string.format("End time 1 since epoch in milliseconds: %d",
          lua_cpp_time:convert_to_ms_since_epoch(end_time_obj_1)))
  print(string.format("End time 2 since epoch in milliseconds: %d",
          lua_cpp_time:convert_to_ms_since_epoch(end_time_obj_2)))

  assert(start_time_obj ~= end_time_obj_1)

  local time_elapsed_1 = lua_cpp_time:difftime_object(end_time_obj_1, start_time_obj)
  local time_elapsed_2 = lua_cpp_time:difftime_object(end_time_obj_2, start_time_obj)
  local time_elapsed_elapsed = lua_cpp_time:difftime_object(end_time_obj_2, end_time_obj_1)
  print(string.format("Time elapsed 1 in milliseconds: %0.3f",
          lua_cpp_time:get_duration_count(time_elapsed_1)))
  print(string.format("Time elapsed 2 in milliseconds: %0.3f",
          lua_cpp_time:get_duration_count(time_elapsed_2)))
  print(string.format("Time elapsed between the two end points: %0.3f",
          lua_cpp_time:get_duration_count(time_elapsed_elapsed)))
end

---@param lua_cpp_time table
---@param sleep_time_milliseconds integer
---@return table start_end_table
function execute_timed_command(lua_cpp_time, sleep_time_milliseconds)
  print("Sleeping for " .. sleep_time_milliseconds .. " milliseconds")
  local start_time_obj = lua_cpp_time:get_current_time_object()

  lua_cpp_time:sleep_milliseconds(sleep_time_milliseconds)
  local end_time_obj_1 = lua_cpp_time:get_current_time_object()

  local seconds = sleep_time_milliseconds / 1000.0
  print("Sleeping for " .. seconds .. " seconds")
  lua_cpp_time:sleep_seconds(seconds)
  local end_time_obj_2 = lua_cpp_time:get_current_time_object()
  return {start_time_obj, end_time_obj_1, end_time_obj_2}
end

-- Ref: http://lua-users.org/wiki/SleepFunction
function sleep1(seconds)
  os.execute("sleep " .. seconds)
end

main()
