scope TreeAbility initializer init

	globals
		private constant integer ABILITY_ID = 'A0H7'
	endglobals

	private function condition takes nothing returns boolean
	    return GetUnitAbilityLevel( GetDyingUnit(), ABILITY_ID) > 0
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = GetDyingUnit()
	    local unit target = GetKillingUnit()
	    local unit newUnit
	    
	    if target == null then
	    	return
	    endif
	    set newUnit = dummyspawn( caster, 1, 'A1JV', 0, 0 )
        call IssueTargetOrder( newUnit, "entanglingroots", target )
	    
	    set newUnit = null
	    set caster = null
	    set target = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call CreateNativeEvent( EVENT_PLAYER_UNIT_DEATH, function action, function condition )
	endfunction

endscope