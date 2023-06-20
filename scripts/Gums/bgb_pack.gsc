function custom_bgb_pack(){

    // We make sure before hand that we know if its a megas game or classics
    while(!isDefined(level.is_megas)) wait GAMETICK;

    switch(level.script){
        case "zm_zod":

        break;

        case "zm_factory":
            level thread factory_custom_bgb_pack();
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

#region Zod

#endregion

#region Factory

function factory_custom_bgb_pack(){
    if(world.sr_mode == "rounds"){

        //level thread rounds_factory_custom_bgb_pack();
        //if(level.debug_bgb_pack) level thread debug_message("Setting Gums for Rounds SR...");

    }else if(world.sr_mode == "easter_eggs"){

        level thread ee_factory_custom_bgb_pack();
        if(level.debug_bgb_pack) level thread debug_message("Setting Gums for EE SR...");

    }else if(world.sr_mode == "community"){

    }else{
        level thread debug_message("Error, unknown game mode");
        return;
    }

}

function ee_factory_custom_bgb_pack(){
    switch(level.players.size){

        case 1:
        
            //level.players[0].bgb_pack = [];
            level.players[0].bgb_pack_randomized = [];

            if(level.is_megas){
                ArrayInsert(level.players[0].bgb_pack_randomized, "zm_bgb_reign_drops",           level.players[0].bgb_pack_randomized.size);
                ArrayInsert(level.players[0].bgb_pack_randomized, "zm_bgb_ephemeral_enhancement", level.players[0].bgb_pack_randomized.size);
                ArrayInsert(level.players[0].bgb_pack_randomized, "zm_bgb_anywhere_but_here",     level.players[0].bgb_pack_randomized.size);
            }else{
                ArrayInsert(level.players[0].bgb_pack_randomized, "zm_bgb_anywhere_but_here",     level.players[0].bgb_pack_randomized.size);
            }

        break;

        case 2:
        case 3:
        case 4:

            // We check if there is at least 1 player with ephemeral
            ephemeral_player = undefined;
            foreach(player in level.players){
                if(IsInArray(player.bgb_pack, "zm_bgb_ephemeral_enhancement")){
                    ephemeral_player = player;
                    if(level.debug_bgb_pack) level thread debug_message("Ephemeral player found!");
                    break;
                }
            }


            ephemeral_gum = ["zm_bgb_ephemeral_enhancement"];
            points_gums = ["zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit"];
            points_gums = array::randomize(points_gums);
            ArrayInsert(points_gums, "zm_bgb_anywhere_but_here", 1);


            // If we detect a player with ephemeral
            if(isDefined(ephemeral_player)){
                foreach(player in level.players){
                    if(player == ephemeral_player) player thread set_bgb(ephemeral_gum);
                    else player thread set_bgb(points_gums);

                }
            // If we dont detect anyone with ephemeral
            }else{
                foreach(player in level.players){
                    if(player IsHost()) player thread set_bgb(ephemeral_gum);
                    else player thread set_bgb(points_gums);
                }
            }

        break;

        default:
            level thread debug_message("Error, cant get number of players");
        break;
    }

    if(level.debug_bgb_pack) level thread debug_message("Gums set!");

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


function set_bgb(patched_bgb){

    if(!patched_bgb.size){
        
    }

    self.bgb_pack_randomized = [];

    for(i=0; i<patched_bgb.size; i++){
        ArrayInsert(self.bgb_pack_randomized, patched_bgb[i], self.bgb_pack_randomized.size);
    }

}