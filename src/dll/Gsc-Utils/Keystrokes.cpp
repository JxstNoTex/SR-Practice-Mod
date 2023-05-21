#include "Gsc-Utils.h"
#include <conio.h>
char KB_code;
#define KB_UP 72
#pragma warning( disable : 4996 )




inline int abs(int a)
{
	return (a < 0) ? -a : a;
}

int GSC::Utils::Keystoreks::returnKeystoreks(char input)
{
	if (GetKeyState(input) & 0x8000)
	{
		std::cout << input << " is Pressed" << std::endl;
		return input;
	}

	return 0;
}
