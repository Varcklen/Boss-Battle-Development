scope BlessIdentity initializer init

	//===========================================================================
	public function Enable takes nothing returns nothing
        call SetRaritySpawn(udg_RarityChance[3] + 5, udg_RarityChance[2] + 10)
    endfunction
    
    public function Disable takes nothing returns nothing
		call SetRaritySpawn(udg_RarityChance[3] - 5, udg_RarityChance[2] - 10)
    endfunction
	
	private function init takes nothing returns nothing

	endfunction

endscope