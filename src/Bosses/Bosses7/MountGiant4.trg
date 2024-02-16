{
  "Id": 50333583,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MountGiant4_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( udg_DamageEventTarget ) == 'e000' and GetUnitLifePercent(udg_DamageEventTarget) <= 60\r\nendfunction\r\n\r\nfunction Trig_MountGiant4_Actions takes nothing returns nothing\r\n    local integer id = GetHandleId( udg_DamageEventTarget )\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n\r\n    if LoadTimerHandle( udg_hash, id, StringHash( \"bsmg1\" ) ) == null then \r\n        call SaveTimerHandle( udg_hash, id, StringHash( \"bsmg1\" ), CreateTimer() )\r\n    endif\r\n\tset id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"bsmg1\" ) ) ) \r\n    call SaveUnitHandle( udg_hash, id, StringHash( \"bsmg1\" ), udg_DamageEventTarget )\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( \"bsmg1\" ) ), bosscast(6), true, function MountGiant1Cast )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MountGiant4 takes nothing returns nothing\r\n    set gg_trg_MountGiant4 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_MountGiant4 )\r\n    call TriggerRegisterVariableEvent( gg_trg_MountGiant4, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_MountGiant4, Condition( function Trig_MountGiant4_Conditions ) )\r\n    call TriggerAddAction( gg_trg_MountGiant4, function Trig_MountGiant4_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}