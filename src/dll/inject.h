#pragma once

#include "detours.h"
#include <TlHelp32.h>
class injector
{
	public:
		bool injectT7();
		DWORD GetProcessIdByName(const char* name);

};


struct T7SPT
{
	public:
		long long llpName;
		int Buffersize;
		int Pad;
		long long lpBuffer;

};