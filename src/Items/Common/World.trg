{
  "Id": 50332552,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_World_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A13F'\r\nendfunction\r\n\r\nfunction Trig_World_Actions takes nothing returns nothing\r\n    local integer cyclA \r\n    \r\n    if not(udg_logic[80]) then\r\n    \tcall IconFrame( \"World\", \"war3mapImported\\\\BTNINV_Inscription_TarotLords.blp\", \"Tarot Card: World\", \"Upgrade |cff60C445uniques|r of all heroes until the end of the battle.\" )\r\n        \r\n        set cyclA = 1\r\n        loop\r\n            exitwhen cyclA > 4\r\n            if udg_hero[cyclA] != null then \r\n                call skillst( GetPlayerId(GetOwningPlayer(udg_hero[cyclA])) + 1, 1 )\r\n            endif\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n    endif\r\n    set udg_logic[80] = true\r\n    call StartSound(gg_snd_QuestLog)\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Human\\\\Resurrect\\\\ResurrectTarget.mdl\", GetSpellAbilityUnit(), \"origin\") )\r\n    call statst( GetSpellAbilityUnit(), 1, 1, 1, 0, true )\r\n\r\n    call stazisst( GetSpellAbilityUnit(), GetItemOfTypeFromUnitBJ( GetSpellAbilityUnit(), 'I0B7') )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_World takes nothing returns nothing\r\n    set gg_trg_World = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_World, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_World, Condition( function Trig_World_Conditions ) )\r\n    call TriggerAddAction( gg_trg_World, function Trig_World_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}