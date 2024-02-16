{
  "Id": 50332869,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_AlchemyAA_Conditions takes nothing returns boolean\r\n    return not( udg_IsDamageSpell ) and GetUnitAbilityLevel(udg_DamageEventSource, 'B08X') > 0 and luckylogic( udg_DamageEventSource, 8, 1, 100 )\r\nendfunction\r\n\r\nfunction AlchemyAACast takes nothing returns nothing\r\n    local integer id = GetHandleId( GetExpiredTimer( ) )\r\n    local unit u = LoadUnitHandle( udg_hash, id, StringHash( \"alch\" ) ) \r\n    \r\n    set udg_Caster = u\r\n    set udg_RandomLogic = true\r\n    call TriggerExecute( udg_DB_Trigger_Pot[GetRandomInt(1, 10)] )\r\n    call FlushChildHashtable( udg_hash, id )\r\n    \r\n    set u = null\r\nendfunction\r\n\r\nfunction Trig_AlchemyAA_Actions takes nothing returns nothing\r\n    local integer id = GetHandleId( udg_DamageEventSource )\r\n\r\n    call SaveTimerHandle( udg_hash, id, StringHash( \"alch\" ), CreateTimer() )\r\n    set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"alch\" ) ) ) \r\n    call SaveUnitHandle( udg_hash, id, StringHash( \"alch\" ), udg_DamageEventSource )\r\n    call SaveBoolean( udg_hash, GetHandleId( udg_DamageEventSource ), StringHash( \"alch\" ), true )\r\n    call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventSource ), StringHash( \"alch\" ) ), 0.01, false, function AlchemyAACast )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_AlchemyAA takes nothing returns nothing\r\n    call CreateEventTrigger( \"udg_AfterDamageEvent\", function Trig_AlchemyAA_Actions, function Trig_AlchemyAA_Conditions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}