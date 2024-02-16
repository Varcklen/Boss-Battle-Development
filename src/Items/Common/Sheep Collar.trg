{
  "Id": 50332522,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Sheep_Collar_Conditions takes nothing returns boolean\r\n    return not( udg_IsDamageSpell ) and inv(udg_DamageEventTarget, 'I04Z') > 0 and IsUnitEnemy(udg_DamageEventSource, GetOwningPlayer(udg_DamageEventTarget)) and luckylogic( udg_DamageEventTarget, 33, 1, 100 )\r\nendfunction\r\n\r\nfunction Trig_Sheep_Collar_Actions takes nothing returns nothing\r\n    set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( udg_DamageEventTarget ), ID_SHEEP, GetUnitX( udg_DamageEventTarget ) + GetRandomReal( -200, 200 ), GetUnitY( udg_DamageEventTarget ) + GetRandomReal( -200, 200 ),  GetRandomReal( 0, 360 ))\r\n    call UnitApplyTimedLife( bj_lastCreatedUnit, 'BTLF', 60 )\r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Orc\\\\FeralSpirit\\\\feralspirittarget.mdl\", GetUnitX( bj_lastCreatedUnit ), GetUnitY( bj_lastCreatedUnit ) ) )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Sheep_Collar takes nothing returns nothing\r\n    set gg_trg_Sheep_Collar = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_Sheep_Collar, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Sheep_Collar, Condition( function Trig_Sheep_Collar_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Sheep_Collar, function Trig_Sheep_Collar_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}