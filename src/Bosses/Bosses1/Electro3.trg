{
  "Id": 50333420,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Electro3_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( udg_DamageEventTarget ) == 'n00Z' and GetUnitLifePercent( udg_DamageEventTarget ) <= 25\r\nendfunction\r\n\r\nfunction Trig_Electro3_Actions takes nothing returns nothing\r\n    local integer id = GetHandleId( udg_DamageEventTarget )\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    \r\n    if LoadTimerHandle( udg_hash, id, StringHash( \"bsel1\" ) ) == null then \r\n        call SaveTimerHandle( udg_hash, id, StringHash( \"bsel1\" ), CreateTimer() )\r\n    endif\r\n\tset id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"bsel1\" ) ) ) \r\n    call SaveUnitHandle( udg_hash, id, StringHash( \"bsel1\" ), udg_DamageEventTarget )\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( \"bsel1\" ) ), 2, true, function ElectroCast1 )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Electro3 takes nothing returns nothing\r\n    set gg_trg_Electro3 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Electro3 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Electro3, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Electro3, Condition( function Trig_Electro3_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Electro3, function Trig_Electro3_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}