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
---@return integer difftime
---Calculate the duration between end_time and start_time in milliseconds
function LuaCppTime:difftime(end_time, start_time)
  return cpp_time.difftime(end_time, start_time)
end

---@param time_point_obj any A `chrono::steady_clock::time_point` object
---@return integer time_since_epoch_in_milliseconds
---Convert a `chrono::steady_clock::time_point` to time since the epoch in milliseconds
function LuaCppTime:convert_to_ms_since_epoch(time_point_obj)
  return cpp_time.convert_to_ms_since_epoch(time_point_obj)
end

return LuaCppTime
