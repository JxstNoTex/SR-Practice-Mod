#include "header/anti-cheat.h"

static int isModApproved(char* ff)
{
    SHA1 checksum;
    checksum.update(ff);
    const string checksum = checksum.final();
    //if we match the checksum of the mod.ff, then we are good to go
    if(checksum == SHA1)
        return 1;
    else    
        return 0;
}


static char* readAllBytes(const char * filename, int * read)
{
    ifstream ifs(filename, ios::binary|ios::ate);
    ifstream::pos_type pos = ifs.tellg();
    int length = pos;
    char *pBuffer = new char[length];
    ifs.seekg(o, ios::beg);
    ifs.read(pBuffer, length);
    ifs.close();
    *read = length;
    return pBuffer;
}