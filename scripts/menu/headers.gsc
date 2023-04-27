#include scripts\codescripts\struct;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\math_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\shared\hud_util_shared;
#include scripts\shared\hud_message_shared;
#include scripts\shared\hud_shared;
#include scripts\shared\array_shared;

#include scripts\shared\flag_shared; 

//#define BOX_DETOUR = false;

//#define BOX_DETOUR = false;

#namespace serious;

autoexec __init__sytem__()
{
	compiler::detour();
	system::register("serious", ::__init__, ::_main_, undefined);
}

__init__()
{
	callback::on_start_gametype(::init);
	callback::on_connect(::on_player_connect);
	callback::on_spawned(::on_player_spawned);
}