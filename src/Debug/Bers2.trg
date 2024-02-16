{
  "Id": 50332375,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Bers2_Actions takes nothing returns nothing\r\n    call berserk( udg_hero[2], -1 )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Bers2 takes nothing returns nothing\r\n    set gg_trg_Bers2 = CreateTrigger(  )\r\n    call TriggerRegisterPlayerChatEvent( gg_trg_Bers2, Player(0), \"3\", true )\r\n    call TriggerAddAction( gg_trg_Bers2, function Trig_Bers2_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}