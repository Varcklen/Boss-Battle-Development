scope SniperQ initializer init

    globals
		trigger trg_SniperQ = null
		private constant integer ABILITY_ID = 'A07K'
    endglobals
    
private function Trig_SniperQ_Conditions takes nothing returns boolean
    return GetSpellAbilityId( ) == ABILITY_ID
endfunction

function SniperQMotion takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer() )
    local unit target = LoadUnitHandle( udg_hash, id, StringHash( "snpqt" ) )
    local unit dummy = LoadUnitHandle( udg_hash, id, StringHash( "snpq" ) )
    local real dmg = LoadReal( udg_hash, id, StringHash( "snpq" ) )
    local real x = GetUnitX( target )
    local real y = GetUnitY( target )
    local real x1 = GetUnitX( dummy )
    local real y1 = GetUnitY( dummy )
    local real angle = Atan2( y - y1, x - x1 )
    local real NewX = x1 + 120 * Cos( angle )
    local real NewY = y1 + 120 * Sin( angle )
    local real IfX = ( ( x - x1 ) * ( x - x1 ) )
    local real IfY = ( ( y - y1 ) * ( y - y1 ) )
    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "snpqc" ) )
    local boolean aspect = LoadBoolean(udg_hash, id, StringHash( "snpqb" ))
    local real hpmax = GetUnitState(target, UNIT_STATE_MAX_LIFE)
    local real hpcur = GetUnitState( target, UNIT_STATE_LIFE)
    
    if SquareRoot( IfX + IfY ) > 100 and hpcur > 0.405 then
        call SetUnitPosition( dummy, NewX, NewY )
        call GetUnitLoc( target )
    else
    	if aspect then 
    		set dmg = dmg * (1.7 - hpcur * 1.2 / hpmax ) * hpmax
    	else
    		set dmg = dmg * hpmax
    	endif
        call spectimeunit( target, "Objects\\Spawnmodels\\Human\\FragmentationShards\\FragBoomSpawn.mdl", "origin", 2 )
        call UnitDamageTarget( caster, target, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )
        call RemoveUnit( dummy )
        call DestroyTimer( GetExpiredTimer() )
        call FlushChildHashtable( udg_hash, id )
    endif

	set caster = null
    set dummy = null
    set target = null
endfunction   

private function Trig_SniperQ_Actions takes nothing returns nothing
    local integer id 
    local real dmg 
    local unit caster
    local unit target
    local integer lvl

    if CastLogic() then
        set caster = udg_Caster
        set target = udg_Target
        set lvl = udg_Level
    elseif RandomLogic() then
        set caster = udg_Caster
        set target = randomtarget( caster, 900, "enemy", 0, 0, 0 )
        set lvl = udg_Level
        call textst( udg_string[0] + GetObjectName(ABILITY_ID), caster, 64, 90, 10, 1.5 )
        if target == null then
            set caster = null
            return
        endif
    else
        set caster = GetSpellAbilityUnit()
        set target = GetSpellTargetUnit()
        set lvl = GetUnitAbilityLevel(caster, ABILITY_ID)
    endif
    
    set dmg = ( 0.012 + ( 0.012 * lvl ) ) * GetUnitSpellPower(caster)
    
    call dummyspawn( caster, 0, 'A10A', 'A0N5', 0 )
    call SetUnitFacing( bj_lastCreatedUnit, AngleBetweenUnits( caster, target ) )

    set id = GetHandleId( bj_lastCreatedUnit )
    
    call SaveTimerHandle( udg_hash, id, StringHash( "snpq" ), CreateTimer() )
	set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "snpq" ) ) ) 
	call SaveUnitHandle( udg_hash, id, StringHash( "snpq" ), bj_lastCreatedUnit )
    call SaveUnitHandle( udg_hash, id, StringHash( "snpqt" ), target )
    call SaveUnitHandle( udg_hash, id, StringHash( "snpqc" ), caster )
    call SaveReal( udg_hash, id, StringHash( "snpq" ), dmg )
    call SaveBoolean(  udg_hash, id, StringHash( "snpqb" ), Aspects_IsHeroAspectActive( caster, ASPECT_01 ) )
	call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( bj_lastCreatedUnit ), StringHash( "snpq" ) ), 0.04, true, function SniperQMotion )
    
    set caster = null
    set target = null
endfunction


//===========================================================================
private function init takes nothing returns nothing
    set trg_SniperQ = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_SniperQ, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trg_SniperQ, Condition( function Trig_SniperQ_Conditions ) )
    call TriggerAddAction( trg_SniperQ, function Trig_SniperQ_Actions )
endfunction

endscope

