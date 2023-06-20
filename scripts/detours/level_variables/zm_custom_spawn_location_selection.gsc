/*level.zm_custom_spawn_location_selection

    its used on:
    "zm_zod" level.zm_custom_spawn_location_selection = &function_2c092767;
    "zm_factory" level.zm_custom_spawn_location_selection = &factory_custom_spawn_location_selection;
    "zm_castle" level.zm_custom_spawn_location_selection = &function_c624f0b2;
    "zm_stalingrad" level.zm_custom_spawn_location_selection = &function_ff18dfdd;
    "zm_genesis" level.zm_custom_spawn_location_selection = &genesis_custom_spawn_location_selection;

    it changes the function "do_zombie_spawn()" of "zm_spawner" andif its not defined then its "spot = array::random(spots);"
*/

function zm_custom_spawn_location_selection(){

    if(!isDefined(level.detour_functions["zm::get_zombie_count_for_round"])) level.detour_functions["zm::get_zombie_count_for_round"] = @zm<scripts\zm\_zm.gsc>::get_zombie_count_for_round;

    switch(level.script){

        case "zm_zod":

        break;

        case "zm_factory":
            level zombie_factory_spawns();
            while(!isDefined(level.zm_custom_spawn_location_selection)) wait GAMETICK;
            if(!isdefined(level.n_player_spawn_selection_index)) level.n_player_spawn_selection_index = 0;
            level.zm_custom_spawn_location_selection = ::factory_zm_custom_spawn_location_selection;
        break;

        case "zm_castle":

        break;
        
        case "zm_island":

        break;
                
        case "zm_stalingrad":

        break;

        case "zm_genesis":

        break;

        case "zm_prototype":

        break;

        case "zm_asylum":

        break;

        case "zm_sumpf":

        break;

        case "zm_theatre":

        break;

        case "zm_cosmodrome":

        break;

        case "zm_temple":

        break;

        case "zm_moon":

        break;

        case "zm_tomb":

        break;
                                                                                               
    }

}

function zombie_spawn_search(script_string){

    wanted_spawns = [];
    wanted_spawns.zone = undefined;

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

                    if(spot.script_string == script_string){
                        if(level.debug)level thread debug_message(script_string+" found on "+string);
                        spot.zone = string;
                        ArrayInsert(wanted_spawns, spot, wanted_spawns.size);
                        if(!isDefined(wanted_spawns.zone)) wanted_spawns.zone = string;
                    }

                    //if(!IsInArray(level.strings, spot.script_string)) ArrayInsert(level.strings, spot.script_string, level.strings.size);
                    //else continue;
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

    if(level.debug) level thread debug_message(wanted_spawns.size);

    if(wanted_spawns.size>0) return wanted_spawns;
    else level thread debug_message("Error, no spot found :(");

}


#region Zod

#endregion

#region Factory

function zombie_factory_spawns(){

    level flag::wait_till("zones_initialized");
    level.ee_spawn = zombie_spawn_search("receiver_set_entry_b");
    level.outside_east_a = zombie_spawn_search("receiver_set_outside_east_a");
    level.outside_south_spawn = zombie_spawn_search("receiver_set_outside_south");

}

function factory_zm_custom_spawn_location_selection(a_spots){

    /*if(level.debug){
        level thread debug_message("Total zombies "+level.zombie_total);
        level thread debug_message("Respawn zombies "+level.zombie_respawns);
    }*/


    // if there are respawners
    if(level.zombie_respawns > 0){

		level.n_player_spawn_selection_index++;
		if(level.n_player_spawn_selection_index >= level.players.size) level.n_player_spawn_selection_index = 0;

		e_player = level.players[level.n_player_spawn_selection_index];
		arraysortclosest(a_spots, e_player.origin);
		a_candidates = [];
		v_player_dir = anglestoforward(e_player.angles);
		for(i = 0; i < a_spots.size; i++){
			v_dir = a_spots[i].origin - e_player.origin;
			dp = vectordot(v_player_dir, v_dir);
			if(dp >= 0){
			    a_candidates[a_candidates.size] = a_spots[i];
			    if(a_candidates.size > 10) break;
			}
		}

		if(a_candidates.size){

            #region Patch
    //In case practice mode is activated
    if(world.practice){
         //Sets the first 2 zombies to spawn on the right Pap window
        if(world.sr_mode == "easter_eggs" || world.sr_mode == "community"){
            if(level.round_number == 1 && level.zombie_total >= [[ level.detour_functions["zm::get_zombie_count_for_round"] ]](level.round_number, level.players.size) -2 && IsInArray(a_candidates, level.ee_spawn[0]) ){
                if(level.debug) level thread debug_message("Patching REspawn");
                patched_spawn = level.ee_spawn[randomInt(level.ee_spawn.size)];
                foreach(spot in a_candidates){
                    if(spot == patched_spawn){
                        if(level.debug) level thread debug_message("Spawn found!");
                        return spot;
                    }
                }
                level thread debug_message("Error, havent found the correct spawn");
            }
        }
        //Sets the zombies to further right pap window in case they can spawn outside east tp building
        else if(world.sr_mode == "rounds"){
            if( IsInArray(a_candidates, level.outside_east_a[0]) && IsInArray(a_candidates, level.outside_south_spawn[0]) ){
                if(level.debug) level thread debug_message("Patching REspawn");
                patched_spawn = level.outside_east_a[randomInt(level.outside_east_a.size)];
                foreach(spot in a_candidates){
                    if(spot == patched_spawn){
                        if(level.debug) level thread debug_message("Spawn found!");
                        return spot;
                    }
                }
                level thread debug_message("Error, havent found the correct spawn");
            }
        }
    }
    #endregion

            return array::random(a_candidates);
        }
		else{

            #region Patch
    //In case practice mode is activated
    if(world.practice){
         //Sets the first 2 zombies to spawn on the right Pap window
        if(world.sr_mode == "easter_eggs" || world.sr_mode == "community"){
            if(level.round_number == 1 && level.zombie_total >= [[ level.detour_functions["zm::get_zombie_count_for_round"] ]](level.round_number, level.players.size) -2 && IsInArray(a_candidates, level.ee_spawn[0]) ){
                if(level.debug) level thread debug_message("Patching REspawn");
                patched_spawn = level.ee_spawn[randomInt(level.ee_spawn.size)];
                foreach(spot in a_candidates){
                    if(spot == patched_spawn){
                        if(level.debug) level thread debug_message("Spawn found!");
                        return spot;
                    }
                }
                level thread debug_message("Error, havent found the correct spawn");
            }
        }
        //Sets the zombies to further right pap window in case they can spawn outside east tp building
        else if(world.sr_mode == "rounds"){
            if( IsInArray(a_candidates, level.outside_east_a[0]) && IsInArray(a_candidates, level.outside_south_spawn[0]) ){
                if(level.debug) level thread debug_message("Patching REspawn");
                patched_spawn = level.outside_east_a[randomInt(level.outside_east_a.size)];
                foreach(spot in a_candidates){
                    if(spot == patched_spawn){
                        if(level.debug) level thread debug_message("Spawn found!");
                        return spot;
                    }
                }
                level thread debug_message("Error, havent found the correct spawn");
            }
        }
    }
    #endregion
            
            return array::random(a_spots);
        }

    // if there are not respawning
	}else{
    
    #region Patch
    //In case practice mode is activated
    if(world.practice){
         //Sets the first 2 zombies to spawn on the right Pap window
        if(world.sr_mode == "easter_eggs" || world.sr_mode == "community"){
            if(level.round_number == 1 && level.zombie_total >= [[ level.detour_functions["zm::get_zombie_count_for_round"] ]](level.round_number, level.players.size) -2 && IsInArray(a_spots, level.ee_spawn[0]) ){
                if(level.debug) level thread debug_message("Patching Spawn");
                patched_spawn = level.ee_spawn[randomInt(level.ee_spawn.size)];
                foreach(spot in a_spots){
                    if(spot == patched_spawn){
                        if(level.debug) level thread debug_message("Spawn found!");
                        return spot;
                    }
                }
                level thread debug_message("Error, havent found the correct spawn");
            }
        }
        //Sets the zombies to further right pap window in case they can spawn outside east tp building
        else if(world.sr_mode == "rounds"){
            if( IsInArray(a_spots, level.outside_east_a[0]) && IsInArray(a_spots, level.outside_south_spawn[0]) ){
                if(level.debug) level thread debug_message("Patching Spawner");
                patched_spawn = level.outside_east_a[randomInt(level.outside_east_a.size)];
                foreach(spot in a_spots){
                    if(spot == patched_spawn){
                        if(level.debug) level thread debug_message("Spawn found!");
                        return spot;
                    }
                }
                level thread debug_message("Error, havent found the correct spawn");
            }
        }
    }
    #endregion

        return array::random(a_spots);
    }


}

#endregion

#region Castle

#endregion

#region Island

#endregion

#region Stalingrad

#endregion

#region Genesis

#endregion

#region Prototype

#endregion

#region Asylum

#endregion

#region Sumpf

#endregion

#region Theatre

#endregion

#region Cosmodrome

#endregion

#region Temple

#endregion

#region Tomb

#endregion