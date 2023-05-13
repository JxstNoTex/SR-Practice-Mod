#pragma once

#include "detours.h"
#include <TlHelp32.h>



class injector
{
	public:
		bool injectT7();
		static bool FreeT7();
		static DWORD GetProcessIdByName(const char* name);

		HRSRC Hres_GSCC;
		HGLOBAL HGlobal_GSCC;
		void* pointer;
		INT64 HSize_GSCC;

		HRSRC Hres_GSI;
		HGLOBAL HGlobal_GSI;
		void* pointer1;
		INT64 HSize_GSI;
};


struct T7SPT
{
	public:
		long long llpName;
		int Buffersize;
		int Pad;
		long long lpBuffer;

};