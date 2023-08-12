#region Zod

#endregion

#region Factory

function ee_factory_mg_custom_ABH(){

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


	//player_zone
	if(level.debug) level thread debug_message("ABH has been found");


    //Patch for top warehouse ABH
	zone_name = get_abh_location("warehouse_top_zone");
	//If I am on left TP, Top furnance is available, EE button is hit and EE is not finished
    if( player_zone == "wnuen_zone" && IsInArray(valid_zones, zone_name) && level flag::get("flytrap") && !is_giant_ee_done() ){

		n_script_int = self getentitynumber() + 1;
		abh_location = struct::get_array(zone_name.target, "targetname");

		foreach(location in abh_location){

			if(location.script_int === n_script_int){
				if(level.debug) level thread debug_message("Top warehouse ABH");
				
				return location;
			}
		}

		level thread debug_message("Error, couldnt find place n"+n_script_int+" for "+zone_name.script_noteworthy);

    }

    //Patch for bottom warehouse ABH
	zone_name = get_abh_location("warehouse_bottom_zone");
	//if I am on left TP, Bottom furnance is available, EE button is hit and EE is not finished
    if( player_zone == "wnuen_zone" && IsInArray(valid_zones, zone_name) && level flag::get("flytrap") && !is_giant_ee_done() ){

		n_script_int = self getentitynumber() + 1;
		abh_location = struct::get_array(zone_name.target, "targetname");

		foreach(location in abh_location){

			if(location.script_int === n_script_int){
				if(level.debug) level thread debug_message("Bottom warehouse ABH");
				
				return location;
			}
		}

		level thread debug_message("Error, couldnt find place n"+n_script_int+" for "+zone_name.script_noteworthy);

    }

	zone_name = get_abh_location("wnuen_zone");
	//If EE button is hit but EE is not finished and left tp ABH is available
    if( level flag::get("flytrap") && !is_giant_ee_done() && IsInArray(valid_zones, zone_name) ){

		n_script_int = self getentitynumber() + 1;
		abh_location = struct::get_array(zone_name.target, "targetname");

		foreach(location in abh_location){

			if(location.script_int === n_script_int){
				if(level.debug) level thread debug_message("Wnuen (left tp) ABH");
				
				return location;
			}
		}

		level thread debug_message("Error, couldnt find place n"+n_script_int+" for "+zone_name.script_noteworthy);

    }

	zone_name = get_abh_location("outside_east_zone");
	//If EE button is hit but EE is not finished and left tp ABH is available
    if( level flag::get("flytrap") && !is_giant_ee_done() && IsInArray(valid_zones, zone_name) ){

		n_script_int = self getentitynumber() + 1;
		abh_location = struct::get_array(zone_name.target, "targetname");

		foreach(location in abh_location){

			if(location.script_int === n_script_int){
				if(level.debug) level thread debug_message("outside east (left tp) ABH");
				
				return location;
			}
		}

		level thread debug_message("Error, couldnt find place n"+n_script_int+" for "+zone_name.script_noteworthy);

    }


    //Else, random ABH
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

	if(level.debug) level thread debug_message("Default ABH");
	return s_player_respawn;
}

function ee_factory_cg_custom_ABH(){

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


	//player_zone
	if(level.debug) level thread debug_message("ABH has been found");


    //Patch for top warehouse ABH
	zone_name = get_abh_location("warehouse_top_zone");
	//If I am on left TP, Top furnance is available, EE button is hit and EE is not finished
    if( IsInArray(valid_zones, zone_name) && level flag::get("flytrap") && !is_giant_ee_done() ){

		n_script_int = self getentitynumber() + 1;
		abh_location = struct::get_array(zone_name.target, "targetname");

		foreach(location in abh_location){

			if(location.script_int === n_script_int){
				if(level.debug) level thread debug_message("Top warehouse ABH");
				
				return location;
			}
		}

		level thread debug_message("Error, couldnt find place n"+n_script_int+" for "+zone_name.script_noteworthy);

    }


    //Else, random ABH
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

	if(level.debug) level thread debug_message("Default ABH");
	return s_player_respawn;
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

function get_abh_location(name){

	respawn_point_array = struct::get_array("player_respawn_point", "targetname");

	foreach(zone in respawn_point_array){
		if(zone.script_noteworthy == name) return zone;
	}

	level thread debug_message("Error, couldnt find abh location "+name);

}