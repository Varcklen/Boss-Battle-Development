scope TotemStart initializer init

	globals
		private integer START_DELAY = 3	
		
		public trigger Trigger = null
	endglobals

	private function condition takes nothing returns boolean
	    return GetUnitTypeId(GetEnteringUnit()) == 'o007'
	endfunction

	private function TotemAwake takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit boss = LoadUnitHandle( udg_hash, id, StringHash( "totem_start_delay" ) )
	
	    if IsUnitAliveBJ(boss) and udg_fightmod[0] then
	        set udg_DamageEventTarget = boss 
	        call TriggerExecute( gg_trg_Totem1 )
	        call UnitAddAbility(boss, 'A1G7')
	    endif
	    call FlushChildHashtable( udg_hash, id )
	    set boss = null
	endfunction
	
	private function action takes nothing returns nothing
		call InvokeTimerWithUnit( GetEnteringUnit(), "totem_start_delay", START_DELAY, false, function TotemAwake )
	endfunction
	
	
	//===========================================================================
	private function condition_damage takes nothing returns boolean
	    return udg_DamageEventAmount > 0 and GetUnitTypeId(udg_DamageEventTarget) == 'o007'
	endfunction
	
	private function TotemDamage takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit boss = LoadUnitHandle( udg_hash, id, StringHash( "totem_delay" ) )
	
	    if IsUnitAliveBJ(boss) and udg_fightmod[0] then
	        call UnitAddAbility(boss, 'A1G7')
	    endif
	    call FlushChildHashtable( udg_hash, id )
	    set boss = null
	endfunction
	
	private function action_damage takes nothing returns nothing
	    call UnitRemoveAbility( udg_DamageEventTarget, 'A1G7' )
	    call InvokeTimerWithUnit( udg_DamageEventTarget, "totem_delay", 5, false, function TotemDamage )
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterEnterRectSimple( trig, GetWorldBounds() )
	    call TriggerAddCondition( trig, Condition( function condition ) )
	    call TriggerAddAction( trig, function action )
	    
	    set Trigger = CreateEventTrigger( "udg_AfterDamageEvent", function action_damage, function condition_damage )
	    call DisableTrigger( Trigger )
	    
	    set trig = null
	endfunction

endscope