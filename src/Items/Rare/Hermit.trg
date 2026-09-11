{
  "Id": 50332610,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope Hermit initializer init\r\n\r\n\tprivate function condition takes nothing returns boolean\r\n\t    return GetSpellAbilityId() == 'A11P'\r\n\tendfunction\r\n\t\r\n\tprivate function action takes nothing returns nothing\r\n\t    local integer cyclA = 0\r\n\t    \r\n\t    call IconFrame( \"Hermit\", \"war3mapImported\\\\BTNINV_Misc_Ticket_Tarot_Storms.blp\", \"Tarot Card: Hermit\", \"All heroes, when activating abilities and items, also use a random ability until the end of the battle.\" )\r\n\t    //Also Chaos Lord E\r\n\t    set udg_logic[34] = true\r\n\t    \r\n\t    call StartSound(gg_snd_QuestLog)\r\n\t    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Human\\\\Resurrect\\\\ResurrectTarget.mdl\", GetSpellAbilityUnit(), \"origin\") )\r\n\t    call statst( GetSpellAbilityUnit(), 1, 1, 1, 0, true )\r\n\t    call stazisst( GetSpellAbilityUnit(), GetItemOfTypeFromUnitBJ( GetSpellAbilityUnit(), 'I0AS') )\r\n\tendfunction\r\n\t\r\n\t//===========================================================================\r\n\tprivate function OnFightEnd_Condition takes nothing returns boolean\r\n\t\treturn udg_logic[34] and not(udg_fightmod[3])\r\n\tendfunction\r\n\t\r\n\tprivate function OnFightEnd takes nothing returns nothing\r\n\t\tset udg_logic[34] = false\r\n        call IconFrameDel( \"Hermit\" )\r\n\tendfunction\r\n\t\r\n\t//===========================================================================\r\n\tprivate function init takes nothing returns nothing\r\n\t\tcall CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )\r\n\t\tcall BattleEndGlobal.AddListener(function OnFightEnd, function OnFightEnd_Condition)\r\n\tendfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}