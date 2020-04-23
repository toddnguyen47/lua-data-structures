cmake_minimum_required(VERSION 3.10)

set(CMAKE_CXX_STANDARD 11)

project(cpp_time_proj
  VERSION 1.0
  DESCRIPTION "C String Functions, OOP-ish style"
)

add_library(cpp_time SHARED
  cpp_time.cpp expose_to_lua.cpp)

target_include_directories(cpp_time PRIVATE "/opt/lua-5.3.5/include")

set_target_properties(cpp_time PROPERTIES PREFIX "")
