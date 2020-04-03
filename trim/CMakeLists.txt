cmake_minimum_required(VERSION 3.10)

INCLUDE_DIRECTORIES("/opt/lua-5.3.5/include")

set(CMAKE_C_STANDARD 11)

project(LuaTrim
  VERSION 1.0
  DESCRIPTION "Terminal Clock Display"
)

add_library(trim SHARED
  trim.c)
