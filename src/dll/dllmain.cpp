// dllmain.cpp : Defines the entry point for the DLL application.
#include "pch.h"

#include <lua.h>
#include <lua.hpp>
#include <luaconf.h>
#include <lualib.h>

#include "component_loader.hpp"
#include "builtins.h"
#include "Opcodes.h"
#include "detours.h"
#include "inject.h"
#include "resource.h"

injector inject;

int init()
{
	//create object reference for injector
	
	inject.injectT7();


	return 1;
}


void unload()
{
	//destroy console
	component_loader::pre_destroy();


	//unload resource and gsc

	inject.FreeT7();

	ScriptDetours::ResetDetours();
	BOOL gsiResult = UnlockResource(inject.Hres_GSI);
	gsiResult = FreeResource(inject.Hres_GSI);

	BOOL gccResult1 = UnlockResource(inject.Hres_GSCC);
	gccResult1 = FreeResource(inject.Hres_GSCC);
}

extern "C"
{
	void __declspec(dllexport) entry(lua_State* L)
	{
		init();
		GSCBuiltins::Init();
		ScriptDetours::InstallHooks();
		Opcodes::Init();
		
		GSCBuiltins::nlog("dll loaded");
		component_loader::post_unpack();

		atexit(unload);
	}
}

