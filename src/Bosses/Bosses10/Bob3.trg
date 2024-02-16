{
  "Id": 50333664,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Bob3_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'n00A' and GetUnitLifePercent(udg_DamageEventTarget) <= 50\r\nendfunction\r\n\r\nfunction Trig_Bob3_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    local integer cyclB\r\n    local real x\r\n    local real y\r\n    local unit u\r\n    \r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call TransmissionFromUnitWithNameBJ( bj_FORCE_ALL_PLAYERS, udg_DamageEventTarget, GetUnitName(udg_DamageEventTarget), null, \"Bosses, help me!\", bj_TIMETYPE_SET, 3, false )\r\n    loop\r\n        exitwhen cyclA > 4\r\n        if GetUnitState( udg_hero[cyclA], UNIT_STATE_LIFE) > 0.405 then\r\n        \tset x = GetUnitX( udg_DamageEventTarget ) + 400 * Cos( ( 45 + ( 90 * cyclA ) ) * bj_DEGTORAD )\r\n        \tset y = GetUnitY( udg_DamageEventTarget ) + 400 * Sin( ( 45 + ( 90 * cyclA ) ) * bj_DEGTORAD )\r\n            set u = CreateUnit( GetOwningPlayer( udg_DamageEventTarget ), DB_Boss_id[GetRandomInt(1,3)][cyclA], x, y, GetRandomReal( 0, 360 ) )\r\n            call aggro( u )\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n\r\n\tset u = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Bob3 takes nothing returns nothing\r\n    set gg_trg_Bob3 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Bob3 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Bob3, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Bob3, Condition( function Trig_Bob3_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Bob3, function Trig_Bob3_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}