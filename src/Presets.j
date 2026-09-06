scope NAME initializer init
	
	globals
		private constant integer
	endglobals

	private function condition takes nothing returns boolean
		return 
	endfunction
	
	private function action takes nothing returns nothing
		
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		
	endfunction
	
endscope
	
	EventName.GetDataUnit("unit")
    call EventName.SetDataUnit("unit", UNIT)
	call EventName.Invoke()
	call EventName.AddListener(function action, function condition)
	
	
	
	//===========================================================================
	private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call CreateNativeEvent( eventId, function action, function condition )
	endfunction
	
	