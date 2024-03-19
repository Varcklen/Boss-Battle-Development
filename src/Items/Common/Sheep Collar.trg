{
  "Id": 50332522,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Sheep_Collar_Conditions takes nothing returns boolean\r\n    return not( udg_IsDamageSpell ) and IsUnitEnemy(AfterAttack.TriggerUnit, GetOwningPlayer(AfterAttack.TargetUnit)) and luckylogic( AfterAttack.TargetUnit, 33, 1, 100 )\r\nendfunction\r\n\r\nfunction Trig_Sheep_Collar_Actions takes nothing returns nothing\r\n\tlocal unit target = AfterAttack.GetDataUnit(\"target\")\r\n    set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( target ), ID_SHEEP, GetUnitX( target ) + GetRandomReal( -200, 200 ), GetUnitY( target ) + GetRandomReal( -200, 200 ),  GetRandomReal( 0, 360 ))\r\n    call UnitApplyTimedLife( bj_lastCreatedUnit, 'BTLF', 60 )\r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Orc\\\\FeralSpirit\\\\feralspirittarget.mdl\", GetUnitX( bj_lastCreatedUnit ), GetUnitY( bj_lastCreatedUnit ) ) )\r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Sheep_Collar takes nothing returns nothing\r\n    call RegisterDuplicatableItemTypeCustom( 'I04Z', AfterAttack, function Trig_Sheep_Collar_Actions, function Trig_Sheep_Collar_Conditions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}