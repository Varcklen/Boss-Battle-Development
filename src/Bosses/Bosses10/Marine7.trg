{
  "Id": 50333686,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Marine7_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( udg_DamageEventTarget ) == 'n04N' and GetUnitLifePercent(udg_DamageEventTarget) <= 30\r\nendfunction\r\n\r\nfunction Trig_Marine7_Actions takes nothing returns nothing\r\n    local integer id = GetHandleId( udg_DamageEventTarget )\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( \"bsmr\" ) ), bosscast(6), true, function Marine2Cast )\r\n    call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( \"bsmr4\" ) ), bosscast(4), true, function Marine3Cast )\r\n    call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( \"bsmr7\" ) ), bosscast(8), true, function Marine4Cast )\r\n    \r\n    call TransmissionFromUnitWithNameBJ( bj_FORCE_ALL_PLAYERS, udg_DamageEventTarget, GetUnitName(udg_DamageEventTarget), null, \"Not again!\", bj_TIMETYPE_SET, 3, false )\r\n    call UnitAddAbility( udg_DamageEventTarget, 'A0SB' )\r\n    call UnitAddAbility( udg_DamageEventTarget, 'A0SE' )\r\n    call pausest( udg_DamageEventTarget, 1 )\r\n    call SetUnitAnimation( udg_DamageEventTarget, \"death\" )\r\n    \r\n    if LoadTimerHandle( udg_hash, id, StringHash( \"bsmr8\" ) ) == null  then\r\n        call SaveTimerHandle( udg_hash, id, StringHash( \"bsmr8\" ), CreateTimer() )\r\n    endif\r\n    set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"bsmr8\" ) ) ) \r\n    call SaveUnitHandle( udg_hash, id, StringHash( \"bsmr8\" ), udg_DamageEventTarget )\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( \"bsmr8\" ) ), 5, false, function Marine5Cast )\r\n    \r\n    set id = GetHandleId( udg_DamageEventTarget )\r\n    \r\n    if LoadTimerHandle( udg_hash, id, StringHash( \"bsmr9\" ) ) == null  then\r\n        call SaveTimerHandle( udg_hash, id, StringHash( \"bsmr9\" ), CreateTimer() )\r\n    endif\r\n\tset id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"bsmr9\" ) ) ) \r\n    call SaveUnitHandle( udg_hash, id, StringHash( \"bsmr9\" ), udg_DamageEventTarget )\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( \"bsmr9\" ) ), bosscast(0.5), true, function Marine5Boom )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Marine7 takes nothing returns nothing\r\n    set gg_trg_Marine7 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Marine7 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Marine7, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Marine7, Condition( function Trig_Marine7_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Marine7, function Trig_Marine7_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}