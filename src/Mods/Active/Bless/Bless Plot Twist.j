scope BlessPlotTwist initializer init

	globals
		private boolean isUsedAgain = false
	endglobals

	//===========================================================================
	public function Enable takes nothing returns nothing
		if isUsedAgain == false then
            call Attempts_Add(1)
        endif
        set isUsedAgain = true
    endfunction
    
    public function Disable takes nothing returns nothing
		
    endfunction
	
	private function init takes nothing returns nothing

	endfunction

endscope