function Zod_Splits(){

    open_egg();

    open_pap();

    get_book();

    last_flag();

    shadowman();

}


// cantidad de rituales hechos level.var_f47099f2

function open_egg(){

    //Creates the timer for the split
    if(!isdefined(level.open_egg)){

		level.open_egg = newHudElem();
		level.open_egg init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^3open_egg: ");

		level.open_egg setTimerUp(0);
		//level.open_egg.alpha = 1;
		first_tick = level.ticks;

		level.height = level.height+15;

	}

    //Waits for the condition to happen
    level flag::wait_till("keeper_sword_locker");

    //Saves the time it took
    last_tick = level.ticks;

    //Calculates the time it took
    total_ticks = last_tick - level.first_tick;
    //Deletes the timer and shows the exact time it took to complete the split
	level.open_egg thread calculate_split(total_ticks);
 
}

function open_pap(){

    //Creates the timer for the split
    if(!isdefined(level.open_pap)){

		level.open_pap = newHudElem();
		level.open_pap init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^3open_pap: ");

		level.open_pap setTimerUp(0);
		//level.open_pap.alpha = 1;
		first_tick = level.ticks;

		level.height = level.height+15;

	}

    //Waits for the condition to happen
    level flag::wait_till("pap_door_open");

    //Saves the time it took
    last_tick = level.ticks;

    //Calculates the time it took
    total_ticks = last_tick - level.first_tick;
    //Deletes the timer and shows the exact time it took to complete the split
	level.open_pap thread calculate_split(total_ticks);
 
}

function get_book(){

    //Creates the timer for the split
    if(!isdefined(level.get_book)){

		level.get_book = newHudElem();
		level.get_book init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^3get_book: ");

		level.get_book setTimerUp(0);
		//level.get_book.alpha = 1;
		first_tick = level.ticks;

		level.height = level.height+15;

	}

    //Waits for the condition to happen
    level flag::wait_till("ee_book");

    //Saves the time it took
    last_tick = level.ticks;

    //Calculates the time it took
    total_ticks = last_tick - level.first_tick;
    //Deletes the timer and shows the exact time it took to complete the split
	level.get_book thread calculate_split(total_ticks);
 
}

function last_flag(){

    //Creates the timer for the split
    if(!isdefined(level.last_flag)){

		level.last_flag = newHudElem();
		level.last_flag init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^3last_flag: ");

		level.last_flag setTimerUp(0);
		//level.last_flag.alpha = 1;
		first_tick = level.ticks;

		level.height = level.height+15;

	}

    //Waits for the condition to happen

    level waittill("ee_keeper_resurrected");
    level waittill("ee_keeper_resurrected");
    level waittill("ee_keeper_resurrected");

    //luego comprueba que alguien haya pillado la bandera

    level.player_flag = 0;

    level thread flag_checker();

    while(!level.player_flag) wait level.tick;

    //Saves the time it took
    last_tick = level.ticks;

    //Calculates the time it took
    total_ticks = last_tick - level.first_tick;
    //Deletes the timer and shows the exact time it took to complete the split
	level.last_flag thread calculate_split(total_ticks);
 
}

function flag_checker(){

    while(!level.player_flag){
        wait level.tick;

        foreach(player in level.players){
            if(isdefined(player.var_11104075)){
               level.player_flag = 1;
               break; 
            }
        }
    }

    
}

function shadowman(){

    //Creates the timer for the split
    if(!isdefined(level.shadowman)){

		level.shadowman = newHudElem();
		level.shadowman init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^3shadowman: ");

		level.shadowman setTimerUp(0);
		//level.shadowman.alpha = 1;
		first_tick = level.ticks;

		level.height = level.height+15;

	}

    //Waits for the condition to happen
    level flag::wait_till("ee_boss_defeated");

    //Saves the time it took
    last_tick = level.ticks;

    //Calculates the time it took
    total_ticks = last_tick - level.first_tick;
    //Deletes the timer and shows the exact time it took to complete the split
	level.shadowman thread calculate_split(total_ticks);
 
}