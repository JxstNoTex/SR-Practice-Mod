function showEndTimes(){

    //Crea el array para los datos
    if(!isdefined(world.end_times) ) world.end_times = [];
    if(!isdefined(world.end_times[level.script])) level register_round_end_times();

    level waittill( "all_players_connected" );

    if(!isdefined(level.round_ends)){

        //level thread debug_message("Creando round ends");

	    level.round_ends = newHudElem();

        level.round_ends init_hudelem("left", "top", "user_left", "user_top", /*Coordenadas*/10, 400, 1.5, 0, (1,1,1), 1, &"Round End: ");
	    level.round_ends.alpha = 1;

        level thread change_end_times();
    }

    //level thread debug_message("Round end creado");

}


function register_round_end_times(){

    //level.scripts_array = ["zm_zod", "zm_factory", "zm_castle", "zm_island", "zm_stalingrad", "zm_genesis", "zm_protype", "zm_asylum", "zm_sumpf", "zm_theater", "zm_cosmodrome", "zm_temple", "zm_moon", "zm_tomb"];

    world.end_times[level.script] = [];

        
    for(i=1; i<=4; i++){
        world.end_times[level.script][i] = [];

        switch(i){
		    case 1:
			{
                if(level.script=="zm_cosmodrome") world.end_times[level.script][i][1] ="26.23";
                else world.end_times[level.script][i][1] ="19.03";
                world.end_times[level.script][i][2] ="27.53";
                world.end_times[level.script][i][3] ="35.54";
                world.end_times[level.script][i][4] ="43.54";
                world.end_times[level.script][i][5] ="53.54";
                world.end_times[level.script][i][6] ="55.53";
                world.end_times[level.script][i][7] ="54.54";
                world.end_times[level.script][i][8] ="53.54";
                world.end_times[level.script][i][9] ="53.55";
                world.end_times[level.script][i][10] ="56.54";
                world.end_times[level.script][i][11] ="55.55";
                world.end_times[level.script][i][12] ="56.54";
                world.end_times[level.script][i][13] ="58.52";
                world.end_times[level.script][i][14] ="59.55";
                world.end_times[level.script][i][15] ="1:00.54";
		        world.end_times[level.script][i][16] = "1:01.54";
                world.end_times[level.script][i][17] = "1:02.53";
                world.end_times[level.script][i][18] = "1:02.55";
                world.end_times[level.script][i][19] = "1:02.54";
                world.end_times[level.script][i][20] = "1:03.54";
                world.end_times[level.script][i][21] = "1:02.55";
                world.end_times[level.script][i][22] = "1:06.54";
                world.end_times[level.script][i][23] = "1:05.54";
                world.end_times[level.script][i][24] = "1:05.55";
                world.end_times[level.script][i][25] = "1:08.53";
                world.end_times[level.script][i][26] = "1:07.54";
                world.end_times[level.script][i][27] = "1:10.54";
                world.end_times[level.script][i][28] = "1:09.55";
                world.end_times[level.script][i][29] = "1:12.54";
                world.end_times[level.script][i][30] = "1:10.55";              

				break;
			}
			case 2:
			{
				
                if(level.script=="zm_cosmodrome") world.end_times[level.script][i][1] ="28.03";
                else world.end_times[level.script][i][1] ="21.23";
                world.end_times[level.script][i][2] ="25.56";
                world.end_times[level.script][i][3] ="33.55";
                world.end_times[level.script][i][4] ="41.54";
                world.end_times[level.script][i][5] ="47.55";
                world.end_times[level.script][i][6] ="50.54";
                world.end_times[level.script][i][7] ="50.55";
                world.end_times[level.script][i][8] ="50.54";
                world.end_times[level.script][i][9] ="49.55";
                world.end_times[level.script][i][10] ="56.55";
                world.end_times[level.script][i][11] ="57.55";
                world.end_times[level.script][i][12] ="58.57";
                world.end_times[level.script][i][13] ="1:00.53";
                world.end_times[level.script][i][14] ="1:02.54";
                world.end_times[level.script][i][15] ="1:06.56";
		        world.end_times[level.script][i][16] = "1:08.55";
                world.end_times[level.script][i][17] = "1:09.55";
                world.end_times[level.script][i][18] = "1:14.56";
                world.end_times[level.script][i][19] = "1:14.52";
                world.end_times[level.script][i][20] = "1:15.55";
                world.end_times[level.script][i][21] = "1:19.55";
                world.end_times[level.script][i][22] = "1:19.54";
                world.end_times[level.script][i][23] = "1:24.55";
                world.end_times[level.script][i][24] = "1:22.55";
                world.end_times[level.script][i][25] = "1:27.56";
                world.end_times[level.script][i][26] = "1:25.53";
                world.end_times[level.script][i][27] = "1:30.56";
                world.end_times[level.script][i][28] = "1:35.54";
                world.end_times[level.script][i][29] = "1:32.56";
                world.end_times[level.script][i][30] = "1:37.55";

                world.end_times[level.script][i][31] ="1:31.55";
                world.end_times[level.script][i][32] ="1:36.55";
                world.end_times[level.script][i][33] ="1:41.55";
                world.end_times[level.script][i][34] ="1:46.55";
                world.end_times[level.script][i][35] ="1:39.55";
                world.end_times[level.script][i][36] ="1:43.55";
		        world.end_times[level.script][i][37] = "1:48.50";
                world.end_times[level.script][i][38] = "1:39.60";
                world.end_times[level.script][i][39] = "1:43.55";
                world.end_times[level.script][i][40] = "1:47.55";
                world.end_times[level.script][i][41] = "1:52.55";
                world.end_times[level.script][i][42] = "1:56.55";
                world.end_times[level.script][i][43] = "1:43.55";
                world.end_times[level.script][i][44] = "1:47.55";
                world.end_times[level.script][i][45] = "1:51.55";
                world.end_times[level.script][i][46] = "1:55.55";
                world.end_times[level.script][i][47] = "2:00.55";
                world.end_times[level.script][i][48] = "2:04.55";
                world.end_times[level.script][i][49] = "2:08.55";
                world.end_times[level.script][i][50] = "1:49.55";

                world.end_times[level.script][i][51] ="1:53.55";
                world.end_times[level.script][i][52] ="1:57.55";
                world.end_times[level.script][i][53] ="2:01.50";
                world.end_times[level.script][i][54] ="2:04.60";
                world.end_times[level.script][i][55] ="2:09.55";
                world.end_times[level.script][i][56] ="2:13.55";
		        world.end_times[level.script][i][57] = "2:17.50";
                world.end_times[level.script][i][58] = "2:21.60";
                world.end_times[level.script][i][59] = "2:25.55";
                world.end_times[level.script][i][60] = "2:30.55";
                world.end_times[level.script][i][61] = "2:34.55";
                world.end_times[level.script][i][62] = "2:39.55";
                world.end_times[level.script][i][63] = "2:43.55";
                world.end_times[level.script][i][64] = "2:48.55";
                world.end_times[level.script][i][65] = "2:53.55";
                world.end_times[level.script][i][66] = "2:58.55";
                world.end_times[level.script][i][67] = "3:03.55";
                world.end_times[level.script][i][68] = "3:08.55";
                world.end_times[level.script][i][69] = "3:12.55";
                world.end_times[level.script][i][70] = "3:18.55";

				break;
			}
			case 3:
			{
                if(level.script=="zm_cosmodrome") world.end_times[level.script][i][1] ="32.82";
                else world.end_times[level.script][i][1] ="25.22";
                world.end_times[level.script][i][2] ="21.54";
                world.end_times[level.script][i][3] ="28.54";
                world.end_times[level.script][i][4] ="33.55";
                world.end_times[level.script][i][5] ="38.55";
                world.end_times[level.script][i][6] ="42.54";
                world.end_times[level.script][i][7] ="42.56";
                world.end_times[level.script][i][8] ="42.53";
                world.end_times[level.script][i][9] ="44.57";
                world.end_times[level.script][i][10] ="51.54";
                world.end_times[level.script][i][11] ="56.54";
                world.end_times[level.script][i][12] ="57.56";
                world.end_times[level.script][i][13] ="1:03.55";
                world.end_times[level.script][i][14] ="1:04.53";
                world.end_times[level.script][i][15] ="1:10.54";
		        world.end_times[level.script][i][16] = "1:11.55";
                world.end_times[level.script][i][17] = "1:17.55";
                world.end_times[level.script][i][18] = "1:16.54";
                world.end_times[level.script][i][19] = "1:22.55";
                world.end_times[level.script][i][20] = "1:28.55";
                world.end_times[level.script][i][21] = "1:26.55";
                world.end_times[level.script][i][22] = "1:32.54";
                world.end_times[level.script][i][23] = "1:39.56";
                world.end_times[level.script][i][24] = "1:34.54";
                world.end_times[level.script][i][25] = "1:41.54";
                world.end_times[level.script][i][26] = "1:47.55";
                world.end_times[level.script][i][27] = "1:54.54";
                world.end_times[level.script][i][28] = "1:46.55";
                world.end_times[level.script][i][29] = "1:52.55";
                world.end_times[level.script][i][30] = "1:58.56";

                world.end_times[level.script][i][31] ="2:05.55";
                world.end_times[level.script][i][32] ="2:12.55";
                world.end_times[level.script][i][33] ="1:58.55";
                world.end_times[level.script][i][34] ="2:04.55";
                world.end_times[level.script][i][35] ="2:11.55";
                world.end_times[level.script][i][36] ="2:17.55";
		        world.end_times[level.script][i][37] = "2:24.55";
                world.end_times[level.script][i][38] = "2:31.55";
                world.end_times[level.script][i][39] = "2:38.55";
                world.end_times[level.script][i][40] = "2:15.55";
                world.end_times[level.script][i][41] = "2:21.55";
                world.end_times[level.script][i][42] = "2:27.55";
                world.end_times[level.script][i][43] = "2:33.55";
                world.end_times[level.script][i][44] = "2:40.55";
                world.end_times[level.script][i][45] = "2:46.55";
                world.end_times[level.script][i][46] = "2:53.55";
                world.end_times[level.script][i][47] = "3:00.50";
                world.end_times[level.script][i][48] = "3:07.60";
                world.end_times[level.script][i][49] = "3:14.55";

				break;
			}
			case 4:
			{
                if(level.script=="zm_cosmodrome") world.end_times[level.script][i][1] ="34.06";
                else world.end_times[level.script][i][1] ="27.06";
                world.end_times[level.script][i][2] ="21.54";
                world.end_times[level.script][i][3] ="27.53";
                world.end_times[level.script][i][4] ="31.54";
                world.end_times[level.script][i][5] ="36.54";
                world.end_times[level.script][i][6] ="39.54";
                world.end_times[level.script][i][7] ="42.54";
                world.end_times[level.script][i][8] ="41.54";
                world.end_times[level.script][i][9] ="43.55";
                world.end_times[level.script][i][10] ="51.55";
                world.end_times[level.script][i][11] ="57.53";
                world.end_times[level.script][i][12] ="1:03.55";
                world.end_times[level.script][i][13] ="1:04.54";
                world.end_times[level.script][i][14] ="1:11.54";

                world.end_times[level.script][i][15] ="1:18.55";
		        world.end_times[level.script][i][16] = "1:18.54";
                world.end_times[level.script][i][17] = "1:25.55";
                world.end_times[level.script][i][18] = "1:32.55";
                world.end_times[level.script][i][19] = "1:29.55";
                world.end_times[level.script][i][20] = "1:37.54";
                world.end_times[level.script][i][21] = "1:45.55";
                world.end_times[level.script][i][22] = "1:53.55";
                world.end_times[level.script][i][23] = "1:46.55";
                world.end_times[level.script][i][24] = "1:54.55";
                world.end_times[level.script][i][25] = "2:02.53";
                world.end_times[level.script][i][26] = "2:11.56";
                world.end_times[level.script][i][27] = "2:19.55";
                world.end_times[level.script][i][28] = "2:06.55";
                world.end_times[level.script][i][29] = "2:14.54";
                world.end_times[level.script][i][30] = "2:22.50";

                world.end_times[level.script][i][31] ="2:30.60";
                world.end_times[level.script][i][32] ="2:39.55";
                world.end_times[level.script][i][33] ="2:48.55";
                world.end_times[level.script][i][34] ="2:25.55";
                world.end_times[level.script][i][35] ="2:33.55";
                world.end_times[level.script][i][36] ="2:40.55";
		        world.end_times[level.script][i][37] = "2:48.55";
                world.end_times[level.script][i][38] = "2:57.55";
                world.end_times[level.script][i][39] = "3:05.55";
                world.end_times[level.script][i][40] = "3:14.50";
                world.end_times[level.script][i][41] = "3:23.60";
                world.end_times[level.script][i][42] = "3:32.55";
                world.end_times[level.script][i][43] = "3:41.55";
                world.end_times[level.script][i][44] = "3:51.55";
                world.end_times[level.script][i][45] = "4:01.50";
                world.end_times[level.script][i][46] = "4:11.60";
                world.end_times[level.script][i][47] = "4:21.55";
                world.end_times[level.script][i][48] = "4:32.55";
                world.end_times[level.script][i][49] = "4:42.55";

				break;
			}
		}

    }

}


function change_end_times(){

    level endon("end_game");

    while(level.round_number < 1){
        //level thread debug_message("Esperando a la Ronda 1");
        wait 0.05;
    }

    level.round_ends setText(world.end_times[level.script][level.players.size][level.round_number]);

    while( isDefined(world.end_times[level.script][level.players.size][level.round_number+1]) ){
        wait level.tick;
        //level thread debug_message("Esperando a que acabe la ronda...");
        level waittill("end_of_round");
        level.round_ends setText(world.end_times[level.script][level.players.size][level.round_number+1]);

        //level thread say_round_time();

        //if(!((level.round_number+1)%5)){
            level thread say_round_time();
            //level thread debug_message("Multiplo de 5");
        //}
        //level thread debug_message("Terminada la ronda "+level.round_number);
    }


    //level thread debug_message("No mas rondas en timer");
    level.round_ends.alpha = 0;

}

function say_round_time(){

    if(!isdefined(level.round_time)){

	    level.round_time = newHudElem();

        level.round_time init_hudelem("left", "top", "user_left", "user_top", /*Coordenadas*/600, 450, /*fontscale*/2, 0, (1,1,1), 1, &"Round ");
    }

    //level thread debug_message("Creando round ends");
    level.round_time calculate_round_time(level.ticks);

    level.round_time FadeOverTime(2);
    level.round_time.alpha = 1;

    wait 4;

    level.round_time FadeOverTime(5);
    level.round_time.alpha = 0;
}