init()
{
    //Determines if the game played is megas or not
    level.is_megas = undefined;
    level thread get_gum_category();

    //This checks if random perk locations should be changed
    if(level.script == "zm_factory" || level.script == "zm_zod" &&  world.practice){
        level thread custom_perk_locations();
    }


    level.tick = 0.05;
    if(!isdefined(level.detour_functions)) level.detour_functions = [];
    level.debug = true;

    if(level.debug){

        level.debug_perks_location = false;
        level.debug_is_megas = true;
        level.debug_bgb_pack = true;

    }else{

        level.debug_perks_location = false;
        level.debug_is_megas = false;
        level.debug_bgb_pack = false;

    }

    //This creates the possible gamemodes
    if(!isDefined(world.practice)) level create_sr_modes();

    //This allowplayers to switch between modes;
    level thread change_sr_mode();

    //Starts custom in game timer
    level thread game_time();

    //Starts the ingame timers
    level thread timer_hud();

    //Makes all gums not to count 
    level thread free_megas();

    //Skips game end cinematic
    level thread fast_exit();

    //Fixes various visual bugs
    level thread improve_render();

    //Elimintaes lag when activating power
    level thread precache_strings();

    //Shows ingame attempt counter
    level thread attempt_counter();

    //Shows the available round end time
    level thread showEndTimes();



    //Patches level.powerup_special_drop_override
    level thread powerup_special_drop_override();
    
    //Patches level.customrandomweaponweights
    level thread customrandomweaponweights();

    //Patches level.zm_custom_spawn_location_selection
    level thread zm_custom_spawn_location_selection();

    //Patches only things for practice mode
    if(world.practice){

        //Changes perk locations
        if(level.script == "zm_factory" || level.script == "zm_zod") level thread custom_perk_locations();

        //Patches box start position
        level thread random_pandora_box_start();

        //Patches dog rounds
        level thread set_custom_special_round();

        //Patches GBG packs and order
        level thread custom_bgb_pack();

    }

}


on_player_connect()
{
    //Makes the used gums stast not to be updated
    self thread delete_bgb_uses();

    //Shows ingame speed meter
    self thread speedmeter_hud();

    //No host players restart when frag + mele is pressed 0.5s
    if(!self ishost()) self thread fast_restart();

    //Allows me to check how many detours are being used
    if(self ishost() && level.debug) self thread debug_hud();

    //Shows number of manipulable spawns at SoE and Giant Style
    if(self IsHost() && level.debug) level thread n_zombie_spawn_hud();
}

on_player_spawned()
{
	self endon("spawned_player");

    if(level.debug){
        wait 5;
        self enableInvulnerability();
        self.ignoreme = 1;
        self.score = 777770;
        self notify("stop_player_out_of_playable_area_monitor");

        /*self.bgb_pack = [];
            self.bgb_pack_randomized = [];
            ArrayInsert(self.bgb_pack, "zm_bgb_round_robbin", self.bgb_pack.size);
        ArrayInsert(self.bgb_pack_randomized, "zm_bgb_round_robbin", 0);*/
        //ArrayInsert(self.bgb_pack, "zm_bgb_reign_drops", 0);
        //ArrayInsert(self.bgb_pack_randomized, "zm_bgb_reign_drops", 0);

        self iPrintLnBold("Debuger mode activated");
    }
}


/*

self setlowready(0);

*/