cmake_minimum_required(VERSION 3.10)

set(CMAKE_C_STANDARD 11)

project(LuaTrim
  VERSION 1.0
  DESCRIPTION "C String Functions globally"
)

add_library(trim SHARED
  trim.c)

target_include_directories(trim PRIVATE "/opt/lua-5.3.5/include")

set_target_properties(trim PROPERTIES PREFIX "")
