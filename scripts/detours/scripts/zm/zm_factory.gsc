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