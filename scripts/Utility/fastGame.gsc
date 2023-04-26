function fast_exit(){

	level waittill("end_game");
	wait 3;
	//Deletes attempts played on the map with
	/*world.attempts[level.script][level.players.size] = undefined;
	world.attempts[level.script] = undefined;
	world.attempts = undefined;*/
	//world.end_times[level.script] = undefined;
	exitLevel(0);

}

function fast_restart(){

	level endon("end_game");
	self endon("disconnect");

	while(true){
		wait level.tick;

		if(self fragButtonPressed() && self meleeButtonPressed()){
			wait 0.5;
			if(self fragButtonPressed() && self meleeButtonPressed()) map_restart();
		}
	}
}
