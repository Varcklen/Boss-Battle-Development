scope Albedo initializer init

	private function condition takes nothing returns boolean
	    return GetSpellAbilityId() == 'A0OS'
	endfunction
	
	private function action takes nothing returns nothing
	    local integer cyclA = 1
	    local integer cyclAEnd
	    local unit caster
	    local unit target
	    
	    if CastLogic() then
	        set caster = udg_Caster
	        set target = udg_Target
	    elseif RandomLogic() then
	        set caster = udg_Caster
	        set target = randomtarget( caster, 900, "enemy", 0, 0, 0 )
	        call textst( udg_string[0] + GetObjectName('A0OS'), caster, 64, 90, 10, 1.5 )
	        if target == null then
	            set caster = null
	            return
	        endif
	    else
	        set caster = GetSpellAbilityUnit()
	        set target = GetSpellTargetUnit()
	    endif
	    
	    set cyclAEnd = eyest( caster )
	    call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl", caster, "origin") )
	    call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl", target, "origin" ) )
	    loop
	        exitwhen cyclA > cyclAEnd
	        call UnitStun(caster, target, 6 )
	        call UnitStun(caster, caster, 6 )
	        set cyclA = cyclA + 1
	    endloop
	
	    set caster = null
	    set target = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
	endfunction

endscope