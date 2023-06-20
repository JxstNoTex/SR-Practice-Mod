function set_custom_special_round(){

    if(level.debug) level thread debug_message("Starting Dog Rounds...");

    switch(level.script){
        case "zm_zod":

        break;

        case "zm_factory":
            while(!isDefined(level.next_dog_round)) wait GAMETICK;
            level thread factory_next_dog_round();
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

function factory_next_dog_round(){

    level flag::wait_till("start_zombie_round_logic");

    switch(level.players.size){
        case 1:
            dog_rounds = [6, 11, 16, 20, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61, 65, 69, 74, 79, 83, 87, 91, 95, 99, 104, 109, 114, 118, 122, 126, 130, 134, 138, 142, 146, 150, 154, 158, 162, 166, 170, 174, 178, 182, 186, 190, 194, 198, 202, 206, 210, 214, 218, 222, 226, 230, 234, 238, 242, 246, 250, 254];
        break;

        case 2:
            dog_rounds = [7, 11, 15, 19, 23, 28, 33, 37, 41, 45, 49, 53, 57, 61, 65, 69, 74, 79, 83, 87, 91, 95, 99, 104, 109, 114, 118, 122, 126, 130, 134, 138, 142, 146, 150, 154, 158, 162, 166, 170, 174, 178, 182, 186, 190, 194, 198, 202, 206, 210, 214, 218, 222, 226, 230, 234, 238, 242, 246, 250, 254];
        break;

        case 3:
            dog_rounds = [7, 11, 15, 19, 23, 27, 32, 37, 41, 45, 49, 53, 57, 61, 65, 69, 74, 79, 83, 87, 91, 95, 99, 104, 109, 114, 118, 122, 126, 130, 134, 138, 142, 146, 150, 154, 158, 162, 166, 170, 174, 178, 182, 186, 190, 194, 198, 202, 206, 210, 214, 218, 222, 226, 230, 234, 238, 242, 246, 250, 254];
        break;

        case 4:
            dog_rounds = [7, 11, 16, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61, 65, 69, 74, 79, 83, 87, 91, 95, 99, 104, 109, 114, 118, 122, 126, 130, 134, 138, 142, 146, 150, 154, 158, 162, 166, 170, 174, 178, 182, 186, 190, 194, 198, 202, 206, 210, 214, 218, 222, 226, 230, 234, 238, 242, 246, 250, 254];
        break;

        default:
            level thread debug_message("Error loading dog rounds");
        break;

    }

    if(!isDefined(dog_rounds)) return;

    for(i=0; i<dog_rounds.size; i++){
        level.next_dog_round = dog_rounds[i];
        if(level.debug) level thread debug_message("Next dog round is "+dog_rounds[i]);
        while(true){
            wait GAMETICK;
            level waittill("end_of_round");
            if(level.round_number >= dog_rounds[i]){
                if(level.debug) level thread debug_message("Setting new dog round...");
                break;
            }
        }

    }

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