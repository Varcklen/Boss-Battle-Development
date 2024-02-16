{
  "Id": 50332793,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_OrbVolcano_Conditions takes nothing returns boolean\r\n    return not( udg_IsDamageSpell ) and luckylogic( udg_DamageEventSource, 10, 1, 100 ) and inv( udg_DamageEventSource, 'I0ER') > 0\r\nendfunction\r\n\r\nfunction Trig_OrbVolcano_Actions takes nothing returns nothing\r\n    set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( udg_DamageEventSource ), 'u000', GetUnitX( udg_DamageEventSource )+GetRandomReal(-500, 500), GetUnitY( udg_DamageEventSource )+GetRandomReal(-500, 500), 270 )\r\n    call UnitAddAbility( bj_lastCreatedUnit, 'A0WB' )\r\n    call UnitApplyTimedLife(bj_lastCreatedUnit, 'BTLF', 21 )\r\n    call IssuePointOrder( bj_lastCreatedUnit, \"volcano\", GetUnitX( bj_lastCreatedUnit ), GetUnitY( bj_lastCreatedUnit  ) )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_OrbVolcano takes nothing returns nothing\r\n    set gg_trg_OrbVolcano = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_OrbVolcano, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_OrbVolcano, Condition( function Trig_OrbVolcano_Conditions ) )\r\n    call TriggerAddAction( gg_trg_OrbVolcano, function Trig_OrbVolcano_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}