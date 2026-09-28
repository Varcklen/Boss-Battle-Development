scope IsaacHead initializer init
	
	globals
		private constant integer ITEM_ID = 'I0F8'
		private constant integer EFFECT_ID = 'A05W'
		private constant integer BUFF_ID = 'B09J'
		private constant integer DURATION = 30

		private constant integer VALUE_1 = 100
		private constant integer VALUE_2 = -50
		private constant integer STAT_TYPE_1 = STAT_DAMAGE_DEALT
		private constant integer STAT_TYPE_2 = STAT_DAMAGE_TAKEN
	endglobals

	private function condition takes nothing returns boolean
		return inv( BattleStart.TriggerUnit, ITEM_ID) > 0
	endfunction
	
	private function DurationEnd takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit target = LoadUnitHandle( udg_hash, id, StringHash( "isaac_head" ) )

	    if GetUnitAbilityLevel( target, EFFECT_ID) > 0 then
    		call StatSystem_Add( target, STAT_TYPE_1, -VALUE_1)
	    	call StatSystem_Add( target, STAT_TYPE_2, -VALUE_2)
	    endif
	    call UnitRemoveAbility( target, EFFECT_ID )
	    call UnitRemoveAbility( target, BUFF_ID )
	    call FlushChildHashtable( udg_hash, id )
	    
	    set target = null
	endfunction
	
	private function action takes nothing returns nothing
		local unit hero = BattleStart.GetDataUnit("caster")
		local real duration = timebonus( hero, DURATION )

		if GetUnitAbilityLevel( hero, EFFECT_ID) == 0 then
		    call StatSystem_Add( hero, STAT_TYPE_1, VALUE_1)
		    call StatSystem_Add( hero, STAT_TYPE_2, VALUE_2)
	    endif
	    
	    call UnitAddAbility( hero, EFFECT_ID )	    
	    call InvokeTimerWithUnit( hero, "isaac_head", duration, false, function DurationEnd )
		
		set hero = null
	endfunction

	//===========================================================================
    private function DeleteBuff_Conditions takes nothing returns boolean
        return GetUnitAbilityLevel( Event_DeleteBuff_Unit, EFFECT_ID) > 0
    endfunction
    
    private function DeleteBuff takes nothing returns nothing
        local unit target = Event_DeleteBuff_Unit

	    if GetUnitAbilityLevel( target, EFFECT_ID) > 0 then
    		call StatSystem_Add( target, STAT_TYPE_1, -VALUE_1)
	    	call StatSystem_Add( target, STAT_TYPE_2, -VALUE_2)
	    endif
	    call UnitRemoveAbility( target, EFFECT_ID )
	    call UnitRemoveAbility( target, BUFF_ID )

        set target = null
    endfunction
	
	//===========================================================================
    private function init takes nothing returns nothing
		call BattleStart.AddListener(function action, function condition)
		call CreateEventTrigger( "Event_DeleteBuff_Real", function DeleteBuff, function DeleteBuff_Conditions )
	endfunction
	
endscope