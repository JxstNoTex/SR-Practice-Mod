#region example

detour system<scripts\shared\system_shared.gsc>::register(str_system, func_preinit, func_postinit, reqs = [])
{
    if(!isDefined(level.register_numbers))level.register_numbers = 0;

    if(isDefined(str_system)){
        switch(str_system){
            case "zm_castle_low_grav":
            level.register_numbers++;
            compiler::relinkdetours();
            break;
        }
    }

    system::register(str_system, func_preinit, func_postinit, reqs);
}

#endregion