scope ShamanW initializer init

    globals
		trigger trg_ShamanW = null
    endglobals
    
function Trig_ShamanW_Conditions takes nothing returns boolean
    return GetSpellAbilityId( ) == 'A0W5'
endfunction

function Trig_ShamanW_Actions takes nothing returns nothing
    local integer id 
    local unit caster
    local integer lvl
    local real x
    local real y
    local real dist 
    local real angle 
    local integer hp
    local integer dmg

    if CastLogic() then
        set caster = udg_Caster
        set lvl = udg_Level
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
    elseif RandomLogic() then
        set caster = udg_Caster
        set lvl = udg_Level
        call textst( udg_string[0] + GetObjectName('A0W5'), caster, 64, 90, 10, 1.5 )
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
    set hp = 500+(500*lvl)
    set dmg = 1 + ( 2 * lvl )
    
    set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer(caster), 'h01V', x, y, 270 )//Player( 10 )
    call BlzSetUnitMaxHP( bj_lastCreatedUnit, hp )
    call SetUnitState( bj_lastCreatedUnit, UNIT_STATE_LIFE, GetUnitState( bj_lastCreatedUnit, UNIT_STATE_LIFE) + hp )
    call UnitApplyTimedLife( bj_lastCreatedUnit , 'BTLF', 30 )
    call SaveInteger( udg_hash, GetHandleId(bj_lastCreatedUnit), StringHash( "ches" ), dmg )
    call SaveUnitHandle( udg_hash, GetHandleId(bj_lastCreatedUnit), StringHash( "ches" ), caster )
    
    set caster = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_ShamanW = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_ShamanW, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trg_ShamanW, Condition( function Trig_ShamanW_Conditions ) )
    call TriggerAddAction( trg_ShamanW, function Trig_ShamanW_Actions )
endfunction

endscope