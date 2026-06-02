scope SludgeR initializer init
    globals
		trigger trg_SludgeR = null
    endglobals

	function Trig_SludgeR_Conditions takes nothing returns boolean
	    return GetLearnedSkill() == 'A0T8'
	endfunction
	
	function Trig_SludgeR_Actions takes nothing returns nothing
		local unit u = GetLearningUnit()
	    if GetUnitAbilityLevel( u, 'A0T8') == 1 then
			call UnitAddAbility( u, 'A0RW')
	    elseif GetUnitAbilityLevel( u, 'A0T8') == 2 then
	        call UnitAddAbility( u, 'A0S6')
		elseif GetUnitAbilityLevel( u, 'A0T8') == 4 then
	        call UnitAddAbility( u, 'A0SD')
		endif
		set u = null
	endfunction
	
	//===========================================================================
	private function OnUnitDied_Condition takes nothing returns boolean
	    return GetUnitAbilityLevel( UnitDied.GetDataUnit("unit_died"), 'A0T8') >= 3 or GetUnitAbilityLevel( UnitDied.GetDataUnit("unit_died"), 'A0T6') > 0
	endfunction
	
	private function OnUnitDied takes nothing returns nothing 
	    local unit caster = UnitDied.GetDataUnit("unit_died")
	    local unit original
	    
	    if GetUnitAbilityLevel( caster, 'A0T6') > 0 then
	    	set original = LoadUnitHandle( udg_hash, GetHandleId(caster), StringHash( "sldg" ) )
	    	if GetUnitAbilityLevel( original, 'A0T8') < 3 then
	    		set caster = null
	    		set original = null
	    		return
	    	endif
    	endif
    	
    	call GroupAoE( caster, GetUnitX(caster), GetUnitY(caster), 450, 400, "enemy", "Units\\Undead\\Abomination\\AbominationExplosion.mdl", null )
	    
	    set caster = null
	    set original = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    set trg_SludgeR = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( trg_SludgeR, EVENT_PLAYER_HERO_SKILL )
	    call TriggerAddCondition( trg_SludgeR, Condition( function Trig_SludgeR_Conditions ) )
	    call TriggerAddAction( trg_SludgeR, function Trig_SludgeR_Actions )

		call UnitDied.AddListener(function OnUnitDied, function OnUnitDied_Condition)
	endfunction

endscope

