{
  "Id": 50333587,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Berserk2_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'e00F' and GetUnitLifePercent(udg_DamageEventTarget) <= 75\r\nendfunction\r\n\r\nfunction BerserkMove takes nothing returns nothing\r\n    local integer id = GetHandleId( GetExpiredTimer() )\r\n    local unit boss = LoadUnitHandle( udg_hash, id, StringHash( \"bsbk2b\" ) )\r\n    local unit dummy = LoadUnitHandle( udg_hash, id, StringHash( \"bsbk2\" ) )\r\n    local unit target\r\n    local real x = LoadReal( udg_hash, id, StringHash( \"bsbk2x\" ) )\r\n    local real y = LoadReal( udg_hash, id, StringHash( \"bsbk2y\" ) )\r\n    local real IfX = ( x - GetUnitX( dummy ) ) * ( x - GetUnitX( dummy ) )\r\n    local real IfY = ( y - GetUnitY( dummy ) ) * ( y - GetUnitY( dummy ) )\r\n    \r\n    if not( udg_fightmod[0] ) or GetUnitState( boss, UNIT_STATE_LIFE) <= 0.405 then\r\n        call RemoveUnit( dummy )\r\n        call DestroyTimer( GetExpiredTimer() )\r\n        call FlushChildHashtable( udg_hash, id )\r\n    elseif SquareRoot( IfX + IfY ) < 70 then\r\n        set target = GroupPickRandomUnit(udg_otryad)\r\n        set x = GetUnitX( target )\r\n        set y = GetUnitY( target )\r\n        call SaveReal( udg_hash, id, StringHash( \"bsbk2x\" ), x )\r\n        call SaveReal( udg_hash, id, StringHash( \"bsbk2y\" ), y )\r\n        call IssuePointOrder( dummy, \"move\", x, y )\r\n    endif\r\n    \r\n    set dummy = null\r\n    set target = null\r\n    set boss = null\r\nendfunction   \r\n    \r\nfunction Trig_Berserk2_Actions takes nothing returns nothing\r\n    local integer id\r\n    local unit u = GroupPickRandomUnit(udg_otryad)\r\n    local real x = GetUnitX( u )\r\n    local real y = GetUnitY( u )\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( udg_DamageEventTarget ), 'u000', GetUnitX( udg_DamageEventTarget ), GetUnitY( udg_DamageEventTarget ), 270 )\r\n    call UnitAddAbility( bj_lastCreatedUnit, 'A0Y5')\r\n    call UnitAddAbility( bj_lastCreatedUnit, 'A071')\r\n    call IssuePointOrder( bj_lastCreatedUnit, \"move\", x, y )\r\n    \r\n    set id = GetHandleId( bj_lastCreatedUnit )\r\n    call DestroyTimer( LoadTimerHandle( udg_hash, id, StringHash( \"bsbk2\" )))\r\n    call FlushChildHashtable( udg_hash, id )\r\n    \r\n    if LoadTimerHandle( udg_hash, id, StringHash( \"bsbk2\" ) ) == null  then\r\n        call SaveTimerHandle( udg_hash, id, StringHash( \"bsbk2\" ), CreateTimer() )\r\n    endif\r\n\tset id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"bsbk2\" ) ) ) \r\n    call SaveUnitHandle( udg_hash, id, StringHash( \"bsbk2\" ), bj_lastCreatedUnit )\r\n    call SaveUnitHandle( udg_hash, id, StringHash( \"bsbk2b\" ), udg_DamageEventTarget )\r\n    call SaveReal( udg_hash, id, StringHash( \"bsbk2x\" ), x )\r\n    call SaveReal( udg_hash, id, StringHash( \"bsbk2y\" ), y )\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( bj_lastCreatedUnit ), StringHash( \"bsbk2\" ) ), 0.5, true, function BerserkMove )\r\n    \r\n    set u = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Berserk2 takes nothing returns nothing\r\n    set gg_trg_Berserk2 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Berserk2 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Berserk2, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Berserk2, Condition( function Trig_Berserk2_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Berserk2, function Trig_Berserk2_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}