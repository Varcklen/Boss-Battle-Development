{
  "Id": 50332704,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Yoric_Skull_Death_Conditions takes nothing returns boolean\r\n    return IsUnitInGroup(GetDyingUnit(), udg_YoricSkull) and not( IsUnitType( GetDyingUnit(), UNIT_TYPE_HERO) )\r\nendfunction\r\n\r\nfunction Trig_Yoric_Skull_Death_Actions takes nothing returns nothing\r\n    call GroupRemoveUnit( udg_YoricSkull, GetDyingUnit() )\r\n    call UnitRemoveAbility( GetDyingUnit(), 'A0YJ')\r\n    call UnitRemoveAbility( GetDyingUnit(), 'B041')\r\n    set bj_lastCreatedUnit = CreateUnitCopy( GetDyingUnit(), GetUnitX( GetDyingUnit() ), GetUnitY( GetDyingUnit() ), GetUnitFacing(GetDyingUnit()) )\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Undead\\\\AnimateDead\\\\AnimateDeadTarget.mdl\", bj_lastCreatedUnit, \"origin\" ) )\r\n    call UnitApplyTimedLife( bj_lastCreatedUnit, 'BTLF', 20 )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Yoric_Skull_Death takes nothing returns nothing\r\n    set gg_trg_Yoric_Skull_Death = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Yoric_Skull_Death, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_Yoric_Skull_Death, Condition( function Trig_Yoric_Skull_Death_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Yoric_Skull_Death, function Trig_Yoric_Skull_Death_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}