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

int CppTime::difftime_object(lua_State *L)
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
  // Ref: https://en.cppreference.com/w/cpp/chrono/duration/duration_cast
  chrono::duration<double, std::milli> diff = *end_time - *start_time;
  // Ref: https://www.lua.org/pil/28.1.html
  chrono::duration<double, std::milli> *stack_space = static_cast<chrono::duration<double, std::milli> *>(
      lua_newuserdata(L, sizeof(chrono::duration<double, std::milli>)));
  *stack_space = diff;
  int number_of_results = 1;
  return number_of_results;
}

int CppTime::get_duration_count(lua_State *L)
{
  int number_of_args = lua_gettop(L);
  if (number_of_args != 1)
  {
    lua_pushliteral(L, "Need to supply std::chrono object");
    lua_error(L); // will exit function right here
  }
  chrono::duration<double, std::milli> *end_time = static_cast<chrono::duration<double, std::milli> *>(
      lua_touserdata(L, 1));
  double count = end_time->count();
  lua_pushnumber(L, count);
  int number_of_results = 1;
  return number_of_results;
}

int CppTime::sleep_milliseconds(lua_State *L)
{
  CppTime::SleepForMilliseconds *sleep_milli_obj = new CppTime::SleepForMilliseconds();
  int number_of_results = this->sleep(L, sleep_milli_obj);
  delete (sleep_milli_obj);
  return number_of_results;
}

int CppTime::sleep_seconds(lua_State *L)
{
  CppTime::SleepForSeconds *sleep_seconds_obj = new CppTime::SleepForSeconds();
  int number_of_results = this->sleep(L, sleep_seconds_obj);
  delete (sleep_seconds_obj);
  return number_of_results;
}

int CppTime::sleep(lua_State *L, SleepFor *sleep_for_obj)
{
  int number_of_args = lua_gettop(L);
  if (number_of_args != 1)
  {
    lua_pushliteral(L, "Need to supply a time to sleep");
    lua_error(L); // will exit function right here
  }

  double time_to_sleep = lua_tonumber(L, 1);
  sleep_for_obj->sleep(time_to_sleep);

  int number_of_results = 1;
  return number_of_results;
}

void CppTime::SleepForSeconds::sleep(double time_to_sleep)
{
  int sec = static_cast<int>(time_to_sleep * 1000.0);
  this_thread::sleep_for(std::chrono::milliseconds(sec));
}

void CppTime::SleepForMilliseconds::sleep(double time_to_sleep)
{
  int sec = static_cast<int>(time_to_sleep);
  this_thread::sleep_for(std::chrono::milliseconds(sec));
}
