{
  "Id": 50333648,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Soulfiend1_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'n04F'\r\nendfunction\r\n\r\nfunction Soulfiend1End takes nothing returns nothing\r\n    local integer id = GetHandleId( GetExpiredTimer( ) )\r\n    local group g = CreateGroup()\r\n    local unit u\r\n    local unit boss = LoadUnitHandle( udg_hash, id, StringHash( \"bssf2b\" ) )\r\n    local unit dummy = LoadUnitHandle( udg_hash, id, StringHash( \"bssf2\" ) )\r\n\r\n    if GetUnitState( dummy, UNIT_STATE_LIFE) <= 0.405 or GetUnitState( boss, UNIT_STATE_LIFE) <= 0.405 or not( udg_fightmod[0] ) then\r\n        call RemoveUnit( dummy )\r\n        call FlushChildHashtable( udg_hash, id )\r\n        call DestroyTimer( GetExpiredTimer() )\r\n    else\r\n        call GroupEnumUnitsInRange( g, GetUnitX( dummy ), GetUnitY( dummy ), 250, null )\r\n        loop\r\n            set u = FirstOfGroup(g)\r\n            exitwhen u == null\r\n            if unitst( u, boss, \"enemy\" ) then\r\n                call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Items\\\\AIil\\\\AIilTarget.mdl\", GetUnitX( u ), GetUnitY( u ) ) )\r\n                call SetUnitState( u, UNIT_STATE_LIFE, RMaxBJ(0,GetUnitState( u, UNIT_STATE_LIFE) - (GetUnitState( u, UNIT_STATE_MAX_LIFE)*0.1) ))\r\n            endif\r\n            call GroupRemoveUnit( g, u )\r\n        endloop\r\n    endif\r\n    \r\n    call GroupClear( g )\r\n    call DestroyGroup( g )\r\n    set u = null\r\n    set g = null\r\n    set dummy = null\r\n    set boss = null\r\nendfunction\r\n\r\nfunction Soulfiend1Cast takes nothing returns nothing\r\n    local integer id = GetHandleId( GetExpiredTimer( ) )\r\n    local unit boss = LoadUnitHandle( udg_hash, id, StringHash( \"bssf1\" ))\r\n    local integer id1 \r\n    \r\n    if GetUnitState( boss, UNIT_STATE_LIFE) <= 0.405 or not( udg_fightmod[0] ) then\r\n        call DestroyTimer( GetExpiredTimer() )\r\n        call FlushChildHashtable( udg_hash, id )\r\n    else\r\n        set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( boss ), 'u000', Math_GetUnitRandomX(boss, 650), Math_GetUnitRandomY(boss, 650), 270 )\r\n    \tcall DestroyEffect( AddSpecialEffect( \"CallOfAggression.mdx\", GetUnitX( bj_lastCreatedUnit ), GetUnitY( bj_lastCreatedUnit ) ) )\r\n    \tcall SetUnitScale( bj_lastCreatedUnit, 2.5, 2.5, 2.5 )\r\n        call UnitAddAbility( bj_lastCreatedUnit, 'A170')\r\n\r\n        set id1 = InvokeTimerWithUnit( bj_lastCreatedUnit, \"bssf2\", 1, true, function Soulfiend1End )\r\n        call SaveUnitHandle( udg_hash, id1, StringHash( \"bssf2b\" ), boss )\r\n    endif\r\n    \r\n    set boss = null\r\nendfunction\r\n\r\nfunction Trig_Soulfiend1_Actions takes nothing returns nothing\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call InvokeTimerWithUnit( udg_DamageEventTarget, \"bssf1\", bosscast(12), true, function Soulfiend1Cast )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Soulfiend1 takes nothing returns nothing\r\n    set gg_trg_Soulfiend1 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Soulfiend1 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Soulfiend1, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Soulfiend1, Condition( function Trig_Soulfiend1_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Soulfiend1, function Trig_Soulfiend1_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}