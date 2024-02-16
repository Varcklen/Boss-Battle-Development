{
  "Id": 50332670,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Star_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A142' and not( udg_fightmod[3] ) and combat( GetSpellAbilityUnit(), true, 'A0EU' )\r\nendfunction\r\n\r\nfunction Trig_Star_Actions takes nothing returns nothing\r\n    call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Human\\\\HolyBolt\\\\HolyBoltSpecialArt.mdl\", GetSpellTargetUnit(), \"origin\" ) )\r\n    call healst( GetSpellAbilityUnit(), GetSpellTargetUnit(), GetUnitState( GetSpellTargetUnit(), UNIT_STATE_MAX_LIFE) )\r\n    call manast( GetSpellAbilityUnit(), GetSpellTargetUnit(), GetUnitState( GetSpellTargetUnit(), UNIT_STATE_MAX_MANA) )\r\n    call stazisst( GetSpellAbilityUnit(), GetItemOfTypeFromUnitBJ( GetSpellAbilityUnit(), 'I04G') )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Star takes nothing returns nothing\r\n    set gg_trg_Star = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Star, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Star, Condition( function Trig_Star_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Star, function Trig_Star_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}