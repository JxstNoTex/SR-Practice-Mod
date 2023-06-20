function debug_hud()
{
	level endon("end_game");
	self endon("disconnect");

    //Waits for the match to begin
    level flag::wait_till("start_zombie_round_logic");
	wait 5.5;

	/*if(!isdefined(self.detoured_registers)){

		self.detoured_registers = newClientHudElem(self);
		self.detoured_registers init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^6Det Reg number: ^5");

        level.height = level.height+15;
		self.detoured_registers.alpha = 1;

        self thread detoured_registers_counter();
	}

    if(!isdefined(self.detoured_name)){

		self.detoured_name = newClientHudElem(self);
		self.detoured_name init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^6Det Reg name: ^5");

        level.height = level.height+15;
		self.detoured_name.alpha = 1;

        self thread detoured_registers_name();
	}*/


    if(!isdefined(self.lazy_detoured_registers)){

		self.lazy_detoured_registers = newClientHudElem(self);
		self.lazy_detoured_registers init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^6Lazy Det Reg number: ^5");

        level.height = level.height+15;
		self.lazy_detoured_registers.alpha = 1;

        self thread lazy_detoured_registers_counter();
	}

    if(!isdefined(self.lazy_detoured_name)){

		self.lazy_detoured_name = newClientHudElem(self);
		self.lazy_detoured_name init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^6Lazy Det Reg name: ^5");

        level.height = level.height+15;
		self.lazy_detoured_name.alpha = 1;

        //self thread lazy_detoured_registers_name();
	}

    /*if(!isdefined(self.zombie_string)){

		self.zombie_string = newClientHudElem(self);
		self.zombie_string init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^6Spawn string: ^5");

        level.height = level.height+15;
		self.zombie_string.alpha = 1;

	}

    if(!isdefined(self.zombie_index)){

		self.zombie_index = newClientHudElem(self);
		self.zombie_index init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^6Spawn Index: ^5");

        level.height = level.height+15;
		self.zombie_index.alpha = 1;

        self thread debug_zombie_spawns();

	}*/

    if(!isdefined(self.respawners)){

		self.respawners = newClientHudElem(self);
		self.respawners init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^6Respawners availables: ^5");

        level.height = level.height+15;
		self.respawners.alpha = 1;

        self thread respawners_availables();

	}



    level thread zombie_alive_hud();
    level thread zombie_spawn_hud();
    level thread zombie_respawn_hud();

}


function detoured_registers_counter(){

    level endon("end_game");
	self endon("disconnect");

    self.detoured_registers setValue( (level.detoured_strings.size -1) );
    self.det_reg = level.detoured_strings.size -1;

    while(true){
        wait level.tick;

        if(self attackButtonPressed() && self useButtonPressed()){
            self.det_reg++;
            if(self.det_reg >= level.detoured_strings.size) self.det_reg = 0;
            wait 0.2;
        }

        if(self adsButtonPressed() && self useButtonPressed()){
            self.det_reg--;
            if(self.det_reg < 0) self.det_reg = level.detoured_strings.size -1;
            wait 0.2;
        }       

        self.detoured_registers setValue( self.det_reg );
    }
}

function detoured_registers_name(){

    level endon("end_game");
	self endon("disconnect");

    while(true){
        wait level.tick;
        self.detoured_name setText(level.detoured_strings[self.det_reg]);
    }
}



function lazy_detoured_registers_counter(){

    level endon("end_game");
	self endon("disconnect");

    self.lazy_detoured_registers setValue( (level.detour_functions.size -1) );
    self.lazy_det_reg = level.detour_functions.size -1;

    while(true){
        wait level.tick;

        if(self attackButtonPressed() && self JumpButtonPressed()){
            self.lazy_det_reg++;
            if(self.lazy_det_reg >= level.detour_functions.size) self.lazy_det_reg = 0;
            self change_lazy_det_regist_name();
            wait 0.2;
        }

        if(self adsButtonPressed() && self JumpButtonPressed()){
            self.lazy_det_reg--;
            if(self.lazy_det_reg < 0) self.lazy_det_reg = level.detour_functions.size -1;
            self change_lazy_det_regist_name();
            wait 0.2;
        }       

        self.lazy_detoured_registers setValue( self.lazy_det_reg );
    }
}

function change_lazy_det_regist_name(){

    counter = 0;
    foreach(name, det in level.detour_functions){
        if(counter == self.lazy_det_reg){
            self.lazy_detoured_name setText(name);
            break;
        }
        counter++;
    }

}


function debug_zombie_spawns(){

    //self iPrintLnBold("Getting Zombie spawns...");

    level.strings = [];

    foreach(string, zone in level.zones){
        //level thread debug_message(zone);// este no va
        //level thread debug_message(string);// nombre de la zona
        //level thread debug_message("volumes "+level.zones[string].volumes.size); //para ver cuantos volumenes hay
        // Un solo volumen ya tiene la info de los respawns de todos, no hace falta ir uno por uno
        if(level.zones[string].volumes.size!=0){
            foreach(type, loc in level.zones[string].a_loc_types){
                //level thread debug_message("target "+level.zones[string].volumes[0].target);
                //level thread debug_message("type "+type+" size "+level.zones[string].a_loc_types[type].size);//el type de spawn "zombie_location" "dog_location"
                if(type != "zombie_location")continue; // I only get zombie spawns
                foreach(spot in level.zones[string].a_loc_types[type]){

                    if(!IsInArray(level.strings, spot.script_string)) ArrayInsert(level.strings, spot.script_string, level.strings.size);
                    else continue;
                    /*types are 
        	            case "custom_spawner_entry":
			            case "faller_location":
			            case "riser_location":
			            case "spawn_location":
			            case "spawner_location":
                    */
                    /*level thread debug_message(spot.script_string+" string");  si tiene
                        //level thread debug_message(spot.script_noteworthy); // no tiene
                        //level thread debug_message(spot.script_float+" float"); // no tiene
                        level thread debug_message(spot.str_tag+" tag"); // no tiene
                    */
                }
            }
        }
    }

    //self iPrintLnBold("Zombie Spawns Ready!");

    self thread get_specific_zombie_spawn();
}

function get_specific_zombie_spawn(){

    self.string = 0;
    self.spawn = 0;

    self.zm_array = [];

    while(true){
        wait 0.05;

        if(self useButtonPressed()){
            if(self attackButtonPressed()){
                self.string++;
                if(self.string >= level.strings.size) self.string = 0;
                self iPrintLnBold("string selected "+level.strings[self.string]);
                self.zombie_string setText(level.strings[self.string]);
                wait 0.2;
            }else if(self adsButtonPressed()){
                self.string--;
                if(self.string < 0) self.string = level.strings.size-1;
                self iPrintLnBold("string selected "+level.strings[self.string]);
                self.zombie_string setText(level.strings[self.string]);
                wait 0.2;
            }else if(self meleeButtonPressed()){
                self.zm_array = [];
                foreach(string, zone in level.zones){
                    if(level.zones[string].volumes.size!=0){
                        foreach(type, loc in level.zones[string].a_loc_types){
                            foreach(spot in level.zones[string].a_loc_types[type]){
                                if(spot.script_string == level.strings[self.string]){
                                    ArrayInsert(self.zm_array, spot, self.zm_array.size);
                                    self iPrintLnBold("Found "+spot.script_string+" in "+string);
                                    wait 0.2;
                                } 
                            }
                        }
                    }
                }
                self iPrintLnBold(self.zm_array.size+" Spawns copied");
                self.spawn = 0;
                self.zombie_index setValue(self.spawn);
                wait 0.2;
            }
        }

        if(self JumpButtonPressed()){
            if(self.zm_array.size<1) continue;

            if(self attackButtonPressed()){
                self.spawn++;
                if(self.spawn >= self.zm_array.size) self.spawn = 0;
                self iPrintLnBold("spawn index "+self.spawn);
                self.zombie_index setValue(self.spawn);
                wait 0.2;
            }else if(self adsButtonPressed()){
                self.spawn--;
                if(self.spawn <0) self.spawn = self.zm_array.size-1;
                self iPrintLnBold("spawn index "+self.spawn);
                self.zombie_index setValue(self.spawn);
                wait 0.2;
            }else if(self meleeButtonPressed()){
                self setOrigin(self.zm_array[self.spawn].origin);
                self iPrintLnBold("Teleported to zombie spawn");
                wait 0.2;
            }
        }
        
    }

    self iPrintLnBold("Custom spawns ended");

}


function n_zombie_spawn_hud(){

	if(!isdefined(level.n_zombie_spawn_hud)){

		level.n_zombie_spawn_hud = newHudElem();
		level.n_zombie_spawn_hud init_hudelem("right", "top", "user_right", "user_top", -50, 95, 1.5, 0, (1,1,1), 1, &"^6Spawn points: ^5");
    	level flag::wait_till("start_zombie_round_logic");
		wait 2.5;

		level.n_zombie_spawn_hud.alpha = 1;

		while(true){
			wait level.tick;

			level.n_zombie_spawn_hud setvalue(level.zm_loc_types["zombie_location"].size);
		}

	}

}

function respawners_availables(){

    while(true){
        wait 0.05;


        a_spots = level.zm_loc_types["zombie_location"];
		e_player = level.players[0];
		arraysortclosest(a_spots, e_player.origin);
		a_candidates = [];
		v_player_dir = anglestoforward(e_player.angles);
		for(i = 0; i < a_spots.size; i++)
		{
			v_dir = a_spots[i].origin - e_player.origin;
			dp = vectordot(v_player_dir, v_dir);
			if(dp >= 0)
			{
				a_candidates[a_candidates.size] = a_spots[i];
			}
		}

        if(self JumpButtonPressed() && IsInArray(a_candidates, level.outside_south_spawn[0]) && IsInArray(a_candidates, level.outside_east_a[0])) self iPrintLnBold("Ambos spawns");

        self.respawners setValue(a_candidates.size);
    }

}