{
  "Id": 50333532,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": true,
  "Script": "function Trig_Salamander2_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'n041' and GetUnitLifePercent(udg_DamageEventTarget) <= 25\r\nendfunction\r\n\r\nfunction Trig_Salamander2_Actions takes nothing returns nothing\r\n    local integer id = GetHandleId( udg_DamageEventTarget )\r\n    local unit boss = udg_DamageEventTarget\r\n    call UnitAddAbilityBJ( 'A0JT', boss )\r\n    call PolledWait( 30 )\r\n    call UnitRemoveAbilityBJ( 'A0JT', boss )\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    \r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Salamander2 takes nothing returns nothing\r\n    set gg_trg_Salamander2 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Salamander2 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Salamander2, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Salamander2, Condition( function Trig_Salamander2_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Salamander2, function Trig_Salamander2_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}