scope SmallHealHS initializer init

	globals
		public constant integer ANILITY_ID = 'A1G8'	
	endglobals

	private function condition takes nothing returns boolean
	    return GetSpellAbilityId() == ANILITY_ID
	endfunction
	
	private function action takes nothing returns nothing
	    local unit caster
	    local unit target

	    if CastLogic() then
	        set caster = udg_Caster
	        set target = udg_Target
	    elseif RandomLogic() then
	        set caster = udg_Caster
	        set target = randomtarget( caster, 900, "ally", "notfull", "", "", "" )
	        call textst( udg_string[0] + GetObjectName(ANILITY_ID), caster, 64, 90, 10, 1.5 )
	        if target == null then
	            set caster = null
	            return
	        endif
	    else
	        set caster = GetSpellAbilityUnit()
	        set target = GetSpellTargetUnit()
	    endif

	    call healst( caster, target, 100 )
	    call DestroyEffect( AddSpecialEffectTarget("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl" , target, "origin" ) )
	    
	    set caster = null
	    set target = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
	endfunction

endscope