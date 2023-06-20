#region Zod

#endregion

#region Factory

function ee_factory_mg_1p_custom_ABH_(){

}

#endregion

#region Castle

#endregion

#region Island

#endregion

#region Stalingrad

#endregion

#region Genesis

#endregion

#region Prototype

#endregion

#region Asylum

#endregion

#region Sumpf

#endregion

#region Theatre

#endregion

#region Cosmodrome

#endregion

#region Temple

#endregion

#region Tomb

#endregion


/* Default ABH function

function function_728dfe3()
{
	player_zone = zm_zonemgr::get_zone_from_position(self.origin + vectorscale((0, 0, 1), 32), 0);
	if(!isdefined(player_zone))
	{
		player_zone = self.zone_name;
	}
	if(isdefined(player_zone))
	{
		zone_name = level.zones[player_zone];
	}
	respawn_point_array = struct::get_array("player_respawn_point", "targetname");
	valid_zones = [];
	foreach(s_respawn_point in respawn_point_array)
	{
		if(zm_utility::is_point_inside_enabled_zone(s_respawn_point.origin, zone_name))
		{
			if(!isdefined(valid_zones))
			{
				valid_zones = [];
			}
			else if(!isarray(valid_zones))
			{
				valid_zones = array(valid_zones);
			}
			valid_zones[valid_zones.size] = s_respawn_point;
		}
	} 
	if(isdefined(level.var_2d4e3645))
	{
		valid_zones = [[level.var_2d4e3645]](valid_zones);
	}
	s_player_respawn = undefined;
	if(valid_zones.size > 0)
	{
		random_zone = array::random(valid_zones);
		random_spawn_point = struct::get_array(random_zone.target, "targetname");
		foreach(location in random_spawn_point)
		{
			n_script_int = self getentitynumber() + 1;
			if(location.script_int === n_script_int)
			{
				s_player_respawn = location;
			}
		}
	}
	return s_player_respawn;
}

*/