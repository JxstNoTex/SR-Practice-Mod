/*level.powerup_special_drop_override

    its used on:
    "zm_factory" level.powerup_special_drop_override = &powerup_special_drop_override;

    
    it changes the function "special_drop_setup()" of "zm_powerups" and if its not defined, the default function is get_valid_powerup();
    which has inside get_next_powerup()

    function get_next_powerup()
    {
	    powerup = level.zombie_powerup_array[level.zombie_powerup_index];
	    level.zombie_powerup_index++;
	    if(level.zombie_powerup_index >= level.zombie_powerup_array.size)
	    {
		    level.zombie_powerup_index = 0;
		    randomize_powerups();
	    }
	    return powerup;
    }

*/

function powerup_special_drop_override(){

    level flag::wait_till("start_zombie_round_logic");

    switch(level.script){
        case "zm_factory":
            level.powerup_special_drop_override = ::factory_custom_powerup_special_drop_override;
        break;

    }
}

#region Factory
function factory_custom_powerup_special_drop_override()
{

    if(!isDefined(level.detour_functions["zm_powerups::get_valid_powerup"])) level.detour_functions["zm_powerups::get_valid_powerup"] = @zm_powerups<scripts\zm\_zm_powerups.gsc>::get_valid_powerup;
    if(!isDefined(level.detour_functions["zm_utility::play_sound_2d"])) level.detour_functions["zm_utility::play_sound_2d"] = @zm_utility<scripts\zm\_zm_utility.gsc>::play_sound_2d;
    if(!isDefined(level.detour_functions["zombie_utility::get_round_enemy_array"])) level.detour_functions["zombie_utility::get_round_enemy_array"] = @zombie_utility<scripts\shared\ai\zombie_utility.gsc>::get_round_enemy_array;


	if(level.round_number <= 10)
	{
		powerup = level [[ level.detour_functions["zm_powerups::get_valid_powerup"] ]](); //returns a random powerup from level.zombie_powerup_array
	#region Patch
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

	#region Patch
        if(world.practice){
            if(level.round_number <31){
                need_perk = false;
                foreach(player in level.players){
                    if(player.host.num_perks>3 && player.host.num_perks<6){
                        need_perk = true;
                        break;
                    }
                }
                if(need_perk && level.round_number<28){ //Round 28 is the max round you have a chance to get the perk
                    powerup = "full_ammo";
                    if(level.debug) level.players[0] iPrintLnBold("Someone needs perk");
                }else if(level.zombie_total){
                    powerup = "insta_kill";
                    if(level.debug) level.players[0] iPrintLnBold("you get insta_kill to kill "+level.zombie_total+" to respawn");
                }else{
                    powerup = "nuke";
                    if(level.debug) level.players[0] iPrintLnBold("you get nuke to kill "+[[level.detour_functions["zombie_utility::get_round_enemy_array"]]]().size+" zombies alive");
                }
            }
        }else if(level.debug) level.players[0] iPrintLnBold("You got "+powerup);
	#endregion

	}
	switch(powerup)
	{
		case "full_ammo":
		{
			if(level.round_number > 10 && randomint(100) < ((level.round_number - 10) * 5)) // 11 = 95% | 12 = 90%....| 28 = 0%
			{
				powerup = level.zombie_powerup_array[randomint(level.zombie_powerup_array.size)];
	#region Patch
                if(world.practice){
                    if(need_perk && level.round_number<28){
                        powerup = "free_perk";
                        if(level.debug)level.players[0] iPrintLnBold("powerup changed to "+powerup);
                    }
                }else if(level.debug)level.players[0] iPrintLnBold("You got "+powerup);
	#endregion
			}
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
				//thread zm_utility::play_sound_2d("vox_sam_nospawn");
				self delete();
			}
			powerup = undefined;
			break;
		}
	}
	#region Patch
    	if(level.debug)level.players[0] iPrintLnBold("You got "+powerup);
	#endregion
	return powerup;
}
#endregion