scope SludgeExtra initializer init

	globals
		private constant integer ABILITYQ = 'A1IE'
		private constant integer ABILITY_REDUCTION = 'A0R5'
		private constant integer UNIT_TO_KILL = 'u00X'
		
		private constant real COOLDOWN_REDUCTION = 0.25
	endglobals
	
	private function conditions takes nothing returns boolean
	    return GetSpellAbilityId() == ABILITYQ
	endfunction
	
	private function Cast takes unit caster returns nothing
		local group g = CreateGroup()
    	local unit u
    	local real cooldownReduce = 0
		
		set bj_livingPlayerUnitsTypeId = UNIT_TO_KILL
        call GroupEnumUnitsOfPlayer(g, GetOwningPlayer(caster), filterLivingPlayerUnitsOfTypeId)
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            set cooldownReduce = cooldownReduce + COOLDOWN_REDUCTION
            call DestroyEffect(AddSpecialEffect( "Objects\\Spawnmodels\\Demon\\DemonLargeDeathExplode\\DemonLargeDeathExplode.mdl", GetUnitX(u), GetUnitY(u) ) )
            call KillUnit(u)
            call GroupRemoveUnit(g,u)
        endloop
        
        set cooldownReduce = RMinBJ(1, cooldownReduce)
        call UnitReduceAbilityCooldownPercent( caster, ABILITY_REDUCTION, cooldownReduce )
        
	    call DestroyGroup( g )
	    set u = null
	    set g = null
	endfunction
	
	private function actions takes nothing returns nothing
	    local unit caster
	    
	    if CastLogic() then
	        set caster = udg_Caster
	    elseif RandomLogic() then
	        set caster = udg_Caster
	        call textst( udg_string[0] + GetObjectName(ABILITYQ), caster, 64, 90, 10, 1.5 )
	    else
	        set caster = GetSpellAbilityUnit()
	    endif
	    
	    call Cast(caster)

	    set caster = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_SPELL_EFFECT )
	    call TriggerAddCondition( trig, Condition( function conditions ) )
	    call TriggerAddAction( trig, function actions )
	    set trig = null
	endfunction

endscope