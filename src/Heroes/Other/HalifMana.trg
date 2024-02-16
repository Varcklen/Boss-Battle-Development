{
  "Id": 50332944,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_HalifMana_Conditions takes nothing returns boolean\r\n    return GetUnitAbilityLevel( GetSpellAbilityUnit(), 'B062' ) > 0\r\nendfunction\r\n\r\nfunction Trig_HalifMana_Actions takes nothing returns nothing\r\n    call manast( GetSpellAbilityUnit(), null, 12 )\r\n    call DestroyEffect(AddSpecialEffect( \"Abilities\\\\Spells\\\\Undead\\\\ReplenishMana\\\\SpiritTouchTarget.mdl\", GetUnitX(GetSpellAbilityUnit()), GetUnitY(GetSpellAbilityUnit()) ) )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_HalifMana takes nothing returns nothing\r\n    set gg_trg_HalifMana = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_HalifMana, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_HalifMana, Condition( function Trig_HalifMana_Conditions ) )\r\n    call TriggerAddAction( gg_trg_HalifMana, function Trig_HalifMana_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}