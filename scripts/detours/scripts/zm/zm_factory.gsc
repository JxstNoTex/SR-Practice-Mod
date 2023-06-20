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
			level thread debug_message("Random 5th perk set to Stamina");
		}

	}else{
		if(math::cointoss())
		{
			level._custom_perks["specialty_staminup"].perk_machine_power_override_thread = level.detour_functions["zm_factory::function_384be1c4"];
			level._custom_perks["specialty_deadshot"].perk_machine_power_override_thread = level.detour_functions["zm_factory::function_49e223a9"];

			if(level.debug){
				level flag::wait_till("start_zombie_round_logic");
				level thread debug_message("You got Daikiry");
			}
		}
		else
		{
			level._custom_perks["specialty_deadshot"].perk_machine_power_override_thread = level.detour_functions["zm_factory::function_16d38a15"];
			level._custom_perks["specialty_staminup"].perk_machine_power_override_thread = level.detour_functions["zm_factory::function_6000324c"];

			if(level.debug){
				level flag::wait_till("start_zombie_round_logic");
				level thread debug_message("You got Stamina");
			}
		}
	}
}
