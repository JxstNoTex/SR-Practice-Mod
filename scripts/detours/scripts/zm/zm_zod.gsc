detour zm_zod<scripts\zm\zm_zod.gsc>::placed_powerups()
{
	level.powerup_drop_count = 0;
	a_bonus_types = [];
    ArrayInsert(a_bonus_types, "double_points", a_bonus_types.size);
    ArrayInsert(a_bonus_types, "insta_kill", a_bonus_types.size);
    ArrayInsert(a_bonus_types, "full_ammo", a_bonus_types.size);
	a_bonus = struct::get_array("placed_powerup", "targetname");
	foreach(s_bonus in a_bonus)
	{
        if(world.practice){
            str_type = "full_ammo";
        }else{
            str_type = array::random(a_bonus_types);
        }
		[[ @zm_zod<scripts\zm\zm_zod.gsc>::spawn_infinite_powerup_drop ]](s_bonus.origin, str_type);
	}
}