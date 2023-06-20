function free_megas(){

    while(level.bgb.size != 63) wait level.tick;

    foreach(i, bgb in level.bgb){
        if(level.bgb[i].var_35e23ba2 != 1){
            level.bgb[i].var_35e23ba2 = 1;
        }
    }

}

function delete_bgb_uses(){

    if(!isDefined(level.void_array))level.void_array = [];

    while(self.bgb_pack.size !=5) wait level.tick;

    //while(!IsArray(self.bgb_stats)) wait level.tick; 
    while(!isDefined(self.bgb_machine_uses_this_round)) wait GAMETICK;
    /*
        Changing to a new variable because in the old way, if you use 5 mega gums,
        you might get the void array before all of them are added to the stats.
        If you wait for machine uses, thats created right after finishing with stats
        so you make sure all of them are created and then you void it
    */

    if(isDefined(self.bgb_stats)) self.bgb_stats = level.void_array;

}