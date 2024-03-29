{
  "Id": 50332361,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Cheattest_Actions takes nothing returns nothing\r\n    local integer i = GetPlayerId(GetTriggerPlayer()) + 1\r\n    \r\n    set udg_combatlogic[i] = true\r\n    call moneyst( udg_hero[1], 100000 )\r\n    call EnableTrigger( gg_trg_Cheatactive )\r\n    call SetHeroLevel( udg_hero[i], 20, true )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Cheattest takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_Cheattest = CreateTrigger(  )\r\n    loop\r\n        exitwhen cyclA > 3\r\n            call TriggerRegisterPlayerChatEvent( gg_trg_Cheattest, Player(cyclA), \"-test\", true )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddAction( gg_trg_Cheattest, function Trig_Cheattest_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}