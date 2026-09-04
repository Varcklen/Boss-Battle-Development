scope Crab5 initializer init

	private function condition takes nothing returns boolean
		return udg_IsDamageSpell and GetUnitTypeId(udg_DamageEventTarget) == 'n009'
	endfunction
	
	private function action takes nothing returns nothing
    	set udg_DamageEventAmount = udg_DamageEventAmount - udg_DamageEventAmount * 0.2
    endfunction
    
    //===========================================================================
	private function init takes nothing returns nothing
		call CreateEventTrigger( "udg_DamageModifierEvent", function action, function condition )
	endfunction

endscope