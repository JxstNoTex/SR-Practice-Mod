init()
{
    level.tick = 0.05;

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

_main_()
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

    /*while(true)
    {
        self iPrintLnBold(map_name);
        waittillframeend;
    }*/
}




on_player_connect()
{
    //Makes the used gums stast not to be updated
    self thread delete_bgb_uses();

    //Shows ingame speed meter
    self thread speedmeter_hud();

    //No host players restart when frag + mele is pressed 0.5s
    if(!self ishost()) self thread fast_restart();
}

on_player_spawned()
{
	self endon("spawned_player");

    wait 5;
        self enableInvulnerability();
        self.ignoreme = 1;
        self.score = 777770;
    
    self iPrintLnBold(level.register_numbers);

}