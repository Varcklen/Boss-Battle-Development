{
  "Id": 50332688,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Tarot_Dopelganger_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A060'\r\nendfunction\r\n\r\nfunction Trig_Tarot_Dopelganger_Actions takes nothing returns nothing\r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Items\\\\AIsm\\\\AIsmTarget.mdl\", GetUnitX( GetSpellAbilityUnit() ), GetUnitY( GetSpellAbilityUnit() ) ) )\r\n    call SetHeroAgi( GetSpellAbilityUnit(), GetHeroAgi( GetSpellTargetUnit(), false), true)\r\n    call stazisst( GetSpellAbilityUnit(), GetItemOfTypeFromUnitBJ( GetSpellAbilityUnit(), 'I0FE') )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Tarot_Dopelganger takes nothing returns nothing\r\n    set gg_trg_Tarot_Dopelganger = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Tarot_Dopelganger, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Tarot_Dopelganger, Condition( function Trig_Tarot_Dopelganger_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Tarot_Dopelganger, function Trig_Tarot_Dopelganger_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}