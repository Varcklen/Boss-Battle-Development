{
  "Id": 50333456,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Sheep4_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'n007' and GetUnitLifePercent(udg_DamageEventTarget) <= 25.\r\nendfunction\r\n\r\nfunction Trig_Sheep4_Actions takes nothing returns nothing\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call Sheep2_SheepSummon(udg_DamageEventTarget)\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Sheep4 takes nothing returns nothing\r\n    set gg_trg_Sheep4 = CreateTrigger()\r\n    call DisableTrigger( gg_trg_Sheep4 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Sheep4, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Sheep4, Condition( function Trig_Sheep4_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Sheep4, function Trig_Sheep4_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}