{
  "Id": 50332793,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_OrbVolcano_Conditions takes nothing returns boolean\r\n    return not( udg_IsDamageSpell ) and luckylogic( AfterAttack.TriggerUnit, 10, 1, 100 ) \r\nendfunction\r\n\r\nfunction Trig_OrbVolcano_Actions takes nothing returns nothing\r\n\tlocal unit caster = AfterAttack.GetDataUnit(\"caster\")\r\n\r\n    set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( caster ), 'u000', GetUnitX( caster )+GetRandomReal(-500, 500), GetUnitY( caster )+GetRandomReal(-500, 500), 270 )\r\n    call UnitAddAbility( bj_lastCreatedUnit, 'A0WB' )\r\n    call UnitApplyTimedLife(bj_lastCreatedUnit, 'BTLF', 21 )\r\n    call IssuePointOrder( bj_lastCreatedUnit, \"volcano\", GetUnitX( bj_lastCreatedUnit ), GetUnitY( bj_lastCreatedUnit  ) )\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_OrbVolcano takes nothing returns nothing\r\n    call RegisterDuplicatableItemTypeCustom( 'I0ER', AfterAttack, function Trig_OrbVolcano_Actions, function Trig_OrbVolcano_Conditions, \"caster\" )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}