{
  "Id": 50332610,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Hermit_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A11P'\r\nendfunction\r\n\r\nfunction Trig_Hermit_Actions takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    \r\n    call IconFrame( \"Hermit\", \"war3mapImported\\\\BTNINV_Misc_Ticket_Tarot_Storms.blp\", \"Tarot Card: Hermit\", \"All heroes, when activating abilities and items, also use a random ability until the end of the battle.\" )\r\n    set udg_logic[34] = true\r\n    \r\n    call StartSound(gg_snd_QuestLog)\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Human\\\\Resurrect\\\\ResurrectTarget.mdl\", GetSpellAbilityUnit(), \"origin\") )\r\n    call statst( GetSpellAbilityUnit(), 1, 1, 1, 0, true )\r\n    call stazisst( GetSpellAbilityUnit(), GetItemOfTypeFromUnitBJ( GetSpellAbilityUnit(), 'I0AS') )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Hermit takes nothing returns nothing\r\n    set gg_trg_Hermit = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Hermit, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Hermit, Condition( function Trig_Hermit_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Hermit, function Trig_Hermit_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}