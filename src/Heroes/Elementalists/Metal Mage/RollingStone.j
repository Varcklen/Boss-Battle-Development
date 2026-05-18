scope RollingStone initializer init

	globals
		private constant integer ABILITY_ID = 'A0KZ'
		
		private constant integer EFFECT_ID = 'A1HX'
		private constant integer BUFF_ID = 'B0B0'
		
		private constant real DURATION = 10
		private constant integer SP_GAIN = 100
	endglobals

	private function condition takes nothing returns boolean
	    return GetSpellAbilityId() == ABILITY_ID
	endfunction
	
	private function RemoveEffect takes unit caster returns nothing
		local integer idUnit = GetHandleId( caster )
		local integer value = LoadInteger( udg_hash, idUnit, StringHash( "rolling_stone_value" ) )
	
		call spdst( caster, -value )
        call UnitRemoveAbility( caster, EFFECT_ID )
        call UnitRemoveAbility( caster, BUFF_ID )
    	//call SaveBoolean( udg_hash, idUnit, StringHash( "rolling_stone_active" ), false )
        call RemoveSavedReal( udg_hash, idUnit, StringHash( "rolling_stone_value" ) )
	endfunction
	
	private function BuffEnd takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "rolling_stone" ) )

	    if GetUnitAbilityLevel( caster, EFFECT_ID) > 0 then
	        call RemoveEffect(caster)
	    endif
	    call FlushChildHashtable( udg_hash, id )
	    
	    set caster = null
	endfunction
	
	private function action takes nothing returns nothing
	    local integer id 
	    local unit caster
	    local real t
	    
	    if CastLogic() then
	        set caster = udg_Caster
	        set t = udg_Time
	    elseif RandomLogic() then
	        set caster = udg_Caster
	        call textst( udg_string[0] + GetObjectName(ABILITY_ID), caster, 64, 90, 10, 1.5 )
	        set t = DURATION
	    else
	        set caster = GetSpellAbilityUnit()
	        set t = DURATION
	    endif
	    set t = timebonus(caster, t)
	
	    if GetUnitAbilityLevel( caster, EFFECT_ID) == 0 then
	        call spdst( caster, SP_GAIN )
	        call UnitAddAbility( caster, EFFECT_ID)
	        
	        call InvokeTimerWithUnit( caster, "rolling_stone", t, false, function BuffEnd )
	        call SaveInteger( udg_hash, GetHandleId(caster), StringHash( "rolling_stone_value" ), SP_GAIN )
	    endif
	    
	    set caster = null
	endfunction
	
	//===========================================================================
	
	private function ActiveCast_Condition takes nothing returns boolean
	    return GetSpellAbilityId() != ABILITY_ID and GetUnitAbilityLevel( GetSpellAbilityUnit(), EFFECT_ID) > 0
	endfunction
	
	private function RemoveDelay takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "rolling_stone_delay" ) )
	    
	    if GetUnitAbilityLevel( caster, EFFECT_ID) > 0 then
	        call RemoveEffect(caster)
	    endif
	    call FlushChildHashtable( udg_hash, id )
	    
	    set caster = null
	endfunction
	
	private function ActiveCast takes nothing returns nothing
		call InvokeTimerWithUnit( GetSpellAbilityUnit(), "rolling_stone_delay", 0.04, false, function RemoveDelay )
	endfunction
	
	//===========================================================================
	private function DeleteBuff_Conditions takes nothing returns boolean
        return GetUnitAbilityLevel( Event_DeleteBuff_Unit, EFFECT_ID) > 0
    endfunction
    
    private function DeleteBuff takes nothing returns nothing
        call RemoveEffect(Event_DeleteBuff_Unit)
    endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function ActiveCast, function ActiveCast_Condition )
	    call CreateEventTrigger( "Event_DeleteBuff_Real", function DeleteBuff, function DeleteBuff_Conditions )
	endfunction
	
endscope