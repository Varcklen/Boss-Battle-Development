scope WolfRush initializer init

	private function condition takes nothing returns boolean
	    return GetUnitAbilityLevel(udg_DamageEventSource, 'A0J8') > 0 and IsUnitType( udg_DamageEventTarget, UNIT_TYPE_ANCIENT)
	endfunction

	private function action takes nothing returns nothing
	    set udg_DamageEventAmount = udg_DamageEventAmount + 0.5 * Event_OnDamageChange_StaticDamage
	endfunction
            
    //===========================================================================
	private function init takes nothing returns nothing
	    call CreateEventTrigger( "udg_DamageModifierEvent", function action, function condition )
	endfunction

endscope