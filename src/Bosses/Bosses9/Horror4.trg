{
  "Id": 50333643,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Horror4_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( udg_DamageEventTarget ) == 'e002' and GetUnitLifePercent(udg_DamageEventTarget) <= 70\r\nendfunction\r\n\r\nfunction Horror4Cast takes nothing returns nothing\r\n    local integer id = GetHandleId( GetExpiredTimer() )\r\n    local unit boss = LoadUnitHandle( udg_hash, id, StringHash( \"bshr4\" ) )\r\n    local integer i = GetRandomInt(1, 4)\r\n    local real x \r\n    local real y\r\n    \r\n    if GetUnitState( boss, UNIT_STATE_LIFE) <= 0.405 or not( udg_fightmod[0] ) then\r\n        call DestroyTimer( GetExpiredTimer() )\r\n        call FlushChildHashtable( udg_hash, id )\r\n    else\r\n        set x = GetRectCenterX( udg_Boss_Rect ) + 2000 * Cos( ( 45 + ( 90 * i ) ) * bj_DEGTORAD )\r\n        set y = GetRectCenterY( udg_Boss_Rect ) + 2000 * Sin( ( 45 + ( 90 * i ) ) * bj_DEGTORAD )\r\n    \tcall CreateUnit( GetOwningPlayer( boss ), 'u007', x, y, 270 )\t\r\n    endif\r\n    \r\n    set boss = null\r\nendfunction\r\n\r\nfunction Trig_Horror4_Actions takes nothing returns nothing\r\n    local integer id = GetHandleId( udg_DamageEventTarget )\r\n    \r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    \r\n    if LoadTimerHandle( udg_hash, id, StringHash( \"bshr4\" ) ) == null  then\r\n        call SaveTimerHandle( udg_hash, id, StringHash( \"bshr4\" ), CreateTimer() )\r\n    endif\r\n    set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"bshr4\" ) ) ) \r\n    call SaveUnitHandle( udg_hash, id, StringHash( \"bshr4\" ), udg_DamageEventTarget )\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( \"bshr4\" ) ), bosscast(1), true, function Horror4Cast )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Horror4 takes nothing returns nothing\r\n    set gg_trg_Horror4 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Horror4 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Horror4, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Horror4, Condition( function Trig_Horror4_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Horror4, function Trig_Horror4_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}