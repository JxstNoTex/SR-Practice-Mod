//Example of serious to change a built in function
/*detour sys::GetAIArchetypeArray(archetype, team)
{
    if(isDefined(team) && team == "axis"){
        team = level.zombie_team;
    }
    if(isdefined(team)){
        return GetAIArchetypeArray(archetype, team);
    }
    return GetAIArchetypeArray(archetype);

}
*/