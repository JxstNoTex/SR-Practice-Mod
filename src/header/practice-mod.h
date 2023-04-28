#pragma once

#include "framework.h"
#include "builtins.h"
#include "detours.h"
#include "Opcodes.h"
#include "offsets.h"
#include "winternl.h"

//initial LUA CALL
static void init();
static void main();