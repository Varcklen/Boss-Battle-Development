{
  "Id": 50333430,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Bear2_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'n010' and GetUnitLifePercent(udg_DamageEventTarget) <= 40\r\nendfunction\r\n\r\nfunction Trig_Bear2_Actions takes nothing returns nothing\r\n    local integer id = GetHandleId( udg_DamageEventTarget )\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Human\\\\Thunderclap\\\\ThunderClapCaster.mdl\", udg_DamageEventTarget, \"origin\") )\r\n    \r\n    if LoadTimerHandle( udg_hash, id, StringHash( \"bsbr\" ) ) == null  then\r\n        call SaveTimerHandle( udg_hash, id, StringHash( \"bsbr\" ), CreateTimer() )\r\n    endif\r\n\tset id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"bsbr\" ) ) ) \r\n    call SaveUnitHandle( udg_hash, id, StringHash( \"bsbr\" ), udg_DamageEventTarget )\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( \"bsbr\" ) ), bosscast(7), true, function BearCast )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Bear2 takes nothing returns nothing\r\n    set gg_trg_Bear2 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Bear2 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Bear2, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Bear2, Condition( function Trig_Bear2_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Bear2, function Trig_Bear2_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}