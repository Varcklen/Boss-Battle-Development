{
  "Id": 50333572,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Wyrm3_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventSource) == 'e00G' and GetUnitTypeId(udg_DamageEventTarget) == 'o00M'\r\nendfunction\r\n\r\nfunction Trig_Wyrm3_Actions takes nothing returns nothing\r\n    set udg_DamageEventAmount = GetUnitState( udg_DamageEventTarget, UNIT_STATE_MAX_LIFE)*0.075\r\n    if GetUnitState( udg_DamageEventSource, UNIT_STATE_LIFE) > 0.405 then\r\n        call KillUnit( udg_DamageEventSource )\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Wyrm3 takes nothing returns nothing\r\n    set gg_trg_Wyrm3 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Wyrm3 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Wyrm3, \"udg_DamageEventAfterArmor\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Wyrm3, Condition( function Trig_Wyrm3_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Wyrm3, function Trig_Wyrm3_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}