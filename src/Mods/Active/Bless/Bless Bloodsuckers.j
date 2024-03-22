scope BlessBloodsuckers initializer init

	globals
		private constant integer DAMAGE_REDUCTION_PERC = 10
	endglobals

	public function AddStat takes integer value returns nothing
		local integer i = 1
		loop
			exitwhen i > PLAYERS_LIMIT
			if udg_hero[i] != null then
				call StatSystem_Add( udg_hero[i], STAT_VAMPIRISM_PHY, value )
			endif
			set i = i + 1
		endloop
    endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		call AddStat(DAMAGE_REDUCTION_PERC)
    endfunction
    
    public function Disable takes nothing returns nothing
		call AddStat(-DAMAGE_REDUCTION_PERC)
    endfunction
	
	private function init takes nothing returns nothing

	endfunction

endscope