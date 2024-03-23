scope CurseSlowness initializer init

	//===========================================================================
	public function Enable takes nothing returns nothing
		call UnitAddAbility( udg_UNIT_DUMMY_BUFF, 'A1DM' )
    endfunction
    
    public function Disable takes nothing returns nothing
		call UnitRemoveAbility( udg_UNIT_DUMMY_BUFF, 'A1DM' )
    endfunction
	
	private function init takes nothing returns nothing

	endfunction

endscope