{
  "Id": 50333418,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Electro1_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( udg_DamageEventTarget ) == 'n00Z' and GetUnitLifePercent( udg_DamageEventTarget ) <= 90\r\nendfunction\r\n\r\nfunction Electro1Cast takes nothing returns nothing\r\n    local integer id = GetHandleId( GetExpiredTimer() )\r\n    local unit dummy = LoadUnitHandle( udg_hash, id, StringHash( \"bsel2\" ))\r\n    local group g = CreateGroup()\r\n    local unit u\r\n    \r\n    if GetUnitState( dummy, UNIT_STATE_LIFE) <= 0.405 or not( udg_fightmod[0] ) then\r\n        call DestroyTimer( GetExpiredTimer() )\r\n        call FlushChildHashtable( udg_hash, id )\r\n    else\r\n        call GroupEnumUnitsInRange( g, GetUnitX( dummy ), GetUnitY( dummy ), 100, null )\r\n        loop\r\n            set u = FirstOfGroup(g)\r\n            exitwhen u == null\r\n            if unitst( u, dummy, \"enemy\" ) then\r\n                call UnitDamageTarget( dummy, u, 35, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )\r\n            endif\r\n            call GroupRemoveUnit(g,u)\r\n        endloop\r\n    endif\r\n    \r\n    call GroupClear( g )\r\n    call DestroyGroup( g )\r\n    set u = null\r\n    set g = null\r\n    set dummy = null\r\nendfunction\r\n\r\nfunction ElectroCast1 takes nothing returns nothing\r\n    local integer id = GetHandleId( GetExpiredTimer( ) )\r\n    local unit boss = LoadUnitHandle( udg_hash, id, StringHash( \"bsel1\" ))\r\n    local integer id1\r\n\r\n    if GetUnitState( boss, UNIT_STATE_LIFE) <= 0.405 or not( udg_fightmod[0] ) then\r\n        call DestroyTimer( GetExpiredTimer() )\r\n        call FlushChildHashtable( udg_hash, id )\r\n    else\r\n        set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( boss ), 'u000', GetUnitX( boss ) + GetRandomReal(-400, 400), GetUnitY( boss ) + GetRandomReal(-400, 400), 270 )\r\n        call UnitAddAbility( bj_lastCreatedUnit, 'A072')\r\n        call UnitApplyTimedLife( bj_lastCreatedUnit, 'BTLF', 20)\r\n        call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Other\\\\Monsoon\\\\MonsoonBoltTarget.mdl\", bj_lastCreatedUnit, \"origin\") )\r\n        set id1 = GetHandleId( bj_lastCreatedUnit )\r\n        \r\n        call SaveTimerHandle( udg_hash, id1, StringHash( \"bsel2\" ), CreateTimer() )\r\n        set id1 = GetHandleId( LoadTimerHandle( udg_hash, id1, StringHash( \"bsel2\" ) ) ) \r\n        call SaveUnitHandle( udg_hash, id1, StringHash( \"bsel2\" ), bj_lastCreatedUnit )\r\n        call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( bj_lastCreatedUnit ), StringHash( \"bsel2\" ) ), 1, true, function Electro1Cast ) \r\n    endif\r\n    \r\n    set boss = null\r\nendfunction\r\n\r\nfunction Trig_Electro1_Actions takes nothing returns nothing\r\n    local integer id = GetHandleId( udg_DamageEventTarget )\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n\r\n    if LoadTimerHandle( udg_hash, id, StringHash( \"bsel1\" ) ) == null  then\r\n        call SaveTimerHandle( udg_hash, id, StringHash( \"bsel1\" ), CreateTimer() )\r\n    endif\r\n\tset id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"bsel1\" ) ) ) \r\n    call SaveUnitHandle( udg_hash, id, StringHash( \"bsel1\" ), udg_DamageEventTarget )\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( \"bsel1\" ) ), bosscast(4), true, function ElectroCast1 )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Electro1 takes nothing returns nothing\r\n    set gg_trg_Electro1 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Electro1 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Electro1, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Electro1, Condition( function Trig_Electro1_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Electro1, function Trig_Electro1_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}