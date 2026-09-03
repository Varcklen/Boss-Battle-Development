scope Salamander2 initializer init

	private function condition takes nothing returns boolean
		return udg_IsDamageSpell and GetUnitTypeId(udg_DamageEventTarget) == 'n041'
	endfunction
	
	private function action takes nothing returns nothing
    	set udg_DamageEventAmount = udg_DamageEventAmount - udg_DamageEventAmount * 0.4
    endfunction
    
    //===========================================================================
	private function init takes nothing returns nothing
		call CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
	endfunction

endscope