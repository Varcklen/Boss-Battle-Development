{
  "Id": 50332348,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Cheat_Conditions takes nothing returns boolean\r\n   return GetPlayerName(GetTriggerPlayer()) == \"Varcklen\"\r\nendfunction\r\n\r\nfunction Trig_Cheat_Actions takes nothing returns nothing\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call BJDebugMsg( \"Cheats enabled by player: \" + GetPlayerName(GetTriggerPlayer()) + \".\" )\r\n\tcall CheatSystem_Enable(GetTriggerPlayer(), true)\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Cheat takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_Cheat = CreateTrigger()\r\n    loop\r\n        exitwhen cyclA > 3\r\n         call TriggerRegisterPlayerChatEvent( gg_trg_Cheat, Player(cyclA), \"-cheat\", true )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddCondition( gg_trg_Cheat, Condition( function Trig_Cheat_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Cheat, function Trig_Cheat_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}