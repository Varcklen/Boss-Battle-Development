scope BlessIKnowGuy initializer init

	globals
		private trigger Trigger = null
	endglobals

	private function action takes nothing returns nothing
        set udg_logic[42] = true
        call BlzFrameSetText( juletext[1][0], "0 G" )
	endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		call EnableTrigger( Trigger )
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "Event_MainBattleWin", function action, null )
		call DisableTrigger( Trigger )
	endfunction

endscope