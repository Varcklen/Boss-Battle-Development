scope QuilgoarSupport initializer init

	private function condition takes nothing returns boolean
	    return GetUnitAbilityLevel(udg_DamageEventSource, 'A0JI') > 0
	endfunction

	private function action takes nothing returns nothing
	    local unit caster = udg_DamageEventSource
	    local unit hero = LoadUnitHandle(udg_hash, GetHandleId(caster), StringHash("dryad_q_hero") )
	    local integer bonusDamage 
	    
	    if hero != null then
	    	set bonusDamage = GetHeroAgi( hero, true )
	    	set udg_DamageEventAmount = udg_DamageEventAmount + bonusDamage
	    endif
	    
	    set caster = null
	    set hero = null
	endfunction
            
    //===========================================================================
	private function init takes nothing returns nothing
	    call CreateEventTrigger( "udg_DamageModifierEvent", function action, function condition )
	endfunction

endscope