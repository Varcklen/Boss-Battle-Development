{
  "Id": 50333548,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MoonPriest4_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( udg_DamageEventTarget ) == 'e005' and GetUnitLifePercent(udg_DamageEventTarget) <= 20\r\nendfunction\r\n\r\nfunction Trig_MoonPriest4_Actions takes nothing returns nothing\r\n    local integer id = GetHandleId( udg_DamageEventTarget )\r\n    local group g = CreateGroup()\r\n    local unit u\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    \r\n    if LoadTimerHandle( udg_hash, id, StringHash( \"bsmp\" ) ) == null  then\r\n        call SaveTimerHandle( udg_hash, id, StringHash( \"bsmp\" ), CreateTimer() )\r\n    endif\r\n\tset id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"bsmp\" ) ) ) \r\n    call SaveUnitHandle( udg_hash, id, StringHash( \"bsmp\" ), udg_DamageEventTarget )\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( \"bsmp\" ) ), bosscast(3.5), true, function MoonPriestCast )\r\n    \r\n    call GroupClear( g )\r\n    call DestroyGroup( g )\r\n    set g = null\r\n    set u = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MoonPriest4 takes nothing returns nothing\r\n    set gg_trg_MoonPriest4 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_MoonPriest4 )\r\n    call TriggerRegisterVariableEvent( gg_trg_MoonPriest4, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_MoonPriest4, Condition( function Trig_MoonPriest4_Conditions ) )\r\n    call TriggerAddAction( gg_trg_MoonPriest4, function Trig_MoonPriest4_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}