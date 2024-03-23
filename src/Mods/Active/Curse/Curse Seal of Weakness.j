scope CurseSealWeakness initializer init

	globals
		private constant integer VALUE_PERC = -15
	endglobals

	public function AddStat takes integer value returns nothing
		local integer i = 1
		loop
			exitwhen i > PLAYERS_LIMIT
			if udg_hero[i] != null then
				call StatSystem_Add( udg_hero[i], STAT_HEAL_BONUS, value )
				call StatSystem_Add( udg_hero[i], STAT_MANA_HEAL_BONUS, value )
			endif
			set i = i + 1
		endloop
    endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		call AddStat(VALUE_PERC)
    endfunction
    
    public function Disable takes nothing returns nothing
		call AddStat(-VALUE_PERC)
    endfunction
	
	private function init takes nothing returns nothing

	endfunction

endscope