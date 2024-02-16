{
  "Id": 50332546,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Tarot_Plague_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A13H'\r\nendfunction\r\n\r\nfunction Trig_Tarot_Plague_Actions takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    local integer cyclAEnd\r\n    local integer i = GetPlayerId(GetOwningPlayer(GetSpellAbilityUnit())) + 1\r\n    \r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Undead\\\\AnimateDead\\\\AnimateDeadTarget.mdl\", GetSpellAbilityUnit(), \"origin\") )\r\n    call UnitAddAbility( GetSpellAbilityUnit(), 'A13V')\r\n\r\n    call NewUniques( GetSpellAbilityUnit(), 0 )\r\n    //call UnitRemoveAbility( GetSpellAbilityUnit(), udg_Ability_Uniq[i] )\r\n    //set udg_Ability_Uniq[i] = 0\r\n    \r\n    call stazisst( GetSpellAbilityUnit(), GetItemOfTypeFromUnitBJ( GetSpellAbilityUnit(), 'I0B8') )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Tarot_Plague takes nothing returns nothing\r\n    set gg_trg_Tarot_Plague = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Tarot_Plague, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Tarot_Plague, Condition( function Trig_Tarot_Plague_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Tarot_Plague, function Trig_Tarot_Plague_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}