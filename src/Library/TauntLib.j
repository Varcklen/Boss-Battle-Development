library Taunt requires CommonTimer

	globals
		private constant integer EFFECT_ID = 'A09H'
		private constant integer BUFF_ID = 'B059'
	endglobals

	private function tauntCast takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit u = LoadUnitHandle( udg_hash, id, StringHash( "taunt" ) )
	
	    call UnitRemoveAbility( u,EFFECT_ID )
	    call UnitRemoveAbility( u, BUFF_ID )
	    if BlzIsUnitInvulnerable( u ) == false then
	        call IssueImmediateOrder( u, "stop" )
	    endif
	    call FlushChildHashtable( udg_hash, id )
	
		set u = null
	endfunction
	
	function taunt takes unit caster, unit target, real t returns nothing
	    local integer id = GetHandleId( target )
	    
	    //Taunt Immunity
	    if GetUnitAbilityLevel(target, 'A1JX') > 0 then
	    	return
	    endif
	    
	    call IssueTargetOrder( target, "attack", caster )
        call UnitAddAbility( target, EFFECT_ID )
        call InvokeTimerWithUnit( target, "taunt", t, false, function tauntCast )
	endfunction
	
endlibrary