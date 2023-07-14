//function 

//level.zombie_powerup_array = array::randomize(level.zombie_powerup_array);







//functions from the game

function randomize_powerups()
{
	if(!isdefined(level.zombie_powerup_array))
	{
		level.zombie_powerup_array = [];
	}
	else
	{
		level.zombie_powerup_array = array::randomize(level.zombie_powerup_array);
	}
}

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