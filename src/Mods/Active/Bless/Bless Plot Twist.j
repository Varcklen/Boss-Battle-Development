scope BlessPlotTwist initializer init

	globals
		private boolean isUsedAgain = false
	endglobals

	//===========================================================================
	public function Enable takes nothing returns nothing
		if isUsedAgain == false then
            set udg_Heroes_Chanse = udg_Heroes_Chanse + 1
            call MultiSetValue( udg_multi, 2, 1, I2S( udg_Heroes_Chanse ) )
        endif
        set isUsedAgain = true
    endfunction
    
    public function Disable takes nothing returns nothing
		
    endfunction
	
	private function init takes nothing returns nothing

	endfunction

endscope