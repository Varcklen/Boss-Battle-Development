{
  "Id": 50333628,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Azgalor4_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'h011' and GetUnitLifePercent(udg_DamageEventTarget) <= 25\r\nendfunction\r\n\r\nfunction Trig_Azgalor4_Actions takes nothing returns nothing\r\n    local integer id = GetHandleId( udg_DamageEventTarget )\r\n    local group g = CreateGroup()\r\n    local unit u\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    \r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( \"bszg1\" ) ), bosscast(6), true, function Azg2Cast )\r\n\r\n    set bj_livingPlayerUnitsTypeId = 'h00O'\r\n    call GroupEnumUnitsOfPlayer(g, GetOwningPlayer( udg_DamageEventTarget ), filterLivingPlayerUnitsOfTypeId)\r\n    loop\r\n        set u = FirstOfGroup(g)\r\n        exitwhen u == null\r\n        set id = GetHandleId( u )\r\n        if GetUnitState( u, UNIT_STATE_LIFE) > 0.405 then\r\n            call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( u ), StringHash( \"bszg1\" ) ), bosscast(6), true, function Azg2Cast )\r\n        endif\r\n        call GroupRemoveUnit(g,u)\r\n    endloop\r\n    \r\n    call GroupClear( g )\r\n    call DestroyGroup( g )\r\n    set u = null\r\n    set g = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Azgalor4 takes nothing returns nothing\r\n    set gg_trg_Azgalor4 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Azgalor4 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Azgalor4, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Azgalor4, Condition( function Trig_Azgalor4_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Azgalor4, function Trig_Azgalor4_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}