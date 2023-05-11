#pragma once

#include "detours.h"
#include "Memhelp.h"
class injector
{
	public:
		bool injectT7();

};


struct T7SPT
{
	public:
		long long llpName;
		int Buffersize;
		int Pad;
		long long lpBuffer;

};