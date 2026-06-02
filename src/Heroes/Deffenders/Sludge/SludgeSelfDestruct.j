scope SludgeSelfDestruct initializer init

	globals
		private constant integer ABILITYQ = 'A1IF'
		private constant integer ABILITY_REDUCTION = 'A0R5'
		
		private constant real COOLDOWN_REDUCTION = 0.25
	endglobals
	
	private function conditions takes nothing returns boolean
	    return GetSpellAbilityId() == ABILITYQ
	endfunction
	
	private function Cast takes unit caster returns nothing
		local unit original = LoadUnitHandle( udg_hash, GetHandleId(caster), StringHash( "sldg" ) )

		call UnitReduceAbilityCooldownPercent( original, ABILITY_REDUCTION, COOLDOWN_REDUCTION )
		call DestroyEffect(AddSpecialEffect( "Objects\\Spawnmodels\\Demon\\DemonLargeDeathExplode\\DemonLargeDeathExplode.mdl", GetUnitX(caster), GetUnitY(caster) ) )
        call KillUnit(caster)

		set original = null
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