scope CurseAnger initializer init

	//===========================================================================
	public function Enable takes nothing returns nothing
		call UnitAddAbility(UNIT_BUFF, 'A0KH')
    endfunction
    
    public function Disable takes nothing returns nothing
		call UnitRemoveAbility(UNIT_BUFF, 'A0KH')
    endfunction
	
	private function init takes nothing returns nothing

	endfunction

endscope