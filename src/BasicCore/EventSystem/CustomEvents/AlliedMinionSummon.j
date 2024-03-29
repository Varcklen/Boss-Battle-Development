scope AlliedMinionSummon initializer init

	private function SummonEventCondition takes unit unitCheck, integer index returns boolean
		if udg_hero[index] == null then
			return true
	    elseif IsUnitType(unitCheck, UNIT_TYPE_ANCIENT ) then
	        return true
	    elseif IsUnitType(unitCheck, UNIT_TYPE_HERO ) then
	        return true
	    elseif IsPermaBuffAffected(unitCheck) == false then 
	        return true
	    elseif GetUnitAbilityLevel(unitCheck, 'A1FY') > 0 then
	        return true
	    endif
	    return false
	endfunction
	
	private function action takes nothing returns nothing
	    local integer index = GetPlayerId(GetOwningPlayer(GetEnteringUnit())) + 1
	    
	    if SummonEventCondition(GetEnteringUnit(), index) then
	        return
	    endif
	    call AlliedMinionSummoned.SetDataUnit("caster", udg_hero[index])
	    call AlliedMinionSummoned.SetDataUnit("minion", GetEnteringUnit())
	    call AlliedMinionSummoned.Invoke()
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		local trigger trig = CreateTrigger(  )
	    call TriggerRegisterEnterRectSimple( trig, bj_mapInitialPlayableArea )
	    call TriggerAddAction( trig, function action )
	    
	    set trig = null
	endfunction

endscope