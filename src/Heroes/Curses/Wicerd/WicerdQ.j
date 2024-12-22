scope WicerdQ initializer init

    globals
		trigger trg_WicerdQ = null
    endglobals
    
function Trig_WicerdQ_Conditions takes nothing returns boolean
    return GetSpellAbilityId( ) == 'A17J'
endfunction

function WicerdQMotion takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer() )
    local integer lvl = LoadInteger( udg_hash, id, StringHash( "wcrqlvl" ) )
    local real dmg = LoadReal( udg_hash, id, StringHash( "wcrq" ) )
    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "wcrqc" ) )
    local unit dummy = LoadUnitHandle( udg_hash, id, StringHash( "wcrq" ) )
    local real x = LoadReal( udg_hash, id, StringHash( "wcrqx" ) )
    local real y = LoadReal( udg_hash, id, StringHash( "wcrqy" ) )
    local real xc = GetUnitX( dummy )
    local real yc = GetUnitY( dummy )
    local real angle = Atan2( y - yc, x - xc )
    local real NewX = xc + 20 * Cos( angle )
    local real NewY = yc + 20 * Sin( angle )
    local real IfX = ( x - xc ) * ( x - xc )
    local real IfY = ( y - yc ) * ( y - yc )
    local group g = CreateGroup()
    local group nodmg = CreateGroup()
    local group cnldmg = LoadGroupHandle( udg_hash, id, StringHash( "wcrqg" ) )
    local unit u
    local boolean l = false
    local boolean k = LoadBoolean( udg_hash, id, StringHash( "wcrq" ) )
    local integer cyclA
    local integer id1
    local real tim

    call GroupEnumUnitsInRange( g, GetUnitX( dummy ), GetUnitY( dummy ), 150, null )
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        if unitst( u, caster, "enemy" ) and not( IsUnitInGroup( u, cnldmg ) ) then
            set l = true
        endif
        call GroupRemoveUnit(g,u)
    endloop
    
    if not(l) and SquareRoot( IfX + IfY ) > 10 and GetUnitState( dummy, UNIT_STATE_LIFE) > 0.405 then
        call SetUnitPosition( dummy, NewX, NewY )
    else
        set tim = timebonus(caster, 10)
        call DestroyEffect( AddSpecialEffect( "Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl", GetUnitX( dummy ), GetUnitY( dummy ) ) )
        call GroupEnumUnitsInRange( g, GetUnitX( dummy ), GetUnitY( dummy ), 200, null )
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            if unitst( u, caster, "enemy" ) then
                call GroupAddUnit( nodmg, u )
                call freezest( caster, u, tim, lvl )
                call UnitDamageTarget( caster, u, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )
            endif
            call GroupRemoveUnit(g,u)
        endloop

        if k then
            set dmg = dmg/3
            set cyclA = 1
            loop
                exitwhen cyclA > 3
                call dummyspawn( dummy, 0, 'A17K', 'A0N5', 0 )
                set id1 = GetHandleId( bj_lastCreatedUnit )

                call SaveTimerHandle( udg_hash, id1, StringHash( "wcrq" ), CreateTimer() )
                set id1 = GetHandleId( LoadTimerHandle( udg_hash, id1, StringHash( "wcrq" ) ) ) 
                call SaveUnitHandle( udg_hash, id1, StringHash( "wcrq" ), bj_lastCreatedUnit )
                call SaveUnitHandle( udg_hash, id1, StringHash( "wcrqc" ), caster )
                call SaveReal( udg_hash, id1, StringHash( "wcrqx" ), GetUnitX(dummy)+GetRandomReal(-500,500) )
                call SaveReal( udg_hash, id1, StringHash( "wcrqy" ), GetUnitY(dummy)+GetRandomReal(-500,500) )
                call SaveReal( udg_hash, id1, StringHash( "wcrq" ), dmg )
                call SaveInteger( udg_hash, id1, StringHash( "wcrqlvl" ), lvl )
                call SaveGroupHandle( udg_hash, id1, StringHash( "wcrqg" ), nodmg )
                call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( bj_lastCreatedUnit ), StringHash( "wcrq" ) ), 0.04, true, function WicerdQMotion )
                set cyclA = cyclA + 1
            endloop
        endif
        call RemoveUnit( dummy )
    	call DestroyGroup( cnldmg )
        call DestroyTimer( GetExpiredTimer() )
    endif
    
    call DestroyGroup( g )
    set cnldmg = null
    set nodmg = null
    set u = null
    set g = null
    set dummy = null
    set caster = null
endfunction    

function Trig_WicerdQ_Actions takes nothing returns nothing
    local integer id 
    local real dmg 
    local unit caster
    local integer lvl
    local real x
    local real y
    local real dist 
    local real angle 

    if CastLogic() then
        set caster = udg_Caster
        set lvl = udg_Level
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
    elseif RandomLogic() then
        set caster = udg_Caster
        set lvl = udg_Level
        call textst( udg_string[0] + GetObjectName('A0Q0'), caster, 64, 90, 10, 1.5 )
        set dist = GetRandomReal( 0, 730 )
        set angle = GetRandomReal( 0, 360 ) * bj_DEGTORAD
        set x = GetUnitX( caster ) + dist * Cos( angle )
        set y = GetUnitY( caster ) + dist * Sin( angle )
    else
        set caster = GetSpellAbilityUnit()
        set lvl = GetUnitAbilityLevel(caster, GetSpellAbilityId())
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
    endif
    
    set dmg = ( 60 + ( 40 * lvl ) ) * GetUnitSpellPower(caster)
    
    call dummyspawn( caster, 0, 'A17K', 'A0N5', 0 )

    set id = GetHandleId( bj_lastCreatedUnit )
    
    call SaveTimerHandle( udg_hash, id, StringHash( "wcrq" ), CreateTimer() )
	set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "wcrq" ) ) ) 
	call SaveUnitHandle( udg_hash, id, StringHash( "wcrq" ), bj_lastCreatedUnit )
    call SaveUnitHandle( udg_hash, id, StringHash( "wcrqc" ), caster )
    call SaveReal( udg_hash, id, StringHash( "wcrqx" ), x )
    call SaveReal( udg_hash, id, StringHash( "wcrqy" ), y )
    call SaveReal( udg_hash, id, StringHash( "wcrq" ), dmg )
    call SaveInteger( udg_hash, id, StringHash( "wcrqlvl" ), lvl )
    call SaveBoolean( udg_hash, id, StringHash( "wcrq" ), true )
	call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( bj_lastCreatedUnit ), StringHash( "wcrq" ) ), 0.04, true, function WicerdQMotion )
    
    set caster = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_WicerdQ = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_WicerdQ, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trg_WicerdQ, Condition( function Trig_WicerdQ_Conditions ) )
    call TriggerAddAction( trg_WicerdQ, function Trig_WicerdQ_Actions )
endfunction

endscope