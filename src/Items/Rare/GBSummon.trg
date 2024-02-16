{
  "Id": 50332596,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_GBSummon_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(GetEnteringUnit()) == 'o01C'\r\nendfunction\r\n\r\nfunction GBSummonCast takes nothing returns nothing \r\n\tlocal integer id = GetHandleId( GetExpiredTimer( ) )\r\n    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( \"gbstt\" ) )\r\n\r\n    if GetUnitState( caster, UNIT_STATE_LIFE) > 0.405 then\r\n        set udg_RandomLogic = true\r\n        set udg_Caster = caster\r\n        set udg_Level = 1\r\n        call TriggerExecute( gg_trg_KillEye )\r\n    else\r\n        call DestroyTimer( GetExpiredTimer( ) )\r\n        call FlushChildHashtable( udg_hash, id )\r\n\tendif\r\n\r\n    set caster = null\r\nendfunction \r\n\r\nfunction Trig_GBSummon_Actions takes nothing returns nothing\r\n\tlocal integer id = GetHandleId( GetEnteringUnit() )\r\n\t\r\n\tcall SaveTimerHandle( udg_hash, id, StringHash( \"gbstt\" ), CreateTimer( ) ) \r\n\tset id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"gbstt\" ) ) ) \r\n\tcall SaveUnitHandle( udg_hash, id, StringHash( \"gbstt\" ), GetEnteringUnit() ) \r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( GetEnteringUnit() ), StringHash( \"gbstt\" ) ), 5, true, function GBSummonCast ) \r\nendfunction \r\n\r\n//===========================================================================\r\nfunction InitTrig_GBSummon takes nothing returns nothing\r\n    set gg_trg_GBSummon = CreateTrigger(  )\r\n    call TriggerRegisterEnterRectSimple( gg_trg_GBSummon, GetWorldBounds() )\r\n    call TriggerAddCondition( gg_trg_GBSummon, Condition( function Trig_GBSummon_Conditions ) )\r\n    call TriggerAddAction( gg_trg_GBSummon, function Trig_GBSummon_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}