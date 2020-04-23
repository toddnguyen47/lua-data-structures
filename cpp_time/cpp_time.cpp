#include "cpp_time.h"

int CppTime::get_hello_world(lua_State *L)
{
  std::string cur_string = "hello world";
  lua_pushlstring(L, cur_string.c_str(), cur_string.size());
  int number_of_results = 1;
  return number_of_results;
}

int CppTime::get_current_time_ms(lua_State *L)
{
  auto ms = chrono::duration_cast<chrono::milliseconds>(
                chrono::system_clock::now().time_since_epoch())
                .count();
  lua_pushinteger(L, ms);
  int number_of_results = 1;
  return number_of_results;
}

int CppTime::get_current_time_object(lua_State *L)
{
  // Ref: https://www.lua.org/pil/28.1.html
  chrono::steady_clock::time_point *stack_space = static_cast<chrono::steady_clock::time_point *>(
      lua_newuserdata(L, sizeof(chrono::steady_clock::time_point)));
  chrono::steady_clock::time_point current_time = chrono::steady_clock::now();
  *stack_space = current_time;
  int number_of_results = 1;
  return number_of_results;
}

int CppTime::convert_to_ms_since_epoch(lua_State *L)
{
  int number_of_args = lua_gettop(L);
  if (number_of_args != 1)
  {
    lua_pushliteral(L, "Need to supply only one std::chrono::time_point<std::chrono::steady_clock> object");
    lua_error(L); // will exit function right here
  }

  // First argument
  chrono::steady_clock::time_point *time = static_cast<chrono::steady_clock::time_point *>(
      lua_touserdata(L, 1));
  auto milliseconds = chrono::duration_cast<chrono::milliseconds>(time->time_since_epoch()).count();

  lua_pushinteger(L, milliseconds);
  int number_of_results = 1;
  return number_of_results;
}

int CppTime::difftime(lua_State *L)
{
  int number_of_args = lua_gettop(L);
  if (number_of_args != 2)
  {
    lua_pushliteral(L, "Need to supply a start and end time object");
    lua_error(L); // will exit function right here
  }
  chrono::steady_clock::time_point *end_time = static_cast<chrono::steady_clock::time_point *>(
      lua_touserdata(L, 1));
  chrono::steady_clock::time_point *start_time = static_cast<chrono::steady_clock::time_point *>(
      lua_touserdata(L, 2));
  auto time_diff_milliseconds = chrono::duration_cast<chrono::milliseconds>(
                                    (*end_time) - (*start_time))
                                    .count();
  lua_pushinteger(L, time_diff_milliseconds);
  int number_of_results = 1;
  return number_of_results;
}
