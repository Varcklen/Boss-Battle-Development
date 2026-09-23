scope FrenzyTotemDeath initializer init

	private function condition takes nothing returns boolean
	    return GetUnitTypeId( GetDyingUnit() ) == 'o023'
	endfunction
	
	private function action takes nothing returns nothing
		local unit diedUnit = GetDyingUnit()
		local lightning ray = LoadLightningHandle( udg_hash, GetHandleId( diedUnit ), StringHash("boss_berserk_totem_ray") )
	
		call DestroyLightning( ray )

	    set diedUnit = null
	    set ray = null
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_DEATH, function action, function condition )
	endfunction

endscope