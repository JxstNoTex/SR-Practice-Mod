function giantSplits(){

    open_door();
    button_hit();
    pick_annihilator();

}


function open_door(){

    //Creates the timer for the split
    if(!isdefined(level.open_door)){

		level.open_door = newHudElem();
		level.open_door init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^3open door: ");

		level.open_door setTimerUp(0);
		//level.open_door.alpha = 1;
		first_tick = level.ticks;

        old_height = level.height;
		level.height = level.height+15;

	}

    //Waits for the condition to happen
    ///level waittill("outside_east_zone"); this is the first door opened for megas
    level util::waittill_any("outside_east_zone", "outside_west_zone");

    //Saves the time it took
    last_tick = level.ticks;

    //Calculates the time it took
    total_ticks = last_tick - level.first_tick;
    //Deletes the timer and shows the exact time it took to complete the split
	level.open_door thread calculate_split(total_ticks);

}

function button_hit(){

    //Creates the timer for the split
    if(!isdefined(level.button_hit)){

		level.button_hit = newHudElem();
		level.button_hit init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^3button hit: ");

		level.button_hit setTimerUp(0);
		//level.button_hit.alpha = 1;
		first_tick = level.ticks;

		level.height = level.height+15;

	}

    //Waits for the condition to happen
    level flag::wait_till("flytrap");

    //Saves the time it took
    last_tick = level.ticks;

    level.teddy_spawns = newHudElem();
    level.teddy_spawns init_hudelem("left", "top", "user_left", "user_top", 120, 55, 1.5, 0, (1,1,1), 1, &"^7teddy spawns: ");
 
    level.teddy_spawns SetTimer(23);
    level.teddy_spawns.alpha = true;

    level.teddy_spawns thread hide_timer(23);

    //Calculates the time it took
    total_ticks = last_tick - level.first_tick;
    //Deletes the timer and shows the exact time it took to complete the split
	level.button_hit thread calculate_split(total_ticks);
 
}

function pick_annihilator(){

    //Creates the timer for the split
    if(!isdefined(level.pick_annihilator)){

		level.pick_annihilator = newHudElem();
		level.pick_annihilator init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^3pick up annihilator: ");

		level.pick_annihilator setTimerUp(0);
		//level.pick_annihilator.alpha = 1;
		first_tick = level.ticks;

		level.height = level.height+15;

	}

    //Waits for the condition to happen
    while (!is_giant_ee_done()) wait level.tick;

    //Saves the time it took
    last_tick = level.ticks;

    //Calculates the time it took
    total_ticks = last_tick - level.first_tick;
    //Deletes the timer and shows the exact time it took to complete the split
	level.pick_annihilator thread calculate_split(total_ticks);
 
}

function is_giant_ee_done(){
	if(!isDefined(level.var_1cbe7756)) return false;
	if(!level.var_1cbe7756) return false;
	return true;
}