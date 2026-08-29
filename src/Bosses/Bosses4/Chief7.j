scope Chief7 initializer init
	//no need to add into boss database
	private function condition takes nothing returns boolean
	    return GetUnitTypeId( GetDyingUnit() ) == 'h01X'
	endfunction
	
	private function action takes nothing returns nothing
	    call Chief6_UnlockItems()
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_DEATH, function action, function condition )
	endfunction
endscope