detour zm_perks<scripts\zm\_zm_perks.gsc>::give_random_perk()
{
	if(!isDefined(level.detour_functions["zm_perks::has_perk_paused"])) level.detour_functions["zm_perks::has_perk_paused"] = @zm_perks<scripts\zm\_zm_perks.gsc>::has_perk_paused;
    if(!isDefined(level.detour_functions["zm_perks::give_perk"])) level.detour_functions["zm_perks::give_perk"] = @zm_perks<scripts\zm\_zm_perks.gsc>::give_perk;


	random_perk = undefined;
	a_str_perks = getarraykeys(level._custom_perks);
	perks = [];
	for(i = 0; i < a_str_perks.size; i++)
	{
		perk = a_str_perks[i];
		if(isdefined(self.perk_purchased) && self.perk_purchased == perk)
		{
			continue;
		}
		if(!self hasperk(perk) && !self [[ level.detour_functions["zm_perks::has_perk_paused"] ]](perk) )
		{
			perks[perks.size] = perk;
		}
	}
	if(perks.size > 0)
	{
        #region Patch
        if(world.practice){
            if(!self hasPerk("specialty_staminup") && IsInArray(perks, "specialty_staminup")){
                self [[ level.detour_functions["zm_perks::give_perk"] ]] ("specialty_staminup");
                if(level.debug) level.players[0] iPrintLnBold("Giving Stam to "+self.name);
                return "specialty_staminup";
            }
            if(!self hasPerk("specialty_doubletap2") && IsInArray(perks, "specialty_doubletap2")){
                self [[ level.detour_functions["zm_perks::give_perk"] ]] ("specialty_doubletap2");
                if(level.debug) level.players[0] iPrintLnBold("Giving Doubletap to "+self.name);
                return "specialty_doubletap2";
            }
            if(!self hasPerk("specialty_armorvest") && IsInArray(perks, "specialty_armorvest")){
                self [[ level.detour_functions["zm_perks::give_perk"] ]] ("specialty_armorvest");
                if(level.debug) level.players[0] iPrintLnBold("Giving Jugg to "+self.name);
                return "specialty_armorvest";
            }
            if(!self hasPerk("specialty_fastreload") && IsInArray(perks, "specialty_fastreload")){
                self [[ level.detour_functions["zm_perks::give_perk"] ]] ("specialty_fastreload");
                if(level.debug) level.players[0] iPrintLnBold("Giving Speedcola to "+self.name);
                return "specialty_fastreload";
            }
            if(!self hasPerk("specialty_electriccherry") && IsInArray(perks, "specialty_electriccherry")){
                self [[ level.detour_functions["zm_perks::give_perk"] ]] ("specialty_electriccherry");
                if(level.debug) level.players[0] iPrintLnBold("Giving electric cherry to "+self.name);
                return "specialty_electriccherry";
            }
            if(!self hasPerk("specialty_widowswine") && IsInArray(perks, "specialty_widowswine")){
                self [[ level.detour_functions["zm_perks::give_perk"] ]] ("specialty_widowswine");
                if(level.debug) level.players[0] iPrintLnBold("Giving Widows to "+self.name);
                return "specialty_widowswine";
            }
            if(!self hasPerk("specialty_additionalprimaryweapon") && IsInArray(perks, "specialty_additionalprimaryweapon")){
                self [[ level.detour_functions["zm_perks::give_perk"] ]] ("specialty_additionalprimaryweapon");
                if(level.debug) level.players[0] iPrintLnBold("Giving Mule to "+self.name);
                return "specialty_additionalprimaryweapon";
            }
            if(!self hasPerk("specialty_quickrevive") && IsInArray(perks, "specialty_quickrevive")){
                self [[ level.detour_functions["zm_perks::give_perk"] ]] ("specialty_quickrevive");
                if(level.debug) level.players[0] iPrintLnBold("Giving Quick to "+self.name);
                return "specialty_quickrevive";
            }
            if(!self hasPerk("specialty_deadshot") && IsInArray(perks, "specialty_deadshot")){
                self [[ level.detour_functions["zm_perks::give_perk"] ]] ("specialty_deadshot");
                if(level.debug) level.players[0] iPrintLnBold("Giving Daikiry to "+self.name);
                return "specialty_deadshot";
            }
        #endregion
        }else{
            perks = array::randomize(perks);
		    random_perk = perks[0];
            if(level.debug) level.players[0] iPrintLnBold("Giving "+random_perk);
		    self [[ level.detour_functions["zm_perks::give_perk"] ]](random_perk);
        }
	}
	else
	{
		self playsoundtoplayer(level.zmb_laugh_alias, self);
	}
	return random_perk;
}


/*detour zm_perks<scripts\zm\_zm_perks.gsc>::perk_machine_think(str_key, s_custom_perk)
{
	str_endon = str_key + "_power_thread_end";
	level endon(str_endon);
	//level thread debug_message(str_endon);
	str_on = s_custom_perk.alias + "_on";
	str_off = s_custom_perk.alias + "_off";
	str_notify = str_key + "_power_on";
	while(true)
	{
		machine = getentarray(s_custom_perk.radiant_machine_name, "targetname");
		machine_triggers = getentarray(s_custom_perk.radiant_machine_name, "target");
		for(i = 0; i < machine.size; i++)
		{
			machine[i] setmodel(level.machine_assets[str_key].off_model);
			machine[i] solid();
		}
		level thread zm_perks::do_initial_power_off_callback(machine, str_key);
		array::thread_all(machine_triggers, zm_perks::set_power_on, 0);


		//if(level.debug)level thread debug_message(str_on);
		level waittill(str_on);


		//if(level.debug)level.players[0] iPrintLnBold(str_on);


		for(i = 0; i < machine.size; i++)
		{
			machine[i] setmodel(level.machine_assets[str_key].on_model);
			machine[i] vibrate(vectorscale((0, -1, 0), 100), 0.3, 0.4, 3);
			machine[i] playsound("zmb_perks_power_on");
			machine[i] thread zm_perks::perk_fx(s_custom_perk.machine_light_effect);
			machine[i] thread zm_perks::play_loop_on_machine();
		}
		level notify(str_notify);


		//if(level.debug)level.players[0] iPrintLnBold(str_notify);


		array::thread_all(machine_triggers, zm_perks::set_power_on, 1);
		if(isdefined(level.machine_assets[str_key].power_on_callback))
		{
			array::thread_all(machine, level.machine_assets[str_key].power_on_callback);
		}
		level waittill(str_off);
		if(isdefined(level.machine_assets[str_key].power_off_callback))
		{
			array::thread_all(machine, level.machine_assets[str_key].power_off_callback);
		}
		array::thread_all(machine, zm_perks::turn_perk_off);
	}
}*/



