scope FallenOneR initializer init

    globals
		trigger trg_FallenOneR = null
    endglobals
    
function Trig_FallenOneR_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A085'
endfunction

function FallenOneREnd takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer( ) )
    local real dmg = LoadReal( udg_hash, id, StringHash( "flnr" ) )
    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "flnrc" ) )
    local real coef = LoadReal( udg_hash, id, StringHash( "flnrc" ) )
    local real x = LoadReal( udg_hash, id, StringHash( "flnrx" ) )
    local real y = LoadReal( udg_hash, id, StringHash( "flnry" ) )
    local unit dummy = LoadUnitHandle( udg_hash, id, StringHash( "flnr" ) )
    local group g = CreateGroup()
    local unit u
    local effect fx
    local real c

    set fx = AddSpecialEffect( "Desecrate.mdx", x, y )
    call BlzSetSpecialEffectScale( fx, 2 )
    call DestroyEffect( fx )
    call GroupEnumUnitsInRange( g, x, y, 400, null )
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        if unitst( u, dummy, "enemy" ) then
            set c = GetUnitState( u, UNIT_STATE_MAX_LIFE)*coef
            call UnitTakeDamage( caster, u, dmg+c, DAMAGE_TYPE_MAGIC )
        endif
        call GroupRemoveUnit(g,u)
    endloop
    
    call RemoveUnit( dummy )
    call FlushChildHashtable( udg_hash, id )
    
    call GroupClear( g )
    call DestroyGroup( g )
    set g = null
    set u = null
    set dummy = null
    set caster = null
    set fx = null
endfunction

function Trig_FallenOneR_Actions takes nothing returns nothing
    local unit caster
    local real x
    local real y
    local real dist 
    local real angle 
    local integer lvl
    local integer id
    local real dmg
    local real coef
    
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
        call textst( udg_string[0] + GetObjectName('A085'), caster, 64, 90, 10, 1.5 )
    else
        set caster = GetSpellAbilityUnit()
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
        set lvl = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    endif
    if lvl > 4 then
        set lvl = 4
    endif
    set dmg = (100+(100 * lvl)) * GetUnitSpellPower(caster)
    set coef = 0.01+(lvl*0.01)
    
    call dummyspawn( caster, 0, 'A0N5', 0, 0 )
    call DestroyEffect( AddSpecialEffect( "war3mapImported\\MagicCircle_Devil.mdx", x, y ) )
    
    set id = GetHandleId( bj_lastCreatedUnit )
    if LoadTimerHandle( udg_hash, id, StringHash( "flnr" ) ) == null  then
        call SaveTimerHandle( udg_hash, id, StringHash( "flnr" ), CreateTimer() )
    endif
    set id = GetHandleId( LoadTimerHandle(udg_hash, id, StringHash( "flnr" ) ) )
    call SaveUnitHandle( udg_hash, id, StringHash( "flnr" ), bj_lastCreatedUnit )
    call SaveUnitHandle( udg_hash, id, StringHash( "flnrc" ), caster )
    call SaveReal( udg_hash, id, StringHash( "flnr" ), dmg )
    call SaveReal( udg_hash, id, StringHash( "flnrc" ), coef )
    call SaveReal( udg_hash, id, StringHash( "flnrx" ), x )
    call SaveReal( udg_hash, id, StringHash( "flnry" ), y )
    call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( bj_lastCreatedUnit ), StringHash( "flnr" ) ), 2, false, function FallenOneREnd )
    
    set caster = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_FallenOneR = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_FallenOneR, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trg_FallenOneR, Condition( function Trig_FallenOneR_Conditions ) )
    call TriggerAddAction( trg_FallenOneR, function Trig_FallenOneR_Actions )
endfunction

endscope

