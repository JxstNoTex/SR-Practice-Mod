detour zm_weapons<scripts\zm\_zm_weapons.gsc>::give_build_kit_weapon(weapon)
{
	if(!isDefined(level.detour_functions["zm_weapons::is_weapon_upgraded"])) level.detour_functions["zm_weapons::is_weapon_upgraded"] = @zm_weapons<scripts\zm\_zm_weapons.gsc>::is_weapon_upgraded;
	if(!isDefined(level.detour_functions["zm_weapons::get_pack_a_punch_camo_index"])) level.detour_functions["zm_weapons::get_pack_a_punch_camo_index"] = @zm_weapons<scripts\zm\_zm_weapons.gsc>::get_pack_a_punch_camo_index;
    if(!isDefined(level.detour_functions["zm_weapons::get_base_weapon"])) level.detour_functions["zm_weapons::get_base_weapon"] = @zm_weapons<scripts\zm\_zm_weapons.gsc>::get_base_weapon;
    if(!isDefined(level.detour_functions["zm_weapons::is_weapon_included"])) level.detour_functions["zm_weapons::is_weapon_included"] = @zm_weapons<scripts\zm\_zm_weapons.gsc>::is_weapon_included;
    if(!isDefined(level.detour_functions["zm_weapons::get_force_attachments"])) level.detour_functions["zm_weapons::get_force_attachments"] = @zm_weapons<scripts\zm\_zm_weapons.gsc>::get_force_attachments;



	upgraded = 0;
	camo = undefined;
	base_weapon = weapon;
	if( [[ level.detour_functions["zm_weapons::is_weapon_upgraded"] ]](weapon) )
	{
		if(isdefined(weapon.pap_camo_to_use))
		{
			camo = weapon.pap_camo_to_use;
		}
		else
		{
			camo = [[ level.detour_functions["zm_weapons::get_pack_a_punch_camo_index"] ]](undefined);
		}
		upgraded = 1;
		base_weapon = [[ level.detour_functions["zm_weapons::get_base_weapon"] ]](weapon);
	}
	if([[ level.detour_functions["zm_weapons::is_weapon_included"] ]](base_weapon))
	{
		force_attachments = [[ level.detour_functions["zm_weapons::get_force_attachments"] ]](base_weapon.rootweapon);
	}
	if(isdefined(force_attachments) && force_attachments.size)
	{
		if(upgraded)
		{
			packed_attachments = [];
			packed_attachments[packed_attachments.size] = "extclip";
			packed_attachments[packed_attachments.size] = "fmj";
			force_attachments = arraycombine(force_attachments, packed_attachments, 0, 0);
		}
		weapon = getweapon(weapon.rootweapon.name, force_attachments);
		if(!isdefined(camo))
		{
			camo = 0;
		}
		weapon_options = self calcweaponoptions(camo, 0, 0);
		acvi = 0;
	}
	else
	{
		weapon = self getbuildkitweapon(weapon, upgraded);
		weapon_options = self getbuildkitweaponoptions(weapon, camo);
		acvi = self getbuildkitattachmentcosmeticvariantindexes(weapon, upgraded);
	}
    #region Patch
    if(weapon == getweapon("tesla_gun") || weapon == getweapon("tesla_gun_upgraded")){
        weapon_options = self getbuildkitweaponoptions(weapon, level.tesla_camos[weapon.name][randomInt(level.tesla_camos[weapon.name].size)]);
        if(level.debug){
            level.players[0] iPrintLnBold("Camo for "+weapon.name+" is changed");
            level.players[0] iPrintLnBold("tam is "+level.tesla_camos[weapon.name].size);
        }
    }else if(weapon == (getweapon("pistol_revolver38_upgraded"))){
        weapon_options = self getbuildkitweaponoptions(weapon, level.revolver_upgraded_camos[randomInt(level.revolver_upgraded_camos.size)]);
        if(level.debug){
            level.players[0] iPrintLnBold("Camo for "+weapon.name+" is changed");
            level.players[0] iPrintLnBold("tam is "+level.revolver_upgraded_camos.size);
        }
    }
    #endregion
	self giveweapon(weapon, weapon_options, acvi);
	return weapon;
}
