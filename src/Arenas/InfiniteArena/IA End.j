function Trig_IA_End_Conditions takes nothing returns boolean
    return udg_fightmod[2] and DeathIf(GetDyingUnit())
endfunction

function Trig_IA_End_Actions takes nothing returns nothing
    local integer i = GetPlayerId(GetOwningPlayer(GetDyingUnit())) + 1

    if udg_LvL[i] <= 5 then
        call DisplayTimedTextToPlayer( Player(i-1), 0, 0, 20, "|cffff0000Warning!|r |cffffcc00Death in this arena will not bring defeat.|r" )
    endif
    call GroupRemoveUnit( udg_otryad, GetDyingUnit() )
    call GroupAddUnit( udg_DeadHero, GetDyingUnit())
    set udg_Heroes_Deaths = udg_Heroes_Deaths + 1
    if udg_Heroes_Deaths == udg_Heroes_Amount then
        call DisableTrigger( GetTriggeringTrigger() )
        call Between( "end_IA" )
    endif
endfunction

//===========================================================================
function InitTrig_IA_End takes nothing returns nothing
    set gg_trg_IA_End = CreateTrigger(  )
    call DisableTrigger( gg_trg_IA_End )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_IA_End, EVENT_PLAYER_UNIT_DEATH )
    call TriggerAddCondition( gg_trg_IA_End, Condition( function Trig_IA_End_Conditions ) )
    call TriggerAddAction( gg_trg_IA_End, function Trig_IA_End_Actions )
endfunction