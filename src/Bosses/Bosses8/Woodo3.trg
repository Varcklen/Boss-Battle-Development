{
  "Id": 50333601,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Woodo3_Conditions takes nothing returns boolean\r\n    return ( GetUnitTypeId(udg_DamageEventTarget) == 'o000' ) and ( GetUnitLifePercent(udg_DamageEventTarget) <= 60 )\r\nendfunction\r\n\r\nfunction Trig_Woodo3_Actions takes nothing returns nothing\r\n    local integer id = GetHandleId( udg_DamageEventTarget )\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    \r\n    if LoadTimerHandle( udg_hash, id, StringHash( \"bswd\" ) ) == null  then\r\n        call SaveTimerHandle( udg_hash, id, StringHash( \"bswd\" ), CreateTimer() )\r\n    endif\r\n\tset id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"bswd\" ) ) ) \r\n    call SaveUnitHandle( udg_hash, id, StringHash( \"bswd\" ), udg_DamageEventTarget )\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( \"bswd\" ) ), bosscast(6), true, function WoodoCast )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Woodo3 takes nothing returns nothing\r\n    set gg_trg_Woodo3 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Woodo3 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Woodo3, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Woodo3, Condition( function Trig_Woodo3_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Woodo3, function Trig_Woodo3_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}