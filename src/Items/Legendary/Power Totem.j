scope PowerTotem initializer init

	private function condition takes nothing returns boolean
	    return GetSpellAbilityId() == 'A1H9'
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = GetSpellAbilityUnit()
		local unit target = GetSpellTargetUnit()
		
		call spdst( target, 10 )
	    call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Items\\AIsm\\AIsmTarget.mdl", GetUnitX( target ), GetUnitY( target ) ) )
	    call stazisst( caster, GetItemOfTypeFromUnitBJ( caster, 'I0HI') )
	    
	    set caster = null
	    set target = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
	endfunction

endscope