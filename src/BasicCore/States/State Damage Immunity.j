scope StateDamageImmunity initializer init
	
	private function condition takes nothing returns boolean
		return GetUnitAbilityLevel( udg_DamageEventTarget, 'A1K0') > 0
	endfunction
	
	private function action takes nothing returns nothing
		set udg_DamageEventType = udg_DamageTypeIgnore
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		call CreateEventTrigger( "udg_DamageModifierEvent", function action, function condition )
	endfunction
	
endscope