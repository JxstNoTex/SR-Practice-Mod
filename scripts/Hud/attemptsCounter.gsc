function attempt_counter(){

    level flag::wait_till("start_zombie_round_logic");
    wait 2.5;

    /*if(!isDefined(world.attempts)){
        world.attempts = 1;
        //level thread debug_message("No hay intentos registrados");
    }else{
        world.attempts++;
        //level thread debug_message("Hay "+world.attempts);
    }*/

    if(!isdefined(world.attempts)){
        world.attempts = [];
        //level thread debug_message("No hay array de mapas");
    }else{
        //level thread debug_message("Si hay array");
    }

    if(!isdefined(world.attempts[level.script])){
        world.attempts[level.script] = [];
        //level thread debug_message("No esta registrado el mapa");
    }else{
        //level thread debug_message("El mapa ya esta registrado");
    }

    if(!isdefined(world.attempts[level.script][level.players.size])){
        world.attempts[level.script][level.players.size] = 1;
        //level thread debug_message("No hay intentos jugados");
    }else{
        //level thread debug_message("Ya se ha jugado");
        world.attempts[level.script][level.players.size]++;
    }

    /*if(!isDefined(world.attempts.level.script.level.players.size)){
        world.attempts.level.script.level.players.size = 1;
        level thread debug_message("No hay intentos registrados");
    }else{
        world.attempts.level.script.level.players.size++;
        level thread debug_message("Hay "+world.attempts.level.script.level.players.size);
    }*/


    if(!isdefined(level.attempts)){

        //level thread debug_message("No hay intentos registrados");

	    level.attempts = newHudElem();
        //tam inicial 1.5
        level.attempts init_hudelem("left", "top", "user_left", "user_top", /*Coordenadas*/350, 150, /*tam*/7, 0, (1,1,1), 1, &"Attempts: ");

        if(world.attempts[level.script][level.players.size] == 1){
            level.attempts.label = &"Attempt: ";
        }else{
            level.attempts.label = &"Attempts: ";
        }

        if(world.attempts[level.script][level.players.size] == 7){
            level.attempts setText("SIUUUUU");
        }else if(world.attempts[level.script][level.players.size] == 10){
            level.attempts setText("ANKARA MESSI");
        }else{
            level.attempts setValue(world.attempts[level.script][level.players.size]);
        }

        level.attempts FadeOverTime(2);
        level.attempts.alpha = 1;

        level thread animation();

    }

}


function animation(){

    //while(true){


        // Posicion inicial X,Y (400,0)
        // Posicion final X,Y ()

        wait 2;

        level.attempts moveOverTime(2.7);
        level.attempts.x = 10;
        level.attempts.y = 0;       

        level.attempts changeFontScaleOverTime(2.7);
        level.attempts.fontscale = 1.5;

        //level.attempts fadeOverTime(5);
        //level.attempts.alpha = 0;

        //wait 5;

    //}

}