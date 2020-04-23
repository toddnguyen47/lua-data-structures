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

int difftime(lua_State *L)
{
  return cpp_time_obj.difftime(L);
}

const struct luaL_Reg cpp_time[] = {
    {"get_hello_world", get_hello_world},
    {"get_current_time_ms", get_current_time_ms},
    {"get_current_time_object", get_current_time_object},
    {"convert_to_ms_since_epoch", convert_to_ms_since_epoch},
    {"difftime", difftime},
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