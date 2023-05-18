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

#include scripts\shared\flag_shared;  // for flags
#include scripts\zm\_zm_utility; // for get_round_enemy_array
#include scripts\zm\_util; // for spawn_model

#include scripts\zm\_zm_perks; // for perks machine functionality

#define GAMETICK = 0.05;

#namespace serious;

autoexec __init__sytem__()
{
	compiler::detour();
	system::register("serious", ::__init__, undefined, undefined);
}

__init__()
{
	callback::on_start_gametype(::init);
	callback::on_connect(::on_player_connect);
	callback::on_spawned(::on_player_spawned);
}