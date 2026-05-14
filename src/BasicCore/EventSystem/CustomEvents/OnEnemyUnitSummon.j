scope OnEnemyUnitSummon initializer init

	private function condition takes nothing returns boolean
		if udg_fightmod[0] == false then
			return false
		endif
		if IsUnitHasAbility(GetEnteringUnit(), 'A1FY') then
			return false
		endif
		if GetOwningPlayer(GetEnteringUnit()) != Player(10) and GetOwningPlayer(GetEnteringUnit()) != Player(PLAYER_NEUTRAL_AGGRESSIVE) then
			return false
		endif
	    return true
	endfunction
	
	private function action takes nothing returns nothing
	    call EnemyUnitSummoned.SetDataUnit("unit", GetEnteringUnit())
    	call EnemyUnitSummoned.Invoke()
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		local trigger trig = CreateTrigger(  )
	    call TriggerRegisterEnterRectSimple( trig, GetWorldBounds() )
	    call TriggerAddCondition( trig, Condition( function condition ) )
	    call TriggerAddAction( trig, function action )
	    set trig = null
	endfunction

endscope