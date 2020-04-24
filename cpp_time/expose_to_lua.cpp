#include "cpp_time.h"

CppTime cpp_time_obj;

int get_hello_world(lua_State *L)
{
  return cpp_time_obj.get_hello_world(L);
}

int get_current_time_ms(lua_State *L)
{
  return cpp_time_obj.get_current_time_ms(L);
}

int get_current_time_object(lua_State *L)
{
  return cpp_time_obj.get_current_time_object(L);
}

int convert_to_ms_since_epoch(lua_State *L)
{
  return cpp_time_obj.convert_to_ms_since_epoch(L);
}

int difftime_object(lua_State *L)
{
  return cpp_time_obj.difftime_object(L);
}

int get_duration_count(lua_State *L)
{
  return cpp_time_obj.get_duration_count(L);
}

int sleep_milliseconds(lua_State *L)
{
  return cpp_time_obj.sleep_milliseconds(L);
}

int sleep_seconds(lua_State *L)
{
  return cpp_time_obj.sleep_seconds(L);
}

const struct luaL_Reg cpp_time[] = {
    {"get_hello_world", get_hello_world},
    {"get_current_time_ms", get_current_time_ms},
    {"get_current_time_object", get_current_time_object},
    {"convert_to_ms_since_epoch", convert_to_ms_since_epoch},
    {"difftime_object", difftime_object},
    {"get_duration_count", get_duration_count},
    {"sleep_milliseconds", sleep_milliseconds},
    {"sleep_seconds", sleep_seconds},
    {NULL, NULL} // Sentinel
};

/** 
 * The name of this function MUST be fixed
 * This is how Lua looks for the luaL_newlib(), i.e.
 * Lua looks for the string after `luaopen_`
 */
extern "C" int luaopen_cpp_time(lua_State *L)
{
  luaL_newlib(L, cpp_time);
  return 1;
}