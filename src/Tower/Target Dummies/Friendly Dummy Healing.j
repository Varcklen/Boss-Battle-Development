scope FriendlyDummyHealing initializer init
	
	private function condition takes nothing returns boolean
		return GetUnitTypeId(Event_AfterHeal_Target) == 'h028'
	endfunction
	
	private function action takes nothing returns nothing
	    call SetUnitLifePercentBJ( Event_AfterHeal_Target, 50 )
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		call CreateEventTrigger( "Event_AfterHeal_Real", function action, function condition )
	endfunction
	
endscope