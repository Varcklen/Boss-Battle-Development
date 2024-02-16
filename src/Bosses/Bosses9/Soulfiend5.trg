{
  "Id": 50333652,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Soulfiend5_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'n04F' and GetUnitLifePercent(udg_DamageEventTarget) <= 20\r\nendfunction\r\n\r\nfunction Trig_Soulfiend5_Actions takes nothing returns nothing\r\n    call DestroyEffect( AddSpecialEffect( \"CallOfAggression.mdx\", GetUnitX( udg_DamageEventTarget ), GetUnitY( udg_DamageEventTarget ) ) )\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( \"bssf1\" ) ), bosscast(5), true, function Soulfiend1Cast )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Soulfiend5 takes nothing returns nothing\r\n    set gg_trg_Soulfiend5 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Soulfiend5 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Soulfiend5, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Soulfiend5, Condition( function Trig_Soulfiend5_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Soulfiend5, function Trig_Soulfiend5_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}