scope CurseAcceleration initializer init

	//===========================================================================
	public function Enable takes nothing returns nothing
		set udg_timelimit = udg_timelimit - 75
    endfunction
    
    public function Disable takes nothing returns nothing
		set udg_timelimit = udg_timelimit + 75
    endfunction
	
	private function init takes nothing returns nothing

	endfunction

endscope