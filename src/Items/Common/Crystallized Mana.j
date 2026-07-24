scope CrystalizedMana initializer init

	globals
		private constant integer ABILITY_ID = 'A1IT'
		private constant integer MANA_RESTORE = 100
		private constant string ANIMATION = "Abilities\\Spells\\Items\\AIma\\AImaTarget.mdl"
	endglobals

	private function condition takes nothing returns boolean
	    return GetSpellAbilityId() == ABILITY_ID
	endfunction
	
	private function action takes nothing returns nothing
	    local unit caster
	    local unit target
	    local integer cyclA = 1
	    local integer cyclAEnd 
	    
	    if CastLogic() then
	        set caster = udg_Caster
	        set target = udg_Target
	    elseif RandomLogic() then
	        set caster = udg_Caster
	        set target = randomtarget( caster, 900, "ally", RT_NOT_FULL_HEALTH, RT_NOT_CASTER, RT_HERO )
	        call textst( udg_string[0] + GetObjectName(ABILITY_ID), caster, 64, 90, 10, 1.5 )
	        if target == null then
	            set caster = null
	            return
	        endif
	    else
	        set caster = GetSpellAbilityUnit()
	        set target = GetSpellTargetUnit()
	    endif
	 
	    set cyclAEnd = eyest( caster )
	    loop
	        exitwhen cyclA > cyclAEnd
	        call manast( caster, target, MANA_RESTORE )
	        call DestroyEffect( AddSpecialEffectTarget( ANIMATION, target, "origin" ) )
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