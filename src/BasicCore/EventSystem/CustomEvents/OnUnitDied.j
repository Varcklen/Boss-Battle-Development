scope OnUnitDied initializer init

	private function action takes nothing returns nothing
		call UnitDied.SetDataUnit("killer", GetKillingUnit())
		call UnitDied.SetDataUnit("unit_died", GetDyingUnit())
    	call UnitDied.Invoke()
	endfunction

	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_DEATH, function action, null )
	endfunction

endscope