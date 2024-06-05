{
  "Id": 50333604,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Woodo6_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'o000' and GetUnitLifePercent(udg_DamageEventTarget) <= 20\r\nendfunction\r\n\r\nfunction Trig_Woodo6_Actions takes nothing returns nothing\r\n    local integer i\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n\r\n\tset i = 1\r\n\tloop\r\n        exitwhen i > 5\r\n        call SummonRandomVoodoTotem(udg_DamageEventTarget)\r\n        set i = i + 1\r\n    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Woodo6 takes nothing returns nothing\r\n    set gg_trg_Woodo6 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Woodo6 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Woodo6, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Woodo6, Condition( function Trig_Woodo6_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Woodo6, function Trig_Woodo6_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}