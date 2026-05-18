scope NinjaE initializer init

	globals
		private constant integer CHANCE_INITIAL = 5
		private constant integer CHANCE_PER_LEVEL = 3
	endglobals

	private function condition takes nothing returns boolean
		local integer level = GetUnitAbilityLevel(udg_DamageEventSource, 'A0JV')
	    return level > 0 and LuckChance(udg_DamageEventSource, CHANCE_PER_LEVEL * level + CHANCE_INITIAL )
	endfunction
	
	private function action takes nothing returns nothing
	    set udg_DamageEventType = udg_DamageTypeCriticalStrike
        set udg_DamageEventAmount = udg_DamageEventAmount + (0.75*udg_DamageEventAmount)
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterVariableEvent( trig, "udg_DamageModifierEvent", EQUAL, 1.00 )
	    call TriggerAddCondition( trig, Condition( function condition ) )
	    call TriggerAddAction( trig, function action )
	    set trig = null
	endfunction

endscope