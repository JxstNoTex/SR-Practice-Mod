function timer_hud()
{

	//Waits for the match to begin
    level flag::wait_till("start_zombie_round_logic");
	wait 2.5;

	level.height = 15;

	//Creates general match timer
	if(!isdefined(level.timer_hud)){

		level.timer_hud = newHudElem();
		level.timer_hud init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^3Global Time: ");

		level.timer_hud setTenthsTimerUp(0.01); //setTimerUp(0);
		level.timer_hud.alpha = 1;
		level.first_tick = level.ticks;

		level.height = level.height+15;

	}

	//Creates round timer
	if(!isdefined(level.minitimer_hud)){

		level.minitimer_hud = newHudElem();
		level.minitimer_hud init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^7Round: ");

		level.minitimer_hud setTenthsTimerUp(0.01);//setTimerUp(0);
		level.minitimer_hud.alpha = 1;

		level.minitimer_hud thread round_end_reset();

		level.height = level.height+15;

	}


}

/*  TEMPLATE TO CREATE NEW SPLIT

function new_split(){

    //Creates the timer for the split
    if(!isdefined(level.new_split)){

		level.new_split = newHudElem();
		level.new_split init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^3new_split: ");

		level.new_split setTimerUp(0);
		//level.new_split.alpha = 1;
		first_tick = level.ticks;

		level.height = level.height+15;

	}

    //Waits for the condition to happen
    while (something) wait level.tick; / level flag::wait_till(str_flag);

    //Saves the time it took
    last_tick = level.ticks;

    //Calculates the time it took
    total_ticks = last_tick - level.first_tick;
    //Deletes the timer and shows the exact time it took to complete the split
	level.new_split thread calculate_split(total_ticks);
 
}

*/