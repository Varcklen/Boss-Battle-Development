scope BlessPurse initializer init

	globals
		private constant integer GOLD_GAIN = 15
	endglobals

	public function AddStat takes integer value returns nothing
		local integer i = 1
		loop
			exitwhen i > PLAYERS_LIMIT
			if udg_hero[i] != null then
				call StatSystem_Add( udg_hero[i], STAT_GOLD_GAIN, value )
			endif
			set i = i + 1
		endloop
    endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		call AddStat(GOLD_GAIN)
    endfunction
    
    public function Disable takes nothing returns nothing
		call AddStat(-GOLD_GAIN)
    endfunction
	
	private function init takes nothing returns nothing

	endfunction

endscope