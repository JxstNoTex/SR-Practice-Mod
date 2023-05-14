#pragma once

#define WEAK __declspec(selectany)

namespace game
{
	WEAK symbol<void(int localClientNum, const char* text)> Cbuf_AddText{ 0x1420EC010_g}; // done

	WEAK symbol<void(int channel, unsigned int label, const char* fmt, ...)> Com_Printf{ 0x142148F60_g}; //done

	WEAK symbol<void(char* text, int maxSize)> Con_GetTextCopy{ 0x14133A7D0_g}; // done

	WEAK symbol<void()> Sys_ShowConsole{0x1423333C0_g}; //done
 
	WEAK symbol<int(int scriptInst, int var)> ScrVm_AddInt{0x1412E9870_g}; 

	namespace s_wcd
	{
		WEAK symbol<HWND> codLogo{ 0x157E75A50_g};//done
		WEAK symbol<HFONT> hfBufferFont{ 0x157E75A58_g}; //done
		WEAK symbol<HWND> hWnd{ 0x157E75A40_g}; //done
		WEAK symbol<HWND> hwndBuffer{ 0x157E75A48_g}; //done
		WEAK symbol<HWND> hwndInputLine{ 0x157E75A60_g}; //done
		WEAK symbol<int> windowHeight{ 0x157E7606C_g}; //done
		WEAK symbol<int> windowWidth{ 0x157E76068_g}; //done
		WEAK symbol<WNDPROC> SysInputLineWndProc{ 0x157E76070_g}; //done
	}
}
