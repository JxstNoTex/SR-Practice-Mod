function debug_hud()
{
	level endon("end_game");
	self endon("disconnect");

    //Waits for the match to begin
    level flag::wait_till("start_zombie_round_logic");
	wait 5.5;

	if(!isdefined(self.detoured_registers)){

		self.detoured_registers = newClientHudElem(self);
		self.detoured_registers init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^6Det Reg number: ^5");

        level.height = level.height+15;
		self.detoured_registers.alpha = 1;

        self thread detoured_registers_counter();
	}

    if(!isdefined(self.detoured_name)){

		self.detoured_name = newClientHudElem(self);
		self.detoured_name init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^6Det Reg name: ^5");

        level.height = level.height+15;
		self.detoured_name.alpha = 1;

        self thread detoured_registers_name();
	}


    if(!isdefined(self.lazy_detoured_registers)){

		self.lazy_detoured_registers = newClientHudElem(self);
		self.lazy_detoured_registers init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^6Lazy Det Reg number: ^5");

        level.height = level.height+15;
		self.lazy_detoured_registers.alpha = 1;

        self thread lazy_detoured_registers_counter();
	}

    if(!isdefined(self.lazy_detoured_name)){

		self.lazy_detoured_name = newClientHudElem(self);
		self.lazy_detoured_name init_hudelem("left", "top", "user_left", "user_top", 10, level.height, 1.5, 0, (1,1,1), 1, &"^6Lazy Det Reg name: ^5");

        level.height = level.height+15;
		self.lazy_detoured_name.alpha = 1;

        //self thread lazy_detoured_registers_name();
	}

}


function detoured_registers_counter(){

    level endon("end_game");
	self endon("disconnect");

    self.detoured_registers setValue( (level.detoured_strings.size -1) );
    self.det_reg = level.detoured_strings.size -1;

    while(true){
        wait level.tick;

        if(self attackButtonPressed() && self useButtonPressed()){
            self.det_reg++;
            if(self.det_reg >= level.detoured_strings.size) self.det_reg = 0;
            wait 0.2;
        }

        if(self adsButtonPressed() && self useButtonPressed()){
            self.det_reg--;
            if(self.det_reg < 0) self.det_reg = level.detoured_strings.size -1;
            wait 0.2;
        }       

        self.detoured_registers setValue( self.det_reg );
    }
}

function detoured_registers_name(){

    level endon("end_game");
	self endon("disconnect");

    while(true){
        wait level.tick;
        self.detoured_name setText(level.detoured_strings[self.det_reg]);
    }
}



function lazy_detoured_registers_counter(){

    level endon("end_game");
	self endon("disconnect");

    self.lazy_detoured_registers setValue( (level.detour_functions.size -1) );
    self.lazy_det_reg = level.detour_functions.size -1;

    while(true){
        wait level.tick;

        if(self attackButtonPressed() && self JumpButtonPressed()){
            self.lazy_det_reg++;
            if(self.lazy_det_reg >= level.detour_functions.size) self.lazy_det_reg = 0;
            self change_lazy_det_regist_name();
            wait 0.2;
        }

        if(self adsButtonPressed() && self JumpButtonPressed()){
            self.lazy_det_reg--;
            if(self.lazy_det_reg < 0) self.lazy_det_reg = level.detour_functions.size -1;
            self change_lazy_det_regist_name();
            wait 0.2;
        }       

        self.lazy_detoured_registers setValue( self.lazy_det_reg );
    }
}

function change_lazy_det_regist_name(){

    counter = 0;
    foreach(name, det in level.detour_functions){
        if(counter == self.lazy_det_reg){
            self.lazy_detoured_name setText(name);
            break;
        }
        counter++;
    }


}