function custom_perk_locations(){

    if(level.script == "zm_factory"){

        level delete_giant_perk_models();
        level factory_perk_location();
        [[level.custom_vending_precaching]]();
        level perk_machine_functionality(); 

        vending_triggers = getentarray("zombie_vending", "targetname");
        array::thread_all(vending_triggers, zm_perks::vending_trigger_think);
	    array::thread_all(vending_triggers, zm_perks::electric_perks_dialog);

        level thread activate_giant_perks_on_power();
        
    }else{
        if(level.is_megas){
            level zod_megas_perk_location();
        }else{
            level zod_classics_perk_location();
        }
    }

}

#region Factory

function delete_giant_perk_models(){

	perk_array = ["specialty_armorvest","specialty_quickrevive","specialty_fastreload","specialty_additionalprimaryweapon","specialty_doubletap2"];

	for(i=0; i<perk_array.size; i++){

		zm_perks::perk_machine_removal(perk_array[i]);

	}

    level notify("specialty_fastreload_power_thread_end");
    level notify("specialty_additionalprimaryweapon_power_thread_end");
    level notify("specialty_quickrevive_power_thread_end");
    level notify("specialty_doubletap2_power_thread_end");
    level notify("specialty_armorvest_power_thread_end");

}

function factory_perk_location(){

    random_perk_loc = struct::get_array("perk_random_machine_location", "targetname");
    /* The Giant
        1st = power perk
        2nd = thomson room
        3rd = 1 window room
        4th = waw jugg loc
        5th = waw speed loc
    */
    power_loc = random_perk_loc[0];
    thomson_loc = random_perk_loc[1];
    window_loc = random_perk_loc[2];
    waw_jugg_loc = random_perk_loc[3];
    waw_speed_loc = random_perk_loc[4];

    patched_order = [];
    ArrayInsert(patched_order, window_loc, patched_order.size);
    ArrayInsert(patched_order, waw_jugg_loc, patched_order.size);
    ArrayInsert(patched_order, waw_speed_loc, patched_order.size);
    ArrayInsert(patched_order, thomson_loc, patched_order.size);
    ArrayInsert(patched_order, power_loc, patched_order.size);

    //My order is: 1wind, waw_jugg, waw_speed, thomson, power


    perk_machines = struct::get_array("zm_perk_machine", "targetname");
    /* The Giant
        1s = Quick Revive
        2nd = Double Tap
        3rd = Jugg
        4th = Speed
        5th = Mule
	    6th = Stam
	    7th = Daikiry
    */
    quick_machine = perk_machines[0];
    doubletap_machine = perk_machines[1];
    jugg_machine = perk_machines[2];
    speed_machine = perk_machines[3];
    mule_machine = perk_machines[4];

    patched_machines = [];

    if(world.sr_mode == "easter_eggs"){
        ArrayInsert(patched_machines, quick_machine, patched_machines.size);
        ArrayInsert(patched_machines, doubletap_machine, patched_machines.size);
        ArrayInsert(patched_machines, speed_machine, patched_machines.size);
        ArrayInsert(patched_machines, mule_machine, patched_machines.size);
        ArrayInsert(patched_machines, jugg_machine, patched_machines.size);
        if(level.debug_perks_location) level thread debug_message(level.script+" "+world.sr_mode);
    }else{
        ArrayInsert(patched_machines, doubletap_machine, patched_machines.size);
        ArrayInsert(patched_machines, speed_machine, patched_machines.size);
        ArrayInsert(patched_machines, jugg_machine, patched_machines.size);
        ArrayInsert(patched_machines, mule_machine, patched_machines.size);
        ArrayInsert(patched_machines, quick_machine, patched_machines.size);
        if(level.debug_perks_location) level thread debug_message(level.script+" "+world.sr_mode);
    }



	match_string = "";
	location = level.scr_zm_map_start_location;
	if(location == "default" || location == "" && isdefined(level.default_start_location))
	{
		location = level.default_start_location;
	}
	match_string = (level.scr_zm_ui_gametype + "_perks_") + location;

	//perk_machines = struct::get_array("zm_perk_machine", "targetname");
    /* The Giant
        1s = Quick Revive
        2nd = Double Tap
        3rd = Jugg
        4th = Speed
        5th = Mule
		6th = Stam
		7th = Daikiry
    */


    perk_locations = [];

	foreach( machine in patched_machines)
	{
		if(isdefined(machine.script_string))
		{
			tokens = strtok(machine.script_string, " ");
			foreach(token in tokens)
			{
				if(token == match_string)
				{
					perk_locations[perk_locations.size] = machine;
				}
			}
			continue;
		}
		perk_locations[perk_locations.size] = machine;
	}
	if(perk_locations.size == 0)
	{
		return;
	}
	if(isdefined(level.randomize_perk_machine_location) && level.randomize_perk_machine_location)
	{
		//random_perk_loc = struct::get_array("perk_random_machine_location", "targetname");
        /* The Giant
            1st = power perk
            2nd = thomson room
            3rd = 1 window room
            4th = waw jugg loc
            5th = waw speed loc
        */
		/*if(random_perk_loc.size > 0)
		{
			random_perk_loc = array::randomize(random_perk_loc);
		}*/
		n_random_perks_assigned = 0;
	}


	foreach(locations in perk_locations)
	{
		perk = locations.script_noteworthy;
		if(isdefined(perk) && isdefined(locations.model))
		{
			if(isdefined(level.randomize_perk_machine_location) && level.randomize_perk_machine_location && patched_order.size > 0 && isdefined(locations.script_notify))
			{
				s_new_loc = patched_order[n_random_perks_assigned];
				locations.origin = s_new_loc.origin;
				locations.angles = s_new_loc.angles;
				if(isdefined(s_new_loc.script_int))
				{
					locations.script_int = s_new_loc.script_int;
				}
				if(isdefined(s_new_loc.target))
				{
					s_tell_location = struct::get(s_new_loc.target);
					if(isdefined(s_tell_location))
					{
						util::spawn_model("p7_zm_perk_bottle_broken_" + perk, s_tell_location.origin, s_tell_location.angles);
					}
				}
				n_random_perks_assigned++;
			}
			t_use = spawn("trigger_radius_use", locations.origin + vectorscale((0, 0, 1), 60), 0, 40, 80);
			t_use.targetname = "zombie_vending";
			t_use.script_noteworthy = perk;
			if(isdefined(locations.script_int))
			{
				t_use.script_int = locations.script_int;
			}
			t_use triggerignoreteam();
			perk_machine = spawn("script_model", locations.origin);
			if(!isdefined(locations.angles))
			{
				locations.angles = (0, 0, 0);
			}
			perk_machine.angles = locations.angles;
			perk_machine setmodel(locations.model);
			if(isdefined(level._no_vending_machine_bump_trigs) && level._no_vending_machine_bump_trigs)
			{
				bump_trigger = undefined;
			}
			else
			{
				bump_trigger = spawn("trigger_radius", locations.origin + vectorscale((0, 0, 1), 20), 0, 40, 80);
				bump_trigger.script_activated = 1;
				bump_trigger.script_sound = "zmb_perks_bump_bottle";
				bump_trigger.targetname = "audio_bump_trigger";
			}
			if(isdefined(level._no_vending_machine_auto_collision) && level._no_vending_machine_auto_collision)
			{
				collision = undefined;
			}
			else
			{
				collision = spawn("script_model", locations.origin, 1);
				collision.angles = locations.angles;
				collision setmodel("zm_collision_perks1");
				collision.script_noteworthy = "clip";
				collision disconnectpaths();
			}
			t_use.clip = collision;
			t_use.machine = perk_machine;
			t_use.bump = bump_trigger;
			if(isdefined(locations.script_notify))
			{
				perk_machine.script_notify = locations.script_notify;
			}
			if(isdefined(locations.target))
			{
				perk_machine.target = locations.target;
			}
			if(isdefined(locations.blocker_model))
			{
				t_use.blocker_model = locations.blocker_model;
			}
			if(isdefined(locations.script_int))
			{
				perk_machine.script_int = locations.script_int;
			}
			if(isdefined(locations.turn_on_notify))
			{
				perk_machine.turn_on_notify = locations.turn_on_notify;
			}



			if(isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].perk_machine_set_kvps))
			{
				[[level._custom_perks[perk].perk_machine_set_kvps]](t_use, perk_machine, bump_trigger, collision);
			}
		}
	}

}

function perk_machine_functionality(){

	if(level._custom_perks.size > 0)
	{
		//perk_array = ["specialty_armorvest","specialty_quickrevive","specialty_fastreload","specialty_additionalprimaryweapon","specialty_doubletap2"];
		a_keys = getarraykeys(level._custom_perks);

		for(i = 0; i < a_keys.size; i++)
		{
			/*if( !IsInArray(perk_array, a_keys[i]) ){
				level.players[0] iPrintLnBold("No esta "+a_keys[i]+" "+i);
				level thread zm_perks::perk_machine_think(a_keys[i], level._custom_perks[a_keys[i]]);
				
				continue;
			}else{
				level thread zm_perks::perk_machine_think(a_keys[i], level._custom_perks[a_keys[i]]);
			}
			level.players[0] iPrintLnBold(a_keys[i]+" "+i);*/


			
			if(isdefined(level._custom_perks[a_keys[i]].perk_machine_thread))
			{
				level thread [[level._custom_perks[a_keys[i]].perk_machine_thread]]();
			}
			if(isdefined(level._custom_perks[a_keys[i]].perk_machine_power_override_thread))
			{
				level thread [[level._custom_perks[a_keys[i]].perk_machine_power_override_thread]]();
				continue;
			}
			if(isdefined(level._custom_perks[a_keys[i]].alias) && isdefined(level._custom_perks[a_keys[i]].radiant_machine_name) && isdefined(level._custom_perks[a_keys[i]].machine_light_effect))
			{
				level thread zm_perks::perk_machine_think(a_keys[i], level._custom_perks[a_keys[i]]);
			}

			//wait 2;
		}


	}

}

function activate_giant_perks_on_power(){

    level flag::wait_till("power_on");

    level notify("sleight_on");
    level notify("additionalprimaryweapon_on");
    level notify("additionalprimaryweapon_power_on");
    level notify("revive_on");
    level notify("doubletap_on");
    level notify("juggernog_on");

}

#endregion

#region ZoD

function zod_megas_perk_location(){

}

function zod_classics_perk_location(){

}

#endregion