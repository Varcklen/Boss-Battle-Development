{
  "Id": 50333623,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Heuz5_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'e008'\r\nendfunction\r\n\r\nfunction Trig_Heuz5_Actions takes nothing returns nothing\r\n    set heuz = udg_DamageEventTarget\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Heuz5 takes nothing returns nothing\r\n    set gg_trg_Heuz5 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Heuz5 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Heuz5, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Heuz5, Condition( function Trig_Heuz5_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Heuz5, function Trig_Heuz5_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}