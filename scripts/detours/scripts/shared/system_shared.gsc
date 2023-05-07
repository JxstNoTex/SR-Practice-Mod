#region example

detour system<scripts\shared\system_shared.gsc>::register(str_system, func_preinit, func_postinit, reqs = [])
{

    if(isDefined(str_system)){
        switch(str_system){

        #region zm_zod

        #endregion

        #region zm_factory

        #endregion

        #region zm_castle
            case "zm_castle_low_grav":
            case "zm_castle_achievements":
            case "zm_castle_teleporter":
        #endregion
            compiler::relinkdetours();
            if(level.debug){
                level thread add_detoured_string(str_system);
            }
            break;
        }
    }

    system::register(str_system, func_preinit, func_postinit, reqs);
}


function add_detoured_string(string){

    if(!isDefined(level.detoured_strings)) level.detoured_strings = [];
    ArrayInsert(level.detoured_strings, string, level.detoured_strings.size);

}



#endregion