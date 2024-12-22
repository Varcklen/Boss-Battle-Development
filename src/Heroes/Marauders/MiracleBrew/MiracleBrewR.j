scope MiracleBrewR initializer init

    globals
		trigger trg_MiracleBrewR = null
    endglobals
    
function Trig_MiracleBrewR_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0RT'
endfunction

function Trig_MiracleBrewR_Actions takes nothing returns nothing
    local unit caster
    local integer lvl
    local integer cyclA
    local real dmg
    local real x
    local real y
    local real dist 
    local real angle 
    local unit target = null
    
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
        call textst( udg_string[0] + GetObjectName('A0RT'), caster, 64, 90, 10, 1.5 )
    else
        set caster = GetSpellAbilityUnit()
        set lvl = GetUnitAbilityLevel(caster, GetSpellAbilityId())
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
    endif
    
    set dmg = 75 + ( 50 * lvl )
    
    set cyclA = 1
    loop
        exitwhen cyclA > 3
        call dummyspawn( caster, 3, 'A087', 0, 0 )
        if cyclA > 1 then
        	set target = randomtarget( caster, 650, "enemy", 0, 0, 0 )
        	if target == null then
        		set dist = GetRandomReal( 0, 650 )
        		set angle = GetRandomReal( 0, 360 ) * bj_DEGTORAD
        		set x = GetUnitX( caster ) + dist * Cos( angle )
        		set y = GetUnitY( caster ) + dist * Sin( angle )
        	else
        		set dist = GetRandomReal( 0, 150 )
        		set angle = GetRandomReal( 0, 360 ) * bj_DEGTORAD
        		set x = GetUnitX( caster ) + dist * Cos( angle )
        		set y = GetUnitY( caster ) + dist * Sin( angle )
        	endif
        endif
        call IssuePointOrder( bj_lastCreatedUnit, "move", x, y )
        call SetUnitMoveSpeed( bj_lastCreatedUnit, 400. )
        call SaveUnitHandle( udg_hash, GetHandleId( bj_lastCreatedUnit ), StringHash( "mrbr" ), caster )
        call SaveReal( udg_hash, GetHandleId( bj_lastCreatedUnit ), StringHash( "mrbr" ), dmg )
        set cyclA = cyclA + 1
    endloop
    
    set target = null
    set caster = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_MiracleBrewR = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_MiracleBrewR, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trg_MiracleBrewR, Condition( function Trig_MiracleBrewR_Conditions ) )
    call TriggerAddAction( trg_MiracleBrewR, function Trig_MiracleBrewR_Actions )
endfunction

endscope

