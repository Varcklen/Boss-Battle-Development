{
  "Id": 50333518,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_GhostKnight2_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( udg_DamageEventTarget ) == 'n008' and GetUnitLifePercent(udg_DamageEventTarget) <= 50\r\nendfunction\r\n\r\nfunction Trig_GhostKnight2_Actions takes nothing returns nothing\r\n    local integer id = GetHandleId( udg_DamageEventTarget )\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    \r\n    call InvokeTimerWithUnit( udg_DamageEventTarget, \"bsgk1\", bosscast(3), true, function GhostKnight1_GhostKnightCast1 )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_GhostKnight2 takes nothing returns nothing\r\n    set gg_trg_GhostKnight2 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_GhostKnight2 )\r\n    call TriggerRegisterVariableEvent( gg_trg_GhostKnight2, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_GhostKnight2, Condition( function Trig_GhostKnight2_Conditions ) )\r\n    call TriggerAddAction( gg_trg_GhostKnight2, function Trig_GhostKnight2_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}