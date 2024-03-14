{
  "Id": 50333472,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_gg_trg_MageTruch3_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'n03L' and GetUnitLifePercent(udg_DamageEventTarget) <= 25\r\nendfunction\r\n\r\nfunction Trig_gg_trg_MageTruch3_Actions takes nothing returns nothing\r\n    local integer id = GetHandleId( udg_DamageEventTarget )\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    \r\n    call shield( udg_DamageEventTarget, udg_DamageEventTarget, 1000 )\r\n    \r\n    if LoadTimerHandle( udg_hash, id, StringHash( \"bsmtr\" ) ) == null  then\r\n        call SaveTimerHandle( udg_hash, id, StringHash( \"bsmtr\" ), CreateTimer() )\r\n    endif\r\n\tset id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"bsmtr\" ) ) ) \r\n    call SaveUnitHandle( udg_hash, id, StringHash( \"bsmtr\" ), udg_DamageEventTarget )\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( \"bsmtr\" ) ), bosscast(4), true, function MageTruch1Cast )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MageTruch3 takes nothing returns nothing\r\n    set gg_trg_MageTruch3 = CreateTrigger()\r\n    call DisableTrigger( gg_trg_MageTruch3 )\r\n    call TriggerRegisterVariableEvent( gg_trg_MageTruch3, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_MageTruch3, Condition( function Trig_gg_trg_MageTruch3_Conditions ) )\r\n    call TriggerAddAction( gg_trg_MageTruch3, function Trig_gg_trg_MageTruch3_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}