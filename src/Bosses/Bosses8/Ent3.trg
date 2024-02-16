{
  "Id": 50333596,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "//TESH.scrollpos=0\r\n//TESH.alwaysfold=0\r\nfunction Trig_Ent3_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'e006' and GetUnitLifePercent(udg_DamageEventTarget) <= 25\r\nendfunction\r\n\r\nfunction Trig_Ent3_Actions takes nothing returns nothing\r\n    local integer cyclA = 1 \r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call UnitAddAbility( udg_DamageEventTarget, 'A0RR' )\r\n    loop\r\n        exitwhen cyclA > 4\r\n        if GetUnitState( udg_hero[cyclA], UNIT_STATE_LIFE) > 0.405 then\r\n            call dummyspawn( udg_DamageEventTarget, 1, 'A0K0', 0, 0 )\r\n            call IssueTargetOrder( bj_lastCreatedUnit, \"entanglingroots\", udg_hero[cyclA] )\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Ent3 takes nothing returns nothing\r\n    set gg_trg_Ent3 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Ent3 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Ent3, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Ent3, Condition( function Trig_Ent3_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Ent3, function Trig_Ent3_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}