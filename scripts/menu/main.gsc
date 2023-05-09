init()
{
    level.tick = 0.05;
    if(!isdefined(level.detour_functions)) level.detour_functions = [];
    level.debug = 1;

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

    while(!isDefined(level.randomize_perk_machine_location)) wait GAMETICK;
    level.randomize_perk_machine_location = 0;

}

/*_main_(){

    switch(level.script){
        case "zm_castle":
        BOX_DETOUR = true;
        break;

        default:
        break;
    }
}*/

/*_main_()
{
    
    map_name = level.script;
    switch(map_name)
      {
        case "zm_zod":
              //EXEXC_ZOD_DETOUR = true
              //compiler::relinkdetour();
              break;
        case "zm_castle":
            //BOX_DETOUR;
            compiler::relinkdetour();
            break;
        default:
            break;
    }
}*/




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
}

on_player_spawned()
{
	self endon("spawned_player");

    if(level.debug){
        wait 5;
        self enableInvulnerability();
        //self.ignoreme = 1;
        self.score = 777770;


        self.bgb_pack = [];
        self.bgb_pack_randomized = [];
        //ArrayInsert(self.bgb_pack, "zm_bgb_round_robbin", self.bgb_pack.size);
        //ArrayInsert(self.bgb_pack_randomized, "zm_bgb_perkaholic", 0);
        ArrayInsert(self.bgb_pack, "zm_bgb_reign_drops", 0);
        ArrayInsert(self.bgb_pack_randomized, "zm_bgb_reign_drops", 0);

        self iPrintLnBold("Debuger mode activated");
    }
}


/*

self setlowready(0);

*/