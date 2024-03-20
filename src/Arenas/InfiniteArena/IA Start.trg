{
  "Id": 50333691,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_IA_Start_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A08B' \r\nendfunction\r\n\r\nfunction Trig_IA_Start_Actions takes nothing returns nothing\r\n    if ItemRandomizerLib_IsAnyRewardExist() then\r\n    \tcall ExtraArenaGeneral_PingPlayerWithRewards()\r\n        call DisplayTimedTextToForce( bj_FORCE_ALL_PLAYERS, 5, \"Select an artifact-reward before starting an endless arena.\" )\r\n        return\r\n    endif\r\n    \r\n    call Between( \"start_IA\" )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_IA_Start takes nothing returns nothing\r\n    set gg_trg_IA_Start = CreateTrigger(  )\r\n    call TriggerRegisterUnitEvent( gg_trg_IA_Start, udg_UNIT_CUTE_BOB, EVENT_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_IA_Start, Condition( function Trig_IA_Start_Conditions ) )\r\n    call TriggerAddAction( gg_trg_IA_Start, function Trig_IA_Start_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}