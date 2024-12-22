scope PriestessR initializer init

    globals
		trigger trg_PriestessR = null
    endglobals
    
function Trig_PriestessR_Conditions takes nothing returns boolean
    return GetSpellAbilityId( ) == 'A056'
endfunction

function Trig_PriestessR_Actions takes nothing returns nothing
    local integer id 
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
        call textst( udg_string[0] + GetObjectName('A056'), caster, 64, 90, 10, 1.5 )
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
    
    set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( caster ), 'h018', x, y, 270 )
    call UnitApplyTimedLife( bj_lastCreatedUnit, 'BTLF', 40 )
    call DestroyEffect( AddSpecialEffectTarget( "Objects\\Spawnmodels\\Undead\\UCancelDeath\\UCancelDeath.mdl", bj_lastCreatedUnit, "origin" ) )
    //call UnitAddAbility( bj_lastCreatedUnit, 'A055' )
    call SetUnitAbilityLevel( bj_lastCreatedUnit, 'A055', lvl )
    
    set caster = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_PriestessR = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_PriestessR, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trg_PriestessR, Condition( function Trig_PriestessR_Conditions ) )
    call TriggerAddAction( trg_PriestessR, function Trig_PriestessR_Actions )
endfunction

endscope