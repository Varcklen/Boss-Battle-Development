scope WyrmStart initializer init

	globals
		private integer START_DELAY = 10 	
	endglobals

	private function condition takes nothing returns boolean
	    return GetUnitTypeId(GetEnteringUnit()) == 'o00M'
	endfunction

	private function WyrmAwake takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit boss = LoadUnitHandle( udg_hash, id, StringHash( "wyrm_start_dealy_boss" ) )
	
	    if IsUnitAliveBJ(boss) and udg_fightmod[0] then
	        set udg_DamageEventTarget = boss 
	        call TriggerExecute( gg_trg_Wyrm1 )
	        call TriggerExecute( trig_Wyrm5 )
	    endif
	    call FlushChildHashtable( udg_hash, id )
	    set boss = null
	endfunction
	
	private function action takes nothing returns nothing
		local unit boss = GetEnteringUnit()
		local integer id = GetHandleId( boss )
		
        if LoadTimerHandle( udg_hash, id, StringHash( "wyrm_start_dealy" ) ) == null then
            call SaveTimerHandle( udg_hash, id, StringHash( "wyrm_start_dealy" ), CreateTimer() )
        endif
        set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "wyrm_start_dealy" ) ) ) 
        call SaveUnitHandle( udg_hash, id, StringHash( "wyrm_start_dealy_boss" ), boss )
        call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( boss ), StringHash( "wyrm_start_dealy" ) ), START_DELAY, false, function WyrmAwake )

	    set boss = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterEnterRectSimple( trig, GetWorldBounds() )
	    call TriggerAddCondition( trig, Condition( function condition ) )
	    call TriggerAddAction( trig, function action )
	endfunction

endscope