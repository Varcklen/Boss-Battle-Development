{
  "Id": 50332687,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Totem_Power_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(GetEnteringUnit()) == 'o00R'\r\nendfunction\r\n\r\nfunction Totem_PowerCast takes nothing returns nothing \r\n\tlocal integer id = GetHandleId( GetExpiredTimer( ) )\r\n    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( \"pwrtt\" ) )\r\n    local group g = CreateGroup()\r\n    local unit u\r\n\r\n    if GetUnitState( caster, UNIT_STATE_LIFE) > 0.405 then\r\n\tcall dummyspawn( caster, 1, 0, 0, 0 )\r\n    \tcall DestroyEffect( AddSpecialEffect( \"war3mapImported\\\\ArcaneExplosion.mdx\", GetUnitX( caster ), GetUnitY( caster ) ) )\r\n    \tcall GroupEnumUnitsInRange( g, GetUnitX( caster ), GetUnitY( caster ), 400, null )\r\n    \tloop\r\n        \tset u = FirstOfGroup(g)\r\n        \texitwhen u == null\r\n        \tif unitst( u, caster, \"enemy\" ) then\r\n                call UnitDamageTarget( bj_lastCreatedUnit, u, 100, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )\r\n        \tendif\r\n        \tcall GroupRemoveUnit(g,u)\r\n        \tset u = FirstOfGroup(g)\r\n    \tendloop\r\n    else\r\n        call FlushChildHashtable( udg_hash, id )\r\n\tcall DestroyTimer( GetExpiredTimer() )\r\n    endif\r\n\r\n    call GroupClear( g )\r\n    call DestroyGroup( g )\r\n    set u = null\r\n    set g = null\r\n    set caster = null\r\nendfunction \r\n\r\nfunction Trig_Totem_Power_Actions takes nothing returns nothing\r\n\tlocal integer id = GetHandleId( GetEnteringUnit() )\r\n\t\r\n\tcall SaveTimerHandle( udg_hash, id, StringHash( \"pwrtt\" ), CreateTimer( ) ) \r\n\tset id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"pwrtt\" ) ) ) \r\n\tcall SaveUnitHandle( udg_hash, id, StringHash( \"pwrtt\" ), GetEnteringUnit() ) \r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( GetEnteringUnit() ), StringHash( \"pwrtt\" ) ), 3, true, function Totem_PowerCast ) \r\nendfunction \r\n\r\n//===========================================================================\r\nfunction InitTrig_Totem_Power takes nothing returns nothing\r\n    set gg_trg_Totem_Power = CreateTrigger(  )\r\n    call TriggerRegisterEnterRectSimple( gg_trg_Totem_Power, GetWorldBounds() )\r\n    call TriggerAddCondition( gg_trg_Totem_Power, Condition( function Trig_Totem_Power_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Totem_Power, function Trig_Totem_Power_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}