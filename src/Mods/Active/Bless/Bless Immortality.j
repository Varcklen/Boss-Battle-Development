scope BlessImmortality initializer init

	//===========================================================================
	public function Enable takes nothing returns nothing
		call RessurectionPoints( 1, true )
    endfunction
    
    public function Disable takes nothing returns nothing
		call RessurectionPoints( -1, false )
    endfunction
	
	private function init takes nothing returns nothing

	endfunction

endscope