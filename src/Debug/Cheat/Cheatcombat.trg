{
  "Id": 50332359,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Cheatcombat_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    if GetTriggerPlayer() == CheatSystem_GetCheater() then\r\n        if udg_combatlogic[1] then\r\n            set udg_combatlogic[1] = false\r\n            call DisplayTimedTextToForce( bj_FORCE_ALL_PLAYERS, 5.00, \"Бой выключен.\" )\r\n            loop\r\n                exitwhen cyclA > 4\r\n                set udg_combatlogic[cyclA] = false\r\n                set cyclA = cyclA + 1\r\n            endloop\r\n        else\r\n            call DisplayTimedTextToForce( bj_FORCE_ALL_PLAYERS, 5.00, \"Бой включен.\" )\r\n            set udg_combatlogic[1] = true\r\n            loop\r\n                exitwhen cyclA > 4\r\n                set udg_combatlogic[cyclA] = true\r\n                set cyclA = cyclA + 1\r\n            endloop\r\n        endif\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Cheatcombat takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_Cheatcombat = CreateTrigger(  )\r\n    loop\r\n        exitwhen cyclA > 3\r\n        call TriggerRegisterPlayerChatEvent( gg_trg_Cheatcombat, Player(cyclA), \"-combat\", true )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddAction( gg_trg_Cheatcombat, function Trig_Cheatcombat_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}