{
  "Id": 50333548,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MoonPriest4_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( udg_DamageEventTarget ) == 'e005' and GetUnitLifePercent(udg_DamageEventTarget) <= 20\r\nendfunction\r\n\r\nfunction Trig_MoonPriest4_Actions takes nothing returns nothing\r\n\tlocal integer i = 1\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    \r\n    loop\r\n    \texitwhen i > 4\r\n    \tcall MoonPriest1_CreateCrystal(udg_DamageEventTarget)\r\n    \tset i = i + 1\r\n\tendloop\r\n    \r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MoonPriest4 takes nothing returns nothing\r\n    set gg_trg_MoonPriest4 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_MoonPriest4 )\r\n    call TriggerRegisterVariableEvent( gg_trg_MoonPriest4, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_MoonPriest4, Condition( function Trig_MoonPriest4_Conditions ) )\r\n    call TriggerAddAction( gg_trg_MoonPriest4, function Trig_MoonPriest4_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}