function random_pandora_box_start(){

    while(!isDefined(level.start_chest_name)) wait GAMETICK;
    level.random_pandora_box_start = 0;

    switch(level.script){

        case "zm_zod":
            level.start_chest_name = "canal_chest";
        break;

        case "zm_factory":
            level.start_chest_name = "chest_3";
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