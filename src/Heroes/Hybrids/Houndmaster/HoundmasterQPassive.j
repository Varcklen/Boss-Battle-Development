scope HoundmasterQPassive initializer init

	globals
		private constant integer ABILITY_ID = 'A105'
		
		private constant integer DAMAGE_INCREASE_INITIAL = 0
		private constant integer DAMAGE_INCREASE_PER_LEVEL = 40
	endglobals

	private function condition takes nothing returns boolean
	    return GetLearnedSkill() == ABILITY_ID
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = GetLearningUnit()
		local integer id = GetHandleId(caster)
		local integer level = GetUnitAbilityLevel( caster, ABILITY_ID)
		local integer damageIncrease = DAMAGE_INCREASE_INITIAL + (DAMAGE_INCREASE_PER_LEVEL * level)
		
		call SaveInteger(udg_hash, id, StringHash("houndmaster_q_damage_increase"), damageIncrease)
		
	    set caster = null
	endfunction
	
	private function condition_null takes nothing returns boolean
	    return GetUnitAbilityLevel( udg_Event_NullingAbility_Unit, ABILITY_ID) > 0
	endfunction
	
	private function action_null takes nothing returns nothing
		local unit caster = udg_Event_NullingAbility_Unit
		
		call RemoveSavedInteger( udg_hash, GetHandleId(caster), StringHash("houndmaster_q_damage_increase") )
        
        set caster = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_HERO_SKILL )
	    call TriggerAddCondition( trig, Condition( function condition ) )
	    call TriggerAddAction( trig, function action )
	    
	    call CreateEventTrigger( "udg_Event_NullingAbility_Real", function action_null, function condition_null )
	endfunction

endscope