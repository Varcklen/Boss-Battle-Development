scope CurseAcceleration initializer init

	//===========================================================================
	public function Enable takes nothing returns nothing
		call CombatTimer_AddBattleTime(-60, true)
		call CombatTimer_AddBattleTime(-60, false)
    endfunction
    
    public function Disable takes nothing returns nothing
		call CombatTimer_AddBattleTime(60, true)
		call CombatTimer_AddBattleTime(60, false)
    endfunction
	
	private function init takes nothing returns nothing

	endfunction

endscope