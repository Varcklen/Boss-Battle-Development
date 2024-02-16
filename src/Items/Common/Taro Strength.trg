{
  "Id": 50332545,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Taro_Strength_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0OA'\r\nendfunction\r\n\r\nfunction Trig_Taro_Strength_Actions takes nothing returns nothing\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Demon\\\\DarkPortal\\\\DarkPortalTarget.mdl\", GetSpellAbilityUnit(), \"origin\" ) )\r\n    call UnitAddAbility( GetSpellAbilityUnit(), 'A0O9')\r\n    call stazisst( GetSpellAbilityUnit(), GetItemOfTypeFromUnitBJ( GetSpellAbilityUnit(), 'I07R') )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Taro_Strength takes nothing returns nothing\r\n    set gg_trg_Taro_Strength = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Taro_Strength, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Taro_Strength, Condition( function Trig_Taro_Strength_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Taro_Strength, function Trig_Taro_Strength_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}