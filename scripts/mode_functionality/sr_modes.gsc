function create_sr_modes(){

    world.modes = [];

    ArrayInsert(world.modes, "rounds", world.modes.size); //Rounds SR and High Rounds
    ArrayInsert(world.modes, "easter_eggs", world.modes.size); // Easter Egg SR
    ArrayInsert(world.modes, "community", world.modes.size); // Song SR and PaP SR

    world.sr_mode = world.modes[0];

    world.practice = false;

}

function change_sr_mode(){

    level.black_screen = false;
    level.voted = false;
    level.changed_mode = false;
    level.changed_practice = false;
    level thread check_blackscreen();

    level waittill( "all_players_connected" );

    array::thread_all(level.players, ::mode_watcher);
    array::thread_all(level.players, ::practice_watcher);

    while(!level.black_screen) wait level.tick;

    if(level.voted){
        if(level.changed_mode){
            index = 0;
            for(i=0; i<world.modes.size;i++){
                if(world.modes[i]==world.sr_mode){
                    index = i;
                    break;
                }
            }

            index++;
            if(index >= world.modes.size) index = 0;
                world.sr_mode = world.modes[index];
        }

        if(level.changed_practice){
            if(world.practice) world.practice = false;
            else world.practice = true;
        }

        
        if(level.changed_mode){
            if(level.changed_practice){
                if(world.practice)text ="Now practicing "+world.sr_mode;
                else text ="Playing without practice "+world.sr_mode;
            }
            else text ="The mode has been changed to "+world.sr_mode;
        }else{
            if(world.practice) text ="Practice mode activated!";
            else text ="Practice mode is over...";
        }

        foreach(player in level.players) player iPrintLnBold(text);
        wait 1;
        map_restart();
    }

}

function mode_watcher(){

    while(!level.black_screen && !level.changed_mode){
        wait level.tick;
        if(self meleeButtonPressed()){
            level.changed_mode = true;
            level.voted = true;
            break;
        }
    }
}

function practice_watcher(){

    while(!level.black_screen && !level.changed_mode){
        wait level.tick;
        if(self fragButtonPressed()){
            level.changed_practice = true;
            level.voted = true;
            break;
        }
    }
}

function check_blackscreen(){

    level flag::wait_till("start_zombie_round_logic");
	wait 2.5;

    level.black_screen = true;
}

function debug_message(text){

    while(!level.black_screen) wait GAMETICK;
    wait 4;

    level.players[0] iPrintLnBold(text);

}