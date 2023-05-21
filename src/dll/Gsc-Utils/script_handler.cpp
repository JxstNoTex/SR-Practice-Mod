#include "pch.h"
#include "script_handler.h"
#include "inject.h"
#include "utils/io.hpp"

DWORD pID;
HANDLE pHandle;
T7SPT t7spt_1;
int InjectedBuffSize;
long long int data_1 = 0;
int data_2 = 0;
unsigned long long llpModifiedSPTStruct;

int script_handler::scriptDump()
{
    injector injector;
    pID = injector.GetProcessIdByName("BlackOps3.exe");
    GSCBuiltins::nlog("%d", pID);
    pHandle = OpenProcess(PROCESS_ALL_ACCESS, FALSE, pID);
    ReadProcessMemory(pHandle, (LPCVOID)OFFSET(0x9407AB0), &data_1, sizeof(data_1), 0);
    ReadProcessMemory(pHandle, (LPCVOID)(OFFSET(0x9407AB0) + 0x14), &data_2, sizeof(data_2), 0);
    UINT64 sptGlobal = data_1;
    int sptCount = data_2;

    for (int i = 0; i < sptCount; i++)
    {
        if (i == 0)
        {
            //gsc 0 is just called default with no extension thus our wile writter crashes
            //do nothing
        }
        else
        {
            char strBuff[256];
            char path[256] = "mods/sr_practice/zone/";
            ReadProcessMemory(pHandle, (LPCVOID)(sptGlobal + (i * 0x18)), &t7spt_1, sizeof(t7spt_1), 0);

            ReadProcessMemory(pHandle, (LPCVOID)t7spt_1.llpName, strBuff, sizeof(strBuff), 0);

            void* buffer;
            buffer = malloc(t7spt_1.Buffersize);
            ReadProcessMemory(pHandle, (LPCVOID)t7spt_1.lpBuffer, buffer, t7spt_1.Buffersize, 0);

            strcat_s(path, strBuff);
            std::cout << "full path: " << path << std::endl;

            //write buffer to file
            //make sure we create the directory first
            std::string dir = path;
            dir = dir.substr(0, dir.find_last_of("/\\"));
            utils::io::create_directory(dir);
            std::ofstream file(path, std::ios::binary);
            file.write((char*)buffer, t7spt_1.Buffersize);
            file.close();
            
        }

        

    }
    return 0;
}

bool script_handler::prechache()
{

    return true;
}

bool script_handler::reload()
{
    return true;
}