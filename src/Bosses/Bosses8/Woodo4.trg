{
  "Id": 50333602,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Woodo4_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'o000' and GetUnitLifePercent(udg_DamageEventTarget) <= 50\r\nendfunction\r\n\r\nfunction Trig_Woodo4_Actions takes nothing returns nothing\r\n    local integer id = GetHandleId( udg_DamageEventTarget )\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call CreateUnit( GetOwningPlayer(udg_DamageEventTarget), 'o00P', GetUnitX( udg_DamageEventTarget ) + GetRandomReal(-400, 400), GetUnitY( udg_DamageEventTarget ) + GetRandomReal(-400, 400), GetRandomReal( 0, 360 ) )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Woodo4 takes nothing returns nothing\r\n    set gg_trg_Woodo4 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Woodo4 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Woodo4, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Woodo4, Condition( function Trig_Woodo4_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Woodo4, function Trig_Woodo4_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}