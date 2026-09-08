{
  "Id": 50333578,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Zapper4_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'n00Q' and GetUnitLifePercent(udg_DamageEventTarget) <= 30\r\nendfunction\r\n\r\nfunction Trig_Zapper4_Actions takes nothing returns nothing\r\n    local unit boss = udg_DamageEventTarget\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call Zapper3_MakeExplode(boss, GetRectCenterX(udg_Boss_Rect) + 1100, GetRectCenterY(udg_Boss_Rect) - 1000, Zapper3_AREA_SIZE )\r\n    call Zapper3_MakeExplode(boss, GetRectCenterX(udg_Boss_Rect) - 1100, GetRectCenterY(udg_Boss_Rect) - 1000, Zapper3_AREA_SIZE )\r\n    \r\n    set boss = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Zapper4 takes nothing returns nothing\r\n    set gg_trg_Zapper4 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Zapper4 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Zapper4, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Zapper4, Condition( function Trig_Zapper4_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Zapper4, function Trig_Zapper4_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}