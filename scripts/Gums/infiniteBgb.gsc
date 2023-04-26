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

    while(!IsArray(self.bgb_stats)) wait level.tick;

    if(isDefined(self.bgb_stats)) self.bgb_stats = level.void_array;

}