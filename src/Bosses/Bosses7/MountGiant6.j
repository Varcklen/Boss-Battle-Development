scope MountGiant6 initializer init

	private function condition takes nothing returns boolean
		return GetUnitTypeId(udg_DamageEventTarget) == 'e000' and IsMinion(udg_DamageEventSource)
	endfunction
	
	private function action takes nothing returns nothing
    	set udg_DamageEventAmount = udg_DamageEventAmount - udg_DamageEventAmount * 0.7
    endfunction
    
    //===========================================================================
	private function init takes nothing returns nothing
		call CreateEventTrigger( "udg_DamageModifierEvent", function action, function condition )
	endfunction

endscope