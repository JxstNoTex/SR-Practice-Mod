init()
{
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

    /*wait 5;
        self enableInvulnerability();
        self.ignoreme = 1;
        self.score = 777770;
    */

}