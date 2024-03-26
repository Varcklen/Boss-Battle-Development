scope BlessProduction initializer init

	globals
		private boolean isUsedAgain = false	
	endglobals

	//===========================================================================
	public function Enable takes nothing returns nothing
		local integer i
		
		if isUsedAgain then
			return
		endif
		set isUsedAgain = true
		
        set i = 1
        loop
            exitwhen i > 4
            if udg_hero[i] != null then
                call ItemRandomizerAll( udg_hero[i], 0 )
            endif
            set i = i + 1
        endloop
    endfunction
    
    public function Disable takes nothing returns nothing
		
    endfunction
	
	private function init takes nothing returns nothing
	endfunction

endscope