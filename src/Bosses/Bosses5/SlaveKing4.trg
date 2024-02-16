{
  "Id": 50333529,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "//TESH.scrollpos=0\r\n//TESH.alwaysfold=0\r\nfunction Trig_SlaveKing4_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( udg_DamageEventTarget ) == 'o00F' and GetUnitLifePercent(udg_DamageEventTarget) <= 20\r\nendfunction\r\n\r\nfunction Trig_SlaveKing4_Actions takes nothing returns nothing\r\n    local integer id = GetHandleId( udg_DamageEventTarget )\r\n    \r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    \r\n    if LoadTimerHandle( udg_hash, id, StringHash( \"bssk\" ) ) == null  then\r\n        call SaveTimerHandle( udg_hash, id, StringHash( \"bssk\" ), CreateTimer() )\r\n    endif\r\n    set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"bssk\" ) ) ) \r\n    call SaveUnitHandle( udg_hash, id, StringHash( \"bssk\" ), udg_DamageEventTarget )\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( \"bssk\" ) ), bosscast(1), true, function SlaveKingCast )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_SlaveKing4 takes nothing returns nothing\r\n    set gg_trg_SlaveKing4 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_SlaveKing4 )\r\n    call TriggerRegisterVariableEvent( gg_trg_SlaveKing4, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_SlaveKing4, Condition( function Trig_SlaveKing4_Conditions ) )\r\n    call TriggerAddAction( gg_trg_SlaveKing4, function Trig_SlaveKing4_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}