-- Ref: https://stackoverflow.com/a/23535333
local function script_path()
  local str = debug.getinfo(2, "S").source:sub(2)
  return str:match("(.*/)") or "./"
end

local path = script_path()

package.cpath = package.cpath .. string.format(";%s?.so", path)
local cpp_time = require("cpp_time")

local LuaCppTime = {}
LuaCppTime.__index = LuaCppTime

function LuaCppTime:new()
  local newInstance = setmetatable({}, self)
  newInstance:__init__()
  return newInstance
end

function LuaCppTime:__init__()
end

---Get a `chrono::steady_clock::time_point` object that can either 
---be converted to a millisecond number, or
---used to calculate duration in milliseconds.
function LuaCppTime:get_current_time_object()
  return cpp_time.get_current_time_object()
end

---@param end_time any A `chrono::steady_clock::time_point` end time
---@param start_time any A `chrono::steady_clock::time_point` start time
---@return any difftime_object `chrono::duration<double, std::milli>`
---Calculate the duration object between end_time and start_time in milliseconds
function LuaCppTime:difftime_object(end_time, start_time)
  return cpp_time.difftime_object(end_time, start_time)
end

---@param duration_object any `chrono::duration<double, std::milli>`
---@return integer duration_in_milliseconds
---Convert a duration count into millliseconds.
function LuaCppTime:get_duration_count(duration_object)
  return cpp_time.get_duration_count(duration_object)
end

---@param time_point_obj any A `chrono::steady_clock::time_point` object
---@return integer time_since_epoch_in_milliseconds
---Convert a `chrono::steady_clock::time_point` to time since the epoch in milliseconds
function LuaCppTime:convert_to_ms_since_epoch(time_point_obj)
  return cpp_time.convert_to_ms_since_epoch(time_point_obj)
end

function LuaCppTime:sleep_milliseconds(time_to_sleep)
  return cpp_time.sleep_milliseconds(time_to_sleep)
end

function LuaCppTime:sleep_seconds(time_to_sleep)
  return cpp_time.sleep_seconds(time_to_sleep)
end

return LuaCppTime
