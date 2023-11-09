function Castle_Splits(){

    //Optional Timers
    level thread Plunger();

    //Mandatory Timers
    level dragons_fed();

    level upgraded_bow();

    level code_set();

    level keeper_start();

    level boss_fight_ready();

    level ee_completed();

}


function dragons_fed(){

    //Creates the timer for the split
    if(!isdefined(level.dragons_fed)){

		level.dragons_fed = newHudElem();
		level.dragons_fed init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^3dragons_fed: ");

		level.dragons_fed setTimerUp(0);
		//level.dragons_fed.alpha = 1;
		first_tick = level.ticks;

		level.height = level.height+15;

	}

    //Waits for the condition to happen
    level flag::wait_till("soul_catchers_charged");

    //Saves the time it took
    last_tick = level.ticks;

    //Calculates the time it took
    total_ticks = last_tick - level.first_tick;
    //Deletes the timer and shows the exact time it took to complete the split
	level.dragons_fed thread calculate_split(total_ticks);
 
}


function upgraded_bow(){

    //Creates the timer for the split
    if(!isdefined(level.upgraded_bow)){

		level.upgraded_bow = newHudElem();
		level.upgraded_bow init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^3upgraded_bow: ");

		level.upgraded_bow setTimerUp(0);
		//level.upgraded_bow.alpha = 1;
		first_tick = level.ticks;

		level.height = level.height+15;

	}

    //Waits for the condition to happen
    while (!check_bow_upgraded()) wait level.tick;

    //Saves the time it took
    last_tick = level.ticks;

    //Calculates the time it took
    total_ticks = last_tick - level.first_tick;
    //Deletes the timer and shows the exact time it took to complete the split
	level.upgraded_bow thread calculate_split(total_ticks);
 
}


function code_set(){

    //Creates the timer for the split
    if(!isdefined(level.code_set)){

		level.code_set = newHudElem();
		level.code_set init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^3code_set: ");

		level.code_set setTimerUp(0);
		//level.code_set.alpha = 1;
		first_tick = level.ticks;

		level.height = level.height+15;

	}

    //Waits for the condition to happen
    level flag::wait_till("dimension_set");
    //level waittill(#"hash_a126360f");

    //Saves the time it took
    last_tick = level.ticks;

    //Calculates the time it took
    total_ticks = last_tick - level.first_tick;
    //Deletes the timer and shows the exact time it took to complete the split
	level.code_set thread calculate_split(total_ticks);
 
}

function keeper_start(){

    //Creates the timer for the split
    if(!isdefined(level.keeper_start)){

		level.keeper_start = newHudElem();
		level.keeper_start init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^3keeper_start: ");

		level.keeper_start setTimerUp(0);
		//level.keeper_start.alpha = 1;
		first_tick = level.ticks;

		level.height = level.height+15;

	}

    //Waits for the condition to happen
    level flag::wait_till("start_channeling_stone_step");

    //Saves the time it took
    last_tick = level.ticks;

    //Calculates the time it took
    total_ticks = last_tick - level.first_tick;
    //Deletes the timer and shows the exact time it took to complete the split
	level.keeper_start thread calculate_split(total_ticks);
 
}

function boss_fight_ready(){

    //Creates the timer for the split
    if(!isdefined(level.boss_fight_ready)){

		level.boss_fight_ready = newHudElem();
		level.boss_fight_ready init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^3boss_fight_ready: ");

		level.boss_fight_ready setTimerUp(0);
		//level.boss_fight_ready.alpha = 1;
		first_tick = level.ticks;

		level.height = level.height+15;

	}

    //Waits for the condition to happen
    level flag::wait_till("boss_fight_ready");

    //Saves the time it took
    last_tick = level.ticks;

    //Calculates the time it took
    total_ticks = last_tick - level.first_tick;
    //Deletes the timer and shows the exact time it took to complete the split
	level.boss_fight_ready thread calculate_split(total_ticks);
 
}

function ee_completed(){

    //Creates the timer for the split
    if(!isdefined(level.ee_completed)){

		level.ee_completed = newHudElem();
		level.ee_completed init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^3ee_completed: ");

		level.ee_completed setTimerUp(0);
		//level.ee_completed.alpha = 1;
		first_tick = level.ticks;

		level.height = level.height+15;

	}

    //Waits for the condition to happen
    level flag::wait_till("ee_outro");

    //Saves the time it took
    last_tick = level.ticks;

    //Calculates the time it took
    total_ticks = last_tick - level.first_tick;
    //Deletes the timer and shows the exact time it took to complete the split
	level.ee_completed thread calculate_split(total_ticks);
 
}


function check_bow_upgraded(){

    if( level flag::get("rune_prison_upgraded") ) return true;
    if( level flag::get("wolf_howl_upgraded") ) return true;
    if( level flag::get("demon_gate_upgraded") ) return true;
    if( level flag::get("elemental_storm_upgraded") ) return true;
    
    return false;
}

function Plunger(){

    level flag::wait_till("ee_power_clocktower");

    level.var_9f94326b.m_mdl_switch waittill("trigger_activated");

    //Creates the timer for the split
    if(!isdefined(level.Plunger)){

		level.Plunger = newHudElem();
		level.Plunger init_hudelem("left", "top", "user_left", "user_top", 120, 40, 1.5, 0, (1,1,1), 1, &"^3Plunger: ");

        level.Plunger.alpha = 1;
        level.Plunger inf_timer();
        level.Plunger.alpha = 0;

        //level flag::wait_till("ee_power_wallrun_teleport");
        
        wait 0.05;
        level.Plunger delete();

	}

}


function inf_timer(){
    self endon("end plunger timer");

    self SetTimer(200);
    wait 200;

}