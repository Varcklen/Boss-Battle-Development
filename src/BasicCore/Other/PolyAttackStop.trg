{
  "Id": 50332198,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_PolyAttackStop_Conditions takes nothing returns boolean\r\n    return GetUnitAbilityLevel(GetAttacker(), 'A1A0') > 0\r\nendfunction\r\n\r\nfunction Trig_PolyAttackStop_Actions takes nothing returns nothing\r\n    call IssueImmediateOrder( GetAttacker(), \"stop\" )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_PolyAttackStop takes nothing returns nothing\r\n    set gg_trg_PolyAttackStop = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_PolyAttackStop, EVENT_PLAYER_UNIT_ATTACKED )\r\n    call TriggerAddCondition( gg_trg_PolyAttackStop, Condition( function Trig_PolyAttackStop_Conditions ) )\r\n    call TriggerAddAction( gg_trg_PolyAttackStop, function Trig_PolyAttackStop_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}