{
  "Id": 50333696,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_IA_End_Conditions takes nothing returns boolean\r\n    return udg_fightmod[2] and DeathIf(GetDyingUnit())\r\nendfunction\r\n\r\nfunction Trig_IA_End_Actions takes nothing returns nothing\r\n    local integer i = GetPlayerId(GetOwningPlayer(GetDyingUnit())) + 1\r\n\r\n    if udg_LvL[i] <= 5 then\r\n        call DisplayTimedTextToPlayer( Player(i-1), 0, 0, 20, \"|cffff0000Warning!|r |cffffcc00Death in this arena will not bring defeat.|r\" )\r\n    endif\r\n    call GroupRemoveUnit( udg_otryad, GetDyingUnit() )\r\n    call GroupAddUnit( udg_DeadHero, GetDyingUnit())\r\n    set udg_Heroes_Deaths = udg_Heroes_Deaths + 1\r\n    if udg_Heroes_Deaths == udg_Heroes_Amount then\r\n        call DisableTrigger( GetTriggeringTrigger() )\r\n        call Between( \"end_IA\" )\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_IA_End takes nothing returns nothing\r\n    set gg_trg_IA_End = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_IA_End )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_IA_End, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_IA_End, Condition( function Trig_IA_End_Conditions ) )\r\n    call TriggerAddAction( gg_trg_IA_End, function Trig_IA_End_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}