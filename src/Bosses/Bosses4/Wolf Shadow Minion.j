scope WolfShadowMinion initializer init

	globals
		private constant integer HASH_KEY = StringHash("shadow_copy_counter")
		private constant integer TICKS_TO_PROC = 4
		private constant integer STUN_DURATION = 5
		private constant integer COLOR_SATURATION = 60
	endglobals

	private function condition takes nothing returns boolean
	    return udg_IsDamageSpell and GetUnitAbilityLevel( udg_DamageEventTarget, 'A1JQ' ) > 0 and LoadBoolean(udg_hash, GetHandleId(udg_DamageEventTarget), HASH_KEY ) == false
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = udg_DamageEventTarget
		local integer id = GetHandleId(caster)
	    local integer counter = LoadInteger(udg_hash, id, HASH_KEY ) + 1
	    local integer saturation
	    
	    set saturation = COLOR_SATURATION * counter
	    call SetUnitVertexColor(caster, saturation, 40, saturation, 255 )
	    if counter >= TICKS_TO_PROC then
	    	call UnitStun(caster, caster, STUN_DURATION )
	    	call SaveBoolean(udg_hash, GetHandleId(caster), HASH_KEY, true)
	    	return
	    endif
	    call SaveInteger(udg_hash, id, HASH_KEY, counter )

	    set caster = null
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
	endfunction

endscope