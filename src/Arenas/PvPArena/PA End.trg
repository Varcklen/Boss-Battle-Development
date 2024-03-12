{
  "Id": 50333700,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_PA_End_Conditions takes nothing returns boolean\r\n    return DeathSystem_IsUnkillable(GetDyingUnit()) == false and GetUnitAbilityLevel(GetDyingUnit(), 'A05X') == 0 and ( GetDyingUnit() == udg_unit[57] or GetDyingUnit() == udg_unit[58] ) and not( IsUnitInGroup(GetDyingUnit(), udg_Return) )\r\nendfunction\r\n\r\nfunction Trig_PA_End_Actions takes nothing returns nothing \r\n    local integer i = GetPlayerId(GetOwningPlayer(udg_unit[57])) + 1\r\n    local integer p = GetPlayerId(GetOwningPlayer(udg_unit[58])) + 1\r\n    \r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n     if not( udg_logic[62] ) then\r\n        if GetDyingUnit() == udg_unit[57] then\r\n            call DisplayTimedTextToForce( bj_FORCE_ALL_PLAYERS, 2, \"Winner: \" + udg_Player_Color[p] + GetPlayerName(GetOwningPlayer(udg_unit[58])) )\r\n        else\r\n            call DisplayTimedTextToForce( bj_FORCE_ALL_PLAYERS, 2, \"Winner: \" + udg_Player_Color[i] + GetPlayerName(GetOwningPlayer(udg_unit[57])) )\r\n        endif\r\n    endif\r\n    call Between( \"end_PA\" )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_PA_End takes nothing returns nothing\r\n    set gg_trg_PA_End = CreateTrigger()\r\n    call DisableTrigger( gg_trg_PA_End )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_PA_End, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_PA_End, Condition( function Trig_PA_End_Conditions ) )\r\n    call TriggerAddAction( gg_trg_PA_End, function Trig_PA_End_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}