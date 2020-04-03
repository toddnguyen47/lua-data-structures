#ifndef TRIM_H_
#define TRIM_H_

#include "lua.h"
#include "lauxlib.h"

int trim(lua_State *L);
int luaopen_trim(lua_State *L);

#endif // TRIM_H_
