scope OnAnyDied initializer init

	private function condition takes nothing returns boolean
		if GetUnitAbilityLevel(GetDyingUnit(), 'A1FY') > 0 then
	        return false
	    endif
	    return true
	endfunction
	
	private function action takes nothing returns nothing
		local integer i = 1
		local unit unitDied = GetDyingUnit()

		loop
			exitwhen i > PLAYERS_LIMIT
			if udg_hero[i] != null then
				call AnyUnitDied.SetDataUnit("caster", udg_hero[i])
				call AnyUnitDied.SetDataUnit("unit_died", unitDied)
		    	call AnyUnitDied.Invoke()
	    	endif
			set i = i + 1
		endloop
	
		set unitDied = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call CreateNativeEvent( EVENT_PLAYER_UNIT_DEATH, function action, function condition )
	endfunction

endscope