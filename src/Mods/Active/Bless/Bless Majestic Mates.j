scope BlessMajesticMates initializer init

	//===========================================================================
	public function Enable takes nothing returns nothing
		call UnitAddAbility(UNIT_BUFF, 'A14G')
    endfunction
    
    public function Disable takes nothing returns nothing
		call UnitRemoveAbility(UNIT_BUFF, 'A14G')
    endfunction
	
	private function init takes nothing returns nothing

	endfunction

endscope