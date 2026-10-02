{
  "Id": 50332356,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Cheatcast_Actions takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    \r\n    if IsTriggerEnabled(gg_trg_Cheatactive) then\r\n        call DisableTrigger( gg_trg_Cheatactive )\r\n        call BJDebugMsg(\"Cooldown cheat disabled.\")\r\n    else\r\n        call EnableTrigger( gg_trg_Cheatactive )\r\n        call BJDebugMsg(\"Cooldown cheat enabled.\")\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Cheatcast takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_Cheatcast = CreateTrigger(  )\r\n    loop\r\n        exitwhen cyclA > 3\r\n            call TriggerRegisterPlayerChatEvent( gg_trg_Cheatcast, Player(cyclA), \"-cooldown\", true )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddAction( gg_trg_Cheatcast, function Trig_Cheatcast_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}