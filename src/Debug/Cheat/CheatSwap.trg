{
  "Id": 50332362,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_CheatSwap_Actions takes nothing returns nothing\r\n\tset SoulSwap_Debug = true\r\n    call heroswap()\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_CheatSwap takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_CheatSwap = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_CheatSwap )\r\n    loop\r\n        exitwhen cyclA > 3\r\n            call TriggerRegisterPlayerChatEvent( gg_trg_CheatSwap, Player(cyclA), \"-swap\", true )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddAction( gg_trg_CheatSwap, function Trig_CheatSwap_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}