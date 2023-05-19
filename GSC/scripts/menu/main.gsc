init()
{
}

on_player_connect()
{
}

on_player_spawned()
{
	self endon("spawned_player");

    while(true)
    {
        self iPrintLnBold("test = " + level.test);
        wait 1;
    }
}