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
        key = compiler::getkeys(KEY_A);
        if(key != 0 && key == KEY_A)
        {
            iPrintLnBold(KEY_A + "got pressed!!");
        }
        wait 0.5;
    }

}