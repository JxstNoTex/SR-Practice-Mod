function game_time(){

    level endon("end_game");

	//level.tick = 0.05;
	level.ticks = 0;

	level flag::wait_till("start_zombie_round_logic");
	wait 2.5;

	while(true){
		wait level.tick;
		level.ticks++;
	}
}

function calculate_time(ticks){

    time = ticks*level.tick;
    //time = (10*3600)+(59*60)+59.95; //uncoment to test a custom time

    text = "";
    ms = int(time*100)%100;
    s = int(time-(ms/100));

    h = int(s/3600);
    if(h>0) s = s - (3600*h);

    min = int(s/60);
    if(min>0) s = s - (60*min);

    hours = 0;

    if(h>0){
        hours = 1;
        text = text+h+":";
    }

    if(hours && min<10) text = text+"0"+min+":";
    else if(hours && min>=10) text = text+min+":";
    else if(!hours && min<10) text = text+"0"+min+":";
    else text = text+min+":";

    if(s<10) text = text+"0"+s+".";
    else text = text+s+".";

    text = text+ms+" ms";
    self setText(text);
}

function calculate_split(ticks){

    time = ticks*level.tick;
    //time = (10*3600)+(59*60)+59.95; //uncoment to test a custom time

    text = "^2";
    ms = int(time*100)%100;
    s = int(time-(ms/100));

    h = int(s/3600);
    if(h>0) s = int(s - (3600*h));

    min = int(s/60);
    if(min>0) s = int(s - (60*min));


    hours = 0;

    if(h>0){
        hours = 1;
        text = text+h+":";
    }

    if(hours && min<10) text = text+"0"+min+":";
    else if(hours && min>=10) text = text+min+":";
    else if(!hours && min<10) text = text+"0"+min+":";
    else text = text+min+":";

    if(s<10) text = text+"0"+s+".";
    else text = text+s+".";


    text = text+ms;
    self setText(text);
    self.alpha = 1;
}

function init_hudelem(alignx, aligny, horzalign, vertalign, x, y, fontscale, alpha, color, hidewheninmenu, label){

    self.alignx = alignx;
	self.aligny = aligny;
	self.horzalign = horzalign;
	self.vertalign = vertalign;
	self.x = x;
	self.y = y;
	self.fontscale = fontscale;
	self.alpha = alpha;
	self.color = color;
	self.hidewheninmenu = hidewheninmenu;
	self.label = label;

}

function round_end_reset(){

    level endon("end_game");

    while(true){
        wait level.tick;

		level waittill("end_of_round");
		self setTenthsTimerUp(0.01);
    }

}

function calculate_round_time(ticks){

    time = ticks*level.tick;
    //time = (10*3600)+(59*60)+59.95; //uncoment to test a custom time

    text = "";

    //level.players[0] iPrintLnBold(text+1);

    text = "^5"+(level.round_number+1)+"^7 in: ^1";
    //level.players[0] iPrintLnBold(text+2);
    ms = int(time*100)%100;
    s = int(time-(ms/100));

    h = int(s/3600);
    if(h>0) s = int(s - (3600*h));

    min = int(s/60);
    if(min>0) s = int(s - (60*min));


    hours = 0;

    if(h>0){
        hours = 1;
        text = text+h+":";
    }

    //level.players[0] iPrintLnBold(text+3);

    if(hours && min<10) text = text+"0"+min+":";
    else if(hours && min>=10) text = text+min+":";
    else if(!hours && min<10) text = text+"0"+min+":";
    else text = text+min+":";

    //level.players[0] iPrintLnBold(text+4);

    if(s<10) text = text+"0"+s+".";
    else text = text+s+".";


    //level.players[0] iPrintLnBold(text+5);

    text = text+ms;
    self setText(text);

    //level.players[0] iPrintLnBold(text+6);
}