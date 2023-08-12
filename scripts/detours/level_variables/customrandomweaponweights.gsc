/*level.customrandomweaponweights

    its used on:
    "zm_zod" level.customrandomweaponweights = &zod_custom_weapon_weights;
    "zm_island" level.customrandomweaponweights = &function_659c2324;
    "zm_stalingrad" level.customrandomweaponweights = &function_659c2324;
    "zm_genesis" level.customrandomweaponweights = &function_659c2324;
    "zm_asylum" level.customrandomweaponweights = &function_659c2324;


    it changes the function "treasure_chest_chooseweightedrandomweapon(player)" of "zm_magicbox" andif its not defined then the order will be fully random
*/

function customrandomweaponweights(){

    if(!isDefined(level.detour_functions["zm_weapons::has_weapon_or_upgrade"])) level.detour_functions["zm_weapons::has_weapon_or_upgrade"] = @zm_weapons<scripts\zm\_zm_weapons.gsc>::has_weapon_or_upgrade;

    switch(level.script){
        case "zm_zod":

            level create_revolver_upgraded_camos();
            while(!isdefined(level.customrandomweaponweights)) wait GAMETICK;
            level.customrandomweaponweights = ::zod_customrandomweaponweights;
            
        break;

        case "zm_factory":

            level create_tesla_camos();
            level.customrandomweaponweights = ::factory_customrandomweaponweights;

        break;

        case "zm_castle":

        break;
        
        case "zm_island":

        break;
                
        case "zm_stalingrad":

        break;

        case "zm_genesis":

        break;

        case "zm_prototype":

        break;

        case "zm_asylum":

        break;

        case "zm_sumpf":

        break;

        case "zm_theatre":

        break;

        case "zm_cosmodrome":

        break;

        case "zm_temple":

        break;

        case "zm_moon":

        break;

        case "zm_tomb":

        break;                                                                           
    }
}

function can_give_ww_weap(weapon){

    if(!isDefined(weapon)){
        if(level.debug) level thread debug_message("Weapon to check not defined");
        return false;
    }
    foreach(player in level.players){
        if(player hasWeapon(weapon)){
            if(level.debug) level thread debug_message(player.name+" has already the weapon "+weapon.name);
            return false;
        }
    }

    if(isDefined(level.zombie_weapons[weapon].is_in_box) && level.zombie_weapons[weapon].is_in_box){
        if(level.debug) level thread debug_message("No one has "+weapon.name+" and its available on the box");
        return true;
    }else{
        if(level.debug) level thread debug_message("No one has "+weapon.name+" BUT its not on the box");
        return false;
    }

}

//zm_weapons::add_limited_weapon(level.idgun[i].str_wpnname, 1);
#region Zod
function zod_customrandomweaponweights(keys){

    #region Patch
    if(world.practice){
        if(can_give_ww_weap(getweapon(level.idgun[0].str_wpnname))){
            ArrayInsert(keys, getweapon(level.idgun[0].str_wpnname), 0);
            if(level.debug)level thread debug_message(level.idgun[0].str_wpnname +" is next weapon");
            return keys;
        }else if(!self [[ level.detour_functions["zm_weapons::has_weapon_or_upgrade"] ]](getweapon("octobomb"))){
            if(level.debug) level thread debug_message(self.name + " doesnt have arnies");
            if(level.zombie_weapons[level.w_octobomb].is_in_box){
                ArrayInsert(keys, level.w_octobomb, 0);
            }else{
                ArrayInsert(keys, level.w_octobomb_upgraded, 0);
            }
            return keys;
        }else if(!self [[ level.detour_functions["zm_weapons::has_weapon_or_upgrade"] ]](getweapon("lmg_cqb"))){
            if(level.debug) level thread debug_message(self.name + " doesnt have dingo");
            ArrayInsert(keys, getweapon("lmg_cqb"), 0);
            return keys;
        }else if(!self [[ level.detour_functions["zm_weapons::has_weapon_or_upgrade"] ]](getweapon("sniper_fastsemi"))){
            if(level.debug) level thread debug_message(self.name + " doesnt have drakon");
            ArrayInsert(keys, getweapon("sniper_fastsemi"), 0);
            return keys;
        }
    }

    #endregion

    return keys;
}

function create_revolver_upgraded_camos(){

    if(!isdefined(level.revolver_upgraded_camos)) level.revolver_upgraded_camos = [];

    //ArrayInsert(level.revolver_upgraded_camos, 10, level.revolver_upgraded_camos.size); //This camo is meh
    ArrayInsert(level.revolver_upgraded_camos, 74, level.revolver_upgraded_camos.size);
    //ArrayInsert(level.revolver_upgraded_camos, 81, level.revolver_upgraded_camos.size); //This camo is ugly :(
    ArrayInsert(level.revolver_upgraded_camos, 121, level.revolver_upgraded_camos.size);

}

#endregion

#region Factory

function factory_customrandomweaponweights(keys){

    #region Patch
    if(world.practice){
        if(can_give_ww_weap(level.weaponzmteslagun)){
            ArrayInsert(keys, level.weaponzmteslagun, 0);
            if(level.debug)level thread debug_message(level.weaponzmteslagun.name +" is next weapon");
            return keys;
        }else if(!self [[ level.detour_functions["zm_weapons::has_weapon_or_upgrade"] ]](getweapon("sniper_fastsemi"))){
            if(level.debug) level thread debug_message(self.name + " doesnt have drakon");
            ArrayInsert(keys, getweapon("sniper_fastsemi"), 0);
            return keys;
        }else if(!self [[ level.detour_functions["zm_weapons::has_weapon_or_upgrade"] ]](getweapon("lmg_cqb"))){
            if(level.debug) level thread debug_message(self.name + " doesnt have dingo");
            ArrayInsert(keys, getweapon("lmg_cqb"), 0);
            return keys;
        }else if(!self [[ level.detour_functions["zm_weapons::has_weapon_or_upgrade"] ]](level.weaponzmcymbalmonkey)){
            if(level.debug) level thread debug_message(self.name + " doesnt have monkeys");
            ArrayInsert(keys, level.weaponzmcymbalmonkey, 0);
            return keys;
        }
    }
    #endregion

    return keys;
}

function create_tesla_camos(){

    if(!isDefined(level.tesla_camos)) level.tesla_camos = [];
    if(!isDefined(level.tesla_camos[getweapon("tesla_gun").name])) level.tesla_camos[getweapon("tesla_gun").name] = [];
    if(!isDefined(level.tesla_camos[getweapon("tesla_gun_upgraded").name])) level.tesla_camos[getweapon("tesla_gun_upgraded").name] = [];

    ArrayInsert(level.tesla_camos[getweapon("tesla_gun").name], 26, level.tesla_camos[getweapon("tesla_gun").name].size);
    ArrayInsert(level.tesla_camos[getweapon("tesla_gun").name], 81, level.tesla_camos[getweapon("tesla_gun").name].size);

    ArrayInsert(level.tesla_camos[getweapon("tesla_gun_upgraded").name], 138, level.tesla_camos[getweapon("tesla_gun_upgraded").name].size);
    ArrayInsert(level.tesla_camos[getweapon("tesla_gun_upgraded").name], 137, level.tesla_camos[getweapon("tesla_gun_upgraded").name].size);
    ArrayInsert(level.tesla_camos[getweapon("tesla_gun_upgraded").name], 136, level.tesla_camos[getweapon("tesla_gun_upgraded").name].size);
    ArrayInsert(level.tesla_camos[getweapon("tesla_gun_upgraded").name], 135, level.tesla_camos[getweapon("tesla_gun_upgraded").name].size);
    ArrayInsert(level.tesla_camos[getweapon("tesla_gun_upgraded").name], 134, level.tesla_camos[getweapon("tesla_gun_upgraded").name].size);
    ArrayInsert(level.tesla_camos[getweapon("tesla_gun_upgraded").name], 133, level.tesla_camos[getweapon("tesla_gun_upgraded").name].size);
    
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




/*
    To be able to get the weapon you need:
    level.zombie_weapons["weapon_name"].is_in_box = 1;
    !player zm_weapons::has_weapon_or_upgrade(weapon)
    zm_weapons::limited_weapon_below_quota(weapon, player, pap_triggers)
    player zm_weapons::player_can_use_content(weapon)
    if(isdefined) [[level.custom_magic_box_selection_logic]](weapon, player, pap_triggers)
    Not to have mk2 or raygun if getting the other one

    if(isdefined) then its gonna be this: player [[level.special_weapon_magicbox_check]](weapon)
1212

*/