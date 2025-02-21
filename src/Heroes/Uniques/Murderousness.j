scope Murderousness initializer init

	globals
	    private constant integer ATTACK_BONUS = 100
		private constant integer ATTACK_BONUS_UPGRADED = 200
	
		private constant integer ABILITY_ID = 'A1EA'
		private constant integer UPGRADED_ABILITY_ID = 'A1EB'
		
		private constant integer EFFECT_ID = 'A1EC'
		private constant integer BUFF_ID = 'B0AH'
		
	    trigger trig_Murderousness = null
	endglobals
	
	private function condition takes nothing returns boolean
	    return GetSpellAbilityId() == ABILITY_ID or GetSpellAbilityId() == UPGRADED_ABILITY_ID
	endfunction
	
	private function action takes nothing returns nothing
	    local real attackAmount
	    local unit caster
	    local real bonus = 0
	    
	    if CastLogic() then
	        set caster = udg_Caster
	    elseif RandomLogic() then
	        set caster = udg_Caster
	        call textst( udg_string[0] + GetObjectName(ABILITY_ID), caster, 64, 90, 10, 1.5 )
	    else
	        set caster = GetSpellAbilityUnit()
	    endif
	    
	    if IsUniqueUpgraded(caster) then
	        set attackAmount = ATTACK_BONUS_UPGRADED
	    else
	        set attackAmount = ATTACK_BONUS
	    endif
	    if not( udg_fightmod[3] ) and combat( caster, true, GetSpellAbilityId() ) then
	    	set bonus = LoadReal( udg_hash, GetHandleId( caster ), StringHash( "murderousness_attack" ) )
	    endif
	    set attackAmount = attackAmount * GetUnitSpellPower( caster ) * GetUniqueSpellPower( caster ) + bonus
	    
	    call SaveReal( udg_hash, GetHandleId( caster ), StringHash( "murderousness_attack" ), attackAmount )
	    call UnitAddAbility( caster, EFFECT_ID )
	     
	    set caster = null
	endfunction
	
	private function BuffClear takes unit target returns nothing
		call UnitRemoveAbility( target, EFFECT_ID )  
        call UnitRemoveAbility( target, BUFF_ID )
	endfunction
	
    //OnAttackEvent
    private function attack_condition takes nothing returns boolean
        return GetUnitAbilityLevel( udg_DamageEventSource, EFFECT_ID) > 0 and udg_IsDamageSpell == false
    endfunction

    private function attack_action takes nothing returns nothing
        local real bonus = LoadReal( udg_hash, GetHandleId( udg_DamageEventSource ), StringHash( "murderousness_attack" ) )
		call SaveReal( udg_hash, GetHandleId( udg_DamageEventSource ), StringHash( "murderousness_attack" ), 0 )
        set udg_DamageEventAmount = udg_DamageEventAmount + bonus
        call BuffClear(udg_DamageEventSource)
    endfunction
    
    //DeleteBuff
    private function DeleteBuff_Conditions takes nothing returns boolean
        return GetUnitAbilityLevel( Event_DeleteBuff_Unit, EFFECT_ID) > 0
    endfunction
    
    private function DeleteBuff takes nothing returns nothing
        call BuffClear(Event_DeleteBuff_Unit)
    endfunction

	//===========================================================================
    private function init takes nothing returns nothing
    	set trig_Murderousness = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( trig_Murderousness, EVENT_PLAYER_UNIT_SPELL_EFFECT )
	    call TriggerAddCondition( trig_Murderousness, Condition( function condition ) )
	    call TriggerAddAction( trig_Murderousness, function action )
    
        call CreateEventTrigger( "Event_OnDamageChange_Real", function attack_action, function attack_condition )
        call CreateEventTrigger( "Event_DeleteBuff_Real", function DeleteBuff, function DeleteBuff_Conditions )
    endfunction
endscope