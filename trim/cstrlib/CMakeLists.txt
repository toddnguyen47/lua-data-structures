cmake_minimum_required(VERSION 3.10)

set(CMAKE_C_STANDARD 11)

project(cstrlib_proj
  VERSION 1.0
  DESCRIPTION "C String Functions, OOP-ish style"
)

add_library(cstrlib SHARED
  cstrlib.c)

target_include_directories(cstrlib PRIVATE "/opt/lua-5.3.5/include")

set_target_properties(cstrlib PROPERTIES PREFIX "")
