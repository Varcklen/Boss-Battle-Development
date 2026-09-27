scope CurseAcceleration initializer init

	globals
		private constant integer TIMER_CHANGE = 30
	endglobals

	//===========================================================================
	public function Enable takes nothing returns nothing
		call CombatTimer_AddBattleTime(-TIMER_CHANGE, true)
		call CombatTimer_AddBattleTime(-TIMER_CHANGE, false)
    endfunction
    
    public function Disable takes nothing returns nothing
		call CombatTimer_AddBattleTime(TIMER_CHANGE, true)
		call CombatTimer_AddBattleTime(TIMER_CHANGE, false)
    endfunction
	
	private function init takes nothing returns nothing

	endfunction

endscope