{
  "Id": 50333617,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Aku6_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( udg_DamageEventTarget ) == 'n04O' and GetUnitLifePercent(udg_DamageEventTarget) <= 25\r\nendfunction\r\n\r\nfunction Trig_Aku6_Actions takes nothing returns nothing\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    \r\n    set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( udg_DamageEventTarget ), 'n04P', GetUnitX( udg_DamageEventTarget ) + GetRandomReal( -120, 120 ), GetUnitY( udg_DamageEventTarget ) + GetRandomReal( -120, 120 ), GetRandomReal(0, 360) )\r\n    call DestroyEffect(AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Orc\\\\MirrorImage\\\\MirrorImageCaster.mdl\", bj_lastCreatedUnit, \"origin\") )\r\n    call UnitApplyTimedLife( bj_lastCreatedUnit , 'BTLF', 25 )\r\n    call SetUnitState(bj_lastCreatedUnit, UNIT_STATE_LIFE, GetUnitState(udg_DamageEventTarget, UNIT_STATE_LIFE))\r\n    call UnitAddAbility( bj_lastCreatedUnit, 'A03O' )\r\n    call IssueImmediateOrder( bj_lastCreatedUnit, \"whirlwind\" )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Aku6 takes nothing returns nothing\r\n    set gg_trg_Aku6 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Aku6 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Aku6, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Aku6, Condition( function Trig_Aku6_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Aku6, function Trig_Aku6_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}