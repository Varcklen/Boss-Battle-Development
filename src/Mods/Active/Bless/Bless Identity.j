scope BlessIdentity initializer init

	//===========================================================================
	public function Enable takes nothing returns nothing
        call AddRaritySpawn(0, 12)
    endfunction
    
    public function Disable takes nothing returns nothing
		call SetRaritySpawn(0, -12)
    endfunction
	
	private function init takes nothing returns nothing

	endfunction

endscope