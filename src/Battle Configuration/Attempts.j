library Attempts initializer init requires Multiboard

	globals
		private constant integer STARTING_ATTEMPTS = 1
		
		private integer Attempts = 0
	endglobals

	public function Add takes integer value returns nothing
		set Attempts = Attempts + value
		call Multiboard_MultiSetValue( 1, 2, I2S( Attempts ) )
	endfunction
	
	public function Get takes nothing returns integer
		return Attempts
	endfunction

	private function InitData takes nothing returns nothing
		call Add(STARTING_ATTEMPTS)
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		local trigger trig = CreateTrigger()
	    call TriggerRegisterTimerEvent( trig, 2, false)
	    call TriggerAddAction( trig, function InitData )
	endfunction

endlibrary