scope DealerR initializer init

    globals
    constant real BERRY_DEALER_R_BANANA_LIFE_TIME = 60
	trigger trg_DealerR = null
endglobals

function Trig_DealerR_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A189'
endfunction

function Trig_DealerR_Actions takes nothing returns nothing
    local unit caster
    local integer lvl
    local real x
    local real y
    local real dist
    local real angle
    local integer id
	local integer cyclA = 1
	local integer cyclAEnd
    
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
        call textst( udg_string[0] + GetObjectName('A189'), caster, 64, 90, 10, 1.5 )
    else
        set caster = GetSpellAbilityUnit()
        set lvl = GetUnitAbilityLevel(caster, GetSpellAbilityId())
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
    endif
    
	set cyclAEnd = lvl+1
	loop
		exitwhen cyclA > cyclAEnd
        call SpawnBanana( caster, Math_GetRandomX(x, 300), Math_GetRandomY(y, 300) )
		set cyclA = cyclA + 1
	endloop
	
    set caster = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_DealerR = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_DealerR, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trg_DealerR, Condition( function Trig_DealerR_Conditions ) )
    call TriggerAddAction( trg_DealerR, function Trig_DealerR_Actions )
endfunction

endscope

