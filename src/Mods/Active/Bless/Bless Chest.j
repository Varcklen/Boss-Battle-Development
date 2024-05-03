scope BlessChest initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function condition takes nothing returns boolean
		return udg_fightmod[3] == false
	endfunction
	
	private function action takes nothing returns nothing
		local location spawn = GetRandomLocInRect(udg_Boss_Rect)
		
		call CreateNUnitsAtLoc( 1, 'h01L', Player(PLAYER_NEUTRAL_AGGRESSIVE), spawn, 270 )
		
		call RemoveLocation(spawn)
		set spawn = null
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
		set Trigger = CreateEventTrigger( "udg_FightStartGlobal_Real", function action, function condition )
		call DisableTrigger( Trigger )
	endfunction

endscope