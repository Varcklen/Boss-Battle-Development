scope SludgeE initializer init

private function conditions takes nothing returns boolean
    return GetUnitTypeId(udg_DamageEventSource) != 'u000' and IsUnitEnemy(udg_DamageEventSource, GetOwningPlayer(udg_DamageEventTarget)) and ( GetUnitAbilityLevel(udg_DamageEventTarget, 'A0RA') > 0 or GetUnitAbilityLevel(udg_DamageEventTarget, 'A0SS') > 0 )
endfunction

private function SludgeEEnd takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer( ) )
    local real dmg = LoadReal( udg_hash, id, StringHash( "slge1" ) )
    local unit target = LoadUnitHandle( udg_hash, id, StringHash( "slge1" ) )
    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "slge1d" ) )
        //call DisplayTimedTextToForce( GetPlayersAll(), 5.00, "111" )
    if GetUnitState( target, UNIT_STATE_LIFE) > 0.405 and GetUnitAbilityLevel( target, 'A0S2') > 0 then
        call UnitDamageTarget( caster, target, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )
    else
        call FlushChildHashtable( udg_hash, id )
        call DestroyTimer( GetExpiredTimer() )
    endif
    
    set caster = null
    set target = null
endfunction

private function SludgeECast takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer( ) )
    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "slgec" ) )
    local unit target = LoadUnitHandle( udg_hash, id, StringHash( "slget" ) )
	local integer id1 = GetHandleId( target )
	local integer lvl = LoadInteger( udg_hash, id, StringHash( "slge" ) )
	local real t = lvl * 2
    set t = timebonus(caster, t)

	if GetUnitAbilityLevel( target, 'A0S2') == 0 then
	
	    if LoadTimerHandle( udg_hash, id1, StringHash( "slge1" ) ) == null then
	        call SaveTimerHandle( udg_hash, id1, StringHash( "slge1" ), CreateTimer() )
	    endif
		set id1 = GetHandleId( LoadTimerHandle( udg_hash, id1, StringHash( "slge1" ) ) ) 
		call SaveUnitHandle( udg_hash, id1, StringHash( "slge1" ), target )
	    	call SaveUnitHandle( udg_hash, id1, StringHash( "slge1d" ), caster )
	    	call SaveReal( udg_hash, id1, StringHash( "slge1" ), 15 * GetUnitSpellPower(caster) )
		call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( target ), StringHash( "slge1" ) ), 1, true, function SludgeEEnd ) 
	endif
    call bufst( caster, target, 'A0S2', 'B06N', "slge2", t )

    call FlushChildHashtable( udg_hash, id )

    set caster = null
    set target = null
endfunction

private function actions takes nothing returns nothing 
    local integer id = GetHandleId( udg_DamageEventTarget )
    local integer lvl

	if GetUnitAbilityLevel(udg_DamageEventTarget, 'A0SS') > 0 then
		set lvl = LoadInteger( udg_hash, GetHandleId(udg_DamageEventTarget), StringHash( "sldge" ) )
	else
		set lvl = GetUnitAbilityLevel( udg_DamageEventTarget, 'A0RA' )
	endif

    call SaveTimerHandle( udg_hash, id, StringHash( "slge" ), CreateTimer() )
	set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "slge" ) ) ) 
	call SaveUnitHandle( udg_hash, id, StringHash( "slgec" ), udg_DamageEventTarget )
    call SaveUnitHandle( udg_hash, id, StringHash( "slget" ), udg_DamageEventSource )
	call SaveInteger( udg_hash, id, StringHash( "slge" ), lvl )
	call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( "slge" ) ), 0.01, false, function SludgeECast )
endfunction

//===========================================================================
private function init takes nothing returns nothing
    local trigger trig = CreateTrigger(  )
    call TriggerRegisterVariableEvent( trig, "udg_AfterDamageEvent", EQUAL, 1.00 )
    call TriggerAddCondition( trig, Condition( function conditions ) )
    call TriggerAddAction( trig, function actions )
endfunction

endscope