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

#include scripts\shared\flag_shared;	// flag functions
#include scripts\zm\_zm_utility; 		// to use get_round_enemy_array and check ABH locations
#include scripts\zm\_util; 				// for spawn_model

#include scripts\zm\_zm_perks; 			// for perks machine functionality

#include scripts\zm\_zm_zonemgr; 		// to get zones for abh locations

#include scripts\zm\_zm_bgb;			// lets me modify gum stats
#include scripts\zm\bgbs\_zm_bgb_anywhere_but_here; // abh registration
#include scripts\zm\_zm_weapons; 		// allows to start with RK5 even if you didnt unlock it

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