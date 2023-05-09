detour zm_perks<scripts\zm\_zm_perks.gsc>::give_random_perk()
{
	if(!isDefined(level.detour_functions["zm_perks::is_weapon_upgraded"])) level.detour_functions["zm_perks::is_weapon_upgraded"] = @zm_perks<scripts\zm\_zm_perks.gsc>::has_perk_paused;
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
		if(!self hasperk(perk) && !self [[ level.detour_functions["zm_perks::is_weapon_upgraded"] ]](perk) )
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

