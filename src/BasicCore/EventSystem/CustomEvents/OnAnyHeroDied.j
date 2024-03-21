scope OnAnyHeroDied initializer init

	private function condition takes nothing returns boolean
		return IsUnitType( GetDyingUnit(), UNIT_TYPE_HERO)
	endfunction

	private function action takes nothing returns nothing
		local integer i = 1
		local unit heroDied = GetDyingUnit()
		
		loop
			exitwhen i > PLAYERS_LIMIT
			if udg_hero[i] != null then
				call AnyHeroDied.SetDataUnit("caster", udg_hero[i])
				call AnyHeroDied.SetDataUnit("unit_died", heroDied)
		    	call AnyHeroDied.Invoke()
	    	endif
			set i = i + 1
		endloop
		
		set heroDied = null
	endfunction

	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_DEATH, function action, null )
	endfunction

endscope