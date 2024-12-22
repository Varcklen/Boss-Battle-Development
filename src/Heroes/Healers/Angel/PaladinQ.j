scope PaladinHeroQ initializer init

    globals
		trigger trg_PalaQ = null
    endglobals
    
function Trig_AngelQ_Conditions takes nothing returns boolean
    return GetSpellAbilityId( ) == 'A0BU'
endfunction

function AngelQCast takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer() )
    local integer counter = LoadInteger( udg_hash, id, StringHash( "angq" ) )
    local integer lvl = LoadInteger( udg_hash, id, StringHash( "angqlvl" ) )
    local unit dummy = LoadUnitHandle( udg_hash, id, StringHash( "angq1" ) )
    local unit dummy1 = LoadUnitHandle( udg_hash, id, StringHash( "angq2" ) )
    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "angq" ) )
    local group g = CreateGroup()
    local unit u
    local real dmg = LoadReal( udg_hash, id, StringHash( "angq" ) )
    local real x = LoadReal( udg_hash, id, StringHash( "angqx" ) )
    local real y = LoadReal( udg_hash, id, StringHash( "angqy" ) )
    
    call DestroyEffect( AddSpecialEffect("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl", x, y ) )
    call GroupEnumUnitsInRange( g, x, y, 250, null )
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        if unitst( u, caster, "ally" ) then
            call healst( caster, u, dmg )
        elseif unitst( u, caster, "enemy" ) then
            call UnitDamageTarget( dummy1, u, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )
        endif
        call GroupRemoveUnit(g,u)
    endloop
    if lvl < 5 then 
        call IssuePointOrder( dummy, "silence", x, y )
    endif
    
    if counter > 0 and GetUnitState( dummy, UNIT_STATE_LIFE) > 0.405 then
        call SaveInteger( udg_hash, id, StringHash( "angq" ), counter - 1 )
    else
        call RemoveUnit( dummy )
        call RemoveUnit( dummy1 )
        call FlushChildHashtable( udg_hash, id )
        call DestroyTimer( GetExpiredTimer() )
    endif
    
    call GroupClear( g )
    call DestroyGroup( g )
    set u = null
    set g = null
    set dummy = null
    set dummy1 = null
    set caster = null
endfunction

function Trig_AngelQ_Actions takes nothing returns nothing
    local unit dummy
    local unit dummy1 
    local integer id 
    local unit caster
    local integer lvl
    local real x
    local real y
    local real dist 
    local real angle 
    local real dmg
    
    if CastLogic() then
        set caster = udg_Caster
        set lvl = udg_Level
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
    elseif RandomLogic() then
        set caster = udg_Caster
        set lvl = udg_Level
        set dist = GetRandomReal( 0, 730 )
        set angle = GetRandomReal( 0, 360 ) * bj_DEGTORAD
        set x = GetUnitX( caster ) + dist * Cos( angle )
        set y = GetUnitY( caster ) + dist * Sin( angle )
        call textst( udg_string[0] + GetObjectName('A0BU'), caster, 64, 90, 10, 1.5 )
    else
        set caster = GetSpellAbilityUnit()
        set lvl = GetUnitAbilityLevel(caster, GetSpellAbilityId())
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
    endif

    set dmg = ( 8 + ( 8 * lvl ) ) * GetUnitSpellPower(caster)
    set dummy = CreateUnit( Player( PLAYER_NEUTRAL_AGGRESSIVE ), 'u000', x, y, bj_UNIT_FACING )
    set dummy1 = CreateUnit( GetOwningPlayer( caster ), 'u000', x, y, bj_UNIT_FACING )
    
    if GetUnitAbilityLevel( caster, 'A0BU') < 5  then
        call UnitAddAbility( dummy, 'A0C0' )
    endif
    call UnitAddAbility( dummy, 'A109' )
    call SetUnitScale( dummy, 2,  2, 2 )
     
    set id = GetHandleId( dummy ) 
    call SaveTimerHandle( udg_hash, id, StringHash( "angq" ), CreateTimer() )
	set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "angq" ) ) ) 
	call SaveUnitHandle( udg_hash, id, StringHash( "angq" ), caster )
    call SaveUnitHandle( udg_hash, id, StringHash( "angq1" ), dummy )
    call SaveUnitHandle( udg_hash, id, StringHash( "angq2" ), dummy1 )
    call SaveInteger( udg_hash, id, StringHash( "angq" ), 15 )
    call SaveInteger( udg_hash, id, StringHash( "angqlvl" ), lvl )
    call SaveReal( udg_hash, id, StringHash( "angq" ), dmg )
    call SaveReal( udg_hash, id, StringHash( "angqx" ), x )
    call SaveReal( udg_hash, id, StringHash( "angqy" ), y )
	call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( dummy ), StringHash( "angq" ) ), 1, true, function AngelQCast )
    
    set dummy = null
    set dummy1 = null
    set caster = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_PalaQ = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_PalaQ, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trg_PalaQ, Condition( function Trig_AngelQ_Conditions ) )
    call TriggerAddAction( trg_PalaQ, function Trig_AngelQ_Actions )
endfunction

endscope

