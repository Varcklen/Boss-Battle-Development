scope NinjaR initializer init

    globals
		trigger trg_NinjaR = null
    endglobals
    
function Trig_NinjaR_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0MB'
endfunction

function Trig_NinjaR_Actions takes nothing returns nothing
    local unit caster
    local integer lvl
    local real x
    local real y
    local real dist 
    local real angle 
    
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
        call textst( udg_string[0] + GetObjectName('A0MB'), caster, 64, 90, 10, 1.5 )
    else
        set caster = GetSpellAbilityUnit()
        set lvl = GetUnitAbilityLevel(caster, GetSpellAbilityId())
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
    endif

        set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( caster ), 'u000', x, y, 270 ) 
        call UnitAddAbility( bj_lastCreatedUnit, 'A0ME')
        call UnitApplyTimedLife( bj_lastCreatedUnit, 'BTLF', 8+(2*lvl))
    	call DestroyEffect( AddSpecialEffect("Abilities\\Spells\\Human\\FlakCannons\\FlakTarget.mdl", x, y ) )

    set caster = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_NinjaR = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_NinjaR, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trg_NinjaR, Condition( function Trig_NinjaR_Conditions ) )
    call TriggerAddAction( trg_NinjaR, function Trig_NinjaR_Actions )
endfunction

endscope

