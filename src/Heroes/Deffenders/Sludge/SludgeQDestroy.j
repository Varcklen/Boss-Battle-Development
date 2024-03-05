library SludgeQDestroy initializer init

	private function ClearStats takes unit sludgeMinion, boolean isRemoved returns nothing
		local integer id = GetHandleId(sludgeMinion)
        local unit owner = LoadUnitHandle( udg_hash, id, StringHash( "sldg" ) )
        local integer maxMinionHp = BlzGetUnitMaxHP( sludgeMinion )
        //call BJDebugMsg("sludgeMinion: " + GetUnitName(sludgeMinion))
        //call BJDebugMsg("owner: " + GetUnitName(owner))
        if owner != null then
        	//call BJDebugMsg("Add")
            call BlzSetUnitMaxHP( owner, BlzGetUnitMaxHP( owner ) + maxMinionHp )
            call BlzSetUnitBaseDamage( owner, BlzGetUnitBaseDamage( owner, 0 ) + BlzGetUnitBaseDamage( sludgeMinion, 0 ) + 1, 0 )
            if isRemoved then
            	call SetUnitState( owner, UNIT_STATE_LIFE, GetUnitState( owner, UNIT_STATE_LIFE) + maxMinionHp )
        	endif
            //call RemoveSavedHandle( udg_hash, id, StringHash( "sldg" ) )
        endif
        set owner = null
    endfunction
	
	private function OnRemoveUnit takes unit u returns nothing
		//call BJDebugMsg("u: " + GetUnitName(u))
    	if GetUnitTypeId(u) == 'u00X' then
    		call ClearStats(u, true)
		endif
    endfunction
    
    private function OnDeath takes nothing returns nothing
    	if GetUnitTypeId(GetDyingUnit()) == 'u00X' then
    		call ClearStats(GetDyingUnit(), false)
		endif
    endfunction
    
    hook RemoveUnit OnRemoveUnit
    
    private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_DEATH )
	    call TriggerAddAction( trig, function OnDeath )
	    
	    set trig = null
	endfunction

endlibrary