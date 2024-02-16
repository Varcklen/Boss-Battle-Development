{
  "Id": 50332428,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Exp_Drain_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0FR'\r\nendfunction\r\n\r\nfunction Trig_Exp_Drain_Actions takes nothing returns nothing\r\n    call statst( GetSpellTargetUnit(), 2, 2, 2, 0, true )\r\n    call SetHeroLevel( GetSpellTargetUnit(), GetHeroLevel(GetSpellTargetUnit()) + 1, true)\r\n\r\n    set udg_logic[GetPlayerId(GetOwningPlayer(GetSpellAbilityUnit())) + 1 + 43] = true\r\n    call stazisst( GetSpellAbilityUnit(), GetItemOfTypeFromUnitBJ( GetSpellAbilityUnit(), 'I08A') )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Exp_Drain takes nothing returns nothing\r\n    set gg_trg_Exp_Drain = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Exp_Drain, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Exp_Drain, Condition( function Trig_Exp_Drain_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Exp_Drain, function Trig_Exp_Drain_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}