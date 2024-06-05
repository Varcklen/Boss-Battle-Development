scope RandomEncounters initializer init

	globals
		private constant integer SPAWN_CHANCE = 55
	endglobals

	private function condition takes nothing returns boolean
        return AnyHasLvL(8) and udg_fightmod[3] == false and SPAWN_CHANCE >= GetRandomInt( 1, 100 )
    endfunction
    
    private function action takes nothing returns nothing
    	local location spawnLoc = null
    	local RandomEncounter randomEncounter

        set randomEncounter = RandomEncounterDatabase_GetRandom(AnyHasLvL(11))
        set spawnLoc = GetRandomLocInRect(gg_rct_Spawn)
        
        set bj_lastCreatedUnit = CreateUnitAtLoc(randomEncounter.Owner, randomEncounter.TypeId, spawnLoc, 270 )
        call randomEncounter.UseTrigger()
        
        call RemoveLocation(spawnLoc)
        set spawnLoc = null
    endfunction
    
    private function condition_delete takes nothing returns boolean
        return udg_fightmod[3] == false
    endfunction
    
    private function action_delete takes nothing returns nothing
    	local group g = CreateGroup()
    	local unit u

	    call GroupEnumUnitsInRect( g, gg_rct_Vision1, null )
	    loop
	        set u = FirstOfGroup(g)
	        exitwhen u == null
	        if GetUnitAbilityLevel( u, 'A1ES') > 0 then
	            call RemoveUnit( u )
	        endif
	        call GroupRemoveUnit(g,u)
	    endloop
	    
	    call DestroyGroup(g)
	    set g = null
	    set u = null
    endfunction

	private function init takes nothing returns nothing
        call BattleEndGlobal.AddListener(function action, function condition)
        call BetweenGlobal.AddListener(function action_delete, function condition_delete)
    endfunction

endscope