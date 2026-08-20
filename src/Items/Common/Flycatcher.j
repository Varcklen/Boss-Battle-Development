scope Flycatcher initializer init

	globals
		private constant integer ITEM_ID = 'I0CG'
		
		private constant integer EFFECT_ID = 'A1JH'
		private constant integer BUFF_ID = 'B0B7'
		
		private constant integer VALUE_TO_ADD = 40
		private constant integer STAT_TYPE = STAT_DAMAGE_DEALT
		
		private constant integer DURATION = 7
	endglobals
	
	private function condition takes nothing returns boolean
	    return inv(Event_AfterHeal_Target, ITEM_ID) > 0
	endfunction
	
	private function EndTime takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer( ) )
		local unit target = LoadUnitHandle( udg_hash, id, StringHash( "flycatcher" ) )
		
		if GetUnitAbilityLevel( target, EFFECT_ID) > 0 then
			call StatSystem_Add( target, STAT_TYPE, -VALUE_TO_ADD)
		endif
		call UnitRemoveAbility(target, EFFECT_ID)
		call UnitRemoveAbility(target, BUFF_ID)
		call FlushChildHashtable( udg_hash, id )
		
		set target = null
	endfunction

	private function action takes nothing returns nothing
		local unit target = Event_AfterHeal_Target
		local real duration = timebonus(target, DURATION)
		
		if GetUnitAbilityLevel( target, EFFECT_ID) == 0 then
			call StatSystem_Add( target, STAT_TYPE, VALUE_TO_ADD)
		endif
		call UnitAddAbility(target, EFFECT_ID)
		
		call InvokeTimerWithUnit( target, "flycatcher", duration, false, function EndTime )
		
	    set target = null
	endfunction
	
	//===========================================================================
    private function DeleteBuff_Conditions takes nothing returns boolean
        return GetUnitAbilityLevel( Event_DeleteBuff_Unit, EFFECT_ID) > 0
    endfunction
    
    private function DeleteBuff takes nothing returns nothing
        local unit hero = Event_DeleteBuff_Unit

	    call StatSystem_Add( hero, STAT_TYPE, -VALUE_TO_ADD)
		call UnitRemoveAbility(hero, EFFECT_ID)
		call UnitRemoveAbility(hero, BUFF_ID)

        set hero = null
    endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateEventTrigger("Event_AfterHeal_Real", function action, function condition )
	    call CreateEventTrigger( "Event_DeleteBuff_Real", function DeleteBuff, function DeleteBuff_Conditions )
	endfunction

endscope