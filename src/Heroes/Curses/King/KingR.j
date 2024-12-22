scope GhoulKingR initializer init

    globals
		trigger trg_KingR = null
    endglobals
    
function Trig_KingR_Conditions takes nothing returns boolean
    return GetSpellAbilityId( ) == 'A0Q5'
endfunction

function KingRMotion takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer() )
    local integer lvl = LoadInteger( udg_hash, id, StringHash( "kngr" ) )
    local real dmg = LoadReal( udg_hash, id, StringHash( "kngr" ) )
    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "kngrc" ) )
    local unit dummy = LoadUnitHandle( udg_hash, id, StringHash( "kngr" ) )
    local real x = LoadReal( udg_hash, id, StringHash( "kngrx" ) )
    local real y = LoadReal( udg_hash, id, StringHash( "kngry" ) )
    local real xc = GetUnitX( dummy )
    local real yc = GetUnitY( dummy )
    local real angle = Atan2( y - yc, x - xc )
    local real NewX = xc + 20 * Cos( angle )
    local real NewY = yc + 20 * Sin( angle )
    local real IfX = ( x - xc ) * ( x - xc )
    local real IfY = ( y - yc ) * ( y - yc )
    local group g = CreateGroup()
    local unit u
    local boolean l = false
    local real r

    call GroupEnumUnitsInRange( g, GetUnitX( dummy ), GetUnitY( dummy ), 150, null )
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        if unitst( u, caster, "enemy" ) then
            set l = true
        endif
        call GroupRemoveUnit(g,u)
        set u = FirstOfGroup(g)
    endloop
    
    if not(l) and SquareRoot( IfX + IfY ) > 10 and GetUnitState( dummy, UNIT_STATE_LIFE) > 0.405 then
        call SetUnitPosition( dummy, NewX, NewY )
    else
        set r = 0.75+(0.25*lvl)
        call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Other\\HowlOfTerror\\HowlCaster.mdl", GetUnitX( dummy ), GetUnitY( dummy ) ) )
        call GroupEnumUnitsInRange( g, GetUnitX( dummy ), GetUnitY( dummy ), 300, null )
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            if unitst( u, caster, "enemy" ) then
                call UnitStun(caster, u, r )
                call UnitDamageTarget( caster, u, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )
            endif
            call GroupRemoveUnit(g,u)
        endloop
        call RemoveUnit( dummy )
        call FlushChildHashtable( udg_hash, id )
        call DestroyTimer( GetExpiredTimer() )
    endif
    
    call DestroyGroup( g )
    set u = null
    set g = null
    set dummy = null
    set caster = null
endfunction   

function Trig_KingR_Actions takes nothing returns nothing
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
        call textst( udg_string[0] + GetObjectName('A0Q5'), caster, 64, 90, 10, 1.5 )
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
    
    set dmg = ( 100 + ( 50 * lvl ) ) * GetUnitSpellPower(caster)
    
    call dummyspawn( caster, 0, 'A0Q3', 'A0Q4', 0 )
    call SetUnitFacing( bj_lastCreatedUnit, GetUnitFacing( caster ) )

    set id = GetHandleId( bj_lastCreatedUnit )
    
    call SaveTimerHandle( udg_hash, id, StringHash( "kngr" ), CreateTimer() )
	set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "kngr" ) ) ) 
	call SaveUnitHandle( udg_hash, id, StringHash( "kngr" ), bj_lastCreatedUnit )
    call SaveUnitHandle( udg_hash, id, StringHash( "kngrc" ), caster )
    call SaveReal( udg_hash, id, StringHash( "kngrx" ), x )
    call SaveReal( udg_hash, id, StringHash( "kngry" ), y )
    call SaveReal( udg_hash, id, StringHash( "kngr" ), dmg )
    call SaveInteger( udg_hash, id, StringHash( "kngr" ), lvl )
	call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( bj_lastCreatedUnit ), StringHash( "kngr" ) ), 0.04, true, function KingRMotion )
    
    set caster = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_KingR = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_KingR, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trg_KingR, Condition( function Trig_KingR_Conditions ) )
    call TriggerAddAction( trg_KingR, function Trig_KingR_Actions )
endfunction

endscope