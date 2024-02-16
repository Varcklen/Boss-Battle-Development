{
  "Id": 50333468,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Thief3_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'h015' and GetUnitLifePercent(udg_DamageEventTarget) <= 25 and GetOwningPlayer(udg_DamageEventTarget) == Player(10)\r\nendfunction\r\n\r\nfunction Trig_Thief3_Actions takes nothing returns nothing\r\n    local integer id = GetHandleId( udg_DamageEventTarget )\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    \r\n    if LoadTimerHandle( udg_hash, id, StringHash( \"bsth2\" ) ) == null  then\r\n        call SaveTimerHandle( udg_hash, id, StringHash( \"bsth2\" ), CreateTimer() )\r\n    endif\r\n\tset id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"bsth2\" ) ) ) \r\n    call SaveUnitHandle( udg_hash, id, StringHash( \"bsth2\" ), udg_DamageEventTarget )\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( \"bsth2\" ) ), bosscast(3), true, function Thief2Cast )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Thief3 takes nothing returns nothing\r\n    set gg_trg_Thief3 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Thief3 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Thief3, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Thief3, Condition( function Trig_Thief3_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Thief3, function Trig_Thief3_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}