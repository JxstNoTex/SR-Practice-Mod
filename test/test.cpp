// test.cpp : This file contains the 'main' function. Program execution begins and ends there.

#include "resource.h"
#include <Windows.h>
#include "Header.h"
#include <string>
#include <filesystem>
#include <fstream>
#include <stdio.h>
#include <vector>
#include <iostream>
#include "resource.h"
#include <thread>
#include "detours.h"
#include "Memhelp.h"
#include <tchar.h>
#include "builtins.h"

DWORD GetModuleBase(DWORD processId, TCHAR* szModuleName)
{
    DWORD moduleBase = 0;
    HANDLE hSnapshot = CreateToolhelp32Snapshot(TH32CS_SNAPMODULE | TH32CS_SNAPMODULE32, processId);
    if (hSnapshot != INVALID_HANDLE_VALUE) {
        MODULEENTRY32 moduleEntry;
        moduleEntry.dwSize = sizeof(MODULEENTRY32);
        if (Module32First(hSnapshot, &moduleEntry)) {
            do {
                if (wcscmp((const wchar_t*)moduleEntry.szModule, (const wchar_t*)szModuleName) == 0) {
                    moduleBase = (DWORD)moduleEntry.modBaseAddr;
                    break;
                }
            } while (Module32Next(hSnapshot, &moduleEntry));
        }
        CloseHandle(hSnapshot);
    }
    return moduleBase;
}


struct T7SPT
{
	public:
        long long llpName;
		int Buffersize;
		int Pad;
		long long lpBuffer;

};

HMODULE GCM()
{
    HMODULE hModule = NULL;
    GetModuleHandleEx(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS, (LPCSTR)GCM, &hModule);
    return hModule;
}
    

DWORD pID;
long long data_1 = 0;
int data_2 = 0;

int main()
{
        std::cout <<"DLL Handle init loaded" << std::endl;
        HRSRC Hres = FindResourceA(GCM(), MAKEINTRESOURCE(GSI), (LPCSTR)"BIN");
        HGLOBAL HGlobal = LoadResource(GCM(), Hres);
        INT64 HSize = SizeofResource(GCM(), Hres);
        void* pointer = (void*)LockResource(HGlobal);


        pID = MemHelp::GetProcessIdByName("BlackOps3.exe");

        if (pID != 0)
        {
            //baseAdr = MemHelp::GetModuleBaseAddress(pID, "BlackOps3.exe");
            INT64 baseAdr = (INT64)MemHelp::GetModuleBaseAddress(pID, "BlackOps3.exe");
           
            
            HANDLE ProcessHandle = NULL;
            ProcessHandle = OpenProcess(PROCESS_ALL_ACCESS, NULL, pID);



            ReadProcessMemory(ProcessHandle, (LPCVOID)(baseAdr + 0x9407AB0), &data_1, sizeof(data_1), 0);

            ReadProcessMemory(ProcessHandle, (LPCVOID)(baseAdr + 0x9407AB0 + 0x14), &data_2, sizeof(data_2), 0);

            long long sptGlobal = data_1;
            int sptCount = data_2;

            std::cout << sptGlobal << std::endl;
            std::cout << sptCount << std::endl;


            //load everything from sptglobal into t7spt and jumpy to the start of the next t7spt struct untill t7spt.length == sptCount
            for (int i = 0; i < sptCount; i++)
            {
                T7SPT t7spt;
                ReadProcessMemory(ProcessHandle, (LPCVOID)(sptGlobal + (i * 0x18)), &t7spt, sizeof(t7spt), 0);
                std::cout << "---------------------------------------------------" << std::endl;
                std::cout << "buffersize: " << t7spt.Buffersize << std::endl;
                std::cout << "Pad: " << t7spt.Pad << std::endl;
                std::cout << "llpName: " << (char)t7spt.llpName << std::endl;
                std::cout << "lpbuffer" << t7spt.lpBuffer << std::endl;
                std::cout << "loaded Script number: " << i << std::endl;
                if (t7spt.llpName == 0x000002638ED70867)
                {
                    std::cout << "found it" << std::endl;
                    return 1;
                }
            }


        }
        if (!HSize <= 0)
        {
            //RegisterDetours(pointer, 1, 0000025711340000);
        }
        else
            std::cout << "Failed to load resource" << std::endl;
        
}
