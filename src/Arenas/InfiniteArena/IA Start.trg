{
  "Id": 50333691,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_IA_Start_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A08B' \r\nendfunction\r\n\r\nfunction Trig_IA_Start_Actions takes nothing returns nothing\r\n    local integer cyclA\r\n    local boolean l = false\r\n\r\n    if ItemRandomizerLib_IsAnyRewardExist() == false then\r\n        call Between( \"start_IA\" )\r\n    else\r\n        set cyclA = 0\r\n        loop\r\n            exitwhen cyclA > 3\r\n            if ItemRandomizerLib_Reward[( cyclA * 3 ) + 1] != null and GetPlayerSlotState(Player(cyclA)) == PLAYER_SLOT_STATE_PLAYING then\r\n                set l = true\r\n                call PingMinimapLocForForceEx( bj_FORCE_ALL_PLAYERS, udg_itemcentr[2 + ( cyclA * 3 )], 5., bj_MINIMAPPINGSTYLE_ATTACK, 50.00, 100.00, 50.00 )\r\n            endif\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n        if l then\r\n            call DisplayTimedTextToForce( bj_FORCE_ALL_PLAYERS, 5, \"Select an artifact-reward before starting an endless arena.\" )\r\n        endif\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_IA_Start takes nothing returns nothing\r\n    set gg_trg_IA_Start = CreateTrigger(  )\r\n    call TriggerRegisterUnitEvent( gg_trg_IA_Start, udg_UNIT_CUTE_BOB, EVENT_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_IA_Start, Condition( function Trig_IA_Start_Conditions ) )\r\n    call TriggerAddAction( gg_trg_IA_Start, function Trig_IA_Start_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}