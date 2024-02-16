{
  "Id": 50333510,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Banshi1_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'n03M' \r\nendfunction\r\n\r\nfunction Trig_Banshi1_Actions takes nothing returns nothing\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call UnitAddAbility( udg_DamageEventTarget, 'A0W8' )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Banshi1 takes nothing returns nothing\r\n    set gg_trg_Banshi1 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Banshi1 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Banshi1, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Banshi1, Condition( function Trig_Banshi1_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Banshi1, function Trig_Banshi1_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}