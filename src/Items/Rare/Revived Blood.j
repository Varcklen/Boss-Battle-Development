scope RevivedBlood initializer init

	globals
		private integer ABILITY_ID = 'A126'
		private integer EFFECT_ID = 'A128'
		private integer BUFF_ID = 'B05R'
		private real DAMAGE_MULTIPLIER = 5
		private real HEAL_MULTIPLIER = 0.5
	endglobals

	private function condition takes nothing returns boolean
	    return GetSpellAbilityId() == ABILITY_ID
	endfunction
	
	private function action takes nothing returns nothing
	    local unit caster
	    
	    if CastLogic() then
	        set caster = udg_Caster
	    elseif RandomLogic() then
	        set caster = udg_Caster
	        call textst( udg_string[0] + GetObjectName(ABILITY_ID), caster, 64, 90, 10, 1.5 )
	    else
	        set caster = GetSpellAbilityUnit()
	    endif
	    
	    call eyest( caster ) 
	    call UnitAddAbility( caster, EFFECT_ID )
	    
	    set caster = null
	endfunction
            
    //===========================================================================
	private function OnDamageCheck_Condition takes nothing returns boolean
	    return GetUnitAbilityLevel( udg_DamageEventSource, BUFF_ID) > 0 and udg_IsDamageSpell == false
	endfunction

	private function OnDamageCheck takes nothing returns nothing
		set udg_DamageEventAmount = udg_DamageEventAmount + Event_OnDamageChange_StaticDamage * DAMAGE_MULTIPLIER
		call healst(udg_DamageEventSource, null, HEAL_MULTIPLIER * udg_DamageEventAmount )

        call UnitRemoveAbility( udg_DamageEventSource, EFFECT_ID )
        call UnitRemoveAbility( udg_DamageEventSource, BUFF_ID )
	endfunction
            
    //===========================================================================
    private function DeleteBuff_Conditions takes nothing returns boolean
        return GetUnitAbilityLevel( Event_DeleteBuff_Unit, EFFECT_ID) > 0
    endfunction
    
    private function DeleteBuff takes nothing returns nothing
        call UnitRemoveAbility( Event_DeleteBuff_Unit, EFFECT_ID )
        call UnitRemoveAbility( Event_DeleteBuff_Unit, BUFF_ID )
    endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
	    
	    call CreateEventTrigger( "Event_DeleteBuff_Real", function DeleteBuff, function DeleteBuff_Conditions )
	    call CreateEventTrigger( "Event_OnDamageChange_Real", function OnDamageCheck, function OnDamageCheck_Condition )
	endfunction

endscope