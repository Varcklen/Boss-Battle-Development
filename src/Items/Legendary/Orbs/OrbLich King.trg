{
  "Id": 50332804,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_OrbLich_King_Conditions takes nothing returns boolean\r\n    return /*inv(GetSpellAbilityUnit(), 'I0FY') > 0 and*/ luckylogic( GetSpellAbilityUnit(), 25, 1, 100 )\r\nendfunction\r\n\r\nfunction Trig_OrbLich_King_Actions takes nothing returns nothing\r\n    set bj_lastCreatedUnit = resst( GetOwningPlayer( GetSpellAbilityUnit() ), GetUnitX(GetSpellAbilityUnit()) + GetRandomReal(-200, 200), GetUnitY(GetSpellAbilityUnit()) + GetRandomReal(-200, 200), GetUnitFacing( GetSpellAbilityUnit() ) )\r\n    call DestroyEffect(AddSpecialEffectTarget(\"war3mapImported\\\\SoulRitual.mdx\", bj_lastCreatedUnit, \"origin\"))\r\n    call UnitApplyTimedLife( bj_lastCreatedUnit, 'BTLF', 20 )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_OrbLich_King takes nothing returns nothing\r\n    /*set gg_trg_OrbLich_King = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_OrbLich_King, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_OrbLich_King, Condition( function Trig_OrbLich_King_Conditions ) )\r\n    call TriggerAddAction( gg_trg_OrbLich_King, function Trig_OrbLich_King_Actions )*/\r\n    \r\n    call RegisterDuplicatableItemType('I0FY', EVENT_PLAYER_UNIT_SPELL_EFFECT, function Trig_OrbLich_King_Actions, function Trig_OrbLich_King_Conditions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}