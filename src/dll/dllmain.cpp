// dllmain.cpp : Defines the entry point for the DLL application.
#include "pch.h"

#include <lua.h>
#include <lua.hpp>
#include <luaconf.h>
#include <lualib.h>

#include "builtins.h"
#include "Opcodes.h"
#include "detours.h"


int init()
{
	//create object reference for injector
	injector obj;
	obj.injectT7();
	return 1;
}





extern "C"
{
	int __declspec(dllexport) entry(lua_State* L)
	{
		GSCBuiltins::Init();
		ScriptDetours::InstallHooks();
		Opcodes::Init();
		GSCBuiltins::nlog("dll loaded");
		return init();
	}
}

