detour zm_factory<scripts\zm\zm_factory.gsc>::function_e0f73644() //This is the function to choose between stamina and daikiry
{

	if(!isDefined(level.detour_functions["zm_factory::function_384be1c4"])) level.detour_functions["zm_factory::function_384be1c4"] = @zm_factory<scripts\zm\zm_factory.gsc>::function_384be1c4;
	if(!isDefined(level.detour_functions["zm_factory::function_49e223a9"])) level.detour_functions["zm_factory::function_49e223a9"] = @zm_factory<scripts\zm\zm_factory.gsc>::function_49e223a9;
	if(!isDefined(level.detour_functions["zm_factory::function_16d38a15"])) level.detour_functions["zm_factory::function_16d38a15"] = @zm_factory<scripts\zm\zm_factory.gsc>::function_16d38a15;
	if(!isDefined(level.detour_functions["zm_factory::function_6000324c"])) level.detour_functions["zm_factory::function_6000324c"] = @zm_factory<scripts\zm\zm_factory.gsc>::function_6000324c;


	//function_384be1c4 Removes Stam
	//function_49e223a9 Adds Daikiry

	//function_16d38a15 removes Daikiry
	//function_6000324c Adds Stam


	if(world.practice){

		level._custom_perks["specialty_deadshot"].perk_machine_power_override_thread = level.detour_functions["zm_factory::function_16d38a15"];
		level._custom_perks["specialty_staminup"].perk_machine_power_override_thread = level.detour_functions["zm_factory::function_6000324c"];

		if(level.debug){
			level flag::wait_till("start_zombie_round_logic");
			level.players[0] iPrintLnBold("Random 5th perk set to Stamina");
		}

	}else{
		if(math::cointoss())
		{
			level._custom_perks["specialty_staminup"].perk_machine_power_override_thread = level.detour_functions["zm_factory::function_384be1c4"];
			level._custom_perks["specialty_deadshot"].perk_machine_power_override_thread = level.detour_functions["zm_factory::function_49e223a9"];

			if(level.debug){
				level flag::wait_till("start_zombie_round_logic");
				level.players[0] iPrintLnBold("You got Daikiry");
			}
		}
		else
		{
			level._custom_perks["specialty_deadshot"].perk_machine_power_override_thread = level.detour_functions["zm_factory::function_16d38a15"];
			level._custom_perks["specialty_staminup"].perk_machine_power_override_thread = level.detour_functions["zm_factory::function_6000324c"];

			if(level.debug){
				level flag::wait_till("start_zombie_round_logic");
				level.players[0] iPrintLnBold("You got Stamina");
			}
		}
	}
}






//This can be changed wtih 

/*detour zm_factory<scripts\zm\zm_factory.gsc>::powerup_special_drop_override()
{
    if(!isDefined(level.detour_functions["zm_powerups::get_valid_powerup"])) level.detour_functions["zm_powerups::get_valid_powerup"] = @zm_powerups<scripts\zm\_zm_powerups.gsc>::get_valid_powerup;
    if(!isDefined(level.detour_functions["zm_utility::play_sound_2d"])) level.detour_functions["zm_utility::play_sound_2d"] = @zm_utility<scripts\zm\_zm_utility.gsc>::play_sound_2d;
    if(!isDefined(level.detour_functions["zombie_utility::get_round_enemy_array"])) level.detour_functions["zombie_utility::get_round_enemy_array"] = @zombie_utility<scripts\shared\ai\zombie_utility.gsc>::get_round_enemy_array;




	if(level.round_number <= 10)
	{
        powerup = level [[ level.detour_functions["zm_powerups::get_valid_powerup"] ]]();
		//powerup = zm_powerups::get_valid_powerup();

		#region patch
        if(world.practice){
            if(IsInArray(level.zombie_powerup_array, "insta_kill") && level.zombie_total){
                powerup = "insta_kill";
                if(level.debug)level.players[0] iPrintLnBold("Drop set to "+powerup+" with "+level.zombie_total+" zombies to respawn");
            }else if(IsInArray(level.zombie_powerup_array, "nuke") && !level.zombie_total){
                powerup = "nuke";
                if(level.debug)level.players[0] iPrintLnBold("Drop set to "+powerup+" with "+[[level.detour_functions["zombie_utility::get_round_enemy_array"]]]().size+" zombies alive");
            }
        }
		#endregion

	}
	else
	{
		powerup = level.zombie_special_drop_array[randomint(level.zombie_special_drop_array.size)];
		if(level.round_number > 15 && randomint(100) < ((level.round_number - 15) * 5)) // 16 = 95% | 17 = 90%....| 31 = 0%
		{
			powerup = "nothing";
		}
	}
	switch(powerup)
	{
		case "full_ammo":
		{
			if(level.round_number > 10 && randomint(100) < ((level.round_number - 10) * 5))
			{
				powerup = level.zombie_powerup_array[randomint(level.zombie_powerup_array.size)];
			}
            if(IsInArray(level.zombie_powerup_array, "free_perk")){
                powerup = "free_perk";
                level.players[0] iPrintLnBold("There is a chance to get a perk");
            }

            if(level.debug)if(powerup != "free_perk") level.players[0] iPrintLnBold(powerup+" Changing from ammo to perk");
			break;
		}
		case "dog":
		{
			if(level.round_number >= 15)
			{
				dog_spawners = getentarray("special_dog_spawner", "targetname");
                thread [[ level.detour_functions["zm_utility::play_sound_2d"] ]]("vox_sam_nospawn");
				//thread zm_utility::play_sound_2d("vox_sam_nospawn");
				powerup = undefined;
			}
			else
			{
                powerup = [[ level.detour_functions["zm_powerups::get_valid_powerup"] ]]();
				//powerup = zm_powerups::get_valid_powerup();
			}
			break;
		}
		case "free_perk":
		case "nothing":
		{
            level.players[0] iPrintLnBold(powerup+" There is nothing or there was a perk");
			if(isdefined(level._zombiemode_special_drop_setup))
			{
				is_powerup = [[level._zombiemode_special_drop_setup]](powerup);
			}
			else
			{
				playfx(level._effect["lightning_dog_spawn"], self.origin);
				playsoundatposition("zmb_hellhound_prespawn", self.origin);
				wait(1.5);
				playsoundatposition("zmb_hellhound_bolt", self.origin);
				earthquake(0.5, 0.75, self.origin, 1000);
				playsoundatposition("zmb_hellhound_spawn", self.origin);
				wait(1);
				thread [[ level.detour_functions["zm_utility::play_sound_2d"] ]]("vox_sam_nospawn");
				self delete();
			}
			powerup = undefined;
			break;
		}
	}

    if(level.debug){
        if(isdefined(powerup))level.players[0] iPrintLnBold(powerup+" is the final powerup");
        else level.players[0] iPrintLnBold("undefined");
    }

	return powerup;
}*/



/* Extra info
    zm_powerups::get_valid_powerup takes a power from "level.zombie_powerup_array"
    //level.zombie_special_drop_array
*/