#include scripts\shared\ai\zombie_utility;

function zombie_alive_hud()
{

	if(!isdefined(level.zombie_alive_hud)){

		level.zombie_alive_hud = newHudElem();
		level.zombie_alive_hud init_hudelem("right", "top", "user_right", "user_top", -50, 50, 1.5, 0, (1,1,1), 1, &"^2Zombies Alive: ");

    	level flag::wait_till("start_zombie_round_logic");
		wait 2.5;

		level.zombie_alive_hud.alpha = 1;

		while(true){
			wait level.tick;

			level.zombie_alive_hud setvalue(get_round_enemy_array());

		}

	}

}


function zombie_spawn_hud(){

	if(!isdefined(level.zombie_spawn_hud)){

		level.zombie_spawn_hud = newHudElem();
		level.zombie_spawn_hud init_hudelem("right", "top", "user_right", "user_top", -50, 65, 1.5, 0, (1,1,1), 1, &"^1Zombies to Spawn: ");

    	level flag::wait_till("start_zombie_round_logic");
		wait 2.5;

		level.zombie_spawn_hud.alpha = 1;

		while(true){
			wait level.tick;

			level.zombie_spawn_hud setvalue((level.zombie_total-level.zombie_respawns));
		}

	}

}

function zombie_respawn_hud(){

	if(!isdefined(level.zombie_respawn_hud)){

		level.zombie_respawn_hud = newHudElem();
		level.zombie_respawn_hud init_hudelem("right", "top", "user_right", "user_top", -50, 80, 1.5, 0, (1,1,1), 1, &"^1Zombies to REspawn: ");

    	level flag::wait_till("start_zombie_round_logic");
		wait 2.5;

		level.zombie_respawn_hud.alpha = 1;

		while(true){
			wait level.tick;

			level.zombie_respawn_hud setvalue(level.zombie_respawns);
		}

	}

}

function get_round_enemy_array()
{
	a_ai_enemies = [];
	//a_ai_valid_enemies = [];
	a_ai_valid_enemies = 0;
	a_ai_enemies = getaiteamarray(level.zombie_team);
	for(i = 0; i < a_ai_enemies.size; i++)
	{
		if(isdefined(a_ai_enemies[i].ignore_enemy_count) && a_ai_enemies[i].ignore_enemy_count)
		{
			continue;
		}
		/*if(!isdefined(a_ai_valid_enemies))
		{
			a_ai_valid_enemies = [];
		}
		else if(!isarray(a_ai_valid_enemies))
		{
			a_ai_valid_enemies = array(a_ai_valid_enemies);
		}*/
		//a_ai_valid_enemies[a_ai_valid_enemies.size] = a_ai_enemies[i];
		a_ai_valid_enemies++;
	}
	return a_ai_valid_enemies;
}

function lockdown_wave(){

	level flag::wait_till("lockdown_active");

	level.zombie_alive_hud.alpha = 0;
	level.zombie_spawn_hud.alpha = 0;
	level.zombie_respawn_hud.alpha = 0;


	level.zombie_alive2_hud = newHudElem();
	level.zombie_alive2_hud init_hudelem("right", "top", "user_right", "user_top", -50, 50, 1.5, 0, (1,1,1), 1, &"^2Zombies Alive: ");
	level.zombie_alive2_hud.alpha = 1;
	level.zombie_alive2_hud thread lockdown_alive();


	level.zombie_spawn2_hud = newHudElem();
	level.zombie_spawn2_hud init_hudelem("right", "top", "user_right", "user_top", -50, 65, 1.5, 0, (1,1,1), 1, &"^1Zombies to Spawn: ");
	level.zombie_spawn2_hud.alpha = 1;
	level.zombie_spawn2_hud thread lockdown_respawn();

	level.lockdown_total = 14 + (8 * level.players.size);
	level.zombies_counted = 0;

    level waittill(#"hash_d2eac5fe");

    level.lockdown_total = 16 + (9 * level.players.size);
	level.zombies_counted = 0;

    level waittill(#"hash_d2eac5fe");

    level.lockdown_total = 18 + (10 * level.players.size);
	level.zombies_counted = 0;

    level waittill(#"hash_d2eac5fe");

    level.lockdown_total = 18 + (10 * level.players.size * 2);
	level.zombies_counted = 0;

	level.zombie_spawn2_hud.alpha = 0;
	level.zombie_alive2_hud.alpha = 0;

	level.zombie_alive_hud.alpha = 1;
	level.zombie_spawn_hud.alpha = 1;
	level.zombie_respawn_hud.alpha = 1;

}


//level.var_c3c3ffc5.size //total wave
//level.zombies_counted//already spawn

function lockdown_zombies(){

	zombies = 0;

	a_ai_enemies = getaiteamarray(level.zombie_team);
	for(i = 0; i < a_ai_enemies.size; i++)
	{
		if(a_ai_enemies[0].lockdown == 1){
			zombies++;
		}
	}

	return zombies;
}

function lockdown_alive(){
	while(level flag::get("lockdown_active")){
		wait level.tick;

		self setvalue(lockdown_zombies());
	}
}

function lockdown_respawn(){
	while(level flag::get("lockdown_active")){
		wait level.tick;

		self setvalue(level.lockdown_total-level.lockdown_spawned);
	}
}