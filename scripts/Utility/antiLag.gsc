function precache_strings(){

    level endon("end_game");

//level.players[0] iPrintLnBold("starting precache");
    str_trig = Spawn( "trigger_radius", (0, 0, 0), 0, 16, 16 );
    str_trig SetInvisibleToAll();

    level waittill( "all_players_connected" );

    //level.players[0] iPrintLnBold("all players connected");
    precache_base_perks(str_trig);
    precache_general(str_trig);

//level.players[0] iPrintLnBold("base precache done");

    switch(level.script){

        case "zm_zod":
        
            precache_pap(str_trig);
            precache_zod_base_perks(str_trig)

            register_this_string(str_trig, &"ZM_ZOD_PICKUP_BOTTLE");
            register_this_string(str_trig, &"ZM_ZOD_PICKUP_IDGUN");
            register_this_string(str_trig, &"ZOMBIE_TRADE_WEAPON_FILL");
            register_this_string(str_trig, &"ZM_ZOD_PORTAL_OPEN");
            register_this_string(str_trig, &"ZM_ZOD_POWERSWITCH_POWERED");
            register_this_string(str_trig, &"ZM_ZOD_POWERSWITCH_UNPOWERED");
            register_this_string(str_trig, &"ZM_ZOD_QUEST_RITUAL_PICKUP_QUEST_KEY");
            register_this_string(str_trig, &"ZM_ZOD_QUEST_RITUAL_PLACE_RELIC");
            register_this_string(str_trig, &"ZM_ZOD_QUEST_RITUAL_PAP_REPLACE");
            register_this_string(str_trig, &"ZM_ZOD_QUEST_RITUAL_PAP_NOT_READY");
            register_this_string(str_trig, &"ZM_ZOD_QUEST_RITUAL_PAP_KICKOFF");
            register_this_string(str_trig, &"ZM_ZOD_ROBOT_NEEDS_POWER");
            register_this_string(str_trig, &"ZM_ZOD_ROBOT_ONCALL_IN");
            register_this_string(str_trig, &"ZM_ZOD_ROBOT_ONCALL_IN");
            register_this_string(str_trig, &"ZM_ZOD_ROBOT_ONCALL_IN");
            register_this_string(str_trig, &"ZM_ZOD_ROBOT_ONCALL_IN");
            register_this_string(str_trig, &"ZM_ZOD_POWERSWITCH_POWERED", &"ZM_ZOD_AREA_NAME_JUNCTION");
            register_this_string(str_trig, &"ZM_ZOD_POWERSWITCH_UNPOWERED", &"ZM_ZOD_AREA_NAME_SLUMS");
            register_this_string(str_trig, &"ZM_ZOD_QUEST_RITUAL_PICKUP_QUEST_KEY", &"ZM_ZOD_AREA_NAME_CANAL");
            register_this_string(str_trig, &"ZM_ZOD_QUEST_RITUAL_PLACE_RELIC", &"ZM_ZOD_AREA_NAME_THEATER");
            register_this_string(str_trig, &"ZM_ZOD_ROBOT_PAY_TOWARDS");
            register_this_string(str_trig, &"ZM_ZOD_ROBOT_SUMMON");

        break;

        case "zm_factory":
        
            precache_pap(str_trig);
            precache_factory_base_perks(str_trig)

            register_this_string(str_trig, &"ZOMBIE_TELEPORT_COOLDOWN");
            register_this_string(str_trig, &"ZOMBIE_TELEPORT_TO_CORE");
            register_this_string(str_trig, &"ZOMBIE_LINK_TPAD");
            register_this_string(str_trig, &"ZOMBIE_POWER_UP_TPAD");
            register_this_string(str_trig, &"ZOMBIE_INACTIVE_TPAD");


        break;

        case "zm_castle":
        
            precache_pap(str_trig);
            precache_no_base_perks(str_trig)

            register_this_string(str_trig, &"ZM_CASTLE_PICKUP_BOTTLE");
            register_this_string(str_trig, &"ZM_CASTLE_GRAVITYSPIKE_PICKUP");
            register_this_string(str_trig, &"ZM_CASTLE_GRAVITYSPIKE_A10_SWITCH");
            register_this_string(str_trig, &"ZM_CASTLE_GRAVITYSPIKE_A10_CONSOLE");
            register_this_string(str_trig, &"ZM_CASTLE_GRAVITYSPIKE_ALREADY_HAVE");
            register_this_string(str_trig, &"ZM_CASTLE_DEATH_RAY_COOLDOWN");
            register_this_string(str_trig, &"ZM_CASTLE_DEATH_RAY_TRAP");
            register_this_string(str_trig, &"ZM_CASTLE_WUNDERSPHERE_LOCKED");
            register_this_string(str_trig, &"ZM_CASTLE_MASHER_POWER");
            register_this_string(str_trig, &"ZM_CASTLE_MASHER_UNAVAILABLE");
            register_this_string(str_trig, &"ZM_CASTLE_MASHER_COOLDOWN");
            register_this_string(str_trig, &"ZM_CASTLE_MASHER_TRAP");
            register_this_string(str_trig, &"ZM_CASTLE_PAP_TP_UNAVAILABLE");
            register_this_string(str_trig, &"ZM_CASTLE_PAP_TP_AWAY");
            register_this_string(str_trig, &"ZM_CASTLE_PAP_TP_ACTIVATE");
            register_this_string(str_trig, &"ZOMBIE_TELEPORT_COOLDOWN");
            register_this_string(str_trig, &"ZM_CASTLE_TELEPORT_LOCKED");
            register_this_string(str_trig, &"ZM_CASTLE_TELEPORT_USE", 500);
            register_this_string(str_trig, &"ZOMBIE_LINK_TPAD");
            register_this_string(str_trig, &"ZOMBIE_TRADE_WEAPON_FILL");
            register_this_string(str_trig, &"ZM_CASTLE_TRADE_UPGRADE_QUEST");
            register_this_string(str_trig, &"ZM_CASTLE_BIND_TO_QUEST");
            register_this_string(str_trig, &"ZM_CASTLE_REFORGED_ARROW");
            register_this_string(str_trig, &"ZM_CASTLE_PICK_UP_ICE_BOW");
            register_this_string(str_trig, &"ZM_CASTLE_PICK_UP_FIRE_BOW");
            register_this_string(str_trig, &"ZM_CASTLE_PICK_UP_LIGHTNING_BOW");
            register_this_string(str_trig, &"ZM_CASTLE_RETURN_WIND_BOW");
            register_this_string(str_trig, &"ZM_CASTLE_RETURN_ICE_BOW");
            register_this_string(str_trig, &"ZM_CASTLE_RETURN_FIRE_BOW");
            register_this_string(str_trig, &"ZM_CASTLE_RETURN_LIGHTNING_BOW");
            register_this_string(str_trig, &"ZM_CASTLE_PICK_UP_BASE_BOW");

        break;

        case "zm_island":
        
            precache_pap(str_trig);
            precache_no_base_perks(str_trig)

            register_this_string(str_trig, &"ZM_ISLAND_TEAR_WEB");
            register_this_string(str_trig, &"ZM_ISLAND_GASMASK_PICKUP");
            register_this_string(str_trig, &"ZOMBIE_BUILD_PIECE_HAVE_ONE");
            register_this_string(str_trig, &"ZM_ISLAND_ELEVATOR_RECHARGING");
            register_this_string(str_trig, &"ZM_ISLAND_USE_ELEVATOR");
            register_this_string(str_trig, &"ZM_ISLAND_ELEVATOR_IN_USE");
            register_this_string(str_trig, &"ZM_ISLAND_CALL_ELEVATOR");
            register_this_string(str_trig, &"ZM_ISLAND_PLANT_SEED");
            register_this_string(str_trig, &"ZM_ISLAND_WATER_PLANT");
            register_this_string(str_trig, &"ZM_ISLAND_CACHE_PLANT");
            register_this_string(str_trig, &"ZM_ISLAND_CLONE_PLANT");
            register_this_string(str_trig, &"ZM_ISLAND_FRUIT_PLANT");
            register_this_string(str_trig, &"ZOMBIE_TRADE_WEAPON_FILL");
            register_this_string(str_trig, &"ZM_ISLAND_PENSTOCK_DEBRIS");
            register_this_string(str_trig, &"ZM_ISLAND_POWER_SWITCH_NEEEDS_WATER");
            register_this_string(str_trig, &"ZM_ISLAND_FILL_BUCKET");
            register_this_string(str_trig, &"ZM_ISLAND_PLANT_BUCKET");
            register_this_string(str_trig, &"ZM_ISLAND_PICKUP_GOLDEN_BUCKET");
            register_this_string(str_trig, &"ZM_ISLAND_SKULLQUEST_GET_SKULLGUN");
            register_this_string(str_trig, &"ZM_ISLAND_SPIDER_QUEEN_WINE");
            register_this_string(str_trig, &"ZM_ISLAND_MAIN_POWER_OFF");
            register_this_string(str_trig, &"ZM_ISLAND_SEWER_IN_USE");
            register_this_string(str_trig, &"ZM_ISLAND_CLONE_PLANT");
            register_this_string(str_trig, &"ZM_ISLAND_USE_SEWER");
            register_this_string(str_trig, &"ZM_ISLAND_NO_POWER");
            register_this_string(str_trig, &"ZM_ISLAND_CAGE_RAISE");
            register_this_string(str_trig, &"ZM_ISLAND_CAGE_LOWER");



        break;

        case "zm_stalingrad":
        
            precache_pap(str_trig);
            precache_no_base_perks(str_trig)

            register_this_string(str_trig, &"ZM_STALINGRAD_POWER_REQUIRED");
            register_this_string(str_trig, &"ZM_STALINGRAD_CONSOLE_DISABLED");
            register_this_string(str_trig, &"ZM_STALINGRAD_CONSOLE_COOLDOWN");
            register_this_string(str_trig, &"ZM_STALINGRAD_CONSOLE_DRAGON_SUMMON", 0);
            register_this_string(str_trig, &"ZM_STALINGRAD_CONSOLE_DRAGON_SUMMON", 500);
            register_this_string(str_trig, &"ZM_STALINGRAD_CONSOLE_DRAGON_BUSY");
            register_this_string(str_trig, &"ZM_STALINGRAD_CONSOLE_DRAGON_ON_THE_WAY");
            register_this_string(str_trig, &"ZM_STALINGRAD_CONSOLE_DRAGON_ARRIVED");
            register_this_string(str_trig, &"ZM_STALINGRAD_CONSOLE_DRAGON_TAKE_OFF_COUNTDOWN");
            register_this_string(str_trig, &"ZM_STALINGRAD_CONSOLE_DRAGON_ENROUTE_PAVLOVS");
            register_this_string(str_trig, &"ZM_STALINGRAD_RIDE_DRAGON");
            register_this_string(str_trig, &"ZM_STALINGRAD_DROP_POD_ACTIVE");
            register_this_string(str_trig, &"ZM_STALINGRAD_DROP_POD_CYLINDER_REQUIRED");
            register_this_string(str_trig, &"ZM_STALINGRAD_DROP_POD_INCORRECT_CYLINDER");
            register_this_string(str_trig, &"ZM_STALINGRAD_DROP_POD_ACTIVATE");
            register_this_string(str_trig, &"ZM_STALINGRAD_GENERATOR");
            register_this_string(str_trig, &"ZM_STALINGRAD_MASTER_CYLINDER");
            register_this_string(str_trig, &"ZOMBIE_TRAP_ACTIVE");
            register_this_string(str_trig, &"ZM_STALINGRAD_TRAP_COOLDOWN");
            register_this_string(str_trig, &"ZM_STALINGRAD_CONSOLE_DRAGON_ENROUTE_PAVLOVS");
            register_this_string(str_trig, &"ZM_STALINGRAD_EGG_PICKUP");
            register_this_string(str_trig, &"ZM_STALINGRAD_EGG_RETRIEVE");
            register_this_string(str_trig, &"ZM_STALINGRAD_EGG_TOO_HOT");
            register_this_string(str_trig, &"ZM_STALINGRAD_EGG_PLACE");
            register_this_string(str_trig, &"ZM_STALINGRAD_EGG_INCUBATE");
            register_this_string(str_trig, &"ZM_STALINGRAD_MOUNTED_MG_COOLDOWN");
            register_this_string(str_trig, &"ZM_STALINGRAD_FLINGER_DISABLED");
            register_this_string(str_trig, &"ZM_STALINGRAD_FLINGER_TRAP_USE", 1000);
            register_this_string(str_trig, &"ZM_STALINGRAD_BRIDGE_UNAVAILABLE");
            register_this_string(str_trig, &"ZM_STALINGRAD_BRIDGE_USE", 500);
            register_this_string(str_trig, &"ZM_STALINGRAD_WEARABLE_EQUIPPED");
            register_this_string(str_trig, &"ZM_STALINGRAD_WEARABLE_WINGS_EQUIP");
            register_this_string(str_trig, &"ZM_STALINGRAD_WINGS_TRANSPORT");
            register_this_string(str_trig, &"ZM_STALINGRAD_WEARABLE_RAZ_MASK_EQUIP");
            register_this_string(str_trig, &"ZM_STALINGRAD_WEARABLE_VALKYRIE_HAT_EQUIP");
            register_this_string(str_trig, &"ZM_STALINGRAD_SHIELD_UPGRADE");

        break;

        case "zm_genesis":
        
            precache_pap(str_trig);
            precache_no_base_perks(str_trig)

            register_this_string(str_trig, &"ZM_GENESIS_APOTHICON_TRAP_READY");
            register_this_string(str_trig, &"ZM_GENESIS_APOTHICON_DOOR");
            register_this_string(str_trig, &"ZOMBIE_TRAP_ACTIVE");
            register_this_string(str_trig, &"ZOMBIE_TRAP_COOLDOWN");
            register_this_string(str_trig, &"ZM_GENESIS_FLINGER_TRAP_USE", 1000);
            register_this_string(str_trig, &"ZM_GENESIS_JUMP_PAD_COOLDOWN");
            register_this_string(str_trig, &"ZM_GENESIS_CALLBOX_PICKUP_PART");
            register_this_string(str_trig, &"ZM_GENESIS_CALLBOX_MISSING_PARTS");
            register_this_string(str_trig, &"ZM_GENESIS_CALLBOX_BUILD");
            register_this_string(str_trig, &"ZM_GENESIS_ROBOT_ONCALL_IN");
            register_this_string(str_trig, &"ZM_GENESIS_ROBOT_PAY_TOWARDS");
            register_this_string(str_trig, &"ZM_GENESIS_ROBOT_SUMMON");
            register_this_string(str_trig, &"ZM_GENESIS_SKULL_TURRET_COOLDOWN");
            register_this_string(str_trig, &"ZM_GENESIS_REUSE_TURRET");
            register_this_string(str_trig, &"ZM_GENESIS_TURRET_IN_USE");
            register_this_string(str_trig, &"ZM_GENESIS_USE_TURRET", 2000);
            register_this_string(str_trig, &"ZOMBIE_TRAP_ACTIVE");
            register_this_string(str_trig, &"ZOMBIE_TRAP_ACTIVE");
            register_this_string(str_trig, &"ZOMBIE_TRAP_COOLDOWN");
            register_this_string(str_trig, &"ZOMBIE_BUTTON_BUY_TRAP", 1000);
            register_this_string(str_trig, &"ZM_GENESIS_WEARABLE_EQUIPPED");
            register_this_string(str_trig, &"ZM_GENESIS_WEARABLE_PICKUP");
            register_this_string(str_trig, &"ZM_GENESIS_PORTAL_OPEN");


            register_this_string(str_trig, &"ZOMBIE_TRAP_ACTIVE");
            register_this_string(str_trig, &"ZOMBIE_TRAP_ACTIVE");
            register_this_string(str_trig, &"ZOMBIE_TRAP_COOLDOWN");
            register_this_string(str_trig, &"ZOMBIE_BUTTON_BUY_TRAP", 1000);
            register_this_string(str_trig, &"ZM_GENESIS_WEARABLE_EQUIPPED");
            register_this_string(str_trig, &"ZM_GENESIS_WEARABLE_PICKUP");


        break;

        case "zm_prototype":

            precache_no_base_perks(str_trig);

        break;

        case "zm_asylum":

            precache_no_base_perks(str_trig);

        break;

        case "zm_sumpf":

            precache_no_base_perks(str_trig)

            register_this_string(str_trig, &"ZOMBIE_BUTTON_BUY_TRAP", 750);
            register_this_string(str_trig, &"ZOMBIE_BUTTON_BUY_TRAP");
            register_this_string(str_trig, &"ZOMBIE_ZIPLINE_ACTIVATE");
            register_this_string(str_trig, &"ZOMBIE_ZIPLINE_USE");
            register_this_string(str_trig, &"ZOMBIE_ZIPLINE_DEACTIVATED");

        break;

        case "zm_theater":
        
            precache_pap(str_trig);
            precache_no_base_perks(str_trig)

            register_this_string(str_trig, &"ZM_THEATER_USE_TELEPORTER");
            register_this_string(str_trig, &"ZOMBIE_TELEPORT_COOLDOWN");
            register_this_string(str_trig, &"ZM_THEATER_LINK_CORE");
            register_this_string(str_trig, &"ZM_THEATER_LINK_PAD");
            register_this_string(str_trig, &"ZM_THEATER_START_CORE");


        break;

        case "zm_Cosmodrome":
        
            precache_pap(str_trig);
            precache_no_base_perks(str_trig)

            register_this_string(str_trig, &"ZM_COSMODROME_LANDER_CALL");
            register_this_string(str_trig, &"ZM_COSMODROME_LANDER_AT_STATION");
            register_this_string(str_trig, &"ZM_COSMODROME_LANDER_NO_CONNECTIONS");
            register_this_string(str_trig, &"ZM_COSMODROME_LANDER", 250);
            register_this_string(str_trig, &"ZM_COSMODROME_LANDER_ON_WAY");
            register_this_string(str_trig, &"ZM_COSMODROME_LANDER_IN_USE");
            register_this_string(str_trig, &"ZM_COSMODROME_LANDER_AT_STATION");
            register_this_string(str_trig, &"ZM_COSMODROME_WAITING_AUTHORIZATION");

        break;

        case "zm_temple":
        
            precache_pap(str_trig);
            precache_no_base_perks(str_trig)

            register_this_string(str_trig, &"ZM_TEMPLE_DESTINATION_NOT_OPEN");
            register_this_string(str_trig, &"ZM_TEMPLE_MINECART_COST", 250);
            register_this_string(str_trig, &"ZM_TEMPLE_MINECART_UNAVAILABLE");
            register_this_string(str_trig, &"ZM_TEMPLE_RELEASE_WATER");
            register_this_string(str_trig, &"ZM_TEMPLE_USE_WATER_TRAP");
            register_this_string(str_trig, &"ZM_TEMPLE_WATER_TRAP_COOL");

        break;

        case "zm_moon":
        
            precache_pap(str_trig);
            precache_no_base_perks(str_trig)

            register_this_string(str_trig, &"ZOMBIE_HACK_NO_COST");
            register_this_string(str_trig, &"ZOMBIE_HACK");
            register_this_string(str_trig, &"ZM_MOON_NO_HACK");
            register_this_string(str_trig, &"ZM_MOON_SYSTEM_ONLINE");
            register_this_string(str_trig, &"ZOMBIE_EQUIP_HACKER");




        break;

        case "zm_tomb":
        
            precache_pap(str_trig);
            precache_no_base_perks(str_trig);

            register_this_string(str_trig, &"ZM_TOMB_ZCIP");
            register_this_string(str_trig, &"ZM_TOMB_CAP", 200);
            register_this_string(str_trig, &"ZM_TOMB_CAP", 400);
            register_this_string(str_trig, &"ZM_TOMB_CAP", 600);
            register_this_string(str_trig, &"ZM_TOMB_CAP", 800);
            register_this_string(str_trig, &"ZM_TOMB_X2D");
            register_this_string(str_trig, &"ZM_TOMB_NS");
            register_this_string(str_trig, &"ZM_TOMB_X2AT", 500);
            register_this_string(str_trig, &"ZM_TOMB_TNKM");
            register_this_string(str_trig, &"ZM_TOMB_TNKC");
            register_this_string(str_trig, &"ZM_TOMB_X2CT", 500);
            register_this_string(str_trig, &"ZM_TOMB_TNKC");

        break;

        default:

            precache_pap(str_trig);
            precache_no_base_perks(str_trig);
            precache_custom_maps_perks(str_trig);

        break;

    }

    //ZoD register_this_string(str_trig, &"ZOMBIE_PERK_WIDOWSWINE", 4000);

    str_trig delete();

    //level.players[0] iPrintLnBold("precache finished");

}

function precache_general(str_trig){

    register_this_string(str_trig, &"HINT_NOICON");
    register_this_string(str_trig, &"ZOMBIE_NEED_POWER");
    register_this_string(str_trig, &"ZOMBIE_NEED_LOCAL_POWER");
    register_this_string(str_trig, &"ZOMBIE_DOOR_ACTIVATE_COUNTER");
    register_this_string(str_trig, &"ZOMBIE_ELECTRIC_SWITCH");
    register_this_string(str_trig, &"ZOMBIE_ELECTRIC_SWITCH_OFF");
    register_this_string(str_trig, &"ZOMBIE_NAVCARD_PICKUP");
    register_this_string(str_trig, &"GENERIC_PICKUP");
    register_this_string(str_trig, &"ZOMBIE_BUTTON_TO_REVIVE_PLAYER");

    register_this_string(str_trig, &"ZOMBIE_BUILD_PIECE_ONLY_ONE");
    register_this_string(str_trig, &"ZOMBIE_BUILD_PIECE_HAVE_ONE");
    register_this_string(str_trig, &"ZOMBIE_GO_TO_THE_BOX_LIMITED");
    register_this_string(str_trig, &"ZOMBIE_GO_TO_THE_BOX");
    register_this_string(str_trig, &"ZOMBIE_BUILD_PIECE_MORE");
    register_this_string(str_trig, &"ZOMBIE_BUILD_PIECE_WRONG");
    register_this_string(str_trig, &"ZOMBIE_CRAFTABLE_CHANGE_BUILD");
    register_this_string(str_trig, &"ZOMBIE_BUILDING");


}

function precache_base_perks(str_trig){

    register_this_string(str_trig, &"ZOMBIE_PERK_ADDITIONALPRIMARYWEAPON", 4000);
    register_this_string(str_trig, &"ZOMBIE_PERK_DOUBLETAP", 2000);
    register_this_string(str_trig, &"ZOMBIE_PERK_FASTRELOAD", 3000);
    register_this_string(str_trig, &"ZOMBIE_PERK_JUGGERNAUT", 2500);
    register_this_string(str_trig, &"ZOMBIE_PERK_MARATHON", 2000);
    register_this_string(str_trig, &"ZOMBIE_PERK_QUICKREVIVE", 1500);
    register_this_string(str_trig, &"ZOMBIE_PERK_QUICKREVIVE", 500);

}

function precache_no_base_perks(str_trig){

    register_this_string(str_trig, &"ZOMBIE_PERK_DEADSHOT", 1500);
    register_this_string(str_trig, &"ZOMBIE_PERK_WIDOWSWINE", 10);
    register_this_string(str_trig, &"ZOMBIE_PERK_WIDOWSWINE", 4000);

}

function precache_factory_base_perks(str_trig){

    register_this_string(str_trig, &"ZOMBIE_PERK_DEADSHOT", 1500);

}

function precache_zod_base_perks(str_trig){

    register_this_string(str_trig, &"ZOMBIE_PERK_WIDOWSWINE", 4000);

}

function precache_custom_maps_perks(str_trig){

    register_this_string(str_trig, &"ZOMBIE_PERK_CHUGABUD", 2000);
    register_this_string(str_trig, &"ZOMBIE_PERK_DIVETONUKE", 2000);
    register_this_string(str_trig, &"ZOMBIE_PERK_TOMBSTONE", 2000);
    register_this_string(str_trig, &"ZOMBIE_PERK_VULTURE", 3000);

}

function precache_pap(str_trig){

    register_this_string(str_trig, &"ZOMBIE_PERK_PACKAPUNCH", 5000);
    register_this_string(str_trig, &"ZOMBIE_PERK_PACKAPUNCH_AAT", 2500);
    register_this_string(str_trig, &"ZOMBIE_GET_UPGRADED_FILL");

    register_this_string(str_trig, &"ZOMBIE_PERK_PACKAPUNCH", 5000);
    register_this_string(str_trig, &"ZOMBIE_PERK_PACKAPUNCH_AAT", 2500);
    register_this_string(str_trig, &"ZOMBIE_PERK_PACKAPUNCH_AAT", 500);


}

function register_this_string(trig, string, insert = undefined)
{
    if(!isDefined(insert)) trig SetHintString(string);
    else trig SetHintString(string, insert);

    wait 0.5; // Just so we don't register all strings at once
}