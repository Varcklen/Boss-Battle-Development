scope CrownOfNight initializer init

	globals
		private constant integer DURATION = 3
		private constant integer ABILITY = 'A1J1'
		private constant string ANIMATION = "Abilities\\Spells\\Human\\Invisibility\\InvisibilityTarget.mdl"
	endglobals
	
	private function conditions takes nothing returns boolean
	    return GetSpellAbilityId() == ABILITY
	endfunction
	
	private function actions takes nothing returns nothing
	    local unit caster
	    local real t = DURATION
	    
	    if CastLogic() then
	        set caster = udg_Caster
	        set t = udg_Time
	    elseif RandomLogic() then
	        set caster = udg_Caster
	        call textst( udg_string[0] + GetObjectName(ABILITY), caster, 64, 90, 10, 1.5 )
	    else
	        set caster = GetSpellAbilityUnit()
	    endif
	    set t = timebonus(caster, t)
	    
	    call eyest( caster )
	    call InvisibilitySystem_Apply(caster, null, t)
	    call DestroyEffect( AddSpecialEffectTarget( ANIMATION, caster, "origin") )
	    
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