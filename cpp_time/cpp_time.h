#ifndef CPP_TIME_H_
#define CPP_TIME_H_

/* Ref: http://lua-users.org/wiki/StringTrim */
/* Ref for luaL_newlib: https://chsasank.github.io/lua-c-wrapping.html */
/* trim.c - based on http://lua-users.org/lists/lua-l/2009-12/msg00951.html
            from Sean Conner */
#include <lua.hpp>
#include <iostream>
#include <chrono>
#include <thread>

using namespace std;

class CppTime
{
public:
  int get_hello_world(lua_State *L);
  int get_current_time_ms(lua_State *L);
  int get_current_time_object(lua_State *L);
  int convert_to_ms_since_epoch(lua_State *L);
  int difftime_object(lua_State *L);
  int get_duration_count(lua_State *L);
  int sleep_milliseconds(lua_State *L);
  int sleep_seconds(lua_State *L);

private:
  class SleepFor
  {
  public:
    virtual void sleep(double time_to_sleep) = 0;
  };

  class SleepForSeconds : public SleepFor
  {
  public:
    void sleep(double time_to_sleep);
  };

  class SleepForMilliseconds : public SleepFor
  {
  public:
    void sleep(double time_to_sleep);
  };

  int sleep(lua_State *L, SleepFor *sleep_for_obj);
};

#endif // CPP_TIME_H_
