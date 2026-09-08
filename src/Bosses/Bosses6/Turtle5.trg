{
  "Id": 50333559,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Turtle5_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( udg_DamageEventTarget ) == 'h01R' and GetUnitLifePercent(udg_DamageEventTarget) <= 25\r\nendfunction\r\n\r\nfunction Trig_Turtle5_Actions takes nothing returns nothing\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n\tcall Turtle4_SpawnEggs(udg_DamageEventTarget)\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Turtle5 takes nothing returns nothing\r\n    set gg_trg_Turtle5 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Turtle5 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Turtle5, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Turtle5, Condition( function Trig_Turtle5_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Turtle5, function Trig_Turtle5_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}