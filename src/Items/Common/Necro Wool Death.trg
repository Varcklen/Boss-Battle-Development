{
  "Id": 50332482,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Necro_Wool_Death_Conditions takes nothing returns boolean\r\n    return IsUnitInGroup(GetDyingUnit(), udg_NecroWool)\r\nendfunction\r\n\r\nfunction Trig_Necro_Wool_Death_Actions takes nothing returns nothing\r\n    call GroupRemoveUnit( udg_NecroWool, GetDyingUnit() )\r\n    call UnitRemoveAbility( GetDyingUnit(), 'A0YO')\r\n    call UnitRemoveAbility( GetDyingUnit(), 'B042')\r\n    set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( GetDyingUnit() ), ID_SHEEP, GetUnitX( GetDyingUnit() ) + GetRandomReal( -200, 200 ), GetUnitY( GetDyingUnit() ) + GetRandomReal( -200, 200 ), GetRandomReal( 0, 360 ) )\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphDoneGround.mdl\", bj_lastCreatedUnit, \"origin\" ) )\r\n    call UnitApplyTimedLife( bj_lastCreatedUnit, 'BTLF', 30 )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Necro_Wool_Death takes nothing returns nothing\r\n    set gg_trg_Necro_Wool_Death = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Necro_Wool_Death, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_Necro_Wool_Death, Condition( function Trig_Necro_Wool_Death_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Necro_Wool_Death, function Trig_Necro_Wool_Death_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}