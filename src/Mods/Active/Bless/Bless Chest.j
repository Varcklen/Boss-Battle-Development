scope BlessChest initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function action takes nothing returns nothing
		call CreateNUnitsAtLoc( 1, 'h01L', Player(PLAYER_NEUTRAL_AGGRESSIVE), GetRandomLocInRect(udg_Boss_Rect), 270 )
	endfunction
	
	//===========================================================================
	public function Enable takes nothing returns nothing
        call EnableTrigger( Trigger )
        if udg_fightmod[0] then
        	call action()
        endif
    endfunction
    
    public function Disable takes nothing returns nothing
        call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "udg_FightStartGlobal_Real", function action, null )
		call DisableTrigger( Trigger )
	endfunction

endscope