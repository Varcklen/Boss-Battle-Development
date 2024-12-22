scope PredatorR initializer init

    globals
		trigger trg_PredatorR = null
    endglobals
    
function Trig_PredatorR_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A15T'
endfunction

function Trig_PredatorR_Actions takes nothing returns nothing
    local unit caster
    local integer lvl
    local real x
    local real y
    local real dist 
    local real angle 
    local integer id
    
    if CastLogic() then
        set caster = udg_Target
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
        call textst( udg_string[0] + GetObjectName('A15T'), caster, 64, 90, 10, 1.5 )
    else
        set caster = GetSpellAbilityUnit()
        set lvl = GetUnitAbilityLevel(caster, GetSpellAbilityId())
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
    endif
    
        set bj_lastCreatedUnit = CreateUnit(GetOwningPlayer(caster), 'u000', x, y, 270 )
	call UnitAddAbility( bj_lastCreatedUnit, 'A15U' ) 
    	call SetUnitAbilityLevel( bj_lastCreatedUnit, 'A15U', lvl )
	call UnitApplyTimedLife( bj_lastCreatedUnit, 'BTLF', 20 )

    set caster = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_PredatorR = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_PredatorR, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trg_PredatorR, Condition( function Trig_PredatorR_Conditions ) )
    call TriggerAddAction( trg_PredatorR, function Trig_PredatorR_Actions )
endfunction

endscope

