scope MaidenE initializer init

	globals
		private constant integer ABILITY_ID = 'A16N'
		
		private constant real HEAL_FACTOR_INITIAL = 0.45
		private constant real HEAL_FACTOR_PER_LEVEL = 0.15
		
		private constant real DURATION_INITIAL = 1
		private constant real DURATION_PER_LEVEL = 1
		private constant integer EFFECT_ID = 'A16P'
		private constant integer BUFF_ID = 'B07C'
	endglobals

	private function condition takes nothing returns boolean
	    return GetUnitAbilityLevel(udg_DamageEventSource, ABILITY_ID) > 0
	endfunction
	
	private function AllyAffect takes unit caster, unit target, integer level returns nothing
		local real healFactor = HEAL_FACTOR_INITIAL + HEAL_FACTOR_PER_LEVEL * level
	
		set udg_DamageEventAmount = 0
		call healst( caster, target, udg_DamageEventAmount * healFactor )
	endfunction
	
	private function EnemyAffect takes unit caster, unit target, integer level returns nothing
		local real duration = DURATION_INITIAL + DURATION_PER_LEVEL * level
		
		set duration = timebonus(caster, duration)
		
		call bufallst( caster, target, EFFECT_ID, 0, 0, 0, 0, BUFF_ID, "mdne", duration )
	endfunction
	
	private function action takes nothing returns nothing
	    local unit caster = udg_DamageEventSource
	    local unit target = udg_DamageEventTarget
	    local integer level = GetUnitAbilityLevel(caster, ABILITY_ID) 
	    
	    if IsUnitAlly( caster, GetOwningPlayer( target ) ) then
	    	call AllyAffect(caster, target, level)
    	else
    		call EnemyAffect(caster, target, level)
    	endif
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateEventTrigger( "udg_DamageModifierEvent", function action, function condition )
	endfunction

endscope