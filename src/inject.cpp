#include "pch.h"
#include "offsets.h"
#include "resource.h"
#include "builtins.h"
#include <string>
#include <filesystem>
#include <fstream>
#include <stdio.h>
#include <vector>
#include <unordered_set>
#include <thread>
#include "resource.h"
#include "pch.h"
#include "Utils.h"


#define OFF_ScrVarGlob REBASE(0x51A3500)
#define OFFSET(x)((INT64)GetModuleHandle(NULL) + (INT64)x)

DWORD pID;
HANDLE pHandle;
T7SPT t7spt;

long long int data_1 = 0;
int data_2 = 0;

HMODULE GCM()
{
    HMODULE hModule = NULL;
    GetModuleHandleEx(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS, (LPCSTR)GCM, &hModule);
    return hModule;
}



bool injector::injectT7()
{
    HMODULE hm = NULL;
    bool injectResponse = false;

    //preload gscc
    HRSRC Hres_GSCC = FindResource(GCM(), MAKEINTRESOURCE(GSCC), (LPCSTR)"BIN");
    HGLOBAL HGlobal_GSCC = LoadResource(GCM(), Hres_GSCC);
    void* pointer = (void*)LockResource(HGlobal_GSCC);
    INT64 HSize_GSCC = SizeofResource(GCM(), Hres_GSCC);


    if (GetModuleHandleEx(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS | GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT, (LPCSTR)&GSCBuiltins::AddCustomFunction, &hm) == 0)
    {
        int ret = GetLastError();
        GSCBuiltins::nlog("nope");
        // Return or however you want to handle an error.
    }
    else
    {
        pID = Utils::GetProcId("BlackOps3.exe");
        if (pID != 0)
        {
            //GSCBuiltins::nlog("%d", pID);

            pHandle = OpenProcess(PROCESS_ALL_ACCESS, FALSE, pID);

            ReadProcessMemory(pHandle, (LPCVOID)0x00007FF665E07AB0, &data_1, sizeof(data_1), 0);

            ReadProcessMemory(pHandle, (LPCVOID)(0x00007FF665E07AB0 + 0x14), &data_2, sizeof(data_2), 0);

            UINT64 sptGlobal = data_1;
            int sptCount = data_2;

            //GSCBuiltins::nlog(" sptcount: %d", sptCount);
            //std::cout << sptGlobal << std::endl;
            //std::cout << sptCount << std::endl;

            for (int i = 0; i < sptCount; i++)
            {
                
                ReadProcessMemory(pHandle, (LPCVOID)(sptGlobal + (i * 0x18)), &t7spt, sizeof(t7spt), 0);
                char strBuff[39];
                UINT64 intbuff;

                ReadProcessMemory(pHandle, (LPCVOID)t7spt.llpName, &strBuff, sizeof(strBuff), 0);

                if (i == 34) //cause strBuff == "scripts/shared/duplicaterender_mgr.gsc" dosent work
                {
                    std::cout << "found it" << std::endl;
                    GSCBuiltins::nlog("found it");
                    std::cout << "---------------------------------------------------" << std::endl;
                    std::cout << "buffersize: " << t7spt.Buffersize << std::endl;
                    std::cout << "Pad: " << t7spt.Pad << std::endl;
                    std::cout << "llpName: " << t7spt.llpName << std::endl;
                    std::cout << "lpbuffer" << t7spt.lpBuffer << std::endl;
                    std::cout << "loaded Script number: " << i << std::endl;
                    std::cout << "String Name: " << strBuff << std::endl;

                    unsigned long long llpModifiedSPTStruct;
                    unsigned long long llpOriginalBuffer;
                    int OriginalSourceChecksum;

                    llpModifiedSPTStruct = i * sizeof(T7SPT) + sptGlobal;
                    llpOriginalBuffer = t7spt.lpBuffer;
                    ReadProcessMemory(pHandle, (LPCVOID)(llpOriginalBuffer + 0x8), &OriginalSourceChecksum, sizeof(OriginalSourceChecksum), 0);
                    std::cout << "---------------------------------------------------" << std::endl;
                    std::cout << "llpModifiedSPTStruct: " << llpModifiedSPTStruct << std::endl;
                    std::cout << "llpOriginalBuffer: " << llpOriginalBuffer << std::endl;
                    std::cout << "OriginalSourceChecksum: " << OriginalSourceChecksum << std::endl;

                    std::cout << "size of lpbuffer: " << t7spt.Buffersize << std::endl;

                    std::cout << "buffer size" << HSize_GSCC << std::endl;

                    //VirtualAlloc((LPVOID)OFFSET(t7spt.lpBuffer), HSize_GSCC, MEM_COMMIT, PAGE_READWRITE);
                    
                    VirtualAllocEx(NULL, (LPVOID)t7spt.lpBuffer, HSize_GSCC, MEM_COMMIT | MEM_RESERVE, PAGE_EXECUTE_READWRITE);
                    WriteProcessMemory(pHandle, (LPVOID)(sptGlobal + i + 0x8), (LPVOID)HSize_GSCC, sizeof(int), 0);
                    WriteProcessMemory(pHandle, (LPVOID)t7spt.lpBuffer, pointer, HSize_GSCC, 0);

                    T7SPT locked;

                    ReadProcessMemory(pHandle, (LPCVOID)(sptGlobal + (i * 0x18)), &locked, sizeof(locked), 0);

                    std::cout << "size of new lpbuffer: " << locked.Buffersize << std::endl;
                    
                    

                    return 1;
                }
            }
            

            GSCBuiltins::nlog("DLL Handle init loaded");
            HRSRC Hres_GSI = FindResource(hm, MAKEINTRESOURCE(GSI), (LPCSTR)"BIN");
            HGLOBAL HGlobal_GSI = LoadResource(hm, Hres_GSI);
            void* pointer = (void*)LockResource(HGlobal_GSI);
            INT64 HSize_GSI = SizeofResource(hm, Hres_GSI);

            if (HSize_GSI <= 1)
            {
                GSCBuiltins::nlog("GSI wasnt allocated from resource");
            }
            if (HSize_GSCC <= 1)
            {
                GSCBuiltins::nlog("GSCC wasnt allocated from resource");
            }

            RemoveDetours();

            RegisterDetours(pointer,1, t7spt.lpBuffer);

            //free the resource
            BOOL bResult = UnlockResource(Hres_GSI);
            bResult = FreeResource(Hres_GSI);
        }

        return injectResponse;
    }
}