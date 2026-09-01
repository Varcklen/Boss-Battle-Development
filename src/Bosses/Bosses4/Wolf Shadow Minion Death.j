scope WolfShadowMinionDeath initializer init

	private function condition takes nothing returns boolean
	    return GetUnitTypeId( GetDyingUnit() ) == 'o00A'
	endfunction
	
	private function action takes nothing returns nothing
		local unit diedUnit = GetDyingUnit()
		
	    call ShowUnitHide( diedUnit )
	    call DestroyEffect( AddSpecialEffect("Abilities\\Spells\\Orc\\FeralSpirit\\feralspirittarget.mdl", GetUnitX(diedUnit), GetUnitY(diedUnit) ) )
	    
	    set diedUnit = null
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_DEATH, function action, function condition )
	endfunction

endscope