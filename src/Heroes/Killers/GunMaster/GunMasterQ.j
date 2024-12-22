scope GunMasterQ initializer init

    globals
		trigger trg_GunMasterQ = null
    endglobals
    
function Trig_GunMasterQ_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A19H'
endfunction

function CommandoQEnd takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer( ) )
    local unit dummy = LoadUnitHandle( udg_hash, id, StringHash( "codq1" ) )
    local real dmg = LoadReal( udg_hash, id, StringHash( "codq1dmg" ) )
    local group g = CreateGroup()
    local unit u
    local effect fx 
    
    set fx = AddSpecialEffect( "Abilities\\Weapons\\GyroCopter\\GyroCopterMissile.mdl", GetUnitX( dummy ), GetUnitY( dummy ) )
    call BlzSetSpecialEffectScale( fx, 2 )
    call DestroyEffect( fx )
    
    call GroupEnumUnitsInRange( g, GetUnitX( dummy ), GetUnitY( dummy ), 350, null )
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        if unitst( u, dummy, "enemy" ) then
            call UnitDamageTarget( bj_lastCreatedUnit, u, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
        endif
        call GroupRemoveUnit(g,u)
    endloop
    call FlushChildHashtable( udg_hash, id )
    call RemoveUnit( dummy )

    call GroupClear( g )
    call DestroyGroup( g )
    set u = null
    set g = null
    set dummy = null
    set fx = null
endfunction

function CommandoQCast takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer( ) )
    local unit dummy = LoadUnitHandle( udg_hash, id, StringHash( "codq" ) )
    local real dmg = LoadReal( udg_hash, id, StringHash( "codqdmg" ) )
    local real x = LoadReal( udg_hash, id, StringHash( "codqx" ) )
    local real y = LoadReal( udg_hash, id, StringHash( "codqy" ) )
    local real xc = GetUnitX( dummy )
    local real yc = GetUnitY( dummy )
    local integer counter = LoadInteger( udg_hash, id, StringHash( "codq" ) ) + 1
    local real angle = Atan2( y - yc, x - xc )
    local real NewX = xc + 20 * Cos( angle )
    local real NewY = yc + 20 * Sin( angle )
    local real halftime = LoadReal( udg_hash, id, StringHash( "codqt" ) )
    local real IfX = ( x - xc ) * ( x - xc )
    local real IfY = ( y - yc ) * ( y - yc )
    local real IfS = SquareRoot( IfX + IfY )
    local real time = LoadReal( udg_hash, id, StringHash( "codqp" ) ) + 0.02
    local boolean l = LoadBoolean( udg_hash, id, StringHash( "codq" ))
    local integer id1

    if IfS < 50 or GetUnitState( dummy, UNIT_STATE_LIFE) <= 0.405 then
        if GetUnitState( dummy, UNIT_STATE_LIFE) > 0.405 then
            set time = halftime
            call SetUnitPosition( dummy, NewX, NewY )
            
            set id1 = GetHandleId( dummy )
            if LoadTimerHandle( udg_hash, id1, StringHash( "codq1" ) ) == null then
                call SaveTimerHandle( udg_hash, id1, StringHash( "codq1" ), CreateTimer() )
            endif
            set id1 = GetHandleId( LoadTimerHandle( udg_hash, id1, StringHash( "codq1" ) ) )
            call SaveUnitHandle( udg_hash, id1, StringHash( "codq1" ), dummy )
            call SaveReal( udg_hash, id1, StringHash( "codq1dmg" ), dmg )
            call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( dummy ), StringHash( "codq1" ) ), 2, false, function CommandoQEnd )
        endif
        call FlushChildHashtable( udg_hash, id ) 
        call DestroyTimer( GetExpiredTimer() )
    else
        call SaveInteger( udg_hash, id, StringHash( "codq" ), counter )
        call SetUnitPosition( dummy, NewX, NewY )
    endif
    if time >= halftime and not(l) then
        call SetUnitFlyHeight( dummy, -400, 800 )
        call SaveBoolean( udg_hash, id, StringHash( "codq" ), true )
    else
        call SaveReal( udg_hash, id, StringHash( "codqp" ), time )
    endif
    
    set dummy = null
endfunction

function Trig_GunMasterQ_Actions takes nothing returns nothing
    local real dmg
    local unit caster
    local integer lvl
    local real x
    local real y
    local real dx
    local real dy
    local real dist
    local real angle
    local integer id
    local real halftime
    
    if CastLogic() then
        set caster = udg_Caster
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
        set lvl = udg_Level
    elseif RandomLogic() then
        set caster = udg_Caster
        set lvl = udg_Level
        set dist = GetRandomReal( 0, 730 )
        set angle = GetRandomReal( 0, 360 ) * bj_DEGTORAD
        set x = GetUnitX( caster ) + dist * Cos( angle )
        set y = GetUnitY( caster ) + dist * Sin( angle )
        call textst( udg_string[0] + GetObjectName('A19H'), caster, 64, 90, 10, 1.5 )
    else
        set caster = GetSpellAbilityUnit()
        set lvl = GetUnitAbilityLevel(caster, GetSpellAbilityId())
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
    endif
    
    call dummyspawn( caster, 0, 'A19I', 0, 0 )
    call UnitAddAbility(bj_lastCreatedUnit, 'Amrf')
    
    set dmg = 100+(50*lvl)
    set dx = x - GetUnitX(bj_lastCreatedUnit)
    set dy = y - GetUnitY(bj_lastCreatedUnit)
    set dist = SquareRoot(dx * dx + dy * dy)
    
    set halftime = 0.02*0.5*(dist/20)

    call SetUnitFlyHeight( bj_lastCreatedUnit, 400, 800 )
    
    set id = GetHandleId( bj_lastCreatedUnit )
    if LoadTimerHandle( udg_hash, id, StringHash( "codq" ) ) == null then
        call SaveTimerHandle( udg_hash, id, StringHash( "codq" ), CreateTimer() )
    endif
    set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "codq" ) ) )
    call SaveUnitHandle( udg_hash, id, StringHash( "codq" ), bj_lastCreatedUnit)
    call SaveReal( udg_hash, id, StringHash( "codqx" ), x )
    call SaveReal( udg_hash, id, StringHash( "codqy" ), y )
    call SaveReal( udg_hash, id, StringHash( "codqt" ), halftime)
    call SaveReal( udg_hash, id, StringHash( "codqdmg" ), dmg)
    call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( bj_lastCreatedUnit ), StringHash( "codq" ) ), 0.02, true, function CommandoQCast )

    set caster = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_GunMasterQ = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_GunMasterQ, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trg_GunMasterQ, Condition( function Trig_GunMasterQ_Conditions ) )
    call TriggerAddAction( trg_GunMasterQ, function Trig_GunMasterQ_Actions )
endfunction

endscope

