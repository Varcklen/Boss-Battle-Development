scope DoctorG initializer init

	globals
		private constant integer ABILITY_ID = 'A04L'
		
		private constant integer HEALTH_TO_GAIN = 75
	endglobals

	private function condition takes nothing returns boolean
	    return GetLearnedSkill() == ABILITY_ID
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = GetLearningUnit()
		
		call BlzSetUnitMaxHP( caster, BlzGetUnitMaxHP(caster) + HEALTH_TO_GAIN )
	    
	    set caster = null
	endfunction
	
	private function condition_null takes nothing returns boolean
	    return GetUnitAbilityLevel( udg_Event_NullingAbility_Unit, ABILITY_ID) > 0
	endfunction
	
	private function action_null takes nothing returns nothing
		local unit caster = udg_Event_NullingAbility_Unit
		local integer level = GetUnitAbilityLevel( caster, ABILITY_ID)
		local integer hpToLose = level * HEALTH_TO_GAIN
		
        call BlzSetUnitMaxHP( caster, BlzGetUnitMaxHP(caster) - hpToLose )
        
        set caster = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    set gg_trg_MinP = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( gg_trg_MinP, EVENT_PLAYER_HERO_SKILL )
	    call TriggerAddCondition( gg_trg_MinP, Condition( function condition ) )
	    call TriggerAddAction( gg_trg_MinP, function action )
	    
	    call CreateEventTrigger( "udg_Event_NullingAbility_Real", function action_null, function condition_null )
	endfunction

endscope