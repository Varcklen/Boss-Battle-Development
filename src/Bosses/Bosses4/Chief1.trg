{
  "Id": 50333502,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Chief1_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventSource) == 'h01X'\r\nendfunction\r\n\r\nfunction Trig_Chief1_Actions takes nothing returns nothing\r\n    set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( udg_DamageEventSource ), 'u000', GetUnitX( udg_DamageEventTarget ), GetUnitY( udg_DamageEventTarget ), 270 )\r\n    call UnitAddAbility( bj_lastCreatedUnit, 'A16V')\r\n    call UnitApplyTimedLife( bj_lastCreatedUnit, 'BTLF', 1)\r\n    call IssuePointOrder( bj_lastCreatedUnit, \"silence\", GetUnitX( bj_lastCreatedUnit ), GetUnitY( bj_lastCreatedUnit ) )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Chief1 takes nothing returns nothing\r\n    set gg_trg_Chief1 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Chief1 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Chief1, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Chief1, Condition( function Trig_Chief1_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Chief1, function Trig_Chief1_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}