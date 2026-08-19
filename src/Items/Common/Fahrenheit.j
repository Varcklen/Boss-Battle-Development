scope Fahrenheit initializer init

	globals
		private constant integer ABILITY_ID = 'A1JD'
		private constant integer BUFF_CHECK = 'B05J'

		private constant real DAMAGE_BONUS = 0.5
		private constant real STUN_DURATION = 4
		private constant string ANIMATION = "Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl"
		
	endglobals

	private function condition takes nothing returns boolean
	    return GetSpellAbilityId() == ABILITY_ID
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
	        call textst( udg_string[0] + GetObjectName(ABILITY_ID), caster, 64, 90, 10, 1.5 )
	        if target == null then
	            set caster = null
	            return
	        endif
	    else
	        set caster = GetSpellAbilityUnit()
	        set target = GetSpellTargetUnit()
	    endif 
	    
	    call DestroyEffect( AddSpecialEffectTarget( ANIMATION, target, "origin" ) )
	    set cyclAEnd = eyest( caster )
	    loop
	        exitwhen cyclA > cyclAEnd
	        call UnitStun( caster, target, STUN_DURATION )
	        set cyclA = cyclA + 1
	    endloop
	    
	    set caster = null
	endfunction

	//===========================================================================
	private function OnDamageCheck_Condition takes nothing returns boolean
	    return GetUnitAbilityLevel( udg_DamageEventTarget, 'BPSE') > 0 and GetUnitAbilityLevel( udg_DamageEventSource, BUFF_CHECK) > 0
	endfunction

	private function OnDamageCheck takes nothing returns nothing
		set udg_DamageEventAmount = udg_DamageEventAmount + Event_OnDamageChange_StaticDamage * DAMAGE_BONUS
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
		
		call CreateEventTrigger( "Event_OnDamageChange_Real", function OnDamageCheck, function OnDamageCheck_Condition )
	endfunction

endscope