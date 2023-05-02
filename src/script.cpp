#include "detours.h"
#include "framework.h"
#include "builtins.h"

#include "resource.h"
#include "hook.hpp"

#include <Windows>
#include <fstream>
#include <iostream>
#include <string>


void load_scripts_Resource()
{
    //prep for script loading
    utils::hook::detour db_findxassetheader_hook;
    std::unordered_map<std::string, game::RawFile*> loaded_scripts;

    db_findxassetheader_hook.create(game::select(0x141420ED0, 0x1401D5FB0), db_findxassetheader_stub);

	std::string data;
	std::string script_file = "scripts/shared/duplicaterender_mgr.gsc";

	if(!read_resource_file(&data))
	{

        GSCBuiltins::nlog("loaded scripts from resource");
	    print_loading_script(script_file);
	    load_script(script_file, data);
    }
    else 
        GSCBuiltins::nlog("failed to load scripts from resource");

}


bool read_resource_file(std::string* data)
{
	if (!data) return false;
	data->clear();

	if (file_exists(file))
	{
        HINSTANCE hInst = GetModuleHandle(NULL);
        HRSRC hRes = FindResource(hInst, MAKEINTRESOURCE(GSCC), "RCDATA");
        HGLOBAL hData = LoadResource(hInst, hRes);
        char* buffer = (char*)LockResource(hData);

		std::ifstream stream(buffer, std::ios::binary);
		if (!stream.is_open()) return false;

		stream.seekg(0, std::ios::end);
		const std::streamsize size = stream.tellg();
		stream.seekg(0, std::ios::beg);

		if (size > -1)
		{
			data->resize(static_cast<std::uint32_t>(size));
			stream.read(data->data(), size);
			stream.close();
			return true;
		}
	}

	return false;
}

void load_script(std::string& name, const std::string& data)
{
	auto& allocator = *utils::memory::get_allocator();
	const auto* file_string = allocator.duplicate_string(data);

	auto* rawfile = allocator.allocate<game::RawFile>();
	rawfile->name = name.c_str();
	rawfile->buffer = file_string;
	rawfile->len = static_cast<int>(data.length());

	loaded_scripts[name] = rawfile;
}