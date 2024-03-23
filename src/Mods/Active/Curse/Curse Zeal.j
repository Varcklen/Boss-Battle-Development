scope CurseZeal initializer init

	//===========================================================================
	public function Enable takes nothing returns nothing
		call BossCastLib_AddInterval(-10)
    endfunction
    
    public function Disable takes nothing returns nothing
		call BossCastLib_AddInterval(10)
    endfunction
	
	private function init takes nothing returns nothing
	endfunction

endscope