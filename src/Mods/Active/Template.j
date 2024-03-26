scope NAME initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function condition takes nothing returns boolean
		return 
	endfunction
	
	private function action takes nothing returns nothing

	endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		call EnableTrigger( Trigger )
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = CreateNativeEvent( , function action, function condition )
		//set Trigger = AnyHeroDied.AddListener(function action, function condition)
		call DisableTrigger( Trigger )
	endfunction

endscope