local cpp_time = require("cpp_time")
local start_time_obj = cpp_time.get_current_time_object()

local sleep_time_seconds = 2
print("Sleeping for " .. sleep_time_seconds .. " seconds")
os.execute("sleep " .. sleep_time_seconds)

local end_time_obj = cpp_time.get_current_time_object()

print(string.format("Start time since epoch in milliseconds: %d",
                    cpp_time.convert_to_ms_since_epoch(start_time_obj)))
print(string.format("End time since epoch in milliseconds: %d",
                    cpp_time.convert_to_ms_since_epoch(end_time_obj)))

assert(start_time_obj ~= end_time_obj)

local time_elapsed = cpp_time.difftime(end_time_obj, start_time_obj)
print("Time elapsed in milliseconds: " .. time_elapsed)
