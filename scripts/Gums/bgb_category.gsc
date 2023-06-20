// Thanks Bug of Cake for confirming I only need to separate in 2 categories!
function get_gum_category(){

    // 0 = no gum / classic gyum
    // 1 = mega gum / any%
    //level.is_megas = undefined; // moved to start of main
    
    //while(level.bgb.size != 63) wait level.tick;

    level waittill( "all_players_connected" );

    foreach(player in level.players){
        foreach(gum in player.bgb_pack){
            if(isDefined(level.bgb[gum].consumable) && level.bgb[gum].consumable){
                if(level.debug){
                    text = ""+player.name+" has "+gum;
                    level thread debug_message(text);
                }
                level.is_megas = true;
                return;
            }
        }
    }

    level.is_megas = false;
    if(level.debug_is_megas) level thread debug_message("Game is Classics");

}