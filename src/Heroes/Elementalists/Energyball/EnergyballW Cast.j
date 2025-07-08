scope EnertyBallWCast initializer init

	private function CastLightning takes unit caster, real damageMultipler returns nothing
		local unit target = randomtarget( caster, 900, "enemy", 0, 0, 0 )
	    local real damage = LoadReal( udg_hash, GetHandleId( LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( "enbw" ) ) ), StringHash( "enbw" ) ) * damageMultipler
	    /*call BJDebugMsg("unit: " + GetUnitName(caster))
	    call BJDebugMsg("target: " + GetUnitName(target))
	    call BJDebugMsg("damage: " + R2S(damage))
	    call BJDebugMsg("check: " + R2S(LoadReal( udg_hash, GetHandleId( LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( "enbw" ) ) ), StringHash( "enbw" ) )))*/
	    if target == null then
	    	return
	    endif
	
		call Lightning_CreateLightning( "CLPB", GetUnitX(caster), GetUnitY(caster), GetUnitFlyHeight(caster) + 50, GetUnitX(target), GetUnitY(target), GetUnitFlyHeight(target) + 50, 0.5 )
        call DestroyEffect( AddSpecialEffect( "Abilities\\Weapons\\FarseerMissile\\FarseerMissile.mdl", GetUnitX( target ), GetUnitY( target ) ) )
        call UnitDamageTarget( caster, target, damage, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
	        
	    set target = null
	endfunction
	
	private function cast_condition takes nothing returns boolean
	    return GetUnitAbilityLevel( GetSpellAbilityUnit(), 'B057') > 0 and GetSpellAbilityId() != 'A0V1'
	endfunction
	
	private function cast takes nothing returns nothing
	    call CastLightning(GetSpellAbilityUnit(), 1)
	endfunction
	
	private function attack_condition takes nothing returns boolean
	    return udg_IsDamageSpell == false and GetUnitAbilityLevel( udg_DamageEventSource, 'B057') > 0 and LoadBoolean( udg_hash, GetHandleId( udg_DamageEventSource ), StringHash( "enbw" ) ) == false
	endfunction
	
	private function attack_delay takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "wisp_w_delay_caster" ) )
	
		call CastLightning(caster, 0.3)
		call FlushChildHashtable( udg_hash, id )
		
		set caster = null
	endfunction
	
	private function attack takes nothing returns nothing
	    local timer usedTimer
	    
	    call SaveTimerHandle( udg_hash, GetHandleId( udg_DamageEventSource ), StringHash( "wisp_w_delay" ), CreateTimer() )
	    set usedTimer = LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventSource ), StringHash( "wisp_w_delay" ) )
		call SaveUnitHandle( udg_hash, GetHandleId( usedTimer ) , StringHash( "wisp_w_delay_caster" ), udg_DamageEventSource )
		call TimerStart( usedTimer, 0.01, false, function attack_delay )
		
		set usedTimer = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function cast, function cast_condition )
	    call CreateEventTrigger( "udg_AfterDamageEvent", function attack, function attack_condition )
	endfunction

endscope

